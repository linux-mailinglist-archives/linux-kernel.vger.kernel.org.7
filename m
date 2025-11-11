Return-Path: <linux-kernel+bounces-896121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE63C4FB0A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665A63B42A3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D943D33D6D8;
	Tue, 11 Nov 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx4jPGLH"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112AD33D6E0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762892474; cv=none; b=JB8PRRdgq4fJ96ZFaBQNtFwrQJm+BWbMHNXFi177UQbcv9WB8RuzyUMjh1/zqit9OYCzeRKIApMhwhSIFTTNEJfn8qFC3WPruc1ocLXSk6zXa28yvO6Prs+W1adjGfKz9055JPsFcZwUxys6XTcPTtkQMtMU+RRDtEXqb6eDQrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762892474; c=relaxed/simple;
	bh=d0Uwe/lEuU99IOaaqFoIrf/FmtYFINnvQYwbCLVF+nQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5ZGwBVL8tw5WRiMlu1+sJyiPLX9jdT9mgfc9ANntPOs3IJrFxvzIYleJnJlPoZC6NqUrOY8cwF2rY5twid6xoN7c37IigGiyhp+UE4e0/dWibyj7UH/aNGdVZjdg+L8nNMwYsHlT047v2VDJsn08SF7fBltcfjgAl5vLKRthxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mx4jPGLH; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-594285c6509so105316e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762892470; x=1763497270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7bM/Z0egb7ac8A1IhbTkYcl7dpLdkBduvWKO9rOoaso=;
        b=Mx4jPGLHFH3/3bFs4L1dBmAfddNsVhgO/7+gXP6e3hr+M4XhkoDU+26Heel0SudPAU
         evHSyQAFoZu7cVltHGy0kuroJL7e1wRYkufYmB+pBpngjNsfoq/sgBT9h0VlhvwEiu2m
         jOcCRToLe6tRvHXEDiWhRYyo3UD7QP5vmzbbl8Aq4AV3Hep/HpTk2sN/69f8tfry+1st
         uKc8T+YraYjODo+rZwOvYj6oFv9JIFN7I75woWifJ5xcf3m586+QxWQZorLEThRfkpdq
         oyJHU/lzotuDjR+gbkyMLNQ1H90t29tE35E8T0/90daDyYSyUjlqa2Hi+qpfDajdz5aL
         KTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762892470; x=1763497270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bM/Z0egb7ac8A1IhbTkYcl7dpLdkBduvWKO9rOoaso=;
        b=ILG3bYfgIcfcaI/6z4gTivAIbw+8wlkaAv9CAdgGlslNq+IWSpFR/2aGjbDCN8Nsx2
         pF8I9PBZeCZyYqBmpcy6zIphvpRU9biGCnsxTUhuI+B29zJ/2ZnusJiIQO3xXcZp3jzm
         CySU4XrO9L9pLGuZ36f2bbBsbfw898AlMz3G3iu8p0h3CVP6kzoVAo7+nsT/44DFjiz3
         GxJNg5sAFQ+kIGO6Enq4sIqoLktHP4WOZtLYIDrd+YTrxJ4E7m/g9Hd95JqL7SLV2n+8
         RXkmHLl8FAfDx02ZHjqsr6hr3QajweF59HxBJdOSACRGRZl4AnLcTSpSb2YqwIsq4rye
         PFmg==
X-Forwarded-Encrypted: i=1; AJvYcCXQRqclnq8fRhKA7M7HpIMsYRSIxQFaXhkKMj/aK3DTJ1GgMI5rLs8eXEHhrgPJpfFqc8dzmA6duC94l4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YynTD0KkMo9pRy6sM819XB+8Bi2DY3IaPG9g9Cf7DaEp6H2N1kn
	8tEqRe7ZTRFCOvecoajKfqEJpPT/GA4sGdurh9+GdOpGb+eg+n+p8X6a
X-Gm-Gg: ASbGnctS3Y6YpgtdcRavVH+a8TiiwzFH/bwzI/qm0f1EYlw2CB8EqTZUZ+VHTiEbF2c
	uh2Q7zNZE941b1ObBADGfxeeGElfJrmZFYaOeZKzh3ZFzwYOfJpr/fnrDTCPZ88uDwSnp6hfvER
	8WosEdUy2UP14rA0GyceyDBdpwB4nqPg+zp95QuvcQO1oquiS97SzIk8RF0SLgNAb9lOZqxgA/6
	UABDwMNn57t64fwbKbP6K80GawxtZDsBTJqR4lJFFA+/8SKZr/2BmGFGmsoDOqErADErJ78Ufxz
	mcaM7fm58XyqEqX2wJh7FkAXaJvWuXUBvjV/7uMvJmr6SCalG5ljoX+H82Vyz6uYcTuEqrQi6co
	6bZLEIr54ueTk8bj5n46C1DtxcXRXFfmqknHm4j/t+Vs=
X-Google-Smtp-Source: AGHT+IFOzNyOb24VBUupwqxWTVYpD+MA84ViEpm3t8gfgJpb6EOwHuFRtQ8tg4P+Y1UGmZYJD9xpaw==
X-Received: by 2002:a05:6512:3e0a:b0:594:2fe7:11e4 with SMTP id 2adb3069b0e04-59576e1bd76mr156463e87.28.1762892469267;
        Tue, 11 Nov 2025 12:21:09 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a39eb32sm5298492e87.82.2025.11.11.12.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 12:21:08 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Tue, 11 Nov 2025 21:21:06 +0100
To: syzbot ci <syzbot+ci9989da8336cb2bc7@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, hch@infradead.org, hch@lst.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, urezki@gmail.com,
	vishal.moola@gmail.com, syzbot@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: make vmalloc gfp flags usage more apparent
Message-ID: <aROasppMPmek9Afh@milan>
References: <20251110160457.61791-1-vishal.moola@gmail.com>
 <69123b72.a70a0220.22f260.0105.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69123b72.a70a0220.22f260.0105.GAE@google.com>

On Mon, Nov 10, 2025 at 11:22:26AM -0800, syzbot ci wrote:
> syzbot ci has tested the following series
> 
> [v1] make vmalloc gfp flags usage more apparent
> https://lore.kernel.org/all/20251110160457.61791-1-vishal.moola@gmail.com
> * [PATCH 1/4] mm/vmalloc: warn on invalid vmalloc gfp flags
> * [PATCH 2/4] mm/vmalloc: Add a helper to optimize vmalloc allocation gfps
> * [PATCH 3/4] mm/vmalloc: cleanup large_gfp in vm_area_alloc_pages()
> * [PATCH 4/4] mm/vmalloc: cleanup gfp flag use in new_vmap_block()
> 
> and found the following issue:
> WARNING: kmalloc bug in bpf_prog_alloc_no_stats
> 
> Full report is available here:
> https://ci.syzbot.org/series/488ab7c0-de91-4749-bbb2-ca76c3fb798b
> 
> ***
> 
> WARNING: kmalloc bug in bpf_prog_alloc_no_stats
> 
> tree:      mm-new
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/akpm/mm.git
> base:      02dafa01ec9a00c3758c1c6478d82fe601f5f1ba
> arch:      amd64
> compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> config:    https://ci.syzbot.org/builds/2334ae39-552d-4ca2-8562-7adc18ce2cb0/config
> 
> can: broadcast manager protocol
> can: netlink gateway - max_hops=1
> can: SAE J1939
> can: isotp protocol (max_pdu_size 8300)
> Bluetooth: RFCOMM TTY layer initialized
> Bluetooth: RFCOMM socket layer initialized
> Bluetooth: RFCOMM ver 1.11
> Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> Bluetooth: BNEP filters: protocol multicast
> Bluetooth: BNEP socket layer initialized
> Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> Bluetooth: HIDP socket layer initialized
> NET: Registered PF_RXRPC protocol family
> Key type rxrpc registered
> Key type rxrpc_s registered
> NET: Registered PF_KCM protocol family
> lec:lane_module_init: lec.c: initialized
> mpoa:atm_mpoa_init: mpc.c: initialized
> l2tp_core: L2TP core driver, V2.0
> l2tp_ppp: PPPoL2TP kernel driver, V2.0
> l2tp_ip: L2TP IP encapsulation support (L2TPv3)
> l2tp_netlink: L2TP netlink interface
> l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
> l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
> NET: Registered PF_PHONET protocol family
> 8021q: 802.1Q VLAN Support v1.8
> sctp: Hash tables configured (bind 32/56)
> NET: Registered PF_RDS protocol family
> Registered RDS/infiniband transport
> Registered RDS/tcp transport
> tipc: Activated (version 2.0.0)
> NET: Registered PF_TIPC protocol family
> tipc: Started in single node mode
> smc: adding smcd device lo without pnetid
> NET: Registered PF_SMC protocol family
> 9pnet: Installing 9P2000 support
> NET: Registered PF_CAIF protocol family
> NET: Registered PF_IEEE802154 protocol family
> Key type dns_resolver registered
> Key type ceph registered
> libceph: loaded (mon/osd proto 15/24)
> batman_adv: B.A.T.M.A.N. advanced 2025.4 (compatibility version 15) loaded
> openvswitch: Open vSwitch switching datapath
> NET: Registered PF_VSOCK protocol family
> mpls_gso: MPLS GSO support
> IPI shorthand broadcast: enabled
> sched_clock: Marking stable (21550045890, 115271513)->(21677757748, -12440345)
> registered taskstats version 1
> ------------[ cut here ]------------
> Unexpected gfp: 0x100000 (__GFP_HARDWALL). Fixing up to gfp: 0xdc0 (GFP_KERNEL|__GFP_ZERO). Fix your code!
>
It looks like we need to add __GFP_HARDWALL to the white-list-mask.

--
Uladzislau Rezki

