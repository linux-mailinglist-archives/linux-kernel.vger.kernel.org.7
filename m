Return-Path: <linux-kernel+bounces-802023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 628B2B44CD6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177CB1C27E50
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF8A2BDC01;
	Fri,  5 Sep 2025 04:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zqr/wLnP"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26D2272811;
	Fri,  5 Sep 2025 04:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757047339; cv=none; b=p1jHUKWwk94eBK/CJD/9jQYk1I96IC7Sj+T67IvHjroF0sx7ha0WhLVDR2aoKhcN1Z4DoPnPBAqo1yORsGMiAsyQq7FiKuL4AZx9Hf1UtlB9ZmDRRoQed4VNGbW1g2wfvVIbnwaFDPKwrVpHKDBO4I/2AocO+Opzf/CqYLsJiw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757047339; c=relaxed/simple;
	bh=haoC4Iq605Rnw34oLAGAMEMRUfKlboNcZlioATaXcGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEQ1IfD18lipXqmcXPc0jt87Wba6HJtQpwOzT1cnFlbFnh7L7LlyQ8YiLtyhhB4236gN7hsw9HSBsDXQirSsx8I2bNBJ2FIEoJLL3OON89mqewuqw/aY4EGAPHWLBJDyPkZMQW/J+f9SIKQWZmW8sRuwNK6giLNPUWqCq2h4Um8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zqr/wLnP; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b32ce93e30so14747881cf.2;
        Thu, 04 Sep 2025 21:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757047337; x=1757652137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FKmc3OiqoUCIGRN7E+h6XFxZ5GqGhS2cMHJIUmthqoE=;
        b=Zqr/wLnPOcnutq/9gxALxeE4hybwvTPoFHW/IwOG6a9CdYHEN1NWJ0Tg9ufnj+spmX
         J7VtrOjsl41FnOxEfkc5/rPQ2a/pol3j4vCqPL4ANA7ZWry+z1CWl364o18rhmo8ex9r
         L/4UzApR05q4iz3MCM7+OC1TTP8hkKzrIpzUnbSqY1rtg6rJQDU3wzkA/zMKc837QxKh
         EX/BNArEXT5eMFTaKVcfmo7QAdb7YSDryY9kauzKp2pjEuxZHxUvX/hFkIxbKu4siimI
         fiM86QrMqC36SSXIG6g0mRMAUJpekLpCVbrjSSwF5LDNeAL2AKWEfoBLrC7ZBU9G3+HM
         gmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757047337; x=1757652137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FKmc3OiqoUCIGRN7E+h6XFxZ5GqGhS2cMHJIUmthqoE=;
        b=qjlER1mUQDdiI4yJhVOdKcqKUiJSyuUvMm5zZM0jQevq2aH65QKsDf1aNobOEwQkQX
         7ZE2qqaW3HCxmwe1+otb5AGpUlE9eWVDf7Ni8//NHeST3qOSaXYGjmV3h+LuC1t7ijhy
         JB6gwE+6L/w7tiU8QFFl50Up0V8HCJyX2xNgI4mm+2Psb9hioOG0qdwLvH4o4tFiJLCl
         9vRnmW0nqMKSMxFVt59baG66OdTL1o8w1zwgGTVBet6NjCCrUQgUCbMC8QrEeWfFuYqq
         ppjnMAICMxyJZzcP9dR6l5jWkX9usunUGD9vMX0K+MwJr4Cflyx3hIwVw4a7XqORzzcK
         M7uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyhT5viUl0GKRmTCi6qrLf7Lg+w0/Tyx4OcG8A2FUQkbRManzAkm6z4+h1up5Q1zohu2mo3PLpZSdKq4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp6Q6XDQQhvqvVXzLg/AXh1Ef/15nnRggEKeX5fEog4rdtWIJe
	h1ixOwUr5vVerZSVS7MTu+PQgWJfvacU4F4EfR3LIVggiWX24T1ekc99
X-Gm-Gg: ASbGnctFU/l/z0i913WYSe+Zbctdv6BiGSCoc12K2Bv8ykdyGCAD8pR9Tznp1VBpaG3
	+s+ep6Gfy9d8NW0nSF2vNT3xF9+EWUIhSQNJ0K0PwpjamP9yMIBmERuntxGT2np+UoIgMv7li+o
	Wb0IJIWU6zHH48VMsrrt5dhxTL0fuu+/HdetCE2ujddDL6PZCVXUMY3q2Yfl+IC22sPS9GKRZjp
	4U6+xdx14JCipHHlYPCMeVVMgmee94H0YIZRnS7NRRgEP47QhICZwcODsfCXy8kvXooo9j/j4h+
	AhrRa/XHrJsX2ODm8GTOyTLhM4IzXqo137mzt2VeFGbx5UwXS4x9r1SNjx9pltajhlQqRB0oKwA
	9CKg/mRkzE/0Kd8edHb1Hgi52PPLUkpYOKCGjyL3Mq9FTmuK4bvk4hvos1dw06xY6iZh35GB7Y+
	sItLfDn7RjfJu9rwi3AwaAlyFzRXL8VKf0S385hKbQLe3Z
X-Google-Smtp-Source: AGHT+IGrYb1U1PAKjzxlTYJ0D6BmDQ/4FzlKGlepVNh4VkMmJpfwfiq0jfQOV/6ptsw1/56zXKajKQ==
X-Received: by 2002:a05:622a:15c8:b0:4b0:6205:d22b with SMTP id d75a77b69052e-4b31db6a3fbmr290693791cf.52.1757047336847;
        Thu, 04 Sep 2025 21:42:16 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f7838edsm39622771cf.39.2025.09.04.21.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 21:42:16 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id C7A46F40066;
	Fri,  5 Sep 2025 00:42:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 05 Sep 2025 00:42:15 -0400
X-ME-Sender: <xms:J2q6aIAiCx9mpiYFx93xX7ydaaKfSPcj1LfSExGNG-kRWRTtaWG1ZA>
    <xme:J2q6aIOX0A-ry71GQjwfyJigy3qqdN1AIn_vQFHzOkR-h-jEcWSqiPMf4oV5ZbVub
    9NZZDxDXTSnv9SQEA>
X-ME-Received: <xmr:J2q6aNUeJ75ZQpxA5_EKnbE3JJiG3NWzeJ9yXbCL3a1xH_aHgJS4haO6RRqP7Rb5Q9fYAXM33z16W0qCiOrWoOBILrx9yhWH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpefghfffvefhhfdvgfejgfekvdelgfekgeevueehlefhiedvgeffjefgteeugfehieen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepvdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuh
    igsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsth
    hsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhope
    hmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopehmihhnghhosehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvg
    dprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:J2q6aLQ3I7qGWGd0s8MnhDYWgovEQmbE_YAo-soEeqEa5UjzJmwbWQ>
    <xmx:J2q6aD0GVheIQSyX8ej204tsknqPrsdCWKY-iBR6TqNwlfDvag8cLw>
    <xmx:J2q6aIiXQemlz9MW7KWEE1vifjAcpt1iCmKwoUVjawA8VDMLZg9e1g>
    <xmx:J2q6aBZpgKo-ZZmaosp4hJP89yBr0vxRjx6MnMQfRq2LhiRXkw0P8w>
    <xmx:J2q6aBOQGGoaie_A3vaEEU60On6stRjiQL9amni_J9zH0tNFC1U34ju_>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 00:42:14 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev
Cc: "Will Deacon" <will@kernel.org>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Mark Rutland" <mark.rutland@arm.com>,
	"Ingo Molnar" <mingo@kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	stern@rowland.harvard.edu,
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
Subject: [PATCH 14/14] MAINTAINERS: update atomic infrastructure entry to include Rust
Date: Thu,  4 Sep 2025 21:41:41 -0700
Message-ID: <20250905044141.77868-15-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905044141.77868-1-boqun.feng@gmail.com>
References: <20250905044141.77868-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gary Guo <gary@garyguo.net>

I would like to help review atomic related patches, especially Rust
related ones, hence add myself as an reviewer.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250723233312.3304339-6-gary@kernel.org
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 37a753ec2aca..65499b9303e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3991,6 +3991,7 @@ M:	Will Deacon <will@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Boqun Feng <boqun.feng@gmail.com>
 R:	Mark Rutland <mark.rutland@arm.com>
+R:	Gary Guo <gary@garyguo.net>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/atomic_*.txt
@@ -4000,6 +4001,7 @@ F:	include/linux/refcount.h
 F:	scripts/atomic/
 F:	rust/kernel/sync/atomic.rs
 F:	rust/kernel/sync/atomic/
+F:	rust/kernel/sync/refcount.rs
 
 ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
 M:	Bradley Grove <linuxdrivers@attotech.com>
-- 
2.51.0


