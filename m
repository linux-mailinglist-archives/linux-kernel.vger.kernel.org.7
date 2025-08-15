Return-Path: <linux-kernel+bounces-769783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7831B273B0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E18D9E73C4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F841DFF0;
	Fri, 15 Aug 2025 00:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kd73VYw0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCA035962;
	Fri, 15 Aug 2025 00:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217155; cv=none; b=j0zOxktKOqVAlAV8PR3DE7pkStDnHnsd2tD9hZOpswYfnOQlcCQjut1vcGplyk/B/0xI7mooSDnGsvOGKNqpcQ/e21U4c15fCWi4jiWks6yIrrb1x1mComhPSeyKiOwj4dIHOYnd52hcFuh+L6kaRMM/VziABCcsuwixoUTJ/hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217155; c=relaxed/simple;
	bh=g4zR21hNRbpIwW2GjR4PpTESla0shxBvfcD4TLxCbgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYyqS32MWqAuCDhju125zVypePM3MKIxWukkGouVcQ3Fs2boV11I/p9OmZfI3EhzuDS5NUtpObJl9zfEA/Ebg7K7J7pjjNxf6CACsebF2dF1Go2ngzRoB84kd42pdzYy85IrW3P+tekrFDae5mzXH7Mv/ZGRINRtktIIpiavtdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kd73VYw0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3238EC4CEED;
	Fri, 15 Aug 2025 00:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755217155;
	bh=g4zR21hNRbpIwW2GjR4PpTESla0shxBvfcD4TLxCbgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kd73VYw0MpCR4rPM18k9+ZktOhzAEjAUwD1o8+Fe6aPeWrMhI1AZwI0YZvijEZy8c
	 fIiewGAMhP1MPHIXrCt2fbHgPm8P616BSrRfUptBE8iCnanb4v1yJRSbg8klLocbi8
	 UpenqMDDDJBI97YRl2wpQn/HxQPQElh6IeoTiaS9IxlLmjLcVzS8jqfAcKWiAOBz+Z
	 FX+J6kNwaChIWnBSokvk+FKXB9J1hZzAamhiBG/nAy3NInMS++71/n7lUq8XXIdg++
	 V965Neoi4auIKv6LnymCAB15UyDqBG0ZxcC77/ogBns/5F5svd6x51x2um7UuqagQC
	 +AiIUSXjUYkbg==
Date: Thu, 14 Aug 2025 17:19:13 -0700
From: Drew Fustini <fustini@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Yao Zi <ziyao@disroot.org>, Han Gao <rabenda.cn@gmail.com>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] clk: thead: add support for enabling/disabling
 PLLs
Message-ID: <aJ59AfgQNHUpMM7x@x1>
References: <20250813072702.2176993-1-uwu@icenowy.me>
 <20250813072702.2176993-2-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813072702.2176993-2-uwu@icenowy.me>

On Wed, Aug 13, 2025 at 03:27:00PM +0800, Icenowy Zheng wrote:
> The 2nd control word of T-Head TH1520 PLLs contains a bit to put the VCO
> into reset state, which means disabling the PLL.
> 
> Some PLLs are put to disabled state by the bootloader, and the clock
> driver should be able to enable them.
> 
> Add support for enabling/disabling PLLs. PLLs other than DPU ones are
> set CLK_IS_CRITICAL to prevent killing the system -- they're meant to
> drive CPU or system buses (even the GMAC/Video ones are driving arbitrary
> buses).

Do you think there is a way in the future to allow disabling PLLs for
run-time power management?  I think it is more important right now to
get hardware peripherals working upstream like you are doing, but I was
curious if there is the potential to do something more granular in the
future.

> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
> No changes in v2.
> 
>  drivers/clk/thead/clk-th1520-ap.c | 38 +++++++++++++++++++++++++++----
>  1 file changed, 33 insertions(+), 5 deletions(-)

Reviewed-by: Drew Fustini <fustini@kernel.org>


