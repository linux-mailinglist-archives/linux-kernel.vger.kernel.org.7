Return-Path: <linux-kernel+bounces-767350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83196B2532D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A96B7B529C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC7F2E9EB3;
	Wed, 13 Aug 2025 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V4xn0GSu"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F8E281368;
	Wed, 13 Aug 2025 18:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755110573; cv=none; b=RV/5RdUfrz20i3UiU75kFfvJg0+FOdWQp+ag2KbYJbtD1e2Lxm5kzXd8ZE14zYR7Wai7R7j54EQB5Q68BzQVqkzTBKgGJTCOP70ykd8dnOJXpH1FZtIJXShNgtpsgrNuGV49i6RMLSYMGAeTsI/jCpdSMhglZ8ZyiZ1AzDClJsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755110573; c=relaxed/simple;
	bh=3vKay5gKg19Kq2chPg/SuX+gjp1J9MnBwzhkOq/r3TY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXQElDvjxZnJLpRbq4CeFL1lJOj7JCf4sQczrfFL/D0/SASWPC/0KDT8gN5YiCCx3JfKTWTIx8KJvg/Vh0V2OQ9fpidR8cXD4Gvqv5XMiXWrSvJzPyEs0qRpIFIQsfKFjxbvQSK0iw2p/i3hj4SDdnNsnYUyvthUIaCX0nXjsLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=V4xn0GSu; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DIgTiZ2135662;
	Wed, 13 Aug 2025 13:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755110549;
	bh=qszVEd2EhaYW8OmOJGC6rnTOzggaCtkQFOIJf3q1+Ps=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=V4xn0GSuS7+ZpaLAJ4RtxHYRSx/+9PUTZvNos9KBTLeImQLktx2GgBOiUWznS+jXG
	 aQK2WgxeVFJTGepVuG/vTb5l6BOqRnh01AXrzIrtvrKxvB+//6HTg0pLWl5Wf/aWzN
	 xpEB3K+ntOA3PbAKitLWd4ZEx+3KKvS/OPHpnyIM=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DIgTpo261105
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 13:42:29 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 13:42:29 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 13:42:29 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DIgTcG2728072;
	Wed, 13 Aug 2025 13:42:29 -0500
Date: Wed, 13 Aug 2025 13:42:29 -0500
From: Nishanth Menon <nm@ti.com>
To: Randolph Sapp <rs@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <d-gole@ti.com>,
        <afd@ti.com>, <bb@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <detheridge@ti.com>, <matt.coster@imgtec.com>,
        Michael Walle
	<mwalle@kernel.org>
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-am62p-j722s: enable the bxs-4-64
Message-ID: <20250813184229.dhgpqvi3b6aat46g@managing>
References: <20250808232522.1296240-1-rs@ti.com>
 <20250808232522.1296240-2-rs@ti.com>
 <20250813151721.nc5fr3qmro5grlda@steam>
 <DC1HS8D8KLIF.2MN7D9EXGQQ45@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DC1HS8D8KLIF.2MN7D9EXGQQ45@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 12:56-20250813, Randolph Sapp wrote:
[...]

> >> +		reg = <0x00 0x0fd80000 0x00 0x80000>;
> >> +		clocks = <&k3_clks 237 1>;
> >> +		clock-names = "core";
> >> +		assigned-clocks = <&k3_clks 237 1>;
> >> +		assigned-clock-rates = <800000000>;

btw, as per https://www.ti.com/lit/ds/symlink/tda4aen-q1.pdf (page 86)
720MHz when vdd_core is 0.75v (default)
and 800MHz when vdd_core is 0.85v

0.85v is set in the board dts and higher OPPs are enabled depending on
board capability.

You might want to check the assigned-clock-rates based on data sheet,
default should'nt need a assigned-clock-rate.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

