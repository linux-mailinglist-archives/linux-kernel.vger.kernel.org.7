Return-Path: <linux-kernel+bounces-860568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02610BF06D4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7333218A1D23
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CC4227EB9;
	Mon, 20 Oct 2025 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWTQj9Hu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695BF1D7E42;
	Mon, 20 Oct 2025 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954870; cv=none; b=soUWl4NbpgJ7G2Noz8HV76CZeE8ZN3N8T612RZdOzyUAATeDvyeWEHCaoHsvUNhOmroPlZHNzTQozoI6A7M8S5LHnnxhdLbTCsuKDnw9x7morTgIhOO7V+cZ8IyeTBv/j3mDuu24mG6uJXkmP4gwwHKzImNyQTUUHeNjuzMIT74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954870; c=relaxed/simple;
	bh=0M7psceSKNec+BNMfLQd3dOi35kp0PFPiLzND396b0c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=adubLhPXCdyZcVDGImFswGH+gN85/Ciqi2im1FGRStw8oB/M7XtPkqOp1HAaIPkR5SfQeB7aDOHtkOVP9oZFQeRSmOZrArnjET5cp9iMb4cYKVZYI9rTC5GaAuTHXUQ00wgx5sUUlulx1XuOGhmT+NRdtZZ55Y2zZJ7MdHVslaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWTQj9Hu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B68C4CEF9;
	Mon, 20 Oct 2025 10:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760954869;
	bh=0M7psceSKNec+BNMfLQd3dOi35kp0PFPiLzND396b0c=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=bWTQj9Huar+h/bXT8YwORnYlSdYowu0LZCXGtiX9QGAK9oR0xV4XoUw/SzQ/PMOBy
	 Z8fxL/cWMhvs5YC87okar1saPvO/0Q2ABk8pYCJsk1xEMnE13ZxGHfOeMIQGtRYpUO
	 1pQqeq/4jyZsTqWpnYZIYBPLwVUGS1WVajUS4jRBcTN/7XqfiUEf/TC87BwXtIVKhm
	 ei6O6AdN8C9biKuJ9A3bb6wSgX3eJBB9lE9ITo0qdQsVlYXy4vyA+XxAhi3QRKroCL
	 n6BrOLAmsvCetS8unVKIjnh4plrEHEp4gl9T1b5IQ0RGRNUQibnPXzhek2vftL7SkJ
	 c9rfVWEPYcB9g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Oct 2025 12:07:44 +0200
Message-Id: <DDN2EGMDUX8W.19VJKCEIPAMXI@kernel.org>
Subject: Re: [PATCH] gpu: nova-core: replace wait_on with kernel equivalents
Cc: "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Alice Ryhl" <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Edwin Peer" <epeer@nvidia.com>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251020-nova_wait_on-v1-1-2eb87fb38d14@nvidia.com>
In-Reply-To: <20251020-nova_wait_on-v1-1-2eb87fb38d14@nvidia.com>

On Mon Oct 20, 2025 at 8:09 AM CEST, Alexandre Courbot wrote:
> wait_on was a temporary helper function waiting for a kernel crate
> equivalent.
>
> Now that read_poll_timeout and fsleep are available, use them and remove
> wait_on.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Acked-by: Danilo Krummrich <dakr@kernel.org>

