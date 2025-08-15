Return-Path: <linux-kernel+bounces-770838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF57BB27F80
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577AB1D03936
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3BA2FB995;
	Fri, 15 Aug 2025 11:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h9/lHK0u"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA53D215F5C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755258445; cv=none; b=RWBdatIV64g2InlnDPlJGyUkGePcXHR+j0pO0rtUv+Ja9DgsUAd//GeiQGZ6F3LjLFCbzcvd15XAvbhILy7lGQ3p0BRjT/BwqYZNtXjXBcHV4wt6zGNzn2kvPoqZ+12XoHWzBNxhGoY0Cg/6zj78WOFe6i6w55YIv8JdsjhQQRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755258445; c=relaxed/simple;
	bh=1VD77uSjBBqxkJZ9d45Q6aa5YIXDLLtlw35f09U505U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=I0A57SyjKC0GygjHGeIBPUrbr0dAzIkTHJqnAyIMBKQPPlurL4pB63y0kq4KF9ZEldqlA5Sv5oChkCvqIzPCZFIPUT9VgApNI+Matkjxt3EZwVRivW3HpTft1QVBIKU/EtDRUmFg+n5H5V6yqLLG9Eft0/+SvQO3dAoTqxE0qbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h9/lHK0u; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755258432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7DyI0nX3hyZSNWpa5bS1jdf0Y0kUJp8jUhwdMxayOJA=;
	b=h9/lHK0ughu1k+FhEC/8YWl3X5m9BCNqcSM7HQqDddI33kzkS9qPAW7FmX9ks31KGo7mcp
	aY/sn+bb8/+C5+FoNQxoDBcR0G6RHDS8tPMuoe57mHZMCoQ1DUuFgCDLzq8l9/6MnE8FWJ
	L5NrnoOUGTZ2/ztG3N1Ih8Nfg179piM=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next] net: pktgen: Use min() to simplify
 pktgen_finalize_skb()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <202508151939.AA9PxPv1-lkp@intel.com>
Date: Fri, 15 Aug 2025 13:46:57 +0200
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Peter Seiderer <ps.report@gmx.net>,
 =?utf-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 oe-kbuild-all@lists.linux.dev,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9CDBDFFA-DFE3-42B6-8C5C-7F4E2AFEDB9B@linux.dev>
References: <20250814172242.231633-2-thorsten.blum@linux.dev>
 <202508151939.AA9PxPv1-lkp@intel.com>
To: kernel test robot <lkp@intel.com>
X-Migadu-Flow: FLOW_OUT

On 15. Aug 2025, at 13:31, kernel test robot wrote:
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on net-next/main]

I thought I compile-tested it, but I must have forgotten to enable
CONFIG_NET_PKTGEN. Sorry about that.

I'll submit a v2.


