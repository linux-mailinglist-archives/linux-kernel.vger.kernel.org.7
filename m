Return-Path: <linux-kernel+bounces-611169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDE5A93E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 21:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C3E465EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 19:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EBB22CBED;
	Fri, 18 Apr 2025 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="F0Sfa4xw"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1074C29CE6
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745005823; cv=none; b=DMGQ5WziKAWZwLdeJiAYvup5XSU6LR6nCWIzO4kP0dA34MW1Dx+0HofC631dMoS0z7qlQIo8ZYvdZpoV2G+ZTOEdA3Nuju3N5pERvr3J5QXtSMdcIwvPCidODvoqyGQexFq2C4GnEW5f9FRleCJfpBFPjuAd3CVLcSYH+PLMdmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745005823; c=relaxed/simple;
	bh=e9RelHQ6jACDHpYiEM2I/Tba3GRyqdVgZ/2MsbNgCaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qD0VxaIFDQUI4vCOg+uanX0NIGXjR4gQy1TODIqqI2E24z9qTC9wrfTab2CcZ5v279a9Y2CNdo0zIZ6QU9VR9KpumYGFKG8mg3q59XNeIBe3/Jp3VfF6FKLrDN05pztrfb/B191/jTjfoqBGlzz3UW+2eTto3Ete9KAbbuNtWns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=F0Sfa4xw; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8f05acc13so25531556d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 12:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1745005819; x=1745610619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NZIpJlMfSrAl5tIsrT+nGzfFnGMUyfcntMF+OWrMx0E=;
        b=F0Sfa4xwKNAzBe9SNHKHvFGMRE5Wo2drsXrpDF9q7hewAoooE5XAWn3cDWqs4hfGh9
         ppfhO07o56x4M+hHmtYC15U6Hc0GaQezZ088sg28bFyjH9PLaEchJ4Hkq9IPAFr00PZF
         POVGpoFTjUI/H+BgY0h2QNWEYjoMsNA72K//6kRzPmJiTcyjtyEAYa9REiGYDHm7jgOL
         GJxTWNQ4jOCT2g4v38OwbwMgVR8Jx9GmV/P8tLlmgdzEFgW/P2AiPkMckdDuYasNGblW
         lpPZa4D6jRx31GnMnfNcfZ5Q76dhKIzgsBPcR0qzevjivLqasM4bEkPiZDTlidT4nDNa
         lDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745005819; x=1745610619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZIpJlMfSrAl5tIsrT+nGzfFnGMUyfcntMF+OWrMx0E=;
        b=ElTl34dqLVx0O9ENeLDdAs5a81bo/fJlCmPQSHlBurD1PLtC/1FB1w+uBKIB6NAdAo
         jiN8utjJOhwG3eM+iZLYgUH3bZExq4aOcphvKr06DwBUKh7Ai7Y/4DKNB+hIAPElrCg5
         34VRXHZQkZ+SJLNlJrAoUpA0yhA7SLDmDrgyYmpyeMGNh4AYgxta/WLN9hUg+RvlKDOo
         luM6WyqruqQ/zvEhEUyIUmMyy+uu1JQ3xux9WdBXbKGTama/NSlIoCq2Knj9ffTnAd5B
         vPYzatuu1lL74Ap1u5y0u+foboM0EAQMt+6mV97yYs6dB7Qthao0jIQH5yzA0bQ4Z4Zg
         T0VA==
X-Forwarded-Encrypted: i=1; AJvYcCWKm9votZfF4Zspv8aIAaQ+BXsFO1ofsVsMLXKSxhAw14zB4jeBonmgFVKqwGRbEiGqa+YWESnIbjVQfCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG1fDuC1v3ohEzbGKWAbZY07U/mEr6hLqu07ub6ZBC94X6FroV
	fqU0PIJpgdIYikvLFmNLFRhDp0OBc3F+rDnTeXEHWk+cH5LVdP529nrnBKE3xRw=
X-Gm-Gg: ASbGncsnRXodlzn+anIFlt8zCHrwqIYVAAtaQyNrht+QVLhTb1JSzvbuElY6L9UxqoG
	8b3dhBJ02ycqKrFk+aNSLVrOtI3jTCMEXf7ItoE10b7dCypRSEF9sNZO09vSF+WQYrUre4PtkeE
	HRqG1BjdBMUasOV8tIoSwRqkX3z8UnzsJEfuw7EA9Uj3XTiR0cINU00qTumhyS05nPwugkA0x+N
	tyk6mXd6UOWCCKj+O5palHNV17PMw0nH1pUVJtfCMa6qtlc/xXgjKDNS4Rig926pspD5c0XECq/
	znnucDQ07gWP7yqgXkYphcTpLAtqczMzTr8H9AU=
X-Google-Smtp-Source: AGHT+IFG3LBqPjgQwSPk23I9MqvaEayWbINNH1Mnqd7uxhMrvknN6OBJKn7Qk/jpVgEALxeT6uR8iA==
X-Received: by 2002:ad4:5ba7:0:b0:6e8:98a1:3694 with SMTP id 6a1803df08f44-6f2c44eb12fmr73235786d6.8.1745005818730;
        Fri, 18 Apr 2025 12:50:18 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f2c2c21d90sm13760766d6.105.2025.04.18.12.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 12:50:17 -0700 (PDT)
Date: Fri, 18 Apr 2025 15:50:13 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	david@fromorbit.com, zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com
Subject: Re: [PATCH RFC 06/28] mm: thp: introduce folio_split_queue_lock and
 its variants
Message-ID: <20250418195013.GA877644@cmpxchg.org>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <20250415024532.26632-7-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415024532.26632-7-songmuchun@bytedance.com>

On Tue, Apr 15, 2025 at 10:45:10AM +0800, Muchun Song wrote:
> @@ -4202,7 +4248,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  		if (!--sc->nr_to_scan)
>  			break;
>  	}
> -	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> +	split_queue_unlock_irqrestore(ds_queue, flags);
>  
>  	list_for_each_entry_safe(folio, next, &list, _deferred_list) {
>  		bool did_split = false;
> @@ -4251,7 +4297,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>  	list_splice_tail(&list, &ds_queue->split_queue);
>  	ds_queue->split_queue_len -= removed;
> -	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> +	split_queue_unlock_irqrestore(ds_queue, flags);

These just tripped up in my testing. You use the new helpers for
unlock, but not for the lock path. That's fine in this patch, but when
"mm: thp: prepare for reparenting LRU pages for split queue lock" adds
the rcu locking to the helpers, it results in missing rcu read locks:

[  108.814880]
[  108.816378] =====================================
[  108.821069] WARNING: bad unlock balance detected!
[  108.825762] 6.15.0-rc2-00028-g570c8034f057 #192 Not tainted
[  108.831323] -------------------------------------
[  108.836016] cc1/2031 is trying to release lock (rcu_read_lock) at:
[  108.842181] [<ffffffff815f9d05>] deferred_split_scan+0x235/0x4b0
[  108.848179] but there are no more locks to release!
[  108.853046]
[  108.853046] other info that might help us debug this:
[  108.859553] 2 locks held by cc1/2031:
[  108.863211]  #0: ffff88801ddbbd88 (vm_lock){....}-{0:0}, at: do_user_addr_fault+0x19c/0x6b0
[  108.871544]  #1: ffffffff83042400 (fs_reclaim){....}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x337/0xf20
[  108.881511]
[  108.881511] stack backtrace:
[  108.885862] CPU: 4 UID: 0 PID: 2031 Comm: cc1 Not tainted 6.15.0-rc2-00028-g570c8034f057 #192 PREEMPT(voluntary)
[  108.885865] Hardware name: Micro-Star International Co., Ltd. MS-7B98/Z390-A PRO (MS-7B98), BIOS 1.80 12/25/2019
[  108.885866] Call Trace:
[  108.885867]  <TASK>
[  108.885868]  dump_stack_lvl+0x57/0x80
[  108.885871]  ? deferred_split_scan+0x235/0x4b0
[  108.885874]  print_unlock_imbalance_bug.part.0+0xfb/0x110
[  108.885877]  ? deferred_split_scan+0x235/0x4b0
[  108.885878]  lock_release+0x258/0x3e0
[  108.885880]  ? deferred_split_scan+0x85/0x4b0
[  108.885881]  deferred_split_scan+0x23a/0x4b0
[  108.885885]  ? find_held_lock+0x32/0x80
[  108.885886]  ? local_clock_noinstr+0x9/0xd0
[  108.885887]  ? lock_release+0x17e/0x3e0
[  108.885889]  do_shrink_slab+0x155/0x480
[  108.885891]  shrink_slab+0x33c/0x480
[  108.885892]  ? shrink_slab+0x1c1/0x480
[  108.885893]  shrink_node+0x324/0x840
[  108.885895]  do_try_to_free_pages+0xdf/0x550
[  108.885897]  try_to_free_pages+0xeb/0x260
[  108.885899]  __alloc_pages_slowpath.constprop.0+0x35c/0xf20
[  108.885901]  __alloc_frozen_pages_noprof+0x339/0x360
[  108.885903]  __folio_alloc_noprof+0x10/0x90
[  108.885904]  __handle_mm_fault+0xca5/0x1930
[  108.885906]  handle_mm_fault+0xb6/0x310
[  108.885908]  do_user_addr_fault+0x21e/0x6b0
[  108.885910]  exc_page_fault+0x62/0x1d0
[  108.885911]  asm_exc_page_fault+0x22/0x30
[  108.885912] RIP: 0033:0xf64890
[  108.885914] Code: 4e 64 31 d2 b9 01 00 00 00 31 f6 4c 89 45 98 e8 66 b3 88 ff 4c 8b 45 98 bf 28 00 00 00 b9 08 00 00 00 49 8b 70 18 48 8b 56 58 <48> 89 10 48 8b 13 48 89 46 58 c7 46 60 00 00 00 00 e9 62 01 00 00
[  108.885915] RSP: 002b:00007ffcf3c7d920 EFLAGS: 00010206
[  108.885916] RAX: 00007f7bf07c5000 RBX: 00007ffcf3c7d9a0 RCX: 0000000000000008
[  108.885917] RDX: 00007f7bf06aa000 RSI: 00007f7bf09dd400 RDI: 0000000000000028
[  108.885917] RBP: 00007ffcf3c7d990 R08: 00007f7bf080c540 R09: 0000000000000007
[  108.885918] R10: 000000000000009a R11: 000000003e969900 R12: 00007f7bf07bbe70
[  108.885918] R13: 0000000000000000 R14: 00007f7bf07bbec0 R15: 00007ffcf3c7d930
[  108.885920]  </TASK>

