Return-Path: <linux-kernel+bounces-747972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3449B13AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E943B68A8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F41426657B;
	Mon, 28 Jul 2025 12:57:30 +0000 (UTC)
Received: from hs01.dakr.org (hs01.dakr.org [173.249.23.66])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95212472B9;
	Mon, 28 Jul 2025 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.249.23.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753707449; cv=none; b=G6Im+ptvE2Rg8j5ETf6xyqUwT1KZV5GyXMLNvKTgUywm4nqbb4GP14LNQQT1jriFE9ZPEDhBpQFdUloA+hWtiQPQ8C0D+7cl7uUM+cxMIrncT0rRhH0S90Qvc8g376DX1ESnt2f1kypNzTbsNXaVTgl2nT37UgEkNKZqqOHFBY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753707449; c=relaxed/simple;
	bh=sU4nt/PuuA1YLyMazmNzKpmeb/FFMMIOGhP3Gm9zZ6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DvqMrz+C1N5g5bpc3HQBYddI9XbKte3PBDglbWhnRMSjHxqBdjWRn+9HoID5RTc2RjK/KRRZPN0FJZv5pZbIig0YTWeguG5ZNRR0+CDKt0SdAlp0P8cHtzU6a3qufcD5EclE+fJhzHPYEQMPln5cyhQ832yc5StZP7NmXymnApg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dakr.org; spf=pass smtp.mailfrom=dakr.org; arc=none smtp.client-ip=173.249.23.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dakr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dakr.org
Message-ID: <6c5b4f8f-c849-47f8-91ce-fc9258b0f239@dakr.org>
Date: Mon, 28 Jul 2025 14:57:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v11 7/8] rust: Add read_poll_timeout functions
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: daniel.almeida@collabora.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev,
 david.laight.linux@gmail.com, Alexandre Courbot <acourbot@nvidia.com>
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
 <20250220070611.214262-8-fujita.tomonori@gmail.com>
 <FC2BC3FF-21F2-4166-9ACD-E14FE722793D@collabora.com>
 <20250728.215209.1705204563387737183.fujita.tomonori@gmail.com>
From: Danilo Krummrich <kernel@dakr.org>
Content-Language: en-US
In-Reply-To: <20250728.215209.1705204563387737183.fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/28/25 2:52 PM, FUJITA Tomonori wrote:
> All the dependencies for this patch (timer, fsleep, might_sleep, etc)
> are planned to be merged in 6.17-rc1, and I'll submit the updated
> version after the rc1 release.

Can you please Cc Alex and me on this?

Thanks,
Danilo

