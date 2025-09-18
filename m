Return-Path: <linux-kernel+bounces-796250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390F0B3FDDA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B4C2082D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D632F49E3;
	Tue,  2 Sep 2025 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IplzEo0/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23751247298;
	Tue,  2 Sep 2025 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756812844; cv=none; b=Z3zZABvQpSEssolSx32CRpVam1DjCmpMT9F2UFmxdkeaCqvlOiFG2bERljXfcYJ6Oq2bISWI3pyHBdYPTixZ+vOf4G1me5UydhT1248kUFqTXzhHznGMlrGR8idGj3NJXR5iJ8zaCS6c/Koiq6PPsdyGfE5h0k4LE/Vp5X3RPGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756812844; c=relaxed/simple;
	bh=NDEg3JUwIVXYkuZ0znIzSpopXc2IJTtscbXtwUBuMtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1xf+Munyjd3QeYjsRux3l5udadpXu83i30mRup/hSeO9qHEhibXcwz7hZuBQVfI9ngTXLkGbfajD1CrCKFK9HrUdINMfpT+V7EQgLlqebiXa1uDMxFQmw5FXnhVw8MnC/xHvEZWWVY3Y3NaupO0hCiBPKAXhQFeF1a4sEqOGCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IplzEo0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACADC4CEED;
	Tue,  2 Sep 2025 11:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756812843;
	bh=NDEg3JUwIVXYkuZ0znIzSpopXc2IJTtscbXtwUBuMtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IplzEo0/LCoFnSOvu7NS4cizRR773dAiCcNJRkdjSJ35knNUKaD8gnVGZrIWKkIep
	 +1kVN/zygPiulbxI6I8dluFiF5Vqn/la/mJlFQWT5CQI+aLwz37Utwe6ZdW5n7CJHE
	 9O9K7mjbnHDAXlbAtNsJBRLvlTfAME4zaA6m+5gLXX4eJ7/EV5LWy1QiLe2UBPxx52
	 seqk81IEEnVOzEErROkL5ZggP8btdaaqQkXFqVWRdGOHTbcaXfYmiTou6i4lwEe0AT
	 eSZPIO/TbSA2U2Zj1nEOZojX3S8gNQCOI+5KUKawcRriM1PFVH4LQzau5JuVuX53V1
	 cO8dfO43FFCxg==
Date: Tue, 2 Sep 2025 12:33:58 +0100
From: Lee Jones <lee@kernel.org>
To: herbert@gondor.apana.org.au, jarkko@kernel.org,
	Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	davem@davemloft.net, linux-crypto@vger.kernel.org,
	peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v12 0/4] Add Loongson Security Engine chip driver
Message-ID: <20250902113358.GI2163762@google.com>
References: <20250705072045.1067-1-zhaoqunqin@loongson.cn>
 <175681275359.2293173.7663755797512449740.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <175681275359.2293173.7663755797512449740.b4-ty@kernel.org>

On Tue, 02 Sep 2025, Lee Jones wrote:

> On Sat, 05 Jul 2025 15:20:41 +0800, Qunqin Zhao wrote:
> > The Loongson Security Engine chip supports RNG, SM2, SM3 and SM4
> > accelerator engines. Each engine have its own DMA buffer provided
> > by the controller. The kernel cannot directly send commands to the
> > engine and must first send them to the controller, which will
> > forward them to the corresponding engine. Based on these engines,
> > TPM2 have been implemented in the chip, then let's treat TPM2 itself
> > as an engine.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/4] mfd: Add support for Loongson Security Engine chip controller
>       commit: e551fa3159e3050c26ff010c3b595b45d7eb071a
> [2/4] crypto: loongson - add Loongson RNG driver support
>       commit: 766b2d724c8df071031412eea902b566a0049c31
> [3/4] tpm: Add a driver for Loongson TPM device
>       commit: 5c83b07df9c5a6e063328c5b885de79f8e8f0263
> [4/4] MAINTAINERS: Add entry for Loongson Security Engine drivers
>       commit: 74fddd5fbab879a7d039d9fb49af923927a64811

Submitted for testing.  I'll send out a PR once successful.

Note to self: ib-mfd-char-crypto-6.18

-- 
Lee Jones [李琼斯]

