Return-Path: <linux-kernel+bounces-725157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C33EAFFB71
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2A71C83D81
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07BC28B7C3;
	Thu, 10 Jul 2025 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLub4zNH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C98286D60;
	Thu, 10 Jul 2025 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134190; cv=none; b=qSVVDYWGN+uCIRW/+pfM0L9LA3RqNH5NuC/orLHXkDuqsY5+dVJEaoyOZdedBfS/YgA0YQqC2TJ14o4+GHIU67SrIXjmtk1F9MOKHm++ok3UPGwK/rqy3e6HcNK5OyKs3K1LnGfB0QL22vkRyAhG/5M1nOJ/800mTKz60r3wEfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134190; c=relaxed/simple;
	bh=gWwCTWj8/ye+GcYqkYt+eJsLndJxZPwa9GOKRJ+B2us=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MCbCML3eTGv4FXVT1MEGXy1m+d0rlUdkPT3gClP7Qoyfr2KHIQ2q1p5wQGSnl43CJ6k3lvOJlrwiaTl+GkTnECTfQ5Y63iuvSgjFcT34RdbZKRG5fRYfDRQX/8WKP3O6PeXUoPL6LrDd46/OT9xPobfSmOsXWPINZ6YWYsNaY+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLub4zNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EF6C4CEE3;
	Thu, 10 Jul 2025 07:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752134189;
	bh=gWwCTWj8/ye+GcYqkYt+eJsLndJxZPwa9GOKRJ+B2us=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=pLub4zNHMe5iUM93IHo5AvuAt9AAb3K6sxWL6sm0BYcCzFXByO+xuhKWV+yk8J6oF
	 VmguuUXeZ0MD4kc1957nAb9ckm2eUStF35f5ew+tR0LfEWE502aHPqhe7aKNc5kv97
	 qFCEgW+8M3ssy+V4WTP/Y6ZI7WfTqFA3CDuYc5xT+DVTh+moTsj0NMbVbNRKHC2JVR
	 UD8kUmr/lSxe1wylVHEVH1v5GOoyu14p4wEgg4n7WjgU+K4sZs6fiybaqrOLI6+bP1
	 EXYJR2SsvUjISnxtN9tmuaK+ySwc4ifIe4ZzFVcMJqGh7m873F7CEe/4lDdzgj3/wi
	 xR9DzcFMs+OXg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 09:56:24 +0200
Message-Id: <DB87QCI31GLJ.3S2R9ZYP5XA75@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] rust: init: compile examples
From: "Benno Lossin" <lossin@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250709-init-remove-old-workaround-v2-0-a3b1be8fd490@gmail.com> <20250709-init-remove-old-workaround-v2-1-a3b1be8fd490@gmail.com>
In-Reply-To: <20250709-init-remove-old-workaround-v2-1-a3b1be8fd490@gmail.com>

On Thu Jul 10, 2025 at 12:49 AM CEST, Tamir Duberstein wrote:
> It's not exactly clear to me why these were `ignore`d. There are many
> others like this in pin-init, but I'm only touching the kernel-specific
> ones here.

Most likely a remnant from 206dea39e559 ("rust: init: disable doctests")
that wasn't cleaned up... Thanks!

---
Cheers,
Benno

> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/init.rs | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

