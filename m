Return-Path: <linux-kernel+bounces-738360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB02FB0B778
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 19:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ADF61899F72
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 17:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A55B21CA14;
	Sun, 20 Jul 2025 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCz8s7Kk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E541CA81;
	Sun, 20 Jul 2025 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753033673; cv=none; b=brTk9qBDfUDvC6hKTyZAULwo8dLhrILWT7TA0ei2FZ5Y0bdeTu9TymkkrFp4AsXFmfKrhdkuzGWfuc+wMwV+FxS3+ON9YXFcuDBQJoEakEy25NMQi+BDwuyKPk3AiP2vOqd7Uv9zYYHTGogHaYzLdVrumNhLdEyJGQb6eThXu24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753033673; c=relaxed/simple;
	bh=04mb5xS3cF3aZTiHfd2DG0BnChI/bOghUjbkJNj2gv4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=YbQwGza555XF86nQq7ezYg2jMabODTTOSObqTwsAIcU5nfAktJYePjQtCUPWKU8rbGbkcq77locAZFSmY7NAwV2Leqnln5CIpcqDK5iUlgKGuDiCAKsW2GZnt/2+gWwVYLNTWRaPcwjEpBD7znzQB2vAVEeO7KBPOdqm8OBIqgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCz8s7Kk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E93C4CEE7;
	Sun, 20 Jul 2025 17:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753033672;
	bh=04mb5xS3cF3aZTiHfd2DG0BnChI/bOghUjbkJNj2gv4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=kCz8s7Kk8q8ON6QABEaRKWJCLOuq8JemkDhhm8DCZ5Y+kuoqAqXhW8R/aAaLOuVZ9
	 gL5Ybkt/eomyw+Hj8ZrBYYW2tUlN+l3sMUKaj+h8NcYr45c+Aiq3gSRunAnQ0gh/cy
	 28zfQfWjqohOGGAKVCn0VzOFIQI6x35eJUNYvKy764wUTERnWRmza8+5pqT07NZuo6
	 nxNJIzWO27gVPIhFLxK7r2tcR0GWfzQmP8vV5Q3paXHI/U4tu+dmE2WI/xbJYH/DxI
	 Lh7lIZnl+0qwX7tL5kK1mwgEdvqUl2PCRRc+CsbJJzlXXT2UGOd6l3SDTm+CLjdYAT
	 G/Zdtj0mnwXxw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Jul 2025 19:47:48 +0200
Message-Id: <DBH2KLK2GFHS.3FJY71WIOOOGJ@kernel.org>
Subject: Re: [PATCH] rust: io: mem: enable IoRequest doc-tests
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250717-topics-tyr-platform_iomem-v15-0-beca780b77e3@collabora.com> <20250717-topics-tyr-platform_iomem-v15-2-beca780b77e3@collabora.com> <DBG2XI0UZ3B5.I9KLFJUYQUMC@kernel.org> <DBG39YMN2TX6.1VR4PEQSI8PSG@kernel.org>
In-Reply-To: <DBG39YMN2TX6.1VR4PEQSI8PSG@kernel.org>

On Sat Jul 19, 2025 at 4:08 PM CEST, Danilo Krummrich wrote:
> When introduced, the IoRequest doc-tests did depend on infrastructure
> added in subsequent patches, hence they temporarily had to be disabled.
>
> Now that we have the corresponding platform device infrastructure,
> enable them.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Applied to driver-core-testing, thanks!

