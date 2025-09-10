Return-Path: <linux-kernel+bounces-810550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3267AB51C3D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3063D1884CF2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDAB31D736;
	Wed, 10 Sep 2025 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2sHwUEv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C490C245019;
	Wed, 10 Sep 2025 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519012; cv=none; b=ktGlJj9uMCA9djnhxnwbuVUvXb+wyh+3VYT/ApYnHsxlYakALqOsgWdYA8pmjz6mcSOQViOlGJGay23fVJMF8hllvltttSAoh9l+3YlESdp0jw/bv+WLSdU3fgyc4KGzf3dHhQOB2kknGSyUKHkC3ZATc2XHaRfQOJTGG3x5YMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519012; c=relaxed/simple;
	bh=tEcxfjPPxIiEgyPcuPLxv2aRAfb/L6QYPeWMrkb/HzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8fX6FzuzTji7j1eK3+jJq/HH/NaOMx+VSQvk7oj1l2lMr6wN8pktSRAIOq5hOdw76Kdqzvwj4fWyzemy0Y/qhaP78m2hJTGzb/xOdnl2/6VnK87h+XWDxxm/vlu2/ZD/dx2yhglEzhP0JuiigYB7Av/Gi+Piwbgt01wuNcnhfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2sHwUEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CABC4CEEB;
	Wed, 10 Sep 2025 15:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757519012;
	bh=tEcxfjPPxIiEgyPcuPLxv2aRAfb/L6QYPeWMrkb/HzE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n2sHwUEvBTRrx3F+cJYRqjQZbnp7QSvHgkxMFwuqGctY9Kk70cKtFTpEst2GyXZyM
	 4WmVYolAGHNKJ8lIG3nDRfpwfC2YffPRxq/eIqymf+PnhLdyNg7OJe+akl6n2JtLjh
	 14rRNMsroDoJzBGTdSr1zCdVh2JSexK1jJ2u+qaI3ZziYLaImqmkdC1UHAgpIFROH+
	 hrctZKC4qp6dlbcn9ghwRGqJaJ7994ASCsocI3JqpyyrE1C3FQhZIU9620J82hrM3a
	 4cQsdFoWGL5Ph7N76JlEi+Dx4V7pijQHa3MOZ+q//htT3Os+6w6BKmIXxAp44RUGE2
	 NHTBjuyDV+Tig==
Message-ID: <17254fe7-3dea-411b-b6a7-fa368ec548e7@kernel.org>
Date: Wed, 10 Sep 2025 17:43:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/7] rust: debugfs: Add support for read-only files
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, Matthew Maurer
 <mmaurer@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Timur Tabi <ttabi@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
 <20250904-debugfs-rust-v11-2-7d12a165685a@google.com>
 <45f6f6e0-bd1e-41e7-8c8e-bb556644a873@de.bosch.com>
 <DCO4MP8YT3A8.2PFXX7VJ1STD@kernel.org>
 <2025091014-explicit-grafted-e849@gregkh>
 <ef5c0c7b-3fb3-4099-966c-62cf08d9b2b4@kernel.org>
 <2025091027-granny-squatted-c5b5@gregkh>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <2025091027-granny-squatted-c5b5@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/25 5:36 PM, Greg Kroah-Hartman wrote:
> I've pushed these to driver-core-testing if you could fix it up as I
> don't know what the other change was?

Sure, will do.

