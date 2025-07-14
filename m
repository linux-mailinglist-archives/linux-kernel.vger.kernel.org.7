Return-Path: <linux-kernel+bounces-729958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA1CB03E42
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DC617D40E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7900B24FC09;
	Mon, 14 Jul 2025 12:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gElQJ69o"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F56024EF7F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494676; cv=none; b=HD2Xne5ZNdFaDAfCA/cnd6doCI46o9+SQKt3Aa2Vnaeitiom3dWh155kTvBZ1GIZYBDnxDMbdfSwcXeQlblAgZAM75n1PY2e18YpgNFGgIU5UEsDygBg1wusW/i7apS/ku9qN2R83BeseAoT1bnHOJV4Z+pIIyH/o54x1u0ADTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494676; c=relaxed/simple;
	bh=CBjLuItx33Qfi8z32IrHmB0TWEC92B60Q29ghyqTY00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlHF21LTCYpFQ6A0ArqiKk5yfu9UejiadJzxZkjTtjhuoX4AkkUZXg1u+q1+H7mFLh2JysjkDDrvAmB2kAYtupbB+rMovViKF+JjRp/XCd5V8mI9n5XnqnFY/l73oDWXflQtbaV5zxbaEAJWKvd2gP0ylOI91kMcH1vM7wzMZIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gElQJ69o; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-553b5165cf5so5181108e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 05:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752494673; x=1753099473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CBjLuItx33Qfi8z32IrHmB0TWEC92B60Q29ghyqTY00=;
        b=gElQJ69oD/rRWF3o4NGV6yEySs6VxciAAIayh0eTKoLnlpNFFvihtcd9f1WQzLkY3R
         PY+VOutUEzDrN0SMN9s+GqQ9a1USNB1TEKRK0QGuKSOV1Lp9X+/YBZ/cAe0jBebLLj79
         UDWXlrqmaAlAoEAbe7/3ITPlP1o0bEBUHbTL1ejvH6xK5IC5qQewpD0s2GoSOSIl9Ntt
         po820r1jNRIzSUBT3Cxzv3VxZoz+FP+WAyYyLf9mllGvW/qUMcrolTA7LIVvJeuO3Wk6
         w4Tqk2OfJiFaVm3u3WkPKM08UY5HclCD6n/Ag75UsAP3rqG8BnI1Kg82syLYh5lTvTP9
         STyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752494673; x=1753099473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBjLuItx33Qfi8z32IrHmB0TWEC92B60Q29ghyqTY00=;
        b=KLM5IwTav9qolhO04HyM3DG/UWcDZuVRDygBRXS/GtaBa3ci8qul8bp/kgTPsVo5XJ
         nIODtwVbU9EbrYydltZqzXyFeDhmGNcsznkdQAf5ODpRzK1VDmsXNGhU0kKnal+vRCVY
         Mqencq2pdhdEQKFs30YE1FWwQmQMtV1/HNKHXYRMaCGjo2TMkjlerp2swqv3xmiV/JIn
         naJhduXfD0vNenBKWbNN5It3dc0GHbiYxjY1Zm0Lkv7d8hl5jf0B93PFCgRwedjcVgql
         9+IcnV1PbsQ0WT2pi42fYqXNC/Kia9RMrpIvrmKqQgLS4qGX7gnR8MnEn286s1xqGLl4
         lbBQ==
X-Gm-Message-State: AOJu0YxjPp6ljAtag9Xh+KhQJvPtCUHNHNbfMi5Py4CG6VJXddzbeZU1
	ZuxwDKY5MlgwMwoxS8jnRrnvrWOJH/nxgnCOMA3u4NxZHyEZJvC35PXrRB1tafSxmkc=
X-Gm-Gg: ASbGncvf/4no84hDK6flQobPjOznhwk03cMQBvnxS2kYYHlkoFa5mVQIuIWi4TS5zPj
	EBb7JINHM2N48cHOKFKwEmeex/M51G8nHGwOnMRWNfihLmgkYP0S/vbwCEHzh4CRSPsycf2p6t2
	fiQeLQDGqksX+O9na/1G3DhA52WxdIv26FIjlr+p5j+Wojk+ZAzYeXNIpmbqMIxFYzKFQHyyRsE
	h+kp97wY5WlqiESzYRK09r3O0g8BcxGlwBziuKBQtykjXAK8w0DFZFlbE4GcjbIoL7aZsIQ5T2P
	FaLr/jsfSBJhw4aDz5plogvoXzD4/pndb1YT02LoQ6P0G96zqGMLW611Aqm9uIA0/uHAEsIt5me
	PqSbRYBMnQfkNaBhxnY7Z+/Oo7ITIf4nlHzKqpPeIuvwAC1Pu2vJsqx9ZlNE=
X-Google-Smtp-Source: AGHT+IFJdEdKVEj7RQIXyvRSvRfuUu9Ds5/AeKDwjQhJnrZ6iAzLBOj2g9OC4r83KdUdjkxZoP6hlA==
X-Received: by 2002:a05:6512:1243:b0:553:cfa8:dd38 with SMTP id 2adb3069b0e04-55a05864462mr3396855e87.36.1752494672821;
        Mon, 14 Jul 2025 05:04:32 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b6bb3esm1945786e87.177.2025.07.14.05.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 05:04:32 -0700 (PDT)
Date: Mon, 14 Jul 2025 14:04:30 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, ipedrosa@redhat.com,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/5] drm/sitronix/st7571-i2c: Log probe deferral cause
 for GPIO get failure
Message-ID: <aHTyTsFuakcQsEm7@gmail.com>
References: <20250714104421.323753-1-javierm@redhat.com>
 <20250714104421.323753-3-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6qAGav6rfCaU7+GE"
Content-Disposition: inline
In-Reply-To: <20250714104421.323753-3-javierm@redhat.com>


--6qAGav6rfCaU7+GE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 12:44:01PM +0200, Javier Martinez Canillas wrote:
> The driver already uses the dev_err_probe() helper (that only prints error
> messages for the -EPROBE_DEFER case) when fails to get any other resource.
>=20
> Also do the same when it fails to obtain the rest GPIO.
reset GPIO
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>

--6qAGav6rfCaU7+GE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmh08kgACgkQiIBOb1ld
UjJmDhAAmMCv8Sip9jCsBWQAquCXjyAm/VndN0wHUU0cDGLbeGTBFzOL2N6rJk0s
BSJYlQmvY3NHI5Z2Cnjvb8k7v7ZwVbQvXz/kIHxjA3qu36qhb5iefa0xh5wLwLTl
s2c8Zynb2jxucf05++gzF4IeSuY8K7EWjWFo0LLR1MU71XYdWkKteYRWlMVyT/AU
1Lgp8t0068QYVthOC9Xz8FtgMU+2Q1wNhBpZpL3R3ecp06tl1XqFiiw+8GmRLkav
AF9kr+FNh4WaYyhZ9OjSN9pcHuhsZpRrl8wvyU6Up68dVsgorEHVwHddZK0UhQU3
5YbpEKr1HPS5wstqrblPvG/sL5PjYF6/LltQEtTNLT3w3qqUiMbFvhPxSERopQ3N
3PiZ4KpE+cdx3bf+Jyrcw/kzMhzzYLH9TCMEDgNerxCAXlcFNRSMeXMSRFMdVW89
v5WVoloz5vD5oCC8sQQCHF1TLr3cbzZOUGLxGp1pSSSGAFsCeJPPqg9FuyrHQsOI
c7uzDqUU86hBh5/0TVhJywhtQwgz+Nj8ec1pcqJdgePz+uM+J0HAdoth9UMMI1u1
dB8/RJqOjB8jLP+TicWzQ7DS+YGt5V1bzi/kAMpWjHTR/3cxxUVrVQNXbjFmxXuS
OKaSpf4ecbHV71YSAyyWY/OT0aX8MzSB0x6ttRwgWcsJNzdsL6M=
=G5Vt
-----END PGP SIGNATURE-----

--6qAGav6rfCaU7+GE--

