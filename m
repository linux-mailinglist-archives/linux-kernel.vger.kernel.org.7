Return-Path: <linux-kernel+bounces-892633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E639C457F0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84473AF4F9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6472FC896;
	Mon, 10 Nov 2025 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4nTXJfkM"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E3A2FC879
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765370; cv=none; b=PYG5UuGIEwnSJ5ozTRQecvsBUjnD/3xCgxSQKXwYfKJAXxqYmG0KLbrpxWuzfbWbz+7EC1Ymj/2Gv34AlbiGQPZk6MLttWBlLacG4uWDZ+hRoLS0cUhbSYCUOWGcofS3RC5l7XLldo2QLqIvo6jLs2tMZBYApC6Q91FVrDP+Mds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765370; c=relaxed/simple;
	bh=lGQwVUMBK/+CPrWtS4F6QQXvH91dHdstz43CnGGeZbQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XY9ug+/HeiE1INYIBaQ64ZrcCMbWMGzLC+AogTBwQ7SwLnvJD+kpG5cVEGmix3mCN4DihF60hH+bRDPlfFl5H5oPQPhcozBEy0918t0WUP/to1j/pT3cq6ik5tWegOV0FTrFl5OFbxlsD/b7gPqagfpbwgb4kWN6n9YL0OUkDxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4nTXJfkM; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e47d14dceso13624925e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762765366; x=1763370166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nIDUdeozIhDI2hlJ0i5K2pwvazKO86pOLo5DtCSzJuI=;
        b=4nTXJfkM094NT7s+ewY3JdtvhIGbAVZO8UTYobbhAKCehvcSpHXtYrJjUIe0J/R/BW
         5F6qrtfUp5Zm8n59XhTNybL+XX7M635fRdU83VwV4Li17dYMFsNu6DHc/2qfppYHUt+1
         pCbu/csRk0yo+U26DNVKAvhMSQDaT2i9B81eL9raeWIHd5dWKW+tdMM4qRZ1KbA7NBcD
         Ex+gDdiVKYML7Z0/UxdcRacS+k6KPCeFPp9rjHnTlaIRgBTA8pGvFq5iU3OlxWS7g0N0
         mq2fKRe2pFRfoIcFpSDGfkeF0oHt2mj5sC+xx30TtVgWDudvrMt/MBbl1uUjhw61IiE4
         /REA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762765366; x=1763370166;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nIDUdeozIhDI2hlJ0i5K2pwvazKO86pOLo5DtCSzJuI=;
        b=W5iTirl6XfTAV9mdLa2Xg/a3yUcmK6BivB7LEiAwwmuWUHqXRPWi5ulSU0MtgjcJUc
         7HSjwo3P1HpqpzrKDnTheeDf1rQlGAPxJH2lAIUctsCCgfa1d5gtxhwuLvglLi9oR373
         TjD3huCC/gruCMOexMXGaRLAa6HQMdt4LrMlHlERToKE52/b87MS+P9RShzyfuZZApvh
         fMbJVzZr8O9n0HZMzdwmyy+9fKLQVpCb8WqASuq+wbk1eXG/Rn/WE3UHW6Rzjy6y/DqE
         N8nSPGn8ztsN/8ithnAslvCL08NERwbqg8cCiif7M+dza/OYHJz3ZYNKe+kHkVZdmz1u
         ztGw==
X-Forwarded-Encrypted: i=1; AJvYcCX60OzZwi195kGX0K3g1KLRwUcd8hA1Cy0vzhKSO+4SVFCSaISFoouf1pCegIFDqgJ1OaX/CGyp+WWyTK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNsmXq7J2ci9SNSXMO81V2ZRsRf+zWWcDPABU8i3jnYbQLc10F
	omKqY50n4v/0yPEVnY0aygoov9ylXORKHc6WxnP0X/F0vYDs7F3OYmcoOPIshQNKy/2b6QMOMa3
	QvWT1MfDNCmTIpHbS1Q==
X-Google-Smtp-Source: AGHT+IG62ut6tZCTX7ilWOkDOMJIy2efcqrDPZDvsUPwtMS/puW7d2bX4/HekffUm0OxAW4LTrKcb+NjTPS54S0=
X-Received: from wmbgz3.prod.google.com ([2002:a05:600c:8883:b0:477:3fdf:4c24])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f1a:b0:477:7f4a:44ba with SMTP id 5b1f17b1804b1-4777f4a4988mr7040275e9.4.1762765365927;
 Mon, 10 Nov 2025 01:02:45 -0800 (PST)
Date: Mon, 10 Nov 2025 09:02:45 +0000
In-Reply-To: <20251020-clk-send-sync-v2-0-44ab533ae084@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251020-clk-send-sync-v2-0-44ab533ae084@google.com>
Message-ID: <aRGqNUVwOcLr_UvN@google.com>
Subject: Re: [PATCH v2 0/2] Implement Send and Sync for clk
From: Alice Ryhl <aliceryhl@google.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Oct 20, 2025 at 09:35:33AM +0000, Alice Ryhl wrote:
> I added a patch to remove the Send/Sync impl for the Tyr driver as well.
> I think it's fine for the Tyr patch to land through whichever tree takes
> the clk patch, as there should be no non-trivial merge conflicts. Or we
> can also take the clk patch through drm-rust where tyr patches normally
> go if preferred by clk maintainers.
> 
> Regarding Daniel's patch [1], I suggest that Daniel sends his type-state
> change rebased on top of this series (without including the patches in
> this series in his).
> 
> [1]: https://lore.kernel.org/rust-for-linux/20250910-clk-type-state-v2-2-1b97c11bb631@collabora.com/
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Stephen, any chance you could pick up this series? Thanks!

Alice

