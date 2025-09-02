Return-Path: <linux-kernel+bounces-796546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EACB40250
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E461667A0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194162DCF45;
	Tue,  2 Sep 2025 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YWEC4QUp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ycglXv/8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147C12D59F7;
	Tue,  2 Sep 2025 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818693; cv=none; b=T0qy8nLCC8IVQDasECGbJk3oJCqo9Zj8TLRTrX53C9mOxNQF4SAKHpjuoYVlgVdRs3MwIKQuD6pPy8+xorJH89DHtKBqKxY0ruuRk6TTxTNlTBCX9P19vDzQv0dMJoyoLiJV48SCiF76nQZe7+HS87YTOa0NBGH2EpRUa3oEibM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818693; c=relaxed/simple;
	bh=HDJq/v4iV8lXkWfu9EkxrHqFL1YttikoDFsBsNqIClM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OCuK/ce8PDUjygZRKxFUEcQfbAAgHNXBWS/WD6VM+LxPwIPyetGYSVC5LpZr7PqADbyvylsaFkpTDFmKQ5oKCEqGirdK2L2/DJ3m/SVAheAuetjPzkQwrapkji98B5zEz5Xc2ZrvLI3Lhs9/aZATtyCS7fYiQvcfgZNX1roLHVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YWEC4QUp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ycglXv/8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756818690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kwfSBoK/ve+VpSlNqrICT/uqzddMZnVh5D/ECzeKzdU=;
	b=YWEC4QUpWfHi33bu+UhnWhDbbLoolTpMPiGzXHG164LfKGhOz4XtdxXII/AMMHGrp+lXYc
	uHRVXoatjegkcLeD/n2vfYABtxJVCJ4JifNZNqP/7y18hPF20O9W5mZv/Y+Rk7fEJgmvCY
	V+NUsP5eeVN0etb0l25dAX+35X2e4QyTHuO3OqKmbsEzU/iv41ewySTrPBeY3CY8gPpkK5
	bHcGOlZK8neVtIfVTHdP0WWuY7WphwFcaB704scqmZ9la/g1zsVMyekVv5ecIUTgOPLpR5
	NnoHfehjzDLa8fxMxhXqdGLQk1I78NDiFWMZJSxDPNKnt96xRlQUpGxuEw2hZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756818690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kwfSBoK/ve+VpSlNqrICT/uqzddMZnVh5D/ECzeKzdU=;
	b=ycglXv/8Sw1JkrzRNe1Kxtw+ZTw7kMPurQ2uCOSB1NYRnv2ef2R1D9mRa61JTdHsIgVret
	H4LwdxeiA7jGRhBw==
To: Chen Wang <unicornxw@gmail.com>, u.kleine-koenig@baylibre.com,
 aou@eecs.berkeley.edu, unicorn_wang@outlook.com, conor+dt@kernel.org,
 inochiama@gmail.com, krzk+dt@kernel.org, looong.bin@gmail.com,
 palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org,
 sycamoremoon376@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev
Subject: Re: [PATCH v2 1/3] irqchip/sg2042-msi: Set irq type according to DT
 configuration
In-Reply-To: <49e70989c2f0a8a67e48527e57b4877262996214.1756169460.git.unicorn_wang@outlook.com>
References: <cover.1756169460.git.unicorn_wang@outlook.com>
 <49e70989c2f0a8a67e48527e57b4877262996214.1756169460.git.unicorn_wang@outlook.com>
Date: Tue, 02 Sep 2025 15:11:27 +0200
Message-ID: <87v7m10zk0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 26 2025 at 09:09, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>
> The original MSI interrupt type was hard-coded, which was not a good idea.

That's not really helpful, unless you explain WHY it's not a good
idea...

Also for correctness sake, you want to change the DTs first and not
after you changed the driver to read it from the stale device tree with
the wrong type.

Thanks,

        tglx

