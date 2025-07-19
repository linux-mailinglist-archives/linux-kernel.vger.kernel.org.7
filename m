Return-Path: <linux-kernel+bounces-737628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BD7B0AE96
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 10:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56D41AA72C7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 08:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B21235057;
	Sat, 19 Jul 2025 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dKH+CVHu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AB31DE3D6;
	Sat, 19 Jul 2025 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752912787; cv=none; b=N05/4BW4dpRscVwHSDrT7FdRbXMm+mZiDKnvBOIY6lJ3bm0dqVyx/sEACSWs3Nb4s0hC5/sc6a1Pwbyk/dAJo6TdOtO3OeXSZ5+od1tIgx53iCkLimp4SKxRgswDzPVuuCzpU/TqPD5tQuwnv4aF9OFRkBo3gSVJufL3ugp2iL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752912787; c=relaxed/simple;
	bh=6llgpNRlWD1HbICRpb1DHBgat6FAFKBqNPw7t1Kqkjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8IFzpFhwDob+Y7UlWcciwuMC4124Ya4/H8bdBGIV384vaof6t6KIRsHpMWoa4Frj/Mww+knOw8dRxxaFraekrWPh9HcLEvrgX7HSNqFzmCJm1kHqnbdtu2fCyagFMos6aEuTBLWFR75gRSFNkxLokqWyNxHkAtFzfIz9WK3RMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dKH+CVHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D19C4CEE3;
	Sat, 19 Jul 2025 08:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752912786;
	bh=6llgpNRlWD1HbICRpb1DHBgat6FAFKBqNPw7t1Kqkjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKH+CVHuU9STrKNwuvfKeXl3KIEMZNprsuVKoJFuwQG6Vq7GtRmgPu9En36im2EZD
	 HNOrw2u9TWn2xh+naOpjJ04yQFmoAZ3jBDG23UI0uyzJN9PXV96ijEfg4O09DGTXuz
	 Sp9B2PGLAZDqP3p7gMv6GO1OtPTNrwrCoJ720Eaw=
Date: Sat, 19 Jul 2025 10:01:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Fiona Behrens <me@kloenk.dev>
Subject: Re: [PATCH v15 0/3] rust: platform: add Io support
Message-ID: <2025071913-coach-prior-d71e@gregkh>
References: <20250717-topics-tyr-platform_iomem-v15-0-beca780b77e3@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717-topics-tyr-platform_iomem-v15-0-beca780b77e3@collabora.com>

On Thu, Jul 17, 2025 at 12:55:21PM -0300, Daniel Almeida wrote:
> ---
> Daniel Almeida (3):
>       rust: io: add resource abstraction
>       rust: io: mem: add a generic iomem abstraction
>       rust: platform: add resource accessors
> 
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/io.c               |  41 ++++++
>  rust/kernel/io.rs               |   5 +
>  rust/kernel/io/mem.rs           | 283 ++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/io/resource.rs      | 229 ++++++++++++++++++++++++++++++++
>  rust/kernel/platform.rs         |  60 ++++++++-
>  6 files changed, 618 insertions(+), 1 deletion(-)

Who is going to be responsible for the new files you have added?

And no real objection, but no copyright info was added to them either,
was that intentional?  I know some companies frown on that as it goes
against their corporate policy (but some don't care, it's hard to keep
track of who likes what at times...)

thanks,

greg k-h

