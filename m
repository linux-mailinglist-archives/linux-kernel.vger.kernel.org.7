Return-Path: <linux-kernel+bounces-731578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A804AB056CA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DDB97B642C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D5C2D7807;
	Tue, 15 Jul 2025 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="okZlV1Ko"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72D42D6604
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572200; cv=none; b=Dz8HuIuikojac8uHjPRnfoMhMnaxy547B+Sw7F4vZ6dE2XvMGufQ4N4zQr+k3NqhTdy5WcOpIJDqcRThiBDbgdCLTNu+WcXNJ3t272wML1unTxh085kODCcJxMOjUQHdLVHeKY1ynwA90+WAWbe4DwrwSS79D4AmPlrcwHxqo0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572200; c=relaxed/simple;
	bh=6YjjE8yx41JhSq70YIv6cyZNts1+4fdz63Q2WWL3ucc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kU08RPyIWUnNy2Vn5kO+6pSw1bX8lbY6OfkirxA4ExfbcMiZn5wRpBm+n4+zMQ7G+rnz4cVNj7H2uhEuyK5LYm3N3VDO4VPn5reVdUugAD4s4e6qPgjY33YRpTlkv6iWabDWEL4MmufRcQGwUNHluBn3dYYgZO4GaxX7KAlMaEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=okZlV1Ko; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso33685025e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752572197; x=1753176997; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6QNqFlrYFx7H7vRElEzA/t1Mf3ypg7FEvJ57Y0jYqXU=;
        b=okZlV1Koon7gs3CDUDBV/joWRKHg9EbfZhyxBDSrHpqkUUXYvfIgg6fRZkmYfXPIOw
         fZ3WWU4EbjFO2vmB/gZbIvZs+ORsZJCQ25Y8RI01p8vpxV8CvMDDezD4sIKTWbadf9Wj
         bcqzePPyy4M4gmtAZSYVvz8/o2mAokg15h8pzVlmlno4N2miAF5livnsoP+tOsnywGsi
         4Vfi/qia8eHHrV1Ue6U6VvuIIp14VJZJi+U0/BWBlHQ2Wu8NrBm7cPvPTQHQqjg9i3jm
         IKo93AFMCyuS2Nlpt/S3TM2ulP+NmCG61P46jIL3evTvqhxTwiqgkeRqUftZZOm/3cyX
         Kwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572197; x=1753176997;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6QNqFlrYFx7H7vRElEzA/t1Mf3ypg7FEvJ57Y0jYqXU=;
        b=E1c0ca9pF4dGkwt+1zV1Qukt8aCQlJaulmTZGGbb9PcLvgoc51vsxzE1DfQkaQfRps
         bZW0TXVYxGLe+oMOXtBULlTIHqaUD80DUk4vWF++lwx7NlOwYVdGet+DU5JdaT0wABg9
         gfT4vQIgZHYlDnDRYJIuchypgO+ZzR4DDe7evNwKMpkhIDM4SFmzb9eDRZDp/gzsWd94
         Cb4rLsr7CbgDsfuuO8qgmF/f7z55MK/oXcBcMgnPtLxMp3QiutHKzQqnL40zVFbzWmFS
         ZbgLjIYNIeLYP9su8cduOs1lnlepfd+mTS4rxo9kFOdYq5P0KLyrLUIHFFmr68LXqqU3
         M6nA==
X-Forwarded-Encrypted: i=1; AJvYcCV2kM+hW4zH/rJxELkD+QQVFADJNvhXoNDx2Hr1yqIMXbCVyxNSnvCwBOwUVET1V77HFE4z6b2oE4erBEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzemahTf0eYFeTbkTO2V/xEUJOG4flIZWMaOGI1hcqAHer4Weel
	UHhuVhm3dlq7IQhiJRwaccRENaxmQ5D9ho5zdeSHYGmUVtov+ngQFps2HiUL/2RexQnPuJ8H61A
	c7uZ24eO82kSEPiH/Rw==
X-Google-Smtp-Source: AGHT+IGqJXffDogg6Dsm86tBp/jS/D5fTXsBjiiYFtlOS+ceWATnmyZQRVUfbJDoWd4/GCP6yGnIn++VGO2RGeY=
X-Received: from wmsp16.prod.google.com ([2002:a05:600c:1d90:b0:456:2272:8b38])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:19c6:b0:456:19be:5e8 with SMTP id 5b1f17b1804b1-45619be0d77mr58477665e9.20.1752572197327;
 Tue, 15 Jul 2025 02:36:37 -0700 (PDT)
Date: Tue, 15 Jul 2025 09:36:36 +0000
In-Reply-To: <20250711-rnull-up-v6-16-v3-4-3a262b4e2921@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org> <20250711-rnull-up-v6-16-v3-4-3a262b4e2921@kernel.org>
Message-ID: <aHYhJBHUoWq46kKW@google.com>
Subject: Re: [PATCH v3 04/16] rust: str: make `RawFormatter::bytes_written` public.
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 11, 2025 at 01:43:05PM +0200, Andreas Hindborg wrote:
> rnull is going to make use of `kernel::str::RawFormatter::bytes_written`,
> so make the visibility public.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Making methods public can be part of making the type itself public. I
don't think a separate patch is needed.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

