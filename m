Return-Path: <linux-kernel+bounces-774164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 954A9B2AF56
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35070189711D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2315C34573E;
	Mon, 18 Aug 2025 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKZJMs3M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1CE32C300;
	Mon, 18 Aug 2025 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537834; cv=none; b=mw0c6RRmwes61JVGB1eU83XD0+MwMs1gh28hf6gpECYpXHbqNWtT3I/fVczMO6RjTH9XQ/IwAS9F3QN1obmAa1dbmgD1Syl+iI+JMy27djVvrc8ozRDA865ciSJP7u4vFN0iuX1h9W66DjmhzICxtNc/AoMDq0vOVVIz5Qgg3H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537834; c=relaxed/simple;
	bh=m8EDhrRjAyOIaC+be7PBn8v9ntITM47BNpWt19+3H2c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=u8QzGMXHiK2GTi2g7Uy5Xnc0wkWUuXs3j9xbYBLUfNNrQqJNgsaeoFxWt6644mKzz0t8y3j4417lOeuD5QfohhSo7VbqiwF7pggXQu4QrL2sfn+obw96wv69o/G9UdRB5AFZx0nyfsXTmeLHZGQRsz/vZv32bdQus2zpVIhmtIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKZJMs3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B6BC4CEEB;
	Mon, 18 Aug 2025 17:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755537833;
	bh=m8EDhrRjAyOIaC+be7PBn8v9ntITM47BNpWt19+3H2c=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=NKZJMs3MHEICxiNfyDQFIsSTlsv5yfJJvspnFrR91Mi4g96H9w01WoHGOaMEdkRWT
	 O8eHRoHanHY4jfp9bpkhO0THl6h7JnffH2aUkl0pASoCOQJWe6+eTlto1lpYx4tVYi
	 q8KghmiLxaSa8eoP56Ftq9rmmlmINR0QO/5mWhHknnSb+0L69IKHn8v5r5TJmU5g9N
	 olC6KI+h7CC4FtVepe5/ckFAClKHbZhyX4kGS4jTCKGLg3Hus6oPdG4xNwbpbb9+5y
	 iC5i8ntf4jHQIDhbITz1wddG5Z0GGgTjTaKDRd0Xuhuf5bKFP1oR8AypwsHFqtKo+T
	 1kFMLa3FmBFtQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Aug 2025 19:23:48 +0200
Message-Id: <DC5Q80UUHSUV.360VLIC6DYZ78@kernel.org>
Subject: Re: [PATCH 1/4] rust: dma: implement DataDirection
Cc: <akpm@linux-foundation.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>, <acourbot@nvidia.com>,
 <jgg@ziepe.ca>, <lyude@redhat.com>, <robin.murphy@arm.com>,
 <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250815171058.299270-1-dakr@kernel.org>
 <20250815171058.299270-2-dakr@kernel.org> <aKLzrp0m00J6CCYz@google.com>
 <DC5INEG2DXU5.DM4JIICEQ2PC@kernel.org> <aKMa7YzO-PwEv9AT@google.com>
 <DC5KK67M752R.N9PX4LUG2F68@kernel.org>
 <CAH5fLgi6OZaqjnDScDrJ3YjN2a8mJuPiO5MLPUqUWo62WkvvrA@mail.gmail.com>
In-Reply-To: <CAH5fLgi6OZaqjnDScDrJ3YjN2a8mJuPiO5MLPUqUWo62WkvvrA@mail.gmail.com>

On Mon Aug 18, 2025 at 4:00 PM CEST, Alice Ryhl wrote:
> In general, I think we want some sort of helper function to cast
> between arbitrary integer types in const-evaluation that panics if the
> cast is out of bounds. Both here and many other places.

What exactly do you have in mind?

