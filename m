Return-Path: <linux-kernel+bounces-808463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A25B50014
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171495E5296
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB68343D6B;
	Tue,  9 Sep 2025 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QBTIYhWx"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF25226D1D;
	Tue,  9 Sep 2025 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429473; cv=none; b=Iu7fW858mrirVJ196+VFslv4xOeDb6RSUhLDAI5Dn400oB2c2hFCjX5Jq/58nMpoAn3pfp4gF9oFDgJjTqeQ8FGQYaKdeH0O/YWle6Y1eQ6WEJBV9nEMLsn63XN5HEdDOE/E+XTnsnDUWduMGTpoJXpwc3zWep7Dw5IlU1rcgrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429473; c=relaxed/simple;
	bh=4MYSLavW/QsTWxpPcXCnHdNSh0e72egCuabSZeM8SKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TA8bFtSNgMSGcYzNUQFGeOqNzY7ppPoCAAv9XpPd8u02pyB1r2ozZa0g+7wYUSTuBKb4Co8tcRz4Q3iGEVgXUeGcGrptY1GkHidCMl653Z6DVIIr9rK8AvZm2wcFaeVq6vmxqFTXbCe8QaDq3g3OgBA07sUnTItE7J9NPGxbOzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QBTIYhWx; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 589Ep5q04047902;
	Tue, 9 Sep 2025 09:51:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757429465;
	bh=M6UYJC51NYe1UdxgpY6BB6KX3ic2M6p4On67tOl2V/M=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=QBTIYhWxYSMBBv7d8KyYZZKQA5eJVVkMPfb/4aguj9UzOhzkLk9A3nOzF7LzOb27M
	 QpZYJ37hqpiS6lGCJQWZX4l42NNzZSudlyZBcuEc4JkRWNDZBh5h+wxccrqEqw/oTb
	 YdbJKQ0TQWTrS8GKXleQip/KUfFoGGmXgVpIboSk=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 589Ep5t73226481
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 9 Sep 2025 09:51:05 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 09:51:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 9 Sep 2025 09:51:04 -0500
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 589Ep4TC2499642;
	Tue, 9 Sep 2025 09:51:04 -0500
Message-ID: <13dcf814-a790-43ec-8e90-32225acb2367@ti.com>
Date: Tue, 9 Sep 2025 09:51:04 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] Remove unused bits from dts and add support for
 remaining pinctrl macros
To: Akashdeep Kaur <a-kaur@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <afd@ti.com>, <vigneshr@ti.com>, <d-gole@ti.com>, <u-kumar1@ti.com>,
        <sebin.francis@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>
References: <20250909044108.2541534-1-a-kaur@ti.com>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20250909044108.2541534-1-a-kaur@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 9/8/25 23:41, Akashdeep Kaur wrote:
> This patch series cleans up the dts files to remove the pin control
> DeepSleep configuration that does not take effect in hardware.
> This series also adds the remaining macros in the pin control file
> supported by SoC so that any configuration can be used as per requirement
> in dts files.
> 
> Link to Previous Versions:
>    -V1: https://lore.kernel.org/linux-arm-kernel/20250731115631.3263798-1-a-kaur@ti.com/
>    -V2: https://lore.kernel.org/linux-arm-kernel/20250901122835.3022850-1-a-kaur@ti.com/
>    -V3: https://lore.kernel.org/linux-arm-kernel/20250902071917.1616729-1-a-kaur@ti.com/
>    -V4: https://lore.kernel.org/linux-arm-kernel/20250904112538.529857-1-a-kaur@ti.com/
>    -V5: https://lore.kernel.org/linux-arm-kernel/20250905051448.2836237-1-a-kaur@ti.com/
> 
> Change Log:
> V1-> V2:
>    -Added the macros that were removed earlier for backward compatibility
>    -Fixed the indentation
>    -Added documentation references in commit message
> 
> V2-> V3:
>    -Updated the commit message to be more descriptive and Clear
>    -Fixed errors introduced in previous version
> 
> V3-> V4:
>    -Rearranged pinctrl macros so that all macros of same type are at same place
>    -Removed any redundant macros added in previous versions of the series
>    -Added new commit to fix the missing existing macro definition
> 
> V4-> V5:
>    -Updated documentation reference in commit message
> 
> V5-> V6:
>    -Updated commit message to add "Fixes" tag and update reference information
>    
> 
> Akashdeep Kaur (4):
>    arm64: dts: ti: k3-am62p5-sk: Remove the unused cfg in USB1_DRVVBUS
>    arm64: dts: ti: k3-am62x-sk-common: Remove the unused cfg in
>      USB1_DRVVBUS
>    arm64: dts: ti: k3-pinctrl: Add the remaining macros
>    arm64: dts: ti: k3-pinctrl: Fix the bug in existing macros
> 
>   arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       |  2 +-
>   .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  2 +-
>   arch/arm64/boot/dts/ti/k3-pinctrl.h           | 51 +++++++++++++++++--
>   3 files changed, 50 insertions(+), 5 deletions(-)
> 

For series,

Reviewed-by: Kendall Willis <k-willis@ti.com>

