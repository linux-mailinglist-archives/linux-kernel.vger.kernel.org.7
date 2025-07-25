Return-Path: <linux-kernel+bounces-745888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 355C3B12014
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DDE116B040
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66FF23F405;
	Fri, 25 Jul 2025 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="UuOkwtnn"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A67D1C5D59;
	Fri, 25 Jul 2025 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753453548; cv=pass; b=JlaNBFXgIkPbMJqy3LeptknrnCefPZUb/WXRwgW5PCUmnbYasa8t7Sm/1Re/qZ7DJuHmFzUOFQ/4SHVtKtHYckQCSuz1uubvJ3erfkda66lo/gPohKlNRu16GFwFrE0cuD3FYmV1QV/1X6cFh/kjaVdtimUb5f3FpPDS1BqeOMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753453548; c=relaxed/simple;
	bh=UwBqImuFzVdzQ4tm7gdmNEey8slK+Q1XhPGQMpuQ8ik=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HzNUKnr0Z/Q8Rhul7IkK4IzjJC3N4bEfg8dOVBW89Y8DvB+GCRULmD4nnsARBvBbRrpLJr3/DjBbyX6igumgXLFV4Qk7rzSVoeBb+OtjDqX4p6+HfJGJUyiQt2Mu8klJ7il0bPRTRHohoDzNJwn4DeWI3q0fbAFgNgk9izdsg10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=UuOkwtnn; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753453522; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KuJEIikpED5QWWp18eszUXUicw18U3pH49ohJow/j6ETktRN5uSlRde4bp0Lee5ihd8w5YwCE9efMnb9digbJY8pVH+d82rr3Ikp3nRKhCrx+H3Ftx7QwhegCpDf9U+HPQFmWwgIuW9xC38RE4Rsb0CSE5TvMl5+0FSFRWk8PHo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753453522; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UwBqImuFzVdzQ4tm7gdmNEey8slK+Q1XhPGQMpuQ8ik=; 
	b=LZ4t0LN8UG2Ics2bz3dtnFCyp0TT7/itNJBQVFE1KI2yvEj6xwcUsJ4SDS+q+qmCJv63EZUA0VuCjCYElmgKyAsR9SfdVAfvQ93aepueiJ5Jacoxr9hdDq8pw1/DDXvv+83A1/bAsjcGZqk9V7EeN10oVP2tZsm/cZjKimewCeg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753453522;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=UwBqImuFzVdzQ4tm7gdmNEey8slK+Q1XhPGQMpuQ8ik=;
	b=UuOkwtnnoSOQPIDVuqJ2BosnWmSyAorz2Qqv++I+tymeLOwIoft2Zn8zamGhaDOO
	l7Q0kPzFWCuF4OuALeUTtawNFLlVCr7Mz56YtH+eRoPF2A9+f57ilEPg0fJ9SNkelzA
	hA3DTAP8DKpLf+jCnCrEyehyKHh5xiMiDNzrA9SU=
Received: by mx.zohomail.com with SMTPS id 1753453520277229.33671250289422;
	Fri, 25 Jul 2025 07:25:20 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v6 5/7] rust: hrtimer: Add forward_now() to HrTimer and
 HrTimerCallbackContext
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250724185236.556482-6-lyude@redhat.com>
Date: Fri, 25 Jul 2025 11:25:04 -0300
Cc: rust-for-linux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org,
 Andreas Hindborg <a.hindborg@kernel.org>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0E58916C-EAAB-4FE4-90A9-25CFA8293CD9@collabora.com>
References: <20250724185236.556482-1-lyude@redhat.com>
 <20250724185236.556482-6-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 24 Jul 2025, at 15:49, Lyude Paul <lyude@redhat.com> wrote:
>=20
> Using the HrTimer::raw_time_cb() function, we can now add an =
equivalent to
> hrtimer_forward_now() to both HrTimer and HrTimerCallbackContext.

raw_time_cb is not in the patch itself, and grepping for it in =
rust/kernel did not
produce any results. There's nothing in bindings_generated.rs either.

=E2=80=94 Daniel=

