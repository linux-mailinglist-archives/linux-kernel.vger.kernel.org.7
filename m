Return-Path: <linux-kernel+bounces-770664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5CFB27D9B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61672A0019C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66362FCBF2;
	Fri, 15 Aug 2025 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bB5hfu78"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C14A185B67;
	Fri, 15 Aug 2025 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251850; cv=none; b=Um0FMvjBOLR/FsVCVaVOAyCNNLpRs72T2LIwUAbo7V9c11xOCM33ouS2Ca7wo7ByrWzk9ox4+jKNMeAn07nixmxPI+6kJyixsCanVIZbSewB3hncSQsobyiQewzyUZuTnMXi58PzhCD34NsJCqd8b/KkrLp/xExxMWNp4N3FB9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251850; c=relaxed/simple;
	bh=RgLFbY4jHkH/C9SvqiRlo8daIkl3Wuk3ugPbeyDWZS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cYLpxHav0+CqRLLf8bejTZjjGzvix1eDIZ2egfIU58r+0bsebPyEx3mG0MlySM0p9pUNjROn84AYZwv1psyJZxhB5CRNx7c52mvSwexaQoMJI3faSUmJqb4eFE1npEKEt3PFt9zPStuf6xQGrl/1GPgxyDmpCtislwbD350cIts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bB5hfu78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79AC5C4CEEB;
	Fri, 15 Aug 2025 09:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755251849;
	bh=RgLFbY4jHkH/C9SvqiRlo8daIkl3Wuk3ugPbeyDWZS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bB5hfu78xRGG777SAsIcoy7cZdM4vU7VFDJlGPD+DLptjDr6ikUXlYn9J7XkTK9w1
	 jaOAlgP7Aiinve4qofq90eyualvjgg6dsKEeXSMIUFUXG5gtZ/sxwuyBonFD39ue4v
	 zw7KH127+zi3IFYsMCR7/s2YNKsqg0eLfkOYXW0FtQSsw0X7SfFA7CG4zS0+pikk35
	 BS0E0YXczPePrZjeFehjnGlUebKjWKzVHIaau0RQhakB47PZLnPGvWSI4btYejHX7n
	 EQaIBlM32ezLHuzSn5f4cyrfHspihztPqlkToBBPcks0oMbYo3bakc0kW5FYQdwbqf
	 bK9VOII05SMiQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>,
 Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Alice
 Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>, Christian
 Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 3/4] rust: miscdevice: Provide additional
 abstractions for iov_iter and kiocb structures
In-Reply-To: <20250813-iov-iter-v4-3-c4f1932b05ef@google.com>
References: <20250813-iov-iter-v4-0-c4f1932b05ef@google.com>
 <Sd3bJSuDzeRFp6pLZtpfMiGff84ipBGWbOcD4IvCarSRysWHcLxyMrudQ5qDRzusozgTLGzsFH-ODocf-iqzKQ==@protonmail.internalid>
 <20250813-iov-iter-v4-3-c4f1932b05ef@google.com>
Date: Fri, 15 Aug 2025 11:56:07 +0200
Message-ID: <878qjkewnc.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> These will be used for the read_iter() and write_iter() callbacks, which
> are now the preferred back-ends for when a user operates on a char device
> with read() and write() respectively.
>
> Cc: Christian Brauner <brauner@kernel.org>
> Co-developed-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




