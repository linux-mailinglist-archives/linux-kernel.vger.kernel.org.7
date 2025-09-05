Return-Path: <linux-kernel+bounces-803109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B55B45AA6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818175C0575
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A98D3705BE;
	Fri,  5 Sep 2025 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hj9h4lTw"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600233705B4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082931; cv=none; b=TEGvX0ClbCWVaVG9juZJ8CCzwruJFK42wl96sPjIpqVn/ERWDa39wpCQzpTU0yhbYJHXFEhvpPZSg0ZTv6P4Omrvn51nQD5qh8GcAXA+bNCktcdE7GsANYo+kdO9MPdhQyyjmjJlNQfwf9bzBilsXO4H6TXoLRZmLKTyt2sXVw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082931; c=relaxed/simple;
	bh=nBqVJvIHpZ/hhIkh512pJcRlR7IMGeiScyT8OJkadCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyLT3WaVRH4kR5SDSLj61pgs53BBIr/VWGwJcIpnfGWhrkBom1L4T5RocOuV+HvDVeefmYwinFXbNwcTn/tLW5/ie1YY8XprQSByTngb+LxqN978MD8DQtsjP5jVoE0WAkgjK3Y9nXhvNjhrgslXuHK8rpDc+4CV7WkT4ViRiuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hj9h4lTw; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f6d7a2a09so302527e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 07:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757082928; x=1757687728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wBMMkeCxHosHV7c8FxU0uPkYWEXN7KfNUsOKbUcY+ww=;
        b=Hj9h4lTwniaEeGeFQdFctyeqaC/S8l9svytLS/XYKNcMU2ajeYZYKSdJFvZu0X8Zxw
         1n9QxxYkXSXmjjbPagNc3erjXiV7oP0aD9BkbO/62vNqrkiz39TQLJ8kxYvj+nIcyqEW
         KOGTbvhgAC0U1Pb0mMxL8TKgG12fdMwi8XnjjLhqhoriWiWXQDMg27uy4Tz1rHvELxnX
         S5vNvVKxq+nqJwd8Bm0s9Sg6oQgNZnDz1HLT3ZegU41R/P60ZMKPshXFLVN7anDwo3Dm
         OwUtjFM1cYRRYdKXVE/s1Dt8Ua8077tZe+UZudUZFZiyenzqjKDplKkZGNYceJgBaRZt
         BA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757082928; x=1757687728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBMMkeCxHosHV7c8FxU0uPkYWEXN7KfNUsOKbUcY+ww=;
        b=HQGI1dL64T3hdVP+y48yhGnsuu8wR4vFd2qSJfwojCPYzw09NFW6OqlgeXEHP+mafg
         HSvQwzlkw20OlCp957sqtI1DicQqHX8PIJiw44INXndD4UpMSur1w1nZKR2FkvxIrW0G
         TONWcStXFrvriVFWq1jJOCJyhAcSIAFF9Ttj3f6DEvVOuacDQsgGiAGeyEs8vsoU1hsL
         P18g1owX67KLxO++BDNrssU3j+5+UKX+6qSPn2nYQ6LkhJBkXILYZT95HVW94I6Rnmbi
         L9156vCk7ydkO/ZS/rvsAlVZzeEt4vOhH5XxAXDdXvcCxNHRi+l2PFR19sp8PIxCgoX0
         wTcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpSOegbcq/bOHHLFTzCNLVkF3iLkCw2GxaOwztj1eag2lW9uQD8AYUg6sVflB7UACIL9I3HrFd1e3x1U4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzERiZvLRM47p9KN1apZg+eC9gikeUqKZXFNyEpNRwutuUgGlhj
	1gf/vPR5l44VeBiEizy38rXOMpE7mK1hXyemnjzPWj8bk6cXlEaT/sBX
X-Gm-Gg: ASbGnctbFOOFl7dpIudHE6kwv9OLDibdmiDSbZpKqbaVZaSp2znUqenJ0B70LrILQUf
	dh4eL3RPs23s0zzY9dE4waodBbnuQEk9IL5a9wrlU39xod6dR8Cn1aLCVwdhogtt8IQoRWwZw46
	E+oJ9/tcHffkJyb/XO8sAL37X5V4UQL2l2WXnVo0CiWR0nb2C+Q2Gz5G92+7m+L2FqnG8z1N8zO
	/nKAoBqM05zw9x4EOqRcxBgp0ddm2bh4Yaslxj5MjEm39GJvlzW4LcBcReWBrhEdz4XV6lN2y48
	iJ5hkptR14o2ZAI4H2pb9+BEB04ikJ1KE4SfMEMK1cnrsSwNR0+l8a8npeFpf80LPsQAvOOoGX7
	4XKoThMuUiwn4Y0kRHz1iLhhsfYrE7S4jOZnoun4=
X-Google-Smtp-Source: AGHT+IG4masltMaevxRMKJ471lFxHbeaLe9lEpEOz6RdTaqnQgxzkAWchzUMWXSGkj3L9K+f4Q+ZOA==
X-Received: by 2002:a05:6512:31c7:b0:55f:67de:343e with SMTP id 2adb3069b0e04-55f68b7d516mr4140045e87.1.1757082928376;
        Fri, 05 Sep 2025 07:35:28 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfc25bsm1820494e87.98.2025.09.05.07.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 07:35:27 -0700 (PDT)
Message-ID: <7563a670-0118-4110-8ad6-7771f22bd046@gmail.com>
Date: Fri, 5 Sep 2025 16:35:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmalloc, mm/kasan: respect gfp mask in
 kasan_populate_vmalloc()
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <20250831121058.92971-1-urezki@gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250831121058.92971-1-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/31/25 2:10 PM, Uladzislau Rezki (Sony) wrote:
> kasan_populate_vmalloc() and its helpers ignore the caller's gfp_mask
> and always allocate memory using the hardcoded GFP_KERNEL flag. This
> makes them inconsistent with vmalloc(), which was recently extended to
> support GFP_NOFS and GFP_NOIO allocations.
> 
> Page table allocations performed during shadow population also ignore
> the external gfp_mask. To preserve the intended semantics of GFP_NOFS
> and GFP_NOIO, wrap the apply_to_page_range() calls into the appropriate
> memalloc scope.
> 
> This patch:
>  - Extends kasan_populate_vmalloc() and helpers to take gfp_mask;
>  - Passes gfp_mask down to alloc_pages_bulk() and __get_free_page();
>  - Enforces GFP_NOFS/NOIO semantics with memalloc_*_save()/restore()
>    around apply_to_page_range();
>  - Updates vmalloc.c and percpu allocator call sites accordingly.
> 
> To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: <stable@vger.kernel.org>
> Fixes: 451769ebb7e7 ("mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc")
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---

Reported-by: syzbot+3470c9ffee63e4abafeb@syzkaller.appspotmail.com
Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>



