Return-Path: <linux-kernel+bounces-811854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EA5B52E9E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46E417B985D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A08C311C10;
	Thu, 11 Sep 2025 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPeidlrL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A4A314A95
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586712; cv=none; b=pUvWkuDkZUsz4khqUpxOLTxd0eg4JDUcpUCQAq1N8V6M8+pbta+vDLxvpykIgI1iFzMbvMIxarNvD2f279cmpqrJd2Vt2CoiMBQ2G8A/rgIS7doSNy2vk+Bl7E7LePALrNOs0AUQn0fxjFxr3WXJj1ULCxkooewJRymnNFBTGlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586712; c=relaxed/simple;
	bh=gS2weFUR+ncgV5TkM5dtRR0yU4ygK56P4uQOCMuOTVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOuiofjd5iZ7QBpBd5Pd4YGSGnY0Fopya+ggPw0FZ92abP8euX0bTTQZRrVI3ePXolUWDD6HqR3Sl0aVhKfNReoH2oPW6NfxyUvI8Aa5zigUhoN30S/IV4xLHaWPm87Kq1TgSkMnt5spKen6rmUvJ9NOApTpvnR4gbeFGH4JfkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPeidlrL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8575EC4CEF0;
	Thu, 11 Sep 2025 10:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757586712;
	bh=gS2weFUR+ncgV5TkM5dtRR0yU4ygK56P4uQOCMuOTVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MPeidlrLVFVQvIMpDQUjBt7aE3/Koh8LezVfJHAhOLft/ifOxDs13u2ZqvtoWoplT
	 f8A0Ju+FqdQyY/Z0RsvmB72DQLhrT0SOkF3OG3WXG8Zkcs/Nir5ZQxaQyuFrCL0+80
	 Iv9ImkmL3OQign8E/ewgSOAr2XvyYORbC9IjV9nPd+WX7QRjRA7+NKWkrc5P9zsk7z
	 ia2CFHUPHpD1HslbGUD7dtuCqjl1jfN9FbixTEh/TLohC6cl7C02C2WEiEqzlQd/rD
	 LJO2XzZFnHJ+f9bCaLr27zvRUSxY54MzsimYXoxrZjaZiAavcQ7j24WcczVzXqWIpv
	 +1WPDmxyt05Iw==
Date: Thu, 11 Sep 2025 11:31:47 +0100
From: Lee Jones <lee@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [GIT PULL] Immutable branch between the MFD and GPIO trees for
 v6.18-rc1
Message-ID: <20250911103147.GI9224@google.com>
References: <20250904130516.72266-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250904130516.72266-1-brgl@bgdev.pl>

On Thu, 04 Sep 2025, Bartosz Golaszewski wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Lee,
> 
> Please pull the following MFD changes that depend on commits I already
> have in the GPIO tree for the next merge window.
> 
> Thanks,
> Bartosz
> 
> The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:
> 
>   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio/mfd-stmpe-for-v6.18-rc1
> 
> for you to fetch changes up to df6a44003953fb23ad67f82d299e439e7ff7150a:
> 
>   mfd: stmpe: Allow building as module (2025-09-04 15:00:53 +0200)
> 
> ----------------------------------------------------------------
> Immutable branch between the MFD and GPIO trees for v6.18-rc1
> 
> Allow building the MFD STMPE driver as module.
> 
> ----------------------------------------------------------------
> Alexander Stein (1):
>       mfd: stmpe: Allow building as module
> 
>  drivers/mfd/Kconfig | 10 +++++-----
>  drivers/mfd/stmpe.c |  6 ++++++
>  2 files changed, 11 insertions(+), 5 deletions(-)

Pulled, thanks.

-- 
Lee Jones [李琼斯]

