Return-Path: <linux-kernel+bounces-804062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5F7B46964
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 08:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B40D7BCC33
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF732BD597;
	Sat,  6 Sep 2025 06:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="haGuMH4/"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FBC2BCF51
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 06:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757139107; cv=none; b=IStrBG0o/pGvnaDobzhgUMc5fZ1XTCXxEcK06mKOoqIyXV/Z9l/EjzeNr1tSwi26w/eqF9PFaIGv89TM/PkEQFEkRbQwBNmXjwOPnS8ClODJnS4BaUNSg38yN3P4nalDbRsRhymCY7HN7s0xNb5sETsfRubblpu4U9Ep3hMQyQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757139107; c=relaxed/simple;
	bh=6s0wIHj0PdxucE4zNmyOjKPAS79GTpwzo+CJViYh/Ic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxQ32aXRI0NqMTSBv58hjIfOqk3EHURgPDFZHrxsbIAlJezWAThwFV9DMkhRlJGMgxMOM8DQ9nQ+5RVwuPLirDlLkGokidmcXF5zxPGoI3IcZVefJihS0QU+D/OoqlxttQR/JajBdZSN3Yy3m8msccP1emjI7f+mGfRwOyZKESQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=haGuMH4/; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757139103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1NFQND2bBLSKcxHd4866jX5YaYjgomSawNC5YiSuAKA=;
	b=haGuMH4/9MQ1i8a0rvaUXsu8yFTDMngQShGe8qVeYZkb/qfA0PpeSzmLmoChvAIQqPzwiM
	Qzlr33tEud3ehDJmUEYacn5rAl5294Hn8Mmj5frISc0eSZG198jv27ot2/NRTna1Gcxl2K
	9c0gPtkUKlrRpNhZSPUyDftng6jsfAQ=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev,
	p@sswd.pw
Cc: Oliver Upton <oliver.upton@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	maz@kernel.org,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org
Subject: Re: [PATCH v3] KVM: arm64: nv: Fix incorrect VNCR invalidation range calculation
Date: Fri,  5 Sep 2025 23:11:29 -0700
Message-Id: <175713908291.1682559.5048017839017321240.b4-ty@linux.dev>
In-Reply-To: <20250906040724.72960-1-p@sswd.pw>
References: <20250906040724.72960-1-p@sswd.pw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Sat, 06 Sep 2025 13:07:24 +0900, p@sswd.pw wrote:
> The code for invalidating VNCR entries in both kvm_invalidate_vncr_ipa()
> and invalidate_vncr_va() incorrectly uses a bitwise AND with `(size - 1)`
> instead of `~(size - 1)` to align the start address. This results
> in masking the address bits instead of aligning them down to the start
> of the block.
> 
> This bug may cause stale VNCR TLB entries to remain valid even after a
> TLBI or MMU notifier, leading to incorrect memory translation and
> unexpected guest behavior.
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: arm64: nv: Fix incorrect VNCR invalidation range calculation
      https://git.kernel.org/kvmarm/kvmarm/c/5b9c1beaa1fd

--
Best,
Oliver

