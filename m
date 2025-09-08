Return-Path: <linux-kernel+bounces-806643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1E8B499CF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B893BFC05
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892902690EC;
	Mon,  8 Sep 2025 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="m1EbeoYy"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E540236435;
	Mon,  8 Sep 2025 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359247; cv=none; b=sKslOBOKg9Eh4ljt0U5jpIWRX8pkksoM28oZDhyIIk8QWdNXacf2KlCb9Igug2PHijsWP9a6+FOxYQrZ+OgmvH5accgZQ2Zvl+qdxUZfv9ZoYLozwNwxTvc+wxALLGZtDmpyXHVneG+WgWS93l9J13GGX5jMKnqXBPkO94/uNOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359247; c=relaxed/simple;
	bh=k7MgYVyUEIosceGm7Ovc7O5+H9yQCLAGqN73gKKtZEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgEmWa+WjZgB4h3bD/o8frnlNO1rdq8SltPoTR3btXFp2pQ2WGOvVeyANmbOOOtkTKfcu8zBuRi+10HhyngHYcSfiXbDvIieAgo7GvrpQH/0GTA2pXXR/pODKfS08BQzYPs23ywzEgXuutuj2Fpji7G0M8kT2nvV4/hRlDP5bv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=m1EbeoYy; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (xdsl-188-155-97-38.adslplus.ch [188.155.97.38])
	by mail11.truemail.it (Postfix) with ESMTPA id 656A2233EF;
	Mon,  8 Sep 2025 21:20:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1757359241;
	bh=bliwDgKbSpIP0SQAFOalQgK//vCgDNXhRwj9jFqniM4=; h=From:To:Subject;
	b=m1EbeoYy4+s3xyw7uU3sTOqfaPwbEnJNsJ7lj1GREHwujDCcBEec7zpb8I7wsHYIn
	 cJpeYLy6zzabWZR6eEBVql5DU83zDTaJSsQXvaND6Wt3szmdmoYc5My9SozACQwV/z
	 5OLX4+LIfigtIZLchdqChYdaJHYsXxBbS21wUl3UPXLhGvWPNXSZzj22HKuI2T0SOM
	 qm64EOA9lOtH1ny8RoMZoO1vQWW0HsYd0yjniTDbjJWOGockwQXFwiF6twK6K4wa2Z
	 Tu+QbMl959thRqJwBiNpJ5H3fhzXw4dhjxK0FviOiYx2DLga/sNHW9TpEzAYCSv5tk
	 egN8VNWQxwFxQ==
Date: Mon, 8 Sep 2025 21:20:35 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, afd@ti.com,
	u-kumar1@ti.com, hnagalla@ti.com, jm@ti.com, d-gole@ti.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Hiago De Franco <hiago.franco@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Parth Pancholi <parth.pancholi@toradex.com>,
	Jo_o Paulo Gon_alves <joao.goncalves@toradex.com>
Subject: Re: [PATCH v4 15/34] arm64: dts: ti: k3-am62p-verdin: Add missing
 cfg for TI IPC Firmware
Message-ID: <20250908192035.GA4217@francesco-nb>
References: <20250908142826.1828676-1-b-padhi@ti.com>
 <20250908142826.1828676-16-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908142826.1828676-16-b-padhi@ti.com>

On Mon, Sep 08, 2025 at 07:58:07PM +0530, Beleswar Padhi wrote:
> The wkup_r5fss0_core0_memory_region is used to store the text/data
> sections of the Device Manager (DM) firmware itself and is necessary for
> platform boot. Whereas the wkup_r5fss0_core0_dma_memory_region is used
> for allocating the Virtio buffers needed for IPC with the DM core which
> could be optional. The labels were incorrectly used in the
> k3-am62p-verdin.dtsi file. Correct the firmware memory region label.
> 
> Currently, only mailbox node is enabled with FIFO assignment. However,
> there are no users of the enabled mailboxes. Add the missing carveouts
> for WKUP and MCU R5F remote processors, and enable those by associating
> to the above carveout and mailboxes. This config aligns with other AM62P
> boards and can be refactored out later.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Verdin AM62P

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>


