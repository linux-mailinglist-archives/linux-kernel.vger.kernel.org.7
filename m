Return-Path: <linux-kernel+bounces-883177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE33C2CAEF
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E0744F757E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F65E315D58;
	Mon,  3 Nov 2025 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="empV3dnx"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D869A314D14
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182085; cv=none; b=tccSaTmgYCPLyDPvsJkYDz2ChZDbjnT2Uk5WaIqEZhAtDsj2iC15Nw9aTxoYf+aT5FfcD+PzHBNIMJ+B6LULXcu4Y/DjMUIIeHTxPsQyA/AyqpvImOPyKQlLxsh9bwErR59uUNvPUOvLrCvtvL3TTcUFMCOJ1tkvWeE4G77ukek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182085; c=relaxed/simple;
	bh=wFTnq7/AvjAJd1O0uQ5fE6zbW25tzv8iQUb4vGr8AYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0cAjq75VIpd4T8aymgO1+FzhXfs1Rlg+Qum6524sUp7cFcrnxEXKdNVu0nKEFL/J2vyqAa5bWzzdUfyO3NY2lGKP9bYLrzygJBjtWtmze+QMCAol6T44RN/NVqCTKrr0ydBCihdsflQe4cdcw44Tk9ywfR0DsHNMxEYfhbR+aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=empV3dnx; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5942bac322dso1105445e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762182082; x=1762786882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFTnq7/AvjAJd1O0uQ5fE6zbW25tzv8iQUb4vGr8AYI=;
        b=empV3dnxbPA905iYxx5sBP453LqvTJjqoAIAPTYYZZm6SZtFUUsvv1azLvpk8eWPZ8
         tPYed1wi4R3oRqQt3sEV+Gaj/XdPjzfegf58NFQX8Zxqm/z1iQDHq+2az7I8KUJmpJIw
         8pomJCGBqiuIXU9vEGnvexapRDSVeOcAovhgc/W3+kZinbpUEPHwP9MA+oEtL17inEtJ
         xdETi3aaFdZISIeuFyy2u6UI/Uzm8J8xe1myg1MsIJ3DlNVOEdItdcjpuRTCxvgzuEg9
         hGCHdUOJrRKG0X1YXZgbW9uB53gAwcbNpHplYoLY9ywlxUJTvWSLnSb+OhfxCW/Z6BaA
         IEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762182082; x=1762786882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFTnq7/AvjAJd1O0uQ5fE6zbW25tzv8iQUb4vGr8AYI=;
        b=Ihm3QXTa2pcNJQCoHdJSxKeFZsbAWPtKy9Y0Woe6SEDr6h6zLsVbCFag0Rlq+RjSnu
         XnMffxA0atC8CM0vi7UTwT0+FvlzBz4z3DyHtFk9tKEN/hrpHP45pEqOSiDh96bRT0JS
         PQvKmN0rXGjIE0JweCWIl5zPN+2f4YkRkhVfStyTGk1bU1HgLFtz0p95E5nlhcy2+Ib7
         GLb+Ls4pdnmE1tfz2BkSog0qj/nXnYpgfSXnK1YzcizKjiEwCm79ECXk81TdepkeFxNC
         3bSzMI7moV6E11lU+HUzbFgGfduNWeul2u/AbNqTm4sjUFa1erUaCRHFcNw4vz4wPkyT
         bRfw==
X-Forwarded-Encrypted: i=1; AJvYcCV5g6Vat+F45Vz2Z0ouCbY9i8juud2SUwaygtQO5Ed8vOd+8K0J7KozLwKf4alI6ja85WHzSSWBHmEyWoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvFMIXMjCMDe2BmguBVxBoiqWamKw6y8Ds+Sw/Nak08zN05CKR
	V5u6SRHnlAW7/spyAl4uM+OE6uZZEpHnCaPlt7qGFBEQz8g2WBZXeOBGtCp2LU2kM/vzNnGw+1P
	hzYYMDWXll12j0f8MjHQQwZ9h7mCTQNbx5TFqNLjbKohhoN6GhnYV
X-Gm-Gg: ASbGnctBqbkdvYEDAu46DMw3jKPwGYFqHOJz+A3dyd765W7UwPE2gcSSEhems0tKySP
	+QVM5X/ISIxaHysToD3bRjccwUzRSHQic1vtDfKMOweIFCYaB9vi6Ix7Xgun94WmQpggdZQgOwS
	oEK9j6obfKQgCpJFPjVYQ21awt359HvBvrSCosYPM8Rg/MlslKP1tJxTQR7U1jIFqZclwj+TGNI
	DcEinksEnciF3y6oLihGj54ehAVsFa9NXjZWtaMJyndHWaYspuDyklUIKw2+4vfIrsr1yhW61IU
	1/F05vNfdoq5beEVmawyyAOGmeVn
X-Google-Smtp-Source: AGHT+IFa4Mg43fDyhq8XGqcAaXzT3DThyrNii6w4o7OGlqUmCCShlNd2QaVTebvbSElp7vVfURXPMK55scLnEN7av9g=
X-Received: by 2002:ac2:4e0f:0:b0:55f:7328:f6ae with SMTP id
 2adb3069b0e04-5941d554d76mr5114757e87.51.1762182081490; Mon, 03 Nov 2025
 07:01:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030161011.282924-1-marco.crivellari@suse.com>
 <20251030161011.282924-4-marco.crivellari@suse.com> <690b3fd0-20a1-4245-8fc4-4e8b40695c98@amd.com>
 <CAAofZF4V7gN=AqgLwcva+zhJyROYfSjzJ2uLxoNeS2KLuytW9Q@mail.gmail.com> <42c631c7-7773-b029-6d59-a54112363a71@amd.com>
In-Reply-To: <42c631c7-7773-b029-6d59-a54112363a71@amd.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 3 Nov 2025 16:01:09 +0100
X-Gm-Features: AWmQ_blJWZ1gR4hPVHrfeQXQvGwYLwKy_C2JeMo72mgp-bqvi56gDubAhgPoPh4
Message-ID: <CAAofZF4Q6MAg0ob4nJEGXkHd0KnDPgOsATcguER6mAmD7CD6Vg@mail.gmail.com>
Subject: Re: [PATCH 3/4] amd/amdkfd: WQ_PERCPU added to alloc_workqueue users
To: Philip Yang <yangp@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, "Yang, Philip" <Philip.Yang@amd.com>, 
	"Kuehling, Felix" <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 2:12=E2=80=AFPM Philip Yang <yangp@amd.com> wrote:
> Hi,
>
> WQ_UNBOUND is more appropriate here, to execute the KFD release work imme=
diately as long as CPU resource is available, not specific to the CPU that =
kfd_unref_process the last process refcount.

Hi,

I will do what you suggest.

Thank you!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

