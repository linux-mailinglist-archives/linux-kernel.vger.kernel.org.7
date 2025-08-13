Return-Path: <linux-kernel+bounces-766128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1A3B2429B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E469D7B723E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9A92EA46A;
	Wed, 13 Aug 2025 07:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UaCgrkGE"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DE02EA159
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069759; cv=none; b=LWyW0kPMpQMg0wOIBPMBfQ59T9XO9/m0fAGz9u+og/LVbR/aVY45lVGkmMnM6msMz2uexvsAGC/dQSDWMvS3tPztwrEHyggsqg8UOMuphRRzMczW4taLKLgxs8ZYOpAf8NLIXscM+qD2cKyeyjfjIUwLrInpa5+qGhRXoDPR0zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069759; c=relaxed/simple;
	bh=zHWm1Cr8otJn4ch9T8KtSHR/9iyJgWcpch+TdzYFzag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o5gJKLJDVZt+RioKKSAbtIM7fDEqw5oqe4OSZHylj7Fgjeu3CeMsNfm+CVOsOwRzMwlfA8xIPL6DfigtmmYRa3B3s4j36ngZcS4vB53BBwfQ/XbTLZPlXFgvS79XPC1rxeQ78BcXa4imw2ndh5Rr9Tl2ushEILwFAXezDasQVy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UaCgrkGE; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b78a034d25so3213942f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755069754; x=1755674554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9OeJRKOtDCkvJ844r7dtJq3GmrirtFq/MoszLdIqFBk=;
        b=UaCgrkGE1Mm4fjoj9FnpHOeqNCYEdr0Cel9IOepexPC+PxwpuFWSDj4BffmpQff+LV
         UahLIpf4sFwQJmaUY4Bgj2f+CmruU4uVRNAcihtbBcUkgl4hv2EG5yeyg/I/Q8tPsE1p
         A1Gu3ALa6TEpa8S7MLkSNnsHNoOsuh+sbSOi5YM3NgTy/UF2/KuQfiD4jnvemfmhMXrn
         V2CXuIwyQgxMf9648QQdeDE9ugb8a4TD9J3FDWkIMu1+hAT+tCACirpzcg/S5HpyFXJc
         uU1Oulg/gQAQtSmfOH3lCBe9IdRmKj8OwRFINLaWCMxLiukBJmndixQYXSnKLPouOVhN
         uleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755069754; x=1755674554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9OeJRKOtDCkvJ844r7dtJq3GmrirtFq/MoszLdIqFBk=;
        b=BR2N3Ddrh8cLrA94A7awab/VtGu8aGtztcAh2tRltjJtwHd8Iyn+fT0k7CQpdDUEdO
         HGncX66nJcLKOkGLA+32BngegxW/m8pPzvq88EmyujEgn334HkK1nH8GeUpZglgJQ1Ea
         FtKMaKcR4Rma4zm/GF8jlnwDbHRORqXxisUuMyxANhvskcagf904ETbjxIPOQDTqvhId
         mtiAVj4I9mA48xoB/7BjyJ/TENzlZ7MV8e1X/k7NS+4x+u0/3ZOOz1glvKl9FC9eM6Pb
         Veo8OAFmCXuZSQbs6PytKUoT+4C4L8/etuHygLxV3FzCPM19CV2vaSeEjLuMr/K7i5/h
         a32A==
X-Forwarded-Encrypted: i=1; AJvYcCWWUTOYaTRDilG957WnrnBeM0652khc/lgQx+zmwhdF6NT7XQgPHdwh0LqwP2HogUAnUXGRiqPkbQBhDTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYh4hEBWJa4sc+w6WUZo8g4n+5Efse5KDy/qZWDJZ5AscQxIG+
	vIllk9LBQCsjZUZM+w6+RPiV2/VCQGrUF+ta+nKIiF+P7fjy/wLWsoetQCWHQQTLAG//79mAuqY
	YSs9SfwULAZ9dBwhWFA==
X-Google-Smtp-Source: AGHT+IFRoWmp1WD0PJKQpOnS88NN6unHtaV2+4xaLDTSiVc9zhHuKpVbFIj0d1eLOibGzkzdXMR34RAbSAcqANY=
X-Received: from wre18.prod.google.com ([2002:a05:6000:4b12:b0:3b9:95c:a591])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2dc8:b0:3b8:f863:672c with SMTP id ffacd0b85a97d-3b917ea0f3bmr1328010f8f.33.1755069754599;
 Wed, 13 Aug 2025 00:22:34 -0700 (PDT)
Date: Wed, 13 Aug 2025 07:22:33 +0000
In-Reply-To: <20250812-rnull-up-v6-16-v4-9-ed801dd3ba5c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org> <20250812-rnull-up-v6-16-v4-9-ed801dd3ba5c@kernel.org>
Message-ID: <aJw9Odr4Ik7RtdCd@google.com>
Subject: Re: [PATCH v4 09/15] rust: block: add block related constants
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Aug 12, 2025 at 10:44:27AM +0200, Andreas Hindborg wrote:
> Add a few block subsystem constants to the rust `kernel::block` name space.
> This makes it easier to access the constants from rust code.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

