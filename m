Return-Path: <linux-kernel+bounces-786797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558D8B36A46
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB21585745
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8D035AAA3;
	Tue, 26 Aug 2025 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="exxnCfz5"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F66343218
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218229; cv=none; b=fSLsEblAYMQilN3GNjQXrOCarDFWTnOH9eSEVtxZEGiGMa2/z4yMRUfz7+v2DkVC0lTsSAlWKTFHtapd0oxzY82UT4tCrU3UZGfdoSw9Ehq8wwMtKr0baiZHgG7JBsas7mHitswPvoYJS/16ZQlf13/L69jfxq1xN5uTjPqOpYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218229; c=relaxed/simple;
	bh=SD1Rkv0S6PHMLGByF520S77rRy4Hnx+nEEIQ7LpCzKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ilvbf6GmhSx4f7HXSh1LhtmKRa2VSjkiQeHPgh4wL4qtlb9Yt1J9dltzWrTi8zhm/c9pq34rj6fWe7ZuE9CXGzG8mBIFg7xs0dXsoljzjZCrGBT2MFV8ZQfjTgmbYA+7lqRg0AphJi+5Q1v3lCZeA3FOFxxQlyXEhaw8oGHPG7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=exxnCfz5; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3c763484ccdso1951149f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756218226; x=1756823026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SD1Rkv0S6PHMLGByF520S77rRy4Hnx+nEEIQ7LpCzKo=;
        b=exxnCfz5CRhh3zvyhNX+hb09Wkm+MFlJw174YJMBoBIxxzQ+vZU69RPyqA41VAalfO
         Q+X5R2ENXNBrYUmNmxKWTJSL89WylEOOclFn2XDB7kN80mrzqrZJ+lnBykh3Y+KLKIFF
         QZIHDNsF9CrpHn/mG9x1E0VTTFmvbR/ZHRuIaGQkJweX8cEdOZ/cFAtAUuYFO9ftCCgN
         plnwScVAcJP8KEmPPuiLJtRTPeX1ye0pCCgg4V9AKKk+chnkrJfQ3ph+ychUBVcPCIqX
         dhEZvZ3nyXAb6iVUSAEVVyzHUZZoqABzAE1L/4wTJVLWzKLAAD3wIno5XDLWjibg1Bpl
         v4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756218226; x=1756823026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SD1Rkv0S6PHMLGByF520S77rRy4Hnx+nEEIQ7LpCzKo=;
        b=OD76yYHJyt7GMNZQohrw8TbP52hzvtKKY5+ssrmzCOXxNMEfCv5Ac+beoez9msSz7g
         wOnnBDtLm+BHDcgukY0ziKM0Q3AZr1i0l7t5Hq/ZwHosGasiSGnGt5pzLBgssW7KA5Mr
         8mY57xUfPEKTNz//8mStbx0OOzgc3ebNNTIfFrNjbh5nOb0BCe+r8duOIAVGUNKnzL6A
         E5wdx2nnHbnhPfzrRLZUE+B+aFVNCVqlb1o3PVxt1Wu2q404F6XfeB7OFNmn8sb5jXX0
         9ZpU3v2KgDrl8P+QHf6ND0ViDS0vZjSu/da2emcpWy/78MkWnV0L0X4ZKPzuWfKHtDZH
         wkrw==
X-Forwarded-Encrypted: i=1; AJvYcCV7J9QOPV8thIuic0tQCX17/VCECJh2vvduMSbhX0gVTlsVTXOZUWvVbygoOR0qahGMV1RFGIxOhI24ux4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUVPSiaFKjyhPUejUPyKzifMOgMMV6y+voy6FLO+i4ROqWb4ph
	qNhAtAnECHbp42uvOGUq4KyvMGgB2SDCTbfS6Q6S9YFhPNxY2Feq/ljY+3Ikc2ei9LM=
X-Gm-Gg: ASbGnctegQN/K5qqYCxu47RcP6HStmnanHHul9OBHR5v4opW0jOiuTLeAgbDMJ9ISSN
	9a3i44D4sOT+A0IxZfz33zoc/GKG7ZVju1qdbtq6oJ7zOVNQfWdJog1CFB0Uu/CaDmYP2wL09vE
	c3ugjK/wx/JlbksbqGcFlyKhKytA5EufV7tcaoq6LdIi/e/TOd8+IXjA8EPGRIgAao7sp/79QEL
	141eb240u+CFx/W28NsQmripL46nJ4cqCXQO5yXqMqYAxMjP4vCOOGakZ3SU61Jovo9u1LDRkVU
	SX/jdFWNI3tD0hiGcYJJEXkBDvhe1Y8e/eX9Q4p5tYxggAxLC0FbYLRBcf89ga64YIqPxtUIkRo
	N+gseNJcPC4UZVxdOcg82VKz6esN2p1flnhLW0yMNuPw=
X-Google-Smtp-Source: AGHT+IHNbU375z1HM3iO0OTASldmwJtv+PMpWsx2AugmIMC46UnJiLI3kABi4oagejSfypZU/JGA8g==
X-Received: by 2002:a05:6000:4006:b0:3ca:2116:c38c with SMTP id ffacd0b85a97d-3cbb15ca336mr1713006f8f.2.1756218226148;
        Tue, 26 Aug 2025 07:23:46 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770402159aesm10800319b3a.82.2025.08.26.07.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 07:23:45 -0700 (PDT)
Date: Tue, 26 Aug 2025 16:23:35 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com, 
	chenridong@huawei.com
Subject: Re: [PATCH -next v5 3/3] cpuset: add helpers for cpus read and
 cpuset_mutex locks
Message-ID: <luegqrbloxpshm6niwre2ys3onurhttd5i3dudxbh4xzszo6bo@vqqxdtgrxxsm>
References: <20250825032352.1703602-1-chenridong@huaweicloud.com>
 <20250825032352.1703602-4-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7bzqvomqxrybdnkq"
Content-Disposition: inline
In-Reply-To: <20250825032352.1703602-4-chenridong@huaweicloud.com>


--7bzqvomqxrybdnkq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH -next v5 3/3] cpuset: add helpers for cpus read and
 cpuset_mutex locks
MIME-Version: 1.0

(I wrote this yesterday before merging but I'm still sending it to give
my opinion ;-))

On Mon, Aug 25, 2025 at 03:23:52AM +0000, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> From: Chen Ridong <chenridong@huawei.com>
>=20
> cpuset: add helpers for cpus_read_lock and cpuset_mutex locks.
>=20
> Replace repetitive locking patterns with new helpers:
> - cpuset_full_lock()
> - cpuset_full_unlock()

I don't see many precedents elsewhere in the kernel for such naming
(like _lock and _full_lock()). Wouldn't it be more illustrative to have
cpuset_read_lock() and cpuset_write_lock()? (As I'm looking at current
users and your accompanying comments which could be substituted with
the more conventional naming.)

(Also if you decide going this direction, please mention commit
111cd11bbc548 ("sched/cpuset: Bring back cpuset_mutex") in the message
so that it doesn't tempt to do further changes.)


> This makes the code cleaner and ensures consistent lock ordering.

Lock guards anyone? (When you're touching this and seeking clean code.)

Thanks,
Michal

--7bzqvomqxrybdnkq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaK3DZBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjaDgD7BWwhODnaF23DEYFz1AQE
g4NAFCp5eUn5EZgaV/iKRuQA/07xZOfgw3gsWo0zYipmhPX/dR80gfIZW2VRCQYP
RIEG
=raww
-----END PGP SIGNATURE-----

--7bzqvomqxrybdnkq--

