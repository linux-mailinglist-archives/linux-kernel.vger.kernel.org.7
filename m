Return-Path: <linux-kernel+bounces-806911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E61B49D72
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E3147AE438
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5552F7AC2;
	Mon,  8 Sep 2025 23:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KIA54G99"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B291B87F2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 23:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757373741; cv=none; b=Aly/m1IjIxFH75bpTeLYNWm2VTBDTsLlDV6VYWynguTtmd6K73SeX9TCl7JtqqI80KHqWDtHawVNE3607Rto9NmxW3aS+3JSZTNOiA7qe8JsOi+nNqyQO/C3oA2xm+OooUeDS6rGq0gAhtCGj7ZIh3WTLGLKOYTu4eDBsB1jg+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757373741; c=relaxed/simple;
	bh=PGOjmTeDDIr1B4cY4+ySaxe5KyHC4GKYSebwfsJjMn4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QIRg0gvBrR+3yQGG+1Gy84/Hnz+3Eef/bi9xVLy2ac1GWHiCmKZVW742agpPqqbStst/DGdwCsyW1VRPZyjY3jrCme3BdomLCwnsZAyBxvdqnbU2HbldQZKpoHT8wgWS6MI8kVfrRhcIaJhwou1NJulCFqeS3YYKJ1FbRpSyJMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KIA54G99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55235C4CEF1;
	Mon,  8 Sep 2025 23:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757373741;
	bh=PGOjmTeDDIr1B4cY4+ySaxe5KyHC4GKYSebwfsJjMn4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KIA54G99aZ/SbV3nV5TTXVGVXCoktdxmU0ZGeJa/ej2vW3PYBVwvR2YM/am6bsXMO
	 3ErRqUje2RCK6wmQI9vJksf43BD1LRY/Anurm4T+e2IHvHKoQ28dL6m5WrCC8hsL1L
	 heIcW5pfsue1NRscA1YgEE/fXZF4FF4o9IT/5/G8=
Date: Mon, 8 Sep 2025 16:22:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vernon Yang <vernon2gm@gmail.com>
Cc: hughd@google.com, baolin.wang@linux.alibaba.com, da.gomez@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Vernon Yang
 <yanglincheng@kylinos.cn>
Subject: Re: [PATCH] mm: shmem: fix too little space for tmpfs only fallback
 4KB
Message-Id: <20250908162220.480d7014cc6c6ad2e14748c5@linux-foundation.org>
In-Reply-To: <20250908123128.900254-1-vernon2gm@gmail.com>
References: <20250908123128.900254-1-vernon2gm@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Sep 2025 20:31:28 +0800 Vernon Yang <vernon2gm@gmail.com> wrote:

> From: Vernon Yang <yanglincheng@kylinos.cn>
> 
> When the system memory is sufficient, allocating memory is always
> successful, but when tmpfs size is low (e.g. 1MB), it falls back
> directly from 2MB to 4KB, and other small granularity (8KB ~ 1024KB)
> will not be tried.
> 
> Therefore add check whether the remaining space of tmpfs is sufficient
> for allocation. If there is too little space left, try smaller large
> folio.

Thanks.

What are the effects of this change?  I'm assuming it's an
*improvement*, rather than a fix for some misbehavior?


