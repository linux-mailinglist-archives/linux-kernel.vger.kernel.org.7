Return-Path: <linux-kernel+bounces-806610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DDAB49949
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F6D204747
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B17231845;
	Mon,  8 Sep 2025 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIbjSsh1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF5B1799F;
	Mon,  8 Sep 2025 19:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757358223; cv=none; b=Wz/mrDlL9SoXhiU4CUs1OeGDXocWtjwQ8GoD/UW31fSnl2Oaez3H80wUk1dAdXh98FgsiH9ZerIsxzqsD9jeARRmYmFiR6xSbnNjKQZBhI1NDWUYOj4YStgOJ0jWlh+S7OeVY482wXHKoA3aLiaihA9BXi+ypLsLgzt5tMm+H1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757358223; c=relaxed/simple;
	bh=FAKaccstvO4Vvs2o0rl2VzV7mpvYttZ5v4enPtxe8eM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cv6wbp4MVUcJc68jQY5WpA5XSAFPPL08NtYWgLIpe9S/TaEhJsADe2N1bvk/tHB8PitYIg3BcEHKfNAuShviRG9jODyQmD5iKjBJAehv7PEmAKtHyqxDlocQ0JD5qpyntd/tYCSXaYFfLtfQux3hUdy9WGervXvmRLs7TcL6Kt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIbjSsh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E15C4CEF1;
	Mon,  8 Sep 2025 19:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757358223;
	bh=FAKaccstvO4Vvs2o0rl2VzV7mpvYttZ5v4enPtxe8eM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nIbjSsh1AZogOlomA5Ho4DXssuONsk01mhVPUx8RidoVnlVllvVP4i655aqK4OYUx
	 cLwYUzu5AlQFmYLH/5/kzupZ8BgPhfs778o9xlCdHrxg1A8RieJ41pWeqVPfVb5Zoz
	 azhz0be/EgzFUumjx1qdxOhBxGkpLzaTJXJE6Vb6N8DY6LNU0QJovQ1nSVKwlAIhu5
	 uwEPU1ZbRq6czffbNBC8xLqhl28TRX1WCgvvvye//6wwQTcBvpxguOuyybdy3kty0W
	 JQHodHuiPcyvllIfU7Et2T4qmrsoidnkmDXeaxINT2CihhhN3bt441DkYpda6kk3ET
	 mOSh0pK2ee7WA==
Message-ID: <3c071f0c-2657-48d6-b2e3-59fec51c1804@kernel.org>
Date: Mon, 8 Sep 2025 21:03:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] rust: drm: gem: Add DriverFile type alias
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina+kernel@asahilina.net>
References: <20250908185239.135849-1-lyude@redhat.com>
 <20250908185239.135849-3-lyude@redhat.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250908185239.135849-3-lyude@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/8/25 8:46 PM, Lyude Paul wrote:
> Just to reduce the clutter with the File<…> types in gem.rs.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

Acked-by: Danilo Krummrich <dakr@kernel.org>

