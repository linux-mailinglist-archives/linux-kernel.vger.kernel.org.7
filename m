Return-Path: <linux-kernel+bounces-827816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D201B93307
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA632A47BA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB073176F2;
	Mon, 22 Sep 2025 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNd2bwmF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66181262D14
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758571849; cv=none; b=HD4MVCUHxQQNGACTGIPsuLVas2TbLVyHWSitfktexvaVhjrOKXwSeFQNUL2jWZy+0KHdcObO2IZEdOtzZqwYztlGSSwNcTZDCNHdZuPbUK+faYVd3G5HP4O7J4DOTeIq/s809WGV+T0bwZgM5sXn7zCZrWKZVZyI3V6Ugb4r/4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758571849; c=relaxed/simple;
	bh=3vCduDlbrwLe6zcjBgTOzIkI6NNiuWys7YniDH4zP9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRs7GcZX+Mctjin1vaV73/L7Eg7Pyee+PsL7oTwI/UN0hlp/NzbZZ6+hCDOFJEabXoesV/C7lzWjf/OK1osv+yn3i+g6xJAlYQOU2pj2RfxEKhpiqFJbDzTNgyNtRrrtqh1layMAmOQsHdFBYQN7eMpmuiWG/bRvLlgmYUnQK7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNd2bwmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7C0C4CEF0;
	Mon, 22 Sep 2025 20:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758571849;
	bh=3vCduDlbrwLe6zcjBgTOzIkI6NNiuWys7YniDH4zP9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bNd2bwmF2smG9z1+6pc/F3TXccsSznXZwkm0vH85LKWVm4gz3uChlVmvEVpoO+N4X
	 kgKcZ2OGUnvFRFkNwdslOWcQ0zF7m5o7RKTYdwzSZtDaBA64SdxDtjVgv91n8J3sNJ
	 ht7eUkLVLkR21FwFBJ9cZ1PeEiFcpqwUUF+u5r1LCmiWB4ULYMiFmvsRZ/V2mHy8lF
	 9AIPBG2M4GjW3p3oQR9YnecQPPrq9Yz2uWgV+gwKyLGsx1R5N4wTAAdDQKhX72+5H/
	 /0ss7yD8VRhGLfyqDI98rSEcA8NDgoWKjYraxcbnblcP09fJGgM+NY7720Kv2ZV6uF
	 9q3oduPY4YCJA==
Date: Mon, 22 Sep 2025 13:10:47 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: liujing <liujing@cmss.chinamobile.com>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: fix memory leak in tools/objtool/elf.c
Message-ID: <jekn3cgvy4jxww3x3f42crvpx3iqh3b7e7nj5bzz46dve7emso@n2vtbf4z2f6k>
References: <20250922090324.2598-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250922090324.2598-1-liujing@cmss.chinamobile.com>

On Mon, Sep 22, 2025 at 05:03:24PM +0800, liujing wrote:
> If calloc succeeds but malloc fails (i.e., sym != NULL but name == NULL),
> then memory has already been allocated for sym via calloc, but atthis
> point sym is not freed, leading to a memory leak.
> 
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>

We intentionally don't fix most memory leaks, objtool has a short
runtime and all the memory gets freed on exit anyway.

-- 
Josh

