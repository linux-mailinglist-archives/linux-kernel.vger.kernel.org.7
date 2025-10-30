Return-Path: <linux-kernel+bounces-878709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7612C2149C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382291A262A6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1EB2DA779;
	Thu, 30 Oct 2025 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="iCa+Bl0r"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD8B2D0C80
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842955; cv=none; b=eXZuZtRWh5Vjn1MTSjVcVRIcA24e/ebkktzA6x7utkBZzYdfW2e8xj4D3SDGlKhBrLX9MuJNU8r1hg2FJFyK/LeoDMnDHfTA+GnOe2L3o91N8gpWp7HRkijk4zXwiLOiDDbnzxsOaerp18rcDy3t7OK/jMHqe2gA5Z3ABih4mMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842955; c=relaxed/simple;
	bh=IZ88xid7g9Z+HTisGSNvfwBx+jHIZkEkhFFlOY8Uu7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kN40ExU3UkyGrP9D1Y+G2O+0q6qdLPBssWNllZixi7IOnfVjpgEQlprDxPsxjswjBFJJW7ZpoZ4vBH1p6tJHSy7FlpPX3yyIVZdjrN/7DRh+KnCFFt12pTfYdNT8BxSPtGaxAOGU4yUPhTbdzHBOuV5cm/1fOH7FRNmRCZWNYzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=iCa+Bl0r; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1761842939; x=1762447739; i=wahrenst@gmx.net;
	bh=IZ88xid7g9Z+HTisGSNvfwBx+jHIZkEkhFFlOY8Uu7U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iCa+Bl0rUSyyMw48NwXf8F6Q4RhX5gU96tX0XglwRhmdRYKKBAWyLG2XiHoXEaxy
	 eMPDf+fHM3d7R6Qu7gZziozvFomjlxsEvLya5SveGBi3pShK1BXNmnzPa2dyz0Hcw
	 +5cSAxECqWpX86LTS2LDSHSfpVqfXkN2nf3kv0KFxLK9E8Ma4COPO83zxZqg+7nYc
	 iTxYWtnsmhrYAoW5yMAx0Igc1TX20i8jVUfOoTUUXx8aYUlEdLVyiPuZJNA0WRe91
	 595xa0Vej9Oar4kfYW3QJ4wJErQ55gaE/pEywiUPbVCxssusk8y503L/cl+Q8915/
	 UFKMHeY16n7xccbJxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.156] ([91.41.217.223]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mplc7-1w3onu2JMj-00eLru; Thu, 30
 Oct 2025 17:48:59 +0100
Message-ID: <2970d1ad-0562-48cc-8e67-ac952d93c4da@gmx.net>
Date: Thu, 30 Oct 2025 17:48:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] staging: vc04_services: Cleanup VCHIQ TODO entries
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
 <20251029-vchiq-destage-v3-5-da8d6c83c2c5@ideasonboard.com>
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
In-Reply-To: <20251029-vchiq-destage-v3-5-da8d6c83c2c5@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:MV7ypobBlp8n8u1O9izaMU+8Eb30QYX3rqFQhsrjMrNLTkp5DhE
 hnEugxWtD7qp3/sDwpJ6uyuLS7p9B6oPHCFv7soMbVTAxfnKrXHHI4YLbWePqU3dE5OJu0c
 xnSdtUFzMS9Zctj4fGpnFImfOQsw8dwW7mH5g5SfG7UkofMuN/5u6MRuAZycutRkcKo2Vpi
 XFiZnsWV+A7QcMaKwT6Mg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oGWcX0WUHKU=;1qKAG5N7IpvLD0ZOyk7d5W6tqcH
 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

Am 29.10.25 um 11:30 schrieb Jai Luthra:
> Raspberry Pi downstream drivers using VCHIQ have changed a lot since
> kernel version 4.4 mentioned in the TODO, and are tangential to the
> destaing process - so drop those items from the list.
>
> Secondly, the code indentation for the vchiq interface driver is not so
> bad anymore since Umang's series (linked below) got merged, so drop it
> from the TODO.
>
> Link: https://lore.kernel.org/all/20241013112128.397249-1-umang.jain@ideasonboard.com/
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

