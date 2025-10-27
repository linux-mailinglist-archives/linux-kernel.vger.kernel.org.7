Return-Path: <linux-kernel+bounces-871253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3B7C0CBF4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C054B4E77CC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F422F39A6;
	Mon, 27 Oct 2025 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZer+rLG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F8426463A;
	Mon, 27 Oct 2025 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558550; cv=none; b=MpHdg2ci9Atw4ZM1PCQy/0wrtxJjIe0ddN6rnm8pSSteVdmQgd2jgPLYyqoSYb5jdhIGlJLQFmf8BZjFS3+e0M05Az57UqCrvd81oHkPXWEXDLZokAPvCDXfIpuwzPdm2+YTZw0H1f8imY1NLsANxJ47OZkw0SUukfaixYZ7rOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558550; c=relaxed/simple;
	bh=aqpWBhTJctQ22Af3ATcDUgcB4495vbkggN0p3+Lo09s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=soDmbW9t6LwUMHx9sUzvBnJZoKPvK4c117IbrBeE5aTmdzKnTNyXesc78Bp18MgdHubQZ9GyiCRr7TM3I3wkdTARvagd7vVLPbIcg0Tlm+fmQA0bCCLEbR1BeeAGLth9WZbO5EN3iNa4GunocBXhyEkunBy8cCYE/PyOQS8P0Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZer+rLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AEEC4CEF1;
	Mon, 27 Oct 2025 09:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761558548;
	bh=aqpWBhTJctQ22Af3ATcDUgcB4495vbkggN0p3+Lo09s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hZer+rLGToaqyqPk/DOrxKf4DrQof+6y6pum94MNtVQEzU8spMzhYm2uAyvtsPmJQ
	 uL4S5s2BTHzf/cfvkt9ACxMv26WjWlqFjh04iOLcX5dU+u/x9S2rzZJuftdMNimT8U
	 xm2wv7GltxdvM4svQlDYxxvTSS45pngZr3gMH5dQB+Vz6DFR+59Zw0zsdlweMHUxDk
	 TimqhTpOt9ICdUPh9mh2d8fHxApSVNk1Gz02M6H3jilHES5QV3+tA+Y89I2CN18cff
	 1ompNNYecWI+bnjWxm3zwZardQAhw6GRQkYNDvLq1cLvBrL+Kf3J4NIFP7DAskR622
	 sqGktt9RJ1Guw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, alex.gaynor@gmail.com,
 aliceryhl@google.com, dakr@kernel.org, daniel.almeida@collabora.com,
 ojeda@kernel.org
Cc: anna-maria@linutronix.de, bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com, frederic@kernel.org, gary@garyguo.net,
 jstultz@google.com, linux-kernel@vger.kernel.org, lossin@kernel.org,
 lyude@redhat.com, rust-for-linux@vger.kernel.org, sboyd@kernel.org,
 tglx@linutronix.de, tmgross@umich.edu
Subject: Re: [PATCH v3 1/2] rust: add udelay() function
In-Reply-To: <20251026125458.2772103-2-fujita.tomonori@gmail.com>
References: <20251026125458.2772103-1-fujita.tomonori@gmail.com>
 <JErNL4JiPvV0WkXxrnJJ3GN7DlXqESjc73E02S0MWjAn4lX-ZtecqfOfmDUuEjm1p0xSEBi-s8Y-cYDHcIvuMA==@protonmail.internalid>
 <20251026125458.2772103-2-fujita.tomonori@gmail.com>
Date: Mon, 27 Oct 2025 10:48:55 +0100
Message-ID: <87y0owfzeg.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:

> Add udelay() function, inserts a delay based on microseconds with busy
> waiting, in preparation for supporting read_poll_timeout_atomic().
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




