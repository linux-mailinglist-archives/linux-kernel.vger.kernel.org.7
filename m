Return-Path: <linux-kernel+bounces-730853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24349B04AF9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2DFC7AD513
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4604F54F81;
	Mon, 14 Jul 2025 22:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7aQ+YZF"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624DD37160
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 22:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533254; cv=none; b=qbgpdUfalvcLCZP/oWm5iXL8x4hAjpjD1Ve8PTmF+z0sxjnZGXptrDyzJmIllROzMf7J5ClxYIH4zz4Y872/6RloO4SjeXMbH0zswWrTrRO2va4GE8bqZkulm1zZs+sfRzBgrse/MWfiSlsJkuhFWgbnhMke7wmJ3JHWwPPXqXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533254; c=relaxed/simple;
	bh=c9CpT0STFiAFhDC+XiDIJVAH7qMjwEzOnnwaeMJVhJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mh0UCuoijxzcK6kIBb0SeqlZ4FZ4GzQDYkZucuei9RBX/eDnwfwtFNe9G0u9IQWhvm9e4RbIuqUEMYqDIZkhHvV7jQhqYnTvYF6ZEktLJkDHKuYZBupn53Y6hsNBNZdf9OT+hxezgs3+LyNMsokLc2e0lruAW+L98qMCZbbxfSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7aQ+YZF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-236470b2dceso42692075ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752533252; x=1753138052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c9CpT0STFiAFhDC+XiDIJVAH7qMjwEzOnnwaeMJVhJI=;
        b=N7aQ+YZF894fi5XPaqhPPd1jNH3wt4gbvtAOEU70c8kxVjcjmUDMwKlQMKtrUrTzlZ
         uZ6iPCtMBdvc6pQwcMyW5kedhZ0EGRRJsodkew7llidf5P5yNkWBu716yh1WmsselpXK
         TiBWR4E4HpsUq3w6kkdctaUSa7z6N4bB4i9x8kk6nC4BLy5Muv0Mqv6+8V7TEUr1ubVx
         bYX6KeSHRE4qpHEyHyHsRvfv16pt98MJ6Uqh2wg/jD8k5slyhbC8rujNrhxXyaZnxYDh
         OPCQ4fYor+shA6j5V6BbyF6kVl7PZ+7uWC5XSqIcq1dCTiKC0DvWh/kyUoZQcoR8bd72
         /sAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752533252; x=1753138052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9CpT0STFiAFhDC+XiDIJVAH7qMjwEzOnnwaeMJVhJI=;
        b=c/+ec4LdCOvbhdxxvZlUCwFOeHHJMHwigVM2cj+QiEZpwoWfh7R2E2BAlrml+B1Pro
         xf/kuzO1cg0pOypETVwunZFjIfc3Xy9oOXMp0HsS0AI+AFp4O/0W//hVIVylynOcIpL9
         lfSW8dg0KPG2sSot1c5AOXfG7SAxxOcEn9si1x9DxFDI3niu87wM4Z7VdBOZK5mfi4kr
         4RksLOK1HKLLpui7h3MPYvCXFEMFxthrR93eNeGMc1xn4v5xkemv6unGF7EySPF9LY1t
         k2tYlIBXGdAmbqdSs0PkmG6ozdYsiXtyLwMx4nB7whepsSt5mPM0c03GjeG0Wog0E1It
         rtkw==
X-Gm-Message-State: AOJu0Yy1j9o2DAxNRMKUg8e+PPysle5DyPjapSCIcCk5f+OLzqwpfV9s
	gBmreJerqGTnKp2YBIlzXv4+F1I04BygdNQRqtPTA2GVDeHA9IMSj0Yl
X-Gm-Gg: ASbGnctbeIjuQAvEaDVR1jKMKB7OFuqKN4xyA9bGcCDpDqiLdbyM/oy+3WZJlnc9gEi
	OZ/kcUdxB+guXaVgq2ei1XQQ59omoLblc8E819OyMJ53oF5Pz2QtXeu/22ewKhlumT04K7AgAaJ
	DTIse6kAto1xTx7HPliZqlxJ2yhpiV+3PzwX7W908H/mKT4TCmhKRhO9auelIbO8qaAdbLJh/A6
	C8W4syWcxwmQvJVnpBzSIQpdbvgGikDpdXvHkspcKrElhBiXDXgtKOppxhWP7BS7tRjUo36qqZ4
	bHpXy6th9iLhJdDWgWxr1NbnkOv+MmMZIM7Q9R/zTsNGGz+VFPhPis15HFBetWJDRkppG/cynl7
	D2wWdkxv1AAI+Y9FQT32Vfw==
X-Google-Smtp-Source: AGHT+IF1QFrqAeVptFxp5k5tGy6a7yZnAQZgsCGC+pj4sAAOV0mvgCE75ZzBFg7tGpV7WycgbpuUPA==
X-Received: by 2002:a17:902:fc4b:b0:234:b735:dca8 with SMTP id d9443c01a7336-23dee1888c5mr228225185ad.6.1752533251308;
        Mon, 14 Jul 2025 15:47:31 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4285ed6sm98304745ad.25.2025.07.14.15.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 15:47:29 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 93B8D4206884; Tue, 15 Jul 2025 05:47:27 +0700 (WIB)
Date: Tue, 15 Jul 2025 05:47:27 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux i3c <linux-i3c@lists.infradead.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2] i3c: Fix i3c_device_do_priv_xfers() kernel-doc
 indentation
Message-ID: <aHWI_wkGzKShpvhV@archie.me>
References: <20250702040424.18577-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6+xiQCy5g/20dcQa"
Content-Disposition: inline
In-Reply-To: <20250702040424.18577-1-bagasdotme@gmail.com>


--6+xiQCy5g/20dcQa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 02, 2025 at 11:04:24AM +0700, Bagas Sanjaya wrote:
> Sphinx reports indentation warning on i3c_device_do_priv_xfers() return
> value list:
>=20
> Documentation/driver-api/i3c/device-driver-api:9: ./drivers/i3c/device.c:=
31: ERROR: Unexpected indentation. [docutils]
>=20
> Format the list as bullet list to fix the warning.

review ping

--6+xiQCy5g/20dcQa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaHWI+gAKCRD2uYlJVVFO
o8k4AP9Xw9u3OioKxAPJ0mSNhnv7gvEWEO+gbnUxuu4fqVPnZwD/Sf+pvejdCXGz
M14IYlW8wQsPimdQae50dn51Zw2omwk=
=xLk8
-----END PGP SIGNATURE-----

--6+xiQCy5g/20dcQa--

