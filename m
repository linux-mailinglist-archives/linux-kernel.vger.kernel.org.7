Return-Path: <linux-kernel+bounces-802374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 685D5B451A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9423AD369
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BC42750FA;
	Fri,  5 Sep 2025 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjaSOKJX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593131A9FB3;
	Fri,  5 Sep 2025 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061420; cv=none; b=KScf4caagBTs2rl/KEDBc8K3JQoY1FmG0wV8MhokmdJWXgUm7tsR6tVzwviQeCx/C7OBfhlRMwl8L2CZvSdQlKqIRG3LLQSMKN17hOD4UDPhsSAZCAJtSlW70qc95ePLwnLxT5435eWnJ/Z+yEIDbz4PWpVZO1diS2NIbkBFZ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061420; c=relaxed/simple;
	bh=6qT177DHCMOTTlEfa1oTPoJo5vWIKMIvZyKmuaGXpOc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=htK+Gmdj9Fev75WHWHpWEY2kslMHAb6TGGRlm7OjSl/AmzFcByprTFLM2H3ewTHlm2esNW1JhYZTbh1KgdxPI7TULmeQBj+97jGA4F6DaewGdgoCZ/6GpWAt0HK8+aZMSJAkbIIZjNQ/+FEBx7kaBiwv/L0+h+2iV34YDo8BRd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjaSOKJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4894C4CEF1;
	Fri,  5 Sep 2025 08:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757061419;
	bh=6qT177DHCMOTTlEfa1oTPoJo5vWIKMIvZyKmuaGXpOc=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=NjaSOKJXD+eNX8jOL1raaeAGvAxnpRS3q4p1oWEBQ9yCj11rRzOJ9FafDNSNT488k
	 x5UZyKsDjdXCLMuPFbZKiBkpzYh2h6Kho4jrUMri0vrU7ssfeAqhtRQlkSG5LiNqf4
	 p+z6M98sM1YMsiOTr9C5p9Af5haRqf3ug8iiRlnFEytPZz/HuaccLx28zKUUQaxfYT
	 JAF4T1cG5Mx0HhJCBcy+b4Ex4zPb9ars5DVGW/kAiceO7VtBtP4zdRESXYIoXxUVPj
	 V3Y0+VQ5y8qNnpYqIsXy3IvAjpqgnOIuB7i+NAmAxnvrJhLzDmj8ZMwzUiNiIUXl2P
	 Tx4Q9rWr7QKlg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Sep 2025 10:36:56 +0200
Message-Id: <DCKQAFNGN8A4.S1VATI4JNP8N@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Linux Kernel Mailing List"
 <linux-kernel@vger.kernel.org>, "Linux Next Mailing List"
 <linux-next@vger.kernel.org>, "Vitaly Wool" <vitaly.wool@konsulko.se>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: linux-next: manual merge of the drm-rust tree with the
 mm-unstable tree
References: <20250905125139.109081b2@canb.auug.org.au>
In-Reply-To: <20250905125139.109081b2@canb.auug.org.au>

On Fri Sep 5, 2025 at 4:51 AM CEST, Stephen Rothwell wrote:
> diff --cc rust/kernel/alloc/allocator.rs
> index b561e7a57bb8,90e03ad15760..000000000000
> --- a/rust/kernel/alloc/allocator.rs
> +++ b/rust/kernel/alloc/allocator.rs
> @@@ -13,8 -13,13 +13,12 @@@ use core::alloc::Layout
>   use core::ptr;
>   use core::ptr::NonNull;
>  =20
>  -use crate::alloc::{AllocError, Allocator};
>  +use crate::alloc::{AllocError, Allocator, NumaNode};
>   use crate::bindings;
> + use crate::page;
>  -use crate::pr_warn;
> +=20
> + mod iter;
> + pub use self::iter::VmallocPageIter;
>  =20
>   /// The contiguous kernel allocator.
>   ///

Looks good, thanks!

