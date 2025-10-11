Return-Path: <linux-kernel+bounces-848915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF651BCECEE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 02:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D0F3E7535
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 00:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88521548C;
	Sat, 11 Oct 2025 00:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uDNbrDyp"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834A02110E;
	Sat, 11 Oct 2025 00:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760142315; cv=none; b=r8PwPjqaOw7fQAPYgsSFcRazD5JtKnw+WrKf7d35UwTCXkp+VoOrhRaIQgDhHZWyugt/LRhDFxWYBjPD/ukxs8JYSArsXttAUFcoRLDoYZ3+noEe8EvJZLQdee+G6i90EM8iLHcMcfJqx9b8wnhHx+m+2TiN/bECStQs7mIoqMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760142315; c=relaxed/simple;
	bh=xloi6/dDCBbBdQj0ATV0M5mulI4g6Kjwg6d5B3972vI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VB4aETtTGs+Ocv716pbQcYwdGMJGiaLFtx7cnCwV3EUVHBLP8i6fLvwfmFkof7oiteUUYxi2qeZ8NYfWPu0FriG3glcKQ9H1PRPOyBnNfevL7rrzRJj46KeFGqxwfpHimdvWgJNjaCE4tqxiXvnPDF7LKs+y68BPNZvU98JP0L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uDNbrDyp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=nC6HbeD+9G+hKIO6m1GM6pRZBQDK7wI3DYn9jMzQYfo=; b=uDNbrDyprSA6K1gO5XOEmoOI55
	xeoXdqA8MQljbE9wSMoC8Sr020ZHCoiJJlGVaoTOopfCWGwGcSeth+FfFTHYh6e4b3I0lMy7LPLpT
	lOyXwf9sGPYgsSvC/7zifl0eWxjGyfQkFsAsKRAhkWkw53+fKX/A8WeZ+b8l2nQ0+jbJlggbNOIMJ
	DSr1+a82fREA15W18zbC4QlBqCPnkXKmkNiBUWDrF+5Mt/MYR1z+lwSCtqWiRtj2lF+prDMGpcmYM
	F5fM0nMqoMbjohJHe0bFtkZaDUkn/7RjUd9Ti8l6JxyaliJOHOzZHNBZ/nUOK57x7VAxZYDMoITFJ
	kQL64Z0A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v7NQ2-00000009aHM-1fEn;
	Sat, 11 Oct 2025 00:25:06 +0000
Message-ID: <d8c6762c-e08c-4b7a-92e9-7dad17ad0b49@infradead.org>
Date: Fri, 10 Oct 2025 17:25:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][v2] hung_task: Panic after fixed number of hung tasks
To: lirongqing <lirongqing@baidu.com>, corbet@lwn.net,
 akpm@linux-foundation.org, lance.yang@linux.dev, mhiramat@kernel.org,
 paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com, mingo@kernel.org,
 dave.hansen@linux.intel.com, rostedt@goodmis.org, kees@kernel.org,
 arnd@arndb.de, feng.tang@linux.alibaba.com, pauld@redhat.com,
 joel.granados@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250928053137.3412-1-lirongqing@baidu.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250928053137.3412-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/27/25 10:31 PM, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Currently, when hung_task_panic is enabled, kernel will panic immediately
> upon detecting the first hung task. However, some hung tasks are transient
> and the system can recover fully, while others are unrecoverable and
> trigger consecutive hung task reports, and a panic is expected.
> 
> This commit adds a new sysctl parameter hung_task_count_to_panic to allows
> specifying the number of consecutive hung tasks that must be detected
> before triggering a kernel panic. This provides finer control for
> environments where transient hangs maybe happen but persistent hangs should
> still be fatal.
> 
> Acked-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> Diff with v1: change documentation as Lance suggested
> 
>  Documentation/admin-guide/sysctl/kernel.rst |  8 ++++++++
>  kernel/hung_task.c                          | 14 +++++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 8b49eab..98b47a7 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -405,6 +405,14 @@ This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
>  1 Panic immediately.
>  = =================================================
>  
> +hung_task_count_to_panic
> +=====================

The underline length should be at least as long as the title to
prevent kernel-doc build warnings. Same length is preferred.

> +
> +When set to a non-zero value, a kernel panic will be triggered if the
> +number of detected hung tasks reaches this value.
> +
> +Note that setting hung_task_panic=1 will still cause an immediate panic
> +on the first hung task.
>  
>  hung_task_check_count
>  =====================

-- 
~Randy


