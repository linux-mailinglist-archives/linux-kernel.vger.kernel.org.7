Return-Path: <linux-kernel+bounces-863327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C80F2BF7919
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08DC64F71B6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452BC3451AD;
	Tue, 21 Oct 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6neV8lq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1C4265CBE;
	Tue, 21 Oct 2025 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062565; cv=none; b=oor3H+lJlKALOkOKek0Hv+FVFvZpYY12OZYbFtbGWQ0wP4aRoq6ra5i0zSxrR13YyaKVBVX7T1y3JaV9Sdj6Ojn+dwIT3jk5S3TRP4pdB3m9rCf/fwn6OPdsd31z1Duf9LaZL+/+/jXnfWd+IaX7VgwSySpwk2M5oGqsh7mlFcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062565; c=relaxed/simple;
	bh=l2aeHL1a3r8akGGXuumo6V4s/qnN5GJQkkV91RpEBHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DMH0mN9Brk9Jnou3ZDLSZx6kmz6KWyH7LqSXo+uPlLnRXvjMgAH/N6tmGaN8ysNj8oae5fSBbDfDo4GMeZJsfVfrt8jl8q72leA8KZmBljXzW/hSrw7JVPfJQpXCS3bnzG22Hn2wLnGaLVnJtpqsd+G3714UzR1AFrHHRqu5gIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6neV8lq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9639AC4CEF1;
	Tue, 21 Oct 2025 16:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761062565;
	bh=l2aeHL1a3r8akGGXuumo6V4s/qnN5GJQkkV91RpEBHo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V6neV8lqKxsIQVsRaJyRWINv+4qnDvZkvPpSysBefxmtjY2dUWFj5WuVbI45jbvEz
	 yCfKtMgmmRgA7ZT3p8jwwWAdixmefklTFJjb08u24Uy/v56JqmHbxNyeYlr5HEo6OI
	 Q3BKpga0HC5UWzVntlMlghAj5L3J1gWldHirf3FSQ6ZAA6f37Dvo11lx4uBfvKRkU7
	 4NeAU/P1eRzxiynqjVNsHYjF9dA+iRQK0hWI68ixk1rrCHhrpQ2Fwm3ke+lKK6IV2q
	 SKVg9ICekHq18cNAZyDBx4GdfRqBtaaPFZQtrtIHwTNMICC3euf5BHbzDDDpSIpgIj
	 SdEDj/Y5Zjs2g==
Message-ID: <a5cca6ca-9147-4531-81d8-05af1333848b@kernel.org>
Date: Tue, 21 Oct 2025 18:02:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rust: Add read_poll_count_atomic function
To: Alice Ryhl <aliceryhl@google.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
 daniel.almeida@collabora.com, a.hindborg@kernel.org, alex.gaynor@gmail.com,
 ojeda@kernel.org, anna-maria@linutronix.de, bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com, frederic@kernel.org, gary@garyguo.net,
 jstultz@google.com, linux-kernel@vger.kernel.org, lossin@kernel.org,
 lyude@redhat.com, rust-for-linux@vger.kernel.org, sboyd@kernel.org,
 tglx@linutronix.de, tmgross@umich.edu
References: <20251021071146.2357069-1-fujita.tomonori@gmail.com>
 <20251021071146.2357069-3-fujita.tomonori@gmail.com>
 <DDO06754OMN5.G0AN9OCWTFLW@kernel.org> <aPeTFMeVoIuo8Lur@google.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <aPeTFMeVoIuo8Lur@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/25 4:05 PM, Alice Ryhl wrote:
> On Tue, Oct 21, 2025 at 02:35:34PM +0200, Danilo Krummrich wrote:
>> Please replace the match statement with map().
>>
>> 	read_poll_count_atomic(
>> 	    ...
>> 	)
>> 	.map(|_| ())
>>
> 
> IMO, this should instead be:
> 
> 	read_poll_count_atomic(
> 	    ...
> 	)?
> 	Ok(())

I think map() has the advantage that it is a bit more explicit about the fact
that the return value is discarded intentionally.

But I'm fine with either version.

