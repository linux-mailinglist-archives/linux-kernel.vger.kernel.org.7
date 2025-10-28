Return-Path: <linux-kernel+bounces-873240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25197C13747
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214AE189C39B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8312D6E72;
	Tue, 28 Oct 2025 08:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="mO1Jka8W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="ch8YEI4w"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A962848AE;
	Tue, 28 Oct 2025 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761638975; cv=pass; b=lqZy+t7kbXZ7kcHoyjIQWvoZemTqNjMQuCwhoFPZWmacmtcD7dj0lGPWzyGMgfbGiEgsmCL3569B0d5Gl6sZZUdl6xn48V6JgQpSUV5w5EqtQnbKj5A0t/Wntw6nEicO7ilgfTrORBs57+EEhkP1EjCvNp7v+KR08HIkQ3ykEwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761638975; c=relaxed/simple;
	bh=oM+Qk6/0i7S5n4w2OHuWR3eCnfyQfEjkW2Qc+xb62FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2M8Uc2DfAJsla76e4M17qH5cEnt3eAeSDHW+U89oRF9snJufFL829zUMjHGB4nHbTReD+jLIe7jnppSWbcHGFDg1ln7Pj4j81hPA1fksLS4viAXtR+9vBpfS9f+UeX+KVARc9SsSf34rBorym81q8qUQv2Ia6xLy+E1PgiyP7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=mO1Jka8W; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=ch8YEI4w; arc=pass smtp.client-ip=185.56.87.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-whct.prod.antispam.mailspamprotection.com; s=arckey; t=1761638973;
	 b=QgER7zAOxBh2RJH9tiwwAehMkF9CQ0zHTDdyfmwdD+iK+cIHlefFs4LU0DDxp49RL8a0UhKibc
	  pylBH8h+wm10S/VwKenDaWm3IvZYA3MpJXBll5S+qlFfGaxzzTaBFV7zUoXGEpvWBNuEcq+0Sb
	  3oyD8itMcIpiDXY60Jb40oxMMwQt1pPshn0dH50DcxTFoD6EROXxFn8ciMocGAWzs0vUyFoBJz
	  VAbKx+Wrz1k+ruitm7Dn3Sx4CP9N1LJZ8aalz/w66mJc4XQYIwIbBE6bbR/g4ni6cgY3MXwFOM
	  yw9gWnUFuL3YEwCaDI7QQoU3XrehRSn5DwzYNr/MlOaUGA==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-whct.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-whct.prod.antispam.mailspamprotection.com; s=arckey; t=1761638973;
	bh=oM+Qk6/0i7S5n4w2OHuWR3eCnfyQfEjkW2Qc+xb62FA=;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	  To:From:DKIM-Signature:DKIM-Signature;
	b=V1Ess1kM/15Z7VtMxnmvr7j/UsBLxZz80SW/xNAn8LM8kVjNDMaRhwYqxZ/3UXSvvXDcYA9Zks
	  ywGgIxbLirm5wthbMTEbbTOk/U7Sc5URihae/iQHAWKNFOk71HeahrRDdJz+Lv3TTtBvVuwS28
	  YiQrsbImvO/LZtSfErGoymGngL7paiKCIw8pSk0pWMXi+hCYtAwIuDCVsE2kE1Hw9WqkfzRBmu
	  t5D+x98xnb9nQk4dnnNc2hb1iVgSn0utZeLVwOitEpGR2pY2pXX53YsMoniVcjTxL12povWePM
	  YYfoCrSdVQ8hgWLQb+RVzGlyaV2/0QcIE/KvnJoCqvSkYw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=ne9rWrothZr4TKac9t+L9M1azOkVDHMJP9hBVA/2hz0=; b=mO1Jka8WCbCdCJtjB3FmruUmvv
	d/kZonxRVzIvwAx7sXwxIGGImk0ZXcCnCZbvu00W9ZI2xZOyhMXsXJPuqM6ilQJkTMQ4FM8k6KvwI
	IJ+d2MDyD6Fj3nLKpK3vq1vzTVez49Da5CGDoO5QdF/M9ZRxqjZE34LqjZYWAj2wfFrM=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-whct.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vDelk-00000001Pnl-2xQ3;
	Tue, 28 Oct 2025 08:09:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=ne9rWrothZr4TKac9t+L9M1azOkVDHMJP9hBVA/2hz0=; b=ch8YEI4w4BIM4FJluSHOAp48Fx
	n+ZnDTn0d2LiVvNZy6+NExHAaPKyXqa9uDyQENZvIpqzgufF6Z+VOQLGmnjdeIlImYSynktKq7c4+
	5idxkp7JdwSLIaH5IWb19HVH6vZ7WYR2XHxm+6D/oWLVoGKMVuK1+ko2p15GMpOmU2eU=;
Received: from [87.17.42.198] (port=59590 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vDelP-00000000PrG-1MNk;
	Tue, 28 Oct 2025 08:09:07 +0000
From: Francesco Valla <francesco@valla.it>
To: Mario Limonciello <mario.limonciello@amd.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Jocelyn Falempe <jfalempe@redhat.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-embedded@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] Add splash DRM client
Date: Tue, 28 Oct 2025 09:09:06 +0100
Message-ID: <4497733.UPlyArG6xL@fedora.fritz.box>
In-Reply-To: <23clcxtgbzbsji2knwp47xdc5udj7lnhbvzsgqi3vklvmhdgjd@26ycx2ed77l4>
References:
 <20251027-drm_client_splash-v1-0-00698933b34a@valla.it>
 <93cbbaef-918f-4300-aa5b-11f098e217b2@amd.com>
 <23clcxtgbzbsji2knwp47xdc5udj7lnhbvzsgqi3vklvmhdgjd@26ycx2ed77l4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5779622.ZASKD2KPVS";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: aef317f9c7174cbc851f75235c82ea84
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vDelk-00000001Pnl-2xQ3-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-whct.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

--nextPart5779622.ZASKD2KPVS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Francesco Valla <francesco@valla.it>
Subject: Re: [PATCH RFC 0/3] Add splash DRM client
Date: Tue, 28 Oct 2025 09:09:06 +0100
Message-ID: <4497733.UPlyArG6xL@fedora.fritz.box>
MIME-Version: 1.0

Hi,

On Monday, 27 October 2025 at 18:19:12 Maxime Ripard <mripard@kernel.org> wrote:
> On Mon, Oct 27, 2025 at 11:31:06AM -0500, Mario Limonciello wrote:
> > On 10/27/25 11:28 AM, Maxime Ripard wrote:
> > > On Mon, Oct 27, 2025 at 11:01:55AM -0500, Mario Limonciello wrote:
> > > > On 10/27/25 7:35 AM, Thomas Zimmermann wrote:
> > > > > > >     - a very simple progress bar, which can be driven through sysfs;
> > > > > 
> > > > > Once you have options to control these settings from user space, you
> > > > > should do it in user space entirely. As Maxime suggested, please improve
> > > > > plymouth for anything with animation.
> > > > > 
> > > > > > >     - a static image (optional).
> > > > > 
> > > > > Board vendors often provide an image, see /sys/firmware/acpi/bgrt/. This
> > > > > is a candidate for display, or the penguin or a custom image. Please
> > > > > make it configurable by Kconfig. Again, if you need policy and
> > > > > heuristics for deciding what to display, you better do this in user
> > > > > space.
> > > > 
> > > > I'd actually argue that the static image from BGRT should be the preferred
> > > > priority.  This can make for a nice hand off to Plymouth.
> > > > 
> > > > The (UEFI) BIOS already will show this image as soon as the GOP driver is
> > > > loaded.  Bootloaders like GRUB by default will avoid showing anything or
> > > > will overwrite with the exact same image in the same location.  This can let
> > > > the kernel do the same, and then the moment Plymouth takes over it could do
> > > > the same.
> > > 
> > > And BGRT isn't typically found on embedded systems at all, so I'm not
> > > sure it's a sensible default, let alone a priority. At most a possible
> > 
> > There are certainly embedded machines using UEFI and that have a BGRT.
> 
> Yes, indeed, hence the "typically".
> 
> > How about "Sensible default the top of the priority list if it exists"
> 
> How about we don't tell contributors what their priorities must be?
> 
> Maxime
> 

I'm not familiar at all with BGRT, I'll study a bit about it.

A build-time configuration could then let the user select:

- a plain solid color
- a custom static image
- the penguin logo (?)
- (on UEFI systems) BGRT source



Thank you

Regards,
Francesco

--nextPart5779622.ZASKD2KPVS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRUrtjevJ039mawAeLir2xSXEi5AAUCaQB6IgAKCRDir2xSXEi5
AKhQAP40LB6RZAIqFWMaqTGwU+pfKfbI7xzrwvAnMQg0GyiITQD9GYvelT634R5P
85RcG3t/ggO2aoRdzaCR0AxVzNLCOQk=
=xkSs
-----END PGP SIGNATURE-----

--nextPart5779622.ZASKD2KPVS--




