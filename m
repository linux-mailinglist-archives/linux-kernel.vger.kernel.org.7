Return-Path: <linux-kernel+bounces-790065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092D4B39EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6263AECAC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FE83126C7;
	Thu, 28 Aug 2025 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MNT3D2Qr"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5E1311C01
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387778; cv=none; b=aiZci7z8nKVHGZ576OzRtuEWJOkC4QVshfZtTb3a8uN/j9RFKEcLurl7eKVdYD4jfDbJFx57TWmYZ9ioxnjGODpbBG/lYCKCxvP0Evcd6bHYLPbA1iuTVStLhtYktcr0Bg4l5crZaCu5jwsm9csd85cF8l4YEFwTXM8eEZOhQzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387778; c=relaxed/simple;
	bh=0Lfc7/gisKl0GuyU0xae9i6tusRkuqMIzRZ4P5WcZ+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASkAsgk+mLIGkyKdlj9HDFXFMwyevtfWweuYMNpdNCWzg5YbVbKf/rIUU2c9oc5Lxrp81cxKJ1SrKfAt9MxHj++7SyxVk5WFvSxzoRgcR3fCeMpRsSZphXIiJU+Vr5R7gH6nycntBVh1AJ+SkMymleEq8uy5uCRxWKFbhBjSaE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MNT3D2Qr; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <892b525b-964b-4a7e-bcc4-8aa0cb8d0068@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756387773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+iREffaG1KUC32E2neaplXOub9NOMnRAdzW/PQKR+E=;
	b=MNT3D2QrgNDlrKe58D6lF5YfPjz48afQbrkMLjANS9KVCfr2YKfCfCCPFdpWvvY4LLkxCn
	c7XgvYi73nuRkRIkKQwF3bVnlhlp3COAXk0V7awNzGo3RbNyGVfQdFD7W8WdWdhk0iloPk
	Ea1LqORduYHIlv8uKYaxWlhUdBiwFLU=
Date: Thu, 28 Aug 2025 14:29:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 1/3] net: stmmac: replace memcpy with strscpy in
 ethtool
To: Konrad Leszczynski <konrad.leszczynski@intel.com>, davem@davemloft.net,
 andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 cezary.rojewski@intel.com, sebastian.basierski@intel.com
References: <20250828100237.4076570-1-konrad.leszczynski@intel.com>
 <20250828100237.4076570-2-konrad.leszczynski@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250828100237.4076570-2-konrad.leszczynski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/08/2025 11:02, Konrad Leszczynski wrote:
> Fix kernel exception by replacing memcpy with strscpy when used with
> safety feature strings in ethtool logic.
> 
> [  +0.000023] BUG: KASAN: global-out-of-bounds in stmmac_get_strings+0x17d/0x520 [stmmac]
> [  +0.000115] Read of size 32 at addr ffffffffc0cfab20 by task ethtool/2571
> 
> [  +0.000005] Call Trace:
> [  +0.000004]  <TASK>
> [  +0.000003]  dump_stack_lvl+0x6c/0x90
> [  +0.000016]  print_report+0xce/0x610
> [  +0.000011]  ? stmmac_get_strings+0x17d/0x520 [stmmac]
> [  +0.000108]  ? kasan_addr_to_slab+0xd/0xa0
> [  +0.000008]  ? stmmac_get_strings+0x17d/0x520 [stmmac]
> [  +0.000101]  kasan_report+0xd4/0x110
> [  +0.000010]  ? stmmac_get_strings+0x17d/0x520 [stmmac]
> [  +0.000102]  kasan_check_range+0x3a/0x1c0
> [  +0.000010]  __asan_memcpy+0x24/0x70
> [  +0.000008]  stmmac_get_strings+0x17d/0x520 [stmmac]
> 
> Fixes: 8bf993a5877e8a0a ("net: stmmac: Add support for DWMAC5 and implement Safety Features")
> Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Signed-off-by: Konrad Leszczynski <konrad.leszczynski@intel.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

