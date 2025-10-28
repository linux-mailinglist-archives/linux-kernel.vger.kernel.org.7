Return-Path: <linux-kernel+bounces-874573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C0CC169B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AABB84E1485
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E95334F481;
	Tue, 28 Oct 2025 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvbXIFFU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D125033CEA7;
	Tue, 28 Oct 2025 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679619; cv=none; b=bjfdljy6Gbgg+agV9NoKu4UhKYFh3OBFe5TDt7LIgqGR29dfcKGiCMVAWbK1gKArAjKiUYprzfJ74/iILnxbBWivEgWmzYh2+4uhCkxdLKL5EASdLenaVJofywrLh29k0Aru1JdNxloBmzhFFqvttICH+a3a01BOq7rhu0Oe7ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679619; c=relaxed/simple;
	bh=W5l+ab68yytFDDqxgiQTe2mOEzh1UbDIZVUX4z6Q76s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d/qyJwQcCIjCnejVEg5GMB0dKZK5u1h3YroX00zIvRUTYgPB4ratYnvmzU0XWQFhBHhPCNKOHQea13GC902+BsfD3IzOwB0ZQfay05y7Owt2zNXk2WJf8aj8dIAyioP0TJ4GPqHJkDRvAVd4nX+njYFk/ykrqvP2TX+qCqOZTFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvbXIFFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EC7C4CEE7;
	Tue, 28 Oct 2025 19:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761679619;
	bh=W5l+ab68yytFDDqxgiQTe2mOEzh1UbDIZVUX4z6Q76s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qvbXIFFUDaOCfVlJL9+2CIfDZ67pAoQqyuiXmgl7bQlfgqi4TWaL59+ln1CFK1iSd
	 OOAxVusiuOJVScJlAD8jXWyaraefOQ+GOcMwNcTH+xvTFgasCHAH/Yp8p8B5x2uAFg
	 2cisgmnOu/Uh8RLngVFoUR4irs7KzvgavFmTZA0yGTi2H4Hj7zT1Sn14pUmqG9HrX5
	 c3LJyozCRGvtTZRZTfZSyb0ZTefVUEaQAP7jDSCjteI2daP21fL4+kELswUQAQwPdr
	 z+zVpIKkn439br0PT5+s1la62CGo0FDsMSoeiOKMaC+Z89Ct+H5hY59/Bh28pWA5w6
	 /UJtSVe2NW6og==
Message-ID: <2b2e5f31-e685-4a28-ae15-f620310d509b@kernel.org>
Date: Tue, 28 Oct 2025 20:26:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] rust: bitmap: add BitmapVec::new_inline()
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yury Norov <yury.norov@gmail.com>, =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?=
 <arve@android.com>, Todd Kjos <tkjos@android.com>,
 Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>,
 Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251028-binder-bitmap-v3-0-32822d4b3207@google.com>
 <20251028-binder-bitmap-v3-2-32822d4b3207@google.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251028-binder-bitmap-v3-2-32822d4b3207@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/25 11:55 AM, Alice Ryhl wrote:
> This constructor is useful when you just want to create a BitmapVec
> without allocating but don't care how large it is.
> 
> Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> Reviewed-by: Burak Emir <bqe@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

