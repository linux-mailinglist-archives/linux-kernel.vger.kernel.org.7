Return-Path: <linux-kernel+bounces-731588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC996B056E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7CB1C2386F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A1C2D5C7C;
	Tue, 15 Jul 2025 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rgYWSuiJ"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B1D2D5406
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572561; cv=none; b=NFpxY+nY9wFH2K22FMnGSOUcX/Ht8bVTUWHP1N1DFRVUPHO8GFK4FMvhCw7I3pXg0/q+LMwDbSdu7fKUQ+3P3u/9qpdGat4N10f/TSjHwlynSp8HbAjoo9N0NBtBaHNl3K3+5HZjWM/bg+cuQYcuvjR06VwKG6ihjXsgHBysWik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572561; c=relaxed/simple;
	bh=dlkAnhJaomQ2T0SdHCSA3+Gcau2eH1xErMq2ETxSbNs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bYIidPZAY2SRllA56H3qe9/6CD59yZj+vx89s/cqN8O+gJrsX6PxtFr3CoqDmaRp2tmQoqVj/4GAaEDfDrgeOJ714AlgiWcDneZZ1obDNsFyrNWLoj/OHaT0RFoE9b8s6LCmOABwhayH5QAVhwo0QTp/68vW0eHh26bdW+riXd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rgYWSuiJ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4538a2f4212so30182075e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752572557; x=1753177357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2KuGHyRPDvml4ocX1AZOTeZ8x+ILcOo5ktYP0sgC0Tc=;
        b=rgYWSuiJIaPFDfamKUEb1nfkMOcjLitlIH4WC4ejbYAO6qFhxIF+JQaqv69pXlXH11
         S7n/IDAgjkFaS3e3u5irp6YE29aX6/OVplC0S3d+VQkiwc3ycu11/1PjmjnDmtnTzbL2
         teGi7LDLDD+k/I415Sc/WNzupFHwzX/Rs2aqDsKF/B2AgQ0d6A77oidZn2WpTwEJZcBs
         Y4gbNj1OUrPVnLJ7cx/0zFWVRP+6R7jMpAyADKzYrzRHmzEikA1jGp6r+ES4MwV9Xj2p
         WlstSIcTHVbujAe1x/8fAJYGghm30+Zvnn7qZoSdLfjFPgpJK9JuSCSquo/n68GVisIf
         hdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572557; x=1753177357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KuGHyRPDvml4ocX1AZOTeZ8x+ILcOo5ktYP0sgC0Tc=;
        b=t7z930IyP2/zBMLg/aXClEqbdvMxCETt+PRE8UkEkZEbN77VL7f2N1dndIPlmG+Vps
         Y3PysRvDSxy4JOaV+y+R9qGmtKsPG9LyV83wo7wjLIM7TRGSCYqWUMVq9GachzG5bZEG
         1E9qZCWSOC78J0+m61k95S3M9jMbppGusyS1WP1hoxf2iA4XLmQWimokZuQGubHndIXV
         BqFvLe3mlVs8rRBFRRm8XygDyau/byxcBHUn7mpAHE9ZG3GftE2jSykbLLClxE93Li3Q
         TwsZ938v3WgZnx2ENoKHPcseN8y8QGFD1MWI26reX0W8plHkUqcWNXC5LDootprJU51S
         JnfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQBOKEi0TAXmphOlbERI1i2SfAVfZiU3ekfsQVYQKP7uJU/45A8N1YZJ3JXXiTICNmi7IEc+l9qH+USDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqNX2SAQlWKtESJb0a/76unYV15yFMdniWRngoc1z1ZAr6kkWo
	dJ5hxwDf70LDJ/E2Hp8FmLQR/L+oRecfYh5CU8V56UN37EU03rfCPsmx7GSbCEhKPnAnW5xk+ZV
	2jniaDAyoMepISFcVJA==
X-Google-Smtp-Source: AGHT+IHvE4UCK7PBe4CViNkIN5aZzxDl2kn27mYrFfsP21JL2dmQdQ6OGNbYYURJGhutkI27jESTUTpKnrenyiU=
X-Received: from wmqe20.prod.google.com ([2002:a05:600c:4e54:b0:456:43c:dcc3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e12:b0:456:21d2:c6f7 with SMTP id 5b1f17b1804b1-45621d2ca13mr44779585e9.23.1752572557800;
 Tue, 15 Jul 2025 02:42:37 -0700 (PDT)
Date: Tue, 15 Jul 2025 09:42:36 +0000
In-Reply-To: <20250711-rnull-up-v6-16-v3-8-3a262b4e2921@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org> <20250711-rnull-up-v6-16-v3-8-3a262b4e2921@kernel.org>
Message-ID: <aHYijICX_xuF-Mb0@google.com>
Subject: Re: [PATCH v3 08/16] rust: block: remove `RawWriter`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 11, 2025 at 01:43:09PM +0200, Andreas Hindborg wrote:
> `RawWriter` is now dead code, so remove it.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Could be squashed into previous commit IMO, but no big deal.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

