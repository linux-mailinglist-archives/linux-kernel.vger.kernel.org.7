Return-Path: <linux-kernel+bounces-616216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE0DA9895E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 14:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4245B5A187E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 12:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C7E268FEB;
	Wed, 23 Apr 2025 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XV6jHMRg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3C1208A9;
	Wed, 23 Apr 2025 12:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410428; cv=none; b=ndkQmTOpn7WsnLFoONB//HeOVa6RAxIaRjKqBGL28wLR0Ne2snnpmUrA6pY64zLXFgayYmnkIiDCKmQiJqqhkBMWUDF5QA6M1HlTj5ThmEq1czD8uUntc33re4D2w47jkktBPe0qA3oaKqowaIqHUqaF1ULu99/N+Ru9AVOGLS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410428; c=relaxed/simple;
	bh=NFhp0O5B0cvLWR4T3WVHjMvhxDjI4rA9TwudC0ibQj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IeskgcYPPiuTO3k3vpdIGcKeeK5C6GF9UvsM0lStFHhs6J0EsMNxpxXF5s+8nesiCg6Jm7SsF2MOj6/8G4f6164T1EG2Rjb6SxZTx3oUe757bVCDATZXjNt7xMESzzVrUqXDHPKtSAfGiRU6KLctbJ6E0CsNVGxlMO5n4s8ljH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XV6jHMRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FDDC4CEEC;
	Wed, 23 Apr 2025 12:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745410428;
	bh=NFhp0O5B0cvLWR4T3WVHjMvhxDjI4rA9TwudC0ibQj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XV6jHMRg0c1W76UxUm43F0AYLmgXPq1BIwcMIQc6ajxPGxm/5USf/5zL70EvhS4Rb
	 3yeiokhDNFruZo9Y66/CVK1ohPCF2yz6P8K9GWCx3Ej8q7iU8L1+l6RvblwYy9U0s5
	 QCWC1lrAulmPrNmBC/y4LuVkZkC/giZipOWCrLDnkmthQqBbflnqRjKMIeRrdT2jvT
	 o1XQGUTBj3FJ7ktwxtxvtUz9v1qEOJxZAmBj/T084WO0a7Lp6u+xATug4DS9j27I3i
	 PIeVGiakGglA0+GRLRNsv9Vz1n4J7CHLptltuhdHc1Tgkc6c7CG6IJjO1oQI/NwGZ/
	 POuXY8YiKCMvQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  andrew@lunn.ch,  hkallweit1@gmail.com,
  tmgross@umich.edu,  ojeda@kernel.org,  alex.gaynor@gmail.com,
  gary@garyguo.net,  bjorn3_gh@protonmail.com,  benno.lossin@proton.me,
  a.hindborg@samsung.com,  aliceryhl@google.com,  anna-maria@linutronix.de,
  frederic@kernel.org,  tglx@linutronix.de,  arnd@arndb.de,
  jstultz@google.com,  sboyd@kernel.org,  mingo@redhat.com,
  peterz@infradead.org,  juri.lelli@redhat.com,
  vincent.guittot@linaro.org,  dietmar.eggemann@arm.com,
  rostedt@goodmis.org,  bsegall@google.com,  mgorman@suse.de,
  vschneid@redhat.com,  tgunders@redhat.com,  me@kloenk.dev,
  david.laight.linux@gmail.com
Subject: Re: [PATCH v14 1/6] rust: hrtimer: Add Ktime temporarily
In-Reply-To: <20250422135336.194579-2-fujita.tomonori@gmail.com> (FUJITA
	Tomonori's message of "Tue, 22 Apr 2025 22:53:30 +0900")
References: <20250422135336.194579-1-fujita.tomonori@gmail.com>
	<20250422135336.194579-2-fujita.tomonori@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Wed, 23 Apr 2025 11:26:14 +0200
Message-ID: <87ldrrmdop.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

FUJITA Tomonori <fujita.tomonori@gmail.com> writes:

> Add Ktime temporarily until hrtimer is refactored to use Instant and
> Duration types.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



