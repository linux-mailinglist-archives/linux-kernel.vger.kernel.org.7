Return-Path: <linux-kernel+bounces-733750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF36B0789C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1234188BF49
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4176B2F532D;
	Wed, 16 Jul 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZBhBEoX"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157912F50B9;
	Wed, 16 Jul 2025 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677319; cv=none; b=QXgS3Xyd5+iVqXwFc+IPP4NS84cbzf+TM0KaoLxk4Yt+5hgYusTO6ofE9C8wh0WU+9NJ2CIZFWBW/7sRF/ryzQjDOkIs7C1yJOFMl2FeqD07bjTN+yoF5jh90lb5I0aMJ9zBoqYcFU/FRPhMwcdTq6CV0Wwc8hr8YOmCnSE/t9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677319; c=relaxed/simple;
	bh=pxyK4IpdvEaEPjWoT9x1mfZguglA3t2FbpKgw8SoBMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WFvAWDyyLJ5okgqxW/Bx1qExy68ZtuUYInHIeufRRoaWlVAlTAE6iKVyNPGz3wn5c3xBJ+IZ2X1OJQPYxqMDZVGteNzgZZW99+wmCJB4tNBMyyKIwWSXUrXI107vEyoKv+OI5u+9Z8iYN9pU8Qd/V0WAoSa8at1JVNmY/61xdHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZBhBEoX; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a9bff7fc6dso9251571cf.1;
        Wed, 16 Jul 2025 07:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677317; x=1753282117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EWuK6FBVFxtsuJtQ1WZQ4cQFsX6B+KpTxg+/m9X09UM=;
        b=BZBhBEoXMkSRbQVx9wrqHusQje5GpWKfES1pYj6cFniP6PNAgqYsUA/3hwqKU4tfUJ
         pCafLDVGJrKubWpLzk7+BrBCtKSzNy9xaxXcT0EIK0+f//BIXponDHL0udWwz2X8L98O
         g+NTRhbT/WGnYSnCg5OrlcheVqqm0EcxLHBc9lpIzQEnzbJ0hETxggdhsNNGypaRmIla
         XEugeI90v8PJX6YCewKO0mCHwHBblsYvsi2YdcuMjkQQUa0+cu0c1+Dlmb7oVVDRKxRz
         Kagc3ghDlc0Px8SJqNCujVqyLH0Y9Mjvnb6KtRkOpT4JRdhqKoU8H7eK89fmlEXJZlf/
         HF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677317; x=1753282117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EWuK6FBVFxtsuJtQ1WZQ4cQFsX6B+KpTxg+/m9X09UM=;
        b=tqwdWLps0sD4FoLXNgqEqBxOG9aXBXJmuMMb3Tc/zEGChtNDwM9wM/+U2UXP4SZuTQ
         LvEP9WGIwZdrumnoULosGPiVR1BjAh6ba9LwLgNhFeTH/HvUX5Pi3YujBFWf0WqDYnhu
         ulDaw0JSJtMMHj9s4usdWhirlMAg5OgO/peBhhleWy1GQEoFRwG4bP+3bYOyDkxGp1Zg
         Yq0KpLsQCX2JvLp4ml1gaLHagsBtFFk0Q8KKBhKe78XxuIgkb3UCn90vTETxsYV/QBxq
         Mlf5g1uO5o5xqsYYVAS2bRtu+Q80/3WDYPaKaR23KvF4Hqr6bDw6oAww8Zmn4h6OSStd
         jbzA==
X-Forwarded-Encrypted: i=1; AJvYcCV2C8xNlPn+jJoYbHHXb2UmSBXbT1EGF96bCpg2+xOPQj3dqNxPh/tGrTy2DYejpHXKvfZqbziEXNzCVRQ=@vger.kernel.org, AJvYcCWjrCSlsz0czboaAbRUkuGvTST1eIb29I7gywiRsh0U9F4CJKA6Ona162IdGo9UIYmmPm6S+8JqVuqpk2nlr9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza+etJpmkS73n87Yjm/1zSD7cvnnPtJv5nz4kh/G5oscaB1A/s
	eGJiglhYskOkuJhhGCmb5kWUOP8Yl9UiRJXjSMKQBJK1O7H02beu94V5
X-Gm-Gg: ASbGncsPy6hh1FfpvrtTcUTlB54QU+j4mlqcW/XdeHn4tyixdzTHs9gZIgqHclzkgLv
	+W4NxCvJoIpPL/l8K3nIyKinXo9wJskJGESColj4y+c6+aQC085nvaE+YqhQ6zozjbmBS1147/O
	r0e4h9FXBoKlpGR/6ff2yED0cR3Ns9zutkoLawzeIP93K8NGm67uA+2mc7Yfaxx/v5zolKXgey0
	adghJICJNGL98s5VGtStkAU2M9zpgStoPkeYfeR7RTnocnRL9eWpzKPD6vOFChBRrp+/q3MUd2t
	8YLzNItqxCELTmVRqH6d4jpUk0b2d6YKsGD/+Fli8M52X7GzK/WDIQSbm8+cIOK4JWGOYEqjstL
	X+DJJzTFH6EJidlwlafhrZjyb1Otfu8ynALDvwx1YUwr4HGEd29YHjV4JsuE+Eulmc7f73nfmYU
	PI0pJ3ZmFUPXqDAVhK0lVrlAA=
X-Google-Smtp-Source: AGHT+IEGElqA+vZ903nEvCUg2SlvUTiLvXQ59tX8l7tJ7HhfxJMyUuFXWKpgRdMMDvOukqTU7aB5Lw==
X-Received: by 2002:ac8:6f0b:0:b0:4ab:63b8:3320 with SMTP id d75a77b69052e-4ab7f9d73bdmr111166751cf.23.1752677316720;
        Wed, 16 Jul 2025 07:48:36 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab75211016sm28194701cf.45.2025.07.16.07.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:48:36 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 08898F40068;
	Wed, 16 Jul 2025 10:48:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 16 Jul 2025 10:48:36 -0400
X-ME-Sender: <xms:w7t3aNN7jRBvcJAqtfXHrwHxawcTmrBdKaotzh7X17o9ZgtooV7vSQ>
    <xme:w7t3aFfhi5DYmj953JMsm5ptmrItb-6tfy_n_2K5EIiUA5XhW-fl837tqyNRa5xBK
    L5Pw9tWkQEfVc3-Fg>
X-ME-Received: <xmr:w7t3aLXtNZEowP_S8YfjkJPTmtLFLGiBuJjjh2xtFVq5kBx1MgMnceBASw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehjeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepkeetteejgeduieekudejfedvvddtiefgieffffeljeefieehiefffedvfeffgfet
    necuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgv
    shhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehhe
    ehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
    pdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmh
    hinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgr
    uggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehojhgvuggr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlvghithgrohesuggvsghirghnrdhorhhg
X-ME-Proxy: <xmx:w7t3aODh-yljAkSWRD732ItNG6yUbbc0LQis4ZcamKBQwxike85jjg>
    <xmx:w7t3aO7qGPqRWcAHRbiIw6aw4j1175KQaSEDUUAthWxIzQb50VDbUQ>
    <xmx:w7t3aN38BVToaS35wMk-Czh-3E3xfjPZs_JV4t6F6BJw_nqb4N68xw>
    <xmx:w7t3aKnX5E6A_tHYVuVwSK1PD_EDtU6Tr8F_qYKufKGbOP7GwnHMmw>
    <xmx:xLt3aL6z5yfm0ytwrgpyblP-QKDsHayOUorMhrdb4S8dqL0bnkR60yrt>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 10:48:34 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: "Will Deacon" <will@kernel.org>,
	"Waiman Long" <longman@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Breno Leitao <leitao@debian.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jason Devers <dev.json2@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 4/9] rust: sync: Add #[must_use] to Lock::try_lock()
Date: Wed, 16 Jul 2025 07:48:13 -0700
Message-Id: <20250716144818.47650-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250716144818.47650-1-boqun.feng@gmail.com>
References: <20250716144818.47650-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Devers <dev.json2@gmail.com>

The `Lock::try_lock()` function returns an `Option<Guard<...>>`, but it
currently does not issue a warning if the return value is unused.
To avoid potential bugs, the `#[must_use]` annotation is added to ensure
proper usage.

Note that `T` is `#[must_use]` but `Option<T>` is not.
For more context, see: https://github.com/rust-lang/rust/issues/71368.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://github.com/Rust-for-Linux/linux/issues/1133
Signed-off-by: Jason Devers <dev.json2@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20241212154753.139563-1-dev.json2@gmail.com
---
 rust/kernel/sync/lock.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index e82fa5be289c..27202beef90c 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -175,6 +175,8 @@ pub fn lock(&self) -> Guard<'_, T, B> {
     /// Tries to acquire the lock.
     ///
     /// Returns a guard that can be used to access the data protected by the lock if successful.
+    // `Option<T>` is not `#[must_use]` even if `T` is, thus the attribute is needed here.
+    #[must_use = "if unused, the lock will be immediately unlocked"]
     pub fn try_lock(&self) -> Option<Guard<'_, T, B>> {
         // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
         // that `init` was called.
-- 
2.39.5 (Apple Git-154)


