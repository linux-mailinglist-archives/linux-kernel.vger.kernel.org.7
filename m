Return-Path: <linux-kernel+bounces-883417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EED75C2D629
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6660B18877C6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9599319605;
	Mon,  3 Nov 2025 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4+lnzu5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234F33191B2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189616; cv=none; b=qpfvjZOpjVlNrI1mqTSAriZt4VuFK3RLG/1QmsQRiKQUYQmZltiEJOiJ+bPNl9tQgOTZM5500hRdOKrStvXG8PluI4hwZNrH7hEl/VDOpN6LaUayFga9Yimk05CE0ARt/7X1yk8zd4V/x6Y0XWV9fFlbuvOR8iVy/O4Aeqg4opE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189616; c=relaxed/simple;
	bh=bxGv/8/30qv9u6TosV/pnkBKN6DycBFjoEKn0mWZGvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuV8c4RDAmokaDmlZ/OB8w2GUX2X5oz2ak4DtalwZNqnjQnk3Ype4eQNn51faRb5rttrzwz83W2xcwboELxXjqhMKiDJaDKLdgYjkGEZqr6rmpVmLXrNtd6SC6HIr9Idqu60pJYH4GwpoCXqZAgdaZUSWi52xeKwZ6TaqfL5VW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4+lnzu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C467FC4CEE7;
	Mon,  3 Nov 2025 17:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762189615;
	bh=bxGv/8/30qv9u6TosV/pnkBKN6DycBFjoEKn0mWZGvQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i4+lnzu5Ya5JTr+gMtuKgI3KcEKOs8Zg5LFHRxkNFe97CmgErRepFnpthZ7VPHPZK
	 2SYqnfKc5MZBmgOzcSKVWGQHokUSYKt7/GttWha6O54fMv9HveEaCc782JWxWayoxS
	 Ri5MLs9gK+capqsorK+qPGJW98lyLWbXJ4Ea9l7AQqxiOqIZwr6WuzGVT31LwFCVWK
	 IEIl0g7jFG7MH2Tiv/q/5ZQv3k7bGPTtvlUpwu1e9vdKycW2Q6nLaFLnIu6QblX8tk
	 +zuFLal8spd0/hcauQRwAMS25orwvc6FgRcQVo43Z4IgYqYprZ7kAvVFuh1cq5jO7f
	 DzMpRTJr2vioQ==
Message-ID: <b4598fbe-8c4d-4a92-9e8e-836feeba2f15@kernel.org>
Date: Mon, 3 Nov 2025 18:06:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ksm: replace function unmerge_ksm_pages with
 break_ksm
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251031174625.127417-1-pedrodemargomes@gmail.com>
 <20251031174625.127417-4-pedrodemargomes@gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251031174625.127417-4-pedrodemargomes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.10.25 18:46, Pedro Demarchi Gomes wrote:
> Function unmerge_ksm_pages() is unnecessary since now break_ksm() walks
> an address range. So replace it with break_ksm().
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> ---

Thanks!

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

