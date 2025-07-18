Return-Path: <linux-kernel+bounces-736418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 750F6B09C9B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF5316DB51
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B240423C519;
	Fri, 18 Jul 2025 07:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BthJAzLp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50222220F5C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752823661; cv=none; b=XqfqKq4bd4rvHis8J2IjNsyVl8Um51nKWNfiTzIpkpNOl/GjCG5nGwM7KrzhMQYycEMHa/pybFng/1kVBqhGLLA+8ZTusSUcMRTD7BWjILx9gxiKHZZ5Zy5kIfrX2xp2leVScPqWUFIWkVJmiznCW//K4gj/yZgPTXh5HBQ2TFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752823661; c=relaxed/simple;
	bh=/XI94bxaZF6nsib/YAIic7esxmyqatld+Hbdc/g4KEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rT6ghYN4Y/fqOAswA2JX2O7uoYuxWK4NIrkDtRkLrhItYVRe+vg02+CXAVP2d6rWfiGQMF0KvawhNLNYUOjdUi4jxapWPjB//lvaKgmZbQg5bOdusbS4Tr5s1Fxyd0vLRBZo/bZmFiLsucIY2Rx0J9SHUm0wAWkL0JSGwhGyeLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BthJAzLp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752823659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4ALo1+1dcRQ6+1vh0jlFPmWPIJu18nYlSnS7izQm0hI=;
	b=BthJAzLpsa5KHICNXqlp/6+W1MrFIO2AoTiRgQTPuMXFtpg3zCb5hwmWdB8Em2B9cLowz4
	LQHh2dgtN07o2x3IArFTd9h++AWyN7tKmwAroUAvdHxfYZYhU5TjstKFafmhLZmPikSUlp
	JS+f8GZdgwS+r2/9ZNMhrdCE9foWQL4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-A08kiBmfMuKXYml5edJM8A-1; Fri, 18 Jul 2025 03:27:37 -0400
X-MC-Unique: A08kiBmfMuKXYml5edJM8A-1
X-Mimecast-MFC-AGG-ID: A08kiBmfMuKXYml5edJM8A_1752823656
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45624f0be48so9429795e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752823656; x=1753428456;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ALo1+1dcRQ6+1vh0jlFPmWPIJu18nYlSnS7izQm0hI=;
        b=CZ8kpM52IhM6Ol41y+BGGGvybUEBtL0aiJaioE0YCyfFZHbVF2lOlxbYRiOspgKPHk
         aOsOdhm1b3m1jG+pG7qWwQ1GfldY8K6H8mIxxVrulSbYyQ656a3s4Q1g7wIGVAygZgFH
         HDjpj3Znqbk+mESAiMIUjvxZca4KQBMJfD0APKXtIfsYVZ6ltm6fnbj/lqOGzTuzVWJl
         8JVeuo3hEYzYxkuDh9hYaXsixQNr111tB6Z5QQ06av+yAqy637GtRKVcnTLC3NQz85Q4
         f5Mx0DDEFgLTeDsny9YOPg7Iayo7kLDWxD0QrWDpvWy7DbvOIZVfT2BMLY6acZvq23BF
         fDEw==
X-Forwarded-Encrypted: i=1; AJvYcCUDxX7Mj0lwSltSUHFRi4DGdncfBJMfgI+Cxt9y0D9XNBx+EsG92dnHCGI55U6V224sfHvJi3Hbgq+9wSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Dx6+FlE6cVdA+kkeQoiH5YhG2mnM43dK6iaZX7kd8rtcKxsW
	ctzEAT/VKgx9eLgMTAIO2goQlY4DnEWQFnPdwFHCuoNkx2r06olpf14MCiQ0TK1xLa6XHPeB/3p
	hI6IlwQjLdzlT7P7M+omCcecINbteQ7ZO5Gij58lJHDu4MISnfKKxhUdIhYVgwXqWzA==
X-Gm-Gg: ASbGncvFiX0kwq/mmwyPWYIwhYHH1sVl8zB0XMzDXVwRXlB30B/cZJPEcNKpzWi0Asy
	KJR0TFzo6NwRp+V5+zR6rj73z0VTPx0o/lvBXUOi53BFAgG3GPQIUJEmenfFkl4wocKY0Te12YT
	Y+8KpW4C6+I7FkXCNJcn5zsiAe+uw2MOjCD7kIOpeFoVer7/ed6Sv0kMO89Kvd8MM/HVnJwupHB
	75QIYKeLY4ARpl3fhaL8rp02BJq4y4Ju59a85QXbULOCLznpSUVa3FEX1a59z2N8lrT30snzys6
	biqkqa/FxEge0r5N2yKY6z4aCpNRR38vwYkFogb/FRLlDPhgml0VdvolMZ7rwUMsrqprdCrS9Tu
	VCqyQL13LCkraW9JbzHNZgBQXpNQrzViymZ/5rX+FZfDYSb4TxG44rpdtxzZhp5KPClI=
X-Received: by 2002:a5d:5d10:0:b0:3b3:a6c2:1a10 with SMTP id ffacd0b85a97d-3b60dd641d0mr9238131f8f.12.1752823655873;
        Fri, 18 Jul 2025 00:27:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXY554i1sD7NMWdm3rJHwC0QZPPTqjFIioukZFUaX3RVDz6Fry8yj4tBhWOgvo+CdOVqGVyg==
X-Received: by 2002:a5d:5d10:0:b0:3b3:a6c2:1a10 with SMTP id ffacd0b85a97d-3b60dd641d0mr9238065f8f.12.1752823655344;
        Fri, 18 Jul 2025 00:27:35 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f43:8900:f364:1333:2a67:d49e? (p200300d82f438900f36413332a67d49e.dip0.t-ipconnect.de. [2003:d8:2f43:8900:f364:1333:2a67:d49e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48a2esm1029324f8f.51.2025.07.18.00.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 00:27:34 -0700 (PDT)
Message-ID: <d6767c20-415d-4429-9528-595d029861b0@redhat.com>
Date: Fri, 18 Jul 2025 09:27:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Replace (20 - PAGE_SHIFT) with common macros for
 pages<->MB conversion
To: Ye Liu <ye.liu@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Davidlohr Bueso <dave@stgolabs.net>, "Paul E. McKenney"
 <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Ye Liu <liuye@kylinos.cn>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
References: <20250718024134.1304745-1-ye.liu@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250718024134.1304745-1-ye.liu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.07.25 04:41, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace repeated (20 - PAGE_SHIFT) calculations with standard macros:
> - MB_TO_PAGES(mb)    converts MB to page count
> - PAGES_TO_MB(pages) converts pages to MB
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


