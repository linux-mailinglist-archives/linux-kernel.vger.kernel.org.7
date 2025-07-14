Return-Path: <linux-kernel+bounces-729965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F7CB03E59
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715E417D84B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C39256C70;
	Mon, 14 Jul 2025 12:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5CFBMQ7"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA217248861
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494820; cv=none; b=dwSVCulUKNpRDEPPt7RYbFfEYvq7ErM3VfuOksH5L77ocm2f5lZYwrzUr/Sq0uO8J33gfg4qBIBJzDIusNnzEtsE9xLUzJtFbVcTn7xD4YNB0cP+0OY4bY9Lc05WeB1W5rXkuit6QOoDG5KbvNmYUUHfxbLuv9kAMwciUg0QYZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494820; c=relaxed/simple;
	bh=btwac0BtZLdtrMNOqtTVqB8u6VGbkgwcCfy4SiDo2nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKzPNe538BHh3nuHwXbjIlVByR7AkBuQ7VGL9C7j+RBNdSK6MoNBppAyvHQEUTuR+rPavkBs4kJ1XU+nJDWOJH7fg9aae54lJ4lpNwOn2MmMXCNIDzRHf2bQM0i4NPd1AqXxpbrOZyiu77ATcndRKLS/X0/L+J0QPzSQcbdSuQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5CFBMQ7; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54b10594812so4158159e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 05:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752494817; x=1753099617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=btwac0BtZLdtrMNOqtTVqB8u6VGbkgwcCfy4SiDo2nY=;
        b=F5CFBMQ7soCI1yGNFYexW/9kgrRAF8f/71NxV2OUT1WiaBTciVRDFqb/uvXEIGmbCX
         tqqKAYTFHnhKE0HPrUfPE9Qkm40TSVqVOuYS2d+/+bilFjiRLoZkKNfUQLvV8Ut9b4ON
         wWqzoc7ZBo9GDr48qi0Apo7nMP6cxSLwMQThRGoaSD7OEnj3OjjhTTUKJaZASLLEuJ5p
         eJi9bPo13niVv50liJRW0bcCkUdMpPx3wdQNgJoL6muF5+AryWZJFy9FyBVHVtFRKQiY
         HwibuWFtO59rZtvkG1tnhmN4R24ELZMQrEkPuS2g2JM8BTiVSw+AUHGtyEVLb2M/dzIq
         9coQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752494817; x=1753099617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btwac0BtZLdtrMNOqtTVqB8u6VGbkgwcCfy4SiDo2nY=;
        b=q9iv1QQbguaXVpC/AhVnz6hilFU0+YZALShMqF7TT/TuHdEVlZGenxyedgLNHBKqSy
         H1ROuRwUjeavhs2BRJPtvJmxmxEbYDDu+J7JtpNYOQlcewCXbSD+Hqw4OXz6wpbT2usM
         Co+mUzpsNuz7dwrjy3zfElbTATd96vA/gfuMxbR9XjCtSbNmjk19QeFx8bfkxXsk+xd8
         XbUPEQv5cWpx9g0FBShRgjC7d8/KVkYn8t+IVZJ3z+Mxli4A1IITR93p4BcsM2sGwN10
         G4bb0dusRH27P4hxgiczyRpaNZXeO/BREKIevhQZjl4CvjHHDM03Aza9H8YWmzutPWl0
         6yKg==
X-Gm-Message-State: AOJu0Ywh9wXqK8cIyWJcFIKD82Ukoz7upZejllj02RiXeEETOLsRTtjL
	TUJP0wS9UfXxx7Z56EYmAHnPzkrBZ95idLOKWNxHSSUjhvAVlrh4P5cc
X-Gm-Gg: ASbGncu/rIQrlZYzOm0TuhrjTUOugVwez4OFx4blodwAO8fkqUqYpec1KxMiVm3XvE3
	uTAF//hI0PCZTIfy1dwNfNRzzb5ONMCEp0ZttnOjvMrM1wJULTOmsWMJ/YCsDxcjZgifE2GnHp3
	7HgO1qh18Icrw3Tf5IlvwPkbh+Kh3BDC3FRl2FPCL3P3zHVrHkWH7kfYcTwRY1dc2Kw9Z/2CIyP
	gtmMsw33qpAv1VcHlmnkz+qxALAtzdpyKAkFmD00HeUKUR6hTaw1Gqg9DmqynDtW+c0nCfvIFd2
	V7I10jSRz/sGvMjMA0Y77lmkrCs0CGqEEZu4lS74kmQcTlGO2nGocd0kxRG8EcwT9OWSKYdcXd2
	e4z0bV26Lj8DPRWknY7d4X0eBzsYjyEb6dt91tYY3nvcuh6IJeievkJoGg9U=
X-Google-Smtp-Source: AGHT+IGaAzeCNW7Q+hF8O+o801w4IIYVn/OnyZ8n0KIX+S8TZTFaXkE3VXSDB+lDfrzEZMLDYey6ZA==
X-Received: by 2002:a05:6512:31c6:b0:553:37a7:b217 with SMTP id 2adb3069b0e04-55a046039e1mr3818518e87.35.1752494816696;
        Mon, 14 Jul 2025 05:06:56 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7bbb16sm1915901e87.11.2025.07.14.05.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 05:06:56 -0700 (PDT)
Date: Mon, 14 Jul 2025 14:06:54 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, ipedrosa@redhat.com,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/5] drm/sitronix/st7571-i2c: Fix encoder callbacks
 function names
Message-ID: <aHTy3tbDKA0QVqBt@gmail.com>
References: <20250714104421.323753-1-javierm@redhat.com>
 <20250714104421.323753-2-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZntHvysbNzK599cl"
Content-Disposition: inline
In-Reply-To: <20250714104421.323753-2-javierm@redhat.com>


--ZntHvysbNzK599cl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 12:44:00PM +0200, Javier Martinez Canillas wrote:
> It seems the driver took some inspiration from ssd130x and some of the
> functions (encoder callbacks) were not renamed to use a st7571_ prefix.

Outch, shame on me.
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>


--ZntHvysbNzK599cl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmh08tgACgkQiIBOb1ld
UjLl5RAAvKkGSF3gPiEDW7asxdOXyyZ0FyIF9ZcOqQS32YWD4+QvYmLqkjSw7O1l
39arEYVQnwmJavO1EMrOY9hyuUoWb1Hkf4LhV6f/qCZrE4pT2aiJdOf+YUnNH+ee
mVNew2FDhiuo/QFK7Dz7Ffxnse9g/c/mKh7wsiqTIwi5mcbiBIgVAaLzx0C8/BDa
Q8htxvkPWqqauAIP2KE5KznUXDaJp9pK97ljG1m61RgqGUUFGPKrLNkqR5t1jDSU
udnSYqJ7dLCOB/OPFTj2If1QEevMnBZjvnKmYoS9V2UJuFV8AfmiROxfU1ckeIeF
YzMy8MH9z/KeGQh0lDVpJk/xbYpZBWCkvMdQwbHBDDbsTMzMA0mkXpI2MsVv2Z9l
n9NQYdVyzGkuyJwYCNZ/NI0+IuXz3hIB73qwO0G+tfSjMUo7SqBto0hqSDMtB8mz
kTha2puNp9ovLMZ52l0EATnNpRfx8GdW/WKsfzEMpypv/Q1cxjeCqlb0OWvuxjEn
ZtatPZ0SMspbkC96IwCjVHYdMk1g/jSj/t1QLk7A6MCwtYkQRxvn7+BIhUqpYxlQ
YTVj0nxDIOvnOxghxX8bWP9GsaCWrFXG8ay7jtXvRN7Q7JKs9IYnZQwCMjdLiw+F
GRzbdR3VXecn1I+INYamQ4m6bPA4Zn8a30g88Bkd1EvFUGGndLQ=
=5E0a
-----END PGP SIGNATURE-----

--ZntHvysbNzK599cl--

