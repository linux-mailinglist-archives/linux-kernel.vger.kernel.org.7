Return-Path: <linux-kernel+bounces-813005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACF4B53F87
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48F2A1CC1F98
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 00:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB6A1DA55;
	Fri, 12 Sep 2025 00:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LYYY9GLX"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98CE2DC775
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 00:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757637925; cv=none; b=C9/TtG7oPAU/17z99yDD0oXq0PY0R9oKZTH3+NlDN7H59jAwdPq9CMFn4jOoOYOIgaBBWV/TIxoq5vIwsLtvHOwd/4vO135/KHu5D1XRn5FIwUMMaCN1BFmVuljlPmn1mCs9T1SJy3uJb5/pMg0+DX+gER/xmT0AYi9D79cDnyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757637925; c=relaxed/simple;
	bh=N2KvqxgWUs/wg+MafUANSGwGiGCJSSdGkR7hHBbj0pU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q8Ue8SBtmJexdoHs2Fz+61tUyw8Y4Dnc06lzeDsPyUTM3WjZyXyeV0dcc6M2cfa0oN3J58ynHLtyI0FRO+4WAYfyD7acEpZuMIMi3bMqOz0SbBTWUR8fqJawZp2KmlysD8vH+61vK3zVnz8/JdydfU7j5c272sdF5xet34TU6Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LYYY9GLX; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757637920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jq5/1lU7TdxI8VO7geJyzqTN6wUTtUvTydZaERif2Xw=;
	b=LYYY9GLX5ATmIJlxmSEyP+zTgQk56leFjskNTLkoZ9ssAQlPQzEx7om2kO5FcIwwEFGk8s
	cKoXUz9odmJp9Zr2ZXyJjY4QJW1S0BP/k5CRRVCFr6thWG66t7Q6T7f+9LjfYQqcK5MzGb
	Qh3bo77aptae6xXLK1nT7pG7DiPLwEw=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: johannes@sipsolutions.net
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH v2 08/10] um: Add initial SMP support
Date: Fri, 12 Sep 2025 08:45:01 +0800
Message-Id: <20250912004501.2565976-1-tiwei.bie@linux.dev>
In-Reply-To: <03cb4661a6135a641c5a3779f2cb424356b8e345.camel@sipsolutions.net>
References: <03cb4661a6135a641c5a3779f2cb424356b8e345.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Thu, 11 Sep 2025 11:32:56 +0200, Johannes Berg wrote:
> On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > 
> > Add initial symmetric multi-processing (SMP) support to UML. With
> > this support enabled, users can tell UML to start multiple virtual
> > processors, each represented as a separate host thread.
> > 
> > In UML, kthreads and normal threads (when running in kernel mode)
> > can be scheduled and executed simultaneously on different virtual
> > processors. However, the userspace code of normal threads still
> > runs within their respective single-threaded stubs.
> > 
> > That is, SMP support is currently available both within the kernel
> > and across different processes, but still remains limited within
> > threads of the same process in userspace.
> 
> Another thing that isn't covered is anything relating to interrupt
> affinity, I guess? Is that automatically not working, or will it look
> like you can change things but that not do anything?
> 
> I don't think it's important now (though eventually I would actually
> like to have it for our simulations), but was just thinking about it.

Currently, our irq_chips haven't implemented the irq_set_affinity
method, so setting IRQ affinity is not supported at the moment, e.g.,
attempting to set affinity through /proc/irq/IRQ#/smp_affinity will
fail with EPERM. And yeah, we should support it eventually. :)

Regards,
Tiwei

