Return-Path: <linux-kernel+bounces-868443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B4CC053BB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751863BB8B6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72CB30748C;
	Fri, 24 Oct 2025 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/qMu8ua"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F602F8BF7
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761296047; cv=none; b=Sw+ov2+P/sR6g/6cHZ0J2nhtQLwdS7gP0s/L3pmgLBXPEAYcjekVjDgpvwbgosFx4/msBvBKbaWSo5SwVgnaWH2FvCxiB3CuxHk/HgQoXq2W5MU77FrMhBvni8306zyvbJzubI0yBlLTJHXIa4dUO+XzvBNKwhU1RAXJvGJLKdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761296047; c=relaxed/simple;
	bh=P3MLsYlhev32niodkLimulflCEkVp2TTq9i5fp+U6/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmCy1rmMYer06inaNPx/JOPuyqVQ1EgoxCNtKkZ3nHud/34gWMnp9QyxDIc5R4WcpYwezWywu2oNxLQZiIQhPbPBxMLj1wg0X9g9wG3TvZ3/piOFnGpiqottLIQtyuN2gDqKvW/X0FiB+aG/W2f6rFC4MvPxzACkPkepKncTff4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/qMu8ua; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b5a8184144dso287016666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761296043; x=1761900843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l23pZA4MExPiJTUB2SAni5gcYgsT0Y++tSC//ed3phQ=;
        b=H/qMu8uaa5ar6tvG/NPRg28X4LDHsTtIgvniwkwOLMzUzvBuR2PjoCtub49aaBYhjx
         lM8syt2ZFjiHg+peMAuoM91Idm8bgoBp+TgirfrX/xiagh/NkJBl46L8UYb2S+AA/qpM
         0/ELJ6ZYczgTXxIbA/SPYglOul8KNKIX6P2226ejiOIiOpv28Hv7mWOarbe5XhTmZz5K
         fxAwrozI43Kq4zEUYOR2s89v8oP09IGMTbBVwQTCMZ6FQKK0X1WXW2VAykZNx4JTuV5/
         /cHa3nkDA2K0jERXuJBeRdbZJIGf7VT8hmoXNUukJMRdyHXzx6Tqjyn+XffKC1oBRX65
         1W+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761296043; x=1761900843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l23pZA4MExPiJTUB2SAni5gcYgsT0Y++tSC//ed3phQ=;
        b=pJw0aO1ilWTyZqxqM21vaNftV+PAGmm6JAfsCjq718kt7Nwz7VGdUgp7IFmj2LT8pZ
         +kv8bRjW7msEOkE6DzS3kHwEsCteBSkBcVmKNnx0kN68U0PUnhDOd2qemnU9p3TbBGqP
         uhf8BN416fqx5GWj4dkG4Wz3R2N8q7mOHp5u/BIBJNnx15SL4KbljPhjNbCCz0ONs9SQ
         EBhrgSUtNk1XdblhN/YCbLzSxWrdkNAJtV6cjP9nmZHxedaltH0B6nqsjp/Mls3rMR1T
         9aWRxfvfh440SeMCkVPWQ346LiohVxMPiH6tN9BltM3WDqYk0SDrEgFgHgtLjDOT/u5N
         0SOw==
X-Forwarded-Encrypted: i=1; AJvYcCWsAjt6b2FqaqY9arBwjquZzSra/Rs4iNSRmhxRDVNK955J27xvT5Qekpa5803GKMo9bmQfRWWTD6Uu268=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9JFfo/kRizwY9Qx0zosLULcojYIqE4f5Gs3R4NT1O04k6bHgg
	VlcPdWKzpRka+H8ZedPBJvaHeF0fiI0B2VzkzwDBHo3d8Pd/lzjAsE87
X-Gm-Gg: ASbGncvTBVonI5Vwt5IAiPacBRZjq9Xi71I2DAGvHrPEjgdca6ujyRtfU83awOo9SFE
	HEiqtKHS++NuqdGO3fSNGBBdKl+TE9Hg1qTLggWXSn5aAl7vBlFpHjHdofq5pJnYOaV6BgS+rMr
	hElzgzHiwySuSsLCClC42NeIIKNNn+upuwlnnXnu2e1RjR+8rvRru/iXW8Sw3bazh8a/8miTrUY
	anf5kUR/Cw/3yyfAV/5tkJ9fRJ7IinoKari+zuOLGa4h0aj+2R8h8JMZ3014A6JU7lqUNtp6dmH
	xlAswhHzyBgSx3ztm1Xi1Z4ouakR3lC+/wAS4qe8aZfoqG6CWTOGdGyexwFSEqM2tYmEhL9LEIM
	tUBeEI6nR6zAlzP5rdTJxFd0ieC1TKvzcHLcgUzyZMzoydKhMTRTiKoklq/Lzhksmok0lnDRmHi
	v2Uj8al74V7D8=
X-Google-Smtp-Source: AGHT+IG51f1FpuK/7izLWH/o5CbZofEfDgwdIaDaNy8TUmUIchs6Y2k+6E/W+IMWdugb6vY2wZ04BA==
X-Received: by 2002:a17:907:3f21:b0:b6d:6a44:5fd9 with SMTP id a640c23a62f3a-b6d6ffe1c8emr161940266b.48.1761296043130;
        Fri, 24 Oct 2025 01:54:03 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d51472215sm461035266b.74.2025.10.24.01.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 01:54:01 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 168394206924; Fri, 24 Oct 2025 15:53:53 +0700 (WIB)
Date: Fri, 24 Oct 2025 15:53:53 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Biancaa Ramesh <biancaa2210329@ssn.edu.in>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] spell check: Edited spelling errors
Message-ID: <aPs-oaYxarodr7fg@archie.me>
References: <20251021173614.48249-1-biancaa2210329@ssn.edu.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qr8t8CYE95nUS9XB"
Content-Disposition: inline
In-Reply-To: <20251021173614.48249-1-biancaa2210329@ssn.edu.in>


--Qr8t8CYE95nUS9XB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 11:06:13PM +0530, Biancaa Ramesh wrote:
> Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>

As others have pointed out in all your previous patches: make sure to descr=
ibe
your changes (in imperative mood) along with appropriate one-line patch tit=
le;
and most importantly: don't add any confidentality disclaimers.

> ---
>  mm/hugetlb.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 795ee393eac0..1760fa39a3af 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2934,7 +2934,7 @@ typedef enum {
>  	 * NOTE: This is mostly identical to MAP_CHG_NEEDED, except
>  	 * that currently vma_needs_reservation() has an unwanted side
>  	 * effect to either use end() or commit() to complete the
> -	 * transaction.	 Hence it needs to differenciate from NEEDED.
> +	 * transaction.	 Hence it needs to differentiate from NEEDED.
>  	 */
>  	MAP_CHG_ENFORCED =3D 2,
>  } map_chg_state;
> @@ -5983,7 +5983,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb,=
 struct vm_area_struct *vma,
>  			int rc =3D vma_needs_reservation(h, vma, address);
> =20
>  			if (rc < 0)
> -				/* Pressumably allocate_file_region_entries failed
> +				/* Presumably allocate_file_region_entries failed
>  				 * to allocate a file_region struct. Clear
>  				 * hugetlb_restore_reserve so that global reserve
>  				 * count will not be incremented by free_huge_folio.
> @@ -6007,7 +6007,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb,=
 struct vm_area_struct *vma,
>  	/*
>  	 * If we unshared PMDs, the TLB flush was not recorded in mmu_gather. We
>  	 * could defer the flush until now, since by holding i_mmap_rwsem we
> -	 * guaranteed that the last refernece would not be dropped. But we must
> +	 * guaranteed that the last reference would not be dropped. But we must
>  	 * do the flushing before we return, as otherwise i_mmap_rwsem will be
>  	 * dropped and the last reference to the shared PMDs page might be
>  	 * dropped as well.
> @@ -6211,7 +6211,7 @@ static vm_fault_t hugetlb_wp(struct vm_fault *vmf)
>  	 * In order to determine where this is a COW on a MAP_PRIVATE mapping it
>  	 * is enough to check whether the old_folio is anonymous. This means th=
at
>  	 * the reserve for this address was consumed. If reserves were used, a
> -	 * partial faulted mapping at the fime of fork() could consume its rese=
rves
> +	 * partial faulted mapping at the time of fork() could consume its rese=
rves
>  	 * on COW instead of the full address range.
>  	 */
>  	if (is_vma_resv_set(vma, HPAGE_RESV_OWNER) &&
> @@ -7193,7 +7193,7 @@ long hugetlb_change_protection(struct vm_area_struc=
t *vma,
>  		} else if (unlikely(is_pte_marker(pte))) {
>  			/*
>  			 * Do nothing on a poison marker; page is
> -			 * corrupted, permissons do not apply.  Here
> +			 * corrupted, permissions do not apply.  Here
>  			 * pte_marker_uffd_wp()=3D=3Dtrue implies !poison
>  			 * because they're mutual exclusive.
>  			 */

The wording itself LGTM, though.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Qr8t8CYE95nUS9XB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPs+lgAKCRD2uYlJVVFO
o0JLAQDZSp866h7184IdH9rd+xrIuOZv7tLHoHkMYaBJHTQTHAD/aBgrlv9lzDzO
mxhy6eDkdKH41KYOFwRD7tJQNElKfQo=
=Je8M
-----END PGP SIGNATURE-----

--Qr8t8CYE95nUS9XB--

