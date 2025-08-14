Return-Path: <linux-kernel+bounces-768519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 019A2B261E4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C76F3B9A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17282F83B6;
	Thu, 14 Aug 2025 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrzpMIQm"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DB32F60D8;
	Thu, 14 Aug 2025 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166284; cv=none; b=oMcElcDmMnPDoQZilorVOxBjVT/3Mo372X0wvnU60QfFb+8vEGs0Zhp6BSBh7AYIoud4GhGhnCLXQkMfth1z5Ne6NDYpsTsuT/h+BErWYqPRpMPIcdr636JTeZ1vtKKT0jYbbC+LMKpz35zaZeQpz7gLIVAml+0tEQOMRrgKwJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166284; c=relaxed/simple;
	bh=eleB09cP4O0qMba1dKQ81WBnimwPCEOWQ1tZ3icgk3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JBo+YfZzBvm12Dg1VnPfSRfnAPi+Ojd0XYpxPSsVuKpseSCigZBE+nPauYa3gHp3xDGIyOR9fBc/YeOfqu8I+tZJpX0vOQa7kAtUgaKSS5KvEuktq5czq2aB80RI7mj7AP2cl6F6ZWuFpPeEg+RXWmilsF7a38oBTfNjsgut2BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrzpMIQm; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24457f5835dso8775095ad.0;
        Thu, 14 Aug 2025 03:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755166282; x=1755771082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XN+OTurFhUfLHMGvTX6bqf0NAEYy6h9ZR9IIwNc0kfI=;
        b=WrzpMIQmOmpfQZY1vaYHzrtxAzcjV0XwLOc54kQlutc0fVUxAv/gVcOhg59yYqJxhF
         FmitursKtAwyJanDc/iw6nfqz5uIwDautwJ6o1j78LusgB5E+ZfHeeah619c6xBfwJ/c
         JUtdqMLRglBSZjPNFT7Pka3gi4jtXr6FrRiExGO1KOtZf0vqfronyM5rxL8ase1mLfMz
         b/BhicPcQVHR0pPeh6tUFnQy9z/rxp+0Fk/WpDg+/yY2kG/UY5Jk0/cjAVrNQbi0MTps
         dl7xp0NFbmajdCcAwDzNLPQ2aPpTYHPw7CNLhWnF7i4qU9r+aaMXxmFOy+/Ra0q9Asdh
         35yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755166282; x=1755771082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XN+OTurFhUfLHMGvTX6bqf0NAEYy6h9ZR9IIwNc0kfI=;
        b=YFq/aywTIvwCrVJNYGS9PG+i0I1JTdKWqNirRQflhbPBvAZ2wcC9e9DF8LXZpc27Ng
         Y+PJr1Wu6DmGPnriV9vEH3n+tl7wqcDUbeORVDqWDLZnpNIQ39Nswmh1jYePgdCje7O2
         A+ea4OvhfFxEmFOAMiI2OeZJYR25avmKZB9AQF0qgGRSCemxNXa6p0TDNZ3jKKWh+7qF
         u53j8ne7008eKYdIat0XzUrux5luIouThODWTG9HzfFELzndMvNUswCYQRtyx908DEWC
         bDaaPCYRgImK3COikx68iWxw7CfSSLGIhCldi2NabiUTokF1KweLM65rUID9xpPPB824
         l4NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDlZpbnn2pvYTmm8tPpjKwLOV+W2NBot1/nP1C8ptj9LxUqRFhyS1pv1rGr+IQjUUSv+XWurXGxHmIFoUT7bk=@vger.kernel.org, AJvYcCWgl7BmNlDBYzf6qc5KdXAjCVTM1024NykIAAk79517+HaCJi5ghhVVv7FmjelIl1/O4Zji9YFT8VdTomo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoV7U4C6IhBMcvDKJ1dU/p7IVILsszVOdU5Xo+tNOYKVDN6dKG
	NybmenHJhxDR11vAqR3YkbS/UhdYtx007mtI/wXhSxboQkYuV/DdN4nX
X-Gm-Gg: ASbGnctgzmK57RrRW751jxKnuAwQ4OVKROss/MsKoIQuO+lI4LFMWNpFt2Z9rB5XyEW
	jy+n23s1I13cEDYNbxGKjJA/uxaRLQTK/lBaPZ3XRIqskm4kB0YZsCtkDoZYnOTzLcMcp9pxuVO
	6sVYW5D9/4UBmSFEWpFP7rNd6HZWVtrJyA3NZ+JziNWtJ+7CBT6sTnDFTR07/M/TPSeyBM90gMU
	pFh9lsA5A38CqMfTp5ylkCLimqwRAaK+u0pMUIhPwNK0m1VEptArM5jnyUzw6WYjrsU8KI3fZWC
	Go/0+ivBeIbRMmRcqsRVBn9aKjDNozF3b3v2Hnz4AA+9ImAwTPDgaH3Ak4xTD6op9OKZUkXjTVw
	IVRMw1bEm4G4hic+QcfY0FVFFpxg/AyFBdY7GN/D2g+fsk/A=
X-Google-Smtp-Source: AGHT+IGFQy/akkao8mv1zo6fNthjIHl5Virn3hLhHOS5TrGg7uOk2CMWx+WX5ZIsg6IPJrcoSMt8jg==
X-Received: by 2002:a17:903:1b64:b0:234:ed31:fca7 with SMTP id d9443c01a7336-244586daca3mr36175355ad.48.1755166281877;
        Thu, 14 Aug 2025 03:11:21 -0700 (PDT)
Received: from shankari-IdeaPad.. ([103.24.60.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899d347sm343894775ad.140.2025.08.14.03.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:11:21 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 4/7] rust: fs: update ARef and AlwaysRefCounted imports from sync::aref
Date: Thu, 14 Aug 2025 15:41:11 +0530
Message-Id: <20250814101111.314193-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aJ2aUwi1L5RjK-X_@google.com>
References: <aJ2aUwi1L5RjK-X_@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 14, 2025 at 08:12:03AM +0000, Alice Ryhl wrote:
> On Thu, Aug 14, 2025 at 12:56:21AM +0530, Shankari Anand wrote:
> > 
> > Hello, can this be picked for review?
> > 
> > The initial patch which moves ARef and AlwaysRefCounted to sync/aref.rs is upstream (commit 07dad44aa9a93) [1]
> > 
> > Thanks,
> > Shankari
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07dad44aa9a93b16af19e8609a10b241c352b440
> 
> Christian maintains rust/kernel/fs, so could you resend this patch with
> 
> 	Christian Brauner <brauner@kernel.org>
> 
> as a recipient?
> 
> Feel free to add this when you resend:
> Acked-by: Alice Ryhl <aliceryhl@google.com>
> 

Done, its here [1]

Thanks,
Shankari

[1] https://lore.kernel.org/rust-for-linux/20250814100101.304408-1-shankari.ak0208@gmail.com/T/#u

