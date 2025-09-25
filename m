Return-Path: <linux-kernel+bounces-833367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C445BA1CA2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C44F5628E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713482E9EBE;
	Thu, 25 Sep 2025 22:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GXdEBbxB"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219512749E3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839177; cv=none; b=cQcwzgMu5ZeiTKVPhsnevIAZS+ZjNSMcU4gOPN6ZF1hp7LLEr3+gOhzqMtBWz7vQ9SrNP5GxIpCoqYX+8gXmA2/tNxf1UJph8W8DBcGApUplcCr2fDddP3lQ8c8pxkQVle/xhDUh0DgGOP90dbp+s2bdLiae/fGjrBITaY5rXoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839177; c=relaxed/simple;
	bh=lTCfAhOCCFujviUGkPpU3RVShb+sKb6mxlJP5kOiJCY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NM7uash2EGgtKs1Gg2LNII1vKVdYVpLGqiGe3VUKD5xBIwV4tfVOlJ9olUuCFGATkDByn+btrsXrVka6F6Kg5sd/trAam4qpl0skcohEvSt9UIurIzKoCAXuebgUlchLgDmIsez7M9qS7ez8FIKMZBBqi780K3Fcsh4FwzgZnGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=GXdEBbxB; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=YYqXCwQWRl1v5mvc0PqGxp32U7oTfoGl3dZTYyV2InM=; b=GXdEBbxBNwjLB0z/eTfkbQ92sO
	uPDNPCJ+qJP8BT9qX5RTyBSWDT3M87lQlTUrRDh5G8SunIxNw1CBNq37Zb1kXuxwqS6A/raQtuzd6
	3mCr7BOSgputcxoch3j27pFdAA7IRDGotL5aJrZ81L6qfZnwFwr0AXWU4qfIvhFPvAR2+3GstJzLE
	bh8JbmLctN/rgjSbRNaz4Ja0GbUjN3LeUh17EeuufiNMM7eYHhcUGCvzBSXsH3UaaDutzLo/6oVmv
	gJX3wV4XDBpMl/7bdIxaomtxuw68Yr2qCYktIpQO4urdq1+pmPWpwHvSB/uX+s18t4pI6Ttn6Vvs+
	EZh7r+LQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v1uPZ-000LnT-JT; Fri, 26 Sep 2025 00:26:01 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1v1uPX-00ENcu-H2; Fri, 26 Sep 2025 00:26:01 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail with esmtp (Exim 4.96)
	(envelope-from <mfo@igalia.com>)
	id 1v1uPW-00BoW8-32;
	Fri, 26 Sep 2025 00:25:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 25 Sep 2025 19:25:59 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka
 <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Brendan Jackman
 <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan
 <ziy@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
Subject: Re: [PATCH 1/3] mm/page_owner: add option 'print_handle' for
 'show_stacks'
In-Reply-To: <20250925202817.795114-1-joshua.hahnjy@gmail.com>
References: <20250925202817.795114-1-joshua.hahnjy@gmail.com>
Message-ID: <d05a76ffe2969b8542db961ef1f41a0e@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: NO, Score=-4.6, Tests=ALL_TRUSTED=-3,AWL=-2.376,BAYES_50=0.8,URIBL_DBL_BLOCKED_OPENDNS=0.001,URIBL_ZEN_BLOCKED_OPENDNS=0.001
X-Spam-Score: -45
X-Spam-Bar: ----

On 2025-09-25 17:28, Joshua Hahn wrote:
> On Wed, 24 Sep 2025 14:40:21 -0300 Mauricio Faria de Oliveira <mfo@igalia.com> wrote:
> 
>> For monitoring the memory usage per stack trace, it is more efficient to
>> use the handle number as unique identifier of a stack trace than to, for
>> example, read/hash all stack traces to uniquely identify them everytime.
>> 
>> The handle number is a unique identifier for stack traces in stackdepot.
>> 
>> This patch adds the option 'print_handle' to print the handle number of
>> stack traces in 'show_stacks'.
> 
>> @@ -887,6 +887,7 @@ static void *stack_next(struct seq_file *m, void *v, loff_t *ppos)
>>  }
>>  
>>  static unsigned long page_owner_pages_threshold;
>> +static bool page_owner_print_handle;
> 
> Hi Mauricio,
> 
> Quick nit -- If I understand your cover letter correctly, you want
> page_owner_print_handle to be false by default, should we initialize this
> to false?

Hey Joshua,

In this case, it is not needed, as static variables don't need to be
initialized to false/0. This is handled as an error in checkpatch.pl,
so it should not be added even for completeness.

Thanks for checking this.

-- 
Mauricio

