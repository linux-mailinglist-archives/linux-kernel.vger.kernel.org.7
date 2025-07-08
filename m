Return-Path: <linux-kernel+bounces-721089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A656AFC48F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C463BD4FE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B706C29A9D2;
	Tue,  8 Jul 2025 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kTXlUkvJ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB280298CB5
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961031; cv=none; b=k11lAqxv5QQSyaAlcupObWOLDSsVMINwZHR1+E/otcZQXtDlQKKSpfKMKN0k5PJG9qxYgfc5Ya75ae9AIyk1VLOUSd34izglrw9qzT4b4cRcs2kQI/zGUCUhSSMdcW8buZ4S9p4Vs8cN8TzU0vGafX9C/ypuA08hU/qm5GX5+5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961031; c=relaxed/simple;
	bh=DTsBDkj96bXrh8JY1NhkIlAjz4FK+rJghyWRFdTIc7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEvVwMgMvqnGjWtmD2uPwNJsfRCJwLdtObHt1p6em1bVfrbQiektaZQUe+j3iOM08KVM0KyIx6Co0SNwP7TJzgydKZ3Rdp+0OcljTiz9EA/csR/uaps8qyBbNNad2491ji1anTfRVDdha0+02OAeTwyYGVJ3598iwd9FU03s7i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kTXlUkvJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DTsBDkj96bXrh8JY1NhkIlAjz4FK+rJghyWRFdTIc7o=; b=kTXlUkvJI91VWOo/DWUJL5udvE
	KVK5cfwxERjWtMniJ60JZgPmZrL4L5oEGVWKIpPTWQPNE5ArJ5jmTYQ7ZYnw8AB3q46n+sQ+5dfYw
	Q4SVys6YEcGcys8bNIZ0SBrDt93/ljXv58c64jASkydde/pGEWnDGkck1cIWArvaTDLVE5ZEeTbZK
	HLP3Hk4i3FpVTujgeFpHyxw+Aujbxr5XpXqzXspRo8hYvpN8EU8ebCpTIC0kqNZ+wi1zn4HSStqB+
	9LXKEb5O1ASsskO+5dvk7WVNfiPBklnI1JhJg9fMfGQmavq3P0cPjfmhIZZi++Iw/Gi7+gwRvKiKu
	BdICYGGQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ35t-0000000GT95-2BT8;
	Tue, 08 Jul 2025 07:50:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 148EF30065D; Tue, 08 Jul 2025 09:50:25 +0200 (CEST)
Date: Tue, 8 Jul 2025 09:50:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 0/3] futex: Use RCU-based per-CPU reference counting
Message-ID: <20250708075025.GF1613376@noisy.programming.kicks-ass.net>
References: <20250707143623.70325-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707143623.70325-1-bigeasy@linutronix.de>

On Mon, Jul 07, 2025 at 04:36:20PM +0200, Sebastian Andrzej Siewior wrote:
> Since it was not yet released, should we rip out the IMMUTABLE bits and
> just stick with GET/SET slots?

I suppose that makes sense. If someone ever comes up with another
use-case for it we can always add it back in.

