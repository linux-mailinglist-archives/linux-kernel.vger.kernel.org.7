Return-Path: <linux-kernel+bounces-728281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE78BB025D4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 22:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2232316EFAA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35DC1FF61E;
	Fri, 11 Jul 2025 20:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cz+K4ptW"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1F41B0420
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752266126; cv=none; b=BkM0QfroUkLPtgUhmFBO/AJLVJv/JNy9gmcedQVwNiNoKMyy0gotmYeSRRytov4NWujT6E5YB2L0f06/CVAHiSKkADiBPva0dG+bDu6HbubU94IDjtJ8Q7vTLdpFBbC0BzPcT52EcGpgJyDwVkephzX1QhsfAzgoZD+6c4TYy+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752266126; c=relaxed/simple;
	bh=b1VDAFqxBEw3uXSyuwPQh26CLi4QbJOh8mtJ/aaAzlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7X50PhcLZtiq0yxYD1Kk2J51rGZxKZgiC04t5bfl47tnqQ4K303YgXubFg4MciFr+7864MGH9/RyAtTXQv/3hsR15sjV7zEaivqUtLXygYOnM+O2MPO9K8zoNchNOhPLXxvUBTaCxEa3CGuOWoirv4WV6aFqS5so5ojF+VDbTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cz+K4ptW; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60dffae17f3so3690340a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752266122; x=1752870922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3WSd1C2YEpBcSCAUHObR5B794dxVqLICPHfsBmrzbCQ=;
        b=cz+K4ptW7cbxEQIlLUQUsoEyRR1uagl+ENxKM9xCurN7IR7hmd42w/GoMzuCjUuAeV
         eRBSiydjiexIWIDahmxFfNLPROyN5BbNNgQvBnDa0BdXGUdBDaZUaYSMBmXjA9Td3zCF
         0V29Cd911kIcTDMHPYuB0+Nx1twZS8iIaw21c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752266122; x=1752870922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3WSd1C2YEpBcSCAUHObR5B794dxVqLICPHfsBmrzbCQ=;
        b=Jd4xlSU2zzmBUSHSxbmZpOvyN1im10emz3C+fz3PUl04WoZJGcou8TpvIgDeLXiKEa
         Iuu4s5yw294RVLbWyju6N+qSU1+NPxkEewQT4QdPBgyQDiLTi32BmPCnKi1hSxm2lO+q
         gSximHDamrbPNgCvZPutRUrugNpU8R1EmETbsKoqGD7Ub+r+g9nES/LjNN1PBdGSXheI
         vb2fm4IHXVR3lzcxbkErCIMpS2JIs3cH8XjfbVz2RUoheDHSGPeQz+aSfF3VfqogTt55
         dbG8lQHVSZ8fL1TftQPbwXN/Zd4I+mxX8CKbVfYEfxxyCDyVW9Ohn/pF53tnl2glledJ
         jP/w==
X-Forwarded-Encrypted: i=1; AJvYcCWl/TObx5Ztt0qPEEZmDtnOMEa3ZQ4J7pFh+bWAiye4jZrzW5ooSzyzvsQspXtePSplMyHCHu3OG8FO0gs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2qpeDYPRVwoqIGSUPSKZlqrTbbDIcvMvGFNhKfqEHN35hoppo
	2xxzRV5J0VKC0tXDG94gmc1Lrg/qp/XENBhiWTxFhpYUK+YC2ulVU+SsPYqfpTEpi1jt0RTGwnF
	0TieE6668Yw==
X-Gm-Gg: ASbGnctQQTBkmDJOOs7FlTmedVcOuyUTUtOKIfSLglsTujU9QFPRShmueee2A/H3Dx4
	cjCE+hOIDGKXqpa5hS++dJ98nxj/VHjdrPflknTLsTLtFSagWUqZx1uRwOR02TqN6A2+qYhOgw3
	F1+0LkguHo5xnH8vngmlYY+6dGvJAbiv/dX3VnGuEQVGxkcgX/jeDiHl8WOKnF3cOFCEVbbtDqr
	mvzKPWroYMD0qq+8nM/KAKRerbnptFLoZonFThgEk/A0MG/CikdYMrg8Er6xi+LQ1PVZJskVvp5
	QzBFBccqgmEnqzuty04v+RPPRq4hKAzSOed3abOEVfcK0QZJR5YIUj6KR1eV1NQkuPYW7dvIV/d
	oDw6rDwEgZy467ASJni4+0t0jQBYsei9cazwwQvxT7uI5lZCQ4Mi3ojFswn3sgcJ5RsEkBfS8
X-Google-Smtp-Source: AGHT+IHAqSUi7zxaTsv2Y2S47r5V8DgWRuSjsk6//9ER1lwPZltdVBr8VdNfIKqr82KkRpEQrFnTsw==
X-Received: by 2002:a05:6402:5291:b0:604:bbd2:7c88 with SMTP id 4fb4d7f45d1cf-611e84cd12fmr4199915a12.26.1752266122419;
        Fri, 11 Jul 2025 13:35:22 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c95282ccsm2661652a12.28.2025.07.11.13.35.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 13:35:21 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0c4945c76so399930266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:35:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWnWniaktMYioc3L/pgz03iTlODOX/5fdCa7xjw95INC6q98QmyuMQzRAbA/OreauQwTqVdW08kVwaOIcI=@vger.kernel.org
X-Received: by 2002:a17:906:9fd1:b0:ae6:e1ba:30a with SMTP id
 a640c23a62f3a-ae6fc3d7e07mr437795566b.54.1752266120408; Fri, 11 Jul 2025
 13:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711151002.3228710-1-kuba@kernel.org> <CAHk-=wj1Y3LfREoHvT4baucVJ5jvy0cMydcPVQNXhprdhuE2AA@mail.gmail.com>
 <20250711114642.2664f28a@kernel.org> <CAHk-=wjb_8B85uKhr1xuQSei_85u=UzejphRGk2QFiByP+8Brw@mail.gmail.com>
 <CAHk-=wiwVkGyDngsNR1Hv5ZUqvmc-x0NUD9aRTOcK3=8fTUO=Q@mail.gmail.com>
 <CAHk-=whMyX44=Ga_nK-XUffhFH47cgVd2M_Buhi_b+Lz1jV5oQ@mail.gmail.com>
 <CAHk-=whxjOfjufO8hS27NGnRhfkZfXWTXp1ki=xZz3VPWikMgQ@mail.gmail.com>
 <20250711125349.0ccc4ac0@kernel.org> <CAHk-=wjp9vnw46tJ_7r-+Q73EWABHsO0EBvBM2ww8ibK9XfSZg@mail.gmail.com>
In-Reply-To: <CAHk-=wjp9vnw46tJ_7r-+Q73EWABHsO0EBvBM2ww8ibK9XfSZg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 13:35:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjv_uCzWGFoYZVg0_A--jOBSPMWCvdpFo0rW2NnZ=QyLQ@mail.gmail.com>
X-Gm-Features: Ac12FXw06ng89sgg6lACD8raxtg8tIsOj2V4Q2Quo5hdT7JGF5RzQP8YU9BhymY
Message-ID: <CAHk-=wjv_uCzWGFoYZVg0_A--jOBSPMWCvdpFo0rW2NnZ=QyLQ@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.16-rc6 (follow up)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Dave Airlie <airlied@gmail.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 13:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Oh well. I think I'll just have to go back to bisecting this thing.
> I've tried to do that several times, and it has failed due to being
> too flaky, but I think I've learnt the signs to look out for better
> too.

Indeed. It turns out that the problem actually started somewhere
between rc4 and rc5, and all my previous bisections never even came
close, because kernels usually work well enough that I never realized
that it went back that far.

                Linus

