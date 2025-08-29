Return-Path: <linux-kernel+bounces-791379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD53B3B621
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBBCA01056
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AB628032D;
	Fri, 29 Aug 2025 08:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xEDWOLTi"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8272857C2
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756456774; cv=none; b=djQ+hrYzCTOvwVDxPlt4YxeGifsiHzT4nVuXYPLmA753b2EEc/EK20yyF8JvECsq9QT9k9Q0xwuQzYpTWqpm6knQep4rDiRM4xA9PqtskwnJP5nMIfvFGcYq+ymzBwiyglJ+mZA88Vp/lTDYbpLssRUk6E5nkRAQe3anadvIzqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756456774; c=relaxed/simple;
	bh=ofdbL1dQDmdAjVuEgLtTz6fjrHzlLyxHt5yz8i38J8w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YJOfL3aV0hmRWBLeT0sTL2aHKu49LGJsR760ZQwvdOl79NVe1eFcIKpnJ6rkP3IRHte4IqtwwBe45l7H1zI2pkhvrjnSFVH4R7pgcauROCKSePbwGNhX9/xfpIM6lqIMaPvXBjYZqPOuuDstq8ONO6aho31TXq07l1b33OaKrFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xEDWOLTi; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b80aecb97so2398355e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756456770; x=1757061570; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7UQEvQJki2jorAxK4pPiRW9zu4FuyXo0Nk/MFVc+zew=;
        b=xEDWOLTit1UdQuamVURP5KKi1HXLZGl+EnsP2NdDScYA5wXp7mI8FOK4oRO7du8rtV
         m4NG9+sCMxsDI980ukIgXGgNQtEDdEPCd0GviNnAok+7wt0uc0iQddtNfg+YkPwcz9sw
         0OHpwTNVYMPys9QBpvINAHq5DUOKgqpvUQxOqgf+BGucphSw/Xwua52CMTOZSCpV0JFM
         jqwFlfsV1AhVD9p9jncM1Der8CYJC15Q+CkM7btp0BDgG4wOnKnUb0WNbJT7/FQZhQl6
         N5V8sq+d1UiQyxCx2DR9deuEoLJWMdniVjJQ/hUGE0hU6imZtrbdHZDqEDTIslfzNcvp
         z9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756456770; x=1757061570;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7UQEvQJki2jorAxK4pPiRW9zu4FuyXo0Nk/MFVc+zew=;
        b=Z6Ct7UZnU5m6e7JfV5PF3jYIWEHj8J1Gx7//UfeDS5ObmH6GnzECwLZzOopT5yx2iY
         Y8QHSVYxzYSoD/T0wOyiX8OsxHGxD9jLb4baASecykG0yukJNlLG2XbN/vVD9gjruxPF
         LSynSF7eEIQc6pWwcZjLLar21Tm1vGUHwFDO7XhMbt0ZNVMwRdF6Pry4dobzuW415FcI
         KnwMxxiZ+BBH2udOOFZqs3mRYn/xevpj1tbv3Rji9Okv20yvGr1O9IIZRgO4fGHmyZSj
         /b7S25mrzVUBae6KGXv3KeJeKI3u6GKrHf8lkyGipaD1uw359GqmltQwXnO4iYR8o93G
         NYZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTpUGUZlOiaEOC94hOAPUoh2j8Ozghv+Z0v2t8qn21pWkGz7dThZizY7ilndBfvpL7goAgw2IpZLMIIpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcLLMeZiEvNexojh132veimDWKs+ZdIclak5nBsM6sUVH+3zrD
	ogLpRCS9Hmm0I1AZRbFveCKEy1Qvqvzqj0u8GfwMrngCFbZ7Kwcm7E7eaCoFv6Wx3mmuwukJSKF
	1cBO7nUS70u0b4qe3gg==
X-Google-Smtp-Source: AGHT+IH3eYiN3fOA8XEY4ERscZ8isUlUhXtUHiGo3BZ8cQY2Ya/Sc9lUa6ETxq2sNQrBnDxAFOKNYLqb5kL+CSo=
X-Received: from wmbfa15.prod.google.com ([2002:a05:600c:518f:b0:45b:63e6:8e28])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5491:b0:456:1d4e:c127 with SMTP id 5b1f17b1804b1-45b5179cdf4mr239952455e9.8.1756456770629;
 Fri, 29 Aug 2025 01:39:30 -0700 (PDT)
Date: Fri, 29 Aug 2025 08:39:29 +0000
In-Reply-To: <20250828133323.53311-5-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828133323.53311-1-dakr@kernel.org> <20250828133323.53311-5-dakr@kernel.org>
Message-ID: <aLFnQbSq3O0R5X_c@google.com>
Subject: Re: [PATCH v4 4/5] samples: rust: dma: add sample code for SGTable
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: akpm@linux-foundation.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	abdiel.janulgue@gmail.com, acourbot@nvidia.com, jgg@ziepe.ca, 
	lyude@redhat.com, robin.murphy@arm.com, daniel.almeida@collabora.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Aug 28, 2025 at 03:32:17PM +0200, Danilo Krummrich wrote:
> Add sample code for allocating and mapping a scatter-gather table
> (`SGTable`).
> 
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Co-developed-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

