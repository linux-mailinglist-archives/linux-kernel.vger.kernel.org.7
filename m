Return-Path: <linux-kernel+bounces-894518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 641EAC4B396
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 07D5034ADF3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ABA34847E;
	Tue, 11 Nov 2025 02:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6v6IXy2"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753C17082A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762828498; cv=none; b=oC7P1iM2O2jlDHHDUz6X8BiMwxz++l4AbmV3DEGKSjrqjU63/YPosngq+bxcftfVPy52ExgnYp3XeoUQgvgZWUwcwY3OAL+U4Gjcnot2e5r4BsZ638wESrI1hFvgIenyrV4G74LybVCwIFdb6Oq1barPS7JG+K4JeUzLRbyimoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762828498; c=relaxed/simple;
	bh=36ncl0PUcmfXo8Ga7gX6fzon1aa5NOwmeXnlIwgkJX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6SClM09TtKaJ5QZCCm+zta4ZHf1PsEg8KJ5B7+GIxUuEvia2bo7f3audarxotX9YlkmdT2iqA4knJqZj2axmMehn22v5Up4KS61BZBV3PfM8sIzMFDpA37CI5h6EKGt71LKsvweqYtMIwl+ufxuApvyc0rXnStSBCiYm+swIck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6v6IXy2; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b25ed53fcbso357222185a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762828495; x=1763433295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=36ncl0PUcmfXo8Ga7gX6fzon1aa5NOwmeXnlIwgkJX0=;
        b=F6v6IXy2qLAntaPMTSBDELWgeeR0OIJyGu+bTHJVw3KSrZpZWno6Q/sQlfDV6/W9U1
         Fiq+nYdVArGVmNOiL9Dgm136uSSO4yGtKMibRLz9PtlTDWEN4LFVa21HSmq7doiKvKvE
         JV1K+CpqMD4PBOB87qb1NjmkGW9C7vg22ZFveH+MgTAc2WBV7McIKQAbJcw+RtEYCpzM
         5s3f4eIkgwlBme5h2qh8yzw9Q1y1ONPNdP2sIDq4gjIrMC8nJk4vnr1J8I+eB8zgNE8T
         +oyGvTnFJyXjF1y1pO9kBL3N1kWZ88RKu7BGfvdh57yiqH0vx9RG9U36KHjcaEQVJ+P1
         mGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762828495; x=1763433295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36ncl0PUcmfXo8Ga7gX6fzon1aa5NOwmeXnlIwgkJX0=;
        b=OxOqZ7ifKCZ7x4cDGJTm+A3MyvWQsKOkzvxibDXMwaAUx9g2OSoYZ9UF8YlacwnqAA
         a6jUiEKNRSjCOmljo9HM2jq6pmBNCbm9d12+cQugM3qySlCpaEnomeHVfXg4sS/Qk+qd
         VLALVtBsaJMvy9pFOL+T5zXmxtCU39EnxKi3DjdQS3FdSke6Y2GV7e71ZNo42WFCaewg
         obIMgwLSZ+N/k8yKg/DdQIIezy0eoeNuhWML7mLcszPOI3Enb5hZ4EkZ1KY1hz2UqXNO
         x1XHoaxvuHQ3ZNAR1oxTJM0xca+UpS4jG73R5pMUa0jXFs7OwSs6VhHNQfodrYRFIbAy
         +fIQ==
X-Gm-Message-State: AOJu0YwGqBZhKb9A7pg1o33hrp89RZvEJ+2ffi0n40n8JQfSY4IeDwSH
	3SxnbQAtMbY1BUB6JpwmN6H0yOrGNtzJevuuNmKtNtxHMH/TtGI9EAxr
X-Gm-Gg: ASbGncu3dIS1lIayUlPpxfuFdpqptZlmh75dKIyUCH0DpVOjWfIpfzJKmgw3yjDrIm7
	gaplLV+wpWnjQSnog254XCOSOBECwl5v7HrcO5Z3kM98E6t7hh99+JVrTT6q0t+AtsQBJrJ+tRV
	433rzEev2D1UhOPKk2bofV83YvyvrsP644ue4wWl9OCtR8738DML/B/4GpAjubV3B0IDY3YX9Dz
	WpVDA/haIjoDrBQrcGjk7SjsYzU26qTc3rryfCvIuyrknNyln0cBtcqws3xjWzE6LuMCJxolQxZ
	EpufTLrI0ArsA1xQjQFxTYZMBayIpQcuaAoyAiFo+YdoHeEOCCxLysB+qr47UEePED0SKFCMRjS
	yLkWXQVgGzGf/pDn9AeKa+6Iwie11qDbAxp1NxSMqQxkKCndLPvwSdzvXPWBDpBZxgeHl8Doa2c
	LvJoScwn2iBdk=
X-Google-Smtp-Source: AGHT+IGbk0YLpiY579gVpZiZCi3ixwsphSaTRqh2TflzCCa7sl2R7fDDID7LfBG+DM0e7yvO1fyTxw==
X-Received: by 2002:a05:620a:700b:b0:8b1:a624:17b1 with SMTP id af79cd13be357-8b257ef53femr1353533685a.27.1762828495281;
        Mon, 10 Nov 2025 18:34:55 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b262aa810asm556535685a.39.2025.11.10.18.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 18:34:54 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 5B906420A6B3; Tue, 11 Nov 2025 09:34:50 +0700 (WIB)
Date: Tue, 11 Nov 2025 09:34:50 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Security Module <linux-security-module@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Jarkko Sakkinen <jarkko@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Kees Cook <kees@kernel.org>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Stuart Yoder <stuart.yoder@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] security: sctp: Format type and permission checks tables
Message-ID: <aRKgyvrTxldlTv9t@archie.me>
References: <20251103113922.61232-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qvMASAdkqo7heMZ7"
Content-Disposition: inline
In-Reply-To: <20251103113922.61232-2-bagasdotme@gmail.com>


--qvMASAdkqo7heMZ7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon, Nov 03, 2025 at 06:39:23PM +0700, Bagas Sanjaya wrote:
> Use reST grid tables for both type and permission checks tables.

review ping

--qvMASAdkqo7heMZ7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaRKgxQAKCRD2uYlJVVFO
o2LrAPwMHby35jPtxyGXpWYYSXXuCRk5uukKnesFG++5jEn9wwEArl/pKT9VjSes
nEPBegou4DPD34Ra21k7Rr1VjGy+mAM=
=pGcR
-----END PGP SIGNATURE-----

--qvMASAdkqo7heMZ7--

