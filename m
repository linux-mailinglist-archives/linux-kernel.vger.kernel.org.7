Return-Path: <linux-kernel+bounces-876052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19043C1A870
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4D78561C38
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872063271F1;
	Wed, 29 Oct 2025 12:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RZKycbMe"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E053271E1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741906; cv=none; b=PWkX9SSEdJlES9NfWvLZyK+/gqkQgTum/287QcC2cFtl6WfGdMujkyamlfYMBDqB2NHGoJ6FcwSjmqEZdr/Zo8Riznj4B+ifJCSZyz3BWxeOPj1cCracebFyOwme9JCGG4N73Q4TmA6nTBUa5y6IRkzWWzwcTNT5sJrvmhe5GWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741906; c=relaxed/simple;
	bh=Lis8XgSRnA5YJBARphY+01JX7JiGiM3xwyWmHXnsc2M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FIla0Cd5iXd4creTePeLvEsa30mTxFI0pkDKinnR5wAeda8QL+QrFVvXRMdvtEMxHq8KO6m1Do3PWGY+xoANHdS+wJbErT0Qhccab2aO+hEfJqeEHklyThxSrPK7sY1xuQWBxhiAHn5X/W9SgL5Yx4wQRzeDVdPKZcLeY6NOdHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RZKycbMe; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4298da9effcso5039526f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761741902; x=1762346702; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H9cuzKWbb4KNIohtS4TrqwKkjylaSR6bB/ye8dvPygA=;
        b=RZKycbMe3C+Kh9HpXsB4fVWevZ/7JW6+SiqRzzH/rg/bNezYJomocEzcib1HS+RwLn
         CVmCFkRer0fjN4vSsZ466D+LsQNo+hIaVsC0faj+O/m3w3DGl/1hSNEVi/BEgUyWu4jk
         c1phhCfFYLmzidKxDPmOGawLhtY79iLRlKhjBwnyrPasH7i1z71G49JCBGVYb5dmeBP7
         Y1GHydTnNjiZn99is49dCz2pHL1uaesbICRK0WZppFClxast0sAiknLafL72rIZEJryT
         Pf3c3aw5VA5AefIuGxlBfhra8BAWHUaUmyCHMX2Laa04JXXV+qQh5S99HFfeqnlszc/i
         l8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761741902; x=1762346702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H9cuzKWbb4KNIohtS4TrqwKkjylaSR6bB/ye8dvPygA=;
        b=JwtrDiuxxMEM56MfrmiGwY8a2dpxaPbXdQ99Q1uPKVaRo+ERYqZll795EeKz+c5Ute
         pv5v+LWmwz2YLAS0pcyLv99CbabUlQt6Nf2QExBb0SCGGJhzvfjFXaPxt7A+WCN0bdGF
         DZiG32CO9iLR1+6pmnYvEbNdDlvkuTi24r0W6R2JHMlTiYjMBIB83HOnjBZWLqza43N8
         k8ImQkK1IH/56dsdwynvv0w1qhN+haj3LgeNlfkko3Mrgk8se21F1EYeQBiqqb0pp84w
         7FDt9M0l6d8dk3ugk1vO1OKBc1Gnv1yPyO50pGqnTZUwVtJ+5aqtTODs9dvYqLDkjiEE
         nYEA==
X-Forwarded-Encrypted: i=1; AJvYcCUjyI2G02hlJY41uGet5v4Rl03DJg6KDpD7E3L7ztEqz+uEZVulExh9DA0k/YrHYSO/6DW4qmiWyAF/2ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNCwkMpEHS3maMBe3J3p5mdTnqijwYmtVjph7Mw96Xr9cLsTNl
	/CYxf+jBerpNa00oSIoaw6q7f/imPi+RTa09TdGzyvr2snzZ3DyQzKKXSUsFK1ObNT6norsnqlD
	N9gLxIX78OfPiTmb7sw==
X-Google-Smtp-Source: AGHT+IF6tS2K+sHdcmYL2m3Gzf5P+hOD9oht3waH8CGyonRKx29wIX6mnYWr9P3YR2G4rkduuBWQ0BGNCYQ/n6g=
X-Received: from wmbgx3.prod.google.com ([2002:a05:600c:8583:b0:475:dca0:4de3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:820c:b0:477:e70:592b with SMTP id 5b1f17b1804b1-4771e16e792mr30523355e9.2.1761741902165;
 Wed, 29 Oct 2025 05:45:02 -0700 (PDT)
Date: Wed, 29 Oct 2025 12:45:01 +0000
In-Reply-To: <20251029073344.349341-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029073344.349341-1-ojeda@kernel.org>
Message-ID: <aQIMTQZK49B1FbTA@google.com>
Subject: Re: [PATCH] rust: condvar: fix broken intra-doc link
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 29, 2025 at 08:33:44AM +0100, Miguel Ojeda wrote:
> The future move of pin-init to `syn` uncovers the following broken
> intra-doc link:
> 
>     error: unresolved link to `crate::pin_init`
>       --> rust/kernel/sync/condvar.rs:39:40
>        |
>     39 | /// instances is with the [`pin_init`](crate::pin_init!) and [`new_condvar`] macros.
>        |                                        ^^^^^^^^^^^^^^^^ no item named `pin_init` in module `kernel`
>        |
>        = note: `-D rustdoc::broken-intra-doc-links` implied by `-D warnings`
>        = help: to override `-D warnings` add `#[allow(rustdoc::broken_intra_doc_links)]`
> 
> Currently, when rendered, the link points to a literal `crate::pin_init!`
> URL.
> 
> Thus fix it.
> 
> Cc: stable@vger.kernel.org
> Fixes: 129e97be8e28 ("rust: pin-init: fix documentation links")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

