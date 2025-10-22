Return-Path: <linux-kernel+bounces-864087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0019BF9E05
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E45742380F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA462D6E5E;
	Wed, 22 Oct 2025 03:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSJDqhVT"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507A827815E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761105213; cv=none; b=JLca+FKv2kJIqVdQF+SsO+ZRgnhbJ3K80EnVhZnANi+eRGL0SPZe08zq5pnRUY6H8UfYgFOMrPeH9yV0KnsBBAUFn0gBB5cHa3mbUOQwgGcdCEZYJwPTrWWPPl1nkSPcZQ84XUXm3fF2RrDlypV9ZSrDsgOU+ca9cuayeHqDMu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761105213; c=relaxed/simple;
	bh=zRhiH32I56VyWPe4Fr72V2VjcJ/u5/dW/hqk4y0Gk6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qljMroVENY8qaxgTuZNCL/E2PS7iOMvsvc1ezp8fh3eRPyh4oPx0/3bg9Qasnj5FTja2mAjs05Zl+WlSH5d9VUGnMHp658O3PZmAIL39Wa1OsH0Hqe2B8T0FxXZMd95XYLHFexUHY4AnTbq2xYNoj3V9MjKoL4Pv1QRN769cYU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSJDqhVT; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4e89d2eaca9so4311401cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761105211; x=1761710011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aRIdLyiAYODA3K+N158OGoOrRxM49M7T/gctII9qTo4=;
        b=aSJDqhVThFGaKPF93EFguOfCVn6OPZIeHfDJDeqNP6wGDr9v5z/ha8IqJxtlV6/PmS
         ETzz53ZzfAl6c4bSGlkp65omaW5CuvxcIS/+s6OsVJXZlwMuYsWzWtQ80nDXM+wV3UnA
         J2zA6rbKcGO9TYoOv/YPVwgg7Ujk+5dQbUfAu2z3vn6H60ALB2yA4zdRhknxRPHKG3j1
         Z6FdI19/OgBYGsX0dvAa9WF44ZGswueOD2pLTO0s00XwWKFkAz7ojtjFUUKlkxhSwF6F
         ioNZIXTkUJ3/qcTlWVBX/atoQXqhb23A/lhWJXRMk+cbI+jqSLqE9VCIuif1yMyt5q36
         sP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761105211; x=1761710011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aRIdLyiAYODA3K+N158OGoOrRxM49M7T/gctII9qTo4=;
        b=dHk65318pO+J95Fi6vvrkHhcnn/h6yh3cjcR7JfmBMzYwvXrGcEnVp5lVEfH4TgaWH
         Eo2gAFqMjG5m14C4oWx6d4OUuKPUOj3dTdUQQw9yb/jra+EED3V99W1OXHjSmPHchEMK
         4htZnUMfD2Kx1BXa1no9w+aKw6VpW+PMZD2UCiyTiBRe7ZHNeMM6WJ3HMXrgeh8uP6i5
         iTT2OrI1GJmI3KgKcl78tICethRlxjeME2YPjcn+O4l3ZvpWQ2LfoEMJ7S+a4ac8ws0l
         K3zTLQMJi2rTCge0Og0gTiih2mJqVabCHjQji9O/SVP0EFGOCPzLZRMNxSFU3HeDMzbJ
         O1+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEc3iGw2tz8KlRi28AI0ctAKoVf4zfvhLaN5bph5CCbWdz5NON+fHqaCcsfgrv38KgfwmuUswdRH96HlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq5MnKrmDic/HijsolV0u0lqnCMUBJgFFPproaxSkksol/lRBf
	7NyLVG/XQHcGj9M2J9G4FUeCCOHM5jsNaKV3FboNAV6oUA2mF/kYwOHI
X-Gm-Gg: ASbGncv+8hdvNmlDR18g0FWn4leGoPQvbsPqAnE1+QH/QMmq7H7Q/wbSzAbhxZKO6qz
	+1DgOBVvUzEyQqeZhzYegTG/KFd/vzPPURBzpZ5v1AIHtTnklhdVs0DsSBW6Fi+Qp/qFYMhNETk
	R0kXn8kWXf831yMdQ7EKaww4arSvBu0IoqPXYnFSwsXSA+QkLVFVE7LmQZcjgu2lwgAtxT+g/pB
	LvY2Z3acUnIXEbtFbFEIfRI2usYoBCEnMGB3oupTO+nqgSBhqpIaGS4R8kEa5D/m7kI4v1v0GRn
	gATBhp2lLdhBRcGvofViWp0PgC88ffNmDmkzXlLBixzguoiP+M04apxcRE3scGk3CN2uE9pQ0Ed
	ieUjqkxzDL82qJp3KCTKCI3/gylAsY19Srzu//yUgkqoBMEmZroLzBv1TgzaZKIjo81gUxXDyEs
	ZXm+k7C8aBWMm8exEFyT/N0F0p+oBrO/2W472YwJ4g9qPoZcFh98qOINrgDTl3vv4z4Gi6I2c69
	0P6
X-Google-Smtp-Source: AGHT+IECF1DqbaKjt3jBSiLByYMx6gIODb85sVZjrsUQCnbvlPh0n5LlJOdNuvj3bJWC4J0vcRT82A==
X-Received: by 2002:a05:622a:14f:b0:4cd:601e:9d29 with SMTP id d75a77b69052e-4e89d20a473mr247846131cf.11.1761105211194;
        Tue, 21 Oct 2025 20:53:31 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab0f3b1dsm85523651cf.32.2025.10.21.20.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 20:53:30 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0FE27F40069;
	Tue, 21 Oct 2025 23:53:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 21 Oct 2025 23:53:30 -0400
X-ME-Sender: <xms:OVX4aP0kMo-N9xL6adRfQQJ3-vB902aRB17pBaeqcGmVrKqDUfCdkg>
    <xme:OVX4aKDMFc63gwHR14kr6Idjk3GpVH_izyp_TMFA07SdmKZrefJ7g5mv_3DAlvdx6
    y9rnuIsrAY2Og1fTjfCyjDQ2TIN8OyuAeK6NsFj2Sc2Q7G9oWNVjQ>
X-ME-Received: <xmr:OVX4aGB8gXvvuG_SR5PXhInW78URfhR7qVKS7-MYhtaBnfRNvAA4oBBOui68ZGjclqDXGyTdDTcXqSbKuPJuy7PrPCGdHWKwlTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueehgeeg
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
    dprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggr
    khhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrh
    ihsehgrghrhihguhhordhnvght
X-ME-Proxy: <xmx:OVX4aLMNBvdaIiUNcLSMpWh_If7ZNXI2iOv6IIhE0t-9DOgLZnwrQQ>
    <xmx:OVX4aANapoWZUQ3_pVnpd0jUd1FLMM451A3x4_uNequNecHpHLC9fQ>
    <xmx:OVX4aPugn47FyRZ8pLNbrn3RaQOANTPqjzgfqOGArKuFqO3QKrAVdA>
    <xmx:OVX4aF8snIDVboWYbsFgCqBnbwegrWzhv1nYYn10Bh1nVfAtGBEZFQ>
    <xmx:OlX4aLHVCr7GRhbox-x5WYNih03N3sfTcoXpeEOcPVXmAUSVuBI65uz5>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 23:53:29 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Maurer <mmaurer@google.com>
Subject: [PATCH 1/3] rust: sync: atomic: Make Atomic*Ops pub(crate)
Date: Tue, 21 Oct 2025 23:53:22 -0400
Message-ID: <20251022035324.70785-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022035324.70785-1-boqun.feng@gmail.com>
References: <20251022035324.70785-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to write code over a generate Atomic<T> we need to make
Atomic*Ops public so that functions like `.load()` and `.store()` are
available. Make these pub(crate) at the beginning so the usage in kernel
crate is supported.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 016a6bcaf080..0bc6e7b04d67 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -22,9 +22,10 @@
 
 pub use internal::AtomicImpl;
 pub use ordering::{Acquire, Full, Relaxed, Release};
+pub(crate) use internal::{AtomicArithmeticOps, AtomicBasicOps, AtomicExchangeOps};
 
 use crate::build_error;
-use internal::{AtomicArithmeticOps, AtomicBasicOps, AtomicExchangeOps, AtomicRepr};
+use internal::AtomicRepr;
 use ordering::OrderingType;
 
 /// A memory location which can be safely modified from multiple execution contexts.
-- 
2.51.0


