Return-Path: <linux-kernel+bounces-777523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56A9B2DA7E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F3F7274D6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9685F2E3363;
	Wed, 20 Aug 2025 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ecXwQxiy"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CA12D7818
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755687816; cv=none; b=qf5PhptWYBNyWs2TsxXMjO2Y9thQs12WdaZJesTT9dzQ3rlNS+3VoRcUL/7NUtxvzQhVNT/iPtA58U1jDtr4u/l15I/vxA70KiHaDK9+qBw4g0WmVXaPc/UsKfbnJhmENZS7OGpHytqVvZb7WZ1WdtfpPAsh7G7acs9InR40z98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755687816; c=relaxed/simple;
	bh=0OTH9Xt3vhe5QIAIUKFu9N3Odja7l1+J/H50NiQ1S98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQZ9L2+kHvvECsBEA5VjheuFclp2FsxtHY4UnY8WHb2KGnoVDzjUoVAN3WKuPWGxWT/rBEkWrO57sh1RD6jjNTD/ITXjK3SDGajc17IkaOk70ZetZHzBmwmXUwcGF+ue+KQVRZ2Tbw1TWAZg+q3SJzzxi5/nMpUux2AaoaihL/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ecXwQxiy; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <df3b5c81-eb26-41ec-a27b-28c273a74859@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755687802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ahfDDflpdzQ8/uA6MgnjOXMXSU4HqqXX/CS0VshQj8Q=;
	b=ecXwQxiyrEPuNlT9g4k47z/DdQB5eI1OERolpmZUu5ph04yCWrGvSa+YRVVnfgvSRhOUCa
	SsPJaDUuhqnd/OIznPyx1+8DZ29YUUNt/tTb8ICrXa9CX8LhdW/2qXFbqUL9B7W42/AErs
	+pMmxGvnDzvqOZPTRB6ltrhhDn/RUHg=
Date: Wed, 20 Aug 2025 19:03:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] panic: Clean up message about deprecated 'panic_print'
 parameter
Content-Language: en-US
To: Petr Mladek <pmladek@suse.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Linux Memory Management List <linux-mm@kvack.org>,
 Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, paulmck@kernel.org, john.ogness@linutronix.de,
 kernel test robot <lkp@intel.com>, Feng Tang <feng.tang@linux.alibaba.com>
References: <aKRJKZHgcxyNF3y7@pathway.suse.cz>
 <202508200907.PsZ3geub-lkp@intel.com>
 <ae9bb2ea-c6e5-4a4b-ae25-aea1d6fe084d@linux.dev>
 <33a897b4-7d9a-4641-9c7a-07c19bb9cb6f@linux.dev>
 <7a34da58-874d-4271-9dbb-7991468d58ff@linux.dev>
 <aKWWcPOf9qPIoCe4@pathway.suse.cz> <aKWYELPjbhC7R8NO@pathway.suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <aKWYELPjbhC7R8NO@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/8/20 17:40, Petr Mladek wrote:
> Remove duplication of the message about deprecated 'panic_print'
> parameter.
> 
> Also make the wording more direct. Make it clear that the new
> parameters already exist and should be used instead.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Confirmed that it fixes the build error when CONFIG_SYSCTL is
disabled.

Tested-by: Lance Yang <lance.yang@linux.dev>

