Return-Path: <linux-kernel+bounces-820596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B167EB7C574
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5439C32345C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 11:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DED371EA7;
	Wed, 17 Sep 2025 11:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="F9GvnpNG"
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D1E2D0283
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110365; cv=none; b=jaXmqUF8J9Uys57bQ6PQF2Pp9c8dGAcN8QRBOmBGH584ByQ2edOCgKjO07n5PpqfzGJi7Y4FmWefVnkvZuRmS6rtf98BXU/qevHL/RqeErQcmheJ1bXMzLAxUC5q1XakUVo/Gi+CiYgtVt0M92CwTNjJMP+gnhPK64hVbOOrLPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110365; c=relaxed/simple;
	bh=o9fgsweKF8PJgKSOc9c3OGlMDVuqLQuNlhUk/jq7D9o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKNBKyXxuccxuhcEiBFjE2mD4Ui3M/Ssd2/FMKepOBte2Vh+oiZCGgyNtd1L65KI2aEBmzL2kQl2B3ZjJ7msD5MBUGBDyLLBVY6eYGUGPqFj8mzGudEqTfUk9UR3etaPf99zUI1vFC+dyHZWaPDy4J8LRnhVtCEfWVOOoyDvNjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=F9GvnpNG; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1758110361; x=1758369561;
	bh=8G1gjeOhH6z3jjCnLYhJiil7bybWOrf0uRdC8hU2GC0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=F9GvnpNG4Gt6Sebr4WS2hF9E2Jzupev462Q9GCTDLgm8G5bOfPCz1HQK9DaCpQJvf
	 YxEfOnaFzh6J2fXYCz371HliTSEGiaB5juDF/11mrAEvEONxHneitPHr8uYbvjCwlJ
	 7Oo+OKMCh8VxmeL9tESfGiPLlFYCOwZLvecntXNATyPPZGP9YhRh43dLfL4XOoLBAf
	 y2koRlmKQRyN8y3KRVEsxcud3Ymy/UGWIBtdpXqqvcUOvRB7lnxYvUbTMJWh7LhPPj
	 BgylIcza2DZTSB7W4Hp5tfOgBjxSloN+sFgkVe/L7zT+HwPGP8ctcLcIYIkEt7qZZt
	 Un6knHsfDjMsQ==
Date: Wed, 17 Sep 2025 11:59:14 +0000
To: Benjamin Tissoires <bentiss@kernel.org>
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org, db48x@db48x.net, gary@garyguo.net, ojeda@kernel.org, tmgross@umich.edu, peter.hutterer@who-t.net, Benno Lossin <lossin@kernel.org>
Subject: Re: (subset) [PATCH v3 RESEND RESEND 0/3] Initial work for Rust abstraction for HID device driver development
Message-ID: <87segljnn7.fsf@protonmail.com>
In-Reply-To: <175810473311.3076338.14309101339951114135.b4-ty@kernel.org>
References: <20250913161222.3889-1-sergeantsagara@protonmail.com> <175810473311.3076338.14309101339951114135.b4-ty@kernel.org>
Feedback-ID: 26003777:user:proton
X-Pm-Message-ID: ff945701f6055e226f1457b6efdd478dc6562136
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Sep, 2025 12:25:33 +0200 "Benjamin Tissoires" <bentiss@kernel.or=
g> wrote:
> On Sat, 13 Sep 2025 16:12:43 +0000, Rahul Rameshbabu wrote:
>> I am doing another resend. Let me know if it makes sense to start sendin=
g out
>> work I have on top of these changes. I wanted to wait till these changes=
 got
>> merged first but maybe that is not the right strategy?
>>
>> https://lore.kernel.org/rust-for-linux/20250721020211.196394-2-sergeants=
agara@protonmail.com/
>>
>> I incorporated Danilo's and Miguel's feedback from my v2. Additionally, =
I
>> noticed I had basic formatting issues when running scripts/checkpatch.pl=
.
>> I made sure to check the generated rustdocs and that the Rust examples
>> compile as part of the kunit infrastructure. I dropped the kref bindings
>> as they are no longer needed for this series.
>>
>> [...]
>
> Applied to hid/hid.git (for-6.18/core), thanks!
>
> [1/3] HID: core: Change hid_driver to use a const char* for name
>       https://git.kernel.org/hid/hid/c/d1dd75c6500c
>

Thanks!

It will be nice not having to carry around that small cleanup patch.

-- Rahul Rameshbabu


