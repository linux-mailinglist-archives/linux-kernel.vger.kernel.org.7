Return-Path: <linux-kernel+bounces-891086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8797DC41CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 23:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26DE54E84EA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 22:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4B4312810;
	Fri,  7 Nov 2025 22:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3qnRij6a"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DC52E3B0D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 22:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762553049; cv=none; b=MbtES3kWthmQP82euoVWZipQS3RwHk+3L8oA01bJt9btHzS0wI166fSp5Rv/BsWexlMzOfRHQms3ns36r5t5mcxzwd5w1eCRHSvAPHZpbbtLx/D81XdTYjv3MaLyyB28hzWJkMWSsf9+zIRYjMQD5tZhNoFhN9PCfHXfvfB/QOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762553049; c=relaxed/simple;
	bh=rH5NWi3glmpfoUsyrWFIS1fb1JBwFyE3VlN/OmM4ilY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+7k3/vbnt9k8nelW58wXtUz+4qw80cqOPz4QPrCyhdj1R3p4lMFt2o3AR1Wuu6nViAFZX6fJBD6u7ZcSpMN75Jfoc4sSBPK0IWIk4l9gypLcs7GT+cxXM5kOd5Qa/XZyb5M7zv2galp2PZDsxd4XmDGFVg7koqUBRmlAR3m/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3qnRij6a; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2959197b68eso19255ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 14:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762553047; x=1763157847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cRweDbYCqtyY9POZrBGfSKktHIdUt3/r/qQ6F0Pf6Fc=;
        b=3qnRij6aVrqTjfXWzxAfEaSRm/mVfPm1PHYD0o4tb47ywS6YOFN02cOs0+wl+/HEbz
         bdeXUvuSOfZDSUJKJzHpeBsIZmgLB465rRbSsYiZQSzB+TW5s4D2vgPL+Tc2uBd7TUI2
         WGvDc0ysMOtLu+36XBI0S0Eyd70aVYhq9BmSkF0TF7EGdK9oz/X3sIFCn5EbXqoNfhCo
         S9K95ZLgMyFeJhe7Shkydso99fAWE0IArfvBW/zCxZiYSAt7hUCtTgIc8bvL7MCTcgRE
         IfOjAp3j3U0KUdHXWHfBfBt2RM/wddejwlaY1YhvjV0p71AijbYkzIbALuo+751g1qCL
         GMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762553047; x=1763157847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRweDbYCqtyY9POZrBGfSKktHIdUt3/r/qQ6F0Pf6Fc=;
        b=RFa69n9biF9+tZyAFYo0TBp2Etd0Ny6rnF3S9EtHZimwaisB/sZhPve+JWm4Uz4W5a
         mqeXEptog1hZxmQRW7NB5P7mWTR55HG8pzMVdafhoeGsR0us+kY9ww1X0wD1cGg46BFx
         GPczwN7/uueqq7uOtVBcYKR+yAByG7ZoOgwuSTLR/yXbQ4b5EbFV6rEiosDg3oPS1fAW
         CsZFjuhhTEU+KKuNim8XU+uMn3w8aunFIEWAXaOCdxe9/QRPFXWvZjx3MdLwR9en/9yf
         5G0RdIg4oTzeeWolpoY0dcVcd6OIWvP5mQxQxDnwUUkR2oAkEeIV9UQoZkSUhK3JuvB9
         Neog==
X-Forwarded-Encrypted: i=1; AJvYcCW0ZKheJZQU4BGCBV5oLkjzEB6ztVBXJvbmAp9M1FIxkfPUlpGPm7C7czPywm7qb3pOUIrWum7OcFVfc6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKAqyaYBbFzG1NLwY7rWYvS5cYaiZXBRkqJ/GTbgflkpdCAD6P
	P+4Bo9B9LCcGCjuRStdTcpH7W+Bf8VAP/r2Vvc4Zps0muvI62arn50WGM2zmP/4Q8Q==
X-Gm-Gg: ASbGncsyQw8cqmFNRJOOqoR3wUwGYjHD1iFT3g+Wiq/s98rX9hMIlQW+vgBqkAF/SAQ
	lYdCgxplWavpOtGG2IDBKIpjUyuj9jOk6SaeCh2bCu8Qb3c8TKVMvy6zYGftRIEgXBCghC0DdBD
	1/1CvRYuml9W6cbqCJn/BMlmEt7lkMHES9Whx7/OHtGgFONJk+UZdrDGc7uEkeapHMHVbZ3p+D0
	p1FLYcwb3bO6Atol0i/dPgFvTNEQ5lTe0fM1jJm2AVMyHApNdMZjtAPKSTU4FsN1kCEdJAVmPmZ
	GjnBvP9/vixH7sqH6jREfgjnp74dJTzPv6eC3+rwbkC9qHPPSrbp2s7JHyVrWDXm5747JbaIKw2
	MY2lLptbsoZwhXyQqqAcif4mc/01h+j9+d8yoGvazwkLuS80LsLOu4RsA4HBJ+JURefh256X1FO
	pX2ED4qgCoVvGJUHq6ULBtp7VanFyyvn+6PNeKOn2nDuA74Wu0VpjWiB4MeC7ym+AUAldEZBweG
	UTPRKHGxm14KOZ3BbN04lQk9Q==
X-Google-Smtp-Source: AGHT+IFv2mkQSlcQS4PXvqaG+xeTcSDoHEqmlso5Xj5Eq3iLbnE3+0IuZGmN3O/yv/DGH1pt27g8qg==
X-Received: by 2002:a17:902:db09:b0:290:be4a:40d2 with SMTP id d9443c01a7336-297e7c0146cmr310255ad.13.1762553046909;
        Fri, 07 Nov 2025 14:04:06 -0800 (PST)
Received: from google.com (116.241.118.34.bc.googleusercontent.com. [34.118.241.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d0b427e1sm3437566a91.2.2025.11.07.14.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:04:05 -0800 (PST)
Date: Fri, 7 Nov 2025 22:04:00 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] rust_binder: use bitmap for allocation of handles
Message-ID: <aQ5s0Ajt26javMbH@google.com>
References: <20251028-binder-bitmap-v3-0-32822d4b3207@google.com>
 <20251028-binder-bitmap-v3-5-32822d4b3207@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-binder-bitmap-v3-5-32822d4b3207@google.com>

On Tue, Oct 28, 2025 at 10:55:18AM +0000, Alice Ryhl wrote:
> To find an unused Binder handle, Rust Binder currently iterates the
> red/black tree from the beginning until it finds a gap in the keys. This
> is extremely slow.
> 
> To improve the performance, add a bitmap that keeps track of which
> indices are actually in use. This allows us to quickly find an unused
> key in the red/black tree.
> 
> This logic matches the approach used by C Binder. It was chosen
> partially because it's the most memory efficient solution.
> 
> Reviewed-by: Burak Emir <bqe@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

LGTM,

Acked-by: Carlos Llamas <cmllamas@google.com>

