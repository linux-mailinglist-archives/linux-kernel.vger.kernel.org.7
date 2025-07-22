Return-Path: <linux-kernel+bounces-740636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63D8B0D6FE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A84164DC0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA3D2E0925;
	Tue, 22 Jul 2025 10:11:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9632E06ED
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753179082; cv=none; b=GGKoPakM2s2UsCwOY8tlUTloXCK+6mhKZsCbtVi3/x21uJObISOohdkPlrxoS183CR5dkK/ObQESoBA4bKFAPzOOCXKpU0CoQRFSq8vhPknGoUkJx95XRVjATxn0E211Axb7FSoGwCVrFjfAZ55e54sXIGeUVROAGXs2CUMwyUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753179082; c=relaxed/simple;
	bh=k7gk/WSw0/gQja9vwG1q7rESJp43kvSAGFsgPignS0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTcK+1pulOlQ6J7VQUzmNZi6rp88h/0S6s1kM0D3bI2upaq8EQ2vd/IhgKOJ9Sv0D8MEuzDiMiwux/43VBtbkQ8cKm/suTjl66OAqebTv++hviofEJS5gAlHBLCbW5peSfDCVMsOnhbQkHCV0kONtMaDXu6EhTv6WQE5xfI770c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2F5C4CEEB;
	Tue, 22 Jul 2025 10:11:20 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>
Subject: Re: (subset) [PATCH 0/2] Improve POE handling for uaccess
Date: Tue, 22 Jul 2025 11:11:18 +0100
Message-Id: <175317907573.3058594.12056270289383660598.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250619160042.2499290-1-kevin.brodsky@arm.com>
References: <20250619160042.2499290-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 19 Jun 2025 17:00:40 +0100, Kevin Brodsky wrote:
> This short series attempts to approach POE (Overlay) faults consistently
> w.r.t. uaccess. We currently assume that spurious Overlay faults are
> handled by retrying the access [1], but this isn't the case.
> 
> Patch 1 ensures that spurious Overlay faults are indeed ignored. This
> being done, it typically isn't worth using an ISB when writing to
> POR_EL0. Patch 2 removes the remaining ISB in the signal handling code.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[2/2] arm64: signal: Remove ISB when resetting POR_EL0
      https://git.kernel.org/arm64/c/1a665a71ef0f

-- 
Catalin


