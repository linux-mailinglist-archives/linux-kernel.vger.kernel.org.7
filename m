Return-Path: <linux-kernel+bounces-884732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E72C30F2D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12500189F75A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530582F0C71;
	Tue,  4 Nov 2025 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rP4Ho8Dz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEA12EFDBB;
	Tue,  4 Nov 2025 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258554; cv=none; b=SCbI0hR+1flG/9LEXGtUmO8m4nGOiZc/k3VfTUTORlPipOJSxrarlvjmRLgpOngPwBNLo1yy0gwYhm9NcAFSJw/c7RB9f67VdCbQRTlVm2onY05lDVuvrmASQsJw7Fa0a3tbCPtoKXFZ3b113eFRi83RIp6m9vndHx6H8ptZdvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258554; c=relaxed/simple;
	bh=sZJP4baAgorkdpZ/rOo/VoYMnev+GlGl+mNeRfTlRIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FFAfMygz1A+zuLWii0Dbf5tcfPgMq8O/U557U2rFnehv5HinOHx92QZYFyX4jCG767CzP+L52n3y1whN76XhMJaDZRnFJ1RL1wLwJbD/+4E4CNilCNQxhloWBdiSjYhmZ171mzJH2hLsbTl4Yli/7FuAoYEp9s03OgWe2dGinOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rP4Ho8Dz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D2FC4CEF7;
	Tue,  4 Nov 2025 12:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762258554;
	bh=sZJP4baAgorkdpZ/rOo/VoYMnev+GlGl+mNeRfTlRIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rP4Ho8DzstMOlJKN2rc++wQ7czOQmeyohDr5mnMUiAhE4//Ox4PXmhtAj8jso0lCb
	 TUGupR+/Ppt7rnFj2gRsfkKq94rROGt/s+hakfGOKL/QVlIrgoI3zgyOmEnjezD+bm
	 3BmhhLvtnczzGRITGQE3iMxiY1nejoi/+dAbCSvYKU9kIcDXV/v8J3CwjjK0wvvk4t
	 7Yp7qD4aFvmWy+hIBMU0JW45sja0Qj6NgPHsXQpQn+dmSWgG/cyKtOfOMD3PoFPxRv
	 0R1yUvpKKKG36e6ZyKTAEucZvpoBGkiS+azlpOTVCGSJHl9Em14nF1zWL9eBxs0ZoP
	 5/4K78oHFWKgA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, alex.gaynor@gmail.com,
 aliceryhl@google.com, daniel.almeida@collabora.com, ojeda@kernel.org,
 anna-maria@linutronix.de, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 frederic@kernel.org, gary@garyguo.net, jstultz@google.com,
 linux-kernel@vger.kernel.org, lossin@kernel.org, lyude@redhat.com,
 rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de,
 tmgross@umich.edu
Subject: Re: [PATCH v4 0/2] Add read_poll_timeout_atomic support
In-Reply-To: <41afff31-0483-423f-9f10-9dede1fccc1b@kernel.org>
References: <20251103112958.2961517-1-fujita.tomonori@gmail.com>
 <41afff31-0483-423f-9f10-9dede1fccc1b@kernel.org>
Date: Tue, 04 Nov 2025 12:26:44 +0100
Message-ID: <87h5va82dn.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Danilo Krummrich <dakr@kernel.org> writes:

> On 11/3/25 12:29 PM, FUJITA Tomonori wrote:
>>   rust: add udelay() function
>>   rust: Add read_poll_timeout_atomic function
>
> @Andreas: Mind providing an ACK so I can pick this one up including the udelay()
> patch?

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



