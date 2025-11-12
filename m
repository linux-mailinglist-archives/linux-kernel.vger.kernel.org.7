Return-Path: <linux-kernel+bounces-896528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422BEC5096F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB843B1D9E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 05:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB4C2D839A;
	Wed, 12 Nov 2025 05:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljMGYc6Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56272D7D47;
	Wed, 12 Nov 2025 05:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762924442; cv=none; b=CGOvm08foDJTZHR+Ds4wZThqC3YSxmLEK0s3eK1zLaLATCevIoW/J9d6TQyit+bwsBWuwSdauv0NNVXdic0yjDQ8birXnnp4NsPxOSJnL8pjdy44UcwJVUZfXs7msTJ9JkjwX4JDNZiuPWyRt7oWNtqy6z0ekhXgg1F9Vzz0Xm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762924442; c=relaxed/simple;
	bh=cgNF4HN70xxc3rYr6FAW93fJj7TyzlIzMRFjVUX+QiE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C1O5Qg8qQ1lZO+4FrAC94E/GhdGmOWudpYIaiVtVvzOW7J2jLLwgVn8T01Nqrurza8Y3FAV3mFykNahrXcxbowMEj13ys1e2LcaSAR64qXM2GOGi2OxSKMwjut9+DGonKxjsWqPhqsQke2XTb0VLNvimP76mhslUVqa8t0BgNBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljMGYc6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D61FC113D0;
	Wed, 12 Nov 2025 05:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762924442;
	bh=cgNF4HN70xxc3rYr6FAW93fJj7TyzlIzMRFjVUX+QiE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ljMGYc6Qv8rhrVNd0RALM1xrtBPxKWK0AzNYfSJFLzZsAaDkVXClfW9D7jhX4x5hR
	 0+KrXb9eq9Ev3+3Zv8dt2GoS40TqrHvPPspbMERV+9HH/smxoCMzVv6btgb/47URHF
	 aayNX/iYvR2+J81Zd0D7x4crxyAZVE4VrA/xPUw1G1HVWX3P0W1kMyxPtbZVUbB6TT
	 9buyIwTvbVxGhksAdh8v98i5Oj9hD+u90jqxlPyWiF8RXB2bUWgATwOStIl4klaydS
	 p/RKMJMPWjPBlJ2aftnCR4B7aCkBMRqzT+2Rf523E/9hwwnzikRzS/pAfC3YXbdTmb
	 4gKsbtLlZh/Rw==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.dev, bard.liao@intel.com
In-Reply-To: <20251014031450.3781789-1-yung-chuan.liao@linux.intel.com>
References: <20251014031450.3781789-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 0/7] ASoC/soundwire: add fake BPT frame to align Intel
 DMA buffer size
Message-Id: <176292443987.64414.1318404160840319574.b4-ty@kernel.org>
Date: Wed, 12 Nov 2025 10:43:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 14 Oct 2025 11:14:43 +0800, Bard Liao wrote:
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



