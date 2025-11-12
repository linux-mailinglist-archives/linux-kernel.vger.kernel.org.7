Return-Path: <linux-kernel+bounces-897763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AF4C53C4C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC3125085F2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0A933B6D8;
	Wed, 12 Nov 2025 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wh0PCCqE"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F032BF00B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965445; cv=none; b=XC6XyhMNkZH9+F9ITpx98zXiug/2HBxTyfJluQ6S8eVUqUhqaFbpX07jlSP43rxrL39o/epb6oRYu2RXD4ZuV3jVirSk80SBWijiszALuw4j/gG4dqmoBAoNUFjLTKkcUsbsZJaNRryz/1fBxX1FbZmLuR5ityBhlO+u3iZThe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965445; c=relaxed/simple;
	bh=1DWc0mFPWuYlwrmYN4N/2p58Cj8JujiPs8naD1Ong/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GwRpLxwIdRadKr2ATuomEj94yQIiNg7lqc0sTkN3HwJSRr5Cw7y6ql//vYisOXmuwlHBof6hUjksU0QKl87iwKPZFdoeuuCwgZiEPowPnu2zDa/3Us6OFmv8nsXSPuQgXOXlvXLpA6Rvmk4k5hg6VirGYZh8n9qVAvQlfCavBCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wh0PCCqE; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762965441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IuZkk1ecQ1y2YiIg61ZBzcctWSlR8+0B252L7V3ihsM=;
	b=Wh0PCCqE3a6g2qnRUMXZ1g3BIMxO6mZ6y7v4sB2g+UnJbZBfkGUQ7BmVF9gblYKJEFO0LK
	dkimfm3eG5fmJkuCNVSDL6U/VcZGlbifE4w5cwBp7d9r1g3Oa8628++g3z/VT9AgZtP6Hv
	ZuhetIod+UxQ7KziDDdDSBYYdCb7ncg=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: thehajime@gmail.com
Cc: Liam.Howlett@oracle.com,
	hch@infradead.org,
	johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	ricarkol@google.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH v13 00/13] nommu UML
Date: Thu, 13 Nov 2025 00:36:51 +0800
Message-Id: <20251112163651.3689244-1-tiwei.bie@linux.dev>
In-Reply-To: <m2bjl7y6mv.wl-thehajime@gmail.com>
References: <m2bjl7y6mv.wl-thehajime@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Wed, 12 Nov 2025 17:52:56 +0900, Hajime Tazaki wrote:
[...]
> > However, I'm not yet convinced that all of the complexities presented in
> > this patchset (such as completely separate seccomp implementation) are
> > actually necessary in support of _just_ the second bullet. These seem to
> > me like design choices necessary to support the _first_ bullet [1].
> 
> separate seccomp implementation is indeed needed due to the design
> choice we made, to use a single process to host a (um) userspace.  I
> think there is no reason to unify the seccomp part because the
> signal handlers and filter installation do the different jobs.
> 
> I don't see why you see this as a _complexity_, as functionally both
> seccomp handling don't interfere each other.  we have prepared
> separate sub-directories for nommu to avoid unnecessary if/else
> clauses in .c/.h files.

I have the same concern about the complexities introduced by this
patch set. The new processing paths it introduces (such as the
separate handling for FP/SSE/AVX, FS, signal, syscall, ...) add a
lot of unnecessary complexities. I think Johannes's suggestion is
a great idea.

> we haven't seen any functional regressions
> since this RFC version (which was 6.12 kernel).

I took a quick look at the code. It appears that patch 02/13 will
break the mmu build when UML_TIME_TRAVEL_SUPPORT is enabled.

Regards,
Tiwei

