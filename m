Return-Path: <linux-kernel+bounces-889796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D5678C3E897
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 06:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABA6B4E7165
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 05:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F1524466C;
	Fri,  7 Nov 2025 05:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="KbPVKILl"
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDECF50F;
	Fri,  7 Nov 2025 05:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762494291; cv=none; b=kgPEWQMEkKkpe9xKtkFTJsTfm0YIWH/ozSsNyn/HlrszCyk/9ieEBY+4ZQLM2bAx6LZ47ngXBS8D+6bXQNROiZcsdqZylD4llomWbkoJZXImGGBx8w/Hc3rFLy7t6yetvaurbuLGSBaYSwEmva8GjvboBwJpzHSLv9n0lPiUHBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762494291; c=relaxed/simple;
	bh=s3x8POj7fp9AJimEEYUdWbjwXZwZfT4W0JGXgP0Uydc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=peIJmlaguYeuxvK4x8w5wwxnXfj12B1I1jtg7XY68X5wTJ9SOzhWJVNVJtq2NQT5dsBG29mxrtPX3+nwnwRDzbAiHbHr6Ul+ewZbilk1kPkPceTTJ2NPeht91P5FJXXsFUxcjbSomm7Q9y1WIslutSVnJ7yMoSw1V7TFOB/SQmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=KbPVKILl; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c37:8120:0:640:c15b:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 8B6CD81AAE;
	Fri, 07 Nov 2025 08:37:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id UbfSYtKL6Ko0-Xdu2k5Oe;
	Fri, 07 Nov 2025 08:37:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1762493854;
	bh=M6pGHVl4PoEe+gGfxwEyT3ttybUZaq/N2I4HTt6yjAY=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=KbPVKILlAGeHh3dVwlPEHykfubhwYJ73+FRM971+sW+dOqbvLKAa45OsXJbN+o6/C
	 q3qNdYPrDknChqG989zNAy5jQAISHYDcyAeYH7bCJVoP2hC9zPoaR9gtoHZ2Udzdve
	 vjr+g+3nnwQxjWCHC7r4IAWuU5jVxQPuz3fqGNgA=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Fri, 7 Nov 2025 08:37:27 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Hang Shu <m18080292938@163.com>
Cc: ojeda@kernel.org, Hang Shu <hangshu847@gmail.com>, Alex Gaynor
 <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Charalampos
 Mitrodimas <charmitro@posteo.net>, Borys Tyran
 <borys.tyran@protonmail.com>, Daniel Sedlak <daniel@sedlak.dev>, Tamir
 Duberstein <tamird@gmail.com>, Matt Gilbride <mattgilbride@google.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: rbtree: fix cursor method lifetimes to match tree
 lifetime
Message-ID: <20251107083727.63c2e524@nimda>
In-Reply-To: <20251107050700.1086059-1-m18080292938@163.com>
References: <20251107050700.1086059-1-m18080292938@163.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Nov 2025 05:06:56 +0000
Hang Shu <m18080292938@163.com> wrote:

> From: Hang Shu <hangshu847@gmail.com>
> 

Jfyi, there is no need for adding this.

> The returned keys and values of cursor methods should be bound by
> the lifetime of the rbtree itself ('a), not the lifetime of the
> cursor.
> 

