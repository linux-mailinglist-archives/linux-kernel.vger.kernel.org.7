Return-Path: <linux-kernel+bounces-835419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34233BA7098
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 14:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0DD61784F1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 12:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7342DC346;
	Sun, 28 Sep 2025 12:53:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED83A2D594A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759064009; cv=none; b=qWjdTXGcAKsoWNDvSZND2rAMRDBCSwJsChILTuPM3XAjd9KSNceiR0TxFlz2dmIwtJpMCZIoH241IhDyi+SRdLNek16gBr1onD+U6XA1UqPOr7vag1JgndJIPHF+HBeG678V5hMkjNbm/JmuTMdMPSDTSO4nbbGZ4ws4+Rie7Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759064009; c=relaxed/simple;
	bh=WRMuH8FjcGi3m2sUC+ywTerdReat98QUnEtjEjKvkr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z0g6hoRlvgmYXXhyeg8g1IU1Wdrak1M5qB4tlvIUrA3gp7BfDLlMutf2D9e4eiPrRyARhHW8ps7huohoN6YxSoLYRTi3Ygs7Ig0mAASeuwuYboC0ovqtFj8rCX+AI0B9jkfcGNDSQlgDM9/Rmd2J57kuc/BcIjtFS5rm3RHkSeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7006150C;
	Sun, 28 Sep 2025 05:53:12 -0700 (PDT)
Received: from [10.163.64.48] (unknown [10.163.64.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 120893F694;
	Sun, 28 Sep 2025 05:53:09 -0700 (PDT)
Message-ID: <3c3f9032-18ac-4229-b010-b8b95a11d2a4@arm.com>
Date: Sun, 28 Sep 2025 18:23:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix some typos in mm module
To: "jianyun.gao" <jianyungao89@gmail.com>, linux-mm@kvack.org
Cc: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 "open list:DATA ACCESS MONITOR" <damon@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:KMSAN" <kasan-dev@googlegroups.com>
References: <20250927080635.1502997-1-jianyungao89@gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250927080635.1502997-1-jianyungao89@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 27/09/25 1:36 pm, jianyun.gao wrote:
> Below are some typos in the code comments:
>
>    intevals ==> intervals
>    addesses ==> addresses
>    unavaliable ==> unavailable
>    facor ==> factor
>    droping ==> dropping
>    exlusive ==> exclusive
>    decription ==> description
>    confict ==> conflict
>    desriptions ==> descriptions
>    otherwize ==> otherwise
>    vlaue ==> value
>    cheching ==> checking
>    exisitng ==> existing
>    modifed ==> modified
>
> Just fix it.
>
> Signed-off-by: jianyun.gao <jianyungao89@gmail.com>
> ---
>   

Reviewed-by: Dev Jain <dev.jain@arm.com>


