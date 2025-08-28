Return-Path: <linux-kernel+bounces-790343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A051BB3A5A1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522B716AC6D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5935E275AF9;
	Thu, 28 Aug 2025 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emHVLjvZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52D3274666;
	Thu, 28 Aug 2025 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756396986; cv=none; b=IlfHa0VJUHpqfK00v4iO1nXwVW0G3vHsljUKW+QvOm24G0XihsZeQtC08ICrTjBqQfN/6IcP8F1nhbI25RCQe64lD8DwENIpNsQyUVCRH0MKYEcu9uOlUoBoN49IN55rQegEXgKU2DV+lRGGIDvqjk4bQU5X8PfERRm4YxqqTCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756396986; c=relaxed/simple;
	bh=rqiqE3eHb4MM2q4/saGPmuf1MqrdrB3czVaUZouQEBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A9GEwsaNUKo7uMKtiWURtobqpVQx/0HW/RIjZRmbW06IQMDuaMGq1Hln1Loc7Re7q4e+8GwZUVHcrvomqD4pWVCEDb/asXLERvjz5THiCPYyjW9Nq8MqKsqykXYQMdXTecYXrcWj82xJJLeBMWUNjlwUOMk1A2Qsoc2mzOlxvNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emHVLjvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56051C4CEEB;
	Thu, 28 Aug 2025 16:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756396986;
	bh=rqiqE3eHb4MM2q4/saGPmuf1MqrdrB3czVaUZouQEBQ=;
	h=From:To:Cc:Subject:Date:From;
	b=emHVLjvZBw4ozIxk0IIGMzWP1NSQcDfdff1OtDBy8Rputuu6rJqiEVy23IbqYSknK
	 BrYQNby3opqZV9Al8KiLPLoSBjRHP4JII/kvTswemJk8q0inM5to+9Uso2r4xO+2he
	 ZBQcp6ALBdVGub9fYALRuvy//ywRhiRmWrfqAv63/Gcp880Llsm+Twmy7Gn22nbQSt
	 qPgOsT471BW2Z53cbzbiP6pLdnopbOkb4mBtMCAkQNabBCnPZzzv+bD8tjI+QRR6yn
	 OU9ZTR0qoCVq2OKZrpXSDGHVDElt8Z79t8DL4m8XIzO1XxujKXoNzlJjwTh+52FalH
	 U0njAhNzAwlww==
From: Miguel Ojeda <ojeda@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: gpu: nova-core: arm32 build errors
Date: Thu, 28 Aug 2025 18:02:47 +0200
Message-ID: <20250828160247.37492-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Danilo et al.,

In Linus' tree and -next, for an arm32 LLVM defconfig plus Rust build, I see:

    error[E0308]: mismatched types
      --> drivers/gpu/nova-core/fb.rs:49:59
       |
    49 |         hal::fb_hal(chipset).write_sysmem_flush_page(bar, page.dma_handle())?;
       |                              -----------------------      ^^^^^^^^^^^^^^^^^ expected `u64`, found `u32`
       |                              |
       |                              arguments to this method are incorrect
       |
    note: method defined here
      --> drivers/gpu/nova-core/fb/hal.rs:19:8
       |
    19 |     fn write_sysmem_flush_page(&self, bar: &Bar0, addr: u64) -> Result;
       |        ^^^^^^^^^^^^^^^^^^^^^^^
    help: you can convert a `u32` to a `u64`
       |
    49 |         hal::fb_hal(chipset).write_sysmem_flush_page(bar, page.dma_handle().into())?;
       |                                                                            +++++++


    error[E0308]: mismatched types
      --> drivers/gpu/nova-core/fb.rs:65:47
       |
    65 |         if hal.read_sysmem_flush_page(bar) == self.page.dma_handle() {
       |            -------------------------------    ^^^^^^^^^^^^^^^^^^^^^^ expected `u64`, found `u32`
       |            |
       |            expected because this is `u64`
       |
    help: you can convert a `u32` to a `u64`
       |
    65 |         if hal.read_sysmem_flush_page(bar) == self.page.dma_handle().into() {
       |                                                                     +++++++


    error: this arithmetic operation will overflow
       --> drivers/gpu/nova-core/falcon.rs:469:23
        |
    469 |             .set_base((dma_start >> 40) as u16)
        |                       ^^^^^^^^^^^^^^^^^ attempt to shift right by `40_i32`, which would overflow
        |
        = note: `#[deny(arithmetic_overflow)]` on by default

Similar to another one I sent, I hope it helps -- it may be useful to make it
build in 32-bit as a test for those kinds of platforms.

Thanks!

Cheers,
Miguel

