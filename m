Return-Path: <linux-kernel+bounces-804350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E134B472B1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2925A2CB1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFDD23ABA1;
	Sat,  6 Sep 2025 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCSbbrK9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359AB221DA5;
	Sat,  6 Sep 2025 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757173719; cv=none; b=OcEX6fQd9PVadhxtl3mg6r/yArfZhPEs2YEO1ACJNDzQst94tt7Nli0iB3DhNGWVD7ZEdRs1OehZdVVVxb/XuehtTsCgFWUL1jUCWw/jPuQd8Tfb3EZofWbm+cmALV73EqRDF0ZEvBjzLmhmsHsdQJLwA1k7f7FxkSgOlbokV0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757173719; c=relaxed/simple;
	bh=QQ7KMn0OoniHUFpZx2lBqgPxKPg2Vwh4ulFX8fgo0ew=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=Af6+qZHQ2gq9W2uVCBBhP8F20LxiTu1gsMZ/X5NIF2XrP08USXRXLly3URS7E0BE3egUdNkoh8Wv/d5NpyOs2TI7L0Vx9rhOG0hWmWynXlnhMlXkfSM64FuLyrE8toj/LuJL5E53qc1Yud8jq1BHgyYd4Lbv3SVQRCNaWJ3QyaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCSbbrK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9946C4CEF8;
	Sat,  6 Sep 2025 15:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757173718;
	bh=QQ7KMn0OoniHUFpZx2lBqgPxKPg2Vwh4ulFX8fgo0ew=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=RCSbbrK9qtud6gCJGDTPp+5KbDLCLDXboJVe6y2xyWaQVnA2TQLCvR1XRPoKQrJmo
	 jRePw9kbPrT4oqB9k7/YIwq1CWNx5QHuV2ZfHCn7g4ElgFZs57t7zwLDn2dlEedZ+D
	 FN0fjAM3k8lto2w1+9sL2liR7kv+fp+23AQQTg1HzwSWmigxvIGEC0kReviz3bd5XN
	 3H7xVS9W/gVB69EB5Yj5AjKb+hgkW6h6n2mvJnVRspkj+C34ikXSQft2ej6xDkDPiY
	 Msc0i0Z4OQXUKptkF211Vz73/kJdvvBYgBe9JRYFxhW5iyub9cVDTbJBug3f83ysR8
	 9EIoZhiU57eFg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 06 Sep 2025 17:48:33 +0200
Message-Id: <DCLU3G70XEAR.383M8VEKRK6BM@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 2/2] samples: rust: add a USB driver sample
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Michal
 Wilczynski" <m.wilczynski@samsung.com>, "Igor Korotin"
 <igor.korotin.linux@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-usb@vger.kernel.org>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-2-7aa024de7ae8@collabora.com>
 <2025090618-smudgy-cringing-a7a4@gregkh>
 <D8EAF874-4FED-42EE-8FD8-E89B6CB0086A@collabora.com>
 <2025090601-iron-glitter-c77d@gregkh>
 <831C4AE2-6964-4699-9E74-E4B721B87B17@collabora.com>
 <DCLQZZHU42HN.4Y4PP0PPR10O@kernel.org>
 <9657C897-087E-4544-849B-964E99D95A50@collabora.com>
 <DCLTJMIAMCVL.35U236MMS5CCK@kernel.org>
 <85B643A9-1657-43ED-BE98-BE7E502D08DA@collabora.com>
In-Reply-To: <85B643A9-1657-43ED-BE98-BE7E502D08DA@collabora.com>

On Sat Sep 6, 2025 at 5:46 PM CEST, Daniel Almeida wrote:
> As I said to Greg above, I=E2=80=99m here to help if anyone wants to writ=
e a USB
> driver. Those interested are free to reach out to me and we will work tog=
ether
> to merge the required abstractions with a real user in mind. Hopefully th=
is
> encourages others to join in this work :)

Yes, that'd be great! :)

