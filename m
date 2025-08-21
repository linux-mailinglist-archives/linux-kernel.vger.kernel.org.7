Return-Path: <linux-kernel+bounces-780836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51706B309ED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 01:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A956206F1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7646121B8E7;
	Thu, 21 Aug 2025 23:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uB3ZmRHW"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AFE1B4141
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 23:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755818258; cv=none; b=jMwpD8ORjf844bOISt6LUVtvFNVwMJx0MiytMvzwU3G5hYjjzCqjPVGjVl5kOzHflq0zcxlEulB/qYiqRCy7DiGPQhqmy+XOBFOY470cGPejxinsQ9qZmcpFvJBD77onaqYiePaHRhtVJkn9k46tTdRjp9b9VftDgw7MQaSFdmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755818258; c=relaxed/simple;
	bh=9Jx7MNK4wl3d7Rq+g2NFPopop6AvJVhChfpbeFuw4ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t+PujeMrU5rZBjU3Iq2tYJaeJ5Yi3zerU6ZGeZtyvTy79N6tVnmvLG3dLb90xusvqpSY6NxGOjG2RLSDJJHN480sW49o69ys02ZI23HMszdUT9hvK4n1rXg6rBRm9hUfMNfpLw17Eu7h9TTNJUEuxEUjvvhVa/I3YhWKIXqCBYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uB3ZmRHW; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57LNH8dL116000;
	Thu, 21 Aug 2025 18:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755818228;
	bh=FxYjy7de4BBvokx76hvxygzUMcYYtcxPhs6mdD+tg/o=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=uB3ZmRHWXlxBkDx2lUhs4SiFQngRmCNt3DVeSHTa1cx3+Ud1xp8aZFHvms37/cdSh
	 SVB+1YCUmu+5A2tl1xJ0Ul5lUv/NJCjmYtEHdXtDqXzY9iF8XI4d5B3mvOZPrP44Ua
	 oqlas05Z+5hAifnjvgkGMp4XMDsm321I9xbleFVg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57LNH7Kr2280882
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 21 Aug 2025 18:17:08 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 21
 Aug 2025 18:17:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 21 Aug 2025 18:17:07 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57LNH7dY2613823;
	Thu, 21 Aug 2025 18:17:07 -0500
Message-ID: <145dc871-4d0e-456f-940e-c3c6268e2d92@ti.com>
Date: Thu, 21 Aug 2025 18:17:07 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: multi_v7_defconfig: Enable more OMAP related
 configs
To: Beleswar Padhi <b-padhi@ti.com>, <linux@armlinux.org.uk>, <arnd@arndb.de>
CC: <krzk@kernel.org>, <afd@ti.com>, <u-kumar1@ti.com>, <praneeth@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250819101137.2878336-1-b-padhi@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250819101137.2878336-1-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Beleswar,

On 8/19/25 5:11 AM, Beleswar Padhi wrote:
> This allows us to enable various peripherals in the TI OMAP family
> platforms like AM571X-IDK, AM572X-IDK, AM574X-IDK, AM57XX-BEAGLE-X15,
> AM57XX-EVM using the multi_v7_defconfig, instead of only with the
> OMAP specific defconfigs.
> 
> DRM_PANEL_OSD_OSD101T2587_53TS:
> Enables OSD LCD panel support used in AM57XX evaluation modules.
> 
> SPI_TI_QSPI:
> Enables TI's QSPI master controller driver for accessing flash devices
> on OMAP5 platforms.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>

Thanks for the patch, QSPI config is needed for am437x.

Reviewed-by: Judith Mendez <jm@ti.com>


