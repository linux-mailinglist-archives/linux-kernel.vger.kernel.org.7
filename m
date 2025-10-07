Return-Path: <linux-kernel+bounces-844824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1629BC2DB6
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 00:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FD319A3222
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 22:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649D4246BA8;
	Tue,  7 Oct 2025 22:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dKlpeR4t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BB31F63FF;
	Tue,  7 Oct 2025 22:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759875637; cv=none; b=PZr05RN4+aWF+XScaprbjVNQyZNoCmcVQESVTe5xpOHGlk9YfdSlF2vlfC0B8egP0TgNfgQZLTrOtS2uhHNcs1XSsfnzR7+vBVarjWoOqwPYXx8opXUbdefDmMKRMjn6Bw+LonDjKqlF9OYQB1ZRD+QrmtQUQkHhBjcXVHWhvSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759875637; c=relaxed/simple;
	bh=ejqxn+rROfDejbjt7kGS4MM5j0UztDEA1dWFkPHb7eU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mBTp7oOz/tbqLCATOU89A5iMywyilQ4oGvRyTsPgu+WANy7VMbp/8gv0H6qmjaFcQMcBuSUPUCGlmagakCxtBIaZMSXvTJJbEIAinRvdUKYAsyEa0Vay/7JU5OQ3WQhagNI4BLTrMbj871LVP0IWPG4z6CPjGBEmKKa0SJw1JCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dKlpeR4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19A5C4CEF1;
	Tue,  7 Oct 2025 22:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1759875637;
	bh=ejqxn+rROfDejbjt7kGS4MM5j0UztDEA1dWFkPHb7eU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dKlpeR4ttNe0GHtMivevZDFXOzfWLOpqNCrqVdWGYwAs2uNWQ0+g4RGP7XPdg7z6T
	 r+DnAqFDbPLKpCLvA45VdLLiFfpPLvcgTMOHbyRSf2023g9+u6UmyaVEtgbO+SuPfb
	 iz2ejQlf0NHo+U0nuXs9ouZ/vb5fxYGZ8C+y5dbM=
Date: Tue, 7 Oct 2025 15:20:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song
 <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He
 <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li
 <chrisl@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, David
 Hildenbrand <david@redhat.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Ying Huang <ying.huang@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/4] mm, swap: misc cleanup and bugfix
Message-Id: <20251007152036.cfbd572d706c40ed79d75642@linux-foundation.org>
In-Reply-To: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 07 Oct 2025 04:02:32 +0800 Kairui Song <ryncsn@gmail.com> wrote:

> A few cleanups and a bugfix that are either suitable after the swap
> table phase I or found during code review.
> 
> Patch 1 is a bugfix and needs to be included in the stable branch,
> the rest have no behavior change.

fyi, the presentation of the series suggests that [1/4] is not a hotfix
- that it won't hit mainline (and then -stable) until after 6.19-rc1.

Which sounds OK given this:

> So far, no issues have been observed or reported with typical SSD setups
> under months of high pressure. This issue was found during my code
> review. But by hacking the kernel a bit: adding a mdelay(100) in the
> async discard path, this issue will be observable with WARNING triggered
> by the wrong GFP and cond_resched in the bio layer.


