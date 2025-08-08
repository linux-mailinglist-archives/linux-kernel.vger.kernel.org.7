Return-Path: <linux-kernel+bounces-759908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9D7B1E45F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7EA18C1173
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867B126463B;
	Fri,  8 Aug 2025 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJqf+GXO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D9E4A11;
	Fri,  8 Aug 2025 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754641625; cv=none; b=HupkHBpimRqmCcvLXECoufRa4+OCjReQBL2dFu3qhfG636dBJIIoT/YkFByDnjvRTBi3I18NJ9eGd1WvJAy4oSS2N6w0cwf53mghDmkPUmBCTHZ13Nug6PhxioLutr6KuUCwiQCfNDBH5IkEQ7WpKQyVjqwKcE1CqpidNqEIX/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754641625; c=relaxed/simple;
	bh=Jgh2qS3kG6kQ1i46rsLuhwXlMgWqyeYURAc8TMAVvsc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eq8zsugjYuwYLdJmkC3FUT080pFhICCdCddxvefYWcMG+6oK7GlPYNRyTVQxS7jR6h7Lr6yh5tVsJmT/PGjM/LG0V6QvIUp3K0rtaLwrQM42qThiGCUl0y0oVbAuUgkR9z9lghJTFqfsCjTltete6XWJFuQ4yOTPOdeohYxUpCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJqf+GXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F6EC4CEF6;
	Fri,  8 Aug 2025 08:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754641624;
	bh=Jgh2qS3kG6kQ1i46rsLuhwXlMgWqyeYURAc8TMAVvsc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WJqf+GXOkSFbEGKoiIYMIZilPpyauyddhVRa8C+SmxOPYcammooLyV566IMRFtoEt
	 EibUnVSXdkLZIrbf/lhy5N3OVhNaC50mQwQjvqa5b0p5BETuw2a9/j/H4hZO2l+g5r
	 N5S5uG1Pkz6lDfAvqNeNmxEHjmFB0BK0nFy+67K02HdApKQOilkL0ZBqOD2keG8aTL
	 n+sqrK+E0RX70TqGWK4klF9sA8vu6G9ztRmEXeE+eED9/0GdQ+MszYwC/tf3vTmtIH
	 52E/RvAHTno84It09WEEAAtabsEbpCggbS7MOh49kFCXvZQO0As1VONACSq1FOviHr
	 /gdwxsdHzIJDw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Stephen
 Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>
Subject: Re: [PATCH v6 5/7] rust: hrtimer: Add forward_now() to HrTimer and
 HrTimerCallbackContext
In-Reply-To: <20250724185236.556482-6-lyude@redhat.com>
References: <20250724185236.556482-1-lyude@redhat.com>
 <yyxia-6jPRe4MK9jt_2OV95A6jC-eLuNR_lsLS_1VkIM8qMTKw1SsmayBxpaRQNi3OeGqZCG2t01zssg4QwxjA==@protonmail.internalid>
 <20250724185236.556482-6-lyude@redhat.com>
Date: Fri, 08 Aug 2025 10:14:06 +0200
Message-ID: <878qju6xip.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lyude Paul" <lyude@redhat.com> writes:

> Using the HrTimer::raw_time_cb() function, we can now add an equivalent to
> hrtimer_forward_now() to both HrTimer and HrTimerCallbackContext.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

With the commit message fixed:

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




