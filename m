Return-Path: <linux-kernel+bounces-825202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B145B8B45F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6597B5A5783
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2885821CC60;
	Fri, 19 Sep 2025 21:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEx5j+1l"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED72D2571BE
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758315978; cv=none; b=unNTsLT4LH8ZhufSgSdz6OvtbDpMBx6+70Wva2I2bKASuJ/Wmct09tv75zGcm9UyNiy4jZwKPd0wFjIGzKADb9ZcmSVv6xn1KeouTCxz2EO3RJJMRc4OFPes37Cq/caa32m1A16WZuDDw+vnfD3a2HZaldNJFrJWYHF789b214A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758315978; c=relaxed/simple;
	bh=mYL8LPLZd7hL3B/CEVwMC0fgq/N+htgb3gAD/aRTppI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTJz95PilNVyksBF9jhAuYeL4r+pbhHL2iqfdgTMx9LnpADm14G6VvXiEaKXOmNEoUj5EYLzNzRqN2NVtSFoelp/XJfCw0mHOzhdDeIvlcPzHgIomxuMaCs+FVrm0VkpxboJ3sWTRDcj8g3UTzlRVJnZK7319cUVxbghrvgm2SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEx5j+1l; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-ea5c1a18acfso2840706276.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758315975; x=1758920775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWPFq5XLiSe5P7Lh1OFm30F3HOSWuJ2B7iUyo634nUk=;
        b=TEx5j+1llNCX8oXdYhgFOE/+SpG3Mce/0nsU5DHvCZewXLawxVOJc/REfAsOc+mW7s
         m9mhAgoiIvDsdKyAKW+orVs5kQgIACPnQKVQ0YbTMg+EW8olGOk+WfFKZA9utQC+KT5R
         z97AanRTG60DmY5Q1WkJsJ/ORB8o++mH7oyp+5EoJssyOZSRciu/PgGXm9PinsP45r+L
         i92cShY5rAa6iiLaiEmqJKi3Yvd6QWGjjHHm/N9gvmzIOig6cIgGLV5K3QxhvlU52jAC
         X/qBbMMFeLhN3pIGpR+c0EudF2FBavcn9O8rXH944zWRn1q0rv5eKS2tmjEr33gxNAVx
         oYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758315975; x=1758920775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWPFq5XLiSe5P7Lh1OFm30F3HOSWuJ2B7iUyo634nUk=;
        b=hSw1hL+JqSkc6fhj4k4gWRrJtAdSMAMGlNQhpVrVwZZljmLiqxU59u+nyMreLDRUEx
         RlPBxcFKtfxixJ4Km9Uxj2SZiWc5X4cjv44ho9o+AqM0Yd6aesua4cWIst/4/uhzoVMU
         B0DlZ7JqCvEH8ynS9iy7DTK8Cwzon4To2walQ0kndmRf7xGDqYVYjWU7nYl6KqdJc4d6
         P6/Ux/jFMCU4NiaFmMQXwmd25Ux9YJaJqTF2NESZFofOK62ftA3OCBRBA9NWfXH8O0mB
         9C/mrVkPy1QIjYoWhwyNVPyeBU06/tNsgGY7IBf4wq/h/GGO2RNsjhweP0OTkKk7PGFb
         /UgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQM6xuT1eMRGZfcGmtgs9DAQtOKcWhodgMsbgvPObh09fhia+GHnOuhTclvjmv/WfjRKKZ44viSKeOyXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTNdBtZQ3y/cGZbyI3034FpS7MpOjxP84ADQSO6EJTCzmvtckX
	V0w1XgPLx8iWecfagsDuSvzMMHq5Pb3K9nnmEs6NcToZH3qiggfEq92+
X-Gm-Gg: ASbGncuxb/3kBgjXcIWF5KubwfubVnnAo9GfY5flc411Nl8thrTyzvxvRWTZhuqazRZ
	ivghffgGo+RtSOrvxWaKWB+rh2HYoxJOt5HnEhARpB7VzvWr3sLWOaDaATg4UgPzvgcFVFllqL3
	gNvGOgou+jmp2ohAMsSRSo6uEdEJKyx2HztKUVXwls/4xxCPe2Q3XYr7tTqrT9YmcfxXv0M4iBi
	kiLFJj5IFoDgx5C3I2zpXNYL9Q8qHTKNmNh4Wf7Ahmfx5EsUSrbRiN80zzwLFINOOVniP46rAoS
	TU3Wy5k2b3ykaNSWt0dbk0Ta8Qu9zSCFTFiF43HE9ElO1iQx5UY6YKHWNa+20uQrsCX/Jq+PUEk
	id5jfTzUrk2BdhO2m93hE+KGNM8B4tR1PeinkPeN1NXW8SNVmJ993
X-Google-Smtp-Source: AGHT+IGu/B19WQElReS4mpdnS2mhyC2RhfwEOQrFXpAd2AUmLIVgGNgyYw5nlRAj/98u6sCZST88wg==
X-Received: by 2002:a05:690e:c8:b0:62a:83f3:a575 with SMTP id 956f58d0204a3-634779c2cf5mr2920693d50.8.1758315974624;
        Fri, 19 Sep 2025 14:06:14 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:b::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea5ce85481fsm2010344276.19.2025.09.19.14.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 14:06:14 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Brendan Jackman <jackmanb@google.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH 0/4] mm/page_alloc: Batch callers of free_pcppages_bulk
Date: Fri, 19 Sep 2025 14:06:11 -0700
Message-ID: <20250919210612.1975459-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919130644.f3a4afdf0c2e51bbec59b6e0@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Andrew,

Thank you for your review, as always!

On Fri, 19 Sep 2025 13:06:44 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 19 Sep 2025 12:52:18 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> 
> > While testing workloads with high sustained memory pressure on large machines
> > (1TB memory, 316 CPUs), we saw an unexpectedly high number of softlockups.
> > Further investigation showed that the lock in free_pcppages_bulk was being held
> > for a long time, even being held while 2k+ pages were being freed [1].
> 
> What problems are caused by this, apart from a warning which can
> presumably be suppressed in some fashion?

There are softlockup panics that we (Meta) saw in the fleet previously. For
some reason I can't get it to reproduce again, but let me try to find a way
to trigger these softlockups again. 

> > This causes starvation in other processes for both the pcp and zone locks,
> > which can lead to softlockups that cause the system to stall [2].
> 
> [2] doesn't describe such stalls.

You're absolutely right -- I was revising this cover letter a bit and I was
going to link the below message separately, but decided to put it in the
message and fogot to remove the footnote. The message below isn't a softlockup,
but let me try and get one to add to the cover letter in a reply to this.

> >
> > ...
> >
> > In our fleet, we have seen that performing batched lock freeing has led to
> > significantly lower rates of softlockups, while incurring relatively small
> > regressions (relative to the workload and relative to the variation).
> 
> "our" == Meta?

Yes -- sorry, I think I made this same mistake in the original version as well.
I'll be more careful about this!

Thank you again for your feedback Andrew, I hope you have a great day!
Joshua

