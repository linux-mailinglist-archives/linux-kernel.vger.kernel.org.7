Return-Path: <linux-kernel+bounces-732110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAC9B061F0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 846187A59E7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70DF1EF38F;
	Tue, 15 Jul 2025 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2CCGnG4p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0137719D093
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591242; cv=none; b=GXBwfu9aI1SU6Z8tjJIY6Q2WgK9iz+UvspqiVHAyiyqKlf5tfSzWbFNfnWG6ME5ZuuzS5/yZ/TVlDVqBnASGssJx+6x1anGKE4LL6kRIzJL8cf7bCgCYs1UzSC5nHasf0CmBm0RIWYJLjLFtoRzr8o92D8aC0a27Wb6pu1vDDJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591242; c=relaxed/simple;
	bh=En50aEqJNzpuh1WEs+Fp6uoiU6AmCKf+RDL/VzWszt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9rKs8/uJEsBdylztR22M5pIc60jRD4T5iUf2VsfSxxm0OIqpoeNzsNoF1o893weHLWYHC41Qm94fLc9i0mhwVCskCq/u4ncaH+gGJzS5w8OD31rcIM3zcH/DZQsD+zfJZcfx+miHp9V+ambtF641wRneYdPCJlGo5MbamKvfR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2CCGnG4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1610AC4CEE3;
	Tue, 15 Jul 2025 14:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752591241;
	bh=En50aEqJNzpuh1WEs+Fp6uoiU6AmCKf+RDL/VzWszt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2CCGnG4pFrOpGuNSJIEU1hjlLcOM5o574G+KnNbRNF/zoe3wnJwKEyzIRarpDU6yJ
	 yLcvcbK2wbIxwK5s/o+nsU6qbXgqGzSE1XM8TsG6vfgNHAEsPMK1FirLRzZmYkBYlZ
	 iPqamrhByiPXcTSZr/4K7tvMVRAjqqCTZ65G23qs=
Date: Tue, 15 Jul 2025 16:53:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Meng-Shao.Liu" <sau525@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] samples/kobject: fix path comment
Message-ID: <2025071548-spectator-driller-0dae@gregkh>
References: <20250715143001.27407-1-sau525@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715143001.27407-1-sau525@gmail.com>

On Tue, Jul 15, 2025 at 10:30:01PM +0800, Meng-Shao.Liu wrote:
> The introductory comment still says the example creates
> /sys/kernel/kobject-example, but the code actually creates
> /sys/kernel/kobject_example.
> 
> Update both comments to reflect the actual sysfs paths. Also,
> fix "tree"->"three" typo in kset-example.c.
> 
> Signed-off-by: Meng-Shao.Liu <sau525@gmail.com>

Please use your name correctly, I doubt it has a '.' in it :)

> ---
>  samples/kobject/kobject-example.c | 2 +-
>  samples/kobject/kset-example.c    | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Your patch series was not threaded, what happened?  When you resend, try
to use something like git send-email to have that work properly.

thanks,

greg k-h

