Return-Path: <linux-kernel+bounces-889777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B459C3E7DF
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 06:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37FD3ACF82
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 05:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156FB279327;
	Fri,  7 Nov 2025 05:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnSfq41C"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C43241CB6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 05:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762492481; cv=none; b=SsMgjv6yvuIOD5FIvOtOYflvTLbP/cJu3RcuBHTC+I6sCTzozwSYebKbecd13xam0ZsHScOufzSlQcLQdnx0uuy7ypx6ijnmi2zIoUxxnTzsv5Pniz2kWSCUDIuU6GMfSkI+n7E/hV+wh3vcfQtIHogU3RvJopCuTcJaDme/c/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762492481; c=relaxed/simple;
	bh=wFgazZHwRKDC0b+E3ALvNq+/41+FCsmrjBSYyzfDEw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFRCI+gWC2Ss9cbY8WOHcFi+2w5hBLEaKGzpgU3tghgnLdYOEdkbSnsMXQL89GWgCAeGtzwtZBWoI5vOzeAOy1nFHuag7kNTStwvEfDvBnb2I8ck0AXsEvlztR57TVobzORzTr0qsKDkI96LMkxpJT7VLA03G2LAWT1U1VfhKVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnSfq41C; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27d3540a43fso3230215ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 21:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762492479; x=1763097279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EXckxvr0vYaJfRakg7xejcSzoqy5VEAgGRFPyHXgVxQ=;
        b=HnSfq41CLTahIk5kp8BDreZbdURDM6OuuCDsv2Cf1TUYDdJmV/m2J1JJE9uA+4l04e
         GBG8/WEOAghLkfwXjpaSFOEeJW6ti4UdUcGKurb0PnO6AcD+8a7pYjwDEYGVD0G6VLoJ
         MmFaujU8Y300trDYhvjF7/wLFq8CsmTtRtjqYPUm682oZyJkSefyTk4ZhOAsE/JF7qeq
         +MaoAOSSnHi/dI5a05I0TFYagoVasxO1fZ/+u6i0nTLdAZ1zSY70K8xcnZPW+oFmjNl+
         cnw/ieaji2AUPkKChIzxnHYbphoOmlZkH6TJgSDX6AnRUDi1fjBuBgEy6WGDfk+oWAZV
         AbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762492479; x=1763097279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXckxvr0vYaJfRakg7xejcSzoqy5VEAgGRFPyHXgVxQ=;
        b=OdDBA1SaSD/2MOxGr4rLeNYoXs/E72W/oOjaQMpE2vbRPt6VdakgN7NHFXhsxhcQJt
         l1F5scHsSa1JdWS+PXsPOwW84Np/2DxkAAp/6DVL9q+TpF4a3Mvlqz/u3j8C0o7D9NkW
         gGGuyMdB64mDsLBXczkN7n7ESPpRw7HrBKexJwRpmNMg3qwACVYlpfVwS7ufOde43nYa
         W4lQ9lFaqyiT1ywAm2NnCDShZrwIguXOfC+tuLqM62eN37PZuBsbUlr289pAw9Gp2ZxJ
         LrT5RTzTf+mzJLyGIZYsIpK3mSIi+3GyG+KWvKnbtdyaoTnpq9ij3vVAcwMx0Q60+qkL
         yd1w==
X-Gm-Message-State: AOJu0YxpZPCztPHvOCUlTNRq3f9lkd0GrT7Ml3CkWsW7DNmc0Vf0flx0
	ucxXdTI3rhbHAwC1McsBLQoDCS3Esuwxr8oOhtpgttyiGyZWGM5O8LSc
X-Gm-Gg: ASbGnctiAGKi0xF13pETYxBuAK5Vh0SLMfDX7FdHFgWgNn1MR9Z6wHIba1CSN143mqT
	VUsk8WAYi8BLrDx7cb2tpd0IJ45LpyinpZWrShrUwspsPhkKXo5kXRHC2dzu8bdVFwgQBaApI6U
	2L8YWAx9dZIQel+JJBNphMCjn2hGnOLwvqlxYCTdWc4L5De5x5lJ5IQdFcLeI0x+pAz8p5j+HPN
	3UhewmlxEEsXYYh/fkwJnY0mJt0szhmGx3T/1CSq8EeIU42ZfwjNxuFOrOqplcDRaz5y1S3m300
	AxPhnWwlAuFxzWv2/rVqlxQURH4obhefiFqOnCpTN18qGweDP3AlgxOcNuNgR29jzLCde0YuCTK
	kv5LRcsQmTSwvmHHOlSF7yZd8YRsNWoYvYEodkIWHBgU4JvrE941BLjYNlK78W+ecQLPSLqA4uG
	I9MB5BXHCPRs0=
X-Google-Smtp-Source: AGHT+IH+frnSJQgDrVAXIYJKyu7mYXKAiPFwbWjawyyleHXAbYs2NV3FQSsq73qfRHjXOM8oDAMAIQ==
X-Received: by 2002:a17:902:c943:b0:290:91d2:9304 with SMTP id d9443c01a7336-297c03a5e59mr26729835ad.4.1762492479156;
        Thu, 06 Nov 2025 21:14:39 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2964f2a9716sm47872335ad.0.2025.11.06.21.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 21:14:37 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 1354842EFE93; Fri, 07 Nov 2025 12:14:29 +0700 (WIB)
Date: Fri, 7 Nov 2025 12:14:29 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>,
	Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH 2/2] iommupt: Describe @bitnr parameter
Message-ID: <aQ2ANX6V3F1qfKdE@archie.me>
References: <20251106073845.36445-1-bagasdotme@gmail.com>
 <20251106073845.36445-3-bagasdotme@gmail.com>
 <9dba0eb7-6f32-41b7-b70b-12379364585f@infradead.org>
 <20251107003541.GA1792527@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x3hfNvsCBYLDwZJH"
Content-Disposition: inline
In-Reply-To: <20251107003541.GA1792527@ziepe.ca>


--x3hfNvsCBYLDwZJH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2025 at 08:35:41PM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 06, 2025 at 03:48:10PM -0800, Randy Dunlap wrote:
> > > diff --git a/drivers/iommu/generic_pt/pt_common.h b/drivers/iommu/gen=
eric_pt/pt_common.h
> > > index b5628f47e0db40..54c16355be2842 100644
> > > --- a/drivers/iommu/generic_pt/pt_common.h
> > > +++ b/drivers/iommu/generic_pt/pt_common.h
> > > @@ -354,6 +354,7 @@ static inline unsigned int pt_max_sw_bit(struct p=
t_common *common);
> > >  /**
> > >   * pt_test_sw_bit_acquire() - Read a software bit in an item
> > >   * @pts: Entry to set
> > > + * @bitnr: Bit to set
> >=20
> > Shouldn't both of these (above) to "to read" instead of "to set"?
>=20
> Yes, that's right, Bagas could you fold that into a v2?

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--x3hfNvsCBYLDwZJH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQ2AMAAKCRD2uYlJVVFO
o07hAQCrjQK1FVbRPucfTlsUP3cQYw/+poMRTLSUUh6cilN7yAEArVh7GTezT4vr
RzS5LgwIZmkWSYMZpirFqHJfOD+03gA=
=3Jmb
-----END PGP SIGNATURE-----

--x3hfNvsCBYLDwZJH--

