Return-Path: <linux-kernel+bounces-783268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFCBB32B19
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35B3179355
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159CF293B73;
	Sat, 23 Aug 2025 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="VDwQcKNf"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB794481DD;
	Sat, 23 Aug 2025 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967418; cv=none; b=fXaLQRIkkkVJrjwKxRqPldDLGm0UpWRGMQWIZqVPlbH757/GspD48u/g/FhbgA61cA3NI/YbopbLxxa8OHxk6fi50rj69Lkro4fMVPCUWLO1lT0yfpdo072Ebfwx3vUlyLdncgb6O2vXPT6lzFHyhFyam028qte5HNAGWFbZtkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967418; c=relaxed/simple;
	bh=4Og8yNETlVlq7K3HbRNBFTfh1ekXURDTYRiAcTqmXz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzRXshmHo6iW2b0Ix/KlECxtp1pSiXZ/vakgTtQQtoXBoCnEa8y/oVP3TUV98y1pz2usXT2UScVrprB2jJYKc0RPFrpzgqGeCh8IeAIie86r+362a6NPro2+bQQivIs5LBXjY2axECOPG4+7XRD//kiM4PTFl/Ani9gCwotFdok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=VDwQcKNf; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id A770F22BD1;
	Sat, 23 Aug 2025 18:43:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1755967406;
	bh=al4cMcBWRH9QgIUZIz9Q7Wj6h73BaDiii1apCj2i8oI=;
	h=Received:Received:From:To:Subject;
	b=VDwQcKNfKWVRs3Ur1vxksqe0mDrvIRYusFgqfjqnoWR4gfhuN2nVjF2k664KWqZ92
	 1iw/Vyy+i86F6UAE+Bsu7BUP4KkgDvepAuMwAyveFyXIKtSBtJCk+nylsDtp5CKPXf
	 PnIEe2Jd8w2WqFP4cJN1vkLpbGHVots+a4HgbTcbqn9TC4Ri5hpB0m5ZNRweKGmRLB
	 56qtB+TLS2SREtdusePEGjXBPk67NLt7amc2eJDLgxSq0dGe8kNCJnG+PruISc75S/
	 yHJEiLUR9DM4jE9x7N7ClfovxOJHn2OvpUmQUOlcZqLqorZmg4m9+3lBIPl9D1QwbX
	 vCxc3pE3MfWyQ==
Received: from livingston (unknown [192.168.42.11])
	by gaggiata.pivistrello.it (Postfix) with ESMTP id 608B67F996;
	Sat, 23 Aug 2025 18:43:26 +0200 (CEST)
Received: from pivi by livingston with local (Exim 4.96)
	(envelope-from <francesco@dolcini.it>)
	id 1uprKw-0002Hl-0k;
	Sat, 23 Aug 2025 18:43:26 +0200
Date: Sat, 23 Aug 2025 18:43:26 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Beleswar Prasad Padhi <b-padhi@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, nm@ti.com, vigneshr@ti.com,
	kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, afd@ti.com, u-kumar1@ti.com, hnagalla@ti.com,
	jm@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Parth Pancholi <parth.pancholi@toradex.com>,
	Jo_o Paulo Gon_alves <joao.goncalves@toradex.com>
Subject: Re: [PATCH 16/33] arm64: dts: ti: k3-am62p-verdin: Add missing cfg
 for TI IPC Firmware
Message-ID: <aKnvrh2TSksb_39i@livingston.pivistrello.it>
References: <20250814223839.3256046-1-b-padhi@ti.com>
 <20250814223839.3256046-17-b-padhi@ti.com>
 <20250821060629.GB7503@francesco-nb>
 <ecff956d-1019-41d0-9bfc-b0bdc30e87ba@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecff956d-1019-41d0-9bfc-b0bdc30e87ba@ti.com>

On Fri, Aug 22, 2025 at 10:09:48PM +0530, Beleswar Prasad Padhi wrote:
> 
> On 8/21/2025 11:36 AM, Francesco Dolcini wrote:
> > On Fri, Aug 15, 2025 at 04:08:22AM +0530, Beleswar Padhi wrote:
> > > The wkup_r5fss0_core0_memory_region is used to store the text/data
> > > sections of the Device Manager (DM) firmware itself and is necessary for
> > > platform boot. Whereas the wkup_r5fss0_core0_dma_memory_region is used
> > > for allocating the Virtio buffers needed for IPC with the DM core which
> > > could be optional. The labels were incorrectly used in the
> > > k3-am62p-verdin.dtsi file. Correct the firmware memory region label.
> > > 
> > > Currently, only mailbox node is enabled with FIFO assignment. However,
> > > there are no users of the enabled mailboxes. Add the missing carveouts
> > > for WKUP and MCU R5F remote processors, and enable those by associating
> > > to the above carveout and mailboxes. This config aligns with other AM62P
> > > boards and can be refactored out later.
> > > 
> > > Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> > > ---
> > > Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > > Cc: Parth Pancholi <parth.pancholi@toradex.com>
> > > Cc: Jo_o Paulo Gon_alves <joao.goncalves@toradex.com>
> > > Requesting for a review/test.
> > > 
> > >   arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi | 42 ++++++++++++++++++++-
> > >   1 file changed, 41 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
> > > index 6a04b370d149..0687debf3bbb 100644
> > > --- a/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
> > > +++ b/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
> > > @@ -162,7 +162,25 @@ secure_ddr: optee@9e800000 {
> > >   			no-map;
> > >   		};
> > > -		wkup_r5fss0_core0_memory_region: r5f-dma-memory@9c900000 {
> > > +		mcu_r5fss0_core0_dma_memory_region: mcu-r5fss-dma-memory-region@9b800000 {
> > > +			compatible = "shared-dma-pool";
> > > +			reg = <0x00 0x9b800000 0x00 0x100000>;
> > > +			no-map;
> > > +		};
> > > +
> > > +		mcu_r5fss0_core0_memory_region: mcu-r5fss-memory-region@9b900000 {
> > Node name should be generic, `memory@9b900000` ?
> 
> 
> Humm, that memory is reserved and has the 'no-map' property. So it
> technically is only used by the node which references it (a particular
> rproc in this case), and never used by Linux for any allocations. So it
> is not generic memory per say...
> 
> So I was inclined for putting the specific node name which uses the
> carveout in the label. What do you think?

My understanding is that the node name must be generic, as required by
the DT specification. What matters is that this is memory, not what is used
for.


So it should be something like


mcu_r5fss0_core0_dma_memory: memory@9c900000 {
	compatible = "shared-dma-pool";
	reg = <0x00 0x9b800000 0x00 0x100000>;
	no-map;
};


Francesco


