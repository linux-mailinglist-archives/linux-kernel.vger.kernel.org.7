Return-Path: <linux-kernel+bounces-781764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6F5B31673
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E041CE517C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD252F8BD3;
	Fri, 22 Aug 2025 11:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sb5yOi/0"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFA72DF71D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755862709; cv=none; b=sLcPnskkN1XN4VCaYQE7i8f+EPdsff2Dms/Oky1QzVZdVcUocFXvVMiyVT8M7eOHCgbndX3leSS7So/ZIR/+PJvQXI7XrZXNqOrkXIvBLR9Tjvdr3LfwGY1DGeV7jy6OQ0+6sS+Gaaiy4zGy8E8yO9OiNCB72Ljpghrc0dqAp+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755862709; c=relaxed/simple;
	bh=tMxhlMKBLmpIIfChC9DTHzoovXoxaO2EHMeYyhq6xcg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q6iycaLwzwcsbghS2N+HsQCFAW+fK77T1IItm2Xt8CK5laXzwY44BQYbHfJHOcHEItHiPfFaSZ0oY2Kl5TxRhKq/jSZqiSWu35g7mfm89yrNmXSlGoNhHOUskIQ3nsxQfb5XS/66J8deMHSpeiNfkqu0cAVfJxeJRDl99uIaFus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sb5yOi/0; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1ad21752so9306035e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755862706; x=1756467506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A273qVlEBYHcOts4QcIpb1RGk5Tm4PY+pm6KzVGfp2M=;
        b=Sb5yOi/0SyEz3ngUzy7kOMCLoEPaHzAxTPl0JmSbKgrXmAgNFpwtkiuolBZEN7eTUn
         WMXvDEOs1tcdMAWTiHKONi16XmoCw2XmZKEtfur9SYDK6oSfSydikpWcyqjLu93YbqQj
         0g9aE2raneDhWre1nkpseknZ07hlwYQplbR2CZV88zoHe6ftnPenUd9SBXBvNm+Nl+X6
         wFqpstU5nntqlmtU4rEOZjQC9AF/Wx2gOEP7mY+Bz/MFipkanC2FQnJ1QqoUAcSAbG1s
         Sw9mNzHeaAL9879n9EWgM7qpb9BLL6OlVADSzSxK913PxWxybFgeh1nySpGX5pNZjwLa
         bLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755862706; x=1756467506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A273qVlEBYHcOts4QcIpb1RGk5Tm4PY+pm6KzVGfp2M=;
        b=M31ACDrt7KxbIgwYjW7rAXDPj48BDyDln6Ex3YG6VdByu+OZUBCfk3D+MK6VzaiQKo
         2HAUvnxiE1Pky3KsMbWqji4kwy8onthmXNdzcdVVxqZ9cKYGuXxTPYAsHrGNcbMAchB5
         plxt4aAlY/jjGsfTjPn9l+kJ7SraBAkbmZj4zU12oLBzMi8F2W9SFaBavK7taydUdUcZ
         7jg8nu5VOkko56NRvR9XU2kEdjUUTBKU4c7F8PWLrPUalFTLRuoH0f0DT95WEj6EfuBa
         Q+FFD35vFEAn1gHd2r79IqhBVRC13GrzC8AOmzghfWLH8cKUn/5kLRD0j6A28TwJssGo
         JbRw==
X-Forwarded-Encrypted: i=1; AJvYcCV6vWTZqY3rfYPwujYemkH3OUBe5YnAy+QTo8nJ6BioIIzHyJGLPS2uv/GmQGLillQoCtpMNkB88E6GLa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoSi4XSO6lWuYFrN/1dSrkSvjDysJ7fkB3uUDmatdUVgM1m9WM
	Hqdlr6PkUf/v4rLVPf/wMMO7xKC89Vz7mmmkbt+Pz3Q040ohFMBURry/NDBqxfh/rukZoJbCmzX
	esp/rP/xgBPdVUwERPg==
X-Google-Smtp-Source: AGHT+IHBOY0x5pOW581j80jySeLBkGqP9CFfghf7g5ufsksr9301sU3ONM+Wh5YM+Yrq+v5Uo2ButFjZu0AysA0=
X-Received: from wmbfp14.prod.google.com ([2002:a05:600c:698e:b0:459:dd85:efda])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4746:b0:456:1281:f8dd with SMTP id 5b1f17b1804b1-45b51791e8emr25943255e9.12.1755862705847;
 Fri, 22 Aug 2025 04:38:25 -0700 (PDT)
Date: Fri, 22 Aug 2025 11:38:25 +0000
In-Reply-To: <20250820165431.170195-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250820165431.170195-1-dakr@kernel.org> <20250820165431.170195-2-dakr@kernel.org>
Message-ID: <aKhWsTKUnFCG548g@google.com>
Subject: Re: [PATCH v2 1/5] rust: dma: implement DataDirection
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: akpm@linux-foundation.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	abdiel.janulgue@gmail.com, acourbot@nvidia.com, jgg@ziepe.ca, 
	lyude@redhat.com, robin.murphy@arm.com, daniel.almeida@collabora.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Aug 20, 2025 at 06:52:55PM +0200, Danilo Krummrich wrote:
> Add the `DataDirection` struct, a newtype wrapper around the C
> `enum dma_data_direction`.
> 
> This provides a type-safe Rust interface for specifying the direction of
> DMA transfers.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

