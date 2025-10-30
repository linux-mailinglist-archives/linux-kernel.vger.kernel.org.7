Return-Path: <linux-kernel+bounces-878733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49259C21599
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1990C189A1D0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB831DF269;
	Thu, 30 Oct 2025 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="d679HxKf"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0BA2E6CB8
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843498; cv=none; b=WdNh2+ucfnZW2UsmuuGiFqmYyfwbvvHd5rv1guIhJakWeQ574HCdRrSpkShNa/ruFjD9q0GHoB5V0B/91ROtKHJiSkNpx73ovbrJdhYcPSxLAG0j1cfbqBaup/jGo48j8dTLdEqWeF4pk8HDJAgyMigOMFpJkF3f4xIl02MvmHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843498; c=relaxed/simple;
	bh=0FHu3rUGS+9JuTB7VJw93CwR+3Meki8I2Z3EaOdfkbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzxzJF3I281fnYs5vNRE/RBNiPC1fdYhvR/JA6QCpsJDkkFcsKUuS9OSbJQHt33/yAUFgRiZ9I/mzdR66JoHSKewubK4xnoDXVkMmSqNVaLnFgq5GYYJcg0dn5NqnDQyWCVNTbWZcEZWrMgUMz7fDX7rNR4XdQ5bmOqhFL05L38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=d679HxKf; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1761843493; x=1762448293; i=wahrenst@gmx.net;
	bh=0FHu3rUGS+9JuTB7VJw93CwR+3Meki8I2Z3EaOdfkbw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=d679HxKfZ3mC/oMh5xQ7KawuoYVpd6bgm4off6YMgsGgOdRJvEqjWteU2gARjBpl
	 l19Q7x0S/rBTVaXSRJhKY1uqzFRPYy9rSQMQVLY9ntvlzMrQ6B3mtvc2MFnr+RjX+
	 QVR0CH8VC3T1jcguVLsOkNEZt6im9A2hPY9RVUKtRbGmpj5PhbysMJMn7FED5QKhF
	 T2GgSBVsX4t3dls9RkYb0bJDnVXkN0/+m4HVmzhCWin6oU1m75kG2As/Whgj7I0x+
	 HJgAhZmsERze1qcUuRJ+OzJGbWun0Cq06pq0BRo797qT4054z4P8XcUpPY/XDyZKT
	 qj65ZWwPMPQf9zeSeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.156] ([91.41.217.223]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYvY2-1vjOnF2BM0-00QFMu; Thu, 30
 Oct 2025 17:58:13 +0100
Message-ID: <4491fde3-5b20-4ba5-bb18-5a44fd566f50@gmx.net>
Date: Thu, 30 Oct 2025 17:58:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] staging: vchiq_arm: Remove bcm2835_camera from
 vchiq
To: Jai Luthra <jai.luthra@ideasonboard.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel-list@raspberrypi.com,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Phil Elwell <phil@raspberrypi.com>, Umang Jain <uajain@igalia.com>
References: <20251029-vchiq-destage-v3-0-da8d6c83c2c5@ideasonboard.com>
 <20251029-vchiq-destage-v3-2-da8d6c83c2c5@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20251029-vchiq-destage-v3-2-da8d6c83c2c5@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:MGbK03mLnp+rlfoCX2thsI3NDziMJq+uMJ5rMxSoJFj4LnaPBu+
 RnfpVjzupb8sfaR3kr3LVXc3JjRN5KPJMndjmVJqyH75U9mkTmFdc4uK9bY0xOMHpJv9KlX
 FOTtJFp0cslgSa6f6gTJyb8TcDDPoFuLSIEaJNcq4uJaSNMherNBpnX6Bdutxj6HARcnR4P
 Jn9dzOfq8JIkg0Tmfk66g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:neHq8X1Wu64=;uWTOl/CRe1Sj6ysDi7exSylktSf
 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

Am 29.10.25 um 11:30 schrieb Jai Luthra:
> As bcm2835_camera driver is dropped, also drop the loading/unloading
> support for it in vchiq.
>
> Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
> ---
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

