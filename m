Return-Path: <linux-kernel+bounces-807642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D22B4A789
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB313B67DE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50CA2C236F;
	Tue,  9 Sep 2025 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5jf9RFl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF302C234F;
	Tue,  9 Sep 2025 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409276; cv=none; b=BR1Bug3LFDmmC2oCnqdDFBkxbAPhp8W2fJKIegkdvEyeSbo+zt5KpBb1QgMBrkitGv/YzUxg5Cc1N5D7nV2wKHdTw1ik+cWOdpQ4x5Xn5t9rAevuZDOS0wlnYSmrnDa2TzI7LP1LYIoWLUTmq6FAC628DU5929I89LSq9iaKGaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409276; c=relaxed/simple;
	bh=VQJWCICOhHbCkaUmxx5hpqb4ryuOMWY3hLJbYcGO+W8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=g2bKYZAsNCCwhQ3Czm5qU8ZbUSEO2XGueUjrKD9HKDyxSvd+6m0UvCwq6+jwlJIOcY1Zk13PFol2t8rleuKwSRnSUVHvd3tkwDgSSKup2AkoBeeiiwnIn8C70pPOKi7RYvYHur6mxcuOyinHeCp9EBdQctEBLBYHO50eCUhzjm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5jf9RFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F9DC4CEF7;
	Tue,  9 Sep 2025 09:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757409275;
	bh=VQJWCICOhHbCkaUmxx5hpqb4ryuOMWY3hLJbYcGO+W8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=W5jf9RFl5PZh8xzrNThdiHCskbj7mamuSL8moI1HITaNGI2YQGHjGeTVgPixQ6CLC
	 TiHNk+53Y0FBCW0KMPmApMTxqo2xbmSTV81CgNwMPKBep8JGSDCQpDH+UerjYrcmF1
	 uhMV+SZkOyjN6FIIdw9ml/hsA6YiOIyBMg4s2m21RtKABWHtS/TZMQMCUBTdoWmdy+
	 7kuaUcLNBV7n12k1Lt8ilyyCclQkYvllO8Uh8CAoTdFwcsomDhtHPxlCNTLMcM/NxL
	 7Sia8SSrpDVYRmJfuhq8qsKah2ZXJw13dRMLVoZPCfiy+93XLjxngFM62Ygf3JMTTt
	 7ZTgWcWofpADg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Sep 2025 11:14:31 +0200
Message-Id: <DCO5LDQHXVUC.3J2MSYSA0WCVC@kernel.org>
Subject: Re: [PATCH v5 1/2] rust: add `Alignment` type
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250908-num-v5-0-c0f2f681ea96@nvidia.com>
 <20250908-num-v5-1-c0f2f681ea96@nvidia.com>
 <CANiq72kUsG10+E-W6zhFXhexZV+O_a-K1Px0kGkWPKvMMhAztQ@mail.gmail.com>
 <DCO2UHSV1FJH.146QJD3UR8FVR@nvidia.com>
 <CANiq72khp7PVeKmbvM=ima7Tp7o1zPfjNY6dRK79aAQZsOvBPw@mail.gmail.com>
In-Reply-To: <CANiq72khp7PVeKmbvM=ima7Tp7o1zPfjNY6dRK79aAQZsOvBPw@mail.gmail.com>

On Tue Sep 9, 2025 at 9:21 AM CEST, Miguel Ojeda wrote:
> On Tue, Sep 9, 2025 at 9:05=E2=80=AFAM Alexandre Courbot <acourbot@nvidia=
.com> wrote:
>>
>> With -rc6 approaching, I don't think we will merge any Nova code taking
>> advantage of this for this cycle, so please feel free to take this
>> patch. We can then merge patch 2 through drm-rust after -rc1 is
>> released.
>
> Sure, sounds good. I can also take patch 2 already as a user of this
> if you prefer (ideally with an Acked-by).

Yeah, this way around make much more sense,

Acked-by: Danilo Krummrich <dakr@kernel.org>

