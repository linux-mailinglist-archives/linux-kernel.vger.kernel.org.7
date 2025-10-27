Return-Path: <linux-kernel+bounces-870763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B657DC0B9E7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 02:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E143A6740
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 01:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E51B2BD597;
	Mon, 27 Oct 2025 01:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="UPLac+tu"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBF418C02E;
	Mon, 27 Oct 2025 01:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761529625; cv=none; b=LLydXwio+/zIeOh/BLBteNAIBH4Yd3Fd5yHqdFn00xi5RsGNeb7vfvcII+ObMziFVb/CbdOJZIDUOcg66MLRI1T23o94IKuC+orc+F+p9iDqBfSgWoDKx+rtocttBKRJfIVvaju+DKTU6n9gdaImpWdSNPrWVGB3GqiiGc6qKMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761529625; c=relaxed/simple;
	bh=2pqybzfD5VlFGHF1/lFEzi3zo5TlFv9a8oX9Bn+ozAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRslgFySzS2pVuz4LfZFExXEpdJ4gLaUWq0hlptwL2yPaLQxvh5Tpt8rMZxu1S6eEAJVWNMvvu7kSHog2ONwa3VQgkNJRJK12cgIp6gYuGgEYKNbBxt+jh0txRN5iagmawmVzLIkQ083ECArUrRfezDgHBP1aimJ6jBxFjilkrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=UPLac+tu; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1761529575;
	bh=JKvBZjDsOTLXyIrjlq85SYk3IB+FQ+tslKn3pT1PxHA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=UPLac+tuxzsHRI3RP4isHvZ/CbFKkTj0viW6zjbFrcBLqpOAlAU3+hOHBSlpW6UaV
	 9YS1H+Jr/Uh1ezEaVzrtxiIWLov7Ip9M5s6PO2q5NSLIW4/PUyURfTBALasdz3ZqUx
	 WGyow4S2l3apOkx5OI5I13mOaF6pl9tATnM2zakw=
X-QQ-mid: esmtpsz11t1761529569t620f5b47
X-QQ-Originating-IP: gRCZCvClcdLqDxlvoHtFPbNT2eMAdSDim737RLKZi24=
Received: from = ( [183.48.247.177])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Oct 2025 09:46:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1112444510141004708
EX-QQ-RecipientCnt: 17
Date: Mon, 27 Oct 2025 09:46:07 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 0/6] clk/reset: anlogic: add support for DR1V90 SoC
Message-ID: <A61F456C6F5290B8+aP7O37HtuMNAYHpi@kernel.org>
References: <20251026-dr1v90-cru-v2-0-43b67acd6ddd@pigmoral.tech>
 <0E60AA15166FED21+aP7JRmPzDIq2WhWw@kernel.org>
 <1bceed11-e7d2-4d10-93fc-b40c6e102bc5@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bceed11-e7d2-4d10-93fc-b40c6e102bc5@pigmoral.tech>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M9JuRt4Rc2r2oDU/NHKLbAQnXUpEL9vQnIroHbnehM7r8wSiM+robU4x
	FLKkYrNylWDkMKgw3Qp4sG60EMNrGdadfze6xSqckLgvcOFj4o9KqAhxcBucr834wAyYooL
	sNAKR0fAJQOeBEltqV+UWltHc1s43HlZCgbUy4FdZuwhEbus7Nb7TIuRPbX4bIv5jsEKUEh
	ztEKL9ZgYQ0CPwALKEiS3UEbXuRRchLOLInptNJ8irTESSVtZOQMszKdam3xsNap7ODVlbX
	DsskqfHTXnGcxQiVY3Hq35JcQk1kkLdhdrYC97AtbsjVI4/pxibQFmpLLI9suqo2Nr7+GyT
	A0VP8yOJ2YAmMS3zbbSIS/Q7QmEScdCpGq6+g3Gd3iSMD1pCzfvfCYpssQ1XkmuRG34SUHL
	CGVFqLBQ6sno/Tc4/Kelnt4FjzcBzUFngvmwsGr2I2OKYk0jq6vmkTpuHWntgUYQgGRwtxR
	y1Zeyx8Sz22QxVvJs3Lq9ku7fp2MFe76WfKS2cXFSahqkbUmv0y/T/mAVc8p5U0ovCyeM98
	alh0INwzOHuhGPbIuQTw6XIEiGd0xe4RCY8JAJv/jU4jNLLkLR1mz42PjFN9edlR7ge70mg
	3Qe2+RbtkmUsTJndum4bkcagzl+tkQQdu1p7DexoQOSxchLi+i+ktIw437fPnelHDWsQ6XB
	q35VOfmHr0rDp+jbhpoz7tAYrL4p3pMNsIceohHoOcGuqOKcYwgM5y/f5B0m9zphSNsAPdv
	6nYpdLXFdYCQSbgRUxPOkSlsC2nWallKzXsCkvvqc763h+p9bmiEMybIrOTS3eEy5S/ISOG
	5AYvn28xiRyJFCiGIqzUD7POT6R2OdmapHBQbt/2BUwTT6cG0FxP3mHrPcPCW5TeRJL6RWp
	Sh8+yPpIWqwJwJlYbirYMPBjHDOrAwwH5GQe25h75HdVKu5J/Jbf+cccrtY5wTAdjRLB+Lz
	+TIUTK1F7ipoxpIeGH7azU5fgEt1oYVTJ3SBDVZ0hQfCL/M00lfLgc/e+QhPjTwT9s/67sZ
	02bXL7lkhqaLFBLxzVAft6bRNNBvJapXt4a/m5Adtg9nz5eNpSzTptteS/dX2Ea+Zz2g+Em
	6le4rB20pLRcZua/r1ca/eSsfPbm2SfO8l8VackB62L2F//KdyY1uRyy/m38vH8wQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Mon, Oct 27, 2025 at 09:39:09AM +0800, Junhui Liu wrote:
> Hi Troy,
> 
> On 10/27/25 9:22 AM, Troy Mitchell wrote:
> > On Sun, Oct 26, 2025 at 10:00:40PM +0800, Junhui Liu wrote:
> > > This adds Clock and Reset Unit (CRU) support for the Anlogic DR1V90 SoC,
> > > as well as corresponding dts bindings and dts integration.
> > > 
> > > The CRU driver framework is built around the clock controller as the
> > > primary device, with the reset controller implemented as an auxiliary
> > > device. The clock part refers to the vendor's code [1] to determine the
> > > structure of the clock tree.
> > > 
> > > The Anlogic DR1 series includes not only the DR1V90 (based on the Nuclei
> > > UX900 RISC-V core), but also the DR1M90 (based on the Cortex-A35 ARM64
> > > core). Most of the clock tree and CRU design can be shared between them.
> > > This series only adds CRU support for DR1V90. Nevertheless, the driver
> > > is structured to make future extension to other DR1 variants like
> > > DR1M90.
> > > 
> > > This depends on the basic dt series for DR1V90 SoC [2].
> > > 
> > > Link: https://gitee.com/anlogic/linux/blob/anlogic-6.1.54/drivers/clk/anlogic/anl_dr1x90_crp.c [1]
> > > Link: https://lore.kernel.org/all/20251021-dr1v90-basic-dt-v3-0-5478db4f664a@pigmoral.tech/ [2]
> > > ---
> > Do we really need a cover-letter? Since you only have one patch, Is it
> > better to put the above information below the --- line in the actual patch?
> 
> Yes, we do need a cover letter since there are 6 patches in this series.
> I think the b4 tool only added you to the To list in patch 0 and 1 because
> you gave a Reviewed-by to patch 1 in v1. You can check the full patch
> series from the mailing list [1]. Thanks.
> 
> [1] https://lore.kernel.org/all/20251026-dr1v90-cru-v2-0-43b67acd6ddd@pigmoral.tech
OOPS!I missed that...
Thanks for your link.

                - Troy


