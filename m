Return-Path: <linux-kernel+bounces-810084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29367B515A3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F8B3B2FDE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD486214813;
	Wed, 10 Sep 2025 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Fjflndpg"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F31223A994;
	Wed, 10 Sep 2025 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503607; cv=none; b=jJ1yqcpDT3yaJvsBJEhnvWZWasmVqrteTJcuk4Z9287IQsbHJABYHNSSiWZa6PhiNzoCDWjWDfnFhwMNMb2JJqeSQ1F9BCBGz+GIpYcMr4JL5wHAmc1jNmadBOtVY1POBiq5nTNJixu3BRBy8CUEcGgfN4Ii5mVPqyV2jWNGGzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503607; c=relaxed/simple;
	bh=G1VY2SY+tigOxhgsgMFnlrH+hixR4rokYsR9+XC5Cbc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UikavWNzRs4p7V59u7bN1fLSXit+TnadPJZ8a4b9lMDaHpSyD9SxiUWVZKr8PYgPX4K9JkJ20iyP4uwD0nd3RcF1aJ9RLFH4sEPHP9uvettV0fknTfTQoFNJSouv5f6ujY1WGx15eiCH9t5T9S2+4pkk2rCnSIcjM6ot7pNdXsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Fjflndpg; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58ABQe0v048886;
	Wed, 10 Sep 2025 06:26:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757503600;
	bh=l1Ebb9w5fqBtupSY4zV28bUMBIdK5LzwZ4K+oC1XGvY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Fjflndpgss9fCb2kIKVOChniUOXQR6GVokG1+NxmFYY4hTlb2Th+bJfgJQFlk7osn
	 xsqPwm02pK6L/CLUIn2G3b/ErsYMNYzSBtzLKXeks1rBdxaPrNKgrEUf/QcfKWaaO1
	 ljmQQo2icD539ysEj0bqaORZMRJGR4cNhRc14UiM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58ABQdCt331890
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 10 Sep 2025 06:26:39 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 06:26:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 06:26:39 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58ABQc7u402547;
	Wed, 10 Sep 2025 06:26:38 -0500
Date: Wed, 10 Sep 2025 16:56:37 +0530
From: s-vadapalli <s-vadapalli@ti.com>
To: Akashdeep Kaur <a-kaur@ti.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>,
        <d-gole@ti.com>, <u-kumar1@ti.com>, <sebin.francis@ti.com>,
        <k-willis@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <vishalm@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v6 2/4] arm64: dts: ti: k3-am62x-sk-common: Remove the
 unused cfg in USB1_DRVVBUS
Message-ID: <1cae6fe7-2d14-420d-ace4-54124206a0d8@ti.com>
References: <20250909044108.2541534-1-a-kaur@ti.com>
 <20250909044108.2541534-3-a-kaur@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250909044108.2541534-3-a-kaur@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Sep 09, 2025 at 10:11:06AM +0530, Akashdeep Kaur wrote:
> After the SoC has entered the DeepSleep low power mode, USB1 can be
> used to wakeup the SoC based on USB events triggered by USB devices.
> This requires that the pin corresponding to the Type-A connector
> remains pulled up even after the SoC has entered the DeepSleep low power
> mode.
> For that, either DeepSleep pullup configuration can be selected or the pin
> can have the same configuration that it had when SoC was in active mode.
> Remove the unnecessary DeepSleep state configuration from USB1_DRVBUS pin,
> as the DeepSleep control bit is not set and the active configuration is
> sufficient to keep the pin pulled up. This simplifies the setup and removes
> redundant configuration.
> 
> This reverts commit 527f884d2d94981016e181dcbd4c4b5bf597c0ad.
> 
> Tested-by: Kendall Willis <k-willis@ti.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>

Acked-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.

