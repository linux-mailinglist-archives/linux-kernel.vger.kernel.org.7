Return-Path: <linux-kernel+bounces-856979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E12BE5937
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E45C6342BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFE92DF15A;
	Thu, 16 Oct 2025 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=airmail.cc header.i=@airmail.cc header.b="S8IP/NHr"
Received: from mail.cock.li (mail.cock.li [37.120.193.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1940121ADB9
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.193.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760650401; cv=none; b=HNWVTaOlZfjRWeqKKiyBISRLDyd+KnOzFk2UtH7aR3K1nzEcnRwDrdocznvRzkU+chjiqlipYbNqqaWBqsAm/GamIBSjd14w32yOrxTuZ64NNH47ymZMToABXQs6sk6FAL2i7WMY6u8p+rtN7Nzx+R8048raW0fMc6elvvNS3t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760650401; c=relaxed/simple;
	bh=so+mUFnhcsR7dLDPGz9OaXfZi9U5TCqhJNYFCwaZ2ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HOR4btYZme4c/g8MaGrPaR6ieTn4lD1JagI7o7BiJQwqVeeVeh1qyloK8t2xeUQpz4ESKPsKyHMotGPXZOXRaXAiInf6lk8EGx4VqmbXSsj3La3/BywAwNO7C+eP+p+7xty3b9dSIW4llzpT206RmKjH8JiLrNRSSHy3ybjitwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airmail.cc; spf=pass smtp.mailfrom=airmail.cc; dkim=pass (2048-bit key) header.d=airmail.cc header.i=@airmail.cc header.b=S8IP/NHr; arc=none smtp.client-ip=37.120.193.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airmail.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airmail.cc
Message-ID: <81fec1a5-1fac-4a50-871a-eaa0f2a2bcb3@airmail.cc>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=airmail.cc; s=mail;
	t=1760650390; bh=so+mUFnhcsR7dLDPGz9OaXfZi9U5TCqhJNYFCwaZ2ck=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S8IP/NHr8aif6T2lhxqZHHs6pTs13W3JNSN7puQXc4crDzsFBgkSj/Vm/oJOwINXA
	 A7hbsmPYcIFNH+2TvTGwg2TdkH3eT/Nd0YJSRY+haiZa+QJuINf/4QT2eXc/cUrLCx
	 LF65Qj+7Olo0t6q9UmJZFA03yUJhwd+NXXJnqQLa2WZvjstbKwrB/qfBhDPN14ks7p
	 +40dvcSGlIbUwIee4gkPAkexkp3o3aFKMYSEUH2HnuQbjsnKa+RN2IuTJrUJJA3W5I
	 C7sahMjvV3QzrdRHXZaQ7OZH8QLQuXBYSYAx2LZXC8uvsaAHhpC7r1PGZYwFZ2pzNo
	 T/WjTBK6ab51A==
Date: Thu, 16 Oct 2025 21:33:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] ksm: use range-walk function to jump over holes in
 scan_get_next_rmap_item
To: Andrew Morton <akpm@linux-foundation.org>,
 Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251016012236.4189-1-pedrodemargomes@gmail.com>
 <20251016140735.d7d4c282f0fbf22954a4b4ee@linux-foundation.org>
From: craftfever <craftfever@airmail.cc>
In-Reply-To: <20251016140735.d7d4c282f0fbf22954a4b4ee@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Andrew Morton wrote:
> On Wed, 15 Oct 2025 22:22:36 -0300 Pedro Demarchi Gomes <pedrodemargomes@gmail.com> wrote:
> 
>> Currently, scan_get_next_rmap_item() walks every page address in a VMA
>> to locate mergeable pages. This becomes highly inefficient when scanning
>> large virtual memory areas that contain mostly unmapped regions.
>>
>> This patch replaces the per-address lookup with a range walk using
>> walk_page_range(). The range walker allows KSM to skip over entire
>> unmapped holes in a VMA, avoiding unnecessary lookups.
>> This problem was previously discussed in [1].
>>
>> ...
>>
>> Reported-by: craftfever <craftfever@airmail.cc>
>> Closes: https://lkml.kernel.org/r/020cf8de6e773bb78ba7614ef250129f11a63781@murena.io
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> 
> Is Fixes: b1d3e9bbccb4 ("mm/ksm: convert scan_get_next_rmap_item() from
> follow_page() to folio_walk") appropriate?
> 
> The problem which is being addressed seems pretty serious.  What do
> people think about proposing a -stable backport of this fix?
> 
> It would be better if this changelog were to describe the user-visible
> effects of the problem.  A copy-n-paste from
> https://bugzilla.kernel.org/show_bug.cgi?id=220599 would suffice.

I must admit, that with this particular fix with scanning only mapped 
pages with actual data, effectiveness of KSM even better according to 
stats, and CPU consumption even smaller tan was in 6.12-6.15 kernels, so 
I think it doesn't necessary to revert that 6.12 folio_walk commit, 
applying to master tree and backporting this topic fix into stable 
branch is sufficient.

