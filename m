Return-Path: <linux-kernel+bounces-798212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D636B41ABA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499711884232
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000A92EA483;
	Wed,  3 Sep 2025 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EZJFfu2D"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9451A2E9ECE;
	Wed,  3 Sep 2025 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893174; cv=none; b=XzkmbipFw+wbZE3tjdErccIMhtwl3efSoioVJoPhh2m3hHlbXgCM77fSXkq0uxV896A9/xw0KTTetMdGGQVdP4alg9zt15BX4UL8B8d6WrUCHBMrR9wkVFUbUTtFbbMEbH/RBY9Vj60pvxIxRM8B//nhCirgWHX/43osdZPzRDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893174; c=relaxed/simple;
	bh=F8Tu6zXPg4ssFQqHChLUNXEw5QwPVsS4RpFArqdk8l4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyEilzuFAudLdn4NTuXf6I3KvAdTMdQUrK2thLip5SJt64jMowAol4MUxfrAU1hSyUgtxyS1gCQEhNhq2rnbplGTzdWLlzLmabxNUzPqNKQiE578rSbJDZXpsXgtvnwjttEv/i4LTo5Y/oQVFiz+rmM9aKmIEsVIctqY5wGVYIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EZJFfu2D; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5839qlnB3236541;
	Wed, 3 Sep 2025 04:52:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756893167;
	bh=MjGeDQJzxnXd8m1pIJ6GNIDiTH2Wa1YICtpm3j0RxX4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=EZJFfu2Din84QWVQd4CeC7AEySaoz1CCOw3Qda0+r34RHjKuHo6AT9rqluagfvO86
	 zzrJZVm2yySq0IvxuN3+6qDG7HtLLvT2GnvvT4WbWRWPdUwu4zCUVuoHZcy1EuD5NP
	 AImybWnCiITMHDFWHnD+s6echUu/16ORBfz7+Sug=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5839qlkn3435497
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 04:52:47 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 04:52:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 04:52:46 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5839qj8C1092983;
	Wed, 3 Sep 2025 04:52:46 -0500
Date: Wed, 3 Sep 2025 15:22:44 +0530
From: s-vadapalli <s-vadapalli@ti.com>
To: Hrushikesh Salunke <h-salunke@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <s-vadapalli@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <danishanwar@ti.com>
Subject: Re: [PATCH v2 0/4] arm64: dts: ti: Add bootph-all tag to USB PHY
 controller
Message-ID: <b870f831-a560-4dfa-a339-7ef95fee9f38@ti.com>
References: <20250902053009.1732607-1-h-salunke@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250902053009.1732607-1-h-salunke@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Sep 02, 2025 at 11:00:05AM +0530, Hrushikesh Salunke wrote:
> This patch series adds the bootph-all property to USB0 PHY controller
> nodes across multiple TI SoCs (AM62, AM62A, AM62P, J722S).

I believe that you are referring to boards rather than SoCs based on the
changes made in the patches which address Nishanth's feedback on the v1
series.

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

For the series,

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.

