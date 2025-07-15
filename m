Return-Path: <linux-kernel+bounces-731587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE98B056DD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946AF1635C7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7024F2D542F;
	Tue, 15 Jul 2025 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jsX+7q3D"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F95C2D6406
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572526; cv=none; b=J7hKKsGc300MOVYMjdbUG5P4KbB06rJ7w8bVHETd+xmF2VrLiV16e7FkOa6M/H+iCjFg84wl+5Dx7zRA6jLotxPt4X39Qebau2zE2lvAuamCdxVjspuhrS9bS+P3ffWottFyleeAwUp8/J0Rp5MYYRwg+bavFRnueQStQMa9DSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572526; c=relaxed/simple;
	bh=6mX6v1XN0y1wLhISjnxbGn87YAYAdv0A15KUv5tWqng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TE+ulnw6jQ8w27nXTFUlrFbZwO8WAdNWjGPiSQ+USIsTtJpJ8mFjG7mafenZgOrvvMprxeniyyj6rV/8fPwLlrFgE7SWQHzo+akXDiqNdFhBV5ZP6XbJyuucjrZOesZof0h3b/rWxl9utqA9V1UtwS2acC20UmVdLvSB1goe9pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jsX+7q3D; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-456175dba68so16610715e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752572520; x=1753177320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vCOcsV4QMbyLyBjdT/exfCsj0/SbOguasr+nXCYSr+8=;
        b=jsX+7q3DA1hYgdn8RBNkRV6UunniTfvubCvqtD93fkqbuwoYSEV/AWEP92zk4XbASO
         A6O2ryZ4Q5s1m0VKDvhgGFW2Xuz4TWqovH0S0tkKS8GP4yfY9HWOyuMvt9t2meboPyxs
         23YxOvOxfB2GI59EeeTg0YCP6z3G2T+Grpb7qRq/9XLVK5iOF6+s+G9yGOoXCe25ldjK
         skxXRumh6Pp3Lc+gwN35lEE03edEvSQvFdQ4KYatkPZ5ixDGUzwp3lF+k3LCAQAaJyy7
         22aeLyh8rF89TVxAAdL8XCVi4YJWIk9G3m8XlIQFtgj7wemcvAq2rFBdL121CXaN1TSW
         +PNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572520; x=1753177320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vCOcsV4QMbyLyBjdT/exfCsj0/SbOguasr+nXCYSr+8=;
        b=aiC5+BNs5LEZup5yARz+UbeslZJ9+ZWiHU3Dm8LxU8Bg4j5Orj7Y1Ltf3kf2DFeCyw
         33Ban25bWYuxebTKhwVu2HrAR6lJ3Lm0TPFUuKPIe47BRDWcttEf9nBAwmJwYvTkNTLp
         ckKP1d32qt1o6pu0SbvQpe4ekKQi2zftqs0vRuor70sEemi+i4o1iz2gGfS9k3GjhXe9
         yKfPwTy7ZLCE6NBUwIp/V0sIYrpMTYP6ukx4xxySLL2aEdmMZB83t5gYYbbL3WtsKGmJ
         9NFH9UVzhCUHMP58WCNlTidwc0yhDFKG30g2pMf3bx++tjRlwoJj/9tThWDh0AZ1JSwZ
         Bilg==
X-Forwarded-Encrypted: i=1; AJvYcCWsFjgIJ8Tmc6u5tPTjWpwP7zddyS34wUqjRk5mKVlVzXWAx1Ug/YHpUcucuUkrYPR93IWBMyQ/W/uV9Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySO6GRw8c0wrD+KNEbcF8dTdJl1UZLM5xOIVkOAfee6FP/UcXQ
	tQPj6pxpjgk1PI/Krws5jVrzWFqtf8XTlGN/iD8bHwlOq4PYrq8Cwv/kdqkteJQow/+DcUBb9V3
	j6yHL86qyQdzxvV33rg==
X-Google-Smtp-Source: AGHT+IH2a0YqGnJWrezL8ePmfjVywiZ3GRN/W9elnPRe6l1D5qfddWIDH5vOoagpaiyTIcxLU6bHGSZIomcAJDM=
X-Received: from wmbds6.prod.google.com ([2002:a05:600c:6286:b0:456:fa0:e0ba])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3f0c:b0:456:dc0:7d4e with SMTP id 5b1f17b1804b1-4560dc08725mr100420025e9.18.1752572519803;
 Tue, 15 Jul 2025 02:41:59 -0700 (PDT)
Date: Tue, 15 Jul 2025 09:41:58 +0000
In-Reply-To: <20250711-rnull-up-v6-16-v3-7-3a262b4e2921@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org> <20250711-rnull-up-v6-16-v3-7-3a262b4e2921@kernel.org>
Message-ID: <aHYiZtzAwvIDuJFD@google.com>
Subject: Re: [PATCH v3 07/16] rust: block: use `NullTerminatedFormatter`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 11, 2025 at 01:43:08PM +0200, Andreas Hindborg wrote:
> Use the new `NullTerminatedFormatter` to write the name of a `GenDisk` to
> the name buffer. This new formatter automatically adds a trailing null
> marker after the written characters, so we don't need to append that at the
> call site any longer.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

