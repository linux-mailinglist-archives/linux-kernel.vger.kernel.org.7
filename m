Return-Path: <linux-kernel+bounces-862641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE216BF5CF0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF051884FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484B532C31A;
	Tue, 21 Oct 2025 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OEVnb6g1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YQdZEiU6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367582F12A6
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042969; cv=none; b=diLVcrey03XtY6LuMnN5HZXog1ExzJf//74oZdmKkqitVT8zRvMsZmL6Sbh5LMrWlRlEgvMEqjS3I4cUZCsi+WezCjurs6g7Ft0oVSTRo29vflAbrUv6OImQLX5z+LozjxI4IQXC9PdV31cB8jDSTXzTehhzjawVbqLWarB1tKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042969; c=relaxed/simple;
	bh=XcZFDb1TXZOGa35K/MLl9HGI/seSGUHoRnNJs5ul5Uw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PAL9tOfodfpwH1ppNCsZ7O42fBd8DT4mi13XxrRDJykqYRyJIfly/FjktEsHsykGcnAgeM29OXfqoMZkuorPk3BpZhslzNRWILkqblFVHMZCgFs5bKiOdGHtKy5HY+gpPyOOrQ3L3TB1MQxLHnkpMcx0yK3pEX2PteUpRyBwcIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OEVnb6g1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YQdZEiU6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761042966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S+dbGUmxbEbdMP/TWbhqHELpgBFElFNdyMVOi0l1Qzc=;
	b=OEVnb6g1A4hxFzOx1dfcjSznDJOK5W6O+8YHkdabHDbum0Iqa+AQFjJ2tAvO+FwJ7j60M1
	JpNPjCq5xwkp4ZaYxwkXj4uMfQfB2zUqAM93k2dhrF2oN0LycPreJyg+FlzGQDa9bw35bV
	FWOvTzK2hgTzXqvXmGeBwl6V7hOihfsC2DBvMT5Xlb+h6CuE6SX6WBnQEfmP0ucTN8EyDI
	PEddOs1z8L7eMTVA62XA8d33cR4ikvEeTe4xgHggWBhmgl5izsvVwxLdQ8jWM4gKFX8MRA
	2ny8fs6bBjNoJB+EeSuoFte2S40qft+8+0fKLcV8A6YMK3J4VCAfjc/XhRcLgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761042966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S+dbGUmxbEbdMP/TWbhqHELpgBFElFNdyMVOi0l1Qzc=;
	b=YQdZEiU611GfzujG9zA5c99LvJyju8e/PyGZ9pBxWGOX73Jldv0y1iFFV6nrEq568p7xZZ
	Ew85d7OHK613UoAw==
To: Vivian Wang <wangruikang@iscas.ac.cn>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Han Gao
 <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, Inochi Amaoto
 <inochiama@gmail.com>, Yao Zi <ziyao@disroot.org>, Vivian Wang
 <wangruikang@iscas.ac.cn>
Subject: Re: [PATCH 0/2] riscv: tests: Make RISCV_KPROBES_KUNIT tristate
In-Reply-To: <20251020-riscv-kunit-kconfig-fix-6-18-v1-0-d773b5d5ce48@iscas.ac.cn>
References: <20251020-riscv-kunit-kconfig-fix-6-18-v1-0-d773b5d5ce48@iscas.ac.cn>
Date: Tue, 21 Oct 2025 12:36:05 +0200
Message-ID: <87sefc1qzu.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vivian Wang <wangruikang@iscas.ac.cn> writes:
> Fix an allmodconfig warning on v6.18-rc1:
>
>     WARNING: 3 bad relocations
>     ffffffff81e24118 R_RISCV_64        kunit_unary_assert_format
>     ffffffff81e24a60 R_RISCV_64        kunit_binary_assert_format
>     ffffffff81e269d0 R_RISCV_JUMP_SLOT  __kunit_do_failed_assertion
>
> While we're at it, rename the test to remove the word "test", in order
> to conform to the style guide.

Reviewed-by: Nam Cao <namcao@linutronix.de>

