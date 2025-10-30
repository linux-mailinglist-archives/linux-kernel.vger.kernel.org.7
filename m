Return-Path: <linux-kernel+bounces-878836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 324AEC2190C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7376A1A6145C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF17836CA87;
	Thu, 30 Oct 2025 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="N+Bjn4dc"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF6136CA8D
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846866; cv=none; b=kLJIoCrIG0rHkwlqx7LWpeJ0Cs+EwaMn0pxIvR6TlT1DFw2hiz6y7Z6Y9r9lKuJC4j2DYBJ8c7Q9KPqd74qmVnQB9hXrt+2MBS3fo5bUIsLJiWK8uqMLEbEYR0bMktIPdK9HdoXMwVhm05eoQ53/ykVH1p204AXiFA6EX8biauw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846866; c=relaxed/simple;
	bh=Ot7VKAWVA6U63aveIdvENPMHR/fzA9s/Q7X9vk9yVwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/z9/yju46tZbP12OUM4fSHGp/4GoJf2q3+NV7LggTwdsHLZXluAPIDGkriUbHKBXZCIdAJmnGRIUll1W0J8Yq+1QD7heOok89FhbHPqKIiJyc2bcvW58LtP9Mt1vRIWmB/q8q4LqqIpVX49TFLX3LCm1t9ss2yytwOo+kS2054=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=N+Bjn4dc; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8738c6fdbe8so16552236d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761846863; x=1762451663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xnGHUYavdaKYzYofeQc3x2iVgQ4gD7UndQ+CtCjwQis=;
        b=N+Bjn4dcHxxWfAqV5hI3zJl3PYNYCY0uv75DXJhSXvCmXBbvQfPNU1WBIEBGisZ36d
         V2ODdNFGqlmq0qf3nwfIjp8XNEy1TF+bglyj04noDoCc1VIGLJg5MxROuTF3Eex2G6L6
         tDhihRmak7FM9v4o5Y97AqUVjwogUChlcbtnGp45XUXTE477CB902zHsT4UjtoKX1ykr
         jcXG5mavr9wVgbR2zKc9i+VrSKd80EAOpmO0dKi0yMioQRgA+ABo4sazB7U2xPvp7d4E
         /j3GaBnfE2+Tl89HZjnDxNV2p1M3TagBhUHGfVRaSdIf1bMaBKUtSOn2Bdr/Bp1zIgy4
         w39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846863; x=1762451663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnGHUYavdaKYzYofeQc3x2iVgQ4gD7UndQ+CtCjwQis=;
        b=wV55t2rByIcjszeVU49xdLqn8/YHAwfaHxJU8A5sa29ZUWz3Uxmj3VEk44FUNcHjD+
         4VwwyO8JlO8zDZrwgSSZH2qkEH9yC0NNwA+e0VgHQsG3moVmXdT3c3vPoly0mcixHMsG
         Lszr5hdxlKQ5GJk4JffdFYwHnbbE4Ato8sEWbcyJyzIMlByy0sw0PeZlrn6OudwGp/ST
         sNEeyHRxANQT8/4hWIjeCOnVepfqlTCvmsC2zwTD6poPUBDsY1mzDaUJy9WX2bPG6kIy
         yMaet/ttL33Agnlq4SL3yYiTwER7UwtAb1HLjVArJ501QJ6locTwiKsSfZ2uWZs4MQPQ
         Kh7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMtip1BlkktZe2OzeKHnpWo8KD1z3FOsrvVPapM2kKVDnMRsMk6c1gwPXdRchI/jVD6gLhZynPn9B5FRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKywTO3RoD3xEzH9VtGvx1RddL9bplHvQpUx/bTUPgr2CTfcz1
	OEYU+Dhg7ghahZXSRDo3UgqTR138xvtIK6t0fOoR1BGaKy7Upck264AhyYyG/bZkMYo=
X-Gm-Gg: ASbGncugWuoE84wfDrourBWxRia3SvLMlR7j2WY6mTebZJo+yW6XexpV/hlApbke13P
	ls02AOkBwbWKmSvhLaJZVd8FXILUfu5MaarCvMl3f1QLiMPHtQikXJdQnSgIZpKaNzR0qnjGiAb
	yhb47Bm48TDPki2QMPoigJnuGBOQtVAg36RfGY5iUUbnt5f3n7/Rz2qoID9cSCapoAdqZDoSqEB
	ZK2xqX3L9/6nOVXSElzBe0Kn+eMGfSXQwu80acGko+D2kg32efXy26IacPEglwsVp8/vsFB29bB
	u7Ijyhy+UmJVvBbNwkHMmkAx6zbwzDYw4Djtb9mbLmee+ogt985r7ioBYa4uf85KBBWTSEyaWKG
	uj23t7kqIiwRFcjPNj9XG/hlGRX+uHUdxMYTimednWv9mlncR74Orql9sQaJd/cXfu/RPoT5QKK
	VabPVzaWkPvCQ8eNSab1uorEBLevFo03LGVWwUUKvyeFjMTg==
X-Google-Smtp-Source: AGHT+IFT5Fmbku/PhtCEDW1KeFw5jyVfP+ejaWvNde5H/+ME0TqKpHB8wRouWON1EINpWnQqdBBBmg==
X-Received: by 2002:ad4:5ca5:0:b0:87c:2095:c582 with SMTP id 6a1803df08f44-8801aca0a1bmr63713946d6.18.1761846863017;
        Thu, 30 Oct 2025 10:54:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba387a61bsm115313061cf.36.2025.10.30.10.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:54:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vEWqr-00000005AuU-2aX4;
	Thu, 30 Oct 2025 14:54:21 -0300
Date: Thu, 30 Oct 2025 14:54:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Kees Cook <kees@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Rientjes <rientjes@google.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/4] mm: introduce and use VMA flag test helpers
Message-ID: <20251030175421.GC1204670@ziepe.ca>
References: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
 <c038237ee2796802f8c766e0f5c0d2c5b04f4490.1761757731.git.lorenzo.stoakes@oracle.com>
 <20251029192214.GT760669@ziepe.ca>
 <0dd5029f-d464-4c59-aac9-4b3e9d0a3438@lucifer.local>
 <20251030125234.GA1204670@ziepe.ca>
 <a7161d7d-7445-4015-8821-b32c469d6eaf@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7161d7d-7445-4015-8821-b32c469d6eaf@lucifer.local>

On Thu, Oct 30, 2025 at 02:03:02PM +0000, Lorenzo Stoakes wrote:

> Yeah, OK well your point has been made here, the compiler _is_ smart enough
> to save us here :)
> 
> Let's avoid this first word stuff altogether then.

I suggest to add some helpers to the general include/linux/bitmap.h
"subsystem" that lets it help do this:

#define BITMAP_OR_BITS(type, member, bit1, bit2, bit3) 

returns a type with the bitmap array member initialized to those bits

Then some other bitmap helpers that are doing the specific maths you
want..

* bitmap_and_eq(src1, src2, src3, nbits)  true if *src1 & *src2 == *src3
* bitmap_and_eq_zero(src1, src2, nbits)   true if *src1 & *src1 == 0
etc

Jason

