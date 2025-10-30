Return-Path: <linux-kernel+bounces-878726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 268DEC21581
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C2F3A8AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D78D303A06;
	Thu, 30 Oct 2025 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="cYSno1Ux"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC9D1D618C
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843362; cv=none; b=H5wRbnveuVlK0nUuZ3LaKRN600dRvk+DLUFfUJZpF1hOLHNaHmMIVHLRrYNccVxN1rC8FCmFP4oiOLTsap1Ow29hjqL2ePRDoRBa4AKU/WHpN2vNC2ScFp2AYJaS5eZUA/jx0lS7S3UNe5DHe39QH5NtrzPsO8W0ispu9es2MjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843362; c=relaxed/simple;
	bh=eoZhnrY71EQ2zDaqYHJl+nGXemc7/mvioR/gsng8p4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bolVElgqcEIqEnGMwPorEZAnpHlpq9P/xreLGuY5rUp/ileByMhoJRVABrxpUENfQUfKrWYK9J2OrVqXugUVzlJIh+e9qsjm/M7MczhOZyofHaab9rgARiuTNROw433eJkwy2ksG7D0JKv/+B9ZYK69N1QSlvseSk43PvaihBSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=cYSno1Ux; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1761843356; x=1762448156; i=wahrenst@gmx.net;
	bh=eoZhnrY71EQ2zDaqYHJl+nGXemc7/mvioR/gsng8p4A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cYSno1UxsdSqclhgfWLl9TctpFYwaHifCQsXqa2EvmKkw2mja3J2EqU0JUiPb7HZ
	 mZ6xLmHotOfA+0m4IOaolAkGLjivpWtkcQ+pqPHB4LSC+AuFfmsHdCPZFD6lNo4aX
	 gSQMR9hCPc8tQoLiIdyGZGFivS1Ar/1qUsadPOYtYOQTi002yw6ZC3Ua6JY1Ty8Ym
	 W3QkZyIlaKgFw1G44TATZUFrE9rrDPmcoMGWpgFkbeLCn38j3FifRMyAr6nSSCUgM
	 Tr4NYn7JcwVHcsV0O0AfBAmTl6SKbGbvWTozyqTWETReoC+IfAQnoHfpqUsLz5jWH
	 x/USw6uRny8YDlJOCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.156] ([91.41.217.223]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVeI2-1vg7Vw1fiW-00KVze; Thu, 30
 Oct 2025 17:55:56 +0100
Message-ID: <7acc7ae7-85bc-4ac7-8f83-d937f4096754@gmx.net>
Date: Thu, 30 Oct 2025 17:55:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] staging: vc04_services: Drop bcm2835-camera driver
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
 <20251029-vchiq-destage-v3-1-da8d6c83c2c5@ideasonboard.com>
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
In-Reply-To: <20251029-vchiq-destage-v3-1-da8d6c83c2c5@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YXgMZEZZnd9GKbBLgs3soQ2a4ToyLB+zuSrNRcc38eKJsesOggD
 alzrfdcauQVOe+uAL2CiOEaN0WWaC07yNIOtjwYuxbIny7wNkElMJmgefALMLvlgvF9Nslm
 0Zf3nfbHO1bDiB+Rn9kE3BvRtselZkjwrFHF8Wf6vBMUVd5HjjmpIMGNTYOF0b+ktEVF/LA
 0nikNvDTzuLUK6k5hRHLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4gO/9HTyqQM=;SnbOWUKCw1wFvV82H5dNNn3frgg
 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
 rFtjO4yes3mdRhoC96YKs/jxks=

Am 29.10.25 um 11:30 schrieb Jai Luthra:
> The bcm2835-camera driver is replaced by the V4L2 bcm2835-unicam driver
> that is already upstream. So drop it from staging.
>
> This also simplifies destaging of VCHIQ MMAL, by reducing the users of
> the MMAL API (this driver is one of them).
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
> ---
Acked-by: Stefan Wahren <wahrenst@gmx.net>

