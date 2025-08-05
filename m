Return-Path: <linux-kernel+bounces-756557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1C0B1B5FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A7316E78D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576FA27E1D0;
	Tue,  5 Aug 2025 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yqolqbm7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE06A278771
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754402708; cv=none; b=NzpAv6lwuLB/W+cpon8uVjDUkn3AtWGZqteMc8M8RoafJQ3H3/az2PTdt93NttbnGBGu5WkzhTJmNuJG+3CjhV5KloKw9sB2b/JAXqiYWW1uiBEE9PpGA4LZ9cSDgo79ttaUedfdmpSFpz1NvWNJXj3IVRXjXS+CgM4GE0w94DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754402708; c=relaxed/simple;
	bh=kTbQlLHadq8Qyhgv+ihd8unPEbfse/RrJPWvdHSevr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSvZbOoUrcWKaFM4XEsH0inpROu3FNPYIpm52Zzm73m8VWAo2M8jSgo/cBZnnkGN9Gay+7NPrzhi9EviYlmTPQaGpljvnZkLSyLkvpIblyFUPNTpqGU4lK/t3Z1YOz3w8ax/r/m9pByVHC3mKbWNqo6+c1z9zrSLMZVoxQ52uDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yqolqbm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512C8C4CEF0;
	Tue,  5 Aug 2025 14:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754402708;
	bh=kTbQlLHadq8Qyhgv+ihd8unPEbfse/RrJPWvdHSevr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yqolqbm76SUa3LpLoucSg/mlXFQ/iKXKihj3GMcpSGX8ZAL/cHkLZB9apmIiITGza
	 8RKaVU4SfHuiKJP569CID9jYNRVJChyuqr8hme7wUnD/aHU4baCSt9PgBExMspUmba
	 nYa+gvFS0FIXfwuYREkTz0GXtebitUI+iGDY7UTRjTe8OSKa6l+ZWmaRm1emdETEJj
	 4UKMdMo5nrxQY6+LA7aR0hMbA76/rhqCAC+kVNTQ/6woRduxy2SHg2sXltcZH4X7WO
	 nKvdEQcTUiF9WbhI67PVo7gUi3JCnvMmPKCZLtV65GyD+bryGuoGf6U/wTiZNcqBW1
	 lRYFzswvtT8Ww==
Date: Tue, 5 Aug 2025 09:05:04 -0500
From: Rob Herring <robh@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, S32@nxp.com, linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 01/20] clocksource/drivers/vf-pit: Replace
 raw_readl/writel to reald/writel
Message-ID: <20250805140504.GA1529859-robh@kernel.org>
References: <20250804152344.1109310-1-daniel.lezcano@linaro.org>
 <20250804152344.1109310-2-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804152344.1109310-2-daniel.lezcano@linaro.org>

On Mon, Aug 04, 2025 at 05:23:19PM +0200, Daniel Lezcano wrote:
> The driver uses the raw_readl() and raw_writel() functions. Those are
> not for MMIO devices. Replace them with readl() and writel()

Typo in the subject: reald

