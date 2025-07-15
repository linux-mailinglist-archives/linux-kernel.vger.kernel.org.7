Return-Path: <linux-kernel+bounces-731593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E7BB056EE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8C03AC6B8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8022D63FD;
	Tue, 15 Jul 2025 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kD3IUD7L"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD0B2472AE
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572692; cv=none; b=Or4Z2ctyP55P12Bm+aBsLUIRPcEKrCrQukdlXLzigcnR4hvJjDsiZsIKmTEJgiRF+Wzxey52lt5TBbK/CHY08xedgrDqADpVie5CqnGEAK5LaN9ROqF0ivrlcFU+uemHwBdKjNOFaf8SAPix8hw1j1McjUIysNmL3ZUhAMIHC8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572692; c=relaxed/simple;
	bh=0OaGNFrB0fgqNoatwO5iBlV6OZUBZFJqA1edmIJr3/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D+BEonJZMe8QmK4k52r4FTlo1XJIRmKwr9gBy2xLtD11/T4mV1X+/PaUnRpxTTdjRAWHCh/fSRJMFGs57MRXdFKzsGDuIw5Obl6+QmghBCChPb9s0SZrszoo+MF69QrQXdkPDw79daxzgGC62aSZKbIlsvTKyHDB+22LtNZeYS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kD3IUD7L; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4561bc2f477so12191495e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752572690; x=1753177490; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h7io7fgXMymKFOK46/kCrzMZ1PRBvZpU4cGSv0rsLuU=;
        b=kD3IUD7LpcrERm5AcjCmjXQC93taCQNI2Kpi0T7mzWPKkkOJTc3YC0DsDIyPNXxxPB
         eQKXTKDBWnYfSWVsps/FDyNxzr55W4YSAAnweVYoRmkQ22SuCIbnOyl1JcFWxxFAf3ph
         9VztT42B0sNHopH0G5BxrHpeOm78qR/7LgR8v4x9GTqk/yeOetYH3NpeE1e5NPdhy9bk
         Q2G3oDtSdl6AX43z1Vl5+BX6RWSa7rcL24Ym6/LQv3mltj0vhpmGBjAgq8djnsObF65Z
         gsYEFNFwVnkKxQnPNb6fovHkEeQFrPQxhXsnyaOMJWXg6UhrNSWL7Pr76MgU7RATJhay
         YPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572690; x=1753177490;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7io7fgXMymKFOK46/kCrzMZ1PRBvZpU4cGSv0rsLuU=;
        b=ZMXHFe9xWHcuyQpUvQIWY3iIzUYPadW7X3VcUfObRIcPSJONlF2GBmSwcsz2zNApfn
         /M6mJ938gRkEIChgZOpx4IEeu+DRz8Ff9M+iy+2pgSzbsmTUXRHvj7Fz+hw7Ns+qSFMP
         h8dsXOJVdDU3/7q8DhPWIDeVbPNWPtGGvMo5/KoREtRdKZL7N2l3VyZpgSx+IMxXOpbX
         21e5RMKRed3dQN00yuQN/BgWUrZEOg653AnBlsLRS0nPn6knIr1nhWRmUzglW2S4k1ZB
         Q+9iB/pXxG0ZD8kQmaB5LdcTEye+2yKyeFFuShHFUH5lTp4J3rEyu8tbSvrVOVCWG33A
         MHcA==
X-Forwarded-Encrypted: i=1; AJvYcCVRXCTcM6ejiAHFK7xFZkaqKsHfmHd+xnTAA5oYzKfuY3nlEoFBOEEIdn9yIy+cvOHqaBev5QVM57YtHEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkQ548h62El/Lub+pCNrGpiU0cpCUqXxNYRzNwL4i6VV5WVK9Q
	VE52V0SAA2RsdqFKxJP2GjT5zARte+v84Lhy0QMymIdH+wTKSrWU2qgd0TVtgE+7nPEehDrly3a
	35GHxD/MVI0FSqKbjnQ==
X-Google-Smtp-Source: AGHT+IH5FEueWO8S7kcW3OwX1kpGtZLu82D3VsejIUYP0K855tlzIywd/DLT8PldrQkxvXurLF5xNuUIeWHiZ1s=
X-Received: from wmbhc25.prod.google.com ([2002:a05:600c:8719:b0:456:1b6f:c878])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5304:b0:456:207e:fd83 with SMTP id 5b1f17b1804b1-456207efef8mr51348465e9.4.1752572689951;
 Tue, 15 Jul 2025 02:44:49 -0700 (PDT)
Date: Tue, 15 Jul 2025 09:44:48 +0000
In-Reply-To: <20250711-rnull-up-v6-16-v3-11-3a262b4e2921@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org> <20250711-rnull-up-v6-16-v3-11-3a262b4e2921@kernel.org>
Message-ID: <aHYjEIZkXhInJMfS@google.com>
Subject: Re: [PATCH v3 11/16] rnull: move driver to separate directory
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 11, 2025 at 01:43:12PM +0200, Andreas Hindborg wrote:
> The rust null block driver is about to gain some additional modules. Rather
> than pollute the current directory, move the driver to a subdirectory.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

