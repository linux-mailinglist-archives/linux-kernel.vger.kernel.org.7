Return-Path: <linux-kernel+bounces-864614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13201BFB2E0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD15C4EEEA9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16F128A1F1;
	Wed, 22 Oct 2025 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdaLuwN2"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771842877E6
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125773; cv=none; b=ppOejQGfJBUg0s392x/fkdx9leQEvNccycygTM825/4GR/jJ6RAZ8iJLhCdrO0JmuKThotei/TOe0QGP/td4gC+dSKMbmLA19rtapcly26igni7d0AwyuLpgtu0J3BMzYbEERLMU1H0SxjYE5u2XN6BoZ16jS55XTXWG4eOCJnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125773; c=relaxed/simple;
	bh=C88xFCOXStXuP1GEmHHJ52O6btKAi7VYGysPrZNMuyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jk2h5I0O+BYJwwv9QitGSlrkBvBM3NtG/L+0Z2M3eGCw7GuOvQCU8tG1/HcrkVrGSC3mxiv0ZfwiWxsH371z6hkPkRGW23/Zz/AMj2+HcQA4rY69K42EIP/1aowHAsHsucC1b+eyw6ZFgaVgD4nKATlMq5Svi7Gi3My9M/1ZDK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdaLuwN2; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso1423838a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761125770; x=1761730570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C88xFCOXStXuP1GEmHHJ52O6btKAi7VYGysPrZNMuyg=;
        b=GdaLuwN2Ln7J4l/a0cfVhLr+vpRDxbQx8/6ccG2VSbNniqvgKt2bTcgj6oQuKjAzuD
         69aMJGcjlcZUgldDBuZQppyYjtQIhUwV3Bdby/CrgrbI8To3xt8WvxJ3NvoOOskMur3T
         1J8V1t+97plfvW4emgAawP3m1Vp500UAoAQJo4AwKZALo6i0gxPBhvLzxu3Jo5aTIUA6
         znwIVAuzS7GuwU6ZMiON5K72FQC9I+s/suyb05daG7gU51PT6aDYkrS9cUcgT7pISFua
         qLsjh6sUkq/PbLnr/FeTfVKvRy5LUOXJ2XHbM76YKeGB+/9QI0VhfmoNu0AVo6f5eM2R
         ruQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761125770; x=1761730570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C88xFCOXStXuP1GEmHHJ52O6btKAi7VYGysPrZNMuyg=;
        b=Tv0fpoXTOBzIr4MnX2+qb3298KltgJ1Q5ZS/eg5Yuwi0JYKWMYof/jOB28oQEw1Y9h
         FEolhEdd+aGUyDovZmgqGVHn5LiHt4Lkf4LnZ/UESUZr/ortsjlXc5Gta7ihCH5MVbsD
         Fw+4SxQB1JYmt4VJp4cPJk5Tbv60/vv7ZpRaJbYIr4lUnolPoPKLTn5PcgU6bFPXod/+
         1qZVTZR7c5HmBJ7sRD9Gbi2Fg5RuyXUycd0zbhTl8tLUk4XzfoH+ThH3OTRJbXPi3NZf
         lTfeh43z6FAsvtD5I2PHjXAkWCMgT+++9HVV0gwwZXiVh50UkntpvKNlOq6T8FunaHgt
         p2SA==
X-Forwarded-Encrypted: i=1; AJvYcCXerRDtJAJap00c8k0h7uN0Hs9vSt5W4lrfSHt7FcPdMlyeBtRYMrQ9AECTiBiZz2Xf9vrqRAZvqLJpKEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTKUyFlfY54xldvY02BcUNaNvL25c6uEDb9qUpGf3J6zrJMldz
	BJ+nhTOZcfFy6ySlzPPo1XCpLfmdqiFzUUIZpWpkMcD9FlwWm+QGvKO/2cdBjd3YUBDxjcyJ1Nn
	if72f0T8aqgjtKmq9yyLOYRGufx5mScg=
X-Gm-Gg: ASbGncsEgCirISGHjR2QkZZgTAc6rjMNj1sGMAVj2wleJbEncBBnx0rNFlklwBV5UI5
	pIvAVEJi/TMTzbAGoVhwmgzrj3IeNf2qkO8CT5aAiBcgXhwaaAN5jyRSPiQphuN6JExMDt+I0oC
	3R+Yua6t9fd/udvlHKHuFO8bdY3dLLiNAW8lNmUXz3JQgQ+BRsIrquG7mShpOkH/zYBkc6nNEv8
	EgOYXkVEdShkG6vgNO0c9YBF9WPRS9asiHhF22AcPGHHqTPbeKQEk/8BFgznA==
X-Google-Smtp-Source: AGHT+IGto3EQlisuvoE7Sasg5zwzwjSEmlEE8ttsGQiw66ca1d04S75zETC5/PIhjoAM5dxY+M9aaYxATM6s/kFKsOM=
X-Received: by 2002:a05:6402:1454:b0:636:2699:3812 with SMTP id
 4fb4d7f45d1cf-63e169999c3mr2842093a12.0.1761125769618; Wed, 22 Oct 2025
 02:36:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021165212.749372-1-a.shimko.dev@gmail.com> <20251022-rugged-archetypal-wallaby-ecbecf@sudeepholla>
In-Reply-To: <20251022-rugged-archetypal-wallaby-ecbecf@sudeepholla>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Wed, 22 Oct 2025 12:35:58 +0300
X-Gm-Features: AS18NWD2CL-Yrxb3Tz9eDASZQ73ONHWrSw9NcQfoZQ6WrOD4sVc61IZW3QMRIxU
Message-ID: <CAOPX744QeM=5qsF0_ZrkvvuumH-EsmJPDMSSs=D04zP=tie3qQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: Add new sensor unit types
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 12:22=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com=
> wrote:

> It is still alpha, we don't add anything into the kernel unless it is
> of beta quality. Do you have a use or you are just adding to match the
> spec ?
Hi Sudeep,

I'm adding it to meet the specifications.

Trying to be useful

Thank you.

Best regards,
Artem

