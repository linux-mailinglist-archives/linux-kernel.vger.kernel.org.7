Return-Path: <linux-kernel+bounces-823754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE14B8760D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8B0C7B4DEE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C40E32252B;
	Thu, 18 Sep 2025 23:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luLgGnIx"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAA43203A3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758237794; cv=none; b=T7RUmeIuz9wJbtqZWYSc2Fqlp7xT4ia6WNtGjKwdmgIHg9D0hJPCEovetYUIFhupC9U2Ais0u0z/6TogNHT2N3r5VDqjPV2b8mtkew93+VpPCHzWIGhWKINdgmsq0s7xvMGOUq48W0gvVyFGLauJ++/7Ndsi3CiXUWhcGB6zmLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758237794; c=relaxed/simple;
	bh=Ef6Rx/N5TdXrlfO8lXio1fR8SoaPImH0mD+Ap5KLFW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egCTVkb5vi9HwFtbFrvifBXf8DDyDhPlUsDjgPeLK1X+wKx6GO+5NM2ZanlrMf0vPpYGH/4EHm5pvVcPCanFkP+VPoY8IJIdRQKSPsvko10rYQd7CabOpfqGD6g+IhJGkBD0Qnsuv4+7Ashd5B4J+5ggTQDIWuMk+ftqSR2W/5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luLgGnIx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2570bf6058aso20052555ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758237792; x=1758842592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cywbwc8EdUxJw4qdKc7+s9IRWS7iBCfFJYQJGElQO3Y=;
        b=luLgGnIxBnTH88GFo1W5xRfvjAKInbTT3pyBUnJIazeftoQ+vDUmf1/L1SWp6n+SMC
         bLgC/RsR6L93kaeQEtdHnc+ih5oOGJtVut7TkVlm0yzw2WcIAPJQYJamSfGGXqbAfLB1
         KmcM9XFuj9dL2C/WxiD0mkUFMdMVWk3zH8v2sO0wcVK9Bpbrqx/vBJCFUitI0XjVqYrN
         ZrFbM6PxJ+G5rF/IxbidbCEZDFLvEE+OgH/LThX2tmb6FLZ8LTIni49U/P8C2fxauMQP
         QIWHkK/PVtGEJeI331xdvwUhiBkqhb82KnchApAR/Q9SKefYbmUX0L/d+ZDXZLXs/Lvt
         bH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758237792; x=1758842592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cywbwc8EdUxJw4qdKc7+s9IRWS7iBCfFJYQJGElQO3Y=;
        b=MvIHXPdA3aBliFWli4mzmWQh4tuNjI4owocItkjW+4Dr4k6siM8+g3VtTUy9MLiWHB
         8MmmNSkp+qldKiiKDIiO19pd1wjD1CCEYvb/9UdsHPVgCJbFu5mBurGvy1X4dHw+mUO6
         MF3RrZ9x3RwnLvIQDfIUUTrklDDo6A6Whr83DE4bA/wJL9jX2zwh6WqlMHb8G7Z+ZnCr
         tTWU0USeIwOvibKobUucKnbhgjQmwhDHm066VqYX4eDbyd59ZsTmcSDkfbBVSlzf4Ei5
         iyOycMuQsCeQbMI9El0OFel+n86CjdxkgZ956tNtKoUpl7DPJnSz2yMLjMsgi0G+IQ88
         iUEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUxytFq5F2Ax9jnJ6UQqpBlWcPLrJhOtH5x0keAKqsxu0v8EDT0SY1TnJcuF9MH4yZ3PWMeRZHOXux0xE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKEOfwaH61jJ/8Qqg0UkdMnMOntGSoETkw00Agem6vvV2M6q7P
	oJIUD1WLRnHj3AXqb2p3agKdXSWsROnvRj69ZdT76tqDaehsd/9d19iK
X-Gm-Gg: ASbGnct7mLuDzj90mzkJMWwKwL2tDMFuGPEE+F1UH9cJgiAWJMDsQsZJT6IT+kcfTju
	wbxl8pgT5I+Hhu88x+E31sTCbADgHd8bPVh6/n2tZ0HdO5G/ISzH+U0ELcOabPEhey3z9hUwVeX
	rVGNqVABzkr9wJzhIvIi8ViD7S8zi+LYFZx2AdJyIWR/YODNmJoh2MzZ37bDgMcMUzm/traq6k4
	oGAfZ3w9Tm41jY4pffjJ1OUNZvS49MSifOLZWF3f664vZ2wAYN2OFtcwVD3xjxGZPhozZQ9X4sU
	w5H40QGZXWRH59P9dZdY6FvduMfSAtS0eZ/iQkrFoh+4DwM9VAT7uMYOxsE1VLOuxsGehekKjkI
	z5F9/KXJL4bow6kiQ6obeJ3c3ick1fScUmyuO8DE9
X-Google-Smtp-Source: AGHT+IGpNOwUTJg5vEerN1zVzVrhhiTJaIsAfQYpkwPbjiwSkLY7kk7Blhp0t2/ryk7iJPRhMy3cEQ==
X-Received: by 2002:a17:902:d511:b0:24c:ce43:e60b with SMTP id d9443c01a7336-269ba45c0a8mr19654615ad.18.1758237792166;
        Thu, 18 Sep 2025 16:23:12 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e20bf07c4sm992769b3a.70.2025.09.18.16.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:23:11 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 0313E420B4E0; Fri, 19 Sep 2025 06:23:08 +0700 (WIB)
Date: Fri, 19 Sep 2025 06:23:08 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Philipp Stanner <phasta@kernel.org>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
	Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2] drm/sched: Extend and update documentation
Message-ID: <aMyUXCF-Jlu3wAjt@archie.me>
References: <20250902111209.64082-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qhp/VLK82Ka+Yy/u"
Content-Disposition: inline
In-Reply-To: <20250902111209.64082-2-phasta@kernel.org>


--Qhp/VLK82Ka+Yy/u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2025 at 01:12:10PM +0200, Philipp Stanner wrote:
> + * The GPU scheduler is shared infrastructure intended to help drivers m=
anaging
                          a shared infrastructure

> + * command submission to their hardware.
> <snipped>...
> + * Job initialization is split into two stages:
> + *   1. drm_sched_job_init() which serves for basic preparation of a job.
> + *      Drivers don't have to be mindful of this function's consequences=
 and
> + *      its effects can be reverted through drm_sched_job_cleanup().

           ".. this function's side effects and these can be .."

> + *   2. drm_sched_job_arm() which irrevokably arms a job for execution. =
This

                                     irrevocably

> + *      initializes the job's fences and the job has to be submitted with
> + *      drm_sched_entity_push_job(). Once drm_sched_job_arm() has been c=
alled,
> + *      the job structure has to be valid until the scheduler invoked
> + *      drm_sched_backend_ops.free_job().
> + *

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Qhp/VLK82Ka+Yy/u
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaMyUWAAKCRD2uYlJVVFO
ozP1AQC87UKQORC06R0t9sItFjRkRGzZuHrMM2C41aAjbI9oCwD9GhjvSUEkZs++
clAP/8722HiSPJona2f7L3BBaH4cGQ0=
=kNNY
-----END PGP SIGNATURE-----

--Qhp/VLK82Ka+Yy/u--

