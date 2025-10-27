Return-Path: <linux-kernel+bounces-872229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7F9C0FA12
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400F24276EC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202943168E2;
	Mon, 27 Oct 2025 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ahgrwfkm"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8228311C38
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586028; cv=none; b=Fg8G934FCIgUPkYYdxnVcMTCk/iq++YfyB8cj5Fp+coeFx58M90eK2vnUlJpaGsSNb9yfenvzk++QgbLqxrwofDFNEV8eGaCxnoGbuSCVg1u6ISa6LQJLE1XslCx3bDvAetOyYT7zCUfMX7ZOGKMRN7uTYB9pvb/aeG3QXgwHLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586028; c=relaxed/simple;
	bh=E37fOle3ST39P+A7lT+g+uenRFySIHC/mg1b7+VoNvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTvHefR2NL7yQnab8mUkdvkX1x+7gfMgV8v6uFOK4bDSvjxbGnDRtw/5WTO/1Mf63w6Pgzsw/6/QvGY7PWGNBbhEZVpsy2g0IuBnYuA7w13XaLNjHF6CG3Vk1hUxNYL3hYuWMR8hsXxaPYI1EDv7c6IyYOz0STjz+AFZaCbnTls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ahgrwfkm; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3717780ea70so64649191fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761586025; x=1762190825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ddh5hq0qRn8Rk6Qy0F8WX9+cfR1Qbj4buJo4sJPvItA=;
        b=AhgrwfkmSRK3ihwt2MmiEA8h/HpQ11QPnCuMkerpynvXsns0xVrc9VPLMo3NwifKg1
         rWUqk6Gltc5khHW0kYu563HPRK5qLXLYttifm8eOUIgir5Pp/22SNwmP51Sfe/S3DVX1
         eJOyE4S5KjtXP0MjC6mcchZ1Vk8KFi77lse8iWqq89NxXfq7ajikrww1EDybNn5UXuMa
         iOxl3Z3LR//FXupA48VuUNHKtfklk1ku1M18TV12eXuzF6katmEzip1g9VMlIBlhKi1P
         jR8nzD4um3CZJj7T1GftG7jirxX0es6FwXLy0wvmjh/xzIFWmipZ2N5Oj2LOn0xHC3Ky
         UALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761586025; x=1762190825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ddh5hq0qRn8Rk6Qy0F8WX9+cfR1Qbj4buJo4sJPvItA=;
        b=f96he2FNzOuN4hRCboo/ah5Jnx8kgCdOYYhOcKLH8Y+8bOT+zlXR5sN+JNnbGNjMSh
         RipyukxIykWswJxRKIndoXVK05XEJWFIh6DWV6GWoboTeMwvv9kCgYSY1xs2Fu8pJzwU
         8MHU0OBljDIXs8ZkuSbApnSvLbCa7FMHia+lRN0mdAVxh47UXCFF9N4hiImQZHMueJw+
         3ufmPpr7gGyW9H/u+ZqCsWz3fMkE3MWTQiIc2QgtmpHP9/1EG0ozHWowxLZrUxbLetMF
         2eAzstt2W+fGzxhlytNwcfBh1drdQ+iOylOv6lp2JAGOo037WnR1IoomHeRcl2urQFl6
         iczw==
X-Forwarded-Encrypted: i=1; AJvYcCX/dhYYE80HsTyNF2L63ocAYDGIZnxmPYm/p5juDxAVcS2VFr6p1p4DEbOFQOfTLV76v2fKEhvHDVV0z5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwomWu+CKnUTaThvys+MS2UjHf3oCtc+WRRIZ3e0rxisWqwk/mc
	IMCa3LzQqNoXgy+RtM1MbkapF0eCTgWZdSkELnLCg99Bj5bJudDChYJYqZWQCxNekDc2b1MeyWp
	z0MDDlds+VAIRfjIwZPgM0bGPcslEmRY=
X-Gm-Gg: ASbGncu1SEfCd24/+WDIeyY7tmCvrBn3wNUsoEpj7O+ECl4hDgAllnb4FjJEMuW/esx
	i6Tpo98PEe4gxHztqoeJO5h5Phsusfpo51BCl61VqfuhLVaQfmwhaUcQazmzlcs6ZVJsjh5yfhC
	xKiwp+nZf+uaYVx1ucb3xxSDO1SO3zdFvNKBtreWeyelGjhSneI2iYcY/LxZ0M9HqmmziVhOeDT
	YGdxWOzPg/23PMFAqhrNCwlPgmBzZx3m1Lk+hC/Cs2ZI2Cg13DNYBCETQjQ
X-Google-Smtp-Source: AGHT+IFKliPkfdx9RIVLQRN/QzU39GGUoDM7Qll1qTLLc2HT1QruAR8oCisrb3Tu2QDviPTkH+x4Ni8k+J+lFfu1dYw=
X-Received: by 2002:a05:651c:235a:10b0:372:8cce:2360 with SMTP id
 38308e7fff4ca-379076aa91fmr1226431fa.14.1761586024547; Mon, 27 Oct 2025
 10:27:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-t210-actmon-p2-v5-1-a07dc70e948d@gmail.com> <0c86e790-84cc-4d4a-b12d-3876f2846073@kernel.org>
In-Reply-To: <0c86e790-84cc-4d4a-b12d-3876f2846073@kernel.org>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 27 Oct 2025 12:26:52 -0500
X-Gm-Features: AWmQ_bmzZMIhaAd104M2Pk8eB6cxIvfn6TpmDfHsRKML26idHnHGvI_UUGuHKEk
Message-ID: <CALHNRZ9ZG2Vck4GB4an8-p-m39G2+YGffzOg630Ey6A6MHaCuA@mail.gmail.com>
Subject: Re: [PATCH v5] memory: tegra210: Support interconnect framework
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 5:52=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 22/10/2025 05:10, Aaron Kling via B4 Relay wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > This makes mc and emc interconnect providers and allows for dynamic
> > memory clock scaling.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> > Changes in v5:
> > - Split series
> > - Link to v4: https://lore.kernel.org/r/20250923-t210-actmon-v4-0-442d1=
eb6377c@gmail.com
> >
>
>
> Tried to apply... and see you did not run checkpatch.
>
> Please run scripts/checkpatch.pl on the patches and fix reported
> warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
> patches and (probably) fix more warnings. Some warnings can be ignored,
> especially from --strict run, but the code here looks like it needs a
> fix. Feel free to get in touch if the warning is not clear.

I ran b4 prep --check, which runs checkpatch and that passes. And none
of the kernel ci bots have complained. Normal checkpatch also passes.
If I run strict, I get a warning like the following:

#340: FILE: drivers/memory/tegra/tegra210-emc-core.c:2226:
+       if (!err) {
[...]
+       } else if (err !=3D -ENODEV)
[...]

The code flow should be correct here. Is this what you are referring
to or are you getting an error/warning I'm not seeing?

Aaron

