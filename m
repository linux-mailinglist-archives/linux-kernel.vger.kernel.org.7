Return-Path: <linux-kernel+bounces-829169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFF7B96667
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4F1D7A37DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFAB2566D3;
	Tue, 23 Sep 2025 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gQA8iklm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC1A23A984;
	Tue, 23 Sep 2025 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638968; cv=none; b=PVTmc+wEkOtC+1j+Vz8SCdqSiwbI/cpVt2jCMwUdcNO2niNlFt2OQiT8c+nipnQtCbuDvd/QBDfQ5qqe1YIRlvVKnH7540LG2EgntjzubT00YCRFjWwDfMiK5y34S/ZIL8eP+S317tUovMLLUTQH3tA07+Moep+hBD84Ubkj4VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638968; c=relaxed/simple;
	bh=RadlGg6GK6lOLaxKls8ButZDQZ3UipZGGdw7puZys9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWJjLSgJ6/A8SpGyYs0/8JlpDk+oqU64XaULYbJgVirhUhRu5WsnQtoHb9ViQrCfNoH3HmZAnXkl2cjk7hhO3O8QYIrA5YMOuoGzBhghuMtis8XjfZqg1xoJ+uZqncUZRm7HsvxdCMw/4ax2AuOadOTymR0pZ6kSKAcOgw1H0TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gQA8iklm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA17C16AAE;
	Tue, 23 Sep 2025 14:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758638967;
	bh=RadlGg6GK6lOLaxKls8ButZDQZ3UipZGGdw7puZys9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQA8iklm/odPpWWXPHhMaMpYZHYUUWh2fnpPeSD/P8BIgFmhIMP5E5jU++dxzzL/k
	 wj/L7ZeouzCmAvz7bGK6emBwvSFAMuoI66bOjDCj4PDlupoOcO/FWINd6H5SNtCyHp
	 m54E1VZj8monlSecfkXyGJZXRPBHZA0ftwuoJmNw=
Date: Tue, 23 Sep 2025 16:49:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: usb: add basic USB abstractions
Message-ID: <2025092303-squeeze-reformed-11ee@gregkh>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-1-7aa024de7ae8@collabora.com>
 <DD07LUJXNZN9.3RHH9NJNRFVNN@kernel.org>
 <2025092356-rounding-eligibly-c4b7@gregkh>
 <f5a802a4-ac9b-4b45-8d1c-871e2e06d7ac@suse.com>
 <2025092307-scoop-challenge-4054@gregkh>
 <13ce0ad0-f0d5-4579-9a48-db727baa177f@kernel.org>
 <2025092356-glorious-unbundle-58f6@gregkh>
 <9995561f-7157-489d-b48e-fe6c92e1f408@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9995561f-7157-489d-b48e-fe6c92e1f408@kernel.org>

On Tue, Sep 23, 2025 at 04:42:11PM +0200, Danilo Krummrich wrote:
> On 9/23/25 4:37 PM, Greg Kroah-Hartman wrote:
> > Yes, you are right, it can be gotten that way.  But I can't wait to see
> > how you wrap that C macro in rust :)
> 
> We can either create a Rust helper function for it, or just re-implement it; in
> the end it boils down to just a container_of() on the parent device.

Yes, and it preserves the "const" of the pointer going into the function
call, can we do that in rust as well?

