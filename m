Return-Path: <linux-kernel+bounces-833007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE23BA0F90
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3C067AD414
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152C731327A;
	Thu, 25 Sep 2025 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elijahs.space header.i=@elijahs.space header.b="oNOqt+jD";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Oxmu7ziR"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF64330E83D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758823550; cv=none; b=BtqYPhDxIawjgGi6SMmwqgipcznrFGdq6aASOcKqIlVSbCynuBO2p8eppYcT67QcLBmCICKjpYiRzk8s+uOXUyI4xeQT11l1AUmPHpFihf+SePxzr5k3PVkRn/Tu+ShqahFyDanxDr1QZjKIbrQVOCSqpbbI4ggxultIgfMJmsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758823550; c=relaxed/simple;
	bh=CmcO6yPRehbZY8hICmv2YV+vpfW/5GRkbc8OrqfNrGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KXalAQuLLhC4Lr8KASNDDhRFISUPrUhz3EqdYlBz09X3+Bje27KnZJrWx/E2JB555GvlfFTMiXOZiBEsbhTuu0QHW365WnyWfBnkIjlJNSg4cT5E3km2XKR0qiCa5dQhPSXrhbf6vchJ/sTjQYkMNwswPeB7VmTpgESy3zFyUTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahs.space; spf=pass smtp.mailfrom=elijahs.space; dkim=pass (2048-bit key) header.d=elijahs.space header.i=@elijahs.space header.b=oNOqt+jD; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Oxmu7ziR; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahs.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elijahs.space
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=oNOqt+jDKuYSIGBKD9cxjBxpCm8NIvebbDc0jljBmPhPLpXhoVWi3OwBlOg5VRmW9wBVH3ILRyUOlINQACOZUMWJn8FJnf1jWzFMqltZmd1nkNViQMx2xJn/RdRYIBEoJW5A6BJywcPmhx0mGvqdskHLa8fzDUlexYPW3aA30GEqtuH5IkePPeA+6S/1i/9dOISVQTqPTSdGHKS4zkAqv/QimhRFbBXeWScP+CeOlGtgH5wfUaMRCTKvXkeBrLxBe6ho1wZrTyKJM0yZzy32ZOtL0aGj9YcAEdcmgiW/0VKCND4l5iKUrfFIBd7BESeeskipKXznd1e7SIkThoOSmA==; s=purelymail2; d=elijahs.space; v=1; bh=CmcO6yPRehbZY8hICmv2YV+vpfW/5GRkbc8OrqfNrGM=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=Oxmu7ziRJEoHPkUqFR58Lt01MwS2CZP7Dl5Ke8iLI9KNe7ZW3FlIeQt5EXY+4pXFFs62by46So16eziD4TnYRsMCxFtpJw+98RL/zok3YM2Djm8AtgSVf8DYk8tK6WXY2nuABl/ZtiiXVoFE0VmB/p2OVDOW6e4hyIz/oQjjl+mQT+7dbixp5E27aebnYvie7Li4SkMk9MaHv5yUJ6ptqpAQc1gOSKGvXTkAaY+Gb7uwawGexu56diAE81YCNwGRA7MgX12vjuNFf8yKqxqrWAra68d6WhO1cijcMBSi18DfG2J16ifajNiDeKpXFo1gL0JK1AHPRgqKXYaiJ9266A==; s=purelymail2; d=purelymail.com; v=1; bh=CmcO6yPRehbZY8hICmv2YV+vpfW/5GRkbc8OrqfNrGM=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 26912:4866:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1519375033;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 25 Sep 2025 18:05:20 +0000 (UTC)
Message-ID: <6e9c820f-070b-409e-ac25-af96b8b962c6@elijahs.space>
Date: Thu, 25 Sep 2025 11:05:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: slab: add basic slab module
To: Danilo Krummrich <dakr@kernel.org>
Cc: Elijah Wright <git@elijahs.space>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>,
 linux-mm@kvack.org
References: <20250924193643.4001-1-git@elijahs.space>
 <DD1SGLU4180C.361W5XLH76XNC@kernel.org>
 <73d7d53f-439b-44a9-98ca-0b1c8fbc1661@elijahs.space>
 <DD22FI7F2ZHT.32SL8PXFZZHV3@kernel.org>
Content-Language: en-US
From: Elijah <me@elijahs.space>
In-Reply-To: <DD22FI7F2ZHT.32SL8PXFZZHV3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/2025 10:43 AM, Danilo Krummrich wrote:

 > Anyways, I'd also like to hear some more opinions, especially 
regarding (4), as
 > mentioned.

ok I just looked it over. I think (4) isn't really viable, the cache 
pointer storage overhead is probably too much (in addition to some 
complex issues). I don't really like having a macro (so (3) basically) 
and I think there are issues with non-static caches, I don't know 
specifically though. obviously (1) doesn't work. (2) is exactly what I 
was thinking specifically for rbtree. IMO the only useful options are 
(2) and (3). I would say maybe implement (2) first and if you want 
macro-generated ZST allocators they can wrap whatever that Box ends up 
being.

 > not having dynamic dispatch for a
kmemcache backed Box is probably not that big of a deal though

I agree

