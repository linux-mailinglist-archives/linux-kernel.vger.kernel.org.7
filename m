Return-Path: <linux-kernel+bounces-891082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 03228C41C9D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 23:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 967EC35131F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 22:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D533126C4;
	Fri,  7 Nov 2025 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B44agV4L"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C80311C2D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 22:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762552873; cv=none; b=Ahj2gh6prYYSfDtrcVlHIPBLpNDKwikHC5ML2q8wAeCMMnTVe82mWJiLlY9fltHhZAKpTikBaDP2Uxwa+rOKFMSKj183V/GoHZJHhxgnlXAdJlYI4YmfcjbgEFcQ4pesGJOY//T3vZDtCz2HhXrdTjxaa2goHo49qnuV8Zk4xCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762552873; c=relaxed/simple;
	bh=NqCuPJtIpK/hHf4UiY9mtn9CsFUO+7oKJtTquFAaGEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnRWil4viAHz3pK9wzmUuubiDnoVBDITCW8dlyKlYsgW4xA7dd22dirGbTH2tIhrD+cGigfB6rR6xdSz9J8MCJFfcqw0Brktr+74nFpy3X9yC8ews2dJQjcgVf7qAWFKEbIlptBlxaEZ0HM0SpUzf+w/ixNAE/vG+J90wAlAnE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B44agV4L; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2959197b68eso18675ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 14:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762552871; x=1763157671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lO62eF2nnq9lumozTZgKwjImCeW30ulMzrcNDCSM+l0=;
        b=B44agV4LXKaA7i2ZZS0O4YQKbDMddd11lham9xTMCLFJRN/MXqEx7OPKna6Hayma58
         OACLn+Dj17Mdb1Ll/Lr9Jl8uLSh2J6wgN0+Q4srLECuEdX46s6HoWd92z/navgZF8jk2
         KEcxRb0rXI6U201tFCFSzlHU/JlrSEeeb9127jyHWd4XbpNcjwx5A+IqKD36e+Zy5Sqd
         JQt8+4XzXAfa+SmL+c+0e4AGoQbqt2+dqSnXGZ3n6hvMHA9Uk/emVljHdvxqtLawNej8
         sgcaGgfnUTL6ivIpAK9CgR+szi/hy/ZWJVToqdfhHHzH1FF56ElPKHKuBkPHfefw1J5d
         XDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762552871; x=1763157671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lO62eF2nnq9lumozTZgKwjImCeW30ulMzrcNDCSM+l0=;
        b=II7oBTXJuSxu7hF/xCeSCwEY6ZiJuUYG1b+E9yPlz2WvNa5vpuAlBO6eQv3DR7/tgG
         jm+TNsTO3lUYrpjLWeQKTKLyIVpX7WNfGR3QUsV6hgblqL0NH/LWNztWkADGSWm2qKxk
         wOtVqO2suIHsKFaUV4Yucy2V22Lon1wE3ZZgDPq32efv4KBzAnZPiHxGL77Yy2hhWmuv
         oE3QKeEsseCrdfaUA3AulUIudPhBeqFzfwQ0slSe7u5eWj6IAeD07UW+dyMHUAZDAWe2
         70eNbUHr4vvr8e6+9zcb+/zHcoA7Qr3ZCaxD7D9A+0oe4Ynu/rX8oYgkHw+aiD4sXB/B
         8x4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnUpiigH25IKu0SZauPXL+3kF7gLJGCsnC6+NkmOf1wRl+OIz7JNMXWPws8jo82PPaqhpR+sj4s+ZzYTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTzaCCVZQgSMd90vYLYAeBDykym2CDCCfSPKg7Hfk6812+fIDi
	g6DlLNVp4p5ewQMJnY45WnkUx0gN2imFS3qZe0cMQnUhJhpIWd66ImC7JySZlMIAyg==
X-Gm-Gg: ASbGncvwlj8Jy5LhiNJr3dPd4hdUcRXhMIMC4FPun4flvquDV7VnG3zG7sf5iepVczN
	Fl7shDP5ElKN22oS9xiAR8QA78cLmKBRkiGbWwCsYomcESVT7B1DF9xZu39YDV17jjAMYvYQSbf
	pybnoWcakLk4vwkL2v9impXKn71+KM+/XYGVD+qy5VqP6V40CsIv9wOP107qkgBW3WSwsWBwjfc
	GTb4lxbHlGWVKtqcpEjQM1f3fGAGat7dw4KMYIuGHKnU9uK5Q/TMbuckONJsLOOKJ8b60lNW+bv
	jB6vecPjYUsTT5YaWskIod7F4i95XjYZgowK/ebN2nD5ZMsjVxET61BtTEHcR1eMu7mzgs18lGV
	+wpaskrxuStHwBy15hwgICcPR3+orvFVivvD775vOn8mGaUdkWmUJLASJmGEmbO3sb63B9uz0u2
	YwfmaYsBoD23xVR4ngw3xgq0ikX5SI4L9on2H2hfifcl6P/oioQwUOmhU9Q9Fvd0+avU8AJG9Is
	k0nSd1nybaBPzFFtVlQI4Qda6cAGTxFrfxn
X-Google-Smtp-Source: AGHT+IEGlO5C4EI+b+m9m+aIDpLZfikk77tRfPm4g2La1C5BkEIgfoA2g0ZMFA/yrbv7f4GjcaMfvA==
X-Received: by 2002:a17:903:2f8f:b0:293:2a8:3f9b with SMTP id d9443c01a7336-297e7e3d68dmr264545ad.15.1762552871000;
        Fri, 07 Nov 2025 14:01:11 -0800 (PST)
Received: from google.com (116.241.118.34.bc.googleusercontent.com. [34.118.241.116])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ca1e718asm3886512b3a.30.2025.11.07.14.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:01:09 -0800 (PST)
Date: Fri, 7 Nov 2025 22:01:04 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] rust_binder: use compat_ptr_ioctl
Message-ID: <aQ5sIOHQ58CX3aQJ@google.com>
References: <20251031-binder-compatptrioctl-v2-1-3d05b5cc058e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031-binder-compatptrioctl-v2-1-3d05b5cc058e@google.com>

On Fri, Oct 31, 2025 at 08:48:18AM +0000, Alice Ryhl wrote:
> Binder always treats the ioctl argument as a pointer. In this scenario,
> the idiomatic way to implement compat_ioctl is to use compat_ptr_ioctl.
> Thus update Rust Binder to do that.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

LGTM,

Acked-by: Carlos Llamas <cmllamas@google.com>

