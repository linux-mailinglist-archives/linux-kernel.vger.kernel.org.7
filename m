Return-Path: <linux-kernel+bounces-786652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C609DB36018
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94DC5464079
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80CE21CC79;
	Tue, 26 Aug 2025 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5BND8LI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6747260F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212845; cv=none; b=nqVF8gRfMvC1fZzaEEUcEEQ21NyYpQIoM9QoaGiDc7STMfJNDqZMdwPOwzwgirhJmtficCed5CVvB1lRRcfM506Zxsna0LWRKqt+/WFZpFT6VaUg+KopyvO5y75pqdxTJxn7WdVpPW9tGTFgwcUFR+NOKeosGsEhV14mbK69yis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212845; c=relaxed/simple;
	bh=VqBfKPuvRHBKNrtaTa7Cb0yVBaKmtsKCiD5waTaaQD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Unor4sciZg0jQWjjk9IJyA2J8cZgb7UAyfDBMciHak3veBE3GQHiEo4yQteiDwjZOAM7plcl12e3Mqu5Ij/Qw7QhDYW3m6UXcMTxE39cMct5/KiTXfuJQU1TlhNWpFFpmn0qykE0EwwQnc2qp04zz61wHQkNj7Ykhv8k4pAVA1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5BND8LI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BB6C4CEF1;
	Tue, 26 Aug 2025 12:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756212845;
	bh=VqBfKPuvRHBKNrtaTa7Cb0yVBaKmtsKCiD5waTaaQD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=g5BND8LIk17igmrS4/oA2wN9wTwM/qROa1VS9wg7QrnPjtmYCxPi8o7qO/aIXs1kr
	 nA1ZvXiZmCePvMByn+/Ra+z/m2H6p0G3C5Kmlq98Xv+cPxxGpx1S5RnpIYcBTFgCkw
	 MsxKKjMndnWRMUi5P+Wd0VZPf46fUOHBGLcGpmEn8rFaejj88tVFQ+5TqkxpUDN330
	 KpfFSV6ZvV+3WJJZNlgTe0oeYAjbDzsdy3DfH8etedYRptIP3tZTzNL0olS3R/8oiU
	 Y++k1RYSMbYklKwv8Yn+itCHLr5r8vRsYzlwVyId67HPYl1bsFqzRvXAmEMN40bGLK
	 zEOvtfpxfk1Nw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,  Will Deacon
 <will@kernel.org>,  kexec@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  bhe@redhat.com,  oxu@redhat.com,  berrange@redhat.com,
  kernel-team@meta.com,  Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] arm64: kexec: Initialize kexec_buf struct in image_load()
In-Reply-To: <20250826-akpm-v1-1-3c831f0e3799@debian.org>
References: <20250826-akpm-v1-1-3c831f0e3799@debian.org>
Date: Tue, 26 Aug 2025 14:54:02 +0200
Message-ID: <mafs0qzwyxmz9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 26 2025, Breno Leitao wrote:

> The kexec_buf structure was previously declared without initialization
> in image_load(). This led to a UBSAN warning when the structure was
> expanded and uninitialized fields were accessed [1].
>
> Zero-initializing kexec_buf at declaration ensures all fields are
> cleanly set, preventing future instances of uninitialized memory being
> used.
>
> Andrew Morton suggested that this function is only called 3x a week[2],
> thus, the memset() cost is inexpressive.

Yep, and it is only 80 bytes on an already very expensive kexec load
call.

>
> Link: https://lore.kernel.org/all/oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3/ [1]
> Link: https://lore.kernel.org/all/20250825180531.94bfb86a26a43127c0a1296f@linux-foundation.org/ [2]
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

