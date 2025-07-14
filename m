Return-Path: <linux-kernel+bounces-729966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3898EB03E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18A14A5D25
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1AC248894;
	Mon, 14 Jul 2025 12:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwGT3AUF"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8367D243964
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494889; cv=none; b=CQwXmbejBL3/koJvsqDNa3RXc3BvTCE3Kf6xizxS0nM4vaDVYdEktCDbSjhxW6rUpyN211y3USdWM69EXFcFGpAs6qYe5l/1iK0hb1q1HXjI2iL6yrrZ+0sTt/iCgwRzfua7cNx/Wkseqw9L0kZXky3QTYwhWTQOpHrBhoJ4xuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494889; c=relaxed/simple;
	bh=rrTQ1/piU5c3HlEkqsvmHmiT+sRyPTggNbv96TDoEuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sve5eJhjCUCA9rsbWMFC6NLFtMryunGIjVBkY18/mroj0FMjZ9NYJu/LsHwqY/gAelWtyQQ6hc21d4n2lX7AbaXgE35TcKihTpSpcosjg01ZUKSqzdoaLisnErao0azyaeevxUPU5Pk8AgPUsB0DPQ4IBoBtZLxEPtzZYQzLnjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwGT3AUF; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553e5df44f8so3855517e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 05:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752494885; x=1753099685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rrTQ1/piU5c3HlEkqsvmHmiT+sRyPTggNbv96TDoEuE=;
        b=RwGT3AUFzM4YVtUzfFv/wppJHSfTBCSRMu3SeIBSPBsDX4kRDv0vV8mugXNVzIToU0
         bphCsn6oHSCmETiCZKWvBX3n+e4TizZ+9C5E2ZGPZqTAG42VZAFE+hxLjSRlZbMW5Net
         ApT62H4CkqVAh/Ic5s8DH6Zg1Lw+rmeOkTvhOkgXtEMyGrBi7xJgmpKNOHUfCD3vdux2
         DUOQLzW6yuR2JzeWBeGmZLoXv3wkdv+4+sN+SBJgr3/Z5MA+ZtgujTeTQU5WbusLbi9I
         FTDFR5rk9eMp7Jjv4duxw7mvnIaXpW/Db1mXTPesHlxo6874ijF7MJYvy8F7W3gwIBZr
         dc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752494885; x=1753099685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrTQ1/piU5c3HlEkqsvmHmiT+sRyPTggNbv96TDoEuE=;
        b=eAD4xn7iY5mZtyJTo09/c+Kzq6TF6EWgQR/U4bVcAxy0aSE3vZ1lJCWGzJ/FC2jI6r
         HdTowQwlk1DQvqcJEg+kskKJ3+GXNYLWjxvs1MYCaXK/YhF9qnzBrjqAyMStiptz/CCe
         Ny5r89gpCgjlp8J945hb7H2jOInHC0m3CJCVmoF1zKSpCETtS8bcucxB9a8CP0oQcyj4
         yilCtCW98BC6K3yHnSnoD/cZgKfpUpYxyxbrwjVYmmuQ0Rn6duUfnZpwHBluiZj7BVLK
         kyCX/ErumISrTekXcZJJuOErmRz2I2X6/OOoWMkk79dnGE51n5SXFWjLdRHGM9+QcSD2
         xjpw==
X-Gm-Message-State: AOJu0Yxy6/0+eQ16BVVd63BJ2d5eQw+kqxVxi+QmDgbjpEsW4SEiqKOx
	Wiof6mFjIUBCeTfqz7a+x4cQSxihs7OlSto1QrilC7N77b86lUiGpNrQ
X-Gm-Gg: ASbGncu/au4w0F157UifvBhNql2O3xYjkzSDsFuVMx9r6NYA32ggm/r81w7c7odIbvg
	9HdnLd1aWprTZVEyb2BmxvE73XamZibO/SeSRMzRowBaIAENFlQMrOXLfXaP87687gAzgnTUmrv
	XVya+YcWb6PM1lrXgmwvRvEZ9z59dKiqOgEkJMVtxPrywJLJe2N3q8aN10jkWOeUbY3PLm75ztc
	CvCJcXQLl1ndkSCyMsXVNkjsvxbnOFcDXtd44+/qA+oyhZ3DlYKaLOEEgIpPMj1PfJmuvpcHTA7
	2nPS+BlMeyznO+NqM9lfMNrDjj76fkctks9av3AOj1ElyvhCaSR5NZ0SwJVfqzYh6PUqEt/YtUI
	aqmVGEQz1w3rnXfRAg4EfPHVuX2u10Nj1C0zPVQrKkN/JOAeJqBV7ngYk9UJsnCHQgtP/Bw==
X-Google-Smtp-Source: AGHT+IEzEQDT9SlcMJXRWaUpVIthbB3FTkJ0mV934wHqVQgkTP67sY6GyOX+sERvMFkML4JM1C6sHw==
X-Received: by 2002:a05:651c:419c:b0:32a:81a2:ebb with SMTP id 38308e7fff4ca-33053293410mr34114811fa.1.1752494885131;
        Mon, 14 Jul 2025 05:08:05 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa29133fcsm15060511fa.3.2025.07.14.05.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 05:08:03 -0700 (PDT)
Date: Mon, 14 Jul 2025 14:08:01 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, ipedrosa@redhat.com,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 3/5] drm/sitronix/st7571-i2c: Add an indirection level
 to parse DT
Message-ID: <aHTzIcxe3Z_j62-X@gmail.com>
References: <20250714104421.323753-1-javierm@redhat.com>
 <20250714104421.323753-4-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4ZunG6Sz0bu+w/YO"
Content-Disposition: inline
In-Reply-To: <20250714104421.323753-4-javierm@redhat.com>


--4ZunG6Sz0bu+w/YO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 12:44:02PM +0200, Javier Martinez Canillas wrote:
> Other Sitronix display controllers might need a different parsing DT
> logic, so lets add a .parse_dt callback to struct st7571_panel_data.
>=20
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>

--4ZunG6Sz0bu+w/YO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmh08xwACgkQiIBOb1ld
UjI3nA/6AhbJzYc14e2kj9qjpjhvgbOUHXl7QmMsJ3Abc63kZe2h1CSouL1ma1on
xVhcpVZTmWnhAi9mtFNdUZ4oaDkUvEuEQDMPC4Ky+nRIl8UIC8MIwH2YGOvv9Nhk
LT9+UmcK0fQSlDGxtTI8v2LHoBMjaJQYYKwrOBO4khDEA8S4nYLnUxF0fVvnbuMJ
SqOLd22GDJMHjGZHPM1a99EAOQDjLS0JYRORQOOljvtKv0bdDpB68TNY+1djaC2D
V13Rl3AXJkBwsQ2QdCKyB9QBdF8fLCh3c2F5OtintxgANurwtM6mTqc71eDuvTA0
yV0yO2APTKZwFBx491C4xqUjjEOxLD3aGErbe8z3czqQ32q0dyDh6WdNSuAX0VGo
l/A0pmxaKCNKZo6Le/DDcaWYWlC42x9FnCIcd7U3J7wZLRGph82bzHiSQizivnX1
AoiZZsro2hAEoxD9rjRxibtuyeSF6H23MTpsey8UP7S6N8P39EE7VeftBp07l/+e
MpX6ZmVf5L8avvtbrT9RKNdcl5LZhA16isAqhGL0/N5tIYgi2kiJD7Kfb14doi38
izpVE+91wWPEXRDc2lxMjAC2pewKB6CwJ0KJRPya7v6/zzMfcApq39fObws9RX+i
q5CM8xY6CGvs2KeF5kVLB3BunhtDMwuI2ZlfvL3/KSZz35EOwyw=
=JGEU
-----END PGP SIGNATURE-----

--4ZunG6Sz0bu+w/YO--

