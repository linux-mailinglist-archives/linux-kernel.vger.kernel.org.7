Return-Path: <linux-kernel+bounces-896763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA693C512AE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4073B7E8C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A082FE58D;
	Wed, 12 Nov 2025 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTG+gFFE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACBD2FE06F;
	Wed, 12 Nov 2025 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937157; cv=none; b=R02RXRnzPo4CHSOdu6kaxMF9/2yByRbu56K6dOu3WscUJmdwWZ/i4tLtpfBQBJmxMws+tlzU0V1RxR+QIxE5QIeDDQwzKdD3+kB+8q/ik1haPIE4gLmRrtUb1mMnvmZ3pDq2vNO7wIWIirKcTSTqjF+MelnCRcgGzh+80U/Rju4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937157; c=relaxed/simple;
	bh=1ZQFJgKD8kSP0h/msfECsS0Q2OzzekcI6whc25wm6ZQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rhk1A5IzeHx6CNfZ1JI9437KkutoXmAg73MnUhjYXn/RhfO3wLT9UedI/hNj3TUqfx/jyRTw0pf1dgytyCZlhYYmbmKtSE1AC5+oD1y5dlyp70uvJGheOrqBC0ZTfKVpoibplLfZNLIJlf00caKHLDRV5ywjouBrL9v0SW3QvBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTG+gFFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D8EC2BC87;
	Wed, 12 Nov 2025 08:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762937156;
	bh=1ZQFJgKD8kSP0h/msfECsS0Q2OzzekcI6whc25wm6ZQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mTG+gFFE4RAUihSgTg9SgOdVkcwEjMXO/39vjGvgu3T8YL9Ek0t5xP01NH/e48uOA
	 AWgCK5b6stp5DQa3RgRubIJjVEySkrVDsQZVF3Jo55davWhDOvR+eJmGsMAVW31OL+
	 TURtF0N00A+X+9FNX6XmD54xUTtHS7rAGR2X3/3F7VBkdg8Wcbf7J17P5RPSmKUzCJ
	 HC8K7GxFxINeVYRGnWYK9hbjw02EHsIKr/R8MftlNpv/tHRtm/0CdmwLq8ALALEGvE
	 nBfirvVb4ZeAxrKly5t0d8IsiA6bsgjqAASdqBdyH9PDq2d+38BhatQ6czZYBFqp7D
	 kdCGV37hHhYrw==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.dev, bard.liao@intel.com
In-Reply-To: <20251021094355.132943-1-yung-chuan.liao@linux.intel.com>
References: <20251021094355.132943-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 0/3] soundwire: send multi sections in one BPT stream
Message-Id: <176293715439.98387.16675271054309970699.b4-ty@kernel.org>
Date: Wed, 12 Nov 2025 14:15:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 21 Oct 2025 17:43:51 +0800, Bard Liao wrote:
> Currently we send a BRA message with a start address with continuous
> registers in a BPT stream. However, a codec may need to write different
> register sections shortly. It makes more sense to send different
> register sections in a BPT stream and no need to close/open the BPT
> stream repeatedly.
> 
> This series depends on the "ASoC/soundwire: add fake BPT frame to align
> Intel DMA buffer size" series. Sending it now to get more review time.
> 
> [...]

Applied, thanks!

[1/3] soundwire: introduce BPT section
      commit: 96755433031e426353cee230abd0e6170d386787
[2/3] soundwire: pass sdw_bpt_section to cdns BPT helpers
      commit: 1fdffb2012767f12bba6bb5646a6967e5607caec
[3/3] soundwire: intel_ace2x: handle multi BPT sections
      commit: 336859050e5844b2e8b601dd126d5dc46f6c00f4

Best regards,
-- 
~Vinod



