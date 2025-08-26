Return-Path: <linux-kernel+bounces-787232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB093B37345
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE6D7A1FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF12930CD86;
	Tue, 26 Aug 2025 19:37:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562D530CD81
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756237037; cv=none; b=A3quKnNeZSnn//owqQS15dYWEzJUwNlIm+PIsBsD9aTG/V+KJ9XOpn/uS3nApg+ZhVBLplfVIBEIYnprBUcTAwUCKWvFzkVgXZlNb+VU18mbdol5nysqoJT7p2UYLLVtnDPxr8GAPT5a0UNEsqMVtcm97/CSVavzX6FDsMX0yK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756237037; c=relaxed/simple;
	bh=ag4Qq03lFV9ilnv3UPwrwtlaOnFTbn/w0ka9VBUtM1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j85wG+uncwECNLOzGMm2QwljCOn3uf6hQOMQO4wbZNxARb8+pzIdBjj6cwtUo9h4Sif8Vj0SABuP/W3EHQO2GguaHoBKii8oYKKeRWq1e5si4XPQ5I9cjVoOkTMTrCmb/vp/TU8IpEOI21KEQ1/4vI2NAryyVpwNy/abgsjlbVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A72AC4CEF1;
	Tue, 26 Aug 2025 19:37:13 +0000 (UTC)
Date: Tue, 26 Aug 2025 20:37:16 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: b10902118 <b10902118@ntu.edu.tw>
Cc: oleg@redhat.com, linux@armlinux.org.uk, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ARM/arm64: ptrace: fix unaligned hardware breakpoint
 validation for 32bit
Message-ID: <aK4M7P9qb5TVou-p@arm.com>
References: <20250824124317.390795-1-b10902118@ntu.edu.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250824124317.390795-1-b10902118@ntu.edu.tw>

On Sun, Aug 24, 2025 at 08:43:14PM +0800, b10902118 wrote:
> b10902118 (3):
>   arm64: ptrace: fix hw_break_set() by setting addr and ctrl together
>   arm64: ptrace: minimize default bp_len for hw breakpoints to pass
>     check
>   ARM: ptrace: minimize default bp_len for hw breakpoints to pass check

We require real names from kernel contributors. Unless you can show
b10902118 is your name.

-- 
Catalin

