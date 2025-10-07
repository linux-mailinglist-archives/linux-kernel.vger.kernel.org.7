Return-Path: <linux-kernel+bounces-844899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A02A9BC304A
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 01:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A14C4EC5F7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 23:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC7C2797B2;
	Tue,  7 Oct 2025 23:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLz8WOVG"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2CC277C98
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 23:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759881408; cv=none; b=Xc5lO3kOzf32remlBs4RR6SJSQ1+RQGxgG2hL27YIseaaU0WzSFXj3rk7gzrXbIOF6MdHbrpwdTDkMWdEPYG9Y2HnCKaewIAWn71FGpF3l66QEN/5UyWpryBzupC9by5CL9XrZ/6g9O3lUo3NvqoeU0xCowiwRZbOyGIY2CB+4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759881408; c=relaxed/simple;
	bh=AqqqImyVX4Ca3i3a0FyZ/Awd7F5tA5oiYrQNUtG8eUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sk096xosHiRFSPMe7+/j4pkE0nYf1VSh3G2ewbHJ6/xQ6sPbnxsliUtzuDOgXoHFTWQa3EksrKJbX6b+SGwO+rSnVouHe2VWa0pE6+TU48IQrMEEiYwKNm2Ng+rtWXN2sfiCrRWyGrjXPCiUZiYlioRcYKtL1yupANqMwG8DtZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLz8WOVG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2681660d604so72407955ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759881405; x=1760486205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AqqqImyVX4Ca3i3a0FyZ/Awd7F5tA5oiYrQNUtG8eUA=;
        b=GLz8WOVGheFn3RBJaFY/U1JgK36OepF93uQJoRhispeXsiPtRsLqFhqs63Bjuk1uhM
         ophSCnysgbBUxf6QEwtyqHSxrQCtEuio0YUPZ+P75xhXzgPaYq8etiLstBJaMxfEazRO
         zfuWD1802NUI/eBlw3bkrVEP/DyiYAWp6rn8xoJEiJFUzxdCDUxGIU4quEP0CyJNfHzX
         AudNZqvRYPeEFilDQ8X4nsblrn8i5dGS3ryDCX/NZ9Ve6p6s8c++4i7gfGTF/QfR5pl6
         lFju8eVY8qejuOz/n7RtRApTpjUrMf9ZGDhBo9fhDg+wKnRsrC8zSWMNOUFuPrK7l+x3
         kTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759881405; x=1760486205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqqqImyVX4Ca3i3a0FyZ/Awd7F5tA5oiYrQNUtG8eUA=;
        b=qOMisSe5zAdCFdtok5l/PuwA674/En40vnFBmPL8t6uE21nCHbx/bjBzhf+hBJfGCQ
         JCh1K4Id1ia6dTMhC/IYKILNLj+0E0+HzXcg9YKFSBbLkX6Z1+Ugc8vuKwiFybw6S7mX
         pV5Ueg0aVhqk/3RW1VSz7tv+HKhb78qJVdKoBAVm1FC1LPUccWLfMzCc9PODNcolN4T9
         9BtrNbih3M8oAPd98mmDldtxzzzexOEeHPDo7kuMTILhh6r2Lj2QhDkVBdn3huPQCd6u
         g1pyO+8zJyVTPztXLC1wxgGpVGf+28AWv+Ik7MokraPw8/29ceuaDFc8vJeGYvGPxdl0
         qnNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV02xU3H1fWiN4ODPlROjTr7+3UIRAHUVTXwJqdbkBN0mueIP8VFGh77B4DB8RpR8AMnVDw5dt4ijV9GVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxPJ5ZzK7g3peupKMTp/uW5KdJedst/hqwWa3dJg1vAcbHGbMX
	n8BbEaDZ+5+Z7gPHs/xByMcjMl12+u81sP/wvBkQQw/66S2eRX+q3Ls5kxYLZXsW
X-Gm-Gg: ASbGncuXwPy9kAY6djCSOxizahAYtraoAw5jr03Cbibv2oKzJoJXcCLtdUzVU27qVzy
	QOxpJNZ9Jxsi985JQ8l4F0AXXltvJc5btFefTijjDL3Apsl65uoghFlHbfoLqTUb8G7ZLg+tb38
	Acl0Xnoa3fJer9y35+Y8aOvPOzZqENUpeATZxVQ0qCDncccSAQ3RCYf8pBI2GleB9YuWkVTJRqF
	GbgVcqJha/RLJh7VYLunNGkrVYZ2RETzcw0EegAzJCAMDlRs87CvloVrgkVvnxf/PRBGTAlFk4X
	LVt63ae26mD54dcI4IwSTdzjnLKGNLOTjBuYJdWmaDKUErw+Uesg9h4qyHPmmEbijptvyccbMdJ
	bXEjw4rW7P8DStwVpifvFYz/7FH/Ox62PGzCq2Ow4a7DCm4FdRhVaLDazHgD8
X-Google-Smtp-Source: AGHT+IECR12KH7zCTIlL8PskN4SIrX86zChxhzZyqyWEAG+eeOOhmLw/P52uED83EK633yo7c2PQsw==
X-Received: by 2002:a17:903:298e:b0:26c:9b12:2b6d with SMTP id d9443c01a7336-290272b550dmr18677895ad.38.1759881405144;
        Tue, 07 Oct 2025 16:56:45 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b513ae7d9sm937031a91.24.2025.10.07.16.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 16:56:44 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 599D64233430; Wed, 08 Oct 2025 06:56:41 +0700 (WIB)
Date: Wed, 8 Oct 2025 06:56:40 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com,
	arnd@arndb.de, bp@alien8.de, corbet@lwn.net,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
	mikelley@microsoft.com, mingo@redhat.com, tglx@linutronix.de,
	Tianyu.Lan@microsoft.com, wei.liu@kernel.org, x86@kernel.org,
	linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH hyperv-next v6 01/17] Documentation: hyperv: Confidential
 VMBus
Message-ID: <aOWouGarxf0FB7ZR@archie.me>
References: <20251003222710.6257-1-romank@linux.microsoft.com>
 <20251003222710.6257-2-romank@linux.microsoft.com>
 <aOR5juzHnsK2E40z@archie.me>
 <273e0882-24f5-465a-be18-d67b4249ce12@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DTXlXJKe31yrlnoK"
Content-Disposition: inline
In-Reply-To: <273e0882-24f5-465a-be18-d67b4249ce12@linux.microsoft.com>


--DTXlXJKe31yrlnoK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2025 at 01:38:02PM -0700, Roman Kisel wrote:
>=20
>=20
> On 10/6/2025 7:23 PM, Bagas Sanjaya wrote:
> > On Fri, Oct 03, 2025 at 03:26:54PM -0700, Roman Kisel wrote:
> > > +The data is transferred directly between the VM and a vPCI device (a=
=2Ek.a.
> > > +a PCI pass-thru device, see :doc:`vpci`) that is directly assigned t=
o VTL2
> > > +and that supports encrypted memory. In such a case, neither the host=
 partition
> >=20
> > Nit: You can also write the cross-reference simply as vpci.rst.
> >=20
>=20
> Thanks for helping out! I could not find that way of cross-referencing
> in the Sphinx documentation though:
> https://www.sphinx-doc.org/en/master/usage/referencing.html#cross-referen=
cing-documents

That's kernel-specific extension (see Documentation/doc-guide/sphinx.rst).

>=20
> I tried it out anyway. The suggestion worked out only for the HTML
> documentation, and would not work for the PDF one. Options attempted:
>=20
> 1. vpci
> 2. vpci.rst
> 3. Documentation/virt/hyperv/vpci
> 4. Documentation/virt/hyperv/vpci.rst
>=20
> and neither would produce a hyperlink inside virt.pdf. Options 2 & 4
> generated a hyperlink in HTML.

That's it.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--DTXlXJKe31yrlnoK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOWotAAKCRD2uYlJVVFO
o/pSAP9eXlQLoQODQqZ+A48QpAAsl+hf9OhLGhdndl6X6JStvAD+OSXtE5WfHadF
FMFMiFdufdHXrrE7npbMx380tvu34Qs=
=nx3N
-----END PGP SIGNATURE-----

--DTXlXJKe31yrlnoK--

