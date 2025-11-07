Return-Path: <linux-kernel+bounces-890955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12732C4173A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 20:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9111899A33
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 19:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224813054EE;
	Fri,  7 Nov 2025 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePhoatHu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77104212F89;
	Fri,  7 Nov 2025 19:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762543976; cv=none; b=GooYA6F0hBn8k4Id8X6raZCDXZL1Aaax2pxhDTvyi9CkIUNRe4DOx3Q8A2Q+EjrF3kVImzQ2qxAf7LLz3aEz9vvYwg7e8oegCuXoCjE6ySKuurzZqaGA/WKNT/5YhleIIISDGR1oiC5IQPK8DhugbPrAqCdQt8+/6fhMUhJkKUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762543976; c=relaxed/simple;
	bh=5kJuNYOoK5sgrRRGtV9IpdaMoM6kMmY+7QnoaSK/b8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7819smodxj2YQRWh4po8B1NhPpdGNth6cG29FXF+R0ivVVldBGu/cUYx60t19CfCvxIy2zdL7HrcpFcj7zzoumFgluvDIcN8NUVZrhqF2ZtspH/6vMRid6R4qTHLBCHxcnxxkBKaUaPBasO9ui3PsVpUHMzUq60tJi5ptPxMEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePhoatHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06599C4CEF8;
	Fri,  7 Nov 2025 19:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762543976;
	bh=5kJuNYOoK5sgrRRGtV9IpdaMoM6kMmY+7QnoaSK/b8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ePhoatHuxrexXObKA0it0rslITJnyKHHyBMzZFYP0ZhTiEIRWwn+IEx61x85Kdt8I
	 tQuCxQo3kFQYoN57aCUon2E7jllDfyrZ147oIcHJwPEcL119z/AqZEqrRapCRp/tUL
	 iakixvJaCvvdxXpIjH0DT4ESFeyJVxrf8xoyLRdbn/3f2bbZ+V2pGmsX7mMWq+OL/G
	 tyS7KyCy1ov1k5xSQsD7h6XsznoKUrT9Dy+qw4GjjAi3Iz9wITc95cYj5DspClogO1
	 gbA/R9b63J5a7d0UDfQ1H8idqoUDueyXvKrsShOXqsSjw2KNtMtrQFOyo7tSlB9qIv
	 fpYzKo6Nqmp2A==
Date: Fri, 7 Nov 2025 12:32:52 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org, ojeda@kernel.org
Subject: Re: Prebuilt LLVM 21.1.5 uploaded
Message-ID: <20251107193252.GA3606140@ax162>
References: <20251105062723.GA2341496@ax162>
 <CANiq72k3WuXTyk-X1ye+7JThf2pNcgdKnqOrFieHqxOMZD2oZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72k3WuXTyk-X1ye+7JThf2pNcgdKnqOrFieHqxOMZD2oZQ@mail.gmail.com>

On Fri, Nov 07, 2025 at 06:56:53PM +0100, Miguel Ojeda wrote:
> By the way, not sure if there is a reason for it (e.g. a workaround
> for a bug or you don't keep the old LLVM files etc.), but just in
> case: the matching LLVM for Rust 1.91.0 (and likely the upcoming
> 1.91.1) is 21.1.2 from what I can see, not 21.1.3 in the table.

Ah, I think that probably came from me looking at the tip of
rustc/21.1-2025-08-01 in https://github.com/rust-lang/llvm-project and
assuming that is what rust 1.91.0 shipped with but I forgot that 'rustc
--version --verbose' will show me that :)

If 1.91.1 is coming soon, I will wait to fix this until then.

Cheers,
Nathan

