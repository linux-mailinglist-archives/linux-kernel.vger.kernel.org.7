Return-Path: <linux-kernel+bounces-736296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B27B09B2A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276484E2282
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9131EA7CB;
	Fri, 18 Jul 2025 06:13:14 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE9917578
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752819194; cv=none; b=YPSJc0cAaR/nI6BcVABrWKJyIDb9pCLIceHACQZWeCvbBEcitdLFDClqUtVao/1Iq9FnMw7gGQisOxvqTMEpSFlOaToDcy1SdgzDInh66d2HyMd2oHTKTIWTHknrJa99iYuj3BWo9q14Cprp3tBnufAld6wufH1D+Uu+tb8igig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752819194; c=relaxed/simple;
	bh=oOJdZ3QpRKC0OUHSEPulECgkGgGzgktm1SG7K7DimrM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rwHm2G1wF6DOlLlO1dSgfFBUfaxOQwQMg5cPU6taKkwlrfWAIjVkShA73CUfwVZBLqYNRNr8EwpTGZUnCz5claTc1RntKGLJdlRs1kj+LNoFfnU+eMCghn4Nh4dTSIH7Keb6uxs+jhhm99+k24Z3QH/ikL+jPq0QnQ/rcI0FYXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bjzxJ4yllzKHMkB
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:13:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 4F2011A084E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:13:07 +0800 (CST)
Received: from [10.174.99.169] (unknown [10.174.99.169])
	by APP2 (Coremail) with SMTP id Syh0CgBnJrjg5XlohNSTAg--.54837S2;
	Fri, 18 Jul 2025 14:13:07 +0800 (CST)
Subject: Re: [PATCH 2/4] mm: swap: correctly use maxpages in swapon syscall to
 avoid potensial deadloop
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <ryncsn@gmail.com>, bhe@redhat.com, hannes@cmpxchg.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250522122554.12209-1-shikemeng@huaweicloud.com>
 <20250522122554.12209-3-shikemeng@huaweicloud.com>
 <CAMgjq7AcMtsS-EX0065jvucLR=YiAvPkjp+rmr=hfxyv9JVW5g@mail.gmail.com>
 <e836546e-5146-40fe-5515-0a185b72bdb2@huaweicloud.com>
 <20250717162115.18edbb2d71685482a98bcdb5@linux-foundation.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <e7cdf8d7-bae7-328b-db5a-f8aedfca85da@huaweicloud.com>
Date: Fri, 18 Jul 2025 14:12:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250717162115.18edbb2d71685482a98bcdb5@linux-foundation.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBnJrjg5XlohNSTAg--.54837S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYI7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vI
	Y487MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r126r1DMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCT
	nIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 7/18/2025 7:21 AM, Andrew Morton wrote:
> On Wed, 11 Jun 2025 15:54:21 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:
> 
>>
>>
>> on 5/26/2025 1:08 AM, Kairui Song wrote:
> 
> Nearly two months!
> 
>> Sure, will add this in next version.
> 
> Do we actually need a new version?  Having rescanned the v1 review I'm
> inclined to merge this series as-is?
> 
> 
So sorry for the late. I will write and send a v2 version soon.


