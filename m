Return-Path: <linux-kernel+bounces-882777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF33C2B707
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15AD13A194A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A1C30277A;
	Mon,  3 Nov 2025 11:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6tG7Isp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167391494CC;
	Mon,  3 Nov 2025 11:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169677; cv=none; b=NwqKRe0m4z1MOTZw0aD3vZvdO3I3Xz6EPpSn6rhaP0gNmhUnt02/2HPA/cXpM1TUxEYYWRJ43pMljqOJ7SnG//kULg2RSxjVAW7N4vBMCdv6W57OBOP/C75/kliFqaaDrpkAzqcmOJg55RDLLhVnlOGxsjuaZgU3Jl2wkteh5rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169677; c=relaxed/simple;
	bh=OMeoSoV7FEFdPkuCN/amC8E9U4TeetZo9Y1tnRpJ0j0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHf5ErDGWctrtGfseOs0+YGly64GHGqh18k1a1J9h0zF6LTsk38HMtlLLtPJhnigqo6bVl7aweu/b/L0os+BOCzIfZ8Ibe3rI/GDx/1p1SJtJD35rmT8BOoGuK+YJyo8LVAU/ygxnVYD0xHA1zExtk4v0jxyxbEgJ6B/O26ikZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6tG7Isp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA435C4CEE7;
	Mon,  3 Nov 2025 11:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169676;
	bh=OMeoSoV7FEFdPkuCN/amC8E9U4TeetZo9Y1tnRpJ0j0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k6tG7Ispr1jGdUvlCt0BHxsNs3dK5T7a2Q1Mj3FgzMsrDx/WeLKI0beYX9AnA+Mba
	 uIbud6+cPo0b1CwD3CXsaWUqHvQacUstEyTuLXnePogNNhod2iYzu7MgzmKgARodIk
	 RlYUe6WjVFjHUXm1OJ+yhKQQEkPM34gfHO+S/J4X3jde5uPX7NfkPtqE9/3cOqbw8X
	 Qu4VTi8cei6rUnevdO0WDi1YyLHPPGXOgisnUGP5mvrNv2WVdSnuUQ380WchgJ+dL5
	 QPLEZt/ifgpxFmAo10Gn6Pt/PUoqduyRFfQAEgMREOELc9fVves6h6OIbTHnMRmjcR
	 8DQQ2zVs1cOOg==
Message-ID: <41afff31-0483-423f-9f10-9dede1fccc1b@kernel.org>
Date: Mon, 3 Nov 2025 12:34:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Add read_poll_timeout_atomic support
To: a.hindborg@kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, alex.gaynor@gmail.com,
 aliceryhl@google.com, daniel.almeida@collabora.com, ojeda@kernel.org,
 anna-maria@linutronix.de, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 frederic@kernel.org, gary@garyguo.net, jstultz@google.com,
 linux-kernel@vger.kernel.org, lossin@kernel.org, lyude@redhat.com,
 rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de,
 tmgross@umich.edu
References: <20251103112958.2961517-1-fujita.tomonori@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251103112958.2961517-1-fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/25 12:29 PM, FUJITA Tomonori wrote:
>   rust: add udelay() function
>   rust: Add read_poll_timeout_atomic function

@Andreas: Mind providing an ACK so I can pick this one up including the udelay()
patch?

