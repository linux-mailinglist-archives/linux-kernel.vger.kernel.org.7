Return-Path: <linux-kernel+bounces-893554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E4BC47D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3A8423287
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941E1275AFF;
	Mon, 10 Nov 2025 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkDGoHUt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08742749ED
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789736; cv=none; b=Vz8rtcug4ZddA6MxlhJStRIjEcv3pJ4X7u0K/Y4P36ldq6ufgSAk4QShulgWLBi/jW3vN2yeygLj3HLfs7X+irs/i6lvnyknXVaxdYHz+LI9IevHKDGa8w65Fsh9rHLcBmUhz7t3i9L85nlmnp0lrT7q1LRTQou/F9a8puwFqhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789736; c=relaxed/simple;
	bh=7usNNwK1oc17KCZRQqTRb/jOrzz/mLzKHFv/CibFkeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y//jphaWrNFBUAeGQOUVnDgpDdnSmsmCNwahStrenCUEeK3D/nP8dEb/OSfFhkoCT9TBdHryVhHOkHj5WgU4S6ZzyYZnHgsvMsOeEzTNMUL7wRlFFFZpuc6CP7Uo5ndvYuh96JoXBD7i5ujwplN0gTnkc9zO9wEXaE3T/J5vkrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkDGoHUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13125C4CEF5;
	Mon, 10 Nov 2025 15:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762789735;
	bh=7usNNwK1oc17KCZRQqTRb/jOrzz/mLzKHFv/CibFkeo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LkDGoHUtlL8QYpGw4ssnW9I1tDmONc4GV/GO/tQBHXeFFR5yPpVf/tXZxGcf3mzH4
	 loJlkqn3ALuwlm3wFCbm2t7gFrDDJsflbmdJuICFfvXfphGisNrEYHOmy2xdHpEy7t
	 vI2WK3v9FsDIvMDCpvjbORMZTOwQjU0y6aBdWPlKagw2cMPNtMeKdjrarMqqlGWxdu
	 Eg6e6m8AWcs5/lIzTp8vTBKvNXWwwD4okmCMe/mKu91/wECnkLCk6VFbMLrA7Vsixd
	 v4TA8fDYJoPg+THe6BniVVBWlUBB93nnDgMstLqijd672t2AXdSJQDR9W+Y5EZyBY5
	 C3qs9WcXC+1Kg==
Message-ID: <f7a69885-7bf6-456b-81fe-3c6a5a29b470@kernel.org>
Date: Mon, 10 Nov 2025 16:48:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: rename walk_page_range_mm()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1762686301.git.lorenzo.stoakes@oracle.com>
 <2e48c7ffbd2ecec8ac189569636173fb44ed3631.1762686301.git.lorenzo.stoakes@oracle.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <2e48c7ffbd2ecec8ac189569636173fb44ed3631.1762686301.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.11.25 12:16, Lorenzo Stoakes wrote:
> Make it clear we're referencing an unsafe variant of this function
> explicitly.
> 
> This is laying the foundation for exposing more such functions and
> maintaining a consistent naming scheme.

IIUC, the "unsafe" variants only bypass the check_ops_valid() check, 
correct?

Staring at the code, I wonder if we should then rename check_ops_valid() 
to something like "are_ops_safe()" [or something similar along the lines 
of safe vs. unsafe]

Because now we will have valid vs. unsafe which is a bit confusing, at 
least for me.

-- 
Cheers

David

