Return-Path: <linux-kernel+bounces-736876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE06B0A483
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1FCB5C03F7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8A62D9EE6;
	Fri, 18 Jul 2025 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aOUiR3YF"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B2CCA4B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752843320; cv=none; b=Pe5oWictcIdQNBsPTJFNnnhouKYzgwZ7ViSeTyQrJG0Mh6+rnkrg1a7GrxUSFyy2bpHP+QYZLstNmigeUuc6Bhij/DhJNfBmbfRHUrwCuwboGH2iaT/1Qzz9WCYABd34WvcCdRkOEXi9RR9szfYARipJSeQrOLqVn5ATbJYI//g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752843320; c=relaxed/simple;
	bh=fr1n0+4rH5sv5RMc7Jiy602JCBTLdiJ3P6xmnxqtQEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aW2OkoKDA/a8fCm/CRr8Fr5qmKsXkHKNpVWFFXdFpA3KeOJUiARbS/VuYuZuoBgU+h4t7tQRjtqFmBEwzDXIVp8Zj1+ezc6aMwy500qk+1X3mVVqSMmmGwAYCAYimZfQxtxsCtP+sF30cFtOxap6s3AAvr82tginictNtaI6UoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aOUiR3YF; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so3214982a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 05:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752843316; x=1753448116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fr1n0+4rH5sv5RMc7Jiy602JCBTLdiJ3P6xmnxqtQEY=;
        b=aOUiR3YFVdOPa6YEXFvhZLE9iTJLvxPOhjE4aqtLsgeR/5von0zcJscAlQvj6anHZo
         1D4etNHE4xPdVVIYH6Fy9VULI/BQ8Amqzq987ZnL2X9wcfzehsa6OsFoWhhKn0jpp1U6
         iIC7kHq+Lgyh6f2nS3K6DCci3pSfL9pt8Ymj6xGg4R2fvsmvsT5WDFQvtq6+wQMfAtWh
         7XIoCvbQBMoPb9dReqGBtBetX+rel3IOW+3WoVaVUQdcseJJppM/XRzzdd0g3gYorBnP
         j0ZLZcyFvwKfXynMaXWycNIGA6PfcpCMRJYWAGBd9qg7ozyLqzmRScJPLZUohEEQMQUz
         nfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752843316; x=1753448116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fr1n0+4rH5sv5RMc7Jiy602JCBTLdiJ3P6xmnxqtQEY=;
        b=OpoTx3F5xDL5wa4nIeXx8xl/9sWhGSPYorP8YIorAeX5/YfDzqBXScpM+sikn6DJti
         z/FeLruEbd0xPPjPTAkM4zf/9kKlbnTzgj1MES7BnF9bdJrKjQnihmOmzBq+kbWWXb0h
         +PkfGcPw9CyUi9986euRh82KmiHCemZBKMh6wlwGFx+ha5JPZtyJUBRPD/HkgALIqxem
         CQb8p/kG1erYWjyTeZXaLhOPl6TXMpLpA6QsGylMAksZ/maOqI39bsKv3moO2Oy9GyKb
         vzwrqkAYID6nEhqel+bAFtDPr1+CODYCZHrlitvO8RwEeb1ySJpgIwpJ6adirTvijXaf
         MRvA==
X-Forwarded-Encrypted: i=1; AJvYcCWe/LivMPGtbn+caqkTmjCEnUUDGgt2NiRLFAubtdxDMqI7fvmHHutyODIr25Df1OTRO3JGsfadd0/c7VA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywptcujwhhgsd588/Wvt+7lP0f8RrrRac72Z08+P/6YuZr32EWJ
	rS5646e5Xc2xLPvqdzQCO91AxZGcaOu1oSrkR8wh16QJ+7q9uLFVyyAaVeAj8XQ6TJk=
X-Gm-Gg: ASbGncu2dV3XzPjRVeqX2oaq1uMAcjA4aCT/BkxHF1QSN6lBQqZyQFv32/kDBWg8Fcj
	DU1+JiYGh1PY223rFCjFAMJiXi169DqfH69xoRVDp0vjnb3YqUmvj0fceqKzN95H5mNo/6SFVa3
	X1iQf5d7l/R1UNYBsgb8aybO7tU2sJU8IBbnlIGHZO0g1hZlq2OaJAZHNeIdumYCCm5B8Ug/Y12
	WercoWPFUiPZsHsRADK3m1Uec5OTPtcghsLG1QlTUj4jY3BoZLdl2AsKdtwL4FDSu5UWO4QNVbc
	wBVfw61ZJQgH2mPKc7r6xJiw0VvpDBoQPfxHxWaD4f4AsRpFyJ2MQU0YmVoag/S4Zj3SPr5LcoO
	+dAH9Blw0DbVv+JNMariGJI1mCMDrlNryNSNnbPaRZxq/4WmOXe0G
X-Google-Smtp-Source: AGHT+IEDd8o5qENEV8z7wOzGgV76OAd6eyt4G/o3gZdjbTKFnZihnkfwJCXrzidGiE+3z1dLAXqMig==
X-Received: by 2002:a17:906:d257:b0:ae3:ed38:8f63 with SMTP id a640c23a62f3a-ae9cddea78emr1022205266b.14.1752843316310;
        Fri, 18 Jul 2025 05:55:16 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca817acsm116348766b.131.2025.07.18.05.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 05:55:15 -0700 (PDT)
Date: Fri, 18 Jul 2025 14:55:14 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Zijiang Huang <huangzjsmile@gmail.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zijiang Huang <kerayhuang@tencent.com>, 
	Hao Peng <flyingpeng@tencent.com>
Subject: Re: [PATCH 1/2] cgroup-v1: Fix missing mutex_unlock in error paths
Message-ID: <mqzlqupbzt4zlsphipac4qz75uzzhcbiuxez2bupmcatp32hkw@y4ltledez5y2>
References: <20250718115409.878122-1-kerayhuang@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kkznbscjeqxbsktm"
Content-Disposition: inline
In-Reply-To: <20250718115409.878122-1-kerayhuang@tencent.com>


--kkznbscjeqxbsktm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 1/2] cgroup-v1: Fix missing mutex_unlock in error paths
MIME-Version: 1.0

On Fri, Jul 18, 2025 at 07:54:08PM +0800, Zijiang Huang <huangzjsmile@gmail.com> wrote:
> In the function, after acquiring the mutex with mutex_lock, multiple return
> paths (such as returning ERR_PTR, NULL, or normal pointers)fail to call
> mutex_unlock to release the lock, which could lead to deadlock risks.

You've almost convinced me that you've found a case for the scoped
locks. However, this patch doesn't look correct -- the lock is released
in cgroup_pidlist_stop() + the comment in fs/kernfs/file.c:

 * As kernfs_seq_stop() is also called after kernfs_seq_start() or
 * kernfs_seq_next() failure,

Or have you found a path where the pairing is unmatched?

Thanks,
Michal

--kkznbscjeqxbsktm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaHpEKQAKCRB+PQLnlNv4
CI4+APwOU4L//IIlbdg31+dRLygCkDW7N3RBdJrIuJJaCtmxGwD/XilJ674QgJUF
btY3IGq540HVGmD8ej3GV8x1dFdRTQc=
=yyIz
-----END PGP SIGNATURE-----

--kkznbscjeqxbsktm--

