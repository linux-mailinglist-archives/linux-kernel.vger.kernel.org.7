Return-Path: <linux-kernel+bounces-783290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6B7B32B60
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 19:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1C0A24BFE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 17:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C0C212553;
	Sat, 23 Aug 2025 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QrIfAk3K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hWFJ2X3G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27051F17E8
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755971357; cv=none; b=H423nhWeOiTyUinrTlL/Q3vlAQjWGP4M8hRbF7syp/ZASTEhKYUepDZ3P8mxHVhhUo6Pmfm4dfT1EWMB0R7AysZSM7YjsjPPDYg5lYO8tiHd5VgoO7F+Cox4X2lIGxgnx49XdXaU/LZU8r9Z2m0rZNp7CpAqZpU2Fi0KaDmq21Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755971357; c=relaxed/simple;
	bh=yfEDlR44SKYwe9t2Ck4ZMb2n6JzWPgouUwpdJL8cUJk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qac7Ho+lRuYUdRR4TI8oobpxCHITQcHUDm0q6g1+MjVH+gtBBLsjqiVAwgp0gldLUxZsEX44c/9lET8oBKUgw39xZ8pm7MPTVVSx6f97RuPg+0My+eiUcsvs+Y6RyY+4crbQOnG0JQ7poh+pramHq5isxsVr0a5xB2xJFqTNtCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QrIfAk3K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hWFJ2X3G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755971353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t26P4i6qFAnXFq7sSgBOwmf+z1fifSmP0XY309gbQkc=;
	b=QrIfAk3KDYbZgLsLCm/xpMgSbDziJXMIURRmN0cI3QQZyrJTBa6YhdRnvPdCWAkF6Bx6uT
	XTvdwdnMYiOlpZqOUeoWytUhvy9eSiO5oImpP2umghH01Ux7UIZIXNgpojJGz1aD6gWoPc
	JTRSO2m29hqoimfkwmAGjVxsMJrfjyN9x7qhxosw9YgQOpiNHLVyTxFINWSSrUdNT2fHS6
	WC0vA0PQRtr8KF/bIc3jRUcUDZOT85aWwTeSLJKEYxvYqIhSwdZXIBnWV+hS86U7spYYHn
	es57CWrTrtLCiIicNGzwvnTr7I9Mq6JOqZMvvDFu36IHJEdYQplWQbBMFjPuWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755971353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t26P4i6qFAnXFq7sSgBOwmf+z1fifSmP0XY309gbQkc=;
	b=hWFJ2X3GOogct+rij7ROeM/drtIzSPOs85Uluc8E9iqkwcOq9X8lky2dBkv8UCt2xskZ+T
	ZkQhDM+W29S5TnDQ==
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: ricardo.neri@intel.com, linux-kernel@vger.kernel.org, Ricardo Neri
 <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH] genirq/debugfs: Fix a typo in IRQ effective affinity
In-Reply-To: <20250812-rneri-irq-debugfs-typo-v1-1-f29777b4024d@linux.intel.com>
References: <20250812-rneri-irq-debugfs-typo-v1-1-f29777b4024d@linux.intel.com>
Date: Sat, 23 Aug 2025 19:49:12 +0200
Message-ID: <87ikievsh3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 12 2025 at 14:00, Ricardo Neri wrote:
> Fix a typo in the line that prints the effective affinity of the IRQ.

It's not a typo. It's intentionally shortened to make the output
tabular, which makes it more readable.

If you want 'effective' then please adjust 'affinity:' with an extra
space so it stays that way.

Thanks,

        tglx

