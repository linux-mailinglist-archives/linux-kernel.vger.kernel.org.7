Return-Path: <linux-kernel+bounces-806540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB96B49835
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F9B1895B6C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB8931AF27;
	Mon,  8 Sep 2025 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D6rKnMve"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A17F31AF13
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355821; cv=none; b=WUDNaEBAbrtVQMe+3Ig70lHLjPDx/egVouxYZcw1BryPeaOP6C8wTxMIBA6Ccr30G97/KKrBee0+jquUecOPlkfSPeEUBldw2+CJ8LXLsOuIGAxkiwod7GZvfPrBVk6pvuWA45riZlZWJe66rkRnoLGnIG6EJV46a+RLTGJyVRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355821; c=relaxed/simple;
	bh=ag+FLIW9TcRTeXefgOCiuIDZYedilutf7L3HblgW/cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZxOJSKHrPYZHq+cIRFZNKetJRKZqGZEN91VUV68SoRbBPVDWglYH89GRdcxG6M/NIGw+HCBMeMq6DfV6DpaBRtoAz/6qU8U3n1lb9ZDFhdnL8ghLXWeQ4DQdSQOStkRd4mEX/4o/tInjMAAkxw4TnUgmFxwv0MewlrfHtzxIDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D6rKnMve; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757355815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JVGGqRZBAm24OtLHJX+wyXUcc8yBv/hwqlqTCh+kbiI=;
	b=D6rKnMvef2XGDvo9OwgPQQ3inWRixjXsipxt2M7RJVwLnY4Iq3qWvesP8y5QqgvP2qLdBv
	YV5oobdQrWxYjDbX5YoiWAK6bqsImHyddB2e5uM4mCL9Jec3RemC7Laia3BbXDNKVkypfo
	imMM7/YOWf85hVWpiUgeRt0p6Pm9uj8=
From: Oliver Upton <oliver.upton@linux.dev>
To: jintack@cs.columbia.edu,
	christoffer.dall@arm.com,
	maz@kernel.org,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	Julien Thierry <julien.thierry.kdev@gmail.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: arm64: vgic: fix incorrect spinlock API usage
Date: Mon,  8 Sep 2025 11:23:23 -0700
Message-Id: <175735577932.2363175.14048203051041035424.b4-ty@linux.dev>
In-Reply-To: <20250908180413.3655546-1-alok.a.tiwari@oracle.com>
References: <20250908180413.3655546-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Mon, 08 Sep 2025 11:04:11 -0700, Alok Tiwari wrote:
> The function vgic_flush_lr_state() is calling _raw_spin_unlock()
> instead of the proper raw_spin_unlock().
> 
> _raw_spin_unlock() is an internal low-level API and should not
> be used directly; using raw_spin_unlock() ensures proper locking
> semantics in the vgic code.
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: arm64: vgic: fix incorrect spinlock API usage
      https://git.kernel.org/kvmarm/kvmarm/c/2d0478279fc7

--
Best,
Oliver

