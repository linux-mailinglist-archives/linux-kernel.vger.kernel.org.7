Return-Path: <linux-kernel+bounces-889992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DE0C3F05A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12AB6188CA32
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFD8284B37;
	Fri,  7 Nov 2025 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7FeyFDt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6812B26529A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762505280; cv=none; b=AqEDt5sSLIyJEwnJf9+8ywril86lC1NYx+z/DdrL+BLfFN/C3lNwWd6bjP+QDcw/lPCayDWG7zzY5WQWuJHytZPJoYGXLsRJVQTVGZMSo+Uw2l/YWYjoQ2MjhA+yGY/cPSNaKBweC4mmLRyCLqSOwVasGT4TbXF9VsKgW8e1TDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762505280; c=relaxed/simple;
	bh=r5HfqcJlbIcSqDVbrM4DbrQWFQDT9pFIOpMky7mOVII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rU79eWBAxGvjkHoE0eIRykRCpQWE12in4pjUCqFjw9+jmMyclKrPI+Ieghs9NmWSqkTnvnbVa2zE3VWLVn/WoKM4fmTZE272vKP9k9ZMy/8H5ZNM3qazPtEvi60y7jiR2F56DjHffjoKIQoQpCpPL2pefFir0aFj9j51URLExLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7FeyFDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18698C19422;
	Fri,  7 Nov 2025 08:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762505280;
	bh=r5HfqcJlbIcSqDVbrM4DbrQWFQDT9pFIOpMky7mOVII=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M7FeyFDtOYIKxkl3DFN8eMztM7r6/7ToOwzInZaWT6sjSOxLE6B9YWMpy9twj/P30
	 JrB79AsLVo1z52Xf/PKrfZuIFChuXSA1Lops5gNQg/mc4nMC70/htUOHfElaawAlsr
	 vMM0FX/l21ZJC65nhws7EJrWz8Mxph/4Five8Q15l+kqD0MoXOTmh6FRy51G6B/lJP
	 pmpKYaUHC3u6YNW6jbgZ9MTCJ8xnIZTN4iSzHGm6FnW3ke2oH3McgqhFge6pjEnuFU
	 Q9uPo7mrCh47AfX4xFZ+whyNrsuQP8TmS7NCqkXyH5vg+0KopWFi6DLCOpwdcgnwUl
	 y3bG78yWb4Mwg==
Message-ID: <d5806728-1f40-4e6d-b832-0076de3ae699@kernel.org>
Date: Fri, 7 Nov 2025 09:47:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/7] mm: introduce clear_pages() and clear_user_pages()
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20251027202109.678022-1-ankur.a.arora@oracle.com>
 <20251027202109.678022-3-ankur.a.arora@oracle.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251027202109.678022-3-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.10.25 21:21, Ankur Arora wrote:
> Introduce clear_pages(), to be overridden by architectures that
> support more efficient clearing of consecutive pages.
> 
> Also introduce clear_user_pages(), however, we will not expect
> this function to be overridden anytime soon.
> 
> We have to place the clear_user_pages() variant that uses
> clear_user_page() into mm/util.c for now to work around
> macro magic on sparc and m68k.
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

