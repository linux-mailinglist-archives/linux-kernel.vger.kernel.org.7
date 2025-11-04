Return-Path: <linux-kernel+bounces-885121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA50C320B9
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118793AE84F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31D23321A3;
	Tue,  4 Nov 2025 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbNjF9eV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C7F32E75C;
	Tue,  4 Nov 2025 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273516; cv=none; b=TF/FivPoHmBpYGADuhlYuPIrEhWiREnGUFz7RdVMSOV0/vHWNtSRhZxivdd3Es2Oujb3npcANzmJ9pr4gS9BqVux8XxjoCkpm+f9JeWi1LT2nMtxx1nwm016twV4t+4+BBWH+r/grJkS15dYd+ejTPY3MBd/A4fghmCnjmvxdDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273516; c=relaxed/simple;
	bh=tAiutw7QyVOLkovCeBu+3Zkhw2VrdttxcSae04A3Sh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ryG9yp+mN4eaVRIn3ZmhNVBU4zNIA6eJkaDBHAPwjIkbs5zOup1sd+ftLXutAKs1XeC9bgvSmYaSBcBsKGnllSyA2twibSQTSnmAsX0UDWCeNYZ9bZQP8wWcRMtifPkKDyW3uHVPR3jNDNiOkAfbNHk78GoLAoX169itknAAaOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbNjF9eV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8731EC4CEF7;
	Tue,  4 Nov 2025 16:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762273515;
	bh=tAiutw7QyVOLkovCeBu+3Zkhw2VrdttxcSae04A3Sh0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WbNjF9eVB6Y2bd3lgvzRyXCUqVKvUXdWSxIJ4c6SLYm8LZzLdv65sCLfJngT5uVcW
	 mwCC8zzVl2lfehhcYenre74vCPzfWj6D6jeYx44Lx/lTfFjYE/b9tdg3I7DIrXcpAh
	 bqU89kGqQzef+nksdZuXMBx05z/zoVqC4wZTASJOkPC0ZMhB/wM0xU0pkPNXRASEtZ
	 +y5QRVpkq7hzYNHMkZZgKyWG5fhYHdekCZTaVNUgpLedpKPgQimN3p+kbLtM4vyIuB
	 1i2CwBiNWSQHnNo+roeP4F6uQRZgN7gzQihqEcXhQcjgPqJaD+VfWyn/3x8Hpr7Mcj
	 3D9fYK1BSA3LA==
Message-ID: <39df4761-d843-4942-9f00-a44fc8436e80@kernel.org>
Date: Tue, 4 Nov 2025 17:25:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: io: cleanup imports and use "kernel vertical" style
To: aliceryhl@google.com
Cc: daniel.almeida@collabora.com, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251104133301.59402-1-dakr@kernel.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251104133301.59402-1-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 2:32 PM, Danilo Krummrich wrote:
> diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
> index ebc29023d59d..e21ccf98b81a 100644
> --- a/rust/kernel/io/poll.rs
> +++ b/rust/kernel/io/poll.rs
> @@ -5,7 +5,10 @@
>  //! C header: [`include/linux/iopoll.h`](srctree/include/linux/iopoll.h).
>  
>  use crate::{
> -    error::{code::*, Result},
> +    error::{
> +        code::*,
> +        Result, //
> +    },
>      processor::cpu_relax,
>      task::might_sleep,
>      time::{

Should instead be:

diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
index ebc29023d59d..b1a2570364f4 100644
--- a/rust/kernel/io/poll.rs
+++ b/rust/kernel/io/poll.rs
@@ -5,7 +5,7 @@
 //! C header: [`include/linux/iopoll.h`](srctree/include/linux/iopoll.h).

 use crate::{
-    error::{code::*, Result},
+    prelude::*,
     processor::cpu_relax,
     task::might_sleep,
     time::{

