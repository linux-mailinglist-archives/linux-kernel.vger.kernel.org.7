Return-Path: <linux-kernel+bounces-762418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FFDB2064D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396951629C8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1349A284693;
	Mon, 11 Aug 2025 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRAVvrzT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFA0284688;
	Mon, 11 Aug 2025 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909244; cv=none; b=jUtii+4/lWpbrF6MNt1FCHPN0EQ8w8fyGoDyDnlsk/iKJlWpGNMQ6GIebSs/ZSf5kBKI2N/aPLeM9tcHlsHFO3bSvM0lcayAAg5ZDXaVCiT/QQEcGVBLjzdX1hQ9MsWwtzqrZrNMQA18i9GAaXTqs2HejM8SRuJjhKd2tFVFAFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909244; c=relaxed/simple;
	bh=LQU8/Ph8t2p6npAH8god//1ZNaCbmitonsyyBNhJpeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kzTNujYLmRhsjUHjcDbTxUhzZhfowtbMZPldyGQ0tyzRbiZGlPSrfXI2bLZhx5Es60AHXuBYB1l8GcAjIK5xu9k1Ahjm6rtijasbPr9YHv6hRwExwOzUWSdvbKO4zXNhhpe061DXO8ZA6+gCkWOUu7kOi4kFFchzwUebexZ5Q5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRAVvrzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB1CC4CEED;
	Mon, 11 Aug 2025 10:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754909244;
	bh=LQU8/Ph8t2p6npAH8god//1ZNaCbmitonsyyBNhJpeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WRAVvrzTlhfM4xpGeNizC8QMuGtwV/JEroIxLBsFkRubXQbGlkk027F8RQvHVc1Vm
	 yWh5KXBKEpP2snMb14joILR8Xm2qN9wRoySMWz9AIoS9V/hkfh9qRz1ZNO8VfBeqVq
	 6raspn8BsooMhPrQGSauywsLiOMFcqYgDG9620IeTSBh2eA5EXEvwBHdQBQUL3BWyR
	 j4HGv05q7Uwzv8l87V4FYrTqgxmVW5iIFQEUaS+Rhi+FepUzMsVAPV6r8fuNcW6xK2
	 Z9UisnO4s/DgkQfnmRp0XrakmjXf5sZr7Snh4z3wdmq/U7yLCOKqh6hYzSdsgM9a4c
	 QZGmDq21ZuFSA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, alex.gaynor@gmail.com,
 ojeda@kernel.org
Cc: aliceryhl@google.com, anna-maria@linutronix.de,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org,
 frederic@kernel.org, gary@garyguo.net, jstultz@google.com,
 linux-kernel@vger.kernel.org, lossin@kernel.org, lyude@redhat.com,
 rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de,
 tmgross@umich.edu, acourbot@nvidia.com, daniel.almeida@collabora.com
Subject: Re: [PATCH v1 1/2] rust: Add cpu_relax() helper
In-Reply-To: <20250811041039.3231548-2-fujita.tomonori@gmail.com>
References: <20250811041039.3231548-1-fujita.tomonori@gmail.com>
 <btV8FNpdoKJ0AyY7M-Rlo8b-iV7kgsatB9XV5VgY4GTQRxPlWfMiBvngzXo1blvuezqJ_8PKIdORtVXf7pc-Kg==@protonmail.internalid>
 <20250811041039.3231548-2-fujita.tomonori@gmail.com>
Date: Mon, 11 Aug 2025 12:45:13 +0200
Message-ID: <871ppigmrq.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:

> Add cpu_relax() helper in preparation for supporting
> read_poll_timeout().
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



