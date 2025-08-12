Return-Path: <linux-kernel+bounces-763969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D0EB21C30
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E50D6233DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 04:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A8C2580CF;
	Tue, 12 Aug 2025 04:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VP10vn1P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6441F78E6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 04:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754973655; cv=none; b=WkcN3J/nj9cjclfFHadmaOQRLMiCFpIk20ydeOnSCfh0HJGpbjv9S5n+J6JP0hBhUG47ajxaE+551OCK5KA+mv60LIto+wL17NWRb4zEXTKhGm3yjWMhNJmO5NRoiPkNRB7fJgCLiMWY7uYWBO9/9Z2goQIDPobi5YJWkKaYGw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754973655; c=relaxed/simple;
	bh=SgaMmRStB2UhLZxqv6pMOrDE29SweSzVbjPPDpPgtmU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=A/4D3+Wlbg5HpbqwpFQgZ3T6Wm4wOZ1gmHKKr4CZMNurKvsMRjySeLg8BcJWe5njZxJxYf3EMWX4A2TS2gb5gVbuhiKG8yLgHlAOEoQ+c+xhggunbga1zN1rA31cSaYq07urAAHCU2S73wzOhy3moXEq+sIbV1vrGv3sgK6IOCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VP10vn1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C63C4CEF0;
	Tue, 12 Aug 2025 04:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1754973654;
	bh=SgaMmRStB2UhLZxqv6pMOrDE29SweSzVbjPPDpPgtmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VP10vn1P+011ti+EqhXQwSG+r/eDBHvTGGQb2lyZrJ45ld3lf3nd4OKR/XGiAXZ/6
	 IlokcWfYSlDDqH4BC3sxL9fzWy7b50tGSGfjf3oN1aMOiD809wR5h3wDZXIeOWb70a
	 GDomZFuifwsQdEbCxMskLCTV5OpzCEEmO424GgdY=
Date: Mon, 11 Aug 2025 21:40:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Qingshuang Fu <fffsqian@163.com>, hannes@cmpxchg.org, mhocko@kernel.org,
 zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Qingshuang Fu <fuqingshuang@kylinos.cn>,
 Yuanchu Xie <yuanchu@google.com>, Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH] Fix the data type inconsistency issue of min (tier,
 MAX_CR_TIERS-1) in read_ctrl_pos
Message-Id: <20250811214053.857168fd35e70e73dee1583d@linux-foundation.org>
In-Reply-To: <91d72c49-22df-43ed-aeeb-0b93a9da3bfa@redhat.com>
References: <20250808072106.153449-1-fffsqian@163.com>
	<91d72c49-22df-43ed-aeeb-0b93a9da3bfa@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 8 Aug 2025 09:35:19 +0200 David Hildenbrand <david@redhat.com> wrote:

> > 
> > Due to the fact that the tier data type in min (tier, MAX_CR_TIERS -1)
> > is int,but MAX_CR_TIERS is an unsigned type, directly using
> > the min function for comparison will result in an error:
> > from mm/vmscan.c:15:
> > mm/vmscan.c: In function ‘read_ctrl_pos’:
> > ./include/linux/build_bug.h:78:41: error: static assertion failed:
> > "min(tier, 4U - 1) signedness error, fix types or
> > consider umin() before min_t()"
> > And MAX_CR_TIERS is a macro definition defined as 4U,
> > so min_t can be used to convert it to int type before
> > performing the minimum value operation.
> > 
> 
> Please use empty lines to make the description easier to read. Also, I 
> think you can simplify this heavily.
> 
> We should add
> 
> Fixes: 37a260870f2c ("mm/mglru: rework type selection")

I'm not liking read_ctrl_pos() much.

Local variable `i' has the rottenest possible name.  In this case it is
a "tier", so let's call it that.  And its type should be unsigned.

But an incoming arg has that name.  Probably inappropriately.  I'm
suspecting that something like base_tier or start_tier would be more
descriptive.  Hard to tell, because read_ctrl_pos() forgot to get
documented.  And this arg should have unsigned type also.

(cc mglru maintainers, who have yet to reveal themselves in MAINTAINERS)

