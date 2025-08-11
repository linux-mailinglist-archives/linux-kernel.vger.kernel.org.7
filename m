Return-Path: <linux-kernel+bounces-763653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B203B21842
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 00:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270BD627D39
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8713F2E613E;
	Mon, 11 Aug 2025 22:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Rmht/i3c"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0292E612F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950708; cv=none; b=D3wAWgHtJRFnp4L8qZ56URZRB8g2zj4JmBfdiVkDVTF9uYCh+Qk/AixgzNS5O0sZO3gcmMT8/0WPtL2mUxO8TsjAktE8g1n/ODehmIZ2E2UsPYisEyRSE+puqM4UDdikgazblMfhNEyAiUOExQOxsQ7I24Q2dAuwXyvDSP1gLX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950708; c=relaxed/simple;
	bh=hLxhxHaWdMlj76eWqAK6hbgx4pifWeyYfjkuCjOx0Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ggb0DPKQnXMUXmqeJ7OKIQEjY9/YabF2vwt6aG6xVz2O+iikWMbbVzq2j8jraNCF5IreqKpNu6rfDcksGVU5MAC8EkxNuAQw3wXgZavueUxQH7hmfgV37IJltgn9z8fxcvqoVKap0mXVoNfnnUnJvr6yugRiF1RDM3E3MmVG/rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Rmht/i3c; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b42254ea4d5so3182220a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754950706; x=1755555506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QPfkB/pIQ/k6u1jMgX4e6F8gib56VfPj24awC4Cu4Y=;
        b=Rmht/i3canU6ZP7p9kIhAkbC6lhUAOH47msih3fhZtQT6je6MmHtfSl61VE5wWjm2N
         qJo0qkuvtRc51s3cnyvnNcaLk3XQvWUvObDhjH8A21VEcp6TCF1/BllImHwOko7iEJfQ
         9bkhQCduUf4IgsxVDvPOkdoFzkX+1OGi74Ip2LLtIg9sFy+GywRnCdYe6yXZv9LN6x2z
         TRZ65bA6aRpfIppxeuYe0nraaHO8Sju+BRPyTe+5KZc7oMD2eTe7QwBUw/UvQq1VRVQX
         8eFvVONqQg4RG4lJcZy2x1cMjv40EWTWFqo7kO1kW3wFld40dHwJ1nd22dhp0GJbyw/g
         BZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950706; x=1755555506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QPfkB/pIQ/k6u1jMgX4e6F8gib56VfPj24awC4Cu4Y=;
        b=uuI3+rHuenSMBlk7NDiijYuD7HZMGnMibHlyc/p3pFwewyxhZe1PPI185qSFk063YB
         q5kAtZH9V2eUdAS1IY2vtGHFrkzDy8qxibcYYbYEDe5UvQYGlfeDKgn5xV+9S0PAzrIy
         xaOkkABKy9MpSfZVt2aEkP8BHlHsXFKjk1HSqG21R9V0nrCJp34qVgjM/6Vg3LlBUso1
         aTz0R6JObwZvgXzCYDN4WLs3q8zwhQwWq9LZiwS0tP8i4rxClqNlJ3pTW3iwPA8zS27t
         Y6shR+eYVtssKxvykCrSEkO/2HNiXdCUKRfnwnwhV+zIoiOyLVbRDaS495nhCKpSg+5E
         XgAw==
X-Forwarded-Encrypted: i=1; AJvYcCWucY/lJx+epvl/ZoOyoVFrZCU0yZg/kgSYDCWIYKEcAoWcv8opJ5dUMga1UZufMVi57W4g2MiO582QSe8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3DOcWPLvMxp9Uie43fXevtb7wAjDR4upENc2rEH5ElttAzesQ
	avNkJOSYHAVjm0bE0742sOrm9WlBT2d556QvokEZsZgANGCDcXYF4vHgSbso8Lug9YuA3dkYBXa
	10kaK3PaTZLOv8kKkWk/lLVm1ECmIWuIevtjroyiOL1n/UaM1JAs=
X-Gm-Gg: ASbGncu9CJG9zizfD/0u873kkO63e2e6vkZNGx7UWksxgh4sC/aYk/nYFMXUqDvYKEb
	5fjU5m4IPy7xMnnm+W5yFDjhVC2Ry+IQPVKq+gOCeDtYK1fTIlByaSiKP6uQiclHz4q1tTJYSCU
	ibiYGubYE6/2uAGdIzIPmRHl8Sqvl9yZ1OVyUEaIFDxS1048CIvvBTNuNsH3xaJqZ7rUONm0kIS
	0TSKeM=
X-Google-Smtp-Source: AGHT+IEos3ybrBp1VeGH5FoNhU0qT67CaE0I68fM7gf/kq+FJ3ArgKD8o+ziY0Jw8Kyj/EY6HpH1lz9vms9IV3m1UW0=
X-Received: by 2002:a17:90b:4f47:b0:31e:f351:bfec with SMTP id
 98e67ed59e1d1-321838a61fdmr23110027a91.0.1754950705580; Mon, 11 Aug 2025
 15:18:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723122304.911130-1-yuehaibing@huawei.com> <55eacb468bb0868fe2552944d46239b7@paul-moore.com>
In-Reply-To: <55eacb468bb0868fe2552944d46239b7@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 Aug 2025 18:18:13 -0400
X-Gm-Features: Ac12FXw_vY8moP4LN-S0tf8nwPO27G2vxwDbZyYItDQggN-Rk4kruJDtqilzpqg
Message-ID: <CAHC9VhTgX4beGWOL5eewnk2jQyW64L3iA5g558_WVoPsu-29NQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: Remove unused function selinux_policycap_netif_wildcard()
To: Yue Haibing <yuehaibing@huawei.com>, stephen.smalley.work@gmail.com, 
	omosnace@redhat.com
Cc: selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 5:22=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Jul 23, 2025 Yue Haibing <yuehaibing@huawei.com> wrote:
> >
> > This is unused since commit a3d3043ef24a ("selinux: get netif_wildcard
> > policycap from policy instead of cache").
> >
> > Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  security/selinux/include/security.h | 6 ------
> >  1 file changed, 6 deletions(-)
>
> Merged into selinux/dev-staging with plans to move it to selinux/dev
> once the merge window closes.

Now merged into selinux/dev, thanks!

--=20
paul-moore.com

