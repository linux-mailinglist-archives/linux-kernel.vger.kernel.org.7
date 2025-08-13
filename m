Return-Path: <linux-kernel+bounces-767444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BF2B25447
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B839A3102
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7862D641A;
	Wed, 13 Aug 2025 20:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chJKdLgV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEE62FD7B8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755115592; cv=none; b=NOBSaLn2S+k4z3MYeg1jyn7mzP0+vKRiBgMrLMHeNgCpRkpvn6BznsH1EmbY3FNcxb9tVbnCfp4mE20vjfta1IGbaB6yaWNyV4OvS+U6oR47Z2ySHLdT3JN3Id96qqtt8vW62R1NodNvBJbuI9tIpSKhQXKWd4W7KCplzJFIGSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755115592; c=relaxed/simple;
	bh=eP0/SvV4fzqCDP5gj6X9P5PrmBVLr+qxf4Hatmahsh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbuhardLcEIMHVH+/8a0EI8XgVDwnMU8Ie2OkroowsvrmcLPOJOHvhpIjZHDz4krVOyM6JjMZoICNtUdP5orfgaDqbZWCNwvCePThopzZ5y01Cm21f0TX7qv7q0uFjBvuCayxctkCEg/+bkRxJEXyImuFMT3GqdYxQ7ltCZG3EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=chJKdLgV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755115589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=47lxym8iNHWBOL/w60+zi9Lo6y41CAt0QBGdV8YddYA=;
	b=chJKdLgVTfZW8WymkHJ09pC0rrbH44nPpqxfYnSPftOI4HrGhaA+QW9CElFx1pZxnA3rk6
	FU8Krhd+7dcXGQpyD2WDNwPc8zADGr49A6TePZn/i19YsP6SrljJYNNLIeawoJWMJvytdw
	2LDMws+TqdvHJYd2Tz7WZk+pzb41on0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-OGdYMNtoNrqjMcM-55mVWQ-1; Wed, 13 Aug 2025 16:06:26 -0400
X-MC-Unique: OGdYMNtoNrqjMcM-55mVWQ-1
X-Mimecast-MFC-AGG-ID: OGdYMNtoNrqjMcM-55mVWQ_1755115586
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a9f5bb140so8202076d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755115586; x=1755720386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47lxym8iNHWBOL/w60+zi9Lo6y41CAt0QBGdV8YddYA=;
        b=AmvrJwCYkphiSNcrnEJIRAFOyyWaG45Na7QGa0mj/Zw+DgqQk5vuPl7x8GE2bNnK5Z
         akCl3b9a19jv3UUVPQU5ZQylTmyYzxFSyA2iSkqcuRjk/DltK/JXKen2PQmP3flKl3Jx
         992W3EK1TG+QR2NCCC9B5njismb9mlTCwJfOKI3wdkZbs9XwcWYVLzMpFcGUvg5B2wEf
         9sHkUSUUaXRZHIa54zzjnSGMOQsMgFSPSuUdO26HOnI4Rj3h1DS0t8Z7FmDlQvDZPuO2
         qIr7FSv5tPsnmEipOY1KeJltm9UGggQBeNVGyqK3a8w6d4rXHgBfkkwDwC7lMWe3M73L
         tcrA==
X-Forwarded-Encrypted: i=1; AJvYcCULdr9Y0RbmN/RdRuE3SnWdS2CTxEIVw2qzWDvpbMr/WObhABkXS8MJNC/npkuatld9RTB9oHO2V/XQmgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDaB6NRtAylSQFrc/yyt2BNVq28NJI78Qf/HVpSBlfbBaB8Z7Z
	2tkTNxFiVOsa9jkrqksQkAhYMhquFN76HW6Hc2jXrd7AZHLpXZrRp1fjyeck8ssZaP05I846Fbs
	tl3FwaBLIwCovpGlwYUyR1UQX4H+/J2jhOMTYmhO/xffUOqEeg9rLfsjZNdS0a+edhw==
X-Gm-Gg: ASbGncux35lxQoKhI3E3vZ+/TRIGsei0xnDRKyGewpZVSTfY5o3LARoYQEnDcQQDhqQ
	iDkhk0sRtteUDon44YIUFOkh4qECkXgJoBlUcZnAjAxOYi9keDpqwiYtYb1bYeNMTYPdpHuiHW6
	3PfW9FR7B1SGkB3nowf/C0x7SXBBLoomtEiu9LnGo1aRHzzlDcO6gjlwkVC1MM1iJptj3/rDTMn
	9oJPbGzMyiEKkEDh9bJwINFD37vGJBcmw1q7Hy7/47Wn44JXZpN2Q9oD4q4nGgyXVbDbZQTJAey
	J4ZOaXiork4/Sv/yeglweVXvCDHyM+Fc
X-Received: by 2002:a05:6214:c41:b0:707:69ad:d84a with SMTP id 6a1803df08f44-70af5c31faemr8222156d6.42.1755115585958;
        Wed, 13 Aug 2025 13:06:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTvuKixXYylw6jZAk9WOPy5ESjWCqWkg0b02ZWazA25ZrJ13LuOVgPLfrU/sj8o6PUC9anPA==
X-Received: by 2002:a05:6214:c41:b0:707:69ad:d84a with SMTP id 6a1803df08f44-70af5c31faemr8221766d6.42.1755115585490;
        Wed, 13 Aug 2025 13:06:25 -0700 (PDT)
Received: from x1.local ([174.89.135.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70af5b0ed60sm2678236d6.45.2025.08.13.13.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 13:06:24 -0700 (PDT)
Date: Wed, 13 Aug 2025 16:06:12 -0400
From: Peter Xu <peterx@redhat.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, 21cnbao@gmail.com,
	ngeoffray@google.com, Suren Baghdasaryan <surenb@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Barry Song <v-songbaohua@oppo.com>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v5] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
Message-ID: <aJzwND0VIq6KB5kD@x1.local>
References: <20250813193024.2279805-1-lokeshgidra@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250813193024.2279805-1-lokeshgidra@google.com>

On Wed, Aug 13, 2025 at 12:30:24PM -0700, Lokesh Gidra wrote:
> MOVE ioctl's runtime is dominated by TLB-flush cost, which is required
> for moving present pages. Mitigate this cost by opportunistically
> batching present contiguous pages for TLB flushing.
> 
> Without batching, in our testing on an arm64 Android device with UFFD GC,
> which uses MOVE ioctl for compaction, we observed that out of the total
> time spent in move_pages_pte(), over 40% is in ptep_clear_flush(), and
> ~20% in vm_normal_folio().
> 
> With batching, the proportion of vm_normal_folio() increases to over
> 70% of move_pages_pte() without any changes to vm_normal_folio().
> Furthermore, time spent within move_pages_pte() is only ~20%, which
> includes TLB-flush overhead.
> 
> When the GC intensive benchmark, which was used to gather the above
> numbers, is run on cuttlefish (qemu android instance on x86_64), the
> completion time of the benchmark went down from ~45mins to ~20mins.
> 
> Furthermore, system_server, one of the most performance critical system
> processes on android, saw over 50% reduction in GC compaction time on an
> arm64 android device.
> 
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Cc: Barry Song <v-songbaohua@oppo.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


