Return-Path: <linux-kernel+bounces-815242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53194B5619B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 16:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11FC217F389
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 14:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916392F0666;
	Sat, 13 Sep 2025 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlkxxIC2"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B822EC0AB
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757774115; cv=none; b=GOY13hTxcXsv3Gwz7aqUh+0HtNnxMWkeWB5E2FmdPXtO/62BDHrJDJwlR/sJ2IAGgDWH3bhVMy6aDB3ZFBbRb2XXvZOwtZKOwM4ZdCnZg7RjGK2GzhWAYmA3TnGUIJRGnunO9dMImebuGrKMtbDxGFsuIMT3ZdjRfF4fmdgifvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757774115; c=relaxed/simple;
	bh=BDUX9YlCgL1zi6slcpLNU7LLkO4E+t3sycYAa7g+gzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQYmHT3EySuPEBSnKCd5r2wi3TOcTNURpTaUw9qYQPHDwkK6c0XydHjGsZCnkL7eWWsgpiDPv7Q049t/GhIcBwgRchBMf3uozJBeocytt01d8JjAIQhkbpE1hKg9ElFKusCz51D9aqT/vjNgbHWjljRwdXtTeYn872xnTx0OF5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlkxxIC2; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3e7643b0ab4so1850339f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 07:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757774112; x=1758378912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6fiXrarRSR0kdAO2K4VRZ44JDkzpu5N8uZFGaP00hf0=;
        b=TlkxxIC2X7r5jXx/y+ztZkr2LBQJ29qwqF2FJDA8qww3dI9e7n+8MSXw8GLQBk7itC
         vIk3FCRUwH92oKVXlfOaiKGE5X81haNEnzZmiON4oGOloCuZBgJAAwtae+Fnu0g06Nqg
         vkjP0sXUlrwZ6UiY/nCfRkn73RdNTYYugtNa43OpX7sMmk/LJzgvA842g5HcIkGM5nXE
         MQ7UB2ZE2R02wM6Cy5W4BMpclZxSCjsMS9LFh61bkuE5eo4Wk02FIpBNT52NQOHnaWNh
         d48aY5U4UcJVROgf98xd8ktB8r4FocgWYQDjHJw0uKs966+Qj6BNHDCA/Hgg/+H7ChCU
         R0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757774112; x=1758378912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fiXrarRSR0kdAO2K4VRZ44JDkzpu5N8uZFGaP00hf0=;
        b=WgMLSIIBqxOjLRQpby7y04akmypp9nVWnjQbvk5iUASBs92++nMMkI3Xv08DBDA/RD
         5Eio2qKw6cCW5/c/RN4W2AQC2742Hydzzg6JNwxryHRhriQiGpSXK8frNs5IwYiKT4ld
         9vOGSLJGEAszEgITEwVsKfP0aTOKP+T4Wtj4iB9qZTAYMXM5Z5Bkx3F067su0GgUCYCk
         aa5egrVRdz/F31ZUxeqRt6X0KitimHXPyz5Ffa8b2Pi5H4wNABb4rtp5KvFQNjne6heG
         hmfd+GvgbU+8F0gh79+cvA0WtnNiYdeZHv2sxrFIDtdbVPwUebS5b/FuQmRc8qjNqaBI
         aKcg==
X-Forwarded-Encrypted: i=1; AJvYcCUh1DfxAYjP7Yn8ldSnnQBSiKTGuWv2N0IYBEFlIJPugx3/sa45dr5YgNGjyUr8FQW6xH/n5MKqEdvYt08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS7Zp3YAJ1wJ3yuZ3PYBn5gGjnRkPT9OsXywwSinALbWFgqh9/
	SU6V1AeVnVxRO7YMMN4IpKsemYyI9J1OtEPTlrmNVXTtWKZJnqzUIxER
X-Gm-Gg: ASbGncuOkagvisOPZawpHpWRYKaJMPv7+FUlKdSr10AXM0s07fHIkNheUcmDLBRpDTT
	EDyfPFtXDH9uAOCbiyostPNmRrmu+RaJx0HGxjNtgTtorkfuKvhnIqdiU957F9W9yFmyebmDv2+
	+4B/yCzRxzHvi0wHXhlCt+PRmhrZGz+uJNKHh2Tj051utPNSdMi/77K1Fh418BfhhmgxVhBtIf2
	c9ZXOxPv2PTzBxEewP+ZVfhEA/6EJWvE8XVMmGMbYC5VEEIMj5r4oPrQGoG9+1jIamqIwXZ0Rxd
	MWnrw88NF50Ii0QnPkinuHGoEpYWwyVVFX2eWK13yv0Jib479Hnu3WL24kruCFWcwrwu2S0y/cB
	TGpczprw+kX98ZcFEB8bMs6k1XtZIGl1hgWjiLkQq+4KkyGTmOb1UUlL9O8LKB6fbszSaxQ==
X-Google-Smtp-Source: AGHT+IHhpBBCovNgxAqBRlSFfJutUHogP+FA8KmrQiU/CxNP8LHdbv9lBhG/X6uQAQCakmX95bODlw==
X-Received: by 2002:a05:6000:26c6:b0:3e7:4c93:18bc with SMTP id ffacd0b85a97d-3e765a092c1mr5272349f8f.49.1757774112195;
        Sat, 13 Sep 2025 07:35:12 -0700 (PDT)
Received: from f (cst-prg-67-222.cust.vodafone.cz. [46.135.67.222])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f29174de1sm15209675e9.2.2025.09.13.07.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 07:35:11 -0700 (PDT)
Date: Sat, 13 Sep 2025 16:35:03 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v5 01/14] slab: add opt-in caching layer of percpu sheaves
Message-ID: <ja3gd6bdckiuanm3xu4hszpjm7euvffm3k7tmu7drh6mdel7m6@oyr635vikumk>
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
 <20250723-slub-percpu-caches-v5-1-b792cd830f5d@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250723-slub-percpu-caches-v5-1-b792cd830f5d@suse.cz>

On Wed, Jul 23, 2025 at 03:34:34PM +0200, Vlastimil Babka wrote:
> The sheaves do not distinguish NUMA locality of the cached objects.

While currently sheaves are opt-in, to my understanding the plan is to
make this the default.

I would argue a hard requirement for a general purpose allocator in this
day and age is to provide node-local memory by default. Notably if you
have a workload which was careful to bind itself to one node, it should
not receive memory backed by other nodes unless there is no other
option. AFAIU this is satisifed with the stock allocator on the grounds
of running on a given domain, without having to explicitly demand memory
from it for everyting.

I expect the lack of NUMA-awareness to result in increased accumulation
of "mismatched" memory as uptime goes up, violating the above.

Some examples how I expect that to happen should this get expanded to
all allocations:
- wherever init happens to reap a zombie, task_struct and some more
  stuff may be "misplaced"
- even ignoring init, literally any fork/exec/exit heavy workload which
  runs on more than one node will be ripe with mismatched frees as the
  scheduler moves things around and the original parent reaps children
- a process passes a file descriptor to a process on another domain and
  the latter is the last to fput
- a container creates a bunch of dentries and whacks them
etc.

In all of these cases getting unlucky means you are using non-local
memory, which in turn will result in weird anomalies which suddenly
clear themselves up if you restart the program (or which show up out of
nowhere).

Arguably, the fork thing is a problem as is and *probably* could be
reduced by asking the scheduler upfront where it would run the child
domain-wise if it had to do it right now and making fork allocate memory
from that domain.

But even with this or some other mitigation in place there would be
plenty of potential to free non-local memory, so the general problem
statement stands.

I admit though I don't have a good solution as to how to handle the
"bad" frees. Someone (I think you?) stated that one of the previous
allocators was just freeing to per-domain lists or arrays and that was
causing trouble -- perhaps this would work if it came with small limits
in place for how big these can get?

