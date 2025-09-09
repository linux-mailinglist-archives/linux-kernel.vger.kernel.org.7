Return-Path: <linux-kernel+bounces-808855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BB7B50576
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B157188D44E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643453002C4;
	Tue,  9 Sep 2025 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hLZZkvJz"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D95C22258C;
	Tue,  9 Sep 2025 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757443082; cv=none; b=AyV8mTg4fU29AbqCS80oBjI8O5Nz1iE2FJEu9jQ3DDPy/hK7pMGLEbLzusL11qB6lQgMw0c+aeYB4moF079XJvUQ8+bpIt7zwmAW1zz3s+ZjQeybIRTSfnGYnh4sMcWzGmL+KO+MgBoikxQvJywewiileG54idOfULEEcNKGhKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757443082; c=relaxed/simple;
	bh=PKXkBQqM60f7+WgXJqMrEwWr6w1qo1F3TD5mCThSVEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XTojHXm/Q0iCQbBrcw/gwtfA+qMwteB+571cU5LJtju/jIksFVfr7k3/ksqr2bARegxfjW1JZQhf80fsJYZ8oC5A/O5cFcckJ3hT2zKx9BF3rxvW3TFPjTBaVZjeTle+vumlmBrnbc9GgGSUeHwCCkWuHG7scMNhgwD4F1WNM6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hLZZkvJz; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 589IbtWf4165019;
	Tue, 9 Sep 2025 13:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757443075;
	bh=GKqZQ6H2ucEXsZBClsOawsfzpF0vS0ppOGE8BHVT8ek=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=hLZZkvJzmUzftQ9dGmPV4TDIRVTEmcKWMKzsRFwkRgI2vtW3RJclHsAfrsdyJy7Jp
	 evddrp7TC0ii087yQvc8zcOio4GTg2gltaXlx47LmLJAqUgyBaJcaujNrw0g0A/wPM
	 5a6eZ8Sduaof/73h9KoLMxNv7AznH4fVHyjRdNtU=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 589Ibtt63346572
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 9 Sep 2025 13:37:55 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 13:37:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Sep 2025 13:37:54 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 589Ibs4N3272256;
	Tue, 9 Sep 2025 13:37:54 -0500
Message-ID: <228bd986-6182-4e4d-ba2f-58ed4dea27e0@ti.com>
Date: Tue, 9 Sep 2025 13:37:54 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] Add support for Variscite VAR-SOM-AM62P5 and
 Symphony board
To: Stefano Radaelli <stefano.radaelli21@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20250904132240.36819-1-stefano.radaelli21@gmail.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250904132240.36819-1-stefano.radaelli21@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi,

On 9/4/25 8:22 AM, Stefano Radaelli wrote:
> This patch series adds support for the Variscite VAR-SOM-AM62P system on module
> and the Symphony carrier board.
> 
> The VAR-SOM-AM62P is a compact SOM based on the TI AM62P Sitara processor,
> featuring up to 8GB DDR4 memory, eMMC storage, Gigabit Ethernet, and various
> peripheral interfaces. The Symphony board is a feature-rich carrier board that
> showcases the SOM capabilities.
> 
> The series includes:
> - Device tree bindings documentation
> - SOM device tree with common peripherals
> - Symphony carrier board device tree with board-specific features
> 
> The implementation follows the standard SOM + carrier board pattern where the
> SOM dtsi contains only peripherals mounted on the module, while carrier-specific
> interfaces are enabled in the board dts.
> 
> Tested on VAR-SOM-AM62P with Symphony carrier board.

For the series,

Reviewed-by: Judith Mendez <jm@ti.com>

