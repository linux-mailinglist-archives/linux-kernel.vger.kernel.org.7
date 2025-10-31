Return-Path: <linux-kernel+bounces-880470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 535C4C25D3A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97E524F501B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EDC2C3253;
	Fri, 31 Oct 2025 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeNtmRQL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D002C0F6C;
	Fri, 31 Oct 2025 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761924277; cv=none; b=WHGsKb9Cy1km4Krn0jfmokuSfZDfkpltMXkbMuGMJSF+zcJIUV6UkJxtBb4V/erQFtVv+a3mzamexUej6MUf/BjRwFsO98Hyp6iSjaYQ7ACOxs8ThybFKUBNOodCKKjpkOjbghsNYdARIqv5LF9bsxpuoe+LRzvyWtov8nW390g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761924277; c=relaxed/simple;
	bh=wELlLjOopO70GyAAjcrhLoBkcEk7e3coegAXgBgiU5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ep6xaA6zfCjI/QLkesUomGQhStmSiItBpSv3gJMX6LM/7VJmJ5o429twByml4brpGl3qAROdROlb8QKbOPIlHRQAW4ta8G2QZVPCTdqLY+Fhz13640v8FJG5v9782rBBypQRnFcgWPjoviQ1UmJ4iOZGfMRMxfWn9NpDD3QWrl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeNtmRQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644DFC4CEE7;
	Fri, 31 Oct 2025 15:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761924277;
	bh=wELlLjOopO70GyAAjcrhLoBkcEk7e3coegAXgBgiU5c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DeNtmRQLpubaHm2ENZAO70y35ZxllIqPJtIyUT06xT7pzFwQwK3qKMej06+407oZM
	 NqC8IY5IfqcsWGAgnXIdM2CewkMdBFcYzSfLp09FJpcmSRNVcFDhCpzNi3Y2CsEA3w
	 poNj4Vn/9JtGEYCSB7GfQln30WgJvkDm9KR8VdMt/TtDCxcmSg503VkkdZcU6o9JBw
	 pMpG6zqdDli9p5GRlA8x5P1Y/mOf+1rOsiwPU3BL0khA+iCZWAce7pkDrOvQIIyZdY
	 iUPiYEMB0EWI2NGn4p2zDrVzXaaIuubpH9QHl8DwnGo5YWR/0dOrSuxqrZJ6ei9D77
	 GcW7EGj0LR56Q==
Message-ID: <c9542093-aa2c-49a5-9126-e495f1fe1497@kernel.org>
Date: Fri, 31 Oct 2025 10:24:07 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Add support for Agilex5 SoCFPGA 013b board
To: niravkumarlaxmidas.rabara@altera.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251031131739.914012-1-niravkumarlaxmidas.rabara@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20251031131739.914012-1-niravkumarlaxmidas.rabara@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/31/25 08:17, niravkumarlaxmidas.rabara@altera.com wrote:
> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> 
> Agilex5 SoCFPGA 013b is a low cost and small form factor development kit
> compared to other Agilex5 development kits.
> It Supports both tabletop and PCIe add-in card operation. It features
> expansion headers for Raspberry Pi 4/5 HATs and Digilent Pmod modules,
> enabling integration with popular ecosystems.
> 
> https://www.altera.com/products/devkit/a1jui0000057q9nmau/agilex-5-fpga-e-series-013b-development-kit
> 
> * Patch 1 - Add compatible string for the new 013b board.
> * Patch 2 - Add device tree for 013b board.
> 
> Note:
> The patch 2 depends on the series: "Add iommu supports"
> https://lore.kernel.org/all/cover.1760486497.git.khairul.anuar.romli@altera.com/
> 
> Patch series "Add iommu supports" is applied to socfpga maintainer's tree
> https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.19
> 
> Changelog:
> v1->v2:
> * No change in DT bindings patch, retains Acked-by
> * Add more description about 013b board in cover letter.
> * Drop Agilex5 from commit header in DTS patch.
> * Add more details about 013b board in commit message of DTS patch.
> 
> v1 patch link:
> https://lore.kernel.org/all/20251031103117.910187-1-niravkumarlaxmidas.rabara@altera.com/
> 
> Niravkumar L Rabara (2):
>    dt-bindings: intel: Add Agilex5 SoCFPGA 013b board
>    arm64: dts: socfpga: agilex5: add support for 013b board
> 
>   .../bindings/arm/intel,socfpga.yaml           |   1 +
>   arch/arm64/boot/dts/intel/Makefile            |   1 +
>   .../dts/intel/socfpga_agilex5_socdk_013b.dts  | 126 ++++++++++++++++++
>   3 files changed, 128 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_013b.dts
> 

Applied!

Thanks,
Dinh


