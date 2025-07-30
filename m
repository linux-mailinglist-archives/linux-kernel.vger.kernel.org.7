Return-Path: <linux-kernel+bounces-751202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB401B1665E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4003C7A46C7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B522B279783;
	Wed, 30 Jul 2025 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHqOzjRi"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC47319CD13
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753900647; cv=none; b=VI3Jncn7L8nBKF2mAhad41L8CcepyPTIdnDi94qt3L6y3B4LTf/yqG/bjD7dIdHupvObxind7hgSH3lmizlfUb8XU8jRDYxgDAziww+fR4DhArHXAJAeBh0X8dW3xXcecwWEt+0d+No2HCJ/imXcoh6RNWPWFGZie9euo2LQ3OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753900647; c=relaxed/simple;
	bh=k49/Xlw9tAEjfEPfK+TC86hcXt6Lk9SjX/Ut7j10jmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raZujotlwpE2iyZ6OrfqB9muHv9vIcxvigm7MrDgfU4Ezc7RpvPWXh7pGropS6ua3h4v2OzMUbwmdmHTB3q8EHiYbKmvpScegfjSUkdX/FcuDSKUIT5xfum3TyF3H+IArffsa2rKinFo7Kh3GGkSLIGM4PKILheW/3OU2iXHbPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHqOzjRi; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76bc55f6612so74003b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753900645; x=1754505445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k49/Xlw9tAEjfEPfK+TC86hcXt6Lk9SjX/Ut7j10jmI=;
        b=DHqOzjRiUrGGfLzKXwCP6d527a9+q4eIJa/HIR+I0YxC07D1CwBPiy/HXfhJM31JXv
         gC1AhemOwlNvBTtCG1nnwfoJdIDFMXXqvGRmMyjyW9PMos6ELr05MQZg5rm4pl+xYxz6
         CB+gPdSsf6slFyrckdcvfkZt0bYVqx2PB2Wh3H53j0mjR66eU+Rfm0/h/LwG0kAdomez
         N1wVnOuEJUGHZUus49bh7iCc4LA0WdYhTKQEdKeLDTtZ3ZgSwDU/cRQu9RBLO6NQHetJ
         wJpM2+9x+3HzWUSauSrADpZBg99GPO/VZIuunhUZ+CemGDoinoqKUW+fT8c08kL+FJ3o
         XZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753900645; x=1754505445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k49/Xlw9tAEjfEPfK+TC86hcXt6Lk9SjX/Ut7j10jmI=;
        b=xA0m7y8MIRULYi67jtsAaUqql9ajPfDgkAXnD2nLEg+frWIeS49bua/pyJzhKSWaq1
         XNp9dFNuGi2JFdOwCJ4QydlImLdbbIDPwPvWcXyr1Sg1yeaRT8iv6et3Y7sKqgKMbj5F
         LvfT2IL+BqND4lyUkbQRY6T1W+4Imkrljchuc5+rDe+4SQA5btykYChVr4E+lfn18Rmw
         z+oxYo/UxuukaIcxwWmvhZF2cKW8ytUMCQo52dPKXVD242AgTA9uejVIVVM1U97LiQCx
         s9frabhPzs2P7yUXN4SkSynS12qV9JQq5oYVx/sdcuZFcUEnOXrhwYOKsaCRl2Q5ixfV
         Qt8g==
X-Forwarded-Encrypted: i=1; AJvYcCUya9rTDqBW28XXzgf22twsWPD/AJESWF2TJ4qOQxLgeLYwVhOuP8HTGvYPM2ypjFiAUprVw8qjAf4f4d0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Hbnizo+i5Aq5KkFlX3Aqv7COFyDpTisDpNulYXhQULTJCJXq
	hnE/7udYZJtdEbZSUM5rrW/N4vSm6NQcopWWMhHdICqfBCbrqjiAUmhD
X-Gm-Gg: ASbGncvfC8LMQsLk9ZB46CAZTVZExMTkG2vGxUfLupVoekOQIQ33GQZ+1KjMjW8/caT
	Smc4+w13yd/9bdpTetPGh+JhYU03XS0Iq67UbxCjtzM70QMAVDFJwqUygQoI7YdwS68W+niHFj8
	9Fy93elk7r0JQajzF4G2k47RYDTuVgU3gYqFybVtYKBmRtTll/sMHVlBigQt8aUWTG2XLiffbQC
	m2o5BlZnZAWYnEF5BgGMhArvGkIGb5bl45e9wdfRnNcjAcm08Uegi5WEdojVcor9enqrmx2JeXW
	aExi3pQkqNxSUhIAKE0gkBDEeClxUHoGIuJSw4kphOd3NROaHnVOQOSzKsMIiIobeE0e3rt6E+u
	BqwDoKZvWWmfadT8fp3M+AcrgUls31Q==
X-Google-Smtp-Source: AGHT+IFT/8PNV9eIN2cOi3v1tmKnm26QayYoRHK93Hil3uEY0ga3nbcSY+Q8XN4aEkiwV9SKyJZn0A==
X-Received: by 2002:a05:6a21:9997:b0:228:6699:87ef with SMTP id adf61e73a8af0-23dc0699d13mr7677895637.13.1753900645086;
        Wed, 30 Jul 2025 11:37:25 -0700 (PDT)
Received: from fedora ([2405:201:5501:4085:eece:e0ff:6b68:de2e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640adfea93sm11308473b3a.84.2025.07.30.11.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 11:37:24 -0700 (PDT)
Date: Thu, 31 Jul 2025 00:07:49 +0530
From: Ritvik Gupta <ritvikfoss@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v2] rust: kernel: introduce `unsafe_precondition_assert!`
 macro
Message-ID: <aIpmfRIvGh8oVUUj@fedora>
References: <20250730171132.159917-1-ritvikfoss@gmail.com>
 <20250730181420.6979b4f1@eugeo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730181420.6979b4f1@eugeo>

> This email should be include the Rust-for-Linux list.

Apologies for oversight.
Automated it to prevent in future :)

> These can just be `const { assert!() }`? There's no reason for this to
> be runtime.

Yeah! `static_assert!` makes sense here.
I'll add more relevant example in v3.

Thanks for the feedback :)

