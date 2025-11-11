Return-Path: <linux-kernel+bounces-895698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82545C4EB24
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44C984E7C35
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A85A2EF654;
	Tue, 11 Nov 2025 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKT5P4m9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9655C33CEAA;
	Tue, 11 Nov 2025 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873354; cv=none; b=AfL3vgSr8mOK1gEFI9ra5ElT112+6DDRCwUDkz5JZhq2juraBxIxE4WxfY5UGaqBTks+BsucqxFShQntKR/R7ODSUd8VjLCZOh7q8ghU+oDNDtx+obxXS5Q8NsPo+DX1OprqHZprwNlI9OugBYH6LEBtXmLOWveRitf6fnZkddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873354; c=relaxed/simple;
	bh=InrPgEOCEB6K6A67ilNYyDWeBHOI+x2pGFN91nkaglU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZ/HoJYV/9fqvp68s7EFGwmDrQvIh7q4UdDm32eeY5i39xWGJSfRyWhPyXiOhaig6Jm8RepcZfLutJ6L509rNeGJoU8EMK2Md0nympy+aZNKeOcqQRtxdCvtDgMsJtmrVJ8X9R41+FUHt3hYH8zkbHBsz38UcA1hCfjA2saaRXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKT5P4m9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C953BC19422;
	Tue, 11 Nov 2025 15:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762873354;
	bh=InrPgEOCEB6K6A67ilNYyDWeBHOI+x2pGFN91nkaglU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EKT5P4m9gWLSoveSzAcUzcvh6XShK/Gwuii6EPs3aRGEK8i+sKz2unZUQICH7id/g
	 i0WfNfx195Wk3W8NpPOfON0PbPYBd1IhbgPEK/5BjFhLuyqj6XVmbZ4FHHWTbA34oC
	 wO5GmTv/67JkB4XNZD+SJzh71T6elqj77Ynet7qla0dQL/v2+XRoeGys1uvbjxl/CG
	 UMgDs9tYKIS/S+MbR5PG+t9tJairvQTKQkFMbIbdufpFVMdeY8bJGO1efZI3A4Q3nm
	 9HRNNT7mKd3OVnGIk3HET/WtFeoaYmGfU9eJyWS+KhgmwqBTwmSVON0WEeWtDYDBaL
	 Oxq7NB85GQgmQ==
From: Nicolas Schier <nsc@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: headers_install.sh: Remove two outdated config leak ignore entries
Date: Tue, 11 Nov 2025 16:02:24 +0100
Message-ID: <176287331288.120136.9145995114023167488.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105-update-headers-install-config-leak-ignore-list-v1-1-40be3eed68cb@kernel.org>
References: <20251105-update-headers-install-config-leak-ignore-list-v1-1-40be3eed68cb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 05 Nov 2025 21:26:02 +0100, Nicolas Schier wrote:
> Remove config leak ignore entries for arch/arc/include/uapi/asm/page.h
> as they have been removed in commit d3e5bab923d3 ("arch: simplify
> architecture specific page size configuration").
> 
> 

Applied to kbuild-next, thanks!

[1/1] scripts: headers_install.sh: Remove two outdated config leak ignore entries
      https://git.kernel.org/kbuild/c/7bade3f7

Please note that commit hashes might change in case of issues with
kbuild-next.

Best regards,
-- 
Nicolas


