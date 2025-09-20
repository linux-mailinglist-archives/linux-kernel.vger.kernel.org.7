Return-Path: <linux-kernel+bounces-825584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B00B8C454
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0621BC07B8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 09:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155F428727A;
	Sat, 20 Sep 2025 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="DoCilT9/"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3CA246763
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758359673; cv=none; b=I2E1rgxDdwS7Oz788fZ0wj/KZyXv2T90BOQ4Fhcm6Of1fjRFxi4fzVp7eAwrsvi2JAUrrkkVYLE2S5agew/Fd54/zYnJkqiFGAlWeODlidtY15LAUhTllHSWKKnBkASW1PwP1TmHlHvkWpCYLCwxaifB/D0QU7/3g6HIsszhJ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758359673; c=relaxed/simple;
	bh=Bq45p3Ca7JVhSXo3NerrjZWAjCMhHCZS6+Fe0EH1VXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ulod8qc3hpD093pBqyRu/56vQe1e7/Q7Z7/9JxtYXEVhGeR8X67wGqNV8QMGmSFAv810yyt/tQtdvAnqjHckilP6WLU16TJUaXAjmG5oyLUoKXOIZSf3XItOFoxfZX4vBXaevfNCTl3ijVjYQtIcoOdAb86LxI73EwLxfb3CHCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=DoCilT9/; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1758359662; x=1758964462; i=wahrenst@gmx.net;
	bh=Bq45p3Ca7JVhSXo3NerrjZWAjCMhHCZS6+Fe0EH1VXE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DoCilT9/UZ/WQN0RqslCiFtt6hcUnkVvZQIsLlEHOIZM/nrJIkHWghVbRCR+eSQk
	 MvFZcOeSyRuhIvA0D3PAerB3qLCTJfNP9qAgeV0G08FB0PiJyZ/TKkhOGlLkv1h6l
	 75Gpj90jNlfwJ9B5pvJ7+gsXREhtpo4rjdGYKzZnHdLoy11FdVsT3HUQgJK8GH6tZ
	 remn79Q1MjS060NaZGWT86PLVEXUqcBdIUbT1SJwdXT+GaogucNC5+NCOwZs9OHQH
	 tuXWk6ULaieoEAOt8HHHQ9hLjWlJc6eJAiSDdG/JWe/lI6I2d87Qb+K51v9HxJVer
	 WORsDm4Mew2VxCw4ZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([79.235.128.112]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEV3I-1vAIzc164o-00C2Ge; Sat, 20
 Sep 2025 11:14:22 +0200
Message-ID: <b3d5eee4-bae9-4de4-a2bd-7fd5a1fa9fb6@gmx.net>
Date: Sat, 20 Sep 2025 11:14:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] platform/broadcom: Destage VCHIQ interface
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
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20250907-vchiq-destage-v2-0-6884505dca78@ideasonboard.com>
 <20250907-vchiq-destage-v2-3-6884505dca78@ideasonboard.com>
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
In-Reply-To: <20250907-vchiq-destage-v2-3-6884505dca78@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yeV6Gvsd+vFcCtVFvRwOBGne72YfegZX7Xh0OtmNtfNgOH2++CG
 w895V+x21htUuumNDlW8RskSF1fr3JuM7m+CpxCYdamTqRyqhWP1+I38omdDDfVnSni62lp
 T+WkciVeQM7Q5PU63JwzxbFSIsIlmRJDRi6R+OtIOq98mjTtwb9uSrECVvzc6Tx1xrxvZdf
 0olVYnofJJWnAn0oth1WQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mCMvwEEmofM=;GhxdT1+PCtiAa6hLRD6QYRjLeLl
 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
 fUQUVp6jitLy9/HP36I

Hi Jai,

Am 07.09.25 um 10:56 schrieb Jai Luthra:
> Destage the VCHIQ interface driver to drivers/platform/raspberrypi.
could you please adjust the commit subject to raspberrypi, too?
> There is still the remaining TODO item of improving the documentation,
> which can be handled post destaging.
I'm fine with this change, but I don't if it is necessary to have the=20
IOCTL documented yet.
Currently I don't know when I've the time to proceed with this [1]. Sorry.

Best regards

[1] -=20
https://lore.kernel.org/linux-staging/20250509221152.13564-3-wahrenst@gmx.=
net/
>
> Secondly, multimedia drivers like codec and ISP that rely on this
> interface need to be upstreamed. And lastly, the drivers that facilitate
> the shared memory between VideoCore and Linux, like the vc-sm-cma driver
> and vc_mem char driver also need to be upstreamed.
>
> Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
> ---

