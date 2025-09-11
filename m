Return-Path: <linux-kernel+bounces-811333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E78A4B52794
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A803D3B3E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F3F22836C;
	Thu, 11 Sep 2025 04:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vtbCSJJt"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757574A32
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757564982; cv=none; b=DpqZBW3e+YXjHqslrfaNog1HORn1BpAtNdqiGv+axHkc+BcNg3lg3K7DzAVGJqG6X031q6QRihLxyxeYdy1dkMfkZ3Mf5dHBcLw7UX7bzQotrU5DnDJzLtKaTmklR/NQ/6fVpQVxRuyEVtnNB6ETd8+s7oA1EH+0oh7uAx8fLrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757564982; c=relaxed/simple;
	bh=zZAsuToX7mi+Y4Kpn99V7tAmHppmkAeDgMApjsK8WPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uJSgSaQE52oBJ02iCRFlFliNw34aosz/7xRL7/WE4CuJx7bpNif2PgqrkRQr/3EYQKNL7YfCZ+znqvKz8d0NMtc8e8ouSqLJN/Bse8kou06HuTLHYc7FNM0DbM1BgGIJFad3oOUGlyOH6NsHzcpjI/QX+aREjKrer9GpLFUQQ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vtbCSJJt; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757564976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pqdhY7qUs1EroFfnj/5dwIqEXqJOyy/7eKGa3EKk0TQ=;
	b=vtbCSJJt2CpJX67adu0e89qQmbWQzvYrLc2ZKQ1YC4BOuEY3znuhN2cW9Qni058020Shj9
	3aj1k/Z4fhAY6wSg6+RYHyABqLVXnFHm7mH8ZcmHkFYZNpcfDk6X8uZRyEfrBAvZhiBKuE
	yGtwx3DQLt1VAQo7QS1Z6bGj7K/exjI=
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
Subject: Re: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
Date: Thu, 11 Sep 2025 12:29:10 +0800
Message-Id: <20250911042910.2834585-1-tiwei.bie@linux.dev>
In-Reply-To: <d28c9690341715fff04fbc01fd80723a30195f23.camel@sipsolutions.net>
References: <d28c9690341715fff04fbc01fd80723a30195f23.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Wed, 10 Sep 2025 13:59:02 +0200, Johannes Berg wrote:
> On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > 
> > We are going to support SMP in UML, so we can not hard code
> > the CPU and NUMA node in __vdso_getcpu() anymore.
> 
> Correct. But does that mean we actually have to implement it via syscall
> in the VDSO? That seems a bit odd? ARM doesn't seem to have getcpu in
> the VDSO at all, for example, so could we do the same and just remove
> it?

Good idea. I checked the implementations in glibc and musl, and
they automatically fall back to the syscall when __vdso_getcpu is
not available:

https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/sysdep-vdso.h;h=5a33871872da9ccef36293c3ca5eba6503f956e6;hb=HEAD#l36
https://git.musl-libc.org/cgit/musl/tree/src/sched/sched_getcpu.c?h=v1.2.5#n32

I will just remove it in the next version.

Regards,
Tiwei

