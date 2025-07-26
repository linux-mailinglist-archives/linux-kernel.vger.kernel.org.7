Return-Path: <linux-kernel+bounces-746807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9096FB12B69
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 18:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEDDD177000
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 16:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF6B28688D;
	Sat, 26 Jul 2025 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EQYktzuZ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DA3CA5E;
	Sat, 26 Jul 2025 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753547022; cv=none; b=plEtBlRQVLMr5i0taqhPDxj9LZEQMspIZeW5xlZBRgC4E8MOihjBe2KouNYubS3qa2tZzPXkPCaDW75XKRzlknaV4vVmDUxBTrYY+foSs9oWIyKDEZsp7DdbtLiXojwDXdRy+bSDv33b7S4/cNPfD63iNHIy1aj9DnqV3WpD9Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753547022; c=relaxed/simple;
	bh=hDqFI2wPYBv59OSq9AykdhCsgQkQAgQ3zp9pKXT0whU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdQ2T3IcKcQRDjOrjBFJA+esjpHhjhz/rtMqSOwsUYURlKUNHzMlraKdhm/cnozePa8gHHlyJBTIVo5jxCT19wZcC0xkRCC/b8i7nyKGCTSjEZNzdVb+ecfYcD69l+BRIs8VwO187HfnJLaaS4JVAbfFudeFFtM9WTmLODefGXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EQYktzuZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BCelaxmFLQrYbCRGNGoWn94+fWTBVluOpP8vBuCzlJc=; b=EQYktzuZkvxfqM2Q5J90Ab3f1F
	O9AUhlPVOrtk8aRkWbDVX3IDvRtAHZWLdFBHj2bTbx7gtaMJuZQpBRWSdyDMNFW9Q99wVjpDjV3nY
	PHDpijOGz+OcpZS1A1azojnxk7gLfymJqZ6REW1+iwlZopuwDIFBFi5Hh1ImSkxA9po3ule/SCxdO
	xBgTTQvyCQxFN2LCfQgMcByZoKLTBpsxOi1uLDVlLAfhIDCO6SYcXuxvgAmgB+PI2DJwDJtAJ38IU
	aAvtCvxWMdZGInv8FNsLkEW3UYrJo6rAPbS+yFMkzQOzOJGdO50gnu8oUK7sLbcC8jDEyH4AR4kqR
	XxKa0Igw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufhgC-0000000Ft6W-15qn;
	Sat, 26 Jul 2025 16:23:24 +0000
Date: Sat, 26 Jul 2025 17:23:24 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/3] rust: maple_tree: add MapleTree
Message-ID: <aIUA_HFLXMYNxWDM@casper.infradead.org>
References: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
 <20250726-maple-tree-v1-1-27a3da7cb8e5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726-maple-tree-v1-1-27a3da7cb8e5@google.com>

On Sat, Jul 26, 2025 at 01:23:22PM +0000, Alice Ryhl wrote:
> +struct ma_state rust_helper_MA_STATE(struct maple_tree *mt, unsigned long start, unsigned long end)
> +{
> +	MA_STATE(mas, mt, start, end);
> +	return mas;
> +}

This seems very inefficient.  Returning a struct larger than two words
(on x86 anyway) means that the compiler implements this as:

void rust_helper_MA_STATE(struct ma_state *masp, ...)
{
	MA_STATE(mas, mt, start, end);
	*masp = mas;
}

so that's about 72 bytes being memcpy'd per access to the maple tree.
Sure, it's stack, so it's cache hot, but surely we can implement
the equivalent of MA_STATE in Rust and see a significant performance
win, at least on read operations.

