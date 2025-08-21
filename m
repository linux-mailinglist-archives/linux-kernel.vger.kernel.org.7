Return-Path: <linux-kernel+bounces-779016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAACAB2EDF5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259135C31F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C028B2D4B4E;
	Thu, 21 Aug 2025 06:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="cFE8T77p"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4342BE650;
	Thu, 21 Aug 2025 06:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755756743; cv=none; b=Y+anwEFavwcnGAraasNzFhZksFk+TcLxhmg8mbd6i+8LlNkOzVuff5t7/c0u/Q11uNg+h/CWQg5koYd9z9jUzX2lkRC3P/z6gVp/G1PbrlGsOI/2DdbKSiVNcC1yVx0umUbyupMBG3BOuCyPwOpkNSY3AC+/y+cnCp4hJdcg3TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755756743; c=relaxed/simple;
	bh=CzxfccKrtMEEzkSH2+ygqDSXtTq9nxXXPzhwFOSsVGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRPMNgHeaVhact+FsFiU3rLBkv9wOJm0DuoMwJnuYY6tKcTgxYxAvS7zsPZML5Of6qnjMms3OSW/R0lU3glEH4W3SNyHT6MOjdZ+ySdnvzendhiVAtB6R/N3Zag9zuTkTkpP+cc74pgGXai2UTk1gugWiKfpEtKNTDgjm/BODPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=cFE8T77p; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 573EF1F967;
	Thu, 21 Aug 2025 08:12:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1755756737;
	bh=rErWGumZLu4gwIsfX6lXxOGxFuhRmHleVgPyO8kQS3o=; h=From:To:Subject;
	b=cFE8T77pvcGGVJmwfcXad9fpSzJgRG5tXoWvAjOUqPkWZwb9aEOINBoC1svyqtVs6
	 cIbxleeF9U9c9BdadbJSl9mqYUn9vqO4XjUUckakgPO2SkIFpkzIiD7/RuOjWwLWgB
	 riZVdNIcIxXq+6FnvS0ZA2ajzIlUAJXLYuUVDtptrXeDGtSynfh4RElCX6H1T5tWvr
	 lElNS8Ty3fdOHFGT93z5GC/w1DLiYvJrIXvv4R5GGRTJxpOd5yJefAB4N7z94BV/KH
	 X/G0YMh9lTeyLuz0QqlnHdk6gRyWDxaTU6w3tmf0SY6BdawJmmQtm6Ie1AbB7ZhyS6
	 dq4focRSoKbDw==
Date: Thu, 21 Aug 2025 08:12:14 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, afd@ti.com,
	u-kumar1@ti.com, hnagalla@ti.com, jm@ti.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Jo_o Paulo Gon_alves <joao.goncalves@toradex.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	Max Krummenacher <max.krummenacher@toradex.com>,
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: Re: [PATCH 18/33] arm64: dts: ti: k3-am62-verdin: Add missing cfg
 for TI IPC Firmware
Message-ID: <20250821061214.GC7503@francesco-nb>
References: <20250814223839.3256046-1-b-padhi@ti.com>
 <20250814223839.3256046-19-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814223839.3256046-19-b-padhi@ti.com>

On Fri, Aug 15, 2025 at 04:08:24AM +0530, Beleswar Padhi wrote:
> The wkup_r5fss0_core0_memory_region is used to store the text/data
> sections of the Device Manager (DM) firmware itself and is necessary for
> platform boot. Whereas the wkup_r5fss0_core0_dma_memory_region is used
> for allocating the Virtio buffers needed for IPC with the DM core which
> could be optional. The labels were incorrectly used in the
> k3-am62-verdin.dtsi file. Correct the firmware memory region label.
> 
> Currently, only mailbox node is enabled with FIFO assignment for a
> single M4F remote core. However, there are no users of the enabled
> mailboxes. Add the missing carveouts for WKUP R5F and MCU M4F remote
> processors, and enable those by associating to the above carveout and
> mailboxes. This config aligns with other AM62 boards and can be
> refactored out later.

Are these memory ranges fine with 512MB DDR memory?


