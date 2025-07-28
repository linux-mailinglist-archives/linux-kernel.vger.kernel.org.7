Return-Path: <linux-kernel+bounces-747603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B42B2B135D5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221593A65A3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F471DB54C;
	Mon, 28 Jul 2025 07:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azJISXrW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5400E1ACEDD
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 07:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753688841; cv=none; b=PMXFxBYWeXeXyc8WZWvJx2pQVuGbFIMeRcfdr4z9icmqJU+z7mf7dt6CxXlDoxg8qVlvdQKdyzcwfeWT1Mtc99r9HByJJqdFZZ+tCgxwPGFSjKyo6iK58NCtJuK0N9Xj+sKtC83CSyUgLVxrPrMxShW7NGzUNq0i2u32EeRYHUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753688841; c=relaxed/simple;
	bh=igx3BzKiRhulOujJ8kiBh4dCLudD9fUfFdXzya6UUjA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RJax7BpE935CxzN7W8r5PPKqMh7xFwNWRAzOxR9jOAn/khjD6iIyOuePFuwXcEOBTe84dc2hdqsrik6u6Gj2fcLEZSWYGuoAyzo4ZYprpm/0g3Bvm/e3KGOtFBehqpA1M6gAiuPca4UAjGb6K/CrctBEZ+gP1kT/Zab93ErPUn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azJISXrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772F8C4CEE7;
	Mon, 28 Jul 2025 07:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753688840;
	bh=igx3BzKiRhulOujJ8kiBh4dCLudD9fUfFdXzya6UUjA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=azJISXrWZFcPH/TwYUhUAwiJL0hB9W6hq4Ix56iEovmaKoOSkeCEu4CrtBsC2awnV
	 YY49tYIYLjm8eiAMN3qH2uc362n+xbAwnKHYwOX9XCU/cAkbYps5E21K1Nz6NDBEVR
	 xGLRoFqcVfv/r91n5a3cJ0mMHvu0GRG+2masFU4REgNrPeoErg8DnATh583q1Vx4WI
	 5iMq8wd+wZ8IRFsXrnBIkAjqWE6lpQ2MnlzQNAyL7ALjmYUOxP6nsY6k8mKo5Z7VTP
	 /t1OBYJd0gioO9mDvpWZxeCOjT6YBGghiXQBTXqbpAfFNl+5+kAf6ZKUlK4b360uvP
	 fgYew0AO4iqFQ==
Message-ID: <8c9eb0b3-0297-4a86-a7b0-3d9d884fedcd@kernel.org>
Date: Mon, 28 Jul 2025 15:47:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, bintian.wang@honor.com, feng.han@honor.com
Subject: Re: [f2fs-dev] [PATCH v3 2/2] f2fs: directly add newly allocated
 pre-dirty nat entry to dirty set list
To: wangzijie <wangzijie1@honor.com>, jaegeuk@kernel.org
References: <20250728050237.1563560-1-wangzijie1@honor.com>
 <20250728050237.1563560-2-wangzijie1@honor.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250728050237.1563560-2-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/25 13:02, wangzijie wrote:
> When we need to alloc nat entry and set it dirty, we can directly add it to
> dirty set list(or initialize its list_head for new_ne) instead of adding it
> to clean list and make a move. Introduce init_dirty flag to do it.
> 
> Signed-off-by: wangzijie <wangzijie1@honor.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

