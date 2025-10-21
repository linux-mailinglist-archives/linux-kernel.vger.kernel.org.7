Return-Path: <linux-kernel+bounces-862071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61804BF45C6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 04:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212F318C55B4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 02:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B4025FA13;
	Tue, 21 Oct 2025 02:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J519sp9y"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91C34AEE2
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761012919; cv=none; b=RbTLZJcWx3sfp097zAGkT4My/GlLqqZ+mYNAsvGj8JqBexcpUv2qZ7mGjzH+Lc3jWpKySJpB9bJ2C+2gTOJwGeoNhKPyCRh4a3KWFk+P5Zr6zb7D71Iqqsyb5q2LWFqr/qfpp/0eXjG4Ab2+evc2YtuUIfszR9gKRO8CVmmHH0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761012919; c=relaxed/simple;
	bh=wj+DGGwa/NrHWDPg5cdVYUxXzQWxpy48f6JbtLi60d4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c3lfs2Ny0o34p93JGtWAebv57kJFZW9Np8c5VbAiZgeXoOVN/hhCVaF4WQyWM/TTaULdewNa3hM2eZuN8hx/KXk5MSkS7U21NUk1bM0t7cBKJUzFE3mVqJdiVGvwWXA4GtehzD4o+qO5cIwe8/Wk0PX9Z8cmpshKEyr3JimWyjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J519sp9y; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d36c0e8d-386b-444c-bd6c-ec9439778e96@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761012914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kfvaitQHko0T9y9BKdTgNOOZmOpTbCeZVw+TE9cO9IY=;
	b=J519sp9y27nGBlbS5dV5jMsy5LarXYr1fJvPmPLe/no8dffuqDk4nwH8BFKwxctENR/wDS
	7DaMC5qjFvC1FrYpKHjv2uYEcwmRBBPcOF19kP7j5GyJL+UPqdlDkNKbzFP/vfSw/xpX7A
	GbuMtZai9KpNzvb1dWs62rdHlif1DlE=
Date: Tue, 21 Oct 2025 10:14:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new 1/1] mm/khugepaged: Factor out common logic in
 [scan,alloc]_sleep_millisecs_store()
To: Leon Hwang <leon.hwang@linux.dev>
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, david@redhat.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com
References: <20251020115350.8175-1-leon.hwang@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251020115350.8175-1-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/20 19:53, Leon Hwang wrote:
> Both scan_sleep_millisecs_store() and alloc_sleep_millisecs_store()
> perform the same operations: parse the input value, update their
> respective sleep interval, reset khugepaged_sleep_expire, and wake up
> the khugepaged thread.
> 
> Factor out this duplicated logic into a helper function
> __sleep_millisecs_store(), and simplify both store functions.

Thanks, less is more ;)

> 
> No functional change intended.
> 
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---

After tweaking as Lorenzo suggested, LGTM.

Reviewed-by: Lance Yang <lance.yang@linux.dev>

