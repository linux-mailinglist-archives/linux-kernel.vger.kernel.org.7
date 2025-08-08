Return-Path: <linux-kernel+bounces-759992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F6AB1E55F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72B517FBAC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE3126A1AC;
	Fri,  8 Aug 2025 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhkwdqyB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CB4268C63;
	Fri,  8 Aug 2025 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754644246; cv=none; b=JpggrBT2NiXrzWdOuPVhfGjOg/nEjWd9NMDk7tiL4b9JhWF23PhsEIPhzC2jv2knZhmz0Yke5MBjLx91FwbuCgc7PCXMrgbGTfMWCvwwxMDQwD75pd+PQx2okGSeV5ecYpfeQePqyDisG9xIjRzr0BJujKSuJ5dTgq8RSxkXmCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754644246; c=relaxed/simple;
	bh=FBnk6fDo4H4EUo6TXmTO2Yy/TCUezrB6XNFY989upss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LC/NAfIYHL58lQe6TKnHHYpE9e++Q5moQhD0UDqxLFCwTIrLqGQinMlni204GH5kyLeLAjnZEYLVL3avYdHlcySk9jAR2xgEPOVKeI6NKt8nOUsVy9v89nkB8m5oFEaskVRG67S4gCvujZDrZRraCbUmxFzA7EgKpdE9WNkATuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhkwdqyB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CE4C4CEF0;
	Fri,  8 Aug 2025 09:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754644245;
	bh=FBnk6fDo4H4EUo6TXmTO2Yy/TCUezrB6XNFY989upss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mhkwdqyBUjsKZ9kqr5UjhUwW1jMvd+ZidJDgzqh/fOxVPaOzQKamQ0rjcgoM0O0KD
	 fATuXzzKjtX7f9ogZQXyb6xHH1fDUSr2gk0yJYoQ0k4IwOz6J4VoskfF5ciyR9PHCZ
	 eeUenOA51Amy95IPxVYtHaZQiiXBxcrom2rDOo5R8u7mjW2SPyBlvJMo+AKMHBpFGV
	 9mQLfbEh8OgVR5cfu4gTbSVEHYXmEzua7n93jEngSD6xlQxqx2w8vBSU1YdGgj5vRH
	 mAU+iq+Mr+wq7Wzs+P/DzXfKuSbdCRtq/uRPVAZTR/OCX++vldTXu1vM/2TclzdTth
	 IPhS9qhVuFCgQ==
Message-ID: <8a4ca76e-989a-463e-ac94-27f5e2e627df@kernel.org>
Date: Fri, 8 Aug 2025 11:10:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: extend kbox with a new constructor
To: Alice Ryhl <aliceryhl@google.com>
Cc: Vitaly Wool <vitaly.wool@konsulko.se>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>
References: <20250807121011.2317762-1-vitaly.wool@konsulko.se>
 <DBWGKO6W6BK3.1ZTUQ8EI9LFJ7@kernel.org> <aJW85LX_mp6pOBM6@google.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <aJW85LX_mp6pOBM6@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/25 11:01 AM, Alice Ryhl wrote:
> Right now we provide the index being initialized, which you
> can use to index an array if that's what you want.

Fair enough, let's keep just the usize then.

