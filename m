Return-Path: <linux-kernel+bounces-824261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18132B88863
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75C8523EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2D72F0C6F;
	Fri, 19 Sep 2025 09:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7lC1LKG"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150A727AC57
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758273176; cv=none; b=uREmT6iVSRrkFfVnouBpAB32SY3z8rA/vt0y5GTJndpjpggBi8WJTjdQ3Kjx785Ikmmz2lJY+00PlwPUpfZYxUvCU25Hfc0HfGmyH3pSUooEUYzw+0JvFI1vy1+hr1zUgpCbQSHpex++ls21fhUE/EWjqJ2DpjAqJXGayOZ2dUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758273176; c=relaxed/simple;
	bh=926HOgz8gxzG0OhowK+NIkyZJmV7LXYWGTd5SEq48FA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T9i7XMmFLHiLmuF4f4mR4ioWI2wgBxiHJdjER/Cp+YAGGK9z9m2gLXs1ZwlyCwTlmXQFClz13r3neocMkayRw3xnx0P8qr5D5jO+gMXHrL0q8WtIeaCftyPo1nICt8ud7bV6e0sJGjutMj6iroaVK+8dff3fxJusAAUFOvnFLps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7lC1LKG; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b794e9a850so15376601cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758273174; x=1758877974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FLP69wPPTyBl3iI6wucn9C3HytX7tdfXjNtYh+fleXw=;
        b=O7lC1LKGAba6cOegMO51W6wE5aJYCL78+sJ49BBa7aobaR8uRLz+BQ4X9T25T7eXid
         dc1qLFkR+jWV5Tc3sd+c+QEVYMAz1ZoFygAbKSnhdU1+nGVSDE1ltj0dPVhLfChtxxsO
         w0nBj5wkCuntLgE7Ps/OJI2Q9hxxg6j5+MmxmPMrkQMyvErieedo/u75O2DVsBn+V57l
         ni3BsE/hwd2i+Hzgc56SRtieo6lenjFEkfYH8nmX1DKsa+ab5vY/w5DFYSZt05F9nSr5
         /lSE5s1XcA+6kAWYbnH+1DFtGHMEEldwE5D8BTI6NsqfCdHqei4pjvPkVOY8AJGwJc37
         9OHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758273174; x=1758877974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLP69wPPTyBl3iI6wucn9C3HytX7tdfXjNtYh+fleXw=;
        b=lrtrQj+7hM4NVY2DKjcpIby0gWfqXLqLwc8vWXbo99ElrGXrwPiXa0SsLd0mGkO9rK
         l9ICJkgLsD0Smf6l0YKkRT+s0CczsS9R88NGCJMXUWi6BeT60AVcMl2GwDngPVrmI9+t
         4Cyh0QyT0JAnuMcjJFWc4u/VTpQkYtYua+dMsXC0iZIckg1u7PPASd/d79+cFIRLl4Yl
         5UJ8/70O9Bu6e/okfT5KcnZO5JEF19zsmRr+sPLpqRRB0gYNsEU3vYA13x6SYtt1qs9t
         OEOe2s4u4fARrmQjCrXPA6AyuKwv+lmYIAw6+uL59HGnjtbFX+13F9Io5DWApZ+UPntG
         52QQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5/JQlIfhaTOEfReATt9iC+A2hba5IGjLPLDDhS2vDQKpEuT7Dh2MYB7HcPK2RWQRDsfdzveJs3Wkh/Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFbgPO1iPhxhBP+8NZClhuNYnpAB7pSBiibE4cUG+Rhoai/1HD
	8SDFDy2KTAZXEjZNRhpKQJ8b05PUMLQTguP2OMykOu/c3kTS5nca1nHw
X-Gm-Gg: ASbGncs8rQPGT4HAOo5cdQXOJIxdkHlOwnaixk9Xuyf04vK0IyKsjWtElhaI+55Y5Y1
	JZXozT2HymAeZ6SfZklfDJzGNAVcrELkeZ4SINQep82I8YMZjCUcncO4azze9PydYzaX7wjCqW7
	rI31cMhNEkafZQ9uE9K8o/3VLOGpAe1ljX8+Y7yRVBmnu/2V1zLLkVFVxoyAdJHYOMJ5Y2hbRov
	sX5PdED2uxtvlAavw03XXsOCNR3OV1Xsq+m8P16jdEZGrBzKwOQ9OgjYYYtdV2TLLQcO1aVZOkM
	LR3d+RMLwqOJ/x1tbL/jl8uPL8BAxvolJJDV9RNxpL/yVpCeTg1m1GQW3XrFDooBWRcKkH6Jhfd
	m3GLCZN0sC2Fss3RGZMmflUNTv5suTy9IDF9kYjnyYVMMMmEl0AjEMStq0pGNIml8kjWjjNhIJ0
	cd34BXPIRROb4C
X-Google-Smtp-Source: AGHT+IGKevs+ZRXSIZUcCkojfkPosvm16AJuFo9XOQFQbaodj2jImJQseN3Lbq6/BNffjGONr4LqZw==
X-Received: by 2002:a05:622a:138c:b0:4b4:924c:aecb with SMTP id d75a77b69052e-4c06cbe92d1mr21104121cf.14.1758273173875;
        Fri, 19 Sep 2025 02:12:53 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda943b56csm26678131cf.39.2025.09.19.02.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:12:53 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id DACEDF40066;
	Fri, 19 Sep 2025 05:12:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 19 Sep 2025 05:12:52 -0400
X-ME-Sender: <xms:lB7NaLq6Q3BjTxYC98o5ZGegSeBTkoELuIR3M6ozx8fjAJ5SwVwnbQ>
    <xme:lB7NaMOmtyt1fg3YROSJNapsU2R0xubuSjbC0ZAwPHJcNVcIUjyrI9B0j-c_V2bFE
    JA8HJ_Br96LsXyt0g>
X-ME-Received: <xmr:lB7NaJ6QrIeFN6HdzX30bo1_E78QWnYwRNPnhqd1UmEc97jKOaf4mEWida1p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegkeekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfhvghn
    ghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnh
    epgeegueekgefhvedukedtveejhefhkeffveeufeduiedvleetledtkeehjefgieevnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshho
    nhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngh
    eppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudel
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghtvghriiesnhhfrhgruggvrg
    gurdhorhhgpdhrtghpthhtohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoheprhhushhtqdhfoh
    hrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmh
    hmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfihilhhlsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprh
    gtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:lB7NaIXZ_tVBUerGN90gG6-mwnFgkkiWK8yG7vb2EoJxfOj7-uymhQ>
    <xmx:lB7NaL1TQhYIAcCcKtk3nIW89jbnmpPdDus_nzVb5YSotIynaVDhDg>
    <xmx:lB7NaPNpFET8Qrs0C01ivQ3LAIce3VU9DKSc6Q5GAF9nbmelKllxXA>
    <xmx:lB7NaO1FtzYHP-KnTMzpfgbLngFU-A_CXDpdE9iYudp6Z6hp4QZ0Qg>
    <xmx:lB7NaG38oyQWmdR888zLmRgPNXjWHsh09GSBvT9f3omNOboFwgqU63DE>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 05:12:51 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: "Peter Zijlstra" <peterz@nfradead.org>,
	"Ingo Molnar" <mingo@kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	"Will Deacon" <will@kernel.org>,
	"Peter Zijlstra" <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	"Miguel Ojeda" <ojeda@kernel.org>,
	alex.gaynor@gmail.com,
	"Gary Guo" <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	"Benno Lossin" <lossin@kernel.org>,
	"Alice Ryhl" <aliceryhl@google.com>,
	"Trevor Gross" <tmgross@umich.edu>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"Andreas Hindborg" <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [GIT PULL] [PATCH 0/4] Rust locking changes for v6.18
Date: Fri, 19 Sep 2025 11:12:37 +0200
Message-ID: <20250919091241.32138-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Peter & Ingo,

Please pull this (mostly) Rust locking changes to tip. It's a bit late
than usual because I was at Kangrejos conference this week, however the
changes are relatively small and simple, so I think it's Ok for v6.18.
I also try using "git notes" for submission links as Thomas suggests,
let see how it goes ;-)

The following changes since commit 17d9f8eaa87d40a2ff66598875a43363e37a909b:

  MAINTAINERS: update atomic infrastructure entry to include Rust (2025-09-15 09:38:36 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/ tags/rust-locking.2025.09.19a

for you to fetch changes up to 9622209360c25d78a81048a9db72f1efef7fbc58:

  rust: lock: Add a Pin<&mut T> accessor (2025-09-15 22:28:35 -0400)

Regards,
Boqun

----------------------------------------------------------------
Locking changes for v6.18:

- Fix a data-race in do_raw_write_lock reported by KCSAN

Rust locking changes for v6.18

- Make `data` in `Lock` structurally pinned.

  Previously the `data` field of a `Lock<T>` is not structurally pinned,
  and it's impossible to initialize the `data` field with a
  pin-initializer, hence e.g. a `Lock<T>` where T is a pin-initialized
  type is not supported. This encourages workarounds like
  `Lock<Pin<KBox<T>>`, which is more complicated and less efficient.
  Therefore make the `data` field in `Lock` structurally pinned to
  support pin-initialized types in a `Lock<T>`.

  Since the `data` field is structurally pinned, make `Guard<T, ...>`
  only `DerefMut` is T is Unpin, otherwise `Guard::as_mut()` is added to
  provide a `Pin<&mut T>`. This is different than normal Rust standand
  library locks.
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAmjNGoEACgkQSXnow7UH
+riU8ggAnRUTBam8NTmHJpZfVbbNSfx1ndaARxd9Wb/MLEh8OHYKbVRPJwvWGge+
dafO0VYULku7ho1SeIlLXp4Bbjy3YC6o/J6xOpr9xMmysUky7RHi+Ys0y9gKaSmW
daPurQEOS8TBUWu5yVxNAfWoRgPEiPULovbzgANKKAV7QsljyoEg7mQCPxLftPze
Hr22HxU+lr6SDH5Efc8ihGqXJAvwunk+0mkJymZbjWo3ZF3cuhXlTMcIlu1SK14a
R1VQu5UoX8S5y0T0gkJ84UJ11e0wrSZyT0EqmHWSpVBnyGgWk8H1u284hDiGG2iG
FvwoSQ9iVuxLhxjhPUSOjq30DzmFfg==
=MZj4
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Alexander Sverdlin (1):
      locking/spinlock/debug: Fix data-race in do_raw_write_lock

Daniel Almeida (3):
      rust: lock: guard: Add T: Unpin bound to DerefMut
      rust: lock: Pin the inner data
      rust: lock: Add a Pin<&mut T> accessor

 kernel/locking/spinlock_debug.c |  4 ++--
 rust/kernel/sync/lock.rs        | 41 +++++++++++++++++++++++++++++++++++++----
 rust/kernel/sync/lock/global.rs |  5 ++++-
 3 files changed, 43 insertions(+), 7 deletions(-)

