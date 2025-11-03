Return-Path: <linux-kernel+bounces-882742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C6AC2B4D1
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8361894733
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3320D2F3C12;
	Mon,  3 Nov 2025 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I69Nt+ZZ"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA252ED84A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169010; cv=none; b=KcC1/PgXsCKpsNnU6gml+I8TyIBS0D8RNKhtu7/XItShRiRSJu9zVlh5edZ+3yYB4RpKwh7FZK+yNAoEsdxlmqK6gGsTe7FSpP0RXGVaQx/zrd7/qUlsCHhpEPo41W3KWwU5pRIV+yc9UV8H76AJxekRBcZNM73S1HW/cJwDFRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169010; c=relaxed/simple;
	bh=zrhN/426GIFilnVCj4jC8s7WHQTdZuCf3dYpf2RYbrU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jl65mmogx/2TdsB22M3NYhRKUSkZDkDxYmm6HoOrikuhRHgmtZU1A9pzubzIQkrVq8hzsSZu40oPE+K67rEdi8h4Ysuu4t+iPbDEHcRuIZtRPaBMMRItwcVNMOwG54o2cDm8UvETVuMvTcfvnZD2g5fgEVoKRY9DeHgJyCVn2+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I69Nt+ZZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b6d2f5c0e8eso869761066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 03:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762169007; x=1762773807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTiOq3s4Du2klSTxft/DNgygXTqBjyM4NTyZGqGWusY=;
        b=I69Nt+ZZiN1mB8kdAgiRvjcMenTdUvXmY/pnc/P02Jqgw5pxoidebb9JyI1WKhy0Wy
         0rfT2QPC75uexucKKTbO9H6e1DHsK4Z5c6Bp/ADNs2qYexwNsMRhDK6kymfkWOPI7nSE
         JhThI/u9wOrCh2Z02Mi7hLCiLLAbhVFDhrjsGB/QX3rKi1+FyxEDVJ38EBvjGoPkUwLj
         UVNXZLyZThKCqKf5EFZ0Y0iMn7pr6GPi8f8JYF+eDSiCVEeyEmefPLQ6DpnJSp8/TKW9
         fzFrnM3mJJIVsvgRBM8R+3HaKoRR90TNBDGCkSbC4YU7lUx0zZCX6Ez9rRG0qbA/skzf
         qhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762169007; x=1762773807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTiOq3s4Du2klSTxft/DNgygXTqBjyM4NTyZGqGWusY=;
        b=vwXf0sUw3Eqc2RT0fF2G7yHomwH5IpXgTIpwCadLS3R3kj8T3R0k5NHMJHF+DUr/zV
         F57E0cix6TNPgyg5Sf/TX5Ho1S/WPj5KkXT6GAINVTwBvcCiJqvdjePQKFoiMqzQDheB
         o3g3hSPCPJY/ZWOBnUeVK53f4g+9T0/MzWA1AwnNv0Cz3rPx92O78nQl3KbM2lAMoJly
         pUnDk7TgFLqNbsU/S8S7rvdVfZ2qQqrE6lOUtP4SxfdMFWANyodsdKEMRnM6kwcPBsJr
         aDMG5PgShmAgVLXYalK0IPuSjeZQSIUGsvnuBtFCITd1J3kKe5VzKamWCxD136QkreIx
         AvAg==
X-Forwarded-Encrypted: i=1; AJvYcCVKWSDCm/nfiyD5N/HOCz1KPi5d7mxwPzg4GJLYhcOsBvjgzGhKFUDNpW/RdBJrZOVibhlRu1ArTnAJUFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl6A96vJorcZyKoSeQfVg7CFQEdhnOquDKnSUAeggpSa4s6QBJ
	POYaxiEj3qjzJWQELJEevsstdZf/WT6fmdWZL+0njhf4BYH8Uiu9V7e3lPRpHA/J
X-Gm-Gg: ASbGncvn9gZc1lgJwEqu8OaACdRzsC9DeV9FqGPh1Y0DZm39kzjMgTibvQxjWoj5Cdo
	mKP0no0ccFpg3sRQy2m9Kq5N4lFDANfB1eeCvmzGlkqQbvzCJG6HiSupxDDyhcptKCqgwEqk4dG
	OEwtyOiTMBzZ+Cdpv8QP3GnZ1MLBVgtAxre9Ib0/i19zfN3fCXD8nEjcg8KU0sMWlUYoHIKy1Cy
	nBBvHuWw6sd4mc1BhTMdDeN0z2hEninx4mCtGuUWWe2/g+4kjw4qNnpweqyQ68Oh9aKCsk5umOI
	B+lL0AP4WsgZVAPCoI+706YVbxetnIhlRJ35PMNvIe7oyB0a3oI6bxdz70aejymTZoP8Py8vtTy
	aLJGxNQUKseSKXzglOMkkuaa9rLDNQPqC2jzB4auzEe2F6h1Y6HSdubR6qT8pzAE+uu3JQ9xY8c
	DAi5EN2yuRYC8f99xxuOl+OCk=
X-Google-Smtp-Source: AGHT+IHSVTw67BWDPb21rBazTbhQ1l5vnr08OXapMWF6VsDckr7xusWomPoiAMolfRR8VzInf7Rdxg==
X-Received: by 2002:a17:906:3950:b0:b70:ac48:db8d with SMTP id a640c23a62f3a-b70ac48fb80mr408438566b.28.1762169006942;
        Mon, 03 Nov 2025 03:23:26 -0800 (PST)
Received: from foxbook (bgu110.neoplus.adsl.tpnet.pl. [83.28.84.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70b9f29c8asm358534466b.8.2025.11.03.03.23.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Nov 2025 03:23:26 -0800 (PST)
Date: Mon, 3 Nov 2025 12:23:22 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guangshuo Li
 <lgs201920130244@gmail.com>, Wesley Cheng <quic_wcheng@quicinc.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: Check kcalloc_node() when allocating
 interrupter array in xhci_mem_init()
Message-ID: <20251103122322.5433a7a1.michal.pecio@gmail.com>
In-Reply-To: <11d7b29d-a45f-48e9-bff5-cb94150d0bdf@intel.com>
References: <20250918130838.3551270-1-lgs201920130244@gmail.com>
	<20251103094036.2d1593bc.michal.pecio@gmail.com>
	<11d7b29d-a45f-48e9-bff5-cb94150d0bdf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Nov 2025 13:02:06 +0200, Mathias Nyman wrote:
> > Hi Greg and Mathias,
> > 
> > I noticed that this bug still exists in current 6.6 and 6.12 releases,
> > what would be the sensible course of action to fix it?
> >   
> 
> Not sure this qualifies for stable.
> Is this something that has really happened in real life?
> 
> The stable-kernel-rules.rst states it should "fix a real bug that bothers people"
> 
> If kcalloc_node() fails to allocate that array of pointers then something
> else is already badly messed up.

I don't know how the reported found it, but it can obviously happen when
the driver is bound to a new xHCI controller under OOM conditions.

So maybe not very often, but xHCI hotplug is a thing in Thunderbolt and
OOM happens sometimes too, so it's not exactly impossible either.

I thought it's usual to fix such bugs when they are known.
Simulated allocation failure before/after:

[ +30,414603] xhci_hcd 0000:00:10.0: xHCI Host Controller
[  +0,000012] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
[  +0,000159] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  +0,000004] #PF: supervisor read access in kernel mode
[  +0,000002] #PF: error_code(0x0000) - not-present page
[  +0,000002] PGD 0 P4D 0 
[  +0,000003] Oops: 0000 [#1] PREEMPT SMP
[  +0,000004] CPU: 1 PID: 4270 Comm: insmod Not tainted 6.6.113 #11
[  +0,000003] Hardware name: HP HP EliteDesk 705 G3 MT/8265, BIOS P06 Ver. 02.45 07/16/2024
[  +0,000003] RIP: 0010:xhci_add_interrupter+0x25/0x130 [xhci_hcd]

[  +0,042495] xhci_hcd 0000:00:10.0: xHCI Host Controller
[  +0,000012] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
[  +0,007193] xhci_hcd 0000:00:10.0: can't setup: -12
[  +0,000010] xhci_hcd 0000:00:10.0: USB bus 2 deregistered
[  +0,000080] xhci_hcd 0000:00:10.0: init 0000:00:10.0 fail, -12
[  +0,000004] xhci_hcd: probe of 0000:00:10.0 failed with error -12

