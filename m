Return-Path: <linux-kernel+bounces-773815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82286B2AAD4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1165721880
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF4632255F;
	Mon, 18 Aug 2025 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u7DY+c2a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC7B32254C;
	Mon, 18 Aug 2025 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526730; cv=none; b=NntUoVAZoRmmUyVWtuHfLVdnVp4VfkmGrEvhsIrpcaWPS4DM8k6jPhnOBckJo+kVaU2DGSTqkn11WQRvarUyRvpj1DMmETBLRIO5Go6DhB2HJoA0bCvj88TTUX6mN4AmbNAWuEzyXy2oRHunTrU8NM10SlQckEISmWRqI6VsNi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526730; c=relaxed/simple;
	bh=ZxMFrqapvJ/C17PrCsjyTGRw+DxEIi+3UaqaeIQKDJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiZAhZAs2/hPxyPcsOXPkfmJRzvxqtGcY/YhIu2mwmY57dqHFy7Gq8pYxS4YqrrxZJx+e1fyitr+uJllOcAKqFJTlLhYn++Y2DQzV3LoP8/3JnRjwAVvDvE9Ovapp4ANyBJl4XmnKo6LrghUQBXxyxpXckZczRLw4AQifMZcM+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u7DY+c2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A886C4CEEB;
	Mon, 18 Aug 2025 14:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755526730;
	bh=ZxMFrqapvJ/C17PrCsjyTGRw+DxEIi+3UaqaeIQKDJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u7DY+c2aJpG9QTUCMtq5dyWRbJV5FzF3n5+sv278J3+rsGaDFLBhpsns06A9Hyz1/
	 LB67UxWQsZmCuHKIBN40TXv0TecesdsiTqo936wkJCHFYK/urqVoPgQpq5O5dFwa8I
	 TbxStWH2Peq26emSvQLVyxVUQEmZwNEhvsy/uI5E=
Date: Mon, 18 Aug 2025 16:18:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: arnd@arndb.de, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, lee@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rust-next 0/2] Add llseek support to miscdevice and
 samples
Message-ID: <2025081818-presume-coral-25c3@gregkh>
References: <20250818135846.133722-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818135846.133722-1-ryasuoka@redhat.com>

On Mon, Aug 18, 2025 at 10:58:37PM +0900, Ryosuke Yasuoka wrote:
> This patch series introduces support for the llseek file operation to
> the Rust miscdevice abstraction.
> 
> The first patch, rust: miscdevice: add llseek support, extends the
> MiscDevice trait with a new llseek method.
> 
> The second patch, rust: samples: miscdevice: add lseek samples, add a
> simple example of how to use the new llseek feature. As currently the
> MiscDevice trait does not support any read/write file operation yet, the
> sample is fundamental one.

As read/write isn't there yet, why is llseek needed just yet?

thanks,

greg k-h

