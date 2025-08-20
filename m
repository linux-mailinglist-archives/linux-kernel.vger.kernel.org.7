Return-Path: <linux-kernel+bounces-778668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5CDB2E8A7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBB11899B23
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6927D2DFA2D;
	Wed, 20 Aug 2025 23:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vFHtrR7Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1921E491B;
	Wed, 20 Aug 2025 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755732569; cv=none; b=YEaVeR6YMIy4nQjs/BO0qsOA9GGyBx1CAtxEhudLd9RdFPBz2IUFZXoX2H6qY6OYNoIMPhVznXy4R7DiX+s905PSy16tzqY1p6lSo7jpiMlLCN6qfcDmn6n1QG5p6lFqzOfGfZH9O4KUWV46bjnMJohiSZtc2B1szZ7yWREu1OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755732569; c=relaxed/simple;
	bh=m2IaG1MY/+xH+rg0uCa+LUQv8zbg5WaY0KTukcGLEDI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RkZuPSiy94L+NMKNTbMgbHCIWQiRuPA2osdnwVceb5/JQOhN5nz0QFiE0qRA6YvcMV5hJTWA5H3lxnTPsuWA9BqerSWB8Yc8N/GWkOkC1H/MWp/wX2t2GDO2BQ7f40wzN6JapvP7L/+XctvME3p2HxMT7xHyPZlYPA4cPrHc4V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vFHtrR7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6B3C4CEE7;
	Wed, 20 Aug 2025 23:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755732569;
	bh=m2IaG1MY/+xH+rg0uCa+LUQv8zbg5WaY0KTukcGLEDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vFHtrR7Y5KroDJGCDi51bt71NRLurSsxOIIDM6sO5c8GU7/Q0AngyIg8cbtiA4CVE
	 fkeVumBm5YkU/2HVuIrhotROZ4hi9PyEoiCUlkFDf/3kgcSvPsp2oefxafa6t/etmc
	 3xtP/tcFRWpZUzFOyqrpnDW3r0USND7XQKXfA3l8=
Date: Wed, 20 Aug 2025 16:29:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baptiste Lepers <baptiste.lepers@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross
 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jann Horn
 <jannh@google.com>, linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: mm: Mark VmaNew as transparent
Message-Id: <20250820162927.34201cfb395ec7319b15920a@linux-foundation.org>
In-Reply-To: <20250812132712.61007-1-baptiste.lepers@gmail.com>
References: <20250812132712.61007-1-baptiste.lepers@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 15:26:56 +0200 Baptiste Lepers <baptiste.lepers@gmail.com> wrote:

> Unsafe code in VmaNew's methods assumes that the type has the same
> layout as the inner `bindings::vm_area_struct`. This is not guaranteed by
> the default struct representation in Rust, but requires specifying the
> `transparent` representation.
> 
> ...
>
> +++ b/rust/kernel/mm/virt.rs
> @@ -209,6 +209,7 @@ pub fn vm_insert_page(&self, address: usize, page: &Page) -> Result {
>  ///
>  /// For the duration of 'a, the referenced vma must be undergoing initialization in an
>  /// `f_ops->mmap()` hook.
> +#[repr(transparent)]
>  pub struct VmaNew {
>      vma: VmaRef,
>  }

Alice suggests that I add a cc:stable to this.  But I see nothing in
the changelog which explains why we're proposing a backport.

So please send us a description of the userspace-visible runtime
impact of this flaw and I'll paste it into the changelog, thanks.


