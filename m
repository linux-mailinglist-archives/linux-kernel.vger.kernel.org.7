Return-Path: <linux-kernel+bounces-855007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E9ABDFE99
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1264E356A23
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D3A2F4A00;
	Wed, 15 Oct 2025 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHzfevzY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9771E51EA
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760550065; cv=none; b=C9GeimR017yxv+THVht8C5zjeuHaYci0M+wcap0B10M79iyS5v/x/BRvRxjsqviljpQp7cP+ywQV4MJcY9FGdF8l6NA16tOS+YjYecZ+PtOivufXAmrOF9tXWqgIzhmPAGPYj8C5irqJlGPFEjtsWXiO9Wh/6JQ1ykCIAAjDBNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760550065; c=relaxed/simple;
	bh=NZCrGB9nHrm21Ve7bIne00nCHgmzUU9E7iFs0ZquwJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hG1IkNayIeFV79uTT+cK2AFnyL+k2m18NM8l4XttGIFHiXfS6ka5GHWCTPWL1NskWotQFbD8clJmwR+a53AHaSckeBxdNJMjm2OfTLqLnDv8rK3pNAnr26aBQ5livhZPPN3nnpK6qPnxxPQxx/uw+cAu6GT/1+3vYXdGB1k2MSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHzfevzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7ABC4CEF8;
	Wed, 15 Oct 2025 17:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760550064;
	bh=NZCrGB9nHrm21Ve7bIne00nCHgmzUU9E7iFs0ZquwJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XHzfevzYzGfsGBPvLd4z4XdUC4PLoK3g/GVMdhXLOBq8o4Zi+tUsdJIMc07hl9w6W
	 NqyRdZye2N68SjeHS0zcPlmfoCnTDjsBF2jB/Tdao2jRpEZv7IQbrAiNmXOg9BxriO
	 IIaVeZdCy/YS4zw98StQ6b9SL6pv8xll0I5jHuRgj13hfsbvf1JKyddl7zxvv3YeU+
	 VGv8IypkhNJmOEFgnlHH8QImVayM9XjtcDfAve9Vo64+2eLJczWtEXZyDZ4uoOGtBW
	 OasDjpcr7moN799RUmRNXVQAtBMLDLHnDVmQGHCZd7OBhzD4t6uC21gcacq0TPBamt
	 Nv7sXoK6NVyGQ==
From: SeongJae Park <sj@kernel.org>
To: wang lian <lianux.mm@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Rik van Riel <riel@redhat.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/khugepaged: fix comment for default scan sleep duration
Date: Wed, 15 Oct 2025 10:40:55 -0700
Message-ID: <20251015174055.70060-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015092957.37432-1-lianux.mm@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 15 Oct 2025 17:29:57 +0800 wang lian <lianux.mm@gmail.com> wrote:

> The comment for khugepaged_scan_sleep_millisecs incorrectly states
> the default scan period is 30 seconds. The actual default value in the
> code is 10000ms (10 seconds).
> 
> This patch corrects the comment to match the code, preventing potential
> confusion. The incorrect comment has existed since the feature was
> first introduced.
> 
> Fixes: ba76149f47d8 ("thp: khugepaged")
> 
> Signed-off-by: wang lian <lianux.mm@gmail.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

