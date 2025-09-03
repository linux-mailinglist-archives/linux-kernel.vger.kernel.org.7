Return-Path: <linux-kernel+bounces-799549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA55FB42D71
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D2E1C22FE3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C3D27B4E4;
	Wed,  3 Sep 2025 23:30:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139D8288D6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 23:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756942238; cv=none; b=Kb9bsJVkjtezoLsFeAoIIvuvaz9jv9jqnKZvRJcyqXO6efP1rr+dLURUNbq63Wx/imExgC4q8YK0m0ReHdVlTfr8s+VHe404dWjbA3NB5YXUjRYSMhYMzffD59YGKd2RfJmWDpDKezDFJ7RevrcMH9Ppx5Oc2mm5L2E/rFCRlLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756942238; c=relaxed/simple;
	bh=R77PUmAdq2xcedWiw/KDGLeaR9hcOu5mkKt6gdVeDgg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZE0CwNSWFoLb59kISBcK8s7nefg9uSgwoCU/Lkfa/mxe0187UurrG7Cvux0g1dwwKWAgi3wfR5J30Dp52XUDmlTRP1dATq6tHp1Yhb9EcHBdARfnjIDxOJzhOHoGrre89qepX2p73ein3sFkKrFAI6mvvPQKnN1SIap+PI6hoyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF4A61655;
	Wed,  3 Sep 2025 16:30:26 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E1483F694;
	Wed,  3 Sep 2025 16:30:33 -0700 (PDT)
Date: Thu, 4 Sep 2025 00:29:24 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Lucas Stach <l.stach@pengutronix.de>, Russell King
 <linux+etnaviv@armlinux.org.uk>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, linux-sunxi
 <linux-sunxi@lists.linux.dev>
Subject: drm/etnaviv: detecting disabled Vivante GPU?
Message-ID: <20250904002924.2bc63b73@minigeek.lan>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

the Allwinner A523/A527/T527 family of SoCs feature a Vivante
"VIP9000"(?) NPU, though it seems to be disabled on many SKUs.
See https://linux-sunxi.org/A523#Family_of_sun55iw3 for a table, the
row labelled "NPU" indicates which model has the IP. We suspect it's
all the same die, with the NPU selectively fused off on some packages.

Board vendors seem to use multiple SKUs of the SoC on the same board,
so it's hard to say which particular board has the NPU or not. We
figured that on unsupported SoCs all the NPU registers read as 0,
though, so were wondering if that could be considered as a bail-out
check for the driver?
At the moment I get this, on a SoC with a disabled NPU:
[    1.677612] etnaviv etnaviv: bound 7122000.npu (ops gpu_ops)
[    1.683849] etnaviv-gpu 7122000.npu: model: GC0, revision: 0
[    1.690020] etnaviv-gpu 7122000.npu: Unknown GPU model
[    1.696145] [drm] Initialized etnaviv 1.4.0 for etnaviv on minor 0
[    1.953053] etnaviv-gpu 7122000.npu: GPU not yet idle, mask: 0x00000000

Chen-Yu got this on his board featuring the NPU:
    etnaviv-gpu 7122000.npu: model: GC9000, revision: 9003

If I get the code correctly, then etnaviv_gpu_init() correctly detects
the "unsupported" GPU model, and returns -ENXIO, but load_gpu() in
etnaviv_drv.c then somewhat ignores this, since it keeps looking for more
GPUs, and fails to notice that *none* showed up:
/sys/kernel/debug/dri/etnaviv/gpu is empty in my case.

Quick questions:
- Is reading 0 from VIVS_HI_CHIP_IDENTITY (or any other of the ID
  registers) an invalid ID, so we can use that to detect those disabled
  NPUs? If not, can any other register used to check this? The whole
  block seems to be RAZ/WI when the NPU is disabled.

- Would it be acceptable to change the logic to error out of the
  driver's init or probe routine when no GPU/NPU has been found, at
  best with a proper error message? As it stands at the moment, the
  driver is loaded, but of course nothing is usable, so it keeps
  confusing users.

Happy to provide a patch, but just wanted to test the waters.

Cheers,
Andre

