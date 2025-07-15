Return-Path: <linux-kernel+bounces-730965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F709B04D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E8D3A75BF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F60A19004A;
	Tue, 15 Jul 2025 00:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2Gs1sOPt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5681553A3;
	Tue, 15 Jul 2025 00:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752539990; cv=none; b=f3t+P/Ow2cHXLE2UYe4YOGAF4EU33IDV8Nm4mIdLi1gRivfYdFQytAusRXzjNpZq0lFegNOgxtEynFoJMRRB4iwRsxQVHANHw0+l64QL5SzR0c2ETrrOZQVZL8SsMoQW82znRgEUIGXMeanmV3RfGy0JZX7gkN0F5GVUc+9CZw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752539990; c=relaxed/simple;
	bh=IJZy+XK9yF0uiw4FMahOZgA+W9v/jtm4MySwUALUrk0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gQQPHbJrb4uMwQioMYeJ2OKZ+Ee7ESOX2U5JBzZ6b2DRtxX7d7Uit9UoYgFd0ghe4cWR/S+VqIvX3fg59oORhENi38z6vCUd1/34EA16UXos/Sh50a3VblwVeR9xAbMvXnE3OUa3Yr6atwGB7B+tJdFh3bVJQpiZ+e0dazzBQmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2Gs1sOPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0C9C4CEED;
	Tue, 15 Jul 2025 00:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752539989;
	bh=IJZy+XK9yF0uiw4FMahOZgA+W9v/jtm4MySwUALUrk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2Gs1sOPtTRyBAHkcll6UCyduaHjwIdSEKd7WjVEtEspdtfFqjD7pBYYip7XzwHSah
	 DyZQxA8gYEcvvp/HzWXpE2T/ehdgxynFi7ULjvUEoJ6B2GKmwFxkhrYtsw8cxar/LC
	 oCg9EvETc3NOZ3WcXFpOon/y7caegWM/SXE9YgEQ=
Date: Mon, 14 Jul 2025 17:39:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com
Subject: Re: [PATCH v9 00/14] khugepaged: mTHP support
Message-Id: <20250714173948.7a4103c47ffec595ef5561f1@linux-foundation.org>
In-Reply-To: <20250714003207.113275-1-npache@redhat.com>
References: <20250714003207.113275-1-npache@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Jul 2025 18:31:53 -0600 Nico Pache <npache@redhat.com> wrote:

> The following series provides khugepaged with the capability to collapse
> anonymous memory regions to mTHPs.

Thanks.  I added this to mm.git's mm-new branch.  I suppressed the
usual emails to save 532 of them.

