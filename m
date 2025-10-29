Return-Path: <linux-kernel+bounces-876054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B36C2C1A85B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0423818986E4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3036254AE1;
	Wed, 29 Oct 2025 12:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CQbPVJly"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B29241CA2
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742035; cv=none; b=PW8AbuqCiTP3CtWWYc9iECxWqGi9ZX28xsgEuMFlDxXjeWPgMHunzFwrMOMh1LoPRehUgJEOSVbaDhIbMb/qxbCvxcZ0/PfJwqkh8XJEsNYhPb7intoJaF6HsO+iPNtESTsu5Sy8OQFRYU3qe3dBjix8vxq9rriOfHLzMniXWXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742035; c=relaxed/simple;
	bh=RZ1c8In1gMlq9FbCVcEzVNRcgJEWOIyiWryo2vurgBU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YyMnVGSBAX9oK5Yczi8gmGBMTlG89tVTv345qaDrllyLTYek7scdKreulhDKE8+mqqIemyvlpZDjPp9AXoucXSAa1+FZ7X5lyQCmIQfd+mWzdDH7phKM/GY+yHR+bX0a7NNw1tPh2QED/XDGJp5y90HtguZVIlZKZEOyjtyVQA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CQbPVJly; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-4284525aecbso4818188f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761742031; x=1762346831; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xtXJvTcq7PSogsyLbiFNIiSa3aMDytmkSsBCAXBdzyM=;
        b=CQbPVJlyM9PbzgrJMatYwu5IELIalkeSMjDpVDvFBHy/SlkiMqlLRRqx24HEOi1ti8
         fmxoITHvV735Q2lXLR/LQ2HiLmUNshJVTf7+JQrza6VQ9hGl6bmqkwXY5RT42rbsmy10
         DziG2VgNlRJC0zv3EAmrnt4np58Q12nP4PuXrsOMaz2ABE93miqAI+4xaeif7aGBTv03
         VH3cm1l/099XAm6jin/REUu1PhKOJmbnnskbvD9Rk5e1AfsNL2FxdzB6KNQIquzkX8rH
         BYimfcWHGR2KMK+Z+iNSa9FeLNnFXLrLFNHdUPAn793MVSbYVk64P6jQEd3Ebt/QAxX+
         5z7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761742031; x=1762346831;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xtXJvTcq7PSogsyLbiFNIiSa3aMDytmkSsBCAXBdzyM=;
        b=movo4VrHWFRRfZKDFJvnkokFXGj/ZdU3UTsh1kDwp4S4/7a/fDRHFqYtephPGx3VH2
         az+0xFC7gSqJZ8JerUoPGH/wR7t1TGQcXFM9b1VLOtFBL5wHync8mlf82yddiwZOsFlg
         EiA10AC/DLKkrW7X4azeDCZIvmqEPRBQYh7UUTnMhCQnJ8UhN1KkLG2cXns0xNXSb+h5
         7RnIDYnR8oxuQ0JsW+wBaC+YCEYv6hrk5KBIlcZxxZlkg5TeBTXJ+ayvi2FVT7Pmyyje
         TeahO6o8Txr5LDYqxKZRvObiZZ2ngrLIKASAMJYQkIJ5lav5clhlR2tk0Ob6vL45FvmH
         7CHw==
X-Forwarded-Encrypted: i=1; AJvYcCX/AZsI3HrWbqEx89CC17avcJkpaypM6PVEiezNnDxsAGYzKS4P/1zTQCy2MVihwaJDuaVYEIeTqB0nnu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTiby3ctC2R7sYrkc+walVuqZtLOUgOXNofRBnIMCj8qImyMIQ
	R5kiFwYlTO3r+23V/KQ83Y6izQm9yHswasw/ntb/ihGlEWo7BEncNYeBrrSIOqQVOA1hVWto2pn
	feWzaeHgSymZcpJJ/Sg==
X-Google-Smtp-Source: AGHT+IEv3fbqpyMJagFo6xGiSAp4ZJfz/NOzhfXNsSPeWdIojUeQVslwvThMYOlDlFUMgf9NEYTALza+RhxNeRs=
X-Received: from wrrx8.prod.google.com ([2002:a5d:4448:0:b0:425:6e00:e053])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:25ca:b0:428:4004:8226 with SMTP id ffacd0b85a97d-429aefb2a9dmr1848797f8f.34.1761742030807;
 Wed, 29 Oct 2025 05:47:10 -0700 (PDT)
Date: Wed, 29 Oct 2025 12:47:09 +0000
In-Reply-To: <20251028-pwm_fixes-v1-1-25a532d31998@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028-pwm_fixes-v1-0-25a532d31998@samsung.com>
 <CGME20251028122316eucas1p2733987cd4c1eb8f83d6572d542e76d2a@eucas1p2.samsung.com>
 <20251028-pwm_fixes-v1-1-25a532d31998@samsung.com>
Message-ID: <aQIMzXnUqjW_IVdb@google.com>
Subject: Re: [PATCH 1/4] rust: macros: Add support for 'imports_ns' to module!
From: Alice Ryhl <aliceryhl@google.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, "Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=" <ukleinek@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="utf-8"

On Tue, Oct 28, 2025 at 01:22:32PM +0100, Michal Wilczynski wrote:
> Kernel modules that use C symbols exported via `EXPORT_SYMBOL_NS` must
> declare this dependency for `modpost` verification. C modules achieve
> this by using the `MODULE_IMPORT_NS(NAMESPACE)` macro, which embeds an
> `import_ns=<NAMESPACE>` tag into the `.modinfo` section.
> 
> The Rust `module!` macro lacked the ability to generate these tags,
> resulting in build warnings for Rust drivers (like the PWM driver) that
> call namespaced C functions.
> 
> Modify the `module!` macro's internal parser (`ModuleInfo`) to accept a
> new optional field `imports_ns`, which takes an array of namespace
> strings.  Update the code generator (`ModInfoBuilder::emit`) loop to
> iterate over these strings and emit the corresponding
> `import_ns=<NAMESPACE>` tags into the `.modinfo` section using the
> existing `#[link_section]` mechanism.
> 
> This provides the necessary infrastructure for Rust modules to correctly
> declare their C namespace dependencies.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

