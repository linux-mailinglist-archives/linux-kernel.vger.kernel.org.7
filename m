Return-Path: <linux-kernel+bounces-874845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F265C17378
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4CAB3A8BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FAD3570CC;
	Tue, 28 Oct 2025 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="PAXceexB"
Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19C53570AE;
	Tue, 28 Oct 2025 22:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.131.90.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761691317; cv=none; b=a6IqT7ICpdLlAwkwgIm/UNTQynqf/tGIaAZj1OlfzqcoLaWhImMJFFKnt5078rr2gNs2FHs9XEBHugUYbXpddqYR2jWqC80h2UAPhCkJQV2YBycPWm75tqIglqxQRZuYTAHNNUOhkcDNYzpJBDlGaZ0Nbkxu92vfW+hwiUz0yH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761691317; c=relaxed/simple;
	bh=7fbLf7dsMSEXsanBd+TOkS6hS7Yp+t45iWo2f3WKxDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5buriq5ohfi9uoLQ/iKCZ8SBk8jtjkfXqt57RmGwByUssAO/2+Ww16skC+woOkWYvIAPo24Kz6sySnoYtX+OsekfzCJjdsL3dTKVrn0/N9nsCqeUHTDDGQeRrTMSsS0urwpAaNvRJV19NNeVojdAFDD1L7wXj1nTVRgaz9gfqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=PAXceexB; arc=none smtp.client-ip=145.131.90.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=startmail1; t=1761690727;
	bh=7fbLf7dsMSEXsanBd+TOkS6hS7Yp+t45iWo2f3WKxDM=;
	h=Date:From:To:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From:Subject:To:Date:
	 Sender:Content-Type:Content-Transfer-Encoding:Content-Disposition:
	 Mime-Version:Reply-To:In-Reply-To:References:Message-Id:
	 List-Unsubscribe:List-Unsubscribe-Post:Autocrypt;
	b=PAXceexBW6LqhOQCKV/n049i6ibT84slkSt9i08v8LW32Z2f9A5yd1a+EVL1yDQoo
	 lVf6LgG5cE6CQqj8+ja7m+lBwcrjzlyo2mb/wvIu7U9AYOxS3Oz80MtS5pMCus/T58
	 KhdbY5jARLAt2G4kZBh4QrV7rRYS6gXXf3xSky79sfnJi01YjZUqVRsd79755pY3pG
	 w0JcbQ8jcA6vPcG66tGW/iAlMH0CD3MlN3+L4NSiltTgeSyE/+6PzVFnAbnKDaHKWp
	 zUAbRMOVMzTvfO1Ez9Ww/cOVYqKERTzCCY/V1pxAVbvXliNxq4g2hAqRH2Pd8+eqim
	 UU0kA/mCsPa3g==
Date: Tue, 28 Oct 2025 22:32:02 +0000
From: Elle Rhumsaa <elle@weathered-steel.dev>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/4] rust: macros: Add support for 'imports_ns' to module!
Message-ID: <aQFEYmJ4K92NNjs5@archiso>
References: <20251028-pwm_fixes-v1-0-25a532d31998@samsung.com>
 <CGME20251028122316eucas1p2733987cd4c1eb8f83d6572d542e76d2a@eucas1p2.samsung.com>
 <20251028-pwm_fixes-v1-1-25a532d31998@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-pwm_fixes-v1-1-25a532d31998@samsung.com>

On Tue, Oct 28, 2025 at 01:22:32PM +0100, Michal Wilczynski wrote:
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

