Return-Path: <linux-kernel+bounces-841610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 363C0BB7D0A
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20EDE4EBF3A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1877B2DC773;
	Fri,  3 Oct 2025 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Bu8Ed3Q"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236572DAFA3
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514330; cv=none; b=SnM4FWZ5xtoBC+NwxE6n5ImpTO8kT2+Kk3EuBjMgiixe3YPCrNXjsgUOzLmfse+1UFvgTnpFM4QYbmgfmag/QMKVXFazzwmuEPzL2jg6L9ZK98YsiLYvEAnpPjVnn29u64KKvtbwZ5DqbdWvKiW0PT1Lw752aFrxLAsfGxenlXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514330; c=relaxed/simple;
	bh=wt1TJp1oWNcsWsdk26sG7pJIbwrONFNB6RBEylZMk+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZ13DEQ8pEerC++vKI38ICp3VdysAVNWHqrUfr++Ateqx9bIe3BO0U9A6dV3HubdB1urNKLzSbRHwy4yZMHDjFU2huuXT5/2yClr8w5S3ok5av80cORMXWpkuDSJgCa9ppfImv6xTvM9njbwsTozEMF4qgkQZEf3+laGUL7Ol9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Bu8Ed3Q; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27d67abd215so23445ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759514328; x=1760119128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UaDYKs66LP34CduEkv1EiCiVmEjNuJqNpCfLGQVzrcg=;
        b=2Bu8Ed3Q2U/qdQojH5e47rbOKM3oBQxCcSjYjGJowPTl9eIW3B6ESRH9hUVyq6quK7
         ovMbMYndL+g9SKICQNOH/6YEdUURdqz+6rg48rd3R51yuJPrfGXeE6bI/fn50Qxcuu4c
         K4aJ8mzHOhJK4oPN3nxAl9+RJy/8uWaO+8DpEOuAM3Ummpvf38bUYVFmmJFSVais1KXB
         tkClT3GaK8RfY3XoICIqxb+SvZu3IgT8zio0YQpu3IbVkCWKt9eeK7/B3VcukabmKT6A
         yBgdByB6iKsZC6L2qlrKSqFKJ8TLJt/XtXnpADpenxrGbAWJ6pSyDGSVTNRbhsEgcb15
         OUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759514328; x=1760119128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaDYKs66LP34CduEkv1EiCiVmEjNuJqNpCfLGQVzrcg=;
        b=AzezA44RICsij06Jy6xZ15ubUSZykzB4FwBMkww8bl9feaqmJtTHW3KuRWJoWfAwOJ
         lsJyESmxZBr/BXh1ANihTuuVXl9ld5lOhkHKKiq8l8jWYJi35s3AC3D+l4wKIAtgZ6o+
         eKZDDx1dFzuKEkaKwEoOLeuPp1U74lVybR/jojorLXy0AUY+VBPl4o9a2ZmUYNXhYagO
         IMKqPHLtLv4KlVVz/6gcX73WvwxHo7gt+WiWBT47mNqZNN0DmMzOQ3QA6vDgb2TyX+Yy
         sNodNthqAOz194RlySId7K5Ho6x61yaSJ+JAmi2fSIff99+12GMuYwusbztYfO0vPBQT
         JW8w==
X-Forwarded-Encrypted: i=1; AJvYcCX7o91MBCzdyMY4dm9cuydxIiFlWxWDESlm3GraYyEOXZl4NeMKV7fv69xQSbV14no38+Bb/FWHe9wsaks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4tzzKrqPl9gPw57S3xHgSvwdqrh/941NwJFHvlT8uSDH6ymo3
	yTNaUBAQLmoZyxFoHHGH4Zm8zK1hfjsFx6n7Dsv8Lkue5lgZOIGUHVI2r0F3rPXLdQ==
X-Gm-Gg: ASbGnct70Up1Ir77yyXwSsqOjSTIHIIdUgGFSj+OJp0l+x0/WEhuqsXsnBaLbHD6f9X
	KlW+Z+VD04LvM0lLGbI6H2OBQMO9lQArtdp8CwvIm4O11w39ZbNScn5yibQXFv/lVvqx1mJmfaX
	fqQI3kKp1KXe9mPpq0e+XD2Stuw2ApmqSOWkyv9+1l5gHGJmqlGrgWSIc3zz7tORUC/C3oaIX9A
	oM5rakWFi5rtSxulpOEI7hWhs7Q8evw71woANu1Y+vLHOXQ494/UK+kquOnRlRE/EQ2qyXtphxD
	IOtT6AU+coDBTM+jkQLQLjSRb68UD5u/S/k9U5QJFu/4x/H7N2IfggjGPiypFYDMFDaUlLxem47
	ALzbcpug8WK7l4VA4nzDjo6ZFOaMpTk6ym4ua+3NHbU77Gmq0Vf5Hjq7PpEvL8kb57hzqDAQpBM
	hDL3eyNvvaaD0t/NkhQHOen76YUBtouzv6bdeLDKqJWck/FGj6140wRPmS6wpyUo9mJpn9VoYl6
	g==
X-Google-Smtp-Source: AGHT+IEkysZQevkBeX/w0QWXf8n+7czeDxOHR/GVkR68sXNL8qA+v98FUl5T5iaeaufxd31jHmkE8w==
X-Received: by 2002:a17:902:d2c2:b0:24b:131c:48b4 with SMTP id d9443c01a7336-28ea80c1031mr246835ad.5.1759514327897;
        Fri, 03 Oct 2025 10:58:47 -0700 (PDT)
Received: from google.com (235.215.125.34.bc.googleusercontent.com. [34.125.215.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ebdac1sm8814355a91.9.2025.10.03.10.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 10:58:47 -0700 (PDT)
Date: Fri, 3 Oct 2025 17:58:42 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust_binder: remove warning about orphan mappings
Message-ID: <aOAO0kQtjovUUXQ-@google.com>
References: <20251002-binder-orphan-v1-1-cdc4cffff992@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002-binder-orphan-v1-1-cdc4cffff992@google.com>

On Thu, Oct 02, 2025 at 09:25:29AM +0000, Alice Ryhl wrote:
> This condition occurs if a thread dies while processing a transaction.
> We should not print anything in this scenario.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  drivers/android/binder/process.rs | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
> index f13a747e784c84a0fb09cbf47442712106eba07c..d8c3c1ae740e0eb3bcc8aa5e7faf4291f1cb69c9 100644
> --- a/drivers/android/binder/process.rs
> +++ b/drivers/android/binder/process.rs
> @@ -1346,10 +1346,6 @@ fn deferred_release(self: Arc<Self>) {
>                  .alloc
>                  .take_for_each(|offset, size, debug_id, odata| {
>                      let ptr = offset + address;
> -                    pr_warn!(
> -                        "{}: removing orphan mapping {offset}:{size}\n",
> -                        self.pid_in_current_ns()
> -                    );
>                      let mut alloc =
>                          Allocation::new(self.clone(), debug_id, offset, size, ptr, false);
>                      if let Some(data) = odata {
> 

LGTM!

Acked-by: Carlos Llamas <cmllamas@google.com>

