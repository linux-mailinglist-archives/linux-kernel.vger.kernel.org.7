Return-Path: <linux-kernel+bounces-701830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C23FAE79F3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 10:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69CF617CDDF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 08:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B7C20F076;
	Wed, 25 Jun 2025 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpzJCuVj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E88315A86B;
	Wed, 25 Jun 2025 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750839774; cv=none; b=AuxUjAnf3Tsz91JG9x81COXa8oexlKY++Bs4ymOrfbzLQdSPJa4PkEO5LEGW/aNr0qw8OuoqGbpAfP6IgRjhOLsHgbhIDA/ZjACnLmvTcaKYwNEv00qSsYMNO5KmBfo0OjRcZE5LQ9J7mkKtpS6lRKdbOjWSLvKjI2wVFiZHqZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750839774; c=relaxed/simple;
	bh=tIEPKsgyCiJDZnmB5TwqXpJh0DvYnKM9P7CqrUT5YE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAsYrA4u8SgAll8S9ioQIcObWIXxUrd2syk1OdwLmn/4ZVhut/N7GgoKGByMw5Y1nAoS4IDpQV4371/rudDJWSXcqfZaFHF7A5aguT1dzOuoouietSEXqPp5vzSW59cE/ZGcLSCAYOmZ8S3yRH/BuBRM+Ck3Jq8neehntg6II/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpzJCuVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78ADC4CEEA;
	Wed, 25 Jun 2025 08:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750839773;
	bh=tIEPKsgyCiJDZnmB5TwqXpJh0DvYnKM9P7CqrUT5YE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fpzJCuVjD8fkCqRizs5ZyAIrY2eYeR44DaW3V12kKsjIL1xxvcvOU3j2EoFWv792v
	 yld/o3MXr3dN6Qj6nJnrfTbaxyA3lHIUdnhusKy3t+GxfKWRvYO57QnXAFXsodbdom
	 Q9i9ACWllzo+RDM0+RgxA7XfzkZ+gQM8gJFDogARk9S8oISBGSHvR2tErsV2//UVVs
	 bzPhXTbtfNTPgbvTrqdzSHdfB4pXjetI+9PGCQCVNh/x5ZfTZCI8s0vbrwFVdKvmwv
	 SgG/rBsk0/NBkLyuEQGTx4+UqcZXRfqmjFzANQj4gV14M01h+0fbhBuh1zf2XVmcAT
	 hUrk+bzQNqh8w==
Date: Wed, 25 Jun 2025 10:22:48 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu
Subject: Re: [PATCH] rust: simplify `Adapter::id_info`
Message-ID: <aFux2MUDAGEYY49I@pollux>
References: <20250625043630.7677-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250625043630.7677-1-work@onurozkan.dev>

On Wed, Jun 25, 2025 at 07:36:30AM +0300, Onur Özkan wrote:
> It was obviously unnecessary to check if `id` is `Some`.
> 
> Signed-off-by: Onur Özkan <work@onurozkan.dev>
> ---
>  rust/kernel/driver.rs | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> index ec9166cedfa7..1036755cb27d 100644
> --- a/rust/kernel/driver.rs
> +++ b/rust/kernel/driver.rs
> @@ -178,11 +178,6 @@ fn of_id_info(_dev: &device::Device) -> Option<&'static Self::IdInfo> {
>      /// If this returns `None`, it means that there is no match in any of the ID tables directly
>      /// associated with a [`device::Device`].
>      fn id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
> -        let id = Self::of_id_info(dev);
> -        if id.is_some() {
> -            return id;
> -        }
> -
> -        None

This was intentional, since I anticipated we'll get [1] eventually. :)

[1] https://lore.kernel.org/lkml/20250620153914.295679-1-igor.korotin.linux@gmail.com/

> +        Self::of_id_info(dev)
>      }
>  }
> --
> 2.50.0
> 

