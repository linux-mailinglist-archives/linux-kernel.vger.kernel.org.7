Return-Path: <linux-kernel+bounces-874668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F33FC16D05
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C63934EE29B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC83271454;
	Tue, 28 Oct 2025 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=erdfelt.com header.i=@erdfelt.com header.b="OSFtPcc0"
Received: from out.bound.email (out.bound.email [141.193.244.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB1B28643C;
	Tue, 28 Oct 2025 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.193.244.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761684516; cv=none; b=BkkcU0l4mo9P3qlyIZ8MqlBAs0zn/d69zNhOBriyxJuexPX7qnkfF4dXNVx72HITBNfY+fO7dlxI/n0DSbZsNBmloLc518mWQL1fjR4MGLdhAW70PexpXmPNT19aGEHe3fJs+j0a5ZBO6GDgdcPVEtTgCQN8t1h4Ly259+QvpJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761684516; c=relaxed/simple;
	bh=qYOWts+NQppC4xFef6kWBvmLDk1lInrYFq5j3m3aHkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSENu+R9eDTzUGtH86Z6KfazCmOHdaizyjy6B6Af1hd3dIPjSErCddTX4kXtMTEkbzx1lBkHizO0RgbksoYgwnKzILACsbw07F3raohjm9JTP285abVNg21J3gB49rEKBvlMvbZhQFtnMnRG0g1uxhVJq/fV7YjzuTghWloQEgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=erdfelt.com; spf=pass smtp.mailfrom=erdfelt.com; dkim=pass (1024-bit key) header.d=erdfelt.com header.i=@erdfelt.com header.b=OSFtPcc0; arc=none smtp.client-ip=141.193.244.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=erdfelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=erdfelt.com
Received: from mail.sventech.com (localhost [127.0.0.1])
	by out.bound.email (Postfix) with ESMTP id D706C8A0A03;
	Tue, 28 Oct 2025 13:48:32 -0700 (PDT)
Received: by mail.sventech.com (Postfix, from userid 1000)
	id C0146160036F; Tue, 28 Oct 2025 13:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=erdfelt.com;
	s=default; t=1761684512;
	bh=RNFyMoBWxOdlyG9IRh7LHDULuVP6HOHggT33RZ17tAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OSFtPcc0BiEXbpb/zBzfoQcm4MgaSuhTYzck8MnN8tUCJrAuoXL2oxWiocPS5Y1hs
	 9resct6vmHBc4qujrDvZNwTjpr6wUxHZ9rT+3SFV9zhobx7B8zRG+2upkCexlAdgAE
	 5nd2gNmxIuKQyKhgQMR02+l8IRdi3C6uskXea2Ds=
Date: Tue, 28 Oct 2025 13:48:32 -0700
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Alex Elder <elder@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, vkoul@kernel.org, kishon@kernel.org,
	dlan@gentoo.org, guodong@riscstar.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, christian.bruel@foss.st.com,
	shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com, namcao@linutronix.de,
	thippeswamy.havalige@amd.com, inochiama@gmail.com,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Introduce SpacemiT K1 PCIe phy and host controller
Message-ID: <20251028204832.GN15521@sventech.com>
References: <20251013153526.2276556-1-elder@riscstar.com>
 <aPEhvFD8TzVtqE2n@aurel32.net>
 <92ee253f-bf6a-481a-acc2-daf26d268395@riscstar.com>
 <aQEElhSCRNqaPf8m@aurel32.net>
 <20251028184250.GM15521@sventech.com>
 <82848c80-15e0-4c0e-a3f6-821a7f4778a5@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82848c80-15e0-4c0e-a3f6-821a7f4778a5@riscstar.com>
User-Agent: Mutt/1.11.4 (2019-03-13)

On Tue, Oct 28, 2025, Alex Elder <elder@riscstar.com> wrote:
> On 10/28/25 1:42 PM, Johannes Erdfelt wrote:
> > I have been testing this patchset recently as well, but on an Orange Pi
> > RV2 board instead (and an extra RV2 specific patch to enable power to
> > the M.2 slot).
> > 
> > I ran into the same symptoms you had ("QID 0 timeout" after about 60
> > seconds). However, I'm using an Intel 600p. I can confirm my NVME drive
> > seems to work fine with the "pcie_aspm=off" workaround as well.
> 
> I don't see this problem, and haven't tried to reproduce it yet.
> 
> Mani told me I needed to add these lines to ensure the "runtime
> PM hierarchy of PCIe chain" won't be "broken":
> 
> 	pm_runtime_set_active()
> 	pm_runtime_no_callbacks()
> 	devm_pm_runtime_enable()
> 
> Just out of curiosity, could you try with those lines added
> just before these assignments in k1_pcie_probe()?
> 
> 	k1->pci.dev = dev;
> 	k1->pci.ops = &k1_pcie_ops;
> 	dw_pcie_cap_set(&k1->pci, REQ_RES);
> 
> I doubt it will fix what you're seeing, but at the moment I'm
> working on something else.

Unfortunately there is no difference with the runtime PM hierarchy
additions.

JE


