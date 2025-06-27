Return-Path: <linux-kernel+bounces-705480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B0EAEAA03
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 00:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32F587A4842
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 22:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACC822F764;
	Thu, 26 Jun 2025 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8ro6kuH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F7C22A4EB;
	Thu, 26 Jun 2025 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750978090; cv=none; b=Bf0LsioR1oNmlDi13w4L0fOIIvy8uLdIOyPbZalzCY+HgNU3BNtc+VKQmC5M0HpbpX26sfzorjh/7xq2bn0mf1avf/2WzXU3LEYdKrYhRvX2f9BOMzzdud45ZqnzLddQqNCWr2ozyQuwKu4BoW31kfF4GD6mHX8RJJMFqjvI0lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750978090; c=relaxed/simple;
	bh=fCvhvhbFhOlfeOSp3pz3JSwPF/zNpq8GnnnbKYprUD0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iqA/4fihgVYt68Ii3D7GPnUAMJqX6SEncxaBc6/7BSBlzySU9ebyDj0ftWIeQl1NQdumn6dIDgMcONKKXcjy1uv3pvl+XBDbrhOYoBklOxjbk66MKfUn/9SjBW+f2nJH+n1qGPhig8/1r7H68twdJF9atxG9KAEU9ujrna1I9lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8ro6kuH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DACEC4CEEF;
	Thu, 26 Jun 2025 22:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750978089;
	bh=fCvhvhbFhOlfeOSp3pz3JSwPF/zNpq8GnnnbKYprUD0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=p8ro6kuHVP4rjmVN4MF+SX3pruihvHxk7qjD4XJHiiggv6p482O/uBd3JSRvtfTWx
	 5oFtEgl9QnCM+fCcxIJgeVuQcMNF0Etva2SaPsL51fGw9dGqI8ueYPuuI4j+DUOVQD
	 Plx45huqWvqeo2rp1+runItb0a5oUJFRk7pUTCufsNkIriFZ3pYpz2vgpO/uaRtIu4
	 qrKW4LlNTM0xlldnf74et4wYXoIZYWBU+Xv+5Am5+B0CDG6HhtmOlXlHUZ5Y+l2CSe
	 xoeOabeVqwCJ1ROiSvuE87brMa+aG24IYJ2oElOJ7UPEQI/5CggGyXp/qHoqI/yKLl
	 0KNSAmkOvAhQw==
From: Vinod Koul <vkoul@kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: dmaengine@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250624-stm32_dma_dbm_fix-v1-1-337c40d6c93e@foss.st.com>
References: <20250624-stm32_dma_dbm_fix-v1-1-337c40d6c93e@foss.st.com>
Subject: Re: [PATCH RESEND] dmaengine: stm32-dma: configure next sg only if
 there are more than 2 sgs
Message-Id: <175097808959.79884.12989914478900786264.b4-ty@kernel.org>
Date: Thu, 26 Jun 2025 15:48:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 24 Jun 2025 09:31:37 +0200, Amelie Delaunay wrote:
> DMA operates in Double Buffer Mode (DBM) when the transfer is cyclic and
> there are at least two periods.
> When DBM is enabled, the DMA toggles between two memory targets (SxM0AR and
> SxM1AR), indicated by the SxSCR.CT bit (Current Target).
> There is no need to update the next memory address if two periods are
> configured, as SxM0AR and SxM1AR are already properly set up before the
> transfer begins in the stm32_dma_start_transfer() function.
> This avoids unnecessary updates to SxM0AR/SxM1AR, thereby preventing
> potential Transfer Errors. Specifically, when the channel is enabled,
> SxM0AR and SxM1AR can only be written if SxSCR.CT=1 and SxSCR.CT=0,
> respectively. Otherwise, a Transfer Error interrupt is triggered, and the
> stream is automatically disabled.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: stm32-dma: configure next sg only if there are more than 2 sgs
      commit: e19bdbaa31082b43dab1d936e20efcebc30aa73d

Best regards,
-- 
~Vinod



