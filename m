Return-Path: <linux-kernel+bounces-723674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A92AFE9CC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4DB585FE6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D51C2DEA7B;
	Wed,  9 Jul 2025 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bqBlbIOI"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2452874E0
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066896; cv=none; b=StV8O3MAvkdV2T1LxyJUWz16kDkOFIRjrr3sRIPD1/rsAf8ZYTEdHSn6l3Zy/NUON0uUVuTvWrXGpSjTNneKgygy/Xd1qu5MXiEQnBDGMazZvzZRPlLl6Qn1MgTQCcWJ5zs4bqkCruz2gSpevzZb8NEF5nEYLvA7yhktSC79rj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066896; c=relaxed/simple;
	bh=W+dKv/OILAWDNbhcTCFP1hGgC+67NpjoeUsnxn5ZeGU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uHyMj+LcmJcZHCr6HNDlLyClVmPt0bFWtqUbI+0RZkjHFlwWeiSIlmz6PS26vR+jloPeoPeBZYhybdGJQ77ZZU1DmA+LWwmL9qbhgybvlQQskMryDpbpt+hDetK8FFEWyWnGtTDnZmdNOLR8QOXFxL4jSy9lxKnKAb/hh6Em9/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bqBlbIOI; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4536962204aso24007795e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 06:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752066893; x=1752671693; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N6bM68ZXZdOjcEM+X0vttOiWXtJPLJGmyTWfeRHvOMs=;
        b=bqBlbIOIhfE9Zy++tztmCWZPimabQA7hxenoKoKrjSVRDENrkRjOr8hjvRn/ncR92s
         mnteGgQokm87wtTfMQ3wWbPES/ehWK9CRkH2SD8eKHp32tda9VKPb6fREOVpPJb1kUVr
         xXQ9mOnkscuiNHIdpJeM7mZSALYMKBxbXhj7p4RK6nTuDMFt8PWf4HVW7gbAJCYkt+lL
         Wdpllqo4hbsbnX4ufvcptUhCj1ssP9L+4hTBzkSfPbxvUOQbJFFG6h96qWBkIHV1W4u8
         cKuWiy1yRbuj1bbPe4PPRXg4amD1PFnSWTMFSRuqMSHcN9qUS46rkB5JgjZauRt0Qgie
         8G8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752066893; x=1752671693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6bM68ZXZdOjcEM+X0vttOiWXtJPLJGmyTWfeRHvOMs=;
        b=HUdytBVdJWc/m9N33NHtPSCPv3TEsPI0JT+dnt65fiNNgkGqO+lSaUtKv7bgdWi4QM
         VfASAycPliAfbycoKbFLd+eWFAjBeo5o4uJd+9tmKSEnFU9A32ddXSjgNW8iimeM5Mod
         qmeO+7WOFJ/pshKya0DtLdvVvgzGjjUQEDRodAmf616nYOTGWnRDB9zKmAD4187iyHKe
         UU464FQHZPXgyky5pnUu4LbQ4aDyv+vM4i4nBsIvyC9IUExdccpZ2NTIz/WSutsqEQ7q
         qqigJgwz0uqlWf28xPh5Xxg8O+JmBgz3mj3E8iCOFxIX31/d20uSA5A67UotCkwl6OXb
         7Rtw==
X-Forwarded-Encrypted: i=1; AJvYcCXVbvxDlikzi+/YmHk2FDPKI/1cogRbVkIQEBAVLwMfV5BIzdMtuseiHmLvuncoazB4VFa7kpr7IJlFvZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOEAmE1PmXjuUa9JMozJsApTSIjmieAlv9oC2R/322nMa+DaJd
	jmMX3sTK6jaqK+WwhBuGdUm8voR70hYNTOSSFegH5xIhxYpD1WiB8hAFprcWgxl+8CYRxneNBs+
	URwitak428GDetvU2Dw==
X-Google-Smtp-Source: AGHT+IHnmAAJG3RJlC4ROAU21sZqv+pruz2DzGzFq+8FpI0+2cgAxpyO20tNdvivqrXSxhzp0D2DJS6T08OvLvw=
X-Received: from wmbhc16.prod.google.com ([2002:a05:600c:8710:b0:43d:9035:df36])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c083:b0:454:d975:6aa7 with SMTP id 5b1f17b1804b1-454d9756eb0mr6844005e9.28.1752066893751;
 Wed, 09 Jul 2025 06:14:53 -0700 (PDT)
Date: Wed, 9 Jul 2025 13:14:52 +0000
In-Reply-To: <20250708-rnull-up-v6-16-v2-2-ab93c0ff429b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org> <20250708-rnull-up-v6-16-v2-2-ab93c0ff429b@kernel.org>
Message-ID: <aG5rTNGn_NbnCISe@google.com>
Subject: Re: [PATCH v2 02/14] rust: str: introduce `BorrowFormatter`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Jul 08, 2025 at 09:44:57PM +0200, Andreas Hindborg wrote:
> Add `BorrowFormatter`, a formatter that writes to an array or slice buffer.
> This formatter is backed by the existing `Formatter`.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

I don't think we need a separate BorrowFormatter. We can instead add a
lifetime to Formatter and give it a safe constructor from a mutable
slice.

Alice

