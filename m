Return-Path: <linux-kernel+bounces-739251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FACB0C3E1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C6B3BA83A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28AB2D3742;
	Mon, 21 Jul 2025 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3noD053"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1332D0C7E;
	Mon, 21 Jul 2025 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753099999; cv=none; b=i1E1RfhuwWPtNe0yJWe9roIDPwbgvWYmGN7qnr+Wv+eCqnql4+1xPtRrOp+5yfHAnajFcxZ9X5cId5FfMgoRjbkAl65GhO+1iCOGsKOWWdcjaNTswr6zBUNPwkSdQq7LeCpYbMMDW+kKWXxSsz/5YTCUarC/0Q52TxJmg1CSrTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753099999; c=relaxed/simple;
	bh=u8UTmNNVfas1iThMeHBfFi6Lpp2ebrw8WQiuOJvC1Ow=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=WfZcEOnXQWiahHBA4CCqTnpZKbwK7tf2k9bbASy32Dn1yvIYAaekAkBM9yfO3GW1Z2xhAkPaTvek+6b8sNCrshFrvMMYHgw8gYyWgYpdrTDkDPsciGhgjadA3IVrEf6YBHR+tWg3FFBZnTFA4uWq644takqbMKcVicGsZn2yeYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3noD053; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37ECCC4CEF4;
	Mon, 21 Jul 2025 12:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753099998;
	bh=u8UTmNNVfas1iThMeHBfFi6Lpp2ebrw8WQiuOJvC1Ow=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=c3noD0534WoM16ejSp+tS6w7M8GrQwMxtJesCf2swGjVeniYVy326zSP5SPzC3g0Y
	 lFppHPRt4GW4qmvjQpDIUH+c9cqhyT8WkO/DQNVlw01Cq9sHsMP/tqCkFvpT3Glq2v
	 LfS430ETT4AsQsx/gne7uAqY67PJalzhUzeeUbXPxZ/BXyiicXjEvFULbM5hL6ioqO
	 6yJf1fiAoPMRFQvswAQJlQVobgeK0hIfVVpMsffvDI0gQ01pxOuPeaDoEUlOMV26Ii
	 73kgvgDAkAr614feE/zrqPcKp32nQ/LcXhy/XzhmK1jznJziYjy4S586WlOQiXzn9U
	 cbkyjSbkLnT4A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Jul 2025 14:13:14 +0200
Message-Id: <DBHQ2ZDUHLSW.LHWUTFQO1E60@kernel.org>
Subject: Re: [PATCH 2/3] device: rust: expand documentation for Device
Cc: "Greg KH" <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250717224806.54763-1-dakr@kernel.org>
 <20250717224806.54763-3-dakr@kernel.org> <aH4juIVmj8euE1CA@google.com>
 <2025072125-twine-curling-db0b@gregkh> <aH4telYyyexiMbjx@google.com>
In-Reply-To: <aH4telYyyexiMbjx@google.com>

On Mon Jul 21, 2025 at 2:07 PM CEST, Alice Ryhl wrote:
> The connection is that to request an irq you must have a &Device<Bound>,
> so if you can only obtain a &Device<Bound> to a bus device, then that
> means that you can never request an irq for a class device.

As mentioned in my other reply, a class device never owns resources of a "r=
eal"
device such as an IRQ.

A USB device, which represents a real device on a bus, is a bus device, in =
your
example the class device is the input device.

