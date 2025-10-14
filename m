Return-Path: <linux-kernel+bounces-851984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 225C7BD7DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03044238F4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EBB30DD3B;
	Tue, 14 Oct 2025 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R/y325+A"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9612BEC21
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426661; cv=none; b=D14wsHv8oCzqxWeQOiiE8p6Z3FbYYbCa2Pwb3Il9Awv5OsHGH2QW4mc4TJcAweuWFmWFtgdXYJFPW6heef/Lcy4PXAvBpk302j9tXzYSF4QMntsUhRWOzm8ihSGFQvRf4AMy0Fx3GH37Yf4b8s07UJHz8nEP0lw/BlmfI/3TAF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426661; c=relaxed/simple;
	bh=XNpQiaoPmtubQWjx7HZt+FaoHtPtuE6h/eecJifiCfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACD21bosL1L6e4Le6b2F82szm5l4INlVG0jevY2S3sq1UgEm1FC/fKUCBnGDmmE/hL73B1PorKmwX9RPaxdQm1SDl+v4l0UNzJhlQWs4FPjltjGWw6BTyQTsNu1TXRt6cyDdEC8sARUacmar5kRab/46jIPDe4ZxbnxfC9HzIaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R/y325+A; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so29600415e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760426658; x=1761031458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DJsuSntfzmyGwBLDCIOK8zsxQdVVbjKkDRasCAUOBFU=;
        b=R/y325+A9c8MxvrcUQukZV+j96qhVzE2ziF8QrunjEewp5G9eqQsioXUUEwqBBtH1e
         S4vHR0knK68wKOmJppkqHeEoqP+qEriQU/Fg0aJMlzlooYsQg3Quax0Y1oirx5SeXPg3
         b/3i8ru3btHplF6Pwq2FBUYVE+ySUl3NqsqlhkTp6ovg7vJ3ZgM7R+rL2CFv1ft75oXr
         RN1cp2dRqIpudgFo1BZJ7y4hliUOrzpIfPEljpKFAb9QEJ/1TLDNy0srWOjY0MNmeYWv
         bnhYotosgLR1qcHEkK5wWFTSmUwvoiVkYxCl5evyHgeEHp/5s8L4Uu84U2F55nu1ahF7
         FMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760426658; x=1761031458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJsuSntfzmyGwBLDCIOK8zsxQdVVbjKkDRasCAUOBFU=;
        b=uDZUjs5M/yZw0UfG9OLInl9qdjIaYPAOziV7Y6dm+FRC4e8C+fI++xAs/3FCZA228k
         0617/n6KUK6JE5W1+KKC6zFyVIXat3wigabfXAmZv5SKBUUIY5gEfn5cbOov3rbBDNEk
         qAGFvRfVJopXKVAeIliGDrRdEgILzYT95y8gc0iQjOxkJDw9uO+V/Joux6VEocWoaeN7
         ccKekjMCclIVLVIEpbOopYrVCM6WjXfXILOFc8QflgRDd2OfH1AumUOeMcED/QZ7k/P3
         2uvifjIXFXhpWUuTvsv2pff9cs9kNThlVPe8wwJC5m66bYhglS5nknFTGDAbxYf/QyPe
         wA+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzehD7u3kpB0t4UBMzd6x0ejatTIpGbx+B7yUndy4vraFvbeVcJF91vGZrUzTPem0u4j4MbGljgJVjw1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+pB0yeYz7HC52U29kDWUiSBtefOmuRb8/KRpd/Q1hvm0N/wm/
	BmMPFF80poWU1SNLrpBZkchCOmdO5Kp2NN3zsgMSFm2i4PYuW5uoFt/41DZdXQFPpbw=
X-Gm-Gg: ASbGncsu3m/O8DBt5vrcVDU9OgVxXbqvSisvmB6/vbBmFiZ7VTpvkJ/Ui+eGSamxvmB
	q3/Vm1/9x/jKfRHr1ANqj1XCmpVYSoV3Xm5vutDD5yf2YBWECgjaNxe0VEECXl+/8pIVESOq/Ib
	xYwlOLVTSvQoqRPQZcF/viAibAc31drDKxUu0DbvcxBGKRWe2TC2lfdYI7LiN0JlDdxlIzTG31M
	cmYLX53bas5C4uqsN+Y/9TTVU3gMzPeVNi4tFUz96X8/nV2zRHxdOmmmLhcVCCnudQXcZBh09WR
	TGWCmVEX4+bMCR5sdDR8DUnJ8rRJAO+YNTmPlFGLpZn9inJLrTt3bVvnMD51T4HmWxHhHWhU9WM
	WJDJOR6RMei3ajY6ZTJ20v4TJaZg+NUKXBQHQ6dQnCe2VKo+GOCjYC+/V6RPsfEo=
X-Google-Smtp-Source: AGHT+IFRg4GPmLD9q+m6Z1pGRfggv0OTz6EOdiAPNLgTJQcEwNtxGs3WA3GtVkRT34c+YV2Jq9/wAw==
X-Received: by 2002:a05:600c:8b24:b0:46f:b42e:edce with SMTP id 5b1f17b1804b1-46fb42eee44mr106715865e9.39.1760426657567;
        Tue, 14 Oct 2025 00:24:17 -0700 (PDT)
Received: from localhost (109-81-16-57.rct.o2.cz. [109.81.16.57])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fb492e6ddsm250256765e9.0.2025.10.14.00.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:24:17 -0700 (PDT)
Date: Tue, 14 Oct 2025 09:24:16 +0200
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Barry Song <21cnbao@gmail.com>,
	netdev@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Huacai Zhou <zhouhuacai@oppo.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network
 buffer allocation
Message-ID: <aO36oKRR3UliRFR5@tiehlicka>
References: <20251013101636.69220-1-21cnbao@gmail.com>
 <927bcdf7-1283-4ddd-bd5e-d2e399b26f7d@suse.cz>
 <877bwyxvvl.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877bwyxvvl.fsf@linux.dev>

On Mon 13-10-25 15:46:54, Roman Gushchin wrote:
> Vlastimil Babka <vbabka@suse.cz> writes:
> 
> > On 10/13/25 12:16, Barry Song wrote:
[...]
> >> An alternative approach is to disable kswapd for these frequent
> >> allocations and provide best-effort order-3 service for both TX and RX paths,
> >> while removing the sysctl entirely.
> 
> I'm not sure this is the right path long-term. There are significant
> benefits associated with using larger pages, so making the kernel fall
> back to order-0 pages easier and sooner feels wrong, tbh. Without kswapd
> trying to defragment memory, the only other option is to force tasks
> into the direct compaction and it's known to be problematic.
> 
> I wonder if instead we should look into optimizing kswapd to be less
> power-hungry?

Exactly. If your specific needs prefer low power consumption to higher
order pages availability then we should have more flixible way to say
that than a hardcoded allocation mode. We should be able to tell
kswapd/kcompactd how much to try for those allocations.
-- 
Michal Hocko
SUSE Labs

