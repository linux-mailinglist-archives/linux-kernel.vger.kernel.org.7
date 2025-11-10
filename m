Return-Path: <linux-kernel+bounces-893887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BED9CC48955
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6FC64F370A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A210132D7E0;
	Mon, 10 Nov 2025 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lb8b3mZ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052CF3195EB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799284; cv=none; b=LUGv0CfgnrMSDyGZONIDYHwAr+XNL9xo6Zyg+2gTbU7iBVq7HacD/xfqw1KZVH3AJay2ebVqr0dOvEd/SIcJhBIIFGK8DrQH8JJHVS6d0C8IPPd050DaDWO5IeI1a7RVBoVSRyl56FDX8O1rMnZMyJp6kG1WKKK0QUEEaAcnq5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799284; c=relaxed/simple;
	bh=9Za0s+jRH4S1Z2bulO5fzs+8YHVqt4OhMTO0L/jbjMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pw+FFAFdMVsW1t8/I3nzbeHEMA8EQpiQ99XGjcwehG+3oFpeaLcKXWuKNId8F769QJbCsdyFjqgRJo8EQo2kQbWy2RfTKKCIxBVwif+BmA3BDbLAFz/x8zlwr/B9STVa5jKsP2boHV0ptgEDjydXw81LjkfiBlZslAwIhG4Bvw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lb8b3mZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C2AC113D0;
	Mon, 10 Nov 2025 18:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762799283;
	bh=9Za0s+jRH4S1Z2bulO5fzs+8YHVqt4OhMTO0L/jbjMk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Lb8b3mZ0SnK/L1P86vnjLalv72ylv0BWzsMxAb3TmQ8ePx/x48jOCMHYWPPtlb3vg
	 z9a2wH0eZprNpxtivM0IEAAgzZNLGTO0np+h+sMlv8A1g1HjBSrdFEvhv/PAEy6j0R
	 Bly+Pqn+iRKpcLGSHqimhrvciigzyyr1ZdMxl4urqDzBdAdj68w4OwfR6EZvDIUQ9e
	 iYDMgfjc+K3/5KLr+wXJLmEJb48d2Jui0NG1Z9ggQkzx+8y2YdoQg7w8MMhpQE7ocw
	 lnjkriSQ+T0ZzKDZQ2Qwc1qhvIDERKl1t43X5XzG6F+CEs2fT6xvXShAqCyqSLbghx
	 a6WfrOCzE8oSQ==
Message-ID: <669b8132-3dae-4f0d-a3e0-7c73a50205a8@kernel.org>
Date: Mon, 10 Nov 2025 19:27:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: rename walk_page_range_mm()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1762795245.git.lorenzo.stoakes@oracle.com>
 <c684d91464a438d6e31172c9450416a373f10649.1762795245.git.lorenzo.stoakes@oracle.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <c684d91464a438d6e31172c9450416a373f10649.1762795245.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.11.25 18:22, Lorenzo Stoakes wrote:
> Make it clear we're referencing an unsafe variant of this function
> explicitly.
> 
> This is laying the foundation for exposing more such functions and
> maintaining a consistent naming scheme.
> 
> As a part of this change, rename check_ops_valid() to check_ops_safe() for
> consistency.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

