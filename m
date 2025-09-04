Return-Path: <linux-kernel+bounces-801653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0881B4485C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DA027B076E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C631929D275;
	Thu,  4 Sep 2025 21:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NX4oG8Xp"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80856267AF2;
	Thu,  4 Sep 2025 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020668; cv=none; b=YJBTqDeVYDcUYal+1zG6BfBcYZaxw92dr/b0RK8YAq2DwQMrlE5j3K0R5IPoNqxDZsMFDh9qmNMmyax1TTrK+f15WEMsGzVX1eXZu7TBB0iJrPQFSISpFOht5v2VypERbJKMseMN/f1tVeYrDB+1K6sMWOo32hZpudTHazGibhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020668; c=relaxed/simple;
	bh=iz2E5DOgA3OJI94hOWj3fSzLyynsgMh4+Kv82QsUK6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZonXAEbNIXsEHiFaIYeqxHgg+8QhjAalpRZ3n7V6OLO6VcKaMU2Z/8pBfz9kifD1rFPEeupXyJMDdgm+n229ZvGAYg/VgmqA5puGPioiChkSIOENDk1YnK6a7w/kJ+ToitF8XCirfGTCJ1DZDSw9u2fFt1LZXcr0VtOPAKIBf3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NX4oG8Xp; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584LHeEM3167273;
	Thu, 4 Sep 2025 16:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757020660;
	bh=Vfqg3s+qknOSc6/C39ZyYTX19WA7gCC0eH96CcelZNU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=NX4oG8XpVzlja3OjRwFb6/2sD4Z/nNm+0ubQNupv+nVYWdTN1vNFQdWu5aAx4ohhd
	 Kr/bYO0h0iXLcA+51m67EDYeLpBDBJDNk9UeeEhZhwMjKCsF/tB6uCICpCnBS3Zrdm
	 fufrQxFO4r5tSF82qYE7jGh7tAW2cd4hBvMfNJGI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584LHe1W1150501
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 16:17:40 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 16:17:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 16:17:40 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584LHehq3602213;
	Thu, 4 Sep 2025 16:17:40 -0500
Message-ID: <83bdbff9-57d5-4391-8ec7-661b1ba012cd@ti.com>
Date: Thu, 4 Sep 2025 16:17:40 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] arm64: dts: ti: Add bootph-all tag to USB PHY
 controller
To: Hrushikesh Salunke <h-salunke@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <s-vadapalli@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <danishanwar@ti.com>
References: <20250902053009.1732607-1-h-salunke@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250902053009.1732607-1-h-salunke@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Hrushikesh,

On 9/2/25 12:30 AM, Hrushikesh Salunke wrote:
> This patch series adds the bootph-all property to USB0 PHY controller
> nodes across multiple TI SoCs (AM62, AM62A, AM62P, J722S).
> 
> The bootph-all tag ensures that these USB PHY controller nodes are
> available during all boot phases, which is required for USB DFU
> (Device Firmware Upgrade) boot functionality.
> 
> Changes sice v1:
> Updated patch series to add "bootph-all" tag to board specific file
> instead of SoC file.
> Rebased on current next.
> 
> This series is based on commit:
> 33bcf93b9a6b Add linux-next specific files for 20250901
> 

Thanks for the patches.

Reviewed-by: Judith Mendez <jm@ti.com>

