Return-Path: <linux-kernel+bounces-832111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC0AB9E5DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271351BC72C4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3272EAD15;
	Thu, 25 Sep 2025 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPnfe+iL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1613287267;
	Thu, 25 Sep 2025 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792579; cv=none; b=UE2oWI2Y7NP5MthAFBkHHLT9oJPNBFnxUKXXQPpG5zadK0RLk8TgM7CLu1vFxoIVLIXLU77LVs8J5G4uC4KupbknVqizRiKPOMBwqcZGPACviyxOQ8Gst9hVi6udUukD1nu6NZD8IdU5wK3ry2YyHAu+IWD+rL1bCbmQwBDAJT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792579; c=relaxed/simple;
	bh=diVPns8/Qglk7iqlPWDaNo4j+JGzMXBeZ3rJ3/QOaT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0RSV9tNT40+0JoZt3j4Hk3ZsqsDeSQB5mbCpuAUzeLZlz+UvwZqUpTSRh7dYyu4Gf0LL8VtA3hHdn4X1vZSGCSo8cxshTVAp90v8IWQegXmBXNftaQJjX2wDTPdOR5ZUWyxJHXWUpN7sN7+8CysBPBrk4op+pHjOOyg9MiMfHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPnfe+iL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009C4C4CEF0;
	Thu, 25 Sep 2025 09:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758792579;
	bh=diVPns8/Qglk7iqlPWDaNo4j+JGzMXBeZ3rJ3/QOaT4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NPnfe+iLnVvZ+Z9+Ttgf7AarUtpAxUoeC5BB8kQCmZ/2PDapJX7tYzdWB0KEIYdH2
	 dLUZyDnzzaCt+gdTx+ffjVWbktwgE3wN/oGbsZeONoTR1Y2eGAoP8ePI7dIWzN/49o
	 2d7v/yB3dUKgQZMvxeVGiaa1Gyw/r9nX4Bz4PC9C+lH3NmNfVMHCxDkMuPqCDZuStF
	 hiHldrqUIQvkGevssirRX21OXBSzkGj9B42kEmioDNUPqho6MMy9M2RsMhgJC1puMA
	 8eAxB/pEchJLkzwmWOEdu+tskdvnZN1rCPchgy/Jwy9ZuonuEwSCHxJKi6KKKHA2wf
	 vZice6PNMuIaA==
Message-ID: <f69f55c4-1d1a-4d9e-856d-fd27c234d451@kernel.org>
Date: Thu, 25 Sep 2025 10:29:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] bpftool: Remove duplicate string.h header
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20250925092125.2006892-1-jiapeng.chong@linux.alibaba.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250925092125.2006892-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-09-25 17:21 UTC+0800 ~ Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ./tools/bpf/bpftool/sign.c: string.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=25499


Note: the title of this issue is correct, but the description mentions a
different problem (another double header inclusion in a different file).
Could that be a bug with your bot?


> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>


Acked-by: Quentin Monnet <qmo@kernel.org>

Thanks!

