Return-Path: <linux-kernel+bounces-808129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 536BEB4FA10
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 092BE4E2C70
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9C33375A5;
	Tue,  9 Sep 2025 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tMr2axex"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C4D32F775;
	Tue,  9 Sep 2025 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420060; cv=none; b=ABwRLwkTNkn/t8o3qDxYNKoJiAoTnzUF0E5Wy6SayN9s2/ZAzVBuc1gvME2b+25icVkiN9KtLHQ0xBt5HUM9uu7F5G/ZfaePr6Tq9aWjO7SQeTFWRoqbGNFc/0Pc68j45kaVgY3ImKmVgg8EbS9CXBuqKKuc5K8M71J1lh/VnOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420060; c=relaxed/simple;
	bh=nfO6Qip4wT2nqsDYDR/PKlg64uG9rndsPou4q5q7/AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ve8asKqQ9ZUwXTgHfiu4nKANNDvg05OoPsxRqNnn2ittlow5ce/nA1qgGaVn7btP0AX+JjixCoFNlBo2ufe4Un7FazM1O8b2YTaUYJjpUx42kEzC6g3pjImFBNdLdOrfGfroASlLlQOLGJY0XknPRtc51FD4CGwp3ojJDbQKAV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tMr2axex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA92C4CEF7;
	Tue,  9 Sep 2025 12:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757420059;
	bh=nfO6Qip4wT2nqsDYDR/PKlg64uG9rndsPou4q5q7/AM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tMr2axexlrFj5gL9A5wx0Pm7Zq/Y5C2R915B/D1ID5hwZs1w5i55e/R1gqXyDFoKa
	 aEdpr+MCr+XI+VwdTGdvIzXtoaB0zx4kSNQ1i+Set8uNLjFS24RS9FTTGXQQpco5OB
	 nOD/LoJaq3ADDiRQO8QYtOQKbBjMqrXkRjlZFabc=
Date: Tue, 9 Sep 2025 14:14:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Simon Neuenhausen <simon.neuenhausen@rwth-aachen.de>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Igor Korotin <igor.korotin.linux@gmail.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/2] samples: rust: add a USB driver sample
Message-ID: <2025090916-dill-elated-3d68@gregkh>
References: <20250825-b4-usb-v1-2-7aa024de7ae8@collabora.com>
 <2025090618-smudgy-cringing-a7a4@gregkh>
 <D8EAF874-4FED-42EE-8FD8-E89B6CB0086A@collabora.com>
 <2025090601-iron-glitter-c77d@gregkh>
 <831C4AE2-6964-4699-9E74-E4B721B87B17@collabora.com>
 <DCLQZZHU42HN.4Y4PP0PPR10O@kernel.org>
 <9657C897-087E-4544-849B-964E99D95A50@collabora.com>
 <DCLTJMIAMCVL.35U236MMS5CCK@kernel.org>
 <85B643A9-1657-43ED-BE98-BE7E502D08DA@collabora.com>
 <3aca9e74-b67c-4bfe-a206-9a6eecdf76ab@rwth-aachen.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3aca9e74-b67c-4bfe-a206-9a6eecdf76ab@rwth-aachen.de>

On Tue, Sep 09, 2025 at 01:19:12PM +0200, Simon Neuenhausen wrote:
> Hi,
> 
> > On 06.09.25 17:46, Daniel Almeida wrote:
> 
> > As I said to Greg above, I’m here to help if anyone wants to write a USB
> > driver. Those interested
> are free to reach out to me and we will work together to merge the required
> abstractions with a real user in mind. Hopefully this encourages others to
> join in this work :)
> I had planned on writing a USB driver for TI nspire calculators, that would
> make them mountable as USB mass storage devices, since they use a
> proprietary USB protocol, that usually requires paid software from TI. At
> the time I gave up on that, due to the lack of USB support in RFL, but I
> could revive the effort using this.

usb-storage is really just SCSI, so if you want to try to do this, you
are going to have to write a scsi driver for the calculator.  Not
something you probably really want to do :(

Odd are this would be a much simpler userspace program instead, as you
can control USB devices directly from userspace, no kernel driver
needed.

thanks,

greg k-h

