Return-Path: <linux-kernel+bounces-769200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B7DB26B4C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77AF01CC64AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D09523ABAB;
	Thu, 14 Aug 2025 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+GbxeHA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8BE2236F7;
	Thu, 14 Aug 2025 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185898; cv=none; b=Rpm6DdBBEV2mpzjw4UKyCz+m7oNoZNRW6an/LaEMNRDvo0Ba5HTCJ8FBjTu7cDnxjyqGUCBgb0vonxinTr55Qc2MVDeoS6o1PzM9Ge8xpbd4G7dvQkRlpOo6F5HfqCO7mowR7RZRQPKjS8MNMhrlgIRpsmrIq214aBzqBbwg5Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185898; c=relaxed/simple;
	bh=1LcIUzqAaW6zCjsY1yHCk7sVqaWkzG1WY7/GcG7KUa8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WPunI2jNzRxww0oyZxJ0Qx5Ef1SXE6iHHloOKCmOcDGQWruzLgn2quWDswBWiUc8BgJ4z8WW7FaIyDDGqhnSa2J8lhO2/7Coq59kqrpNlYHaB1VU8W7fPkTLx+7U/I8iL8r6lMSGhDfRXtb9uSCSZ4cq4+DOELlqUeHkg82kimM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+GbxeHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D77C4CEF6;
	Thu, 14 Aug 2025 15:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755185898;
	bh=1LcIUzqAaW6zCjsY1yHCk7sVqaWkzG1WY7/GcG7KUa8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=M+GbxeHA/fwPi9Spwcg37O0nsyMZvnG1O2nkPNnteb0lvsFUzl4A24FRFAFeIYOD5
	 onpshTvk/UrsCJvSM4rJE3MdxlHkOx/hYMSU8T4GWiQiFqvjuHCFOuVrA4qnD3iJ47
	 Q+L/SJkUdqNQtY/dm6OsMovrZhuu5UtWKK4ajSpj/CJyaLXdtBsmizajvNk5iec3d4
	 KW8W5MwI7XGGvHBrD6I3m8zOZz0DvKc27o5OCD+QCniKM1WVDsgYyYoaAbKRS75gzF
	 fjcSQlje2h5BlKXqkMGZVA+yIifx6/G3TvMbY3XrRc/AeABbQo1gE+PZg/XRuAunJf
	 qOS9qCljx/IoA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Aug 2025 17:38:13 +0200
Message-Id: <DC29H09I86EP.1WC5FDOG2NMN9@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Fiona Behrens" <me@kloenk.dev>, "Jocelyn Falempe" <jfalempe@redhat.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/11] rust: security: replace `core::mem::zeroed`
 with `pin_init::zeroed`
From: "Benno Lossin" <lossin@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Paul Moore"
 <paul@paul-moore.com>
X-Mailer: aerc 0.20.1
References: <20250814093046.2071971-1-lossin@kernel.org>
 <20250814093046.2071971-8-lossin@kernel.org>
 <CAHC9VhQXOezJ2=B1BQOqLgfuzDJEVS5G_r9+_bQ+OUNTpjZCKw@mail.gmail.com>
 <CANiq72=vhPsGjSx9u0FvDa6uzMFkFQFP9qG+DhtZ_U5TyV=bJQ@mail.gmail.com>
 <CANiq72k8kWHeBGLgHVE6vN36n6ashq-TVX3+h6WxLtc1jpUefQ@mail.gmail.com>
In-Reply-To: <CANiq72k8kWHeBGLgHVE6vN36n6ashq-TVX3+h6WxLtc1jpUefQ@mail.gmail.com>

On Thu Aug 14, 2025 at 5:33 PM CEST, Miguel Ojeda wrote:
> On Thu, Aug 14, 2025 at 5:31=E2=80=AFPM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> I think the idea is to take all these through the Rust one with
>
> Or through the pin-init one, which gets pulled into the Rust one.

There are no pin-init changes in this patchset (in v2 there were, but I
took them for v6.16), so I think it should go via the rust tree.

We can of course wait with patches 3-11 until the next cycle and let
maintainers pick them individually, but since they are so small, I think
it's easier to just pick them all at once via the rust tree.

---
Cheers,
Benno

