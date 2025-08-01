Return-Path: <linux-kernel+bounces-753800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4AAB18820
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 22:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CD854445B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 20:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A645F28D857;
	Fri,  1 Aug 2025 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JciFuEhH"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BBC21ABC9
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 20:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080165; cv=none; b=Fds6jc4mSjKzIwD24dhJBt3Z7lPf6URYoewzYGrNoaRvWsXUtdzIrYCzXBnLcDyuTWdkGoqU4AvdcSvpWYZXP4mP90VMKlwCOXa9Tf96sigIwcT+Sw4leGFOV3wsUSRCm7l6DzdW0EHVyia6IxtL0FaLQ5IKSG5Nsvqf26Py4TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080165; c=relaxed/simple;
	bh=ft1GtVlHTumH5n9zAoqypec1LBFsX5MTL+yaj3JjcSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHhsU5WUo48E3ocHruCQ5H9W8y6PbJHoXuRJgd8tvp/bqOYeHlhsy6XT+p4bi/CbdXtixtDVbn5RFqR/cECKurpeA5DIAMAHnvabZ11zuxnmnEFJN7zfB3z/e0RJKG32yIj2OimB5+XWZhGb3xEuGdpijL3GNT2730HPHpZDu5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JciFuEhH; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-615d1865b2dso1658289a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 13:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754080160; x=1754684960; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QXkdEcm3dcCFEHiiyHz9se6bX6iRUxFV0EivrOFS6/U=;
        b=JciFuEhHIk3W2yedU2vIuAy9vCPto+TYtCjYIVlQ+DjAzEc7/9+xovb5GwnmteW4NE
         UqvlUCGmTpDRMSo9WkpNueuoC9m/A3MqsSjpN0ziAwZSBVn2Vs/67zkCtB+9X2q4n2K/
         oHvhDGB9yTPYZ4DnjTdqd1Di77T4kFq4IxarY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754080160; x=1754684960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXkdEcm3dcCFEHiiyHz9se6bX6iRUxFV0EivrOFS6/U=;
        b=lMSqAgQ6+mS+f25y9q+CFocXcifJh4NnMB1uaBcRVBRCpOzizc8iGyRh97PayMIPnE
         59tmh4CuqgFzZTs2g28AsZ9RHGcLG5WNHVZhrhs4SnX/kPx9W2h8zOOS9rXOlOdtqT+M
         hJYXJtnFG+q6l76PYeCXtEXqHzKdtNzBSjtRJCS9t7SvgTU7EZNkxeRcyXZ4ZSYB+TFW
         7hcaTXp3BVMFioeCkrPbQL49BEkpo+mkXRvAk9RQ/UrPh7+atOeVM87LHfJskqkFxvmE
         mDLxMEeWWCSrMuprW88mTivsw8c7v5JuVxBdI+9W9VuCgvNtbr8AN4dzKfrNN6si+PDi
         onpw==
X-Forwarded-Encrypted: i=1; AJvYcCULvNhXZfOCE4mtdkGMkcWa8NVh6lHpNY5DVxtxppZehOaSbJrmCntLOy7XWHS6RdWz89glBqVJMnbQt3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzwobt5vO9fb+tVBoT639xDun0uOl+jrm7v45X29hC9TL+c/Y3
	y74nHbl/Ug0o2mtC07yO94DLX6yS1Vgtqv3TWtQxDpXZftmCrNklpsjTRqCs08idnH7ZBhPPEEu
	ZjxZskr8=
X-Gm-Gg: ASbGncujulJzhhXBJfFGKAl+DXRs+L/v6RYc5CsJ488zlJQCYb9t9oTCUyTSUxxFLtw
	1cPp6J5oyHFQN+uh7M7ZwWMin6moyf9Iialdpm9rLBaD9ywYPdVKK6RN8s10V9VYiXhUa6pUraZ
	dMXZZf7vPxbwk1P4rIAQtPsGlYaBSjTrvBLe3SNZZE0Hlo85+quimR934rcTtvvM6eQwtj1W/Ir
	Jcc7RB1bkpaTRBwPFB6D8LHqgHRHf/CfM9yNNusO/u7aa81JRMN/EQGaZzdiT1qdt3dXPFZHtuG
	392bvkXJfOlgWE0taEARh1HlJ59GfMxtvvj3xOJQ6dj1ftWvC9Ky6d1LdYuV7X7uqekN6OOWOY0
	/7v14sl3+hhAgCb5aFeaWaPFep8CMVZD1/KCpfRGVAMC1Vp9smopt8X0TsPdB8pYqSFvqMfWV
X-Google-Smtp-Source: AGHT+IHu79RWH/5QfOJGe+AiBqjI62ZtNKqmYG3AMZUVV6eXxKxuGqmSJ2oXyodQFSDpqZDdKJHbLw==
X-Received: by 2002:a05:6402:1118:b0:615:905a:3d43 with SMTP id 4fb4d7f45d1cf-615e71451c1mr500933a12.16.1754080160022;
        Fri, 01 Aug 2025 13:29:20 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2d554sm3234230a12.27.2025.08.01.13.29.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 13:29:18 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-615d1865b2dso1658250a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 13:29:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOgEKlrDj90hloX6hZsI9poB6cuWVaymYe1JdF9xWPEt5azGPd+KbsibdMF+UzBGCcYP8cVK8mRpIuj9c=@vger.kernel.org
X-Received: by 2002:aa7:cb0d:0:b0:615:8012:a365 with SMTP id
 4fb4d7f45d1cf-615e715f7a6mr469886a12.25.1754080158122; Fri, 01 Aug 2025
 13:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801091318-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250801091318-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Aug 2025 13:29:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whgYijnRXoAxbYLsceWFWC8B8in17WOws5-ojsAkdrqTg@mail.gmail.com>
X-Gm-Features: Ac12FXxywlhxHC92NneGnmmt5Hm9rlPrKO5mJOfIsb2I5ZMf5olIOr9KL1pDLfc
Message-ID: <CAHk-=whgYijnRXoAxbYLsceWFWC8B8in17WOws5-ojsAkdrqTg@mail.gmail.com>
Subject: Re: [GIT PULL v2] virtio, vhost: features, fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alok.a.tiwari@oracle.com, anders.roxell@linaro.org, dtatulea@nvidia.com, 
	eperezma@redhat.com, eric.auger@redhat.com, jasowang@redhat.com, 
	jonah.palmer@oracle.com, kraxel@redhat.com, leiyang@redhat.com, 
	linux@treblig.org, lulu@redhat.com, michael.christie@oracle.com, 
	parav@nvidia.com, si-wei.liu@oracle.com, stable@vger.kernel.org, 
	viresh.kumar@linaro.org, wangyuli@uniontech.com, will@kernel.org, 
	wquan@redhat.com, xiaopei01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Aug 2025 at 06:13, Michael S. Tsirkin <mst@redhat.com> wrote:
>
>         drop commits that I put in there by mistake. Sorry!

Not only does this mean they were all recently rebased, absolutely
*NONE* of this has been in linux-next as fat as I can tell. Not in a
rebased form _or_ in the pre-rebased form.

So no. This is not acceptable, you can try again next time when you do
it properly.

            Linus

