Return-Path: <linux-kernel+bounces-745400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461B5B11965
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA1B07AFE78
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EEA23373D;
	Fri, 25 Jul 2025 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dilMVaPB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A600C41A8F;
	Fri, 25 Jul 2025 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753429809; cv=none; b=UEqw84WCACsbd4OXFUB/SaURmVJbW/92YexglH5u16c4ZvOUBPco09tebbq1t8gwJwBF3UBe53BRC8r9PQDszaOOSSRr2g5cQEZWHobWY7NaDG+bsIx/7dyZLbGRjo4zDC32e9BDfCD/Kg17GLuNCo/4/11Q9mdhMy0BnCqLiGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753429809; c=relaxed/simple;
	bh=0Z2NaRercMgKU7Ha9P6a5TtnFKTjaFDoCKIBrBApX0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YP3SaNcBooEMEh4avrMHPNYxUS7WNLxRnKmVyGNpInI/3HrZ7eIYZuymwEXoJrLYKYD0BqGFsn+z+EvCJrB/pPk4QcllOc6tbbPMKZZfIb1fr+cu+G7I6rbFXWjQw/6JluAt2SmMi02V79bKjvC7L5Sxq/NlQPyPr+7r9F0fKoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dilMVaPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E1CC4CEE7;
	Fri, 25 Jul 2025 07:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753429809;
	bh=0Z2NaRercMgKU7Ha9P6a5TtnFKTjaFDoCKIBrBApX0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dilMVaPBt00KXR1Fd5ZkWWKRL48Ck/oaReXqrbPMmXqzk8VEmCqrwVyff/f9YHZxl
	 X0n1nbGjS+VOf04GDAWUkeaDLtuNMaM17kCFPtaHITuXGrjS+PbJpewLkbizgHEsk1
	 Ne5EF1jxTbmh9rQVb6govgPhYX0FwLnPO4+gV4Kj21FmOXlhdZHlA7sjwEpxHyvVrW
	 wjMdk8TEjicPuE+KHmG8sugUrEWHsA2J4JSOu2o8rqWdy07+vXEoGHvuZLh9hycvVB
	 3h9T234RgpbupAcP0ri5IcPa0vxemjItg6ZFldnfgA4Y+2AZrHXwAml3YF+nVxKzzn
	 7r9E4NFwlvgCw==
Date: Fri, 25 Jul 2025 09:50:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, 
	michal.simek@xilinx.com, git@xilinx.com, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: Add missing Xilinx
 INTC binding
Message-ID: <20250725-gentle-otter-of-stamina-c8e47b@kuoka>
References: <2b9d4a3a693f501d420da88b8418732ba9def877.1753354675.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b9d4a3a693f501d420da88b8418732ba9def877.1753354675.git.michal.simek@amd.com>

On Thu, Jul 24, 2025 at 12:57:57PM +0200, Michal Simek wrote:
> Add missing description for AMD/Xilinx interrupt controller. The binding is
> used by Microblaze before dt-binding even existed but never been
> documented properly.
> 
> IP acts as primary interrupt controller on Microblaze systems or can be
> used as secondary interrupt controller on ARM based systems like Zynq,
> ZynqMP, Versal or Versal Gen 2. Also as secondary interrupt controller on
> Microblaze-V (Risc-V) systems.
> 
> Over the years IP exists in multiple variants based on attached bus as OPB,
> PLB or AXI that's why generic filename is used.
> 
> Property xlnx,kind-of-intr is in hex because every bit position corresponds
> to interrupt line. Controller support mixing edge or level interrupts
> together and this is the property which distinguish them.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


