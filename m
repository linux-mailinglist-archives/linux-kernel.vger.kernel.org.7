Return-Path: <linux-kernel+bounces-736677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 038BDB0A05D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD06B3B79C2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB0029E0FD;
	Fri, 18 Jul 2025 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGV1q4da"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DAF29E0F1
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752833319; cv=none; b=dAckCI7lP9u4afhjizmpsdimFKjqmkyC54nv8Hf9/D8YEPi4ibpIqtg4gRFe52CBGZL32gYLTQKWRK54eaJ1/PtRYe9XQ8Bgk0H6o4g9RZhFXKlrIaQBQhow9q8Eq7C5RVl1WLL6CG+33ALm6+hZnr/q/46rUVLHtOnpf1jPVYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752833319; c=relaxed/simple;
	bh=IqkcBZjildqfrYXTo8sxxwqovOo/lC+C2lAL0ChmSZY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=k74kwVNR1iLquZrfdaNoichFVcM5lGbiR0QhlFddmv1IO6OLID5F0ildK0TrKu/SXb4bxYB4pc6UQwe3i60zuuyMmD0v6NHdQQ/k6vn0NPY3l8JCDjttnKGJ6E6M02qk+Z8IU5u0iljQ0OCfK3JZ51zwHgBhNXCaU5p39Xa6ne4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGV1q4da; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FEBC4CEEB;
	Fri, 18 Jul 2025 10:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752833318;
	bh=IqkcBZjildqfrYXTo8sxxwqovOo/lC+C2lAL0ChmSZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IGV1q4da+2GQSwVGGR0gJYtMsgumakE8a/yzQ4ZDvybxYo4OiwyAtDhni7mlzNsoi
	 8lbZlmmpxTTlbxUtpbVwzOos5RrWiuuPSaFEuJjq/3kJtGGU6EsEFWLTHcV2X66EMf
	 g5SQYFaBMf6qqcJb5I/7vTMWERvdFpBtQS8m8JknCk1qRiJXeLLJYNUsw7utUAgPnu
	 zlRQA5fdyMwtHjqcUH0qDs4ZTZW0ZH/P/fxa0MnSLgR9BxbqrNw0wybqLBivyuxV9U
	 mItwG8pVGYE4YOuIgy+Ejqnk1oml1Dy1MnGYRjb22Ta3gaj9P3LyDtPJrEy3lTmuV7
	 q6VDTA/gFQdog==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Jul 2025 12:08:34 +0200
From: Michael Walle <mwalle@kernel.org>
To: Jayesh Choudhary <j-choudhary@ti.com>
Cc: jyri.sarha@iki.fi, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 devarsht@ti.com, tomi.valkeinen@ideasonboard.com, airlied@gmail.com,
 simona@ffwll.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Decouple max_pclk check from constant display
 feats
In-Reply-To: <20250704094851.182131-1-j-choudhary@ti.com>
References: <20250704094851.182131-1-j-choudhary@ti.com>
Message-ID: <c638ebecd9b01df5779d3f8931c2bf17@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

> In an effort to make the existing compatibles more usable, we are
> removing the max_pclk_khz form dispc_features structure and doing the
> correspondig checks using "curr_max_pclk[]".
> 
> Changes are fully backwards compatible.
> 
> After integration of OLDI support[0], we need additional patches in
> oldi to identify the VP that has OLDI. We have to do this since
> OLDI driver owns the VP clock (its serial clock) and we cannot perform
> clock operations on those VP clock from tidss driver. This issue was
> also reported upstream when DSI fixes[1] had some clock related calls
> in tidss driver. When "clk_round_rate()" is called, ideally it should
> have gone to "sci_clk_determine_rate()" to query DM but it doesn't 
> since
> clock is owned by OLDI not tidss.
> 
> So add a member is_oldi_vp[] in tidss_device structure to identify this
> and avoid performing clock operations for VP if it has OLDI panel.
> For the same checks in OLDI driver, atomic_check() hook is added to its
> bridge_funcs.
> In the atomic_check() chain, first the bridge_atomic_check() is called
> and then crtc_atomic_check() is called. So mode clock is first checked
> in oldi driver and then skipped in tidss driver.
> 
> Had the tidss_oldi structure been exposed to tidss_dispc.c, we could
> have directly checked VP type in dispc but since the structure is 
> defined
> in tidss_oldi.c , we have to add additional member to tidss_device
> structure.
> 
> [0]: 
> https://lore.kernel.org/all/20250528122544.817829-1-aradhya.bhatia@linux.dev/
> [1]: https://lore.kernel.org/all/DA6TT575Z82D.3MPK8HG5GRL8U@kernel.org/

For this series:
Tested-by: Michael Walle <mwalle@kernel.org> # on am67a

-michael

