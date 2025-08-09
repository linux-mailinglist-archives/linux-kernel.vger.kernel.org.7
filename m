Return-Path: <linux-kernel+bounces-761110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9827BB1F482
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 14:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4455A7A9526
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 11:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D14C27FD76;
	Sat,  9 Aug 2025 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJPhA7ty"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECC82459D7
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754740823; cv=none; b=T8UUdSJ7/CwPdZHnwHwQ+G0Jt49NG/UASbovZMgMExKZWVOTVNx5ugX5q0WHULaaPWoyHmLNRCPig5AGAOc6gR3TlUcG5s5DDxffwe5TM/6zGfmXTyCSeA1p+m4059AGhiRxYAP2yiww6NxUb4FEHdS+IezoAlMLtXtDwMA0a90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754740823; c=relaxed/simple;
	bh=G9Y86yEKl/OQbyDpbnOxMl2AIRYIjfol7N+IaJnktGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bveU/j7bQaSpykMJCLo8YURaM67ift/lqNEwyXbmL3sS27TvMhXpsbCVGroDV4cfcIMO7q28RgY3oUluNtDoqMdssylxRu6/I7Cvblo4vegih01ZqQUaYXXgqGwoNOpGZpdkYjbaWt9oMgzdILGue01EA79fwBMpAXcKh89hQJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJPhA7ty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCFBC4CEE7;
	Sat,  9 Aug 2025 12:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754740823;
	bh=G9Y86yEKl/OQbyDpbnOxMl2AIRYIjfol7N+IaJnktGY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SJPhA7ty3dtS0ZCWINuLv+UkCmgqg8gcRv2ZgfqgMGEO5qycVRQoi3AIfriUnIjDP
	 qx+2BoQc4304doOkvyCTp/IXwySULvtwRBF1rfhn+9EHG+3vMOdci8mb8S1fcclbhd
	 58bbGM+h6tpNYPZy9A0IVu3/UY5WaREeQZy1oinmeTd4bDUbet/xMjRQtsQOBYiXke
	 NZvFno/VS2q9sKG3JhzS7EuH+w7/bEZHcLBPAlpA68IwFWvbBlJTKJK+3h8/iGlr3L
	 nSfVjLemXQMfy0nM/8Q2s+JlGXpVteevcDmnHsGabYKUoOWhylquP4oT4kpO+UW5xX
	 O8D952sECK5Ig==
Message-ID: <a0e84862-858e-44cf-aadd-31bc6b3fec08@kernel.org>
Date: Sat, 9 Aug 2025 14:00:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau: replace snprintf() with scnprintf() in
 nvkm_snprintbf()
To: Seyediman Seyedarab <imandevel@gmail.com>
Cc: lyude@redhat.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250724195913.60742-1-ImanDevel@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250724195913.60742-1-ImanDevel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/25 9:59 PM, Seyediman Seyedarab wrote:
> snprintf() returns the number of characters that *would* have been
> written, which can overestimate how much you actually wrote to the
> buffer in case of truncation. That leads to 'data += this' advancing
> the pointer past the end of the buffer and size going negative.
> 
> Switching to scnprintf() prevents potential buffer overflows and ensures
> consistent behavior when building the output string.
> 
> Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>

Applied to drm-misc-next, thanks!

