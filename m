Return-Path: <linux-kernel+bounces-850345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6F5BD294B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AAEF4F01D7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812572FF648;
	Mon, 13 Oct 2025 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jI3Y+wNq"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535882E2DC4
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760351443; cv=none; b=JklQPFyNyiyr6A1x7e6WrdXt2iSiqH2baVcjlXr1u1WR1c4N3tu7+/Ab6zMx9mzMAg2VH5JCf1iXas2SwEHL0WDEDc8OJ2+n37PqeksAhSSjUaSGnDq5TNJrU30n91MZ+2tfcuPPNtOMKANcteoAbkwdlFpKcZs2M3/Shp3FtH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760351443; c=relaxed/simple;
	bh=jiFRFs/pzEd9dRu7mmnIj+h3VvAGP09WSi9bmQ+XQXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXraWyhSUc/XGpubWhd7Z6ZI4BS/LiPaJFnHFN5PXqmpu1T8M8ReldL3YDXsjoRmJjkK8XXsJX/QktKGXrc5pVOycsAWXH1SogvA1A6OpYB/dIJ0/XNjYTmu8FTfbTVx7A0vHULTzieM5sHkvqbS0qntyZ0qwoCBHdrBn5UiJN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jI3Y+wNq; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b47174b335bso252460a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760351441; x=1760956241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiFRFs/pzEd9dRu7mmnIj+h3VvAGP09WSi9bmQ+XQXE=;
        b=jI3Y+wNqOfXqZkNirPIqMZYHa+OmAAWQsYhgvZlJScZ9FppHiMAO8uMcZ9717WT+xb
         ksqxuO6gkeSir3rTHYr7nEH2J0CTFzwK+2KDMAHjLSuwuOT4Uob+8Vh18imgit1tQUv9
         8Z9PQlJUpTGFbrfcaB60TppZw2994o5Q6qh+vYEZKYAVSabZzaiWNLONFDLhoAZK4of8
         wMgjGFk7ltREgkjq3YAvg/Fdo48Co77ASnp9/JrmkypzsUcmuRa2oeESd/uyfgvPWCi8
         CKoWM0/I0pT+6uSd096Bn0GqduRk+pcSJtmPKh0rdtuPMnhn2/w4BAy7HNBNmRsSMMuV
         LzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760351441; x=1760956241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiFRFs/pzEd9dRu7mmnIj+h3VvAGP09WSi9bmQ+XQXE=;
        b=R03vEzS0tsuzkmOkPbRCuOZOgyl5wE6/ndqGjOjaKVTKrev3b/vu9m+0smWzAbJNQz
         2mUgsO7piLAQYC6Dvb8atI5FPu1n7rFZSFVyTwFgLNeDHYcEjB7pMvmx3zLmGqFA0vvL
         l0+Yjp7bw3utgxWTKTEbv6gpnaR98qbn112mjHTAq9KwLz0faXqnG3u6HKNVJq+PgSUG
         7vFCqCgEHkL6UVkz0OKQJ6LeVkF106KOG6n/574aLoVll4o3SAaFXiH4vmS/vkGh0kfw
         +LM31lwnDrNl/wp5Y1zfSwGwlC4TZk4kGxItkYcSul/rdYd/xcPIrxCZlmLWohIHCXdM
         Km1g==
X-Forwarded-Encrypted: i=1; AJvYcCVWZp/GJkrEEZIEXxEAKVFpfm51z2movtybOoSYrzrcYrCThoRsNyXeYK3BVCDtNFM6aFp6Rt9vn1syzBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgxJZNNf3/IDLSqE8l5tdSxOpN8drbIVI5Uq1eJ1JiK6iBIJXo
	yzXJ1zceHfvoo5Iqx3eMF0Nzn7ZcR3tNEOnNcJ67IaRx36jzGlMl7VsS
X-Gm-Gg: ASbGncurSx7FDS2xID7xlz8Ch0qkaqlVDBsLPbmRg0GAK7zI585/SLIyC8XcF00A3kl
	O4RLNHCny7NpyaMCioF4+qSmzTk9X4Ht2to17g8R6eMBICKGjcNTOzCrJ9agGkmNLPmHRjr33S3
	9RjS55K5KGDa/408ZzS7z0uA59tB9cPvItQVzpR4eL3ogFjEVhUMSXZ7IsbugVv57gkXUNFPnZN
	0k1l5FjRTfpZCl5dW2wxd3AHQdJKAkPVMDjaDq/lyQlpsWVaJbFf/NfF0MFjX2addqj6Ktz5VpR
	PXKgNAclJkbqjtDP+0NrHijQvI8PSKlbfVdz/wF1gws4Nfsg2A4SziTfLPm9e9mUi1Am5+rOK/h
	yykBlcfZcF1aT6QviMqTfjDWZ0g3nnW7ayE7OWA==
X-Google-Smtp-Source: AGHT+IGzKbSk+xpeuhcRPxXprhrHKgWgl+TgyFJOpJO1QcWS3vLYIUxy1cm46/h9evTFKRIrqkRaaw==
X-Received: by 2002:a05:6a20:9383:b0:2b0:ff55:f838 with SMTP id adf61e73a8af0-32da83782b4mr14502989637.3.1760351441359;
        Mon, 13 Oct 2025 03:30:41 -0700 (PDT)
Received: from localhost ([104.249.174.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626d284bsm11467729a91.18.2025.10.13.03.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:30:40 -0700 (PDT)
From: Ben Guo <benx.guo@gmail.com>
To: aliceryhl@google.com
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	alexs@kernel.org,
	benx.guo@gmail.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	corbet@lwn.net,
	dakr@kernel.org,
	dzm91@hust.edu.cn,
	gary@garyguo.net,
	hust-os-kernel-patches@googlegroups.com,
	justinstitt@google.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	lossin@kernel.org,
	morbo@google.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	si.yanteng@linux.dev,
	tmgross@umich.edu
Subject: Re: [PATCH v2] docs/zh_CN: Add translation of rust/testing.rst
Date: Mon, 13 Oct 2025 10:30:31 +0000
Message-ID: <20251013103037.44979-1-benx.guo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAH5fLgi4C454xG67vN-T5rRV1X4-rAGEj_ftnHqTOoN61wtcKw@mail.gmail.com>
References: <CAH5fLgi4C454xG67vN-T5rRV1X4-rAGEj_ftnHqTOoN61wtcKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 13 Oct 2025 11:45:39 +0200 Alice Ryhl <aliceryhl@google.com> wrote:
>When posting a new version, you should start a new thread.

>Alice

Thanks, Alice, for the reminder.
I’ll post v3 as a new thread.

Thanks,
Ben Guo

