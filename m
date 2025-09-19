Return-Path: <linux-kernel+bounces-824154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E7EB8841B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BC6A7BDAB9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B610F2C15AF;
	Fri, 19 Sep 2025 07:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uaEufAvL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1108C28DB54;
	Fri, 19 Sep 2025 07:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267738; cv=none; b=jpDZC+VgD5EhhzMlkiUaF9b7Yuy9lanaPeI55KPAIiZgvZApObtwA3kNWFVGNtq+zdgdRSkAWdiRMM1XFdg/puPL4XZWAvN4b/RyJsVW8EK6TEaD0v3JfbSR1IOPhTi+XIoTrOgtRiy7Q48hVvqTfCIGkhf1gR/AQTCAay7Itx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267738; c=relaxed/simple;
	bh=AP3suinvPVLF7jLQXI4kA0vIsUqXIGv5ptuGsCCbyC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itcJvBxNVyMUOEdssS06l2yYi6VphhiZNFDIuc0w5efifUNiqOqcIV/DYYsj0oZc6GIhvihPt2PnJUEYUpJgkd09zPLfqmr2uAQ6M5oNjucNSSu0NcT83KalI9WlwT0z6iaIZ3ckXV0/T5UhKczDANlpRt8++CC+j1ir1JtKcK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uaEufAvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF188C4CEF0;
	Fri, 19 Sep 2025 07:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758267736;
	bh=AP3suinvPVLF7jLQXI4kA0vIsUqXIGv5ptuGsCCbyC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uaEufAvLcRGJYXBCB8ceNTFfgIQtiluFbtRT8SVLU36+hK9rrdYh2HV79bx1kdV1V
	 RqVKUVMdK5SbBP3NYN4aSd8E35Cm+Hz7SplMJ8eyQS/eN11GOhiRxghkAhrLecbjn5
	 AKYIHrZfu22xnqjGLfnnzTjoN2AWZtT8orOkkv8M=
Date: Fri, 19 Sep 2025 09:42:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Matt Gilbride <mattgilbride@google.com>
Subject: Re: [PATCH v2] rust_binder: add Rust Binder driver
Message-ID: <2025091904-widely-pregnant-1448@gregkh>
References: <20250919-rust-binder-v2-1-a384b09f28dd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-rust-binder-v2-1-a384b09f28dd@google.com>

On Fri, Sep 19, 2025 at 06:42:07AM +0000, Alice Ryhl wrote:
> Please see the attached link to the original RFC for motivation.
> 
> I did not include all of the tracepoints as I felt that the mechansim
> for making C access fields of Rust structs should be discussed on list
> separately. I also did not include the support for building Rust Binder
> as a module since that requires exporting a bunch of additional symbols
> on the C side.

I used most of the original RFC submission for the changelog text when
applying this to the char-misc tree as this isn't really a valid
changelog, but rather a "what has changed from before" type of text.

Anyway, great work, nice to see this finally land, let the A/B testing
begin!

greg k-h

