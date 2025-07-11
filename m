Return-Path: <linux-kernel+bounces-726882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CBEB01252
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D033E17311C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBC11C84A0;
	Fri, 11 Jul 2025 04:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RSaWinhF"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE5E1946DA;
	Fri, 11 Jul 2025 04:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752208423; cv=none; b=e9rfVJXGD5o88Yz45IOuurioR3DVtRFFnqXfEcRyaBjkAvDSR4Gvhojsj6gZiT6S/WAiJw5B1lpX5T/xfsQKGhe2EI22GNSFoxycCcUW0PShxGwpd616vzGjxJohwlUc+pkSzaDFFu8sQXqYsqaPnZWnzw7FBoGGmIOL5JSrIes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752208423; c=relaxed/simple;
	bh=BEftgnqdSguitud/leMW60+/n/YCwspDb7PHiQH+aW4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sc68id1+Q/WiA+w1wYP7BJ6mfjqwUqVRzK6hHhXOsJQqjCEiZOd+LoFYT2TeR9PYKibQCg9dZAof87Mtn/DP91re155p3eK5YuyEOjjRvh7POoyuLJh+IJ/n8vV2w69WEBHJJ1eNhHJIvZGa6GT8lDMexmkcgvKRGxVqULQxoQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RSaWinhF; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56B4XMCW1341376;
	Thu, 10 Jul 2025 23:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752208402;
	bh=RDjqQI7xGn6ZAkyB8A2JVUVNfkN4kR0P7+fd79Lw4zk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=RSaWinhFcfF/pN8NNbcj/1+Yo1dbwdpKtCU+wXuEQAW6THaJ/JHa5Rmz3WnH3oNkb
	 KYDWaNYMXrkYdNzCjkoNcjcv9yWjnHMmRrXoAnLiuFd0oqSbLcvnNMMiONxtAUJOQA
	 KUSjB1u6+6CUOEGYJmdB3d80Jzmatb54kJb77Yb0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56B4XMkr3687438
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 10 Jul 2025 23:33:22 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 10
 Jul 2025 23:33:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 10 Jul 2025 23:33:21 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.169])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56B4XKG12538132;
	Thu, 10 Jul 2025 23:33:21 -0500
Date: Fri, 11 Jul 2025 10:03:20 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Hrushikesh Salunke <h-salunke@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <s-vadapalli@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <danishanwar@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am69-sk: Add idle-states for
 remaining SERDES instances
Message-ID: <fcf7ca92-2963-4545-ac9a-e96787c2548f@ti.com>
References: <20250708113942.4137917-1-h-salunke@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250708113942.4137917-1-h-salunke@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Jul 08, 2025 at 05:09:42PM +0530, Hrushikesh Salunke wrote:
> In AM69 SoC there are 4 instances of the 4 lane SERDES. So in
> "serdes_ln_ctrl" node there are total 16 entries in "mux-reg-mask"
> property. But "idle-states" is defined only for the lanes of first two
> SERDES instances. SERDES lane mapping is left at its reset state of
> "zero" for all four lanes of SERDES2 and SERDES4. The reset state of
> "zero" corresponds to the following configuration:
> 
> Lanes 0 and 1 of SERDES2 are unused
> CPSW MAC Ports 1 and 2 mapped to lanes 2 and 3 of SERDES2
> EDP Lanes 0, 1, 2 and 3 mapped to lanes 0, 1, 2 and 3 of SERDES4
> 
> For completeness, define the "idle-states" for the lanes of remaining
> SERDES instances.
> 
> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
> ---
> This patch is based on commit
> 26ffb3d6f02c  Add linux-next specific files for 20250704
> 
> Changes since v1
> As pointed by out by Siddharth, setting lanes of remaining SERDES
> to "unused" will cause regression on AM69-SK as these lanes are used
> by CPSW and Display. Updated patch to set the desired values for
> remaining serdes lanes.

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.

