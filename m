Return-Path: <linux-kernel+bounces-893323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69099C47116
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9B51893EDC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441813126BD;
	Mon, 10 Nov 2025 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1Ycw4nL"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9837E2FCC01
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783255; cv=none; b=LgeX/CFENd38FtiCg11IHh5/UN9soHbx+FfiiiT7Kk77dKsJdiIKr//ZywytJOkCM6htPHCLdUkOqBJCcYvQ2Jg85PKmwzOwgQFFOsK668WXGy4+TaYSxbQ18XtQ5W/Rzhj5fEjmOAtSjknE4sG+nR4C7rMKraHuqrsy+ru5bQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783255; c=relaxed/simple;
	bh=FYssamICSy1FmCGsy60I7YqSmDHQPMWdfL0FRzWDmX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGrmFMCCnOV9SvGQhfO9m1ebIbfUsTq3dw1Vw99UFCeUFogNOvGpk/z0s+W3VOwioVe1wf77uR+9hCx4g9JT7AcGoUc3JlJVTzSqJunxbOidpA2IdD7hfbUQDS2elxd2dSOitjfVnJwHI6OCbdvGJDud/ZZ4UU5PnH6xZJUAG6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1Ycw4nL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4777707a7c2so12044195e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762783252; x=1763388052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S4rnPuFoLSJY+wYOcC/uitVXQKa6g6GidhYhMA27fY0=;
        b=U1Ycw4nLZcQa0MUbYMDJQ4bl1L6GW91HgS0EXC+XVNEXl4gTsELurTLjVn6SKBlNTS
         cPspNaM2UKBuyQdZUO/vRpYMKQVDVIrUu7QJuN7aAlcnRroHvdYgDPmgi9+pQNvUz+gg
         bNqRVCPqeL8+/HbFuZGTtW8FiAQzB0AklxYThoa5qBcUTjTrmprGZ8YiKfdRIlQzZ3ug
         dXPpRoA1vfbltfIDBS96nrpVLLvnx7bhhdLyO9CSgjBVmEsX91D/QN1zP7q6/ooirjY1
         /+W/bu9V6zzG7796uJ5yoRi6l5eXX4BiNTGJWFVkbDuqlRPPLOfmI5XLMeS5Diet0c0b
         srQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762783252; x=1763388052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S4rnPuFoLSJY+wYOcC/uitVXQKa6g6GidhYhMA27fY0=;
        b=I173ekmG6ZJY22ShK7w1thoWq1A7UbxHLaX6ica3f5yHSITMgy7s+hpCkRmn3Q+7Mf
         UCDnELwkoyocERcw5OJb5rstdzz/gB8Bk6H/RzdgT1ywGePeH33yWK/Nlp8ZgvhlISRF
         8tbeUxIDn9MHyszaXmB9KPUTHjey4HGSBzDtzGiX2hEQNE1HqHNAR+a312F+9X7pY8ae
         3BZMiCcJihtMZzNfd/cW9Xi9h0CsUcLtAD1QQp7yh++xy/NM7Gu+9OS8P/jJm6IaNoZR
         Gb3MwxwocOh53RUBhYHB9ufee0GXuhVfv4awO9qrN1DvCaykRK1NwKzm0eaaVCLvcRJJ
         afHg==
X-Forwarded-Encrypted: i=1; AJvYcCUEN4o2H6ydfPMRycCko3hzThv4rDX/YO/hS9Y9i5RwzDMm1sSrYsA4UyWQcp+nUpAnVJ7/MB34aT0bv8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0vwMyk5XR+Q0wkOvweBeBS6T8nlkz03J21BWwep2VRZQFdG2N
	Z6WunOPWkJWN7e3yIIfM/uu/xQqj/rDDihTpnJjuoyVRmzx2SmVvelLV
X-Gm-Gg: ASbGnctODcL0jm6rz794sf0oy1afOZD4gHneUyeW7FzYrhYKF3V90HzDE8S0qvvW3Al
	J90tYfLXC61WnHCPSUwFhhfYvMsYHBJ11RTRmX6RyvzVBqI2JXVpR1BU3aCHnADj1dGGRMURgDd
	KOlgRmIkYJsb+7wIbuhd+RweCIhLdv9vK+VxdDvexONw7yMLx0u7cMlCZFHTsh11PJadEgz223M
	RgSsdJZUOg4eqrm30y9eIBAjeHiI8+dyBC1RM0K+YQoAiS0tK70L44qfj/gssZ32Nh/k50khpXD
	j6NwUR0M+8x1dMhs4tZqSuCG8VpeFUJIVsqMUOqtkymStU5cS2I82SIhJwU5PAZQWFSsXgJHtRy
	M5iArCkJI6tw7INftfxzIvgriJJ+HfKRmCBcIDnzkI3QGn7gmW5onAg3j5bQceDVh/BKywI8s5R
	k/kDs2yhE1fusJZWwSgHY22TBchx4=
X-Google-Smtp-Source: AGHT+IFoy/cBqZOm2wlTrv3klXznz9YEiEan3hTFzorPBnCLjU6edYiPlVgEB9J1b7JmjmFZ0TjJEg==
X-Received: by 2002:a05:600c:8592:b0:471:793:e795 with SMTP id 5b1f17b1804b1-4776db7e562mr79140925e9.0.1762783246698;
        Mon, 10 Nov 2025 06:00:46 -0800 (PST)
Received: from [10.80.3.86] ([72.25.96.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47761c2fe2asm265979035e9.5.2025.11.10.06.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 06:00:46 -0800 (PST)
Message-ID: <42ba9a0c-846b-4a9a-a434-9d53c770f948@gmail.com>
Date: Mon, 10 Nov 2025 16:00:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net/mlx5e: Make DEFAULT_FRAG_SIZE relative to page
 size
To: Mingrui Cui <mingruic@outlook.com>, Dragos Tatulea <dtatulea@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
References: <MN6PR16MB54501AC60FA25B6C79FB2C3DB7C5A@MN6PR16MB5450.namprd16.prod.outlook.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <MN6PR16MB54501AC60FA25B6C79FB2C3DB7C5A@MN6PR16MB5450.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/11/2025 17:33, Mingrui Cui wrote:
> When page size is 4K, DEFAULT_FRAG_SIZE of 2048 ensures that with 3
> fragments per WQE, odd-indexed WQEs always share the same page with
> their subsequent WQE, while WQEs consisting of 4 fragments does not.
> However, this relationship does not hold for page sizes larger than 8K.
> In this case, wqe_index_mask cannot guarantee that newly allocated WQEs
> won't share the same page with old WQEs.
> 
> If the last WQE in a bulk processed by mlx5e_post_rx_wqes() shares a
> page with its subsequent WQE, allocating a page for that WQE will
> overwrite mlx5e_frag_page, preventing the original page from being
> recycled. When the next WQE is processed, the newly allocated page will
> be immediately recycled. In the next round, if these two WQEs are
> handled in the same bulk, page_pool_defrag_page() will be called again
> on the page, causing pp_frag_count to become negative[1].
> 
> Moreover, this can also lead to memory corruption, as the page may have
> already been returned to the page pool and re-allocated to another WQE.
> And since skb_shared_info is stored at the end of the first fragment,
> its frags->bv_page pointer can be overwritten, leading to an invalid
> memory access when processing the skb[2].
> 
> For example, on 8K page size systems (e.g. DEC Alpha) with a ConnectX-4
> Lx MT27710 (MCX4121A-ACA_Ax) NIC setting MTU to 7657 or higher, heavy
> network loads (e.g. iperf) will first trigger a series of WARNINGs[1]
> and eventually crash[2].
> 
> Fix this by making DEFAULT_FRAG_SIZE always equal to half of the page
> size.
> 
> [1]
> WARNING: CPU: 9 PID: 0 at include/net/page_pool/helpers.h:130
> mlx5e_page_release_fragmented.isra.0+0xdc/0xf0 [mlx5_core]
> CPU: 9 PID: 0 Comm: swapper/9 Tainted: G        W          6.6.0
>   walk_stackframe+0x0/0x190
>   show_stack+0x70/0x94
>   dump_stack_lvl+0x98/0xd8
>   dump_stack+0x2c/0x48
>   __warn+0x1c8/0x220
>   warn_slowpath_fmt+0x20c/0x230
>   mlx5e_page_release_fragmented.isra.0+0xdc/0xf0 [mlx5_core]
>   mlx5e_free_rx_wqes+0xcc/0x120 [mlx5_core]
>   mlx5e_post_rx_wqes+0x1f4/0x4e0 [mlx5_core]
>   mlx5e_napi_poll+0x1c0/0x8d0 [mlx5_core]
>   __napi_poll+0x58/0x2e0
>   net_rx_action+0x1a8/0x340
>   __do_softirq+0x2b8/0x480
>   [...]
> 
> [2]
> Unable to handle kernel paging request at virtual address 393837363534333a
> Oops [#1]
> CPU: 72 PID: 0 Comm: swapper/72 Tainted: G        W          6.6.0
> Trace:
>   walk_stackframe+0x0/0x190
>   show_stack+0x70/0x94
>   die+0x1d4/0x350
>   do_page_fault+0x630/0x690
>   entMM+0x120/0x130
>   napi_pp_put_page+0x30/0x160
>   skb_release_data+0x164/0x250
>   kfree_skb_list_reason+0xd0/0x2f0
>   skb_release_data+0x1f0/0x250
>   napi_consume_skb+0xa0/0x220
>   net_rx_action+0x158/0x340
>   __do_softirq+0x2b8/0x480
>   irq_exit+0xd4/0x120
>   do_entInt+0x164/0x520
>   entInt+0x114/0x120
>   [...]
> 
> Fixes: 069d11465a80 ("net/mlx5e: RX, Enhance legacy Receive Queue memory scheme")
> Signed-off-by: Mingrui Cui <mingruic@outlook.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> Changes in v3:
>    - Add a warning for page sizes above 8K as suggested.
> 
> Changes in v2:
>    - Add Fixes tag and more details to commit message.
>    - Target 'net' branch.
>    - Remove the obsolete WARN_ON() and update related comments.
> Link to v2: https://lore.kernel.org/all/MN6PR16MB5450C5EC9A1B2E2E78E8B241B71AA@MN6PR16MB5450.namprd16.prod.outlook.com/
> 
>   .../net/ethernet/mellanox/mlx5/core/en/params.c  | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>


