Return-Path: <linux-kernel+bounces-894509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAB8C4B32A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AE674E43D8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BECD347FCC;
	Tue, 11 Nov 2025 02:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KUnq6Eks"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D442BCF43
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762827823; cv=none; b=tqYt/mi/VQjFx2qBbQMM1QmfmLZSXl87yVf99wIlP6iC8pJlZx/PURino7L8gI+M0HmcKBDWk3SAQSE40lQoawTqyBRs9DoW/25wPrAtOuHe1y1qZINALkkSU+iu0I4MJirF4g/1AGAeult0wJw9/eFQGFXcFwvx/aag3FAfDlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762827823; c=relaxed/simple;
	bh=G/LpC2lkRvx8VNyHY6WizXs4laMIh6WBPFY4dGrctC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUFQHCAu476aNolxYC9e2w+qy+gljuV0GUCkeTcMC3QLHrlrJ/AOebPQffYoGuQMIKtBK1jJsNL6toUYk3WEunt74tWcsQfJeF4/MQhDQ+NiAiYm2G6eUhzjyhl5kyGK3xNoTRnDPJbCzYI1KdVdP8xb7FGUcx9F4OaN5DK/3TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KUnq6Eks; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <24969292-7543-456f-8b80-09c4521507e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762827809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2QEY03Zb79SqJtXbf2zF+i57eoPzcpd2R1ZoSjupFo=;
	b=KUnq6Eks5+xX4BoI5CcsTd5M8ayBvzEvJtBfpTPkht0rd2IUTHnBDtE0SJbtanxFBSLrwJ
	1kF+HodCXj9w701YF+pz1FWfIW9/YROvpD63GjFT3E+sw/148pxBfealvVfcozJ0SmQHjT
	svDRow3q91F7HoMTCc7SItb+Aeybl6c=
Date: Tue, 11 Nov 2025 10:23:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] memcg: cleanup the memcg stats interfaces
To: Harry Yoo <harry.yoo@oracle.com>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <aRKKfdN3B68wxFvN@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aRKKfdN3B68wxFvN@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 11/11/25 8:59 AM, Harry Yoo wrote:
> On Mon, Nov 10, 2025 at 03:20:04PM -0800, Shakeel Butt wrote:
>> The memcg stats are safe against irq (and nmi) context and thus does not
>> require disabling irqs. However for some stats which are also maintained
>> at node level, it is using irq unsafe interface and thus requiring the
>> users to still disables irqs or use interfaces which explicitly disables
>> irqs. Let's move memcg code to use irq safe node level stats function
>> which is already optimized for architectures with HAVE_CMPXCHG_LOCAL
>> (all major ones), so there will not be any performance penalty for its
>> usage.

Good job. Thanks!

> 
> Are you or Qi planning a follow-up that converts spin_lock_irq() to
> spin_lock() in places where they disabled IRQs was just to update vmstat?

Perhaps this change could be implemented together in [PATCH 1/4]?

Of course, it's also reasonable to make it a separate patch. If we
choose this method, I’m fine with either me or Shakeel doing it.

> 
> Qi's zombie memcg series will depends on that work I guess..

Yes, and there are other places that also need to be converted, such as
__folio_migrate_mapping().

Thanks,
Qi

> 


