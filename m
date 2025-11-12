Return-Path: <linux-kernel+bounces-896529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E10DDC50975
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2496C4EC9F9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 05:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8AD2D77FF;
	Wed, 12 Nov 2025 05:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rwf17Ah9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6775A2D9798;
	Wed, 12 Nov 2025 05:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762924445; cv=none; b=Ff8NqzfWoiLoeljhSAoNC/zZ8asMHaBm22QHmDNiQHekWDwSGa0neqNlpNIm5P3f13Q00/TzhOEP0fZQyzv/AITLEN/7moMu243gZ4cVt3aH3wX99JJ9C1swTG0yP0ZkaTo8g5g4riD63KH5zgBpXRLYcrys5qkJU9dfTusYdF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762924445; c=relaxed/simple;
	bh=0w0ugMGL+u1bfLJHEX32YPO9hOBMrnDSyoSCoozDccg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=axqvxKueVdPHrvTsmN1dnzqgEgIxvRDdBsMlGNKgUpxFPRX9gMYxox83eq1fbvVl/S1Gp8PAo/AukLjf0tH4bCsLJdamjRYS7s0GlZsxsNl9XgQmJUBoqpiR1eqt46stZjVldeBMhHu21/VSyllrxdoxRL9kXamXiEK4XmHlKWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rwf17Ah9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0032C4CEF7;
	Wed, 12 Nov 2025 05:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762924445;
	bh=0w0ugMGL+u1bfLJHEX32YPO9hOBMrnDSyoSCoozDccg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Rwf17Ah946tMtq9hwbOcCtAXCPD2ys23Pfb4slj7ToU/wjIg4+qET/Li1wgQtZxCr
	 EfIp79FAcWhJVUrqAacsf2IW17/OuOkqrIdGxaM1PXgJNKKKlvV3vfBvfcQY+EJHBz
	 CIUgxjz0+JbryHoddTYTfEsEA6xQWIiFjPMyLKjOe4DasqlIA+fiYAvAZhuh13L7+N
	 uxBwpr2nVxPGOyDUjJlyT7wuT1MezFta+R3CsPdTsTzQIQOiMJl29QHctdL2LwqX6y
	 SY87YD8OlejnLmuMXXblaWNKuzjOLyRWEB8l/ohUGfJPhTRDpNcZjgAtUF47ykiaQH
	 K6Zw8pl1nGaAw==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, broonie@kernel.org, tiwai@suse.de, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.dev, bard.liao@intel.com
In-Reply-To: <20251030070253.1216871-1-yung-chuan.liao@linux.intel.com>
References: <20251030070253.1216871-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH RESEND 0/7] ASoC/soundwire: add fake BPT frame to align
 Intel DMA buffer size
Message-Id: <176292444214.64414.17984655662156688458.b4-ty@kernel.org>
Date: Wed, 12 Nov 2025 10:44:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 30 Oct 2025 15:02:46 +0800, Bard Liao wrote:
> There is a constraint on Intel DMA buffer size that needs to be a
> multiple of data block size. This series adds some fake BRA frames
> to add some extra buffer size to meet the constraint.
> The change is mainly on the soundwire tree. It would be better to go
> through the soundwire tree.
> 
> Bard Liao (7):
>   soundwire: cadence_master: make frame index trace more readable
>   soundwire: only compute BPT stream in sdw_compute_dp0_port_params
>   soundwire: cadence_master: set data_per_frame as frame capability
>   soundwire: cadence: export sdw_cdns_bpt_find_bandwidth
>   ASoC: SOF: Intel: export hda_sdw_bpt_get_buf_size_aligment
>   soundwire: cadence_master: add fake_size parameter to
>     sdw_cdns_prepare_read_dma_buffer
>   soundwire: intel_ace2x: add fake frame to BRA read command
> 
> [...]

Applied, thanks!

[1/7] soundwire: cadence_master: make frame index trace more readable
      commit: 464101450bf8c16be6f6bd2cc48d3dfd7ab4a23a
[2/7] soundwire: only compute BPT stream in sdw_compute_dp0_port_params
      commit: 101bfbe88ae4944263fd58b2e0c265db263f793a
[3/7] soundwire: cadence_master: set data_per_frame as frame capability
      commit: 558abe5fadd03579351ce1c752b5961984b0fb86
[4/7] soundwire: cadence: export sdw_cdns_bpt_find_bandwidth
      commit: 207a5831b34834dd97ed2f0100bf936cf67e54c3
[5/7] ASoC: SOF: Intel: export hda_sdw_bpt_get_buf_size_aligment
      commit: 10ed028f7851f41d391c6b6516c9f8b3f95fac8f
[6/7] soundwire: cadence_master: add fake_size parameter to sdw_cdns_prepare_read_dma_buffer
      commit: d7941dc674aed1e9eed5e17fe46c3dde884fc948
[7/7] soundwire: intel_ace2x: add fake frame to BRA read command
      commit: 420399049ebba154bb82d5024d9a7d2de19ce1f8

Best regards,
-- 
~Vinod



