Return-Path: <linux-kernel+bounces-730003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FD1B03EF7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432761898CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F146024BD00;
	Mon, 14 Jul 2025 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="djLVffo4"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C18248F5E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752497220; cv=none; b=OPw5R7BI1PFuSQFZCsgU9yYrL6YVp4wgte7NHHOFEWg3rv0gXoCMwUb55fLkvYZrQdALe82WOqD9ZFqnxQMh2OZbI2hVZ6GBDQQwGSRK+FgXRQDfyv/Az82rIF7COmOhXkaUOCCSb2fF79bRdXKgIXtbzvsHUPWKxz1H9RvVACA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752497220; c=relaxed/simple;
	bh=J91ZYjtbwaTMJpu11gGqhMzN1zmkSrrX3uRax3VQX4k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sNvXLpWT9+VOlVkGQn7lnYyHFA8BKRfb0ZvNd50OApO0wiFVgz9rZSqZ8wc7FaZ1vppxgsvsShIh04H8bWtIIA4evXXmKNnqXTO4g9iF8B/cH2KGMYNy1tXw4la3gSbu/x1gf+W3shOcFQyphqZ+GPZ7hWo78MGPlwIDt4e8OwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=djLVffo4; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4f6ba526eso2230722f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 05:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752497217; x=1753102017; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BCAU8VS25IOt9sYf9oIboq5yhkU4imPeOC08UrRhKsI=;
        b=djLVffo41W3YCTKpLmP3i9fNpU9x+rcTwfEI3WVPVQQdUwUYZdLFjy9zvmd9WxgKJ6
         cglgGllzX9rr9A/UB+5PcwfOdWpCfqlfGPxLaSwYdEK/FQI2wz4UO3hcjqlE4yH8dtWh
         HzpXzcVn1SDspV10rK+mBa8T9HD9nlDQ+4mfP19t7SxqVM8yYrP4iXHg7jS0rkE9pft6
         iXXxWs61pbsQDjdp2PwX0ChIxMq+F1nhVNa6khyBXPNZ0zQ90tzpx+euUZ+I9/ywmapP
         WIamdZFBXpfCsw6jh1UDbYpd6J3678Z8NQoUouB3vyFGAxsi5uctaEE2rhm+g6zRqI32
         HKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752497217; x=1753102017;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BCAU8VS25IOt9sYf9oIboq5yhkU4imPeOC08UrRhKsI=;
        b=Qnt7v9C40vkjwQYWPMW8p36WAkMWUaoYx1ZtA2DyenVYwRomGj78Ie04IaSgKpOpCK
         u2At/V3i7yMWgJ5/5hXPaTl/jWQKs/QwOJ/zOGlYxmKkNf7TkXVlOXtHcWKwzB9QtTex
         xHTwQHFYWIvyUBjdnmS03WawRa0xpFdrsM/M0aUh7EwTe+ETjSkGHXjNxlBE36r7YBtV
         CaywaktY1+kPMlwlUhBiOVMs9IbvGD4zv+rwi16umaLJVoM75rCaGMD4IWlnQzpeU/nv
         ZICfimay2SkKPbCRoOTtuAnaWkz5U+c3M4uW0VkaZ+SFNts8oMaWBaQMsHT24oQXC337
         Qs8A==
X-Forwarded-Encrypted: i=1; AJvYcCX/4rLrQaXcPt1zzw75YlWp517JnqIVVi/Z89rJ5ysNmW0YocwSB5U3ynBlf+ZPWeOsRDlPT/0nbLZkDZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7mMylMpqPRjrvr8X0Aqj2rgb04IXmsvebCqwMaFK0WaXWfMeT
	7m9UhlYOffWq+f3PbE/4bTzU6l96guLEtAK/ygqBWGVkHclhJjZ6i5/d1ZLuCIp0lFughS0vY5d
	aR8TAgpwN/UPtV0YwCg==
X-Google-Smtp-Source: AGHT+IHmaElp4RBx+5dPs5oLMrkGNVDwKIXPHrM9xPeMMW0WD12ewivZSlrvWCFl9tPhmrJGiETmE9A+UXAq7kE=
X-Received: from wruo9.prod.google.com ([2002:a5d:6709:0:b0:3a5:648f:da85])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4186:b0:3a5:2599:4178 with SMTP id ffacd0b85a97d-3b5f188e184mr9031238f8f.19.1752497217128;
 Mon, 14 Jul 2025 05:46:57 -0700 (PDT)
Date: Mon, 14 Jul 2025 12:46:37 +0000
In-Reply-To: <20250714124637.1905722-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714124637.1905722-1-aliceryhl@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=855; i=aliceryhl@google.com;
 h=from:subject; bh=J91ZYjtbwaTMJpu11gGqhMzN1zmkSrrX3uRax3VQX4k=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBodPrWgeicSuKw5YfI3216ongBoxX9oo68m/mvN
 72eamAoXryJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaHT61gAKCRAEWL7uWMY5
 RteZD/9cC7JpaRYcoO4yYDovl2LVXJIdg08abJiEQ5GKe7RflOOxPz9i8Xhjc2pAoz5uLlLwMp1
 3QIXlEmBmgPjueunZy0Nx8YiIBFjXKhlYxAywf4Xkkc+7VuwXACh41AqjraAbBbfs3k3L+OybsC
 d+86l587FM/VSt/UTm42r1ygwMB0u6HmmCbC/UKq5ah55WLijo8a4ysA7Cnpfi5z25Qs0lVXLc9
 PX+HuDHsIpSBApHn6ToTWnI5If16Tp5kBjOT0ss7ZoXVoJHnVib030+P691keE85Hy3CUiNz1He
 aGsyzWeWqIiPxltTPD44vCD9+O8pDrnAESUjv7wD6tzIlG1BH3USVdBZ7pP2thmyS/WbH1CBvoV
 cn3h9aCFteU167LHG38IyRJnhLuplL3YTqmwEzOUa7HNTBtB/HYLP5QATADJ44WO/c1JzlKlLEB
 dVL8Q2UrIGC2+70P4e1HT5Y4O8/VUNAHRX7kY+4y9gqOiycTjAN2eZaRia6RSRW7eKnHKf08/JD
 YInGOsGT1QxfuwNrvyeWyd0tOd33ze6+GLDyS7nx83Y3VWBdEfp0sSfosEGVE0O1hB5oaZaMo9c
 bNdBXCQBZmU7xrCs8wM0NVAG6scGfrnHKSyWzuUUyrWHn9c4GSEAjT9d9Nf3dCpYIFgR7nIBnzP MoHsNxCnKsvdP8w==
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714124637.1905722-2-aliceryhl@google.com>
Subject: [PATCH 2/2] pid: add Rust files to MAINTAINERS
From: Alice Ryhl <aliceryhl@google.com>
To: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"

This files is maintained by Christian Brauner, thus add it to the
relevant MAINTAINERS entry.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f4e99716183..e46c90a52f83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19510,12 +19510,13 @@ M:	Christian Brauner <christian@brauner.io>
 PIDFD API
 M:	Christian Brauner <christian@brauner.io>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
+F:	rust/kernel/pid_namespace.rs
 F:	samples/pidfd/
 F:	tools/testing/selftests/clone3/
 F:	tools/testing/selftests/pid_namespace/
 F:	tools/testing/selftests/pidfd/
 K:	(?i)pidfd
 K:	(?i)clone3
 K:	\b(clone_args|kernel_clone_args)\b
-- 
2.50.0.727.gbf7dc18ff4-goog


