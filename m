Return-Path: <linux-kernel+bounces-809944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BDEB513BD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CBFA486494
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593E53164B4;
	Wed, 10 Sep 2025 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gE2XCIuo"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B02C2FF65B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499556; cv=none; b=Hs/N0AoQQWexIPwlQadNd3y9SdxDCNlsOQCQ6xZkgYn67qKJLpYFbJ6p9Pfp3aQrP/OYcKmvvjAlBIjvpjyEugI9Xd7P9XHuQK0LPVo7dy4ZhC7PXt4xsIQOOnYDlxDivVjdaSI/l77nsRiaHw+dKW5C6DNtlvAhX0JQyTI3u8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499556; c=relaxed/simple;
	bh=wHz9SsGajPNBHN651vynes9IY74+1qSVzpbURRJCVXs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=opxlJ8LmDdnncBDGfrNmXbOUCJLCUgTLyBWRmoSvcAUCZWfp7D3UUefSLEiy8oqbOC06TlaE+t3II3GWxs2nXixN/UvsWfGJDgZy1CrYVTxW4SkpSkiMh+HCg3g+a/nLSXpmt3yT141RHu6lPl/WqC+tY5f7G6vPy06I/8t7zXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gE2XCIuo; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b9912a07dso39341405e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757499553; x=1758104353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1id+5OvuvqKyGBWl/taL6/LjlzotK8J0LksRsZS7ZSw=;
        b=gE2XCIuogG+6OS8WNgeyXp21IgdLrlkeNK/cKxa0IVqInCKlVMdWkgBANrdtcLhlli
         kkNfB3VA2zw3Xc8+67iEGORGUKcxQznfkBGGMwkSLoXR03MtI3pidpya+VoudiN/cIAu
         Mbna1KeL/aACsfKerrAzNUfZpyovLW74whgjd1jGj5F88nD7lbwKmsnPsRHXFJuYgJYK
         eGgqcmnXychLcRLi9Hk3babLF49k7vZtrSqBOIQodo/VESXsvn65Q2UQuazIBBzx5eef
         nZnyx1ILlq3jblTnN7Kf47L1z20H6cOOVUqbBkOKzUSmb6iWqclQ2669ubNauGeBeD98
         Y5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757499553; x=1758104353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1id+5OvuvqKyGBWl/taL6/LjlzotK8J0LksRsZS7ZSw=;
        b=UhPJfSPgHW6OsvczCNv0G+KoyRDtU8e5CPvfWITkqEEVnGFCF4dcdq3m30eR8TgGR+
         X7n9+FDY3JYvPEK12mIsF90FPNeJDpjr1bD+mIlApqL84aDgE06JDU6LLo5/dwHrCJFw
         zITb2bYmtHytBvYHMcMcRPcpJ+7qopOo1aoPVW1N+NaC/g/XUTnjctyjn3JT779V2O+r
         TW47OWZBwnSWr7YG6Jjw7l7dWJn7CYZ0w67ZA/ErdGY4SRJUOhTfBj4rxrK2H0ndbEF9
         6J3qtbIJCVCtEBkZvFUOmdwGyT1qPxjbRh0ORb8XcFnPgotdplAIQ4Q2qk/yGc3J+j/2
         cfBw==
X-Forwarded-Encrypted: i=1; AJvYcCVAnFk/iWgUnbPCB28W0tFqPDZPSqmFTCmMboDpaEPtq4GVAql4kCLxAkibESoVy3IjZZSnG0d+XVTpf8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw02R2NO8Q7Rl2mnxYEVE0vaIlOX3Lay51JOo7mLF7RitqhNwPg
	hDMbcoo8hqSDnfVyJD24vm7oC29/MjA4a2mFi96KBQSwqV8GYlJDA4uBBEngpstn+5eJBOSRsSi
	VAWrvB1P+y+vdLPWNoQ==
X-Google-Smtp-Source: AGHT+IG6yPMkO9jM7petOD8J9NTleSm/goiR/WLTyxvYA+RDKwpsQ+z3Wdkkp8ZmZDL9W2QNPMGOPXGF1tzIdys=
X-Received: from wmsr3.prod.google.com ([2002:a05:600c:8b03:b0:45b:79d1:abcb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:45c9:b0:45d:d50e:20c3 with SMTP id 5b1f17b1804b1-45dddec9282mr120206755e9.29.1757499553488;
 Wed, 10 Sep 2025 03:19:13 -0700 (PDT)
Date: Wed, 10 Sep 2025 10:19:12 +0000
In-Reply-To: <20250905140534.3328297-1-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905140534.3328297-1-lossin@kernel.org>
Message-ID: <aMFQoM8-SRrOmN1t@google.com>
Subject: Re: [PATCH] rust: pin-init: add code blocks to `[try_][pin_]init!` macros
From: Alice Ryhl <aliceryhl@google.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>, 
	Christian Schrefl <chrisi.schrefl@gmail.com>, Alban Kurti <kurti@invicto.ai>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Sep 05, 2025 at 04:05:31PM +0200, Benno Lossin wrote:
> Allow writing `_: { /* any number of statements */ }` in initializers to
> run arbitrary code during initialization.
> 
>     try_init!(MyStruct {
>         _: {
>             if check_something() {
>                 return Err(MyError);
>             }
>         },
>         foo: Foo::new(val),
>         _: {
>             println!("successfully initialized `MyStruct`");
>         },
>     })
> 
> Link: https://github.com/Rust-for-Linux/pin-init/pull/84/commits/2880a9b898336e2d54f80715f00ce00f21f74d2f
> Signed-off-by: Benno Lossin <lossin@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>


