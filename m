Return-Path: <linux-kernel+bounces-753081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E351B17E68
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88E5189FA4E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7251217666;
	Fri,  1 Aug 2025 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yj1HVORg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D069360;
	Fri,  1 Aug 2025 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754037576; cv=none; b=ASlRTja5SE/eJdi7vGfg+NNyHNs/KTNBkoJphIIfxt7SnHrgQ+ID1c0mMVOKlQkAqaH5kBUfW6t0KhkD+v1wkcyulzeB6dI2Py5z6ssq3UuurvFVnlOy3yMrV4viOm2SjXkaz3Y1BPsqXMxT8SMH+gZGpOHi+tLSl2XOUBygRfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754037576; c=relaxed/simple;
	bh=fwEs+YNB0mmqaVzWETcaj3WxZL4OqZ4tiIit5tDYPzY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=gH8LVryqSoYojL/moMaBJo70Xdg/MFDCv71rWojmodlv+ZRgsZ50B55dpaXTfaslQ4TLjzLE6LY7jKBRcHKN7CCOS4ra3ORehQB3Mn8x7ynE/AQGwYl29vCiG5lK80CNXo2G4tBwVZn97rqjbDWl3Etu8Un1bhU75I3PO498Qo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yj1HVORg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF98AC4CEF4;
	Fri,  1 Aug 2025 08:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754037575;
	bh=fwEs+YNB0mmqaVzWETcaj3WxZL4OqZ4tiIit5tDYPzY=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=Yj1HVORgU3qzloEwHSh7H5M4vTUuKWo3N+uQkFsdrap1Rg3hj3dyW2NxlOdAfqIXn
	 jJw+CJ9m/otswuWFkw5dZ2rlXnC6ge0etgCHLiyPEUycMEC+HJUt3ZQvsn6vcSIo7o
	 tP63wJZGZdRhR6RLCotvzYAYgyQr50PBXgrj9clCgfC4A2rbBdodiG7XzLAusW56Vy
	 lMRjF1ZUF8AI/GInq7DwzQRZT2fpbUu+aeLRvpTrrIL6Jo8MyrhNXKADZW67Bzu2ke
	 sBdTQW/YyuWwbARjKJY2UO5bHpb/yE1nTBNyhrIegD8hpnyEH3RwIVKhV4v3HDZoUp
	 7RuQHL093vyMg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Aug 2025 10:39:29 +0200
Message-Id: <DBQYFB7JA7Y8.1G2VWBTOP7N8N@kernel.org>
Cc: "Shankari Anand" <shankari.ak0208@gmail.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "Viresh Kumar" <vireshk@kernel.org>, "Nishanth
 Menon" <nm@ti.com>, "Stephen Boyd" <sboyd@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 7/7] rust: kernel: update ARef and AlwaysRefCounted
 imports from sync::aref
References: <20250717073450.15090-1-shankari.ak0208@gmail.com>
 <CAPRMd3nhDKApttF_wBU01es76NG=qAyZMAer_gjbbtTSH_FmSA@mail.gmail.com>
 <CANiq72=uDrg9HBVM97dgJGaC946Or964-2aF6OJVV0ih_vWuRA@mail.gmail.com>
In-Reply-To: <CANiq72=uDrg9HBVM97dgJGaC946Or964-2aF6OJVV0ih_vWuRA@mail.gmail.com>

On Fri Jul 25, 2025 at 4:03 PM CEST, Miguel Ojeda wrote:
> On Fri, Jul 25, 2025 at 3:02=E2=80=AFPM Shankari Anand
> <shankari.ak0208@gmail.com> wrote:
>>
>> Can this be picked up for review? Should I be splitting each core
>> kernel file into a separate patch?

[...]

> Having said that, I am not sure why this one in particular has e.g.
> `opp.rs` and `devres.rs` -- those are different
> entries/trees/maintainers in `MAINTAINERS`. So it would likely help to
> perform a split that doesn't involve different subsystems.

For reference:

https://lore.kernel.org/lkml/DBQYD7G5SOZA.2MSKKQWXTPCBB@kernel.org/

