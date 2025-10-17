Return-Path: <linux-kernel+bounces-857538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1D4BE70FE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E65E626A39
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BD226B96A;
	Fri, 17 Oct 2025 08:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IxHrI8yk"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D887247DE1
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760688620; cv=none; b=TOpJqo7vYsE/qPX8jntJ3AvKx1vmQCKCGsbh0VPlWtRKjbw/0SEXuDHfxYIZRSxWPgwEzyN9zyFk9yiozzbcjaC4+W4hzi76zAF/wQ97KX4IMoK6AUQ9o6H6KyBCOKSmf2shgFzQ5tjweNGfMR8A+opNxmiaMyxKOrFk+sOK0I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760688620; c=relaxed/simple;
	bh=3iV73grwZVL5e+M3W2mQ8pBkc2HE8s3ztCwUlslCTHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3TYvM4FSQIUqWXxxJLCA1JAM4JSaxmY8fxnlMJHh10heQRCBQC7S7hFcxYV6bQse+ryX/uSZQ8vv2bzRtVQmJc2ij3BOw4qt6DgkbpFF9LN9LfuoFSCzEYiyV8+kCn0llQ2r7VX14qM4aZPtl+2AV/rCvBfNoP/8zFBer27mAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IxHrI8yk; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760688609; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=N4g7Sz/sJFHpZPMFxNijrb3z0sAlp2EIUfkGGeOKoiE=;
	b=IxHrI8yko2v5XfoiRyf6kJCqcYvmG1C5r1xkTnEnZn2958nkgwfjAsJnrAnJ0ZHIPwjsWUjYv61EYAZla9ihWTnFTkKNLX/Rm2+STy6E/Vj3GV/kpchg4+jD7dRXk7rpd0i3ktghQdS2IeA9VD23ytfb53DBveja4u/K2zf5BmA=
Received: from 30.221.146.57(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WqPArJo_1760688606 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Oct 2025 16:10:07 +0800
Message-ID: <cdd47a33-d0c5-4e7d-a210-fb3236e6749c@linux.alibaba.com>
Date: Fri, 17 Oct 2025 16:10:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new 1/1] mm/khugepaged: guard is_zero_pfn() calls with
 pte_present()
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251016033643.10848-1-lance.yang@linux.dev>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20251016033643.10848-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/10/16 11:36, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> A non-present entry, like a swap PTE, contains completely different data
> (swap type and offset). pte_pfn() doesn't know this, so if we feed it a
> non-present entry, it will spit out a junk PFN.
> 
> What if that junk PFN happens to match the zeropage's PFN by sheer
> chance? While really unlikely, this would be really bad if it did.
> 
> So, let's fix this potential bug by ensuring all calls to is_zero_pfn()
> in khugepaged.c are properly guarded by a pte_present() check.
> 
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>


