Return-Path: <linux-kernel+bounces-841523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D71BB7947
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 452AB3471AA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBE42C15B7;
	Fri,  3 Oct 2025 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TNSYP1xM"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47078F7D
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759509556; cv=none; b=BKEY5LpVUA9bkSjk99VgEk4kC+4027DwzTUshisIhVwBek/Hy/+QN11272OFER+apEzWBio0kZQjzlmyccAbhQKXI/ShTbO/8yLoiMQwYvIAjWVocLgeCLkizfXyQN0ZnjtTWsTqnY5bxvTeWgMoiWnkVmuwJp50kTktm/3d/0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759509556; c=relaxed/simple;
	bh=flWy0wy52AJtdu3sH/w7VS3n46/g3z25QbyuAkeY5/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AH3DEU3gYU8ocXKz9QJzlqCk+nhS7+KM74JLRFS9T8guQ/cWAyJA74URNqZNqbPwq5BhEQMimnPvKIgWuA2u+mKk4mlzdFpMZRqj08rlnfsJCDRhbmZYg3ynNoT1U3VBUOY71/NEQaeh/YUvgccnADZlFtc2URvNeM0kMRmg4/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TNSYP1xM; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3FC411A10EA;
	Fri,  3 Oct 2025 16:39:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EBD5F60683;
	Fri,  3 Oct 2025 16:39:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1D51D102F17C4;
	Fri,  3 Oct 2025 18:39:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759509552; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1F9JLF84oqNjZaJLCmTP67ExLJITt2P8O0NR+62/ztU=;
	b=TNSYP1xM90AAba6RGlmBaA4a/flXLVC+rAElTVHL+LLaqMp9pBoRSjpak5bd2YjgvbSpfi
	M9PIJzp5HGeCrV0qNLNqCG5SNOBLevtvr5RGFGTbu1YJSSrU5x4OloH48JG97qLJ79FhAV
	O6QycYHCUXsrug7u2cR3wD9hceGqtqofBiJfdu7zz6IUQoG8vZZ3ovnoXXvHJpvvgHOLAD
	LpYAUO5WWjfNGAZccgxD4WEnxbgbefIKXn/RiJ78a7X6e1CFT4+beqLTLFHBGPFApJy66U
	b8SRwG+dsKtARauP3cPF2jRzctO/PaImFtl742GTLOQO8LCn8GAcw2ubRx4lkw==
Date: Fri, 3 Oct 2025 18:39:04 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Hui Pu
 <Hui.Pu@gehealthcare.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] drm/bridge: lock the encoder chain in scoped
 for_each loops
Message-ID: <20251003183904.15c800ac@booty>
In-Reply-To: <20251003-dexterous-loose-guppy-45e1b3@houat>
References: <20251003-drm-bridge-alloc-encoder-chain-mutex-v2-0-78bf61580a06@bootlin.com>
	<20251003-drm-bridge-alloc-encoder-chain-mutex-v2-4-78bf61580a06@bootlin.com>
	<20251003-dexterous-loose-guppy-45e1b3@houat>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Maxime,

On Fri, 3 Oct 2025 16:04:50 +0200
Maxime Ripard <mripard@kernel.org> wrote:

> On Fri, Oct 03, 2025 at 12:39:26PM +0200, Luca Ceresoli wrote:
> > drm_for_each_bridge_in_chain_scoped() and
> > drm_for_each_bridge_in_chain_from() currently get/put the bridge at each
> > iteration. But they don't protect the encoder chain, so it could change
> > (bridges added/removed) while some code is iterating over the list
> > itself. To make iterations safe, change the logic of these for_each macros
> > to lock the encoder chain mutex at the beginning and unlock it at the end
> > of the loop (be it at the end of the list, or earlier due to a 'break' or
> > 'return' statement).
> > 
> > Also remove the get/put on the current bridge because it is not needed
> > anymore. In fact all bridges in the encoder chain are refcounted already
> > thanks to the drm_bridge_get() in drm_bridge_attach() and the
> > drm_bridge_put() in drm_bridge_detach(). So while iterating with the mutex
> > held the list cannot change _and_ the refcount of all bridges in the list
> > cannot drop to zero.  
> 
> This second paragraph *really* needs to be its own patch. And I'm not
> really sure playing games when it comes to refcounting is a good idea.
> 
> A strict, simple, rule is way easier to follow than trying to figure out
> two years from now why this loop skips the refcounting.
> 
> Unless you have a performance issue that is, in which case you should
> add a comment (and we will need a meaningful benchmark to back that
> claim).

Just to give some background, I have realized we need to lock the
encoder chain after drm_for_each_bridge_in_chain_scoped() was added.
Should I had realized it before, I would have sent it in the form you
can see in this patch, without the get/put because it is not necessary.
Not sure whether that would have changed the reception.

But I'm not aware of any performance issue, and the impact of
refcounting should not be small, soI'll try re-adding an explicit
get/put on top of the current version. It will likely make the macro
more complicated but should be reasonably doable. So, expect a v3 with
that change to we can all see how it looks.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

