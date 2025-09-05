Return-Path: <linux-kernel+bounces-802126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEC4B44DDB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D4E1B2799A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0682874EA;
	Fri,  5 Sep 2025 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zRJzdLtP"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2742AD2F;
	Fri,  5 Sep 2025 06:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757052984; cv=none; b=jkvpBXI64gFKi6iOqp8MpERkHl0vFkrFkZwaVbMhwZXwKK9Sm0QyznVyc6fL8RBiOtff7RRvTdl6oo2PISNrxJYWGptMo96aG+MEOmY+pznOsCCeh6BLYQPdaLS+BtPYFx1zfSvPKib4fcE3Ck9K20xWk1hN3q26zKvs88ZLIKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757052984; c=relaxed/simple;
	bh=KpRBmRKvhDcjWYur42/C1E01RbQyObokHTjZKKxxxLk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gz0Korl3ZN82082cDS2yEgO+DBsBB65jDUdzgXzmjA6yiij/p5x0Lr/6hgGxCK8T0KOLHByOUt8MseK2upAXo9gysJUvxUb+e46FOCzHDlfYdSZmRa/ppIUMtcZuu9iRmQkKgIqRj8ZLbA5WH+31NkuLNR7XR0VpzrQwrIe6Ozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zRJzdLtP; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5856GG323688819;
	Fri, 5 Sep 2025 01:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757052976;
	bh=6QhfPD6JIYlG46t1oLGKwVf4axoG3i/vXd29SY71uMA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=zRJzdLtPrgJ1V9493DF9TDLIcb+evX+BtefbXgcr0QKEkBL4kIDpHHS42WogoCKXp
	 WSlfazTzCm7WiBUcn6LYr4h6HFUgaNmZlYHjE27lBt1bWMqFX9gNfdKzJB80+UBoiW
	 DBvvthSsJG2KWNBCfurb6o2E7+ZgPcaADVO0kA4M=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5856GGLL165521
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 01:16:16 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 01:16:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 01:16:16 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5856GFuu004031;
	Fri, 5 Sep 2025 01:16:15 -0500
Date: Fri, 5 Sep 2025 11:46:14 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Akashdeep Kaur <a-kaur@ti.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>,
        <u-kumar1@ti.com>, <sebin.francis@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <vishalm@ti.com>
Subject: Re: [PATCH v5 3/4] arm64: dts: ti: k3-pinctrl: Add the remaining
 macros
Message-ID: <20250905061614.c4heyez77to4ovpz@lcpd911>
References: <20250905051448.2836237-1-a-kaur@ti.com>
 <20250905051448.2836237-4-a-kaur@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250905051448.2836237-4-a-kaur@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Akash,

On Sep 05, 2025 at 10:44:47 +0530, Akashdeep Kaur wrote:
> Add the drive strength, schmitt trigger enable macros to pinctrl file.
> Add the missing macros for DeepSleep configuration control referenced
> from "Table 14-6172. Description Of The Pad Configuration Register Bits"
> in AM625 TRM[0].

Isn't what you're really referencing the AM62P TRM ?
Small correction, perhaps it can be fixed up while applying?

> Add some DeepSleep macros to provide combinations that can be used
> directly in device tree files example PIN_DS_OUTPUT_LOW that
> configures pin to be output and also sets its value to 0.
> 
> [0] https://www.ti.com/lit/pdf/SPRUJ83
> 
> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>

[...]

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

