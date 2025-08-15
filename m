Return-Path: <linux-kernel+bounces-770292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E20CB27967
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C775876A7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6472C15BA;
	Fri, 15 Aug 2025 06:48:49 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D194315F;
	Fri, 15 Aug 2025 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755240529; cv=none; b=oj4HDHgyiWeKmU08dtM9qJlT+bhVb7O7pxmM9kMtxDwEplSp0a0HpVicG/tbjq930rAcpUZqrEMGi69fxcBnkJL4802N8Cr0XCKk6Giji3v3QgXg1FxyCoA1/dx5LA2y+vVAggucmmi3wpgJQJ/mo2JT5XlfmZ0WeeflzeDQqEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755240529; c=relaxed/simple;
	bh=hLM0Y1Cn9S272hTRWQPAqYuL88qsD6mxQE18qPcdLmA=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=LtGq4mX60/knRKEny644HXnRosULpK5q30ER7pAnTw3fXDhZiVTx5L1cpomFkJXbSCerEqxcDIJnQ52vbrQWjK6IdPiXpRz3Dy+uDoA6kO+Pmj3kxm4cM2/B6eCPTiTIwJRpLA3cykNy8qXSt7B2gCtuoYQNbtAv3otlY1xep4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c3CLH4Hglz2TSx0;
	Fri, 15 Aug 2025 14:45:59 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 33ACD140123;
	Fri, 15 Aug 2025 14:48:42 +0800 (CST)
Received: from kwepemq100003.china.huawei.com (7.202.195.72) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Aug 2025 14:48:42 +0800
Received: from [10.67.113.98] (10.67.113.98) by kwepemq100003.china.huawei.com
 (7.202.195.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 15 Aug
 2025 14:48:41 +0800
Message-ID: <689ED849.3060800@hisilicon.com>
Date: Fri, 15 Aug 2025 14:48:41 +0800
From: Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: <devicetree@vger.kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Conor
 Dooley" <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Convert hisilicon,mbigen-v2
 to DT schema
References: <20250812203327.730393-1-robh@kernel.org> <175519583586.3483838.3438060375809789110.robh@kernel.org>
In-Reply-To: <175519583586.3483838.3438060375809789110.robh@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq100003.china.huawei.com (7.202.195.72)

Hi Rob,

On 2025/8/15 2:23, Rob Herring (Arm) wrote:
> 
> On Tue, 12 Aug 2025 15:33:25 -0500, Rob Herring (Arm) wrote:
>> Convert the HiSilicon MBIGEN binding to DT schema format. It's a
>> straight-forward conversion.
>>
>> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>> ---
>>  .../hisilicon,mbigen-v2.txt                   | 84 -------------------
>>  .../hisilicon,mbigen-v2.yaml                  | 76 +++++++++++++++++
>>  2 files changed, 76 insertions(+), 84 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.yaml
>>
> 
> Applied, thanks!

Thanks!

Best Regards,
Wei

> 
> 
> .
> 

