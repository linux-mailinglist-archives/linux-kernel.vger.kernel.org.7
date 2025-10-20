Return-Path: <linux-kernel+bounces-860564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B07BF06BF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8646518A1432
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E8F2F744F;
	Mon, 20 Oct 2025 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lclC/Qug"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EF62F658A
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954718; cv=none; b=GczQ9Gd6dO79T0QLihzT0jV9RISetSreEMggO3+CT3rMF3+getp0D/p9vdnkJAERWB2Fxu5jiAYVQSK+al0Dy1PSlZc+8g8zXyPdkhqE6NL/wiwcudqgEZjxSgXyA876rxAtGIROqSEaM8EOyUDzrLnpZauUGnPCrDN8jaaJuTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954718; c=relaxed/simple;
	bh=jynQZy8NvRUFl/mPSThasbSqTz03s5bqnfLoVMOjL5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uFkBHscNn8fbgspwXG3+pxwnQ4nUOeCHADAYWiTdbZ3k5e6axtSJXPI6Hrg1fIj5RjYFf7tCqp7E5YvtlpLrkGYHoiXgT44BOmrMru3BgOKp6qphU18gbQt4lUC86OBsjxyqyn5HrraeLW6N7XAp1k2kbQofz/sqRkZANj9gcvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lclC/Qug; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4711810948aso27138325e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760954715; x=1761559515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmRi35y6N5WRRBxahDavUEXtA6gcUuvhGuS8xAmEQp0=;
        b=lclC/QugTynu+qCQqHZMGlvpQDI5Y3DpCCn4HomfhREi2s5mdGfvpBPvmD1njsNrip
         Jb1XqqP+/EzXgYH1SJXTReUXf6e5WsSeZ1+cGj663p5LetsfgA1wk72tv+p8P1aFwY4t
         3Rl1mXGoJRK8HJ2r3GknPyFAqK+AIqCGygqLGatJ3aGfg/iiLcE6hak72s8aCFkNfvup
         ljs9rfKoN1ImJ2cIHiHfVSBcBLpM0+009iImv1wqR5f4LST2mDoBeEeHun4QGYnTMlcd
         4pjRWWJl9LWTi2WkI1uREPCsgnXTBtw/PsFWSt6C1ay3szNYrc3an5eINvF3BAw3YkvF
         DE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954715; x=1761559515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmRi35y6N5WRRBxahDavUEXtA6gcUuvhGuS8xAmEQp0=;
        b=HQxSujMwurQQHvtiLVxrNU/cwefcOHcmERvK7s3XaO4d4Ou5xyiBGSh/l2W9GCvigC
         +brK04oPl21kcTeTpBkzqQNFYxq+hbVkXSeEccZaTnz8MZJe/XH5YyfIqcHupyFqiv4f
         b/ExPzzJWCVrlgioyBa/7YIwUKZUN7xBbNWK8h9ff34GvS83wJCOhAwFYu0qFpMxr+bU
         j0TieAqaMoAa1Wk9+ONvqDP7o9BenlyemuxYILrlSEyQ4R2be3r7bBD/EO44W1+A3Osr
         G3iTsHFacfcLvrKG3QKt9t1ClTX8c05tD4hYTFEjOBTEULqvMTqoQ1tpldFm6xw1AqNw
         zw5w==
X-Forwarded-Encrypted: i=1; AJvYcCXWodoruAW6aUxe/e0e9kRRrrbnSx9idzzJKtj5xY0vwDiZW9nmsNIFHJHjIl8odJZWpQztGTXlFMd8Hj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Eck+FwOP5xCy6x5zjhIVsBS9gOou0sBcMyK1QF2Qc5NXO+cJ
	vaTDE+YfiOQkQ9MXf+JXMss1vAi4sqf/eFUSFxM7AMePn5N5xKXjCExD
X-Gm-Gg: ASbGncvlKIeQyosZ+XvXJCzPRC0gghCo/rBJXwbKqfp3nLuSIXcFrUFXdRY40Xk8zLh
	qYV3lfSdqBmZz27JHZytOUv2l8qXV58RV1ZzVAtJQj4EgMuUMyS4dvGV8dfkLVQ3FU69IRgCAGI
	EvDcboPsDJvb9XEdXPk6oxjDMKtEvuaEbHlkOql3jouj5Ra7VXrjf7TEi07TQUVPorWfJO/5U1O
	RiCR3WV5/nrX416K7fN57s0pXlPbiCEipkj6e6XmIsTfSrzdxOxISgm+mH1kqopL2/NPzQ8JlTx
	alusgbZtUFywh9BI9h8ezL9l71ApbWpr9+j4J02s0rBnOeOKd52CgwKqHw+IaB4iAtOfUGcjS9C
	KDKs64o1T3/OS7/FFTXjHhsoDGN1GKe503+ReauvJAXXIHrUx6FeOaATL8f3dMY91i15qxIM2Hu
	b+AZ+2MhHT4paHFqg6uPa5A2oaNYTeD0zGHQTRr0I40dW2fwHweI3k
X-Google-Smtp-Source: AGHT+IFIwYtaN8vVGOKJnzPfzSNFBFhGVp3hgUQ/fiHsNQ1iCinDla5G+0DyDEO1L7XTYHNYpfyOFA==
X-Received: by 2002:a05:6000:144a:b0:427:e1bf:13bd with SMTP id ffacd0b85a97d-427e1bf1a74mr5180978f8f.52.1760954715031;
        Mon, 20 Oct 2025 03:05:15 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5bab52sm14419230f8f.22.2025.10.20.03.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 03:05:14 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:05:13 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ryan Neph <ryanneph@google.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, "Thomas =?UTF-8?B?SGVsbHN0?=
 =?UTF-8?B?csO2bQ==?=" <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/xe/configfs: fix clang warnings for missing
 parameter name
Message-ID: <20251020110513.48d18788@pumpkin>
In-Reply-To: <20251017-rn-cfi-v1-2-bf66e6ad4fcd@google.com>
References: <20251017-rn-cfi-v1-0-bf66e6ad4fcd@google.com>
	<20251017-rn-cfi-v1-2-bf66e6ad4fcd@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 12:46:26 -0700
Ryan Neph <ryanneph@google.com> wrote:

> Fixes warning from clang-17 that look like:
> 
> drivers/gpu/drm/xe/xe_configfs.h:35:97: error: omitting the parameter name in a function definition is a C2x extension [-Werror,-Wc2x-extensions]
>    35 | static inline u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev, enum xe_engine_class,

Why did that become invalid?
It has pretty much always been used - and can be used to avoid -Wshadow warnings.
This looks like a clang bug.
And you'd want a specific -W 'knob' for it as well.

At a guess the C2x extension lets the name be omitted in the function body for
an unused parameter (the same as C++).
I think that is the 'definition' and the ones being changed here are the 'declaration'.
But I might be wrong.

	David

> 
> Signed-off-by: Ryan Neph <ryanneph@google.com>
> ---
>  drivers/gpu/drm/xe/xe_configfs.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_configfs.h b/drivers/gpu/drm/xe/xe_configfs.h
> index fed57be0b90e146d57d966bab0e55e1723513997..a0d614b37efd54b89390f04a238aef1a8d4df4e2 100644
> --- a/drivers/gpu/drm/xe/xe_configfs.h
> +++ b/drivers/gpu/drm/xe/xe_configfs.h
> @@ -21,9 +21,9 @@ bool xe_configfs_primary_gt_allowed(struct pci_dev *pdev);
>  bool xe_configfs_media_gt_allowed(struct pci_dev *pdev);
>  u64 xe_configfs_get_engines_allowed(struct pci_dev *pdev);
>  bool xe_configfs_get_psmi_enabled(struct pci_dev *pdev);
> -u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev, enum xe_engine_class,
> +u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev, enum xe_engine_class class,
>  				       const u32 **cs);
> -u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev, enum xe_engine_class,
> +u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev, enum xe_engine_class class,
>  					const u32 **cs);
>  #ifdef CONFIG_PCI_IOV
>  unsigned int xe_configfs_get_max_vfs(struct pci_dev *pdev);
> @@ -37,9 +37,11 @@ static inline bool xe_configfs_primary_gt_allowed(struct pci_dev *pdev) { return
>  static inline bool xe_configfs_media_gt_allowed(struct pci_dev *pdev) { return true; }
>  static inline u64 xe_configfs_get_engines_allowed(struct pci_dev *pdev) { return U64_MAX; }
>  static inline bool xe_configfs_get_psmi_enabled(struct pci_dev *pdev) { return false; }
> -static inline u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev, enum xe_engine_class,
> +static inline u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev,
> +						     enum xe_engine_class class,
>  						     const u32 **cs) { return 0; }
> -static inline u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev, enum xe_engine_class,
> +static inline u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev,
> +						      enum xe_engine_class class,
>  						      const u32 **cs) { return 0; }
>  static inline unsigned int xe_configfs_get_max_vfs(struct pci_dev *pdev) { return UINT_MAX; }
>  #endif
> 


