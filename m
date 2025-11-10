Return-Path: <linux-kernel+bounces-892894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 297EFC460EB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3701890FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C996C3064A3;
	Mon, 10 Nov 2025 10:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZPxsn+u2"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539C4288C22
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771856; cv=none; b=evZQqt/ohGQbnES3/ungAGP6xCZDOxIx8eqMrkXZkY/p0xsgLpK8b1CDjRcJUHRCfHiSgZOQ1quy1Y+9BbYRk4VA8j3ktqYnFX94D7pae0xxHaZalwjL/fyFo5TxQicMwZ4XtP2wDii7UBUfBeGDsUIonGicaEGEKAwjPvrSWD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771856; c=relaxed/simple;
	bh=QuvzLQvjJhrJPEv2EiWNZ0BlmMA56gk0ZaiE4mu3nUw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dniiZOloXUS0j3Hj5cjfkOzzFuKsSXr2YJytB9Zo6jMXlXMIbF1CJ7BQ2MYVIT94+HH13gRmr7K/FpI2bRN1GRiTu/aBMhtggO3AnlWfFTQdcswS3Lwu/hF/4tszY6uy/3webv067W7ipkgv9y89rA+21s7avlaYMMxI3XeneJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZPxsn+u2; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b6d35430f56so241863666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762771852; x=1763376652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jAehjyaMCP4/3fDkR7/7In2PF2fJ4VvVwolrpLltF9s=;
        b=ZPxsn+u2ZATM1esOgyuV4f5Wv/lwph1n4AP8h7MO47bSkcn8tBKUIUpPPmZap56jkR
         5DOrkKcZxUzHyykTk+nPKBMs2KEjSt+5mIRh/d4mbVXreOiUi6xxstfpWbm9OKssLcd6
         /k1XA+nI/63ILdM2Bdq5mWrbI9f3Ilmp8gCwnvs7otalv72rnggQonAfuHiQYZ6btYLX
         jto0oAALSW0mQ8903qULfvuaovN7eCdCn+DzVPRVF7EbXnIYxgMKwvb3ssCY2ht5MTXI
         toWFb6tTfMk4hxnUmwIVyd5dKgCSVsi2h52ENzRHblyLgOcXW4AgR/rjtlWBLVdxSKA6
         HHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762771852; x=1763376652;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jAehjyaMCP4/3fDkR7/7In2PF2fJ4VvVwolrpLltF9s=;
        b=K+s4Dn29easzyLQ+5ENF6ANn+UR5aXM5RiYVbuJhUH5eFoicKa4d+CsAk2aZTvZyGR
         ESfNI+P9amZFj0jkoxhpB0QsVw8V0NbJLsYsWi3fjnALRHKfSo+v6d3cGya5M/ggyr2g
         MWgQRKe4yKiCovs+NuhrsjswZcv1Ysd3hyzzdHve8kXXQ26Q9XIJHOKAvlROxD38mG/0
         rKddDf9OHpf40cNhS8gIQUW15CFc4tARnVbzbhc2pbSqZDSCGTcYthZQ2z6BjYO06M8y
         /9bgm0WZxdBY+uwyIykbciWCrTs4gyuREwnh6EBXsVUZ0s4b1Ge3nhf4NwvTKOSNe1Vl
         s12A==
X-Forwarded-Encrypted: i=1; AJvYcCU2W7YNKZIPvd7K6uSYmOnM/zhggcBnZC68zGVvEdC4dyCAcIpDk25B5qN3BgnlhlEmk0wL6k/ilbXRUwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ky35GYKdSImDFWRuEDkCn4ygbYxT1S6eipcjrCCttHh/pXZC
	u56SbGX+geO7bXUOXagKhVRT/fuuUCHrEex3t5BquEmg7j6Xx5mQ9AXepM9KCNwABMvptUwGiO+
	A6eexh6FydPSEtiVWag==
X-Google-Smtp-Source: AGHT+IHAxf8vIQMyFMTQjQQEpwFvS82i11CDs38Q8zhN6iIl6WZ7bHyAX4vTa1PqPqK6uf3c9yj3YRaeI9ccAqo=
X-Received: from ejctl15.prod.google.com ([2002:a17:907:c30f:b0:b71:a2e3:37b8])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1c03:b0:b72:9c81:48ab with SMTP id a640c23a62f3a-b72e050415bmr723371966b.59.1762771851712;
 Mon, 10 Nov 2025 02:50:51 -0800 (PST)
Date: Mon, 10 Nov 2025 10:50:51 +0000
In-Reply-To: <20251110095025.1475896-8-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110095025.1475896-1-ojeda@kernel.org> <20251110095025.1475896-8-ojeda@kernel.org>
Message-ID: <aRHDi9phG8iz14SO@google.com>
Subject: Re: [PATCH 07/18] rust: proc-macro2: remove `unicode_ident` dependency
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

On Mon, Nov 10, 2025 at 10:50:12AM +0100, Miguel Ojeda wrote:
> The `proc-macro2` crate depends on the `unicode-ident` crate to determine
> whether characters have the XID_Start or XID_Continue properties according
> to Unicode Standard Annex #31.
> 
> However, we only need ASCII identifiers in the kernel, thus we can
> simplify the check and remove completely that dependency.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Verified that these match exactly for ascii characters.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

