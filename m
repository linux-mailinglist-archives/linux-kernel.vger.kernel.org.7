Return-Path: <linux-kernel+bounces-884380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DFAC300C9
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCA0A4FBF02
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71860311C2A;
	Tue,  4 Nov 2025 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JhQ1b0rk"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439703115A5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245812; cv=none; b=TD8rmiy7mr24YrUMSc7wlWW7T9/s5a9J068dSiCqIUbYGFH/AsuCApA4eUcZb+0yZqE0fcLgtXIOWTttYJKFTFEKy4f6F5Yze2lQ9x5IB+JOYf6TywUgfhPIiBd/VXhDb/nyLbFy2+twauifxqja/b20F5WWjiWaw0h/AQwRzEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245812; c=relaxed/simple;
	bh=aCZn6ff47Phi13st1KZjBEeenbiDArdJcDNAQTj5X2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oPxIWgO0VUGmyT5EhwiOz/cHzrjKlMfQvW2+InX9yCWO1v5Rni5wptwDEvl+QbsepK3wk609Y7C7dFuGTW4hYANp17ZPD5MIpdxbsG2nD7xOqhifXHnZpJH10b//EeZGXrvtft3KdSVnm7gxWNmHGdVfSufbmZifRJv3jF9i/NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JhQ1b0rk; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-475dabb63f2so25485385e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762245809; x=1762850609; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q52MEZmU/u71Q2fxLMiAXidd/2SEiVk+mC1uS2okEF0=;
        b=JhQ1b0rkReLwatsxhycmPG2f3/szTTX8ZR5D70UZxs/Dpk6uiuIwS87p4W+gp/Audm
         e5yMuDHePa+QsvFF1pMFK+BPm7ZDOQ1FxRMj0Zh3GIRk8uKI/XVOZEMo1dB94u5tHJWs
         W9dV2aMvunWFRTj37bQ9Ry2hJGvaoMwvjj1mkR7bmLy2dzgMy9mjRgcOelNfsQyhgzOi
         oxWtXyO4XKyL0z6ddDrDe9RcIrOqjZAm3GSA6awjVebhjYF/X/SqkchVwIBcPobD/fEM
         IxZIeI/KHzgZ+KcMgqqO0zorjpYiYmR1POVTT0M553rp82KrL+qRgjsZ/SIVJ0HpGzZ8
         BU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762245809; x=1762850609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q52MEZmU/u71Q2fxLMiAXidd/2SEiVk+mC1uS2okEF0=;
        b=f82jkFFFBOmLdd3COqdHwpScg2u+fY0gOPkl0Bd4zh7Nm9mhtuEkKVWhL8hhC7uK5v
         azuKz1I7fC6GzPbXyAnwGjWVVLrSr45zgvYxuCjzbpW6OJm0ZY2fEIKY+gnVFFnUu6HN
         fjI+m+GheZBYLz+CQEg20nnzFZh9fpwCdIF01/rgcAmDoWdpADawv+TZjefNPdviQUmZ
         Lkvixh3nmWlO/QoB3wOs8i1HZzYOMNO3EeT4UgNeVOIuFlDW8z0CmEvIXQ9zB//b8mOE
         rv3czR54sBDkQXXOZonAj3eVNv23x9kXpY3A1oSgbF/S/OsW8h3sC2APdgFlxKODuM3o
         wsqA==
X-Forwarded-Encrypted: i=1; AJvYcCXN12DB0TlN7N9N65vTwvCeodwXjAjF1I+3sduekQGPJdyBxPr4FhzVTjNy8r7FxWGVqM8AvmlLzrfnjx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy36iUzuHtkMlTS62EwGgu3L5gotR8sbqqfDLPrqC1dKdGl6oHF
	g90+9KnnrcNnrlFSvbLwQZ4YPy3oHyPnSuMognSiAQa+TaOmdQxcryjK+vHSy7tle4JLGODRh1s
	wGQW8723f68Cb0slBLw==
X-Google-Smtp-Source: AGHT+IH9Ofzy7IHR33bFDyjQrzC2PFRdiKPrUsc69skOdCa28cMYpVlp1wFV4OsqJjaxDKWPch2OKGFPl8v9u4o=
X-Received: from wmhf17.prod.google.com ([2002:a7b:cc11:0:b0:475:dc85:436d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5387:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-477307e6f82mr124823895e9.18.1762245809686;
 Tue, 04 Nov 2025 00:43:29 -0800 (PST)
Date: Tue, 4 Nov 2025 08:43:28 +0000
In-Reply-To: <20251103203932.2361660-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103203932.2361660-1-dakr@kernel.org>
Message-ID: <aQm8sNvcunHF9mPr@google.com>
Subject: Re: [PATCH] rust: auxiliary: fix false positive warning for missing a
 safety comment
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, david.m.ertman@intel.com, 
	ira.weiny@intel.com, leon@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Nov 03, 2025 at 09:39:18PM +0100, Danilo Krummrich wrote:
> Some older (yet supported) versions of clippy throw a false positive
> warning for missing a safety comment when the safety comment is on a
> multiline statement.
> 
> warning: unsafe block missing a safety comment
>    --> rust/kernel/auxiliary.rs:351:22
>     |
> 351 |                 Self(unsafe { NonNull::new_unchecked(adev) }),
>     |                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     |
>     = help: consider adding a safety comment on the preceding line
>     = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#undocumented_unsafe_blocks
>     = note: requested on the command line with `-W clippy::undocumented-unsafe-blocks`
> 
> warning: 1 warning emitted
> 
> Fix this by placing the safety comment right on top of the same line
> introducing the unsafe block.
> 
> Fixes: e4e679c8608e ("rust: auxiliary: unregister on parent device unbind")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

