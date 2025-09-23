Return-Path: <linux-kernel+bounces-829354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB46B96E03
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8486319C6814
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185072E2EF1;
	Tue, 23 Sep 2025 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBtwTcNq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700492727FD;
	Tue, 23 Sep 2025 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758646146; cv=none; b=BpeCpVjTnVzmOIe7wJEzw/PdKMGyYDFCs3TouM3yt4PnQr2yHE8IN1Xb6PPdYOHPFY5lTv+3LJvJL8FurZaXj/Cl18buJy4O/sSqfSjPRlmTPUIkbgOH6rUdlL0JbnhjPcYkvHC6wyveW7BFix5tXOyqcsMA51YvPSWfRsO0wJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758646146; c=relaxed/simple;
	bh=gQEI8w1XTDvCdl8F4VkYWyYgmtpvnXoMcNaTHHluqGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBymP7LU/5MzZT0MYQFjsVrQdglrZkNKODCrpu69ICocgjsMRm7+dgwyHQbMfaSXG5iTzOHamjKgpDk59v5J/c+XNm2viS0/LHQK0VTnfuTbzPoSxz4N+FpufFnSEym7oe2sjfM46aWtWMp534a6bkUbmiFz4y0K+6fQ1bVFsZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBtwTcNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BA9C113D0;
	Tue, 23 Sep 2025 16:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758646146;
	bh=gQEI8w1XTDvCdl8F4VkYWyYgmtpvnXoMcNaTHHluqGk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QBtwTcNqGj7x58cWF+SaqALNnAF/5pZ5Mv5xWwivlmcxSEJ+WjNlyYdEsy1vlj0En
	 75pwZMqYPt8hGYfafNsP2OOD5BTnTinBPmIvDMSKoA6VwcXKnz2EXXpcNWTaMaZonU
	 kLcOXZxDcgIrZx3LRzcOLIr6bk0YHTlrOfGC3P25ZI9A3Qyfkqr5fiSLHiecZddDl2
	 16sie1W3wPx6wIFA2vBIXnNqwY4JjWeZe6ilIejyN2jQjCoCIjCMK1iNoDDRS6sRef
	 Uh5gmRWK5iS/hnUdbGuQyQvKsIZGzvpD9kJJBmomD5GRGLBIU7fa9m1zX24YHVsp/j
	 qJuO2xi4MVVrw==
Message-ID: <22591ebe-c496-42e5-b2f8-9ca4f8fcaed5@kernel.org>
Date: Tue, 23 Sep 2025 18:49:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the rust tree with the driver-core
 tree
To: Mark Brown <broonie@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <aNLOhQyd0YmJnPco@finisterre.sirena.org.uk>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <aNLOhQyd0YmJnPco@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/25 6:44 PM, Mark Brown wrote:
> diff --cc rust/kernel/lib.rs
> index fa083aa44cd6f,f910a5ab80ba5..0000000000000
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@@ -17,8 -17,8 +17,9 @@@
>   // the unstable features in use.
>   //
>   // Stable since Rust 1.79.0.
> + #![feature(generic_nonzero)]
>   #![feature(inline_const)]
>  +#![feature(pointer_is_aligned)]
>   //
>   // Stable since Rust 1.81.0.
>   #![feature(lint_reasons)]

This hunk doesn't seem to be related to the driver-core tree.

> @@@ -115,7 -112,7 +117,8 @@@ pub mod pid_namespace
>   pub mod platform;
>   pub mod prelude;
>   pub mod print;
>  +pub mod processor;
> + pub mod ptr;
>   pub mod rbtree;
>   pub mod regulator;
>   pub mod revocable;

This one looks good, thanks!

