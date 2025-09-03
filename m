Return-Path: <linux-kernel+bounces-798729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2283B4221E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1863A49F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3583090FA;
	Wed,  3 Sep 2025 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="N0tq5TFE"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBBB3093AE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906867; cv=none; b=S5dBxrXGYqTWbXwAQRbT+2mjyme1Nlw/tCAHbC8BQejWlMsuUctxNH4H0Q2iA5dZwttgT6hZFNvcW1mnFyINbpVsSi/p0ijtW+JvbO4sTo8luRX0//o7XbuNVdYhJxHx3h4TeNItzDHRaz+Sz3WLRM5BfGXcPFfqrSYKSxDpULs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906867; c=relaxed/simple;
	bh=K/9dAyFF/P+rSML/+SeNcZwvlUM5MmpiClNT/7DQIXQ=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=l5Jvd3htR9ctkOGTer1CeqFLLYEcCTcjKierUIvQTQsxTOuXstm7vfOX3HJrRIxX/RgHjwU6kK6ilu9xrvV1W4uidm16x+8n+g3Kl8d/MY5ULtFzQloY2DrRgWZItdt1nNNmAzgPN5s7PpVLsGAikb1jknYzgbWN11Qjje6+RbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=N0tq5TFE; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:480e:e039:1d0b:c5ff:a9e2])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 33B7D83D;
	Wed,  3 Sep 2025 15:39:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1756906792;
	bh=K/9dAyFF/P+rSML/+SeNcZwvlUM5MmpiClNT/7DQIXQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=N0tq5TFEyFNEPAEWuQykFLtPtYKWwkIk7GdD6zDzio5OcB4Q61rd9DzuNVntZGLCm
	 saS90oxafBg89QQmQ7ldOuP1fPOj99B68c5gIKWAx8fdaIT0O9rl4P1HvhWBqKxo1A
	 qJtFV01IqAFswxeh6z1HOBHiL38eALSBaFLczvC4=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <731ead88-8dc9-4032-86f5-7a2dd5044b22@gmx.net>
References: <20250827-vchiq-destage-v1-0-5052a0d81c42@ideasonboard.com> <20250827-vchiq-destage-v1-4-5052a0d81c42@ideasonboard.com> <731ead88-8dc9-4032-86f5-7a2dd5044b22@gmx.net>
Subject: Re: [PATCH 4/5] media: staging: Drop bcm2835-camera driver
From: Jai Luthra <jai.luthra@ideasonboard.com>
Cc: linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-list@raspberrypi.com, Dave Stevenson <dave.stevenson@raspberrypi.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>
Date: Wed, 03 Sep 2025 19:10:55 +0530
Message-ID: <175690685574.8095.13306600513284108529@freya>
User-Agent: alot/0.12.dev28+gd2c823fe

Hi Stefan,

Quoting Stefan Wahren (2025-08-28 00:48:22)
> Hi Jai,
>=20
> Am 27.08.25 um 08:24 schrieb Jai Luthra:
> > The bcm2835-camera driver is replaced by the V4L2 bcm2835-unicam driver
> > that is already upstream. So drop it from staging.
> AFAIK the old Raspberry Pi Camera V1 isn't supported by V4L2=20
> bcm2835-unicam. Personally i'm fine with this, but this must be clear in =

> the commit message.Did you already talked to distributions like Redhat & =

> OpenSuSE about this step?

As Dave mentioned, the OV5647 should work with V4L2. I don't have a sensor
with me, but I can order one and try to get it working with the upstream
kernel separate from this series.

I did test the V2 camera module (IMX219) with my series applied on top of
upstream kernel, and capture worked fine with bcm2835-unicam, so I don't
believe V1 camera module should be an issue.

> > This also simplifies destaging of VCHIQ MMAL, by reducing the users of
> > the MMAL API (this driver is one of them).
> AFAIU this drops the only one user of VCHIQ MMAL. So please explain, why =

> we still need this API and how this should be tested?

The bcm2835-isp and bcm2835-codec are other users, which are currently only
present in the downstream Pi kernel [1].

I plan to upstream the ISP driver as a subsequent series (that was the main
motivation for this series), thus keeping the MMAL API still here.

[1] https://github.com/search?q=3Drepo%3Araspberrypi%2Flinux%20%23include%2=
0%22..%2Fvchiq-mmal%2F&type=3Dcode

>=20
> Best regards

Thanks,
    Jai

