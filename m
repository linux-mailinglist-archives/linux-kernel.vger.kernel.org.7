Return-Path: <linux-kernel+bounces-834350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BCBBA482B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156D31BC82DE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3689A22689C;
	Fri, 26 Sep 2025 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VW6u7eIx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889FC223DF9;
	Fri, 26 Sep 2025 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902106; cv=none; b=N6VqY4zfqa6s5zUAt8sEUGSzOwSs5Ly9ZaEXn6IJb77eClyQYhtHfdkAA++/wGHTqz7/2wT62EqelfS5Qs2QCMXxV3acxjmEscInLPB3UGt2rkqHEK8ESGnjW8g4wUzVHFxFF9I9sAYwQblaoBJ74PvIeTOtREqHl0MTwc8qN38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902106; c=relaxed/simple;
	bh=QY04EA7f9rFZc1ry5RbDdee1eH1ZtF6RNbYZ864Iejg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eb7O4RMQTPpNRm1AKmnzvm1eS3WNeiWy8OJxIHMqOxsHOIZ9g4gWKHM2rtF3MRcOqpSVMF2HkZwcJR5RJMGWwM3Z2rjy1Pt0++U9JOQzLBgvT5A5zd0q6cWxMU1Dp/J9HeSl956zvc5bptKfqJvP42j+Jk9AKjquB1OWdtYnqdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VW6u7eIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F4BC4CEF4;
	Fri, 26 Sep 2025 15:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758902106;
	bh=QY04EA7f9rFZc1ry5RbDdee1eH1ZtF6RNbYZ864Iejg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VW6u7eIxwWH1cr753V5J2LxOOHjIM2+OJigjWqXy14dsgdSVDAbzEcPIWJG0VyCLK
	 IiccvlAsT6yUeZltR+hEk/dtzTgYiN8iGJTIaVOiWciMEjQIh8uwa5Sh9LyZzxGHdf
	 6e+BTEIFUWgoEllJmVhO84ZDyvqyCJ6GclSVEfh/uoWb9G74cMnPpPgmp3myebEVZT
	 DH2NM9Sku3+IlbR22ooNMdKu92dc99ruSbBvc6LFrXx6D8l3z8ZLXsoFZytC/jToL5
	 HZntiHHn+c/Q5BCRPQfrm9x5FaiE+yy/dZTmjzhS3CQcPXb1K/+j+ptQywWfdiudnf
	 m8wiQxKpt7BPg==
Date: Fri, 26 Sep 2025 16:55:01 +0100
From: Simon Horman <horms@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 0/2] net: devmem: improve cpu cost of RX
 token management
Message-ID: <aNa3ValQeGEm_WGb@horms.kernel.org>
References: <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v3-0-084b46bda88f@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v3-0-084b46bda88f@meta.com>

On Fri, Sep 26, 2025 at 08:02:52AM -0700, Bobby Eshleman wrote:
> This series improves the CPU cost of RX token management by replacing
> the xarray allocator with an niov array and a uref field in niov.
> 
> Improvement is ~5% per RX user thread.
> 
> Two other approaches were tested, but with no improvement. Namely, 1)
> using a hashmap for tokens and 2) keeping an xarray of atomic counters
> but using RCU so that the hotpath could be mostly lockless. Neither of
> these approaches proved better than the simple array in terms of CPU.
> 
> Running with a NCCL workload is still TODO, but I will follow up on this
> thread with those results when done.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Hi Bobby,

Unfortunately this patchset doesn't apply cleanly to net-next.
So you'll need to rebase and repost at some point.

-- 
pw-bot: changes-requested

