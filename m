Return-Path: <linux-kernel+bounces-764248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECA3B22076
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE243A299C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325742E0410;
	Tue, 12 Aug 2025 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6dTdEuy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E22D2882C9;
	Tue, 12 Aug 2025 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986359; cv=none; b=aok/aZBcSWFCcTOQQ7dFldvmqHftJCM2Ane+uNxTQJsKxlqAPWTKrTnZfA17Y14BMsK/cl8Efpi+pux+1fBv9Xa7QGjlqY606G7Au9Vpi3q5aHw43rdasS8VQxVnE5Ll5qfjwZ4ZyEhmBUp4JvdahpVtzLkY1Cq1BcP9v70xVn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986359; c=relaxed/simple;
	bh=Q3v2a9wegNqf+dAAUCSd2yKhORKs4z8ixJkHi/sttGk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=OfWredCh3OaaHT8wElIlDKzs1hZOhWI3eBfa81UmPAA1RsTiT2pW6kaWg9Zwymp4x5C1EFSyXOxS9luWR059sbV1Ece1nWsyAAKye2YrC1RKIvi8tmc1hUwFiHHl+xeNvS1HN/B1/u/QVDi8X2RkIv9cIAVoojYKCvPdvAQ+SCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6dTdEuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BCCC4CEF0;
	Tue, 12 Aug 2025 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754986356;
	bh=Q3v2a9wegNqf+dAAUCSd2yKhORKs4z8ixJkHi/sttGk=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=T6dTdEuyHuvVSS3J+ThcLpypDVXyY0AT/y4n7OOJfrwtTagw9AacHBTuc0SWFfAma
	 9b0zbqZ2fNgDkD2E7Ytx1DqpPz+lttTdCpcA8k/nZpt1ixWKWZU/IHY9/OXDj8QLli
	 NxVM1u+4K4wbQHafF0kkowpWnO7ebne1ICohsGcfXdljQkMW6aber0pbDQlB17oLkG
	 vGYl1Z69E/ivlzlKPb9hnLprsvs7yeegJ7i3onR15isHegtDbd4vGg0aax32jagvXS
	 IiZtgOzjEXAXaFBLrc6av9V2J2+AvDRVPeqBHkYNBJ/E6oJkqV2BdkSjO2XCW56DZM
	 eHoBzmQwVynZg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 10:12:31 +0200
Message-Id: <DC0AQNL2V4TL.1UDSNIRZX4SFU@kernel.org>
Subject: Re: [PATCH v5 3/5] rust: convert `Arc` to use `Refcount`
From: "Benno Lossin" <lossin@kernel.org>
To: "Gary Guo" <gary@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Tamir Duberstein"
 <tamird@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "Alex
 Mantel" <alexmantel93@mailbox.org>
Cc: "Will Deacon" <will@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Mark Rutland" <mark.rutland@arm.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250723233312.3304339-1-gary@kernel.org>
 <20250723233312.3304339-4-gary@kernel.org>
In-Reply-To: <20250723233312.3304339-4-gary@kernel.org>

On Thu Jul 24, 2025 at 1:32 AM CEST, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
>
> With `Refcount` type created, `Arc` can use `Refcount` instead of
> calling into FFI directly.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  rust/kernel/sync/arc.rs | 45 +++++++++++++----------------------------
>  1 file changed, 14 insertions(+), 31 deletions(-)

