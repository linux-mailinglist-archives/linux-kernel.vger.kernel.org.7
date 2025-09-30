Return-Path: <linux-kernel+bounces-837136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC134BAB7EF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 523907A7807
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA422765ED;
	Tue, 30 Sep 2025 05:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhfQs+Vb"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271432765CE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759210251; cv=none; b=A+VRmB3sebPqawQRsrKI2x54Gv+ggFIIV2IeHkKxZxXtR2NLdPkCfC5xcER6C4W6nwzYWHZ3jRtcQ8VtmI8s4F08qsLePqSnIhbAVi9G/3p37iJgZfR5LIO+PjdhhUY3DQKAl5JMXiKyGheSQcUmUmvROezEhUmp/1ncGiEFPmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759210251; c=relaxed/simple;
	bh=kJbqLTiMm5n5re5QK5W+OP5gnoACwklUKd76CdRrlyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfDbAZNMHibKG0OJx0MWeUPVjnH3SAoVXhJK6/T++B1mZq4Vip9tgveUpxO+ucQwfufVRg6/r8HkI+SueHUUtHCyy/Z5xBFz/6ArdTZfkbqUsPhTvwu8VlqVLSFoUxZ/VGe91QBZ0A4l6FdecNj1wdf9qx2v1oxuTlVrOYwetMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhfQs+Vb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2570bf605b1so59401555ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759210249; x=1759815049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kJbqLTiMm5n5re5QK5W+OP5gnoACwklUKd76CdRrlyk=;
        b=MhfQs+Vb1YmkmBFRvuBGmrzR7QjTt/S0ppwkiGaHR/bNv2vQvYjAy+Ls/sRJZzUozD
         yU/HwajVP6mLUcNVXq0R7+OQB8jscL9Wf9LHu+PzXgPO9pyEXnaXSud8P1NWVpL1Nzy7
         0s2Onsxw/aPXfAS0ZvrNUsQtA5wX0I8dqXKwGwKPtkoU1IRrBOvXYKPje74ecLT4DqET
         a5Q4b5LjnCZaz7NxFH2WzN4ZktEAL3qxIBKpwIBC7e/MT4i3gL+xxuevB9xBxKeNbnqG
         EfUI0rbrWrUnc5V07zLasQNEMCXHk1WbdVPKZqMCJ8tKEqhU7HHMv/8GJQSf1b7ILEus
         7lhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759210249; x=1759815049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJbqLTiMm5n5re5QK5W+OP5gnoACwklUKd76CdRrlyk=;
        b=akmiHS+qFsXkUGCUQeaYUTh4SBFcWUoTQFRCG0njrCQlgO9vVCr4UQtmBWD3vuUWrQ
         Ezl9Xv0yeGmiHcwdnqgdw+/9McB6xkwqkY51N/f29o0EnThycLxA3mOnV3rbzGF0aGcG
         CHF2B5kVG+wFpijFFM8zA0YKxKb1JwHHja1+iNZL466YMhEHXvVRYfLUVdhzXwZD2HCQ
         gsooYPMSDqwPnHTBwe9bH8rpsyBFxd/wMSG9Z80faLVc98xQuzREil0tc4XU76gQUI/A
         RH0IbUKI0Bx30fGUZ1sMysK3zbUcSvjowKUcPOCl5Hsp8LzHaIZUJtprL0jKIaim7XFO
         zZVw==
X-Forwarded-Encrypted: i=1; AJvYcCV3p9D8utPCwx19EqWE16dkRV+JhJkeSwfEjrqESkHms9fMe89Mbj71Nk3m1lbdpZ/sALYq2BO/BivkGOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7n08yacDSHbgoV4uJrJX1aPLXf6rYgCGAmKF0sCiCcKgfhTNM
	+nE/TwBo0Cj5hruGRnv5MqU4nGNMpOi84T+9Z21xPZcAuxD6ySf2sbDp
X-Gm-Gg: ASbGncvw7q9lac05xzjNmTapPbPaDHp/cSCHdMWLrULbNuipshSEJo236cW231qEAX7
	p4xbUo6SMfN0d7rGuDVqZXecYj38/Usz/7SJl1wUUwbSUcj7sKju6xEv2Us8d/PRSWc4wKRQSC5
	kvLXJExp3as0kFvQlxD65lYdkZBJnnW+NUf7JDHas9D02RGu8WuL8vyXcogzr94Fe+dQUSNfnry
	pvCQ31p8ZF1bFnnzZYa/cSy3XRVeZHGgEbx8jx7AiWEOwZtQLqxJV8ShhxgR2HLlctAjOXw+uJ/
	oR1yqjTDfmpbU6Sg11jW0wlKhCY23cHsgeZ81AjGZmBYVoNE3+7Ood7mMqh9KAW9sCKjCW2Ya+R
	PrPXkHBOgqfSycZj5kWU6HB1tUNJk2dmr7Bw70yIWAo+jgb3GLn1DZEdSDjfX
X-Google-Smtp-Source: AGHT+IFH0qFdbXtToX9fXo/RIjy+qv5QY1o56wuNcKsmdGzJWcBq+mdk2EFwSV8jJXEVGNLFeuik1w==
X-Received: by 2002:a17:903:3884:b0:282:ee0e:5991 with SMTP id d9443c01a7336-282ee1da05amr90374515ad.30.1759210249140;
        Mon, 29 Sep 2025 22:30:49 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d43c4sm150130985ad.17.2025.09.29.22.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 22:30:47 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D887140220BF; Tue, 30 Sep 2025 12:30:44 +0700 (WIB)
Date: Tue, 30 Sep 2025 12:30:44 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Koichi Okuno <fj2767dz@fujitsu.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Will Deacon <will@kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com
Subject: Re: [PATCH v1] Documentation/admin-guide/perf: Fix indentation and
 formatting in fujitsu_uncore_pmu.rst
Message-ID: <aNtrBM-ta2YGDp4t@archie.me>
References: <20250930100742.4741-1-swarajgaikwad1925@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cMSAwhz+Sv4CEa3d"
Content-Disposition: inline
In-Reply-To: <20250930100742.4741-1-swarajgaikwad1925@gmail.com>


--cMSAwhz+Sv4CEa3d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 10:07:36AM +0000, Swaraj Gaikwad wrote:
> This patch fixes several reStructuredText (RST) formatting issues in
> documentation/admin-guide/perf/fujitsu_uncore_pmu.rst that were causing
> Sphinx build warnings and errors. Specifically:
>=20
> - Unexpected indentation in bullet lists.
> - Block-quote unindents that broke literal blocks.
> - Missing blank lines between paragraphs and lists.

Already fixed by [1].

Thanks.

[1]: https://lore.kernel.org/lkml/20250926043748.3785-1-krishnagopi487@gmai=
l.com/

--=20
An old man doll... just what I always wanted! - Clara

--cMSAwhz+Sv4CEa3d
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaNtq/gAKCRD2uYlJVVFO
oz60AP97XF6CvLqd4PNXGjdCTmfDaUUqBNMnJAzw/BJi2efbOQEAnNY+kFcwa4rh
HBtD9ufl1ONXIwYHfhbAR8Is9Fb4dg8=
=CBP8
-----END PGP SIGNATURE-----

--cMSAwhz+Sv4CEa3d--

