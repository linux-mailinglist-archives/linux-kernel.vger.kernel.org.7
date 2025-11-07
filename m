Return-Path: <linux-kernel+bounces-891137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 916ACC41EBF
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 00:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 502774E6F8D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 23:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861BC303C8F;
	Fri,  7 Nov 2025 23:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4VWJLrg"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EFF42AA9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762557331; cv=none; b=GIeCDwcMRaWc3oVYkz81NBvaXm/RsFhp5+9KE5Lq9AtVYmRwD5k+9cM4RDtzmdQ/yNFRF0sBACMiy7QUg60tEgOat6oEJ3+fZDm5bp4EVTwXArdRddltjMiG8Gj9ACAxaoRMz/Ca7PY8hlF7zW7fTo4S3eZBtyIRa0ZG+QsFJeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762557331; c=relaxed/simple;
	bh=1CNW2q7rZ5eZ1hQ3d6f/0/8aleciBSs32cCPnD55gF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgFKKMuznrTM2EcrqddRAgaNTH4+B9pHC8jmJ3aNwl6ELpOR0OtANskRD3yRqfc6ocHp5yr7sriQkWwmzSJacVctbYu9CrIl2g6uoQYkkxMlUfMMrbuORAYOjnuvzYT+yygbBzupikxkO4NGv9tOCYLttj5FLFALk/UYqyxePkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4VWJLrg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-295247a814bso15878355ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 15:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762557330; x=1763162130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lm3n9qHPKakGyAJDHeR9T+11dprM9YeXc2RscwPCjOI=;
        b=K4VWJLrgxSLsrRxVFAvj4UQ/OmcgvXFJP+pej5FUCoPjrEXmdEjbDvuWhb/JVn11n9
         +PLR1af8fB4dglUN8rNKKYY7g/hguu4zkRXm470sME+BGnMUAGAU47OEYPemX/jHFVeX
         pHTlS31qERdmTm/YAWWtPmsq+G9uF/3p/Y0AbEqam4i8NdTFTX+KlJcKPxye7IaYOSXK
         4T2FemmLRFn60Kwx0cWBWtb+F6g+r8wECL57ZaUwrsX0Ewi/ysA/IHDZPCin86Ifkcs/
         fxBS7l++hjcCBrypV4usqI4ibGp6fTqmvRERWZ6n8Mk6nt7mdRvZEiYviIycqe2ueihQ
         XFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762557330; x=1763162130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lm3n9qHPKakGyAJDHeR9T+11dprM9YeXc2RscwPCjOI=;
        b=Y6oQx3gSkEXwYoCUBkPvAdHYF78Vq+gumKWQrY3Ry1ZTbSoU18ar8BlMcYUz1MAwCd
         bveCu4GpCmPgatG1mmk7/GHnsFhzhautljpuCCXwNMQ0kIMK6h+kEiGKsTOUXBzrMbZR
         Pu8ypn/THGsfG5zpzMVlwEUTKrJbXOXlT6sWNaEDP6RXbQQbHc/EXpudkjlK13OdyegJ
         56wClHUC59+CSPz+EzfyuZ6oNRdNwCZfIr/7PuUHEUAED5tP2XbhDDg8glnKQo0IMFrG
         fs7xkYaC1th9K8SJO44++fF/Q2e5IhdbFVxXkhiIznVz1JuJxbWf82+0G315urhhxFAC
         kuCA==
X-Forwarded-Encrypted: i=1; AJvYcCW0NfWQGq1LA30MUt8nrvWj5rEy8/WYZctiaF125+lfg47wUF1SpEcNR8pdmJ18VoeqWabNQcEW7uosvEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWn/sKby5hQEXGzN2kJl1FUK1hp+IcxD0KmMh2OaswBk82AYBa
	ovLvwaQNKCGJIK+T2VKGHiDPr8H8hOVtnNbBxp7uuWLosnSi6Zklc2dMOdH1S5yhxWM=
X-Gm-Gg: ASbGnctY1Rw6Eb8PxwdD8RQ0qPfqzEI7+451zuLBih12xJOJPc6ZBhqYRzuDX7CT8v1
	vG0X6riIfbg2W9f3lK2GRQMOdy2B7FSI4WD+km4sluXCkSo8/l0n98YGylQn8ZvX+Rzt6t58MrA
	EcX0dM91GHD5VwRqNejfriLS+WnkgIaXwC2KIru8xq9h0SwSgWZ8lLRtdm7POBLV88aPjt8+Jht
	N78iDRxzUlIoPex8OB+33OQrQtzweL+wJwiZJeeAw8JdTiaAJUPtkrloKPl3YumsOHViL1HzCXb
	7DqDPsa0Z2Y84+w8w/DQrBtr3g+u8VJW0jMZmjcPYNRE5jZjw00f5qssl+9MXO+DGJ6nsgRShsg
	pb8SXaUUujIEuSDqEtTQQ7BakjoDX4ApAYyfgTciMfLWL9WxaTrmn5CbrtrVsglYKk+2BvBXRaF
	xNpeMwdOIiGaU=
X-Google-Smtp-Source: AGHT+IGED60LsdNHAG47E5ek+vWqvgFmd56J6anEw/IyiassMDG+ECL/tyhoZhYvdVdrJbsIiOQYEg==
X-Received: by 2002:a17:902:e888:b0:295:1a5b:f406 with SMTP id d9443c01a7336-297e564f99emr8849895ad.25.1762557329690;
        Fri, 07 Nov 2025 15:15:29 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ca4257sm70259405ad.95.2025.11.07.15.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 15:15:28 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 88957423BF1E; Sat, 08 Nov 2025 06:15:26 +0700 (WIB)
Date: Sat, 8 Nov 2025 06:15:26 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 0/2] genpt documentation fixes
Message-ID: <aQ59jnOE3pFyZPkn@archie.me>
References: <20251107081300.13033-2-bagasdotme@gmail.com>
 <49ff6f64-b664-4628-af2a-1b46e0fd62ad@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="haSgLIvfV15aCdif"
Content-Disposition: inline
In-Reply-To: <49ff6f64-b664-4628-af2a-1b46e0fd62ad@infradead.org>


--haSgLIvfV15aCdif
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07, 2025 at 11:16:36AM -0800, Randy Dunlap wrote:
>=20
>=20
> On 11/7/25 12:12 AM, Bagas Sanjaya wrote:
> > Changes since v1 [2]:
> >=20
> >   - s/to set/to read/ (Randy)
>=20
> That's not quite what I said (wrote):
>=20
> > @@ -354,6 +354,7 @@ static inline unsigned int pt_max_sw_bit(struct pt_=
common *common);
> >  /**
> >   * pt_test_sw_bit_acquire() - Read a software bit in an item
> >   * @pts: Entry to set
> > + * @bitnr: Bit to set
>=20
> | Shouldn't both of these (above) to "to read" instead of "to set"?
>=20
>=20
>=20
> No changes to pt_set_sw_bit_release() [which should say "to set" in 2 pla=
ces].
>=20

Oops, I misunderstood the review. Will send the fixup shortly.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--haSgLIvfV15aCdif
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQ59iAAKCRD2uYlJVVFO
o2mPAQCtbCENoydVvPLZcPrSmiIrDBqFuvWPN0Kq1nC14RV9iwD+KCZacoHSjhsN
O6Z8k1VhZ8ialSR19Dwm+CelyQbgTgI=
=3f7R
-----END PGP SIGNATURE-----

--haSgLIvfV15aCdif--

