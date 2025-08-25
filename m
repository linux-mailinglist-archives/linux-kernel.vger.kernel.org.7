Return-Path: <linux-kernel+bounces-785160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71176B346C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6532A442F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA4630147D;
	Mon, 25 Aug 2025 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="Y1/YsxUI"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4029D2FF16B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138046; cv=none; b=TgNubJNOG9OK5ZnEVu0KTrm6wWb/rEsRWmcS6uc+kRoxUUsT6Y88FFisHnXUFuAdgm5fH5bcnGTYUbFliWIPDJ+93HxyhZ/5W5O1YHHMaVtUa/DYn98nGKrBRGI3Fw9LDcHrETG6RxmYACIaFbijibsyRfdGWrLW+zZZzA/mSx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138046; c=relaxed/simple;
	bh=l88MbX/D+x5hdZ5ghNMKvll7+r5L2HuQ4LZvlsClm1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=faVOEK31UhpcOuYBfAX+RdWq89pDqYE9j79vI0aoY7WsDs5QZF8zg8EFK2KbhE/XRoR8GIW7Rg/aZnHICwE226UWgTocf/WEwmO7G+wfGP7ioaSdsl1fhv8AopVDZDnwV9pSrEdH4453guf2iHMotfHdb7zpfV/xBtBZ8CrOgVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=Y1/YsxUI; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (p5de4594b.dip0.t-ipconnect.de [93.228.89.75])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 491512FC0047;
	Mon, 25 Aug 2025 18:07:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1756138039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ukKoVtirAExIh7Myr9qrHvYyBmqYsM+ZvCkxZsLrPEw=;
	b=Y1/YsxUImZ/OEgAYb72dpxNT8GMyxFNjV5929hD47M+DJtLClhZDzjj9TIUw+dUA+NqfkC
	GppMVmfr0O6zwgRMMK0Iy50CHNoFI+DaoM3+EQs6Zqho0LFUlY4Ny/JyBQFm09GLsYo00f
	bdo3vJoNSPH3TqI12qg25I5rlA5X8Fw=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <bcd2fe8a-c80a-4556-9944-83fd2b493567@tuxedocomputers.com>
Date: Mon, 25 Aug 2025 18:07:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Add TUXEDO IBS Gen8 to Samsung sleep quirk
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Georg Gottleuber <ggo@tuxedocomputers.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250701205630.64031-1-wse@tuxedocomputers.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20250701205630.64031-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

Am 01.07.25 um 22:55 schrieb Werner Sembach:
> From: Georg Gottleuber <ggo@tuxedocomputers.com>
>
> On the TUXEDO InfinityBook S Gen8, a Samsung 990 Evo NVMe leads to
> a high power consumption in s2idle sleep (3.5 watts).
>
> This patch applies 'Force No Simple Suspend' quirk to achieve a sleep with
> a lower power consumption, typically around 1 watts.
>
> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org
gentle bump for this not to be forgotten
> ---
>   drivers/nvme/host/pci.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8ff12e415cb5d..d677080e67d33 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3198,10 +3198,12 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
>   		 * Exclude Samsung 990 Evo from NVME_QUIRK_SIMPLE_SUSPEND
>   		 * because of high power consumption (> 2 Watt) in s2idle
>   		 * sleep. Only some boards with Intel CPU are affected.
> +		 * (Note for testing: Samsung 990 Evo Plus has same PCI ID)
>   		 */
>   		if (dmi_match(DMI_BOARD_NAME, "DN50Z-140HC-YD") ||
>   		    dmi_match(DMI_BOARD_NAME, "GMxPXxx") ||
>   		    dmi_match(DMI_BOARD_NAME, "GXxMRXx") ||
> +		    dmi_match(DMI_BOARD_NAME, "NS5X_NS7XAU") ||
>   		    dmi_match(DMI_BOARD_NAME, "PH4PG31") ||
>   		    dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1") ||
>   		    dmi_match(DMI_BOARD_NAME, "PH6PG01_PH6PG71"))

