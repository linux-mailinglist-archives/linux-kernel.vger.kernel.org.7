Return-Path: <linux-kernel+bounces-869057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C279EC06D25
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3611C01475
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7AD253B58;
	Fri, 24 Oct 2025 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K//ufyrb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B7030EF62;
	Fri, 24 Oct 2025 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317848; cv=none; b=Xaavi6aLIHMCmbQjCqUv1/2a8sYdWE1IcPc+g3fs8f6NAHTcR05Aix+5CcbEkiHIOZkNS1NFh1SOc7LAJTzcB1ccjVDYnbgglij7ZtyOIodFpFT/wnWgBqlSdy3CDrhi6w/hvss21CQhxnNtsKdzE0FX2NVh+cqbD+Cnj6kdsqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317848; c=relaxed/simple;
	bh=ckGShd3HSTRH6YBTlCk+dpeQP+1/q+Dixe18TS1J2YE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFhSC/KNuHsrf5wpqvkt6OViOZPIfU2F70dkCNMzE0j6q2wHaX799Jnj801brXefP3PO4MYLPjma7xjzhRh5e7KKzn1MRCpVN6GZNhc8ehko/vHWty55/gqbiCSRKd1ZoC2PAhHisZ12/zGFuWVunsm7l6u7PdGduz7PZQod3uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K//ufyrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92911C4CEF1;
	Fri, 24 Oct 2025 14:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761317847;
	bh=ckGShd3HSTRH6YBTlCk+dpeQP+1/q+Dixe18TS1J2YE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K//ufyrbHR+YI7mo1zmUMQyv7Q1B7V4AXedFU0PK2l7GtfwIal6gWCYcsOK5Ibef2
	 qFF3vZZ38sCQ69GP44WX/fLkFhI6YfVtUhwi3TGAPg1J9R5ZoBfr4g2YhDr2IncIai
	 2zWIUjD09tZkh2N3fDkKQGG04+I1Vg/YIPPUrmmEjn1YuMpiZvjoz2icOqlgvYGtEV
	 FBQQiD5cqJqJw4kvVeQ+yeseZK9wtl044UBDhuxr9W/v1QPU/aY4axq4IEqrpk3sNd
	 4OEL5jttbmqo5NvjZ7I8WbeBRcTY44Xa2PSibqBc87KbosuJXiWBuM2wYTePLWN9dl
	 tEFr0v7ao6dMw==
Message-ID: <ad655011-d695-4dca-bc60-902aeffe73a9@kernel.org>
Date: Fri, 24 Oct 2025 16:57:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Remove the usage of Rust native atomics in debugfs
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthew Maurer <mmaurer@google.com>
References: <20251022035324.70785-1-boqun.feng@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251022035324.70785-1-boqun.feng@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 5:53 AM, Boqun Feng wrote:
> Boqun Feng (3):
>   rust: sync: atomic: Make Atomic*Ops pub(crate)
>   rust: sync: atomic: Implement Debug for Atomic<Debug>
>   rust: debugfs: Replace the usage of Rust native atomics

I ack'd patch three for you to pick it up, but I now wonder if you want me to
pick it up through the driver-core tree?

