Return-Path: <linux-kernel+bounces-883992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D163BC2F06F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 03:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FCF7189C878
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 02:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74837264630;
	Tue,  4 Nov 2025 02:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlPM2pRD"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595272609D6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 02:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762224750; cv=none; b=BUDPWOCUOP/FdrDTenroC3q/Ir1h8jz1sZs/zbZUZTxbCvVjNPoDcJEuSSLSquehos0cPEbdFp4DA0pSlVrK9LCk6wka7WFxM6XmyMqyiDYm/8iYzT2CYBMsST3opA37Q5WPmCp6mzJBbqGR5rBV1KAsEyTmz5VBLfe4q41Eqjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762224750; c=relaxed/simple;
	bh=3tWJbifLBnvpN/JRMjzdL38LPPQ+G97PL29g19sGzQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTRqIRjnrXkJ/p46kaewPS1a3lfYe1AQ2ro/mW+GsKW5Dwcz1Tdh45o5w4KQtMnqADPo5uQrXobSNXpaytnyS0oToK4sfw0nwB8Iao0np0Lhk3Y42sYsT8gjByXUbcnSvZVK9CCWmdyWnQj5nePFsrTVOb49l+vOFXD4B0VDguI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlPM2pRD; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2955805b7acso18275095ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 18:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762224749; x=1762829549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3tWJbifLBnvpN/JRMjzdL38LPPQ+G97PL29g19sGzQo=;
        b=BlPM2pRDTUqYwBJ9bOb0yj+7ByZDKskzd4eHvDD6zsFjTUoiZ+fs5HrHgMM8OuQLCW
         jnzl4KEMwMPixepMz8wgXn7wCGCdhQXFbycJ1iYYFXn7XIAkqB/WWFWyaM2/21uPYJZE
         Yl3x5Npbnr0dpF97HDjYMisHOXyLReeRsKqC0h4O/O09mIQfK2yBysPGmBcJjzv5nF+z
         UzvHuep97IuhqC7ADW80F1OPs6TzPd8mwVNU71l1P+Ln5Zf1LZivFzdJxt+bRXSFTpGO
         3HNZuexNAbuJwhdtgKeB+oVgI/m4FRYn0oEq7H3a536G0ZMTnr1MWN+qZe9ewKgGRDSd
         oecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762224749; x=1762829549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tWJbifLBnvpN/JRMjzdL38LPPQ+G97PL29g19sGzQo=;
        b=rcuX4PvexYa/Gvca68g3qNogPdCz7uaF8xZppbfQvg2BtuWTg6huNEhZFuu5+yb75f
         55AYVPMfpkDYHch7hJHzFqpmAHUeZRKtEcXtXrJWa1F8DfCgHiICKpjM5JOU4leCIAL9
         zSbKGOZrbExlWQSSCWSO8Wh328uQk+mmW5SKJz0Lsem8gj+HWGc9H9m0OV6BWU7Dw4o5
         KASx4g2XyJ4wk8IIEXkHas8voS3bpXu39ofTMEAdFN6WPRUL+xFIhgA+GCDhnVVSAQcv
         JA/C2dFFroM4nOuOOtUtu9MYMqpSFi2ZbXnEUHsPrBXje5l2lhfbVMPBLYOu2M1g6GHw
         OweA==
X-Gm-Message-State: AOJu0YyXwGg50CEzb9x2DuhAOcHeX08GkD6wg+WZ4QYVguGV2TsRaUIz
	pCq35Er9HubSnMkTkUzJV+qigdSxf6wUajPHf0kyWfxZo3dTh5QtPw+s
X-Gm-Gg: ASbGncvpYT/WsTViAcFnZ0Z/GdOpWhUQYWI+FfOvUHHAdMO9600rOTP9S9PBF3tQ9NS
	WWe2rZ8nBLOqrwd2Sn0j8TQveMC3xYT7VMQQJYH4RmJkVgfdIOhCtUKqt0AxG8siGf2RN+ge28e
	zmrkGoNQpKPqWI6ZDZ1qR6ffLChVGekAKGFBQJ5RldyY5AxeOt1JgQeZ/ixnMcMHM4uLnxfU9vV
	WZ9KY9/09zB6ihBcX2k3gNJtbImSTiIuq6dkCh/JO0wN1mQWiMCttqozNlNveU1hdg+K4TKKAco
	QC0ZFPWtiZEH1cRRAiQwWXQuMWB8OSTyZkLSJ9NqsLgExPj+qe4Z3wTRY4fF6WGF3EFKi6TMwoF
	5EQikTPAsrxdes2O8dS4hzdeaCYeiVdcV/Rwv3bwgzjhi6Mtt3sZURW08AS1J2q9m+nfe4F+ice
	/LMWFoHFjRsC0=
X-Google-Smtp-Source: AGHT+IFAa3BjhnfTACYpqySRfsVkvcgHY7lS7G3ybxCoYsaIw+Dr/1CCWJZhz/f7vHQRsrc7EHjyNQ==
X-Received: by 2002:a17:903:41cd:b0:295:5623:e586 with SMTP id d9443c01a7336-295f93ab7abmr20256195ad.10.1762224748421;
        Mon, 03 Nov 2025 18:52:28 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998887sm7185115ad.42.2025.11.03.18.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 18:52:27 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 83A5C420A6B9; Tue, 04 Nov 2025 09:52:25 +0700 (WIB)
Date: Tue, 4 Nov 2025 09:52:25 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Vamsi Attunuru <vattunuru@marvell.com>,
	Srujana Challa <schalla@marvell.com>,
	Julien Panis <jpanis@baylibre.com>
Subject: Re: [PATCH] Documentation: misc-devices: Fix C macro cross-reference
 syntax
Message-ID: <aQlqaflrr8Ku1TFe@archie.me>
References: <20251104022242.19224-1-bagasdotme@gmail.com>
 <2025110402-going-swore-319e@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lSOn3Rl1q01u6ClR"
Content-Disposition: inline
In-Reply-To: <2025110402-going-swore-319e@gregkh>


--lSOn3Rl1q01u6ClR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 11:30:18AM +0900, Greg Kroah-Hartman wrote:
> On Tue, Nov 04, 2025 at 09:22:42AM +0700, Bagas Sanjaya wrote:
> > Macro references in Octeon CN10K and TI TPS6954 docs are erroneously
> > written using :c:macro:: (double colon) rather than :c:macro: (single
> > colon), making these rendered in htmldocs output as italics with
> > verbatim roles. Correct them.
> >=20
> > Fixes: 5f67eef6dff394 ("misc: mrvl-cn10k-dpi: add Octeon CN10K DPI admi=
nistrative driver")
> > Fixes: dce548889650c1 ("Documentation: Add TI TPS6594 PFSM")
>=20
> Please break this up into 2 different patches as you are doing 2
> different things.

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--lSOn3Rl1q01u6ClR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQlqZAAKCRD2uYlJVVFO
o7GmAQDqB8gDbrktA53sjm3ex+1VOcZCMxkOareCbTLb8rMVNQD9HAR3k6pc345R
ommijr4R+ev31rX+gxlHfC+0XDNxYwo=
=w8af
-----END PGP SIGNATURE-----

--lSOn3Rl1q01u6ClR--

