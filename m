Return-Path: <linux-kernel+bounces-839252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B71BB12E0
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3F13C302E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9B027B33E;
	Wed,  1 Oct 2025 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="t/umSCE8"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984041459FA
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759333948; cv=none; b=RKpDck24k6ct/+J9iZIWeX5pCD7t2sfxm0xvjJ3NGuJNCvmRygHgAJP9vku5L9fzbe30OIdTPX+TPSYMsQOmLF96dRhZ1Lxd5yG8DSV2oYMgP/u24q1JnywU6iQMEhiDQ36sVIyEf4mDfT64OIUbTqzNY7u3N/VUofzy2GbDWBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759333948; c=relaxed/simple;
	bh=a7PM5FlC5X4+ZJt0HZGyb26F/2XXaZnGZGWxxCbOMKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jg8NFiDwGdUuFhpE7T9ylCb5nFW2qOlk/rGaeJ6Bep+QK0JFvmWrSyC+g5ez/wUkUft4ANjeOhWxiceF8ad5bb01LxcwErozDx7/LBOgHYl+zubSaquTlQHtin0JFh6k69D91EIhcrS+ctNZde5TnoeEDNBMPGL7/FO4HV1W2cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=t/umSCE8; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-78e9f48da30so577886d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 08:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759333945; x=1759938745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uHCHbH4bKQ0EEHiyKfm9TsIjUNoXvUiqJ8z77sZHB1g=;
        b=t/umSCE82m65OU9TydixEQs6TWgwVb7XPIkFXOog2T7aS0DcTOgCC8fa3OeoRPUgrm
         FlfXh+jdAd2Bj0d7L46C4ba8QkoqY9536SqdIEK5mOcVRYn3RBLzyvRX1S9CFN1uZedU
         8VKnogHK/lF1dEyD2vGBw1Qnp/sJdL39QJUB6cTQF2DRyys0DvE0YN22q5CK/kNry29A
         LBgMGPxC8tMwJRZ8SmscWfXH7hmTNCmGcpjMoh7bJbZc+c+Tq4JvYIjZpIfac7kAX+uq
         WVFCEr57UcqqzURSZNFvZyZGm4QByDjZwX9r0MfLmhtj4VJX8wR+IbGD8VqDQDbPgwfQ
         IbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759333945; x=1759938745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHCHbH4bKQ0EEHiyKfm9TsIjUNoXvUiqJ8z77sZHB1g=;
        b=Z19m1LKm4lv23ZdSji5XsgPpJXmtTRO+KcfNXKu4kcwgY1pNUXrE7wq2bp8+capvMG
         inlkExcH7ZLhBRbPDzlz5Wmbnfl7Ym7YeXP12GQGOVqZ8Wuvr8S2NWCKIDo1MAlmKIax
         RwAq9eSE/uZY5IRo4LlumgIiND65DUpaUl8ja5iltQGFjZIRXDYZwswsPLiKYTNz6rD1
         h0ct9/7nt7lRwpD58OSsRtc1FgmR7AutfuB5zjKfRqRlssY8xJ0zEjukiWvs9aQS+cLL
         8jkFlBhOyDenmF4TW/FyTUHPPodClHR6pzzOSP0KlUHr+UkA9dETuCYspRtAzXIw80RC
         3Nhw==
X-Forwarded-Encrypted: i=1; AJvYcCVi/zDMIQl/z9o9+00IMv8TlYi0Du0UBzWJccmeFOpg2DWOP6W1pOod4lNI5TWSDQau+rtq6xe3Cehf+U0=@vger.kernel.org
X-Gm-Message-State: AOJu0YynHAmcE42Teb4uXuoP+isvgKNsVAWpXMn490FOVtoOSXJQNNso
	fkwxlL5NATcDDJMEEXFvs/dUBHi/toTkLxCm2SDkEuv38xRxwXS5SsUZW+GrX1MxcI8=
X-Gm-Gg: ASbGnct2lbCXqBI28Nd6scMDvLU4BaMI7asP/bmc0dmLel4yIeLblbsIHlwa1iV2tQJ
	83yY/csEO1l9tuJQkiQNfwRh/aep9jS3VkvFH9uBqisIy6PlUZYseQtk0KSNHzRV+mnKO3waJVO
	2czGUQvdbtFMPo0xYqqkL7s/fiX/DLVU8yC+f4v1iy+PLewYex4s2XtyT4fEmNPuA8tUWIj/cI6
	6vBQJe5n9XFAi9uVtdYLBNeF2XAdHlq1ruKwsgpXz8JeEvWGEz2CFq5TuqCXfkM5LgDQ1UGJd/Q
	fSColEVB3Jjgmb8ogsvMBJVKQxvT95Om5ARQ5dBLCCAghrb9meIb58d6ldMdQuU9g1SWQREg8jV
	+xCix5o0SqZBM+slb56lDIm3DGewv2u8AHWiimz7eLzhkdDuQy3M45WuLSDxAqyUc/YkRPvYsMQ
	tfRjxV92U/RsBL9iha5soFhcuBdSTYwQ==
X-Google-Smtp-Source: AGHT+IE9HCW0wyGkJZlnA7Hr0vdt3tar2buiMFkEIfn9/MUkRsZs4AEYdzb/URPhW2fv4DE/k8ZKgQ==
X-Received: by 2002:a05:6214:62f:b0:824:30f8:ed70 with SMTP id 6a1803df08f44-8739d146d6emr53562716d6.9.1759333945123;
        Wed, 01 Oct 2025 08:52:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878be52aad3sm112936d6.59.2025.10.01.08.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 08:52:24 -0700 (PDT)
Date: Wed, 1 Oct 2025 11:52:22 -0400
From: Gregory Price <gourry@gourry.net>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH] mm: page_alloc: avoid kswapd thrashing due to NUMA
 restrictions
Message-ID: <aN1ONiuqoZQTliHG@gourry-fedora-PF4VCD3F>
References: <20250919162134.1098208-1-hannes@cmpxchg.org>
 <4a793133-6cb3-42d4-948f-84eae6fa7df3@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a793133-6cb3-42d4-948f-84eae6fa7df3@suse.cz>

On Wed, Oct 01, 2025 at 04:59:02PM +0200, Vlastimil Babka wrote:
> On 9/19/25 6:21 PM, Johannes Weiner wrote:
> > 
> > Since kswapd hysteresis targets watermarks that are *higher* than
> > needed for allocation, even *unrestricted* allocations can now get
> > suckered onto such nodes that are already pressured. This ends up
> > concentrating all allocations on them, even when there are idle nodes
> > available for the unrestricted requests.
> > 
> > This was observed with two numa nodes, where node0 is normal and node1
> > is ZONE_MOVABLE to facilitate hotplugging: a kernel allocation wakes
> > kswapd on node0 only (since node1 is not eligible); once kswapd0 is
> > active, the watermarks hover between low and high, and then even the
> > movable allocations end up on node0, only to be kicked out again;
> > meanwhile node1 is empty and idle.
> 
> Is this because node1 is slow tier as Zi suggested, or we're talking
> about allocations that are from node0's cpu, while allocations on
> node1's cpu would be fine?
>
> Also this sounds like something that ZONELIST_ORDER_ZONE handled until
> it was removed. But it wouldn't help with the NUMA binding case.
> 

node1 is a cpu-less memory node with 100% ZONE_MOVABLE memory. Our first
theory was that this was a zone-order vs node-order issue, but we
found this kswapd thrashing to be the issue instead.

No mempolicy was in use here, it's all grounded in GFP/ZONE interactions.

> > Similar behavior is possible when a process with NUMA bindings is
> > causing selective kswapd wakeups.
> > 
> > To fix this, on NUMA systems augment the (misleading) watermark test
> > with a check for whether kswapd is already active during the first
> > iteration through the zonelist. If this fails to place the request,
> > kswapd must be running everywhere already, and the watermark test is
> > good enough to decide placement.
> 
> Suppose kswapd finished reclaim already, so this check wouldn't kick in.
> Wouldn't we be over-pressuring node0 still, just somewhat less?
> 

This is the current and desired behavior when nodes are not in exclusive
zones. We still want the allocations to kick kswapd to reclaim/age/demote
cold folios from the local node to the remote node.

But when that happens, and the remote node is not pressured, there's no
reason to wait for reclaim before servicing an allocation.

Once all the nodes are pressured (all kswapd is running), we end up
back in the position of preferring to wait for a page on the local
node rather than wait for a page on the remote node.

There will obviously be some transient sleep/wake of kswapd, but that's
already the case.  The key observation here is this patch allows for
fallback allocations on remote nodes when nodes have exclusive zone
memberships (node0=NORMAL, node1=MOVABLE).

~Gregory

