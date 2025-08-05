Return-Path: <linux-kernel+bounces-756797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA733B1B95B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07B2B7A5360
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6082029617D;
	Tue,  5 Aug 2025 17:30:09 +0000 (UTC)
Received: from hs01.dakr.org (hs01.dakr.org [173.249.23.66])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7EE2918F1;
	Tue,  5 Aug 2025 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.249.23.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754415009; cv=none; b=HcYUlTTgiJFRmTGqUvrYK/k6hZ8SJFR1Mc7x3SI9xxOOFnZQFk1RHYVIXSY/3tm2TglTaOy3H2HlWAelSKDp6dWyAReOsBpz1cO6zYd06/3LYZphgo8470w372heYaIT2htRjkT2sitDdYeTQFjSSyPmXPuql/NYJxspeG4C194=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754415009; c=relaxed/simple;
	bh=Y2eT5YbSJaEPQUKR08WmIuDOeJ9tiS128FPOCPqcUYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YbpTwmu9ZCvDWgVV2Y+7eU0m5aJobP36ooZUcNBUBjA3ZE3cY9QvW224K+RtWF0dwovqwzKIFkCGMRctrXOq0ovzXLss8DNZme6Ca/dl0KHMKpArDFybN02MXNwKC5/xTyTDc5LUG6z87Q1tOqvWUMZClTdNwxdWUpGQK5VhMnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dakr.org; spf=pass smtp.mailfrom=dakr.org; arc=none smtp.client-ip=173.249.23.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dakr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dakr.org
Message-ID: <b7a7f917-9c22-4971-b9e0-6bc0d674b139@dakr.org>
Date: Tue, 5 Aug 2025 19:23:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v11 0/4] New trait OwnableRefCounted for ARef<->Owned
 conversion.
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>,
 Asahi Lina <lina+kernel@asahilina.net>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
From: Danilo Krummrich <kernel@dakr.org>
Content-Language: en-US
In-Reply-To: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/18/25 2:27 PM, Oliver Mangold wrote:
> This allows to convert between ARef<T> and Owned<T> by
> implementing the new trait OwnedRefCounted.

Thanks for working on this!

Please make sure to use scripts/get_maintainer.pl in order to make sure to send
your series to all relevant maintainers and reviewers. I think you forgot some
of them.

