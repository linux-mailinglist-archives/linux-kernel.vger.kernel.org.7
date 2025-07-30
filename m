Return-Path: <linux-kernel+bounces-750327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A8FB15A17
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B64E5433E1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A2E292B3D;
	Wed, 30 Jul 2025 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yjHuj2w8"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512AC290BCC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753862272; cv=none; b=K5nwAhrJp2kStQR2/5ajz/EJFsob1TqJqW9e+apgeYB3k0XgTtxgC4cRam3G88qO2wU3avMV+Q5LxazN81sPVo63d/yoqyzDxzFRU054tkFY6jaAXgD2ttW4waoYrq0k48wecOUognmOMw9m7bS7xK5VYTtkQHI5jB03UtSvyFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753862272; c=relaxed/simple;
	bh=smz0s47ENzWJoVfL6gZB5jmHbvR//Sa4vQ9XJgjD1+w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=njlL8MwlcYO+xq18T9zxPy1LMkNXgfRLURD+e3aG5Y18UG3x9MKuFrr932S/1nWzlH/4N5tipsX0mr6rEgC2QsadF4XOlWLPB5cPKtkMr5N14EkBP34JYe3uAagyqn/VavN9eYYaz0mNvpkpmIYgPzxcFIY69xKggvwfmg4C9gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yjHuj2w8; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-ae6f9b15604so508917666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753862269; x=1754467069; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ibU44Ftq98mAdTatqw5GBxBTG4xcjjy5CLljWHMN/6g=;
        b=yjHuj2w8O8p2QS0gJCxMgEyhDiNsNWvkmhLpAXux7mK8JPVirSUuaLnUPWW5DMtfRB
         dhE+hC94aBJK80frGA+rXVXFmwTUx/AXoHEKdRq6RhMCj3Y08IyCNDeZB8UGhs0khUB3
         5XPNJ0VGUhJShHR1npu+Bj5ERc7hSLSbkPkaKAOktp1uVZx22eMrfrDomGLf/axRm6RC
         swiDOLdK/c2Z0QBisO6/R0WyO2NR84hX40gAPK4mUX+6ego3RTJgBkwDBM2rT6keNasQ
         dUtFqgq4pKmLIQWii8qfd343X2pW/m42G39hVURXTZLv3R3gxr6+0SxjIOArn7Dj1nPC
         ImjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753862269; x=1754467069;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibU44Ftq98mAdTatqw5GBxBTG4xcjjy5CLljWHMN/6g=;
        b=I+fy9whsfLZgWoRSZcMiX7Ugw75gDP5CYRuqsTskKbKJuGobU/LO0E1oSMiRE2bjXB
         n5itzAnoym+zBxeYouGtTnko/lWoXMbQO9mgam6uOWDxa+9nTJcQCgouM+dSTf/KD+px
         kF2uE03kUEnuoyTgsNUzUPeIvAm5yYryJkyWQR/Muv5msIVYU6hUrEQ49aHRLf6xDekC
         GX2MDKQYYtfSh1id3Y64ZY7JcMepEimgLGxR6CUgml0mtPtIZgqlwtQnLACv9oUof0+E
         F+e72BSfwyga9E8hNrnfOvA8iMFw/WBXzI2Wr1OGWeAN7nH8+gN9FPuuVIxlQ86UADuT
         TGSA==
X-Forwarded-Encrypted: i=1; AJvYcCUW5rmgPPzk+eKqGW87bDc8vYF4CGFa1lKwAENCDgl6qBMTFHZroFV9iKuf3iq9jnigYGgIBhDPF2UExRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9u9pUbW7sABkGI8vNmXBYlq5G7mkrHiG3eySOwPkz8B0g6/Lm
	gbj2bqEQqk7kkFWo3A/Gf7Z4EsRCYuQHi9SJ9TjR8sMQxUgcHUogDxkZ512ZR3Qlf1NU/IyrjCp
	CIxAGmvgLHy80u9Bt4g==
X-Google-Smtp-Source: AGHT+IEOVXeHC1r/hz+Tx2maJd+AAzxr+M2KzaJ+f1U+lCSeLVEGvFmmDtiCAtV/69p9x0JJxrpeeODxXzry/7k=
X-Received: from ejcvi1.prod.google.com ([2002:a17:907:d401:b0:ad8:9944:a3d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7247:b0:af4:dba9:3eb6 with SMTP id a640c23a62f3a-af8fd919a99mr303002066b.31.1753862269580;
 Wed, 30 Jul 2025 00:57:49 -0700 (PDT)
Date: Wed, 30 Jul 2025 07:57:48 +0000
In-Reply-To: <20250729-regulator-send-sync-v1-0-8bcbd546b940@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729-regulator-send-sync-v1-0-8bcbd546b940@collabora.com>
Message-ID: <aInQfMf02dfsrgQ3@google.com>
Subject: Re: [PATCH 0/2] rust: regulator: relax a few constraints on Regulator<T>
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Jul 29, 2025 at 02:31:39PM -0300, Daniel Almeida wrote:
> This series implement two related changes to address a bit of an oversight
> on my end on the initial patch for the Regulator abstraction. Note that
> this is not a fix, as it just relaxes the constraints on the previous code
> as it is safe to do so.
> 
> Patch 1 removes some needless &mut self for functions that already provide
> their own locking on the C side.
> 
> Patch 2 implements Send and Sync. In particular, there is no reason for
> Regulator<T> not to be Send, and as discussed above, it is naturally Sync.
> 
> This is based on linux-next for now, I am waiting for 6.17-rc1 to be out in
> order to rebase.
> 
> ---
> Daniel Almeida (2):
>       rust: regulator: remove needless &mut from member functions
>       rust: regulator: implement Send and Sync for Regulator<T>
> 
>  rust/kernel/regulator.rs | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

