Return-Path: <linux-kernel+bounces-732504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE014B067BF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4545044DC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AEB26FA69;
	Tue, 15 Jul 2025 20:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsYyKRR5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A122919D081;
	Tue, 15 Jul 2025 20:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752611434; cv=none; b=NjIJYl/pmAANQMQ20QHDA8sdKvHGmhLMaPRnRpGdDe33mmKahXKOgeFUXEduPbySyXXGNZX+M0mUSkBwZenVgQjuBfkDFjfq+iSE4gkP+bNX+3N7S0oTGG+74c9+T0jEWQiuzijmbzRaRK4Vfoe2rl2trRo0xlfg3MxXlUSQi74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752611434; c=relaxed/simple;
	bh=7K6+y0ij5VMil3iEvSkd7pvZyXQmaStMVyFFUEeu8zc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=DuNRJ/vwZHdlcBLBmArD8y2Jz5X1MpoN2v8VlNrARKh4J4dVfbqubXzR9ZgHzmaRkB307XgTMRuyRWNhZ9f76BRurbE/u+nryVrD/Hh+DxMt5co7vYOuF/P5sbHHXheFJlU9lwnYoiY5/vBiTIcmWIMaIR4fUONx8zPTCqMo+0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsYyKRR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A12C4CEE3;
	Tue, 15 Jul 2025 20:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752611434;
	bh=7K6+y0ij5VMil3iEvSkd7pvZyXQmaStMVyFFUEeu8zc=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=VsYyKRR5ByX6dkme01E4wNfl2oIva428NDU2bTobNG5J4/DxZeQenAbGik/2SK97F
	 XoP5TTOoz0PZCNCqQ+uBDCnsclYb7EK9XJTbqtoTdVo1cWA/vtp2zT9aRKPgFzYW3k
	 b0vrjbgRcOCtPZ2tlZU7QmXuRd+KqZ8GC4gxU57oY1JvTLWB55i28gpXU4gKNanaAj
	 Oo3I+b++CSrb7qDd5WSNBuO0gszXBehJou94qmyckyJnH7ju2pOTjqMnieHwF+LO/T
	 4pyK+M3P6ZRC4gbXCWTmeuqtP1yOhkrDLH5s9pGoLkZQ0Va6glwNJhCuOc0COxGBD/
	 bvWylUkJbS7gg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 22:30:29 +0200
Message-Id: <DBCWWFSD33HA.3UQ4NXBZR0VX7@kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <daniel.almeida@collabora.com>, <m.wilczynski@samsung.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 2/2] rust: device: implement Device::as_bound()
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250713182737.64448-1-dakr@kernel.org>
 <20250713182737.64448-2-dakr@kernel.org>
In-Reply-To: <20250713182737.64448-2-dakr@kernel.org>

On Sun Jul 13, 2025 at 8:26 PM CEST, Danilo Krummrich wrote:
> Provide an unsafe functions for abstractions to convert a regular
> &Device to a &Device<Bound>.
>
> This is useful for registrations that provide certain guarantees for the
> scope of their callbacks, such as IRQs or certain class device
> registrations (e.g. PWM, miscdevice).
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Applied to driver-core-testing, thanks!

  [ Remove unnecessary cast(). - Danilo ]

