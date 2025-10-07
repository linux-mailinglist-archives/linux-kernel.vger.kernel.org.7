Return-Path: <linux-kernel+bounces-843697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 486A8BC005D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 04:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BA1E4F15A2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 02:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EB71C84BB;
	Tue,  7 Oct 2025 02:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsUbabb6"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916241A23AC
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 02:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759803797; cv=none; b=PTUTnK1eM3vcYwMPaack/jyqa8ugC8MNRt4ZkUY/RcF44GeSyCv0Am3AoZXF9Vwhm6NrrzEUe0Is+Bm9kn4XWfo0eJumUVM65nUL2AaoMHgVEw3axMcqi+DOZvnptgN3HafhQxtkR/qKYwVZewEhhHw0MjOnQxySEEe06NhK9W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759803797; c=relaxed/simple;
	bh=VFmeDcTP2xUAQewFWw/R0BKl+XcGbbncNDnV2L/OXN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6ZeJ4v6X6xwvHqcEcrCDEx2MxHsekhlDkqIjqLIkVcRr/dCFZiOUU4tCK0bTHz8LxNDdN5DZuQa1jz7AntukaX5Z1x/BmPmscmk6VPTYafpjWITlV1iRa77M88J2oPaNmqpcar+2o7mccW2I06XnaM2beKDc5M0sPIHmiaorIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsUbabb6; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3324fdfd54cso6608554a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 19:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759803795; x=1760408595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VFmeDcTP2xUAQewFWw/R0BKl+XcGbbncNDnV2L/OXN0=;
        b=dsUbabb6l06KJXGCdPtZiVMtWdwnBLSbSQsM1Rk5pumQuR/OkOgFCKVg4GQxwFDGMS
         mBWrQKCqrj0pK+6jFR6HWD52gXGSAgL2LOl6TDduNamn6NH8S18yyAaYDZlfizrvjU40
         1xSrp3nibSL+PF29vEbKn8tRaB6MQRLYzBXZaUZz1JKRwySPFYH3wOY1HAD/NOUrRXdc
         tpcpSns+N2l7Ky5dPi8MQldx1qpyQPsF1Aql9UOrjo8B6MIvnlIKSsQ36tKBuhNNvxms
         tV1r9M+Mh8Z4wY90kX54phHFNpUHHHKv9WPb2eSucGx312kuwHLTT/pBGA8a8q7p13g/
         OR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759803795; x=1760408595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFmeDcTP2xUAQewFWw/R0BKl+XcGbbncNDnV2L/OXN0=;
        b=a693PLTYGdqN0pRj5QE45C5+xsVNKPtT96yVr/ZPL28dmHn411cj3V40F3bmhO2ksx
         QkkgTD5n4qhavy4CT8fRtr0arkgjs0Oa/FAh/+DJpwQLP9lonkEDyrV5vXMjGNgxQnIR
         /YXlInzv0Xz/FmVC6FuAP8DFrRde7ryU8D1wqrBO3vG5Uiun9JgJHteWJJICbZ5XzZJ1
         xFY+YTtSQT8B6O/t0l1hfwj2M0hUUODtGp0tSitNE0c44DDwt4e6qINfCvJGJ22Ov4V+
         qCJZFl9hnNiOyNVG3gekh9qHqpL1EtQMkEpJQWHipb3QxG6cbMZ/SsSZlNICBEVZ0e2i
         rj5g==
X-Forwarded-Encrypted: i=1; AJvYcCWs2FWj/CD2L2VX4ERS30rUEn0/Y4e8Bko/Ucf60sYx1imGpsGBo9MrK+6s1/3H8vqd9h91j79KO4gyDUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqpnu7b/xG6p7wpCfV56StPihLdp9rk/vCe3AsZWPdu8M+wOs8
	I3t5/F6xgoT6SLlyKmBbjsqPRn7e/EL6TmNu+qHovFFd7VgireldDHw/
X-Gm-Gg: ASbGnctHp3AdsST3b1PBYFLUGidWk/Mlz/6Wiconikt1O5qJjeD0p8b4MkEjePVv7E3
	zWWX07NIvfIfg3Z21jctKd0uJtIlLgdylRd7hZ1nMBr0NbwyRw0wWdl0ES0vcv/V85apbFoaMlF
	Eut/V4LLZCBo+iwpmkHn+jO0sGCs8eYJJz8QjYP4MBPbuvlqTelMDBmm6m5CF/sE5JWkvDBp8lf
	XMx3k90n1ie792vfV4gYDA0KVKONIgJwPZfJ2+hnSMMEKwjsjFy51gR6HUjO0PCzz23F9lNR/JL
	R9Lf7d9DO9pLBW/BPs0KKsPd9MVYqJHSgiQX4BG0oH3UiCTq0cK2UaAppeISLIT6WgAIxmtd3aW
	QZMX5/CssjHX0vYNMZNNM/xUG4Lpn2ctHOjEUplE47KHPmik8pQ==
X-Google-Smtp-Source: AGHT+IFOWjODpkm0RXk0UNQxPxlDwgwSSLwVcoAanx1LQC/FF/GVJT5hQh4wQ4RD5szE0at/zJ+BUA==
X-Received: by 2002:a17:90b:4a84:b0:32b:ab04:291e with SMTP id 98e67ed59e1d1-339c279971dmr17239314a91.25.1759803794482;
        Mon, 06 Oct 2025 19:23:14 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ff26f8sm18166635a91.13.2025.10.06.19.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 19:23:13 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 8DC154233432; Tue, 07 Oct 2025 09:23:10 +0700 (WIB)
Date: Tue, 7 Oct 2025 09:23:10 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Roman Kisel <romank@linux.microsoft.com>, arnd@arndb.de, bp@alien8.de,
	corbet@lwn.net, dave.hansen@linux.intel.com, decui@microsoft.com,
	haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
	mikelley@microsoft.com, mingo@redhat.com, tglx@linutronix.de,
	Tianyu.Lan@microsoft.com, wei.liu@kernel.org, x86@kernel.org,
	linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v6 01/17] Documentation: hyperv: Confidential
 VMBus
Message-ID: <aOR5juzHnsK2E40z@archie.me>
References: <20251003222710.6257-1-romank@linux.microsoft.com>
 <20251003222710.6257-2-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BxWMTnibnAgGT5v9"
Content-Disposition: inline
In-Reply-To: <20251003222710.6257-2-romank@linux.microsoft.com>


--BxWMTnibnAgGT5v9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2025 at 03:26:54PM -0700, Roman Kisel wrote:
> +The data is transferred directly between the VM and a vPCI device (a.k.a.
> +a PCI pass-thru device, see :doc:`vpci`) that is directly assigned to VT=
L2
> +and that supports encrypted memory. In such a case, neither the host par=
tition

Nit: You can also write the cross-reference simply as vpci.rst.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--BxWMTnibnAgGT5v9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOR5fQAKCRD2uYlJVVFO
o7mVAP9gyGXv/aQVGaS5iH1wf6rUETBzEy69Mg8TYKRf5l2JsQEA5cnv0cPiT81i
pUA3Vos9PED8kntZHhKYkra64woP1wo=
=xXE5
-----END PGP SIGNATURE-----

--BxWMTnibnAgGT5v9--

