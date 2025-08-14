Return-Path: <linux-kernel+bounces-768249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B26B4B25EDB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565351C87782
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A882E7BCC;
	Thu, 14 Aug 2025 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZVWo0dg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510752580D7;
	Thu, 14 Aug 2025 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160111; cv=none; b=Stw2wq2yADDY8RravKR2nTo7cN/lDyp7AVoH87pOi7TvMAIqyjas0NiNDXzp2dngfssskHiysrIJPwfsA7YE64KtL2aNJMWh8fpE5d3eFS5csMnUaEAouaQcub0uTVO1COh9vwo4bfLdcZkuy0i7ufTHMgqvcVcOHKXnicO3Cp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160111; c=relaxed/simple;
	bh=ciJd1n2DPoSoC6rfnWbnvNN4xgBsSfqT2aex2mKyrU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5bI5PtgtscHa26Q47B03nlhIXgW7eUuNy1/BLn9nutS2IdzEBC5N/lFVelgOF7ALPw/0h6Rwww2GpVdPAxWKeaDlX+LTRXITGdWUwV3hQsuI9cyP1CVrAGazJMq5rIJTTZAauPPyQc8jVHlRxTa+8Ix5XdDxJyeZEaHKKWq14Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZVWo0dg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB5DC4CEEF;
	Thu, 14 Aug 2025 08:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755160110;
	bh=ciJd1n2DPoSoC6rfnWbnvNN4xgBsSfqT2aex2mKyrU4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bZVWo0dgRI8Ht6uxw1/7FugpjVR382NzxZ3qM53yTT5T81fbi2Z0asTu14Hxk+j3/
	 PSAWpmIBKwdnN6tip3d/DIXCb6IY8Vfv/j7y29zdFhZpC41ygCDLuBxySGhP8qwesp
	 LduVuTlki3UQaseXcbl4JS/EM7hxaqW+aXvoC6lCnCdTb468iKvuXd/KpvSXG9QXpb
	 lPeYbUysk7o8pdusqS0B//UWYIVZdYEeGgQPyxQuZBeZodSN95sr+5sX7hc71oX1/O
	 HjKlhZ9lNZUQHyM+Y3oNYHJBws69H3v1PLPfn4abVyOYYPEoZFC38eRxPdmxcJ/n7T
	 xesg1QyiyO2bA==
Message-ID: <5b68f042-c457-4ef5-a36d-d00fb431ad54@kernel.org>
Date: Thu, 14 Aug 2025 10:28:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: rust: add page.rs to MEMORY MANAGEMENT - RUST
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
 rust-for-linux@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250814075454.1596482-1-aliceryhl@google.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250814075454.1596482-1-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 9:54 AM, Alice Ryhl wrote:
> The page.rs file currently isn't included anywhere, and I think it's a
> good fit for the MEMORY MANAGEMENT - RUST entry. The file was originally
> added for use by Rust Binder, but I believe there is also work to use it
> in the upcoming scatterlist abstractions.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Acked-by: Danilo Krummrich <dakr@kernel.org>

