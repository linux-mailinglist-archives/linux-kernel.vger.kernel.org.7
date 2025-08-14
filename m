Return-Path: <linux-kernel+bounces-767972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244F6B25B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2183B84CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36BA2264B1;
	Thu, 14 Aug 2025 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RB9EXGPY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3DE1DE4F6;
	Thu, 14 Aug 2025 05:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150950; cv=none; b=BqWPL00T2EFk6GTIJtCjpdjQeQLoHKSc1fEYLKB8ITbzNhIiPAAiY01BExflyUj8xQayHhvsUv0cDoq1FOAwHbdXA4oT+INRdcjPww5Y6qfXpueEM4K8m1cjuoklVnTqPT78nCpYvbh1GbTGulEvhznWrpnQbVN9lT87aEeklME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150950; c=relaxed/simple;
	bh=epSLKE+81yx2bqgLT97GRaHzH4spHuRzyCMTHW14WX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2xKyOhcZcQvINvf2wLsUSAecI3XoGeJrzxRkkKhWnjmpcIeKx4rG5e2+L0wt/p41DrZ3b18mHbofoWPApRE+0Bm2hshoOa/p4JrNfYLwSqXKPGdYw7qp7re5PV+hpRcEblgiwf/hPpmp0SC3NZ60CKsX/wAgHGnZeQ04FZC2OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RB9EXGPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10955C4CEEF;
	Thu, 14 Aug 2025 05:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755150949;
	bh=epSLKE+81yx2bqgLT97GRaHzH4spHuRzyCMTHW14WX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RB9EXGPYRdeGETXqTidkjThZqO+y52y1fNGxG6+UgZwZKoOy2Fm3KsOk3ZKUghj/H
	 h4IJmkOG8W4woH6CkgLOzDUC+7fadQ9xzqEdQcIAjGfX4vRvtjM8QBN9pdh9zXKH+l
	 OHGT9aqnLLBOvDXyzgocDhHD4mRcOD3kK0yjTdto=
Date: Thu, 14 Aug 2025 07:55:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Areej <areejhamid8560@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Xiangfei Ding <dingxiangfei2009@gmail.com>
Subject: Re: [PATCH] rust: lib: add if_cfg! macro for conditional compilation
Message-ID: <2025081411-skimming-roundworm-dc2b@gregkh>
References: <20250813203826.3145553-1-areejhamid8560@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813203826.3145553-1-areejhamid8560@gmail.com>

On Thu, Aug 14, 2025 at 01:38:26AM +0500, Areej wrote:
> Add a new if_cfg! macro to simplify conditional compilation using
> cfg attributes. This macro expands to paired #[cfg(cond)] and 
> #[cfg(not(cond))] blocks, allowing compile-time selection between 
> code branches in both expression and statement contexts.

Nit, trailing whitespace in your text :(

> 
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1183
> Signed-off-by: Areej Hamid <areejhamid8560@gmail.com>

 From: line does not match up with this text :(

thanks,

greg k-h

