Return-Path: <linux-kernel+bounces-726953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B46AB0135B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A133A3B873F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0B91D618E;
	Fri, 11 Jul 2025 06:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/kBexQq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9611A944F;
	Fri, 11 Jul 2025 06:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752214441; cv=none; b=HAeWEJ4sEIFfbNDGuNod4D1dCwTEsof5xscIJXCm/l5zPq4rRg04uIUTTar6aH2QiCiBhRlMCGAhZCcxhOFDDjHxVaRLrp99Ypqrkfc/BmzcIr4c8MMLThu2PcWyWYu3J+5Uc2satgl2OSQgZVOfYukR+VG69S+Rnvpoe93l6eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752214441; c=relaxed/simple;
	bh=pxyh/DkUib7pi6dop/it5OeNrxrB04KysXzdojBfGgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J25uCcFBi5GnsMHfwg0B/IRvjOLrL71ACFhs/9ctpV8ms8NTX1g1VqSF571TQ6GS0C9hgTmYap+dnmAV+YGTLO7Q7qxusxsdRG9ZJZkKEjxCY8p4yN4EH204CNBhXzY2JwPOTSRDke8gR+XE0pa8JH3EMcqsjMsJ7JNNyNgMonM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/kBexQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B9CC4CEED;
	Fri, 11 Jul 2025 06:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752214441;
	bh=pxyh/DkUib7pi6dop/it5OeNrxrB04KysXzdojBfGgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Y/kBexQq3sDwqRDLwBlD0IN8AaYcVZ6iSRm59jNNEzfPYVhtTOzCynh54BWNe1+gC
	 WhjhfMaJjZ/nPgC0n0+TzEIJveF4rs6F5JXRcAzilPx4Gp3OtvOetNW48zhLLg4qd7
	 gC1U5bNabieY/u1RjyJHcYwiAUN28Cv19JptVWmfNMjyyUGLI0MkAFddJnHMULWdDM
	 xcKhH9/23tXIDdn7hOQTpBUoC7vJTGgASqJ989cxO2NpB9X38issLoBBYlwxDvP9wN
	 s+FXRL+I90nJfL7IDMyzPaCvK20qI4w/fO6zHZBzbE34pLrgO/OY59GNmL7YmY1vjF
	 /Eaj6ntKssZXQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
Cc: <miguel.ojeda.sandonis@gmail.com>,  <alex.gaynor@gmail.com>,
  <ojeda@kernel.org>,  <aliceryhl@google.com>,  <anna-maria@linutronix.de>,
  <bjorn3_gh@protonmail.com>,  <boqun.feng@gmail.com>,  <dakr@kernel.org>,
  <frederic@kernel.org>,  <gary@garyguo.net>,  <jstultz@google.com>,
  <linux-kernel@vger.kernel.org>,  <lossin@kernel.org>,
  <lyude@redhat.com>,  <rust-for-linux@vger.kernel.org>,
  <sboyd@kernel.org>,  <tglx@linutronix.de>,  <tmgross@umich.edu>
Subject: Re: [PATCH v3 0/5] rust: time: Convert hrtimer to use Instant and
 Delta
In-Reply-To: <20250711.080013.1402268636571271744.fujita.tomonori@gmail.com>
	(FUJITA Tomonori's message of "Fri, 11 Jul 2025 08:00:13 +0900")
References: <20250626.091248.526065656918619245.fujita.tomonori@gmail.com>
	<87h5zstoaq.fsf@kernel.org> <871pqojlyi.fsf@kernel.org>
	<7kUMSi1wTeYVq8p7t6lUe8rugGRXZu39tbD9FdcLqepQEJv0k7q7s2VOLeVZPiLLcpLf2GL5vj9ilWhDKtC9UQ==@protonmail.internalid>
	<20250711.080013.1402268636571271744.fujita.tomonori@gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Fri, 11 Jul 2025 08:13:51 +0200
Message-ID: <87ple7i7a8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:

> On Thu, 10 Jul 2025 13:59:17 +0200
> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>
>> This was discussed [1] and consensus was reached that `as_*` iwth pass
>> by value plus a `Copy` bound on the trait is the way to go for this
>> method.
>>
>> [1] https://hackmd.io/ZXXSbxxQRpiWzX61sJFlcg?view#API-Naming-guidelines-=
for-conversion-functions
>
> Great, thanks!
>
> Would you like me to send a patch for something =E2=80=95 for example, a =
patch
> that applies the above changes to the current timekeeping-next tree?
>
> Or would you prefer to reset timekeeping-next to an earlier commit for
> a cleaner history, and have me send a patchset based on that?

Yes, we should align the code, so if you can change all the `as_nanos`
to take by value, that would be great.

I already sent the PR for the 6.17 merge window, so please send a new
patch, then we can get it in the next cycle.


Best regards,
Andreas Hindborg



