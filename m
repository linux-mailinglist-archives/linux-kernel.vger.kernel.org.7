Return-Path: <linux-kernel+bounces-724664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2586AFF595
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2031AA8A43
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA8FAD23;
	Thu, 10 Jul 2025 00:16:22 +0000 (UTC)
Received: from audible.transient.net (audible.transient.net [24.143.126.66])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A78073D69
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.143.126.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752106582; cv=none; b=on70icpS7hbfh/GvdkKMUMKaDgVvuWKKHYBiOFsw9UVl9Hq+ECkc1KLxDehuzg1XyuezKbDtkBRX8NQX7U8HlPiNZx1ifvhxFV3yZyOCxmU4FEH/BwWTdpGufWAJ5OJEy70wNckuVt9If3cb6NlAFAfG8mXMYozpV03rZFSxgTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752106582; c=relaxed/simple;
	bh=ZlDHScqJfWOWyzCL4r+gdpFIRQ61fogzaddKfDoU/qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nlgbi9ysMzuBvyjy8CWkXDAR3RIC2ps5F3nc68/Oab8222wLrA9R5v+z0fLDRluRp3oGZ2KohRRvQcJoBZcjb4YegwaHh8kMg6tdCWTofRGPF+DPKb9JtKeVY9BAWIZk4aFmIbRSZLfpDg8PCYFdCgyvY5f7GpMDaRFKixiwV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=audible.transient.net; spf=pass smtp.mailfrom=audible.transient.net; arc=none smtp.client-ip=24.143.126.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=audible.transient.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=audible.transient.net
Received: (qmail 4019 invoked by uid 1000); 9 Jul 2025 12:04:22 -0000
Date: Wed, 9 Jul 2025 12:04:22 +0000
From: Jamie Heilman <jamie@audible.transient.net>
To: Ben Skeggs <bskeggs@nvidia.com>
Cc: Rui Salvaterra <rsalvaterra@gmail.com>, airlied@gmail.com,
  nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
  linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] NVIDIA ION graphics broken with Linux 6.16-rc*
Message-ID: <aG5axlstlhnUYks2@audible.transient.net>
Mail-Followup-To: Ben Skeggs <bskeggs@nvidia.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>, airlied@gmail.com,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
References: <CALjTZvZgH0N43rMTcZiDVSX93PFL680hsYPwtp8=Ja1OWPvZ1A@mail.gmail.com>
 <aG2mzB58k3tkxvK-@audible.transient.net>
 <25642e5b-25ee-49b2-b08d-4c64fa2e505a@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25642e5b-25ee-49b2-b08d-4c64fa2e505a@nvidia.com>

Ben Skeggs wrote:
> On 7/9/25 09:16, Jamie Heilman wrote:
> > Rui Salvaterra wrote:
> > > Unfortunately, bisecting is not feasible for me.
> > That looks pretty similar to the problem I posted
> > (https://lore.kernel.org/lkml/aElJIo9_Se6tAR1a@audible.transient.net/)
> > that I bisected to 862450a85b85 ("drm/nouveau/gf100-: track chan
> > progress with non-WFI semaphore release").  It still reverts cleanly
> > as of v6.16-rc5 so you might want to give that a shot.
> 
> Hi,
> 
> Thank you for bisecting!  Are you able to try the attached patch?

Yeah that got graphics visible again for me, though there's something
else horrible going on now (still? I'm not sure if its new behavior or
not) and it blows out my dmesg ringbuffer with errors or warnings of
some kind, that I was just about to start trying to debug that when
some power event seems to have fried my PSU.  Combined with a bunch of
filesystem corruption, its going to be a while a before I can get that
system back up to that spot where I can troubleshoot it again, the
root volume is fried and I'm going to have rebuild.  Anyway, I think
whatever it is was probably an entirely separate issue.

> From 6987c1c254285305fdc20270e21709a313632e0d Mon Sep 17 00:00:00 2001
> From: Ben Skeggs <bskeggs@nvidia.com>
> Date: Wed, 9 Jul 2025 10:54:15 +1000
> Subject: [PATCH] drm/nouveau/nvif: fix null ptr deref on pre-fermi boards
> 
> Check that gpfifo.post() exists before trying to call it.
> 
> Fixes: 862450a85b85 ("drm/nouveau/gf100-: track chan progress with non-WFI semaphore release")
> Signed-off-by: Ben Skeggs <bskeggs@nvidia.com>
> ---
>  drivers/gpu/drm/nouveau/nvif/chan.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvif/chan.c b/drivers/gpu/drm/nouveau/nvif/chan.c
> index baa10227d51a..80c01017d642 100644
> --- a/drivers/gpu/drm/nouveau/nvif/chan.c
> +++ b/drivers/gpu/drm/nouveau/nvif/chan.c
> @@ -39,6 +39,9 @@ nvif_chan_gpfifo_post(struct nvif_chan *chan)
>  	const u32 pbptr = (chan->push.cur - map) + chan->func->gpfifo.post_size;
>  	const u32 gpptr = (chan->gpfifo.cur + 1) & chan->gpfifo.max;
>  
> +	if (!chan->func->gpfifo.post)
> +		return 0;
> +
>  	return chan->func->gpfifo.post(chan, gpptr, pbptr);
>  }
>  
> -- 
> 2.49.0
> 


-- 
Jamie Heilman                     http://audible.transient.net/~jamie/

