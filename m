Return-Path: <linux-kernel+bounces-788365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A519B38366
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99E94621DA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B911350D5D;
	Wed, 27 Aug 2025 13:09:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A2833F9;
	Wed, 27 Aug 2025 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756300197; cv=none; b=UbD3FHhLom6zVjlm9wnRYRrzRDJm9jjkv3WUwbA/m79f/Jr5SHYKlRKcQoaWbB9oB4+vKwREstPpVYKeb7EJOhagS6SxQVMITXp9DTX9RdNR2jCY7/ujnGsmwCyS/kvEtme8zYH8WKDqEyA/Ph2QvqJhFYj7lD19q5nomjUYHrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756300197; c=relaxed/simple;
	bh=D3+PuIC2hj+Z79JjrDH0FHlZ91TH9OUwHrcIMtATjIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gzCq9j55BJCjMurgGaG/Lh+Qw6lTp9um/5R+RXSbBrw5xRts1YkgiFNtq1jkVYpYH5f/hSMfgagFnylG+5QG5sS7/5XGWgWX0p9d44rfD6/AMl+yHL3lRHpr+w0Puzd9KdDsv6m8ZrVdYy2qx82j/XTrkxGDPTRdVQBggyymSn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DF141688;
	Wed, 27 Aug 2025 06:09:47 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 119673F694;
	Wed, 27 Aug 2025 06:09:53 -0700 (PDT)
Date: Wed, 27 Aug 2025 14:09:38 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej@kernel.org>, Samuel
 Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: t527: orangepi-4a: Limit eMMC
 clock to 75 MHz
Message-ID: <20250827140924.1340417f@donnerap.manchester.arm.com>
In-Reply-To: <20250821132935.2070398-1-wens@kernel.org>
References: <20250821132935.2070398-1-wens@kernel.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 21:29:35 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

Hi Chen-Yu,

> From: Chen-Yu Tsai <wens@csie.org>
> 
> The eMMC on the Orange Pi 4A doesn't function correctly at full speed
> of 150 MHz under HS200 mode. Either the traces on the board or module
> aren't great, or the SoC's internal delays are incorrect. Tuning the
> pin drive strength did not help.
> 
> After some experimenting, 75 MHz was found to be stable enough. Use this
> as the maximum frequency for now.
> 
> Fixes: de713ccb9934 ("arm64: dts: allwinner: t527: Add OrangePi 4A board")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
> index c52d09cf0888..fb5311a46c2e 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
> @@ -160,6 +160,7 @@ &mmc2 {
>  	mmc-ddr-1_8v;
>  	mmc-hs200-1_8v;
>  	non-removable;
> +	max-frequency = <75000000>;

I am not a big fan of this change, as it looks like we are papering over
something. I think the BSP runs it as a higher frequency just fine, can
you check that? Traditionally the BSP uses HS400, IIRC, maybe we should
finally bite the bullet and enable that?

Mikhail has some other assorted changes to beat his WalnutPi into
submission, among others a slight increase of the voltage, both I/O (1.9V)
and supply (3.4V). Also he increased the pins driving capability to 40mA,
did you try that?

On my boards I tried to lower the frequency as well, but didn't get
consistent results, though there was *some* improvement (at least probed
the block device and read the partition table). And I needed to go much
lower (40 MHz), so I wonder if this is all related to some bigger
underlying issue.

Cheers,
Andre

>  	vmmc-supply = <&reg_cldo3>;
>  	vqmmc-supply = <&reg_cldo1>;
>  	status = "okay";


