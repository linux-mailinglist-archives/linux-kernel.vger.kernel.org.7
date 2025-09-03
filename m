Return-Path: <linux-kernel+bounces-797707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A86B41445
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E4E1B2777B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522BC2D3A90;
	Wed,  3 Sep 2025 05:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nGG27zwB"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27D01DE2D8;
	Wed,  3 Sep 2025 05:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756876756; cv=none; b=B0A2AeuSSh63rIcR/V8Dq7aQ8c3FX5cV7FCCwq/M8HR7DouRmVYWTlG+uQyQxlbU/FKVQOGdC3ct7NqhamkSEGvDN03/5xTa536m+hPY9i4+nTskpPmCJcgdgV4kBbjy3WwuipAPLZ/yFRIKtCdqgeniL+wzfEQDQEYhaeV+SQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756876756; c=relaxed/simple;
	bh=7ZYNSTK4YsnxBQmoYz7w1ZYPUcs2CciPuFZ/Nw25UYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CWo3cm2JaZzf9N9LwjxnuWkumpIiDwecoaoB6zdOwhpM1cN9QtvAD9yS7+9cTRo1jIVL592nyFliQphj9tUjssV3gzS8fM4ynIUBrk5AYuOy8m+PrBCzVxR+xgE88fxmp9DCMZQL3mYQgsKQqSzS6ZDMJrPrm38nwTyNkxKI9zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nGG27zwB; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5835J5dg2693289;
	Wed, 3 Sep 2025 00:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756876745;
	bh=fFnDPqUapCpZq44H9P2mGHmeMombMf+LktHqojkMpLA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=nGG27zwBFw4zR3DDV+gRfobREsQuTq4FLtmKTXqoJDfe0a6zkpVrAkMhMAqtXIf/H
	 UTQfsp+F0UF6nZR7Cd1Z6IWuZYbRIOkHd2DY08wObCFFu7JUEzF5TDWTQCme4lSJzR
	 9zRBQXT1rxaCsVj1YqQ3JuyTwFnf9/UZjhstmoaY=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5835J5pl2804916
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 00:19:05 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 00:19:05 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 00:19:04 -0500
Received: from [172.24.231.157] (hp-z2-tower.dhcp.ti.com [172.24.231.157])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5835J0rR748052;
	Wed, 3 Sep 2025 00:19:01 -0500
Message-ID: <068a4bc4-70b4-41a6-b60d-be88d67a0709@ti.com>
Date: Wed, 3 Sep 2025 10:48:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-am62d2-evm: Enable USB support
To: Paresh Bhagat <p-bhagat@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <s-vadapalli@ti.com>
References: <20250823032304.1085775-1-p-bhagat@ti.com>
 <20250823032304.1085775-3-p-bhagat@ti.com>
Content-Language: en-US
From: Hrushikesh Salunke <h-salunke@ti.com>
In-Reply-To: <20250823032304.1085775-3-p-bhagat@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 23/08/25 08:53, Paresh Bhagat wrote:
> Add pinmux configuration for USB1 interface and enable the node for
> functionality. Also enable data transfer on USB0, on existing power
> delivery configuration.
> 
> Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
> ---

Reviewed-by: Hrushikesh Salunke <h-salunke@ti.com>


Regards,
Hrushikesh.

