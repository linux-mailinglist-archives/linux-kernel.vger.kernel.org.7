Return-Path: <linux-kernel+bounces-727729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7700B01EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05AAD3BF98F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843792882AA;
	Fri, 11 Jul 2025 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZmS8DE4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB4C2DCF6C;
	Fri, 11 Jul 2025 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752242829; cv=none; b=glt0CgEYx1C8sA3HYadWl6wMunQx/bLiEtAGmq/l2Gu0owGl/2+V4VREnb/V1sTl8dfpJ8qrhrARsO2DMLFd9lv86olu3lFwQ6gM+5HE0awbZHh/3HVuxYHUFO8hYQgDfDtkx4GV8hts7qUIgplPQNf9vesw4AsxN0CQBUjxygU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752242829; c=relaxed/simple;
	bh=dVpXeqmLRonURvzfr0IQwPPm++MfCDKX7tUK2E3Xgpg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=kgU+eLayjsudxclek8nUH0bw3BameGRjJPoamfpZL+21GdCPVJ7/HwbLVwy5tudeOHksa6RRoK5jd2v2OZT5JtGdJwBuZbTP3JhfSEAEy1ZVgemNIRHlA5qCAFphUguKp+lFZNUvYEXXDgDJkBlwmJcK2jG18fgqf0RgAMqMoj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZmS8DE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCE3C4CEED;
	Fri, 11 Jul 2025 14:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752242828;
	bh=dVpXeqmLRonURvzfr0IQwPPm++MfCDKX7tUK2E3Xgpg=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=IZmS8DE4qSbtKmTm1CG914y6A2XQ96csOKsJuE4nxVidbviSw3OSPnFKzWoPRzrsF
	 Xn7jYNBD2Dzvw74a4FpmiCNARJ5pBpN3yMzOQ+MaJTcyDAd2CoWBLBSDF+Jhfdqirw
	 RYRrOy+opSvoix/5YBC818q3YcRYpAJzbj99nxpoLYrC2G2KE0UoXKf88nrv5ONSJa
	 /cu6lHwqSwoduXXWo+KWuNO2xumnLdNZGlOK0mdVr4ilK0DZzYE++Kaz5qeSGYEPhd
	 TafLJYqg9IVZpWmNGqLZbLM6IVdFxBFBDmL+SEEi0iWv5LKWfYsYzCDXt4lJck4KKr
	 tqsL6WgiNjWyg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 16:07:04 +0200
Message-Id: <DB9A8OPZK3DZ.YVQPQQSD12MU@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3] workqueue: rust: add delayed work items
Cc: "Tejun Heo" <tj@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Lai
 Jiangshan" <jiangshanlai@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@gmail.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Benno
 Lossin" <lossin@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
References: <20250711-workqueue-delay-v3-1-3fe17b18b9d1@google.com>
In-Reply-To: <20250711-workqueue-delay-v3-1-3fe17b18b9d1@google.com>

Hi Alice,

On Fri Jul 11, 2025 at 9:59 AM CEST, Alice Ryhl wrote:
> This patch is being sent for use in the various Rust GPU drivers that
> are under development. It provides the additional feature of work items
> that are executed after a delay.

I thought I commented on this in a previous version already, but apparently=
 I
haven't (was it a different thread maybe?).

For drivers, we should also support 'scoped' work items and worqueues, wher=
e
'scoped' means limit the lifetime to the driver being bound to a device.

For better understanding, in C one would call this devm_alloc_workqueue(), =
which
would guarantee that the workqueue is terminated on device unbind. Similar =
for
individual work items on shared workqueues (such as the system ones), which
would be canceled synchronously on driver unbind.

This is very useful for drivers, since it allows to provide a &Device<Bound=
>
within the work's callback, which allows drivers to access device resources
safely and directly without additional overhead.

