Return-Path: <linux-kernel+bounces-893431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D111C47606
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A804F4ED30B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5C7314B6C;
	Mon, 10 Nov 2025 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z2APgdQ6"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EB93054F0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786642; cv=none; b=KaBOSrgMe6AGLeSpicaV4O5FQqqhXGhuVijMUnDEMUcFXlyQEecna9I7BrPxhNDXdtyuaFPgjegwYwzr2c4eD9aHtjFVsSYln5xsWWEilhYQtTrpTsrdElYleYAmUWNXi4d/77YXYgh3C6F1TzUK0dmW5NqdSon5d/LH0kirfS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786642; c=relaxed/simple;
	bh=XrYjurcXwMFuI1n6vQ4mS/+j3z0zFW9n2Q2HRAorD/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iOEYbUmr99y6zXODRxOq1oUWkv0wAI4e/LE6ZBIS1eVGSNDLyM8Ir3oE8Up7E/g32bfSKTGJG9CN3ZY8FLN2yciuvXyJyawkuOD4bgPHwkWAUHrsDobn1SxWYHBNVwkhUBwEfGeHj++2u3fHgJVOWUahR4Zmc/3eaOJNGncQyas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z2APgdQ6; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b70caafad59so335463266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762786639; x=1763391439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XrYjurcXwMFuI1n6vQ4mS/+j3z0zFW9n2Q2HRAorD/k=;
        b=z2APgdQ68ppohMezTmMnZUfXJwArZ+yKG2bGNYUSiLZUZi9tdGyAt8NDkBH3P/eXwE
         LSceGSJUCNJHwSQlVLYkNWD+AQSmJoGCl5ksxV/2Fd64cm3YDojMcOirkQLf087pRVaQ
         WfmdSbxqgGycjfK4OOlWtjVIpALEF5q9Po+mMSLqT/WGCy8xkhb9T41e50ssu3Ru8Uci
         BgOv9WtcD8YYVx/F7KjtpacxOnm5g/bb9z3CPOzPlq3wBGa7iU+KXrO0j04GfZRSyNLI
         6cXRItaSLfwQqE8FZOtSIm4b3cCxkEiiYvnWc3gCWj9BLkenWXT8/FVQqoHtmAzZTz+1
         R2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786639; x=1763391439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XrYjurcXwMFuI1n6vQ4mS/+j3z0zFW9n2Q2HRAorD/k=;
        b=bj5RAFLfU3ry1hMU/Z7ArlnWdn1YqyM7QI5yNzW3r9bxDXUbLYoZ7sP0/4PlgXYx55
         ypM0q+xh7HuoPGiDb68D4qjdKdZKzm72M0VZndSItwehiuEoBEaF9V+YdpRERWz3Jmpj
         f42aaYeOhwoOP2jKb2RG/AE0AFgWESTAIiAFpF2L/YndW9RpXYx6dxoK7rY2flxypdPT
         xbjW6mk/Ix0UPzkcLSV4s/0Rby0a29UBPp7GvJjhaSHmoRBabvPdKqjik1+w2EUp1k8s
         czh4WL1j40/ft+KBBRjP83dYi74pkXIidpK9z8QBpk4mxspnjWgtMoqMycFoK7Yjalb2
         jeRg==
X-Forwarded-Encrypted: i=1; AJvYcCXpk+EhQZtLd6oYonzEX73xrrN9UZV3EvcbRcowyJQJYVIkFNnSfEG3Qep108w7dDwxuJi17vfL5PBsOZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyenACR9oJnMAEshAVx8ZhxMZl17F7A1ORN4iiiQPjT4pt2+E46
	HiE/n3nnAHtMPRLENycgldvkQcIlMn4C7+lSATxWpoADPi4kma/Vn1tiQ/SEs0udOaYR7hOlf/3
	o+lZmhAkG1oWmE0CsOA==
X-Google-Smtp-Source: AGHT+IGOnlG8lE2H2BKECccs5w83Ie0qMvDDSxYqNCeNyk/4OUCiSM9N6qmdcMFCMYYfeMybQOzcZG1uqwa4NcY=
X-Received: from ejcvb9.prod.google.com ([2002:a17:907:d049:b0:b72:b433:246a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1c85:b0:b3b:4e6:46e6 with SMTP id a640c23a62f3a-b72e02ca1d9mr839517866b.1.1762786639240;
 Mon, 10 Nov 2025 06:57:19 -0800 (PST)
Date: Mon, 10 Nov 2025 14:57:18 +0000
In-Reply-To: <20251110131913.1789896-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110131913.1789896-1-ojeda@kernel.org>
Message-ID: <aRH9Tjf0tszyQhKX@google.com>
Subject: Re: [PATCH v2] gendwarfksyms: Skip files with no exports
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>
Content-Type: text/plain; charset="utf-8"

On Mon, Nov 10, 2025 at 02:19:13PM +0100, Miguel Ojeda wrote:
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).

Is gendwarfksyms actually present in 6.12 upstream? I know we have it in
Android's 6.12 branch, but I thought we backported for Android only.

Alice

