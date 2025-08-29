Return-Path: <linux-kernel+bounces-791374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E673B3B617
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF93A1B25F9E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DFE2BE04D;
	Fri, 29 Aug 2025 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xmTN+AlL"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8070628032D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756456575; cv=none; b=qF1pJt7FlYV3AhkV6Krxs1jquh2wOOUnZkuipISvMRP4nfde8WNLbHJNHLa47KEm90IVX/5spa0rwTKHsqJ1i3uWQcPx09hnY6ye8DOo5oOfAlESEYb9PJPbBMCGQsR5ivz2p1hv1mPooRajRmPdeLBVhw2iQ1PZrqIyJf08Kn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756456575; c=relaxed/simple;
	bh=67Q3wwWYIQYF+tk7qpVPKh9q+KpcJ3v3lEZhgOnlbPY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bmrhMRxbIY+LhUhPQV0nEDrUBnzlsDwjsSzT5qCKeJKld4U1Mz6N/2RGvYak0AfzggEc0fF4qDHC/zJHqjOAObnDUBG+uecBYV197QykLErC8N6V3duxmB3uSimBtlbSvI9QyIndmd7hrTzinxYVtAOZc0u36mHqhvye3PFuBx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xmTN+AlL; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b7a0d1a71so11582845e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756456572; x=1757061372; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+WfsHJaNr8B1G4j6nvf+vMtCXY7ovA1eH/GUnVYwIdI=;
        b=xmTN+AlLhs25pB2zUHSvjv3mnpABaDSnE0SMOgfYsiU0XuSh4cETzLQMk8LC87D8gh
         NsNEsVWWI/bP9FtIuOy/vxSmHY4CrZdwVrMeTfJqkBylHEKevsF1N/AmDnyvJyZyW/7Q
         FjsGBcVkwoep00hBV95kDN/RAUAM3Q3QQxpcT+UpXlwY/Qn0vS/ooH+PEM3JRLRVo/QY
         +a3bJQVfo4ASWkJy/JEpBkA1jUifbONxYicgQY/y9w5tbhe1iBAI9NwghwqOOMnqiDK0
         i+AF/kxufkr6StvMFj/DO+AOUrcky3n/QDRNGq8bpFpwHw6PjHc8mEZEIMLbJ4a6sTzQ
         aKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756456572; x=1757061372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+WfsHJaNr8B1G4j6nvf+vMtCXY7ovA1eH/GUnVYwIdI=;
        b=CkVEuvmBXcOkeGVaGoUTJinzxQX+GNSQt5Ax4738Hl+PPX0o/BBarTGg1FYAarpLl/
         ODBRDE6w9eF20Va1FvtcSx75aWAbzPdu2BBqrrOVFQ7q8NNyPW4Ms+d1uOk6F+rYuQXK
         EYJe1rdWOZXidMugSDZ5Mh6CFiij6hNH+fw04hDUnMUXxp4XRPqBdJ5n/CwLm+oTU1Nr
         gfCZTpiph+EBhfaNklJvS3oGFhWTxTi3hfyKjCEYNt5FxEhSVKUHvfKcLpYJ/FDAN1Jt
         us61DSqqn9UFDctzetOMQ6/Ey/XDJ0lBoqmWVcm92t7Sv+LGNd0alsifmNpoFZ3x9H3Z
         2mXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0UDXLdbD2Cb8mwpsfxmkt5Eui57Y9x+s0mz5ayJN6EWB8NmIaw6/yL+0jmBU9YBq26RK8AJ53CIWPnPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXzdh+tUSwRZAVeuIKHoRA1D/ImRlmASES6he55095Mcp5rpwL
	LpBP7B48k2GUsfyJmA0QF/ZgMjSO6KezQGlUIfLjDRhxBzM7nK6rGBGvLv7EzdIBN+1SWqc3svu
	43KUSfgSikDJyeXCwGw==
X-Google-Smtp-Source: AGHT+IHBs3qa4cRLWnEt/5+OZRWtSxur1GY6tufapxIB/TactG+f/e2ts5C3baKCJMYEViDYDAfSJ+igluM7TJs=
X-Received: from wmbhh14.prod.google.com ([2002:a05:600c:530e:b0:45b:73cf:284d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c0d1:20b0:459:d8c2:80b2 with SMTP id 5b1f17b1804b1-45b5190ff43mr138726825e9.7.1756456572039;
 Fri, 29 Aug 2025 01:36:12 -0700 (PDT)
Date: Fri, 29 Aug 2025 08:36:10 +0000
In-Reply-To: <aK8co_CHsqr4gBhe@tardis-2.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827-file_as_c_str-v1-1-d3f5a3916a9c@google.com> <aK8co_CHsqr4gBhe@tardis-2.local>
Message-ID: <aLFmenCq6fICWaA6@google.com>
Subject: Re: [PATCH] rust: use the new name Location::file_as_c_str() in rustc 1.91.0+
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Aug 27, 2025 at 07:56:35AM -0700, Boqun Feng wrote:
> On Wed, Aug 27, 2025 at 01:12:16PM +0000, Alice Ryhl wrote:
> > As part of the stabilization of Location::file_with_nul(), it was
> > brought up that the with_nul() suffix usually means something else in
> > Rust APIs, so the API is being renamed prior to stabilization. Thus,
> > adjust Linux to use the new name on new rustc versions.
> > 
> > Link: https://www.github.com/rust-lang/rust/pull/145928 [1]
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> 
> Thanks for doing this!
> 
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> 
> > ---
> > This hasn't been merged upstream yet. It shouldn't be merged until that
> > happens.
> 
> Let me know when it gets upstreamed, I'm happy to do a test then.

The PR just landed.

Alice

