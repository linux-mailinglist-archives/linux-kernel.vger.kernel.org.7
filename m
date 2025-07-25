Return-Path: <linux-kernel+bounces-746286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 761A5B124EE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 21:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE63189C761
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B383424EA9D;
	Fri, 25 Jul 2025 19:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6wBfuL8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBD0224225;
	Fri, 25 Jul 2025 19:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753473259; cv=none; b=qxjONfIcUD5pjOq+hS0NJ+uewKViPlghFewOcyaXKqJlzEatG74L8EkFfjV71M+Q8ZlewTuc3orTNhIxLb9prS/Ygfigm6+3CKTCnRUQs4XSxx7Rts5tv7pMHF9FsKutv0ftEmEJB5JavHBbEut8XU9KDR5t/4AgrhLNorHoKQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753473259; c=relaxed/simple;
	bh=HcLeuS221SxqUQm8rMuuyM10MPC2lhm7zpns7xmK5Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Puko53h9AyyrjHupc17i/8gvLnZOvr/RaLWU3U9/idIv7lXqKj2PYEUz+Od8uQTLSl0/bXl6ILxYtvC6pov7kvGpsCDFuScs0XWoIN8b8lonVZPtpo/mmCoanMcmF6dPJj3/bWTsIHllAZqA0jgmtmv855dRu/vhAJNRcFhz1hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6wBfuL8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F80C4CEEF;
	Fri, 25 Jul 2025 19:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753473258;
	bh=HcLeuS221SxqUQm8rMuuyM10MPC2lhm7zpns7xmK5Is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f6wBfuL8A4rnzpBkVWYd6tthrmMlB8Ki5O+LRupelBAldzvFuzX+jZKP+7+kkIdmU
	 WRgeW0bI7i7dvSO01p2ld7cJpa5tERPpi+Z3Fnz6/xOEcc6B1wXkd4RjPROh497PsT
	 DxwsHwGKs0QcJoTA6ZVNVdw1wGgblMeFhoO4ke8gB4o+PvHetmJAfp1LjgkG6KI+QL
	 ho8FcgCS7EmYprOBLYxXOBqUEhHiXIfx0lw8Dqs1BWq3/WgoFoBFRXbFJWktjZqG2g
	 XNfniHT2S8rOLY8PJl6zIrSbeoBBmpMB+2nm2/2dndBVfesFX2c47ZpRD/sGolWT1q
	 jLyxqMdjHgmug==
Date: Fri, 25 Jul 2025 14:54:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, michal.simek@xilinx.com,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	monstr@monstr.eu, Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	git@xilinx.com
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: Add missing Xilinx
 INTC binding
Message-ID: <175347325669.1744765.8437009717469539977.robh@kernel.org>
References: <2b9d4a3a693f501d420da88b8418732ba9def877.1753354675.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b9d4a3a693f501d420da88b8418732ba9def877.1753354675.git.michal.simek@amd.com>


On Thu, 24 Jul 2025 12:57:57 +0200, Michal Simek wrote:
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
> 
> Changes in v2:
> - update subject and commit message
> - drop second example
> 
> https://docs.amd.com/v/u/en-US/pg099-axi-intc
> 
> ---
>  .../interrupt-controller/xlnx,intc.yaml       | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/xlnx,intc.yaml
> 

Applied, thanks!


