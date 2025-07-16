Return-Path: <linux-kernel+bounces-733753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9AAB078A0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14CE189CCBD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC182F5C5F;
	Wed, 16 Jul 2025 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj7XYEdL"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED0E2F5C3C;
	Wed, 16 Jul 2025 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677327; cv=none; b=cewxpDmOXtns/xR31tMjnecn9kmpX2cubdr5wLhKWg5ebMB+4IVXO3kNPcbpfjMocBYz/iI8JDmJndlzyx6ZcxXSDex6vtpr2qIsk/exbAVdDyj7+Np33ZDXT6q2F0sHL4s8Ofk3W/AIRuI1i4dhG/L4SPLo+vN/9StS24MLRo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677327; c=relaxed/simple;
	bh=7wFuk//I4jCqJCb57E0XDPyIYe9lxjI7SqzxAVdKpH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y/HaeerVohElbubc3dFpieiYolylOopLYs8bFT2mLuadlevkeNSCkXX0rnpQ5mwdy7dWyrNTcOLrA0TPX+S8q4lmU/UXGYwUUrx9RtALM5sOVPyTXxWaAIS3+Bg43s4CPCLbFVQb68EjNL1wzsya/d8ywxvZ7kAb4FSOAqan/V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pj7XYEdL; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ab5e2ae630so43050831cf.3;
        Wed, 16 Jul 2025 07:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677325; x=1753282125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bXPVr/G9SRnd6R3I/P1k9JsMvcyWlWkDxRUnOYYx1cM=;
        b=Pj7XYEdL/rJVqi+pY0BVifPFcDRCJ+5nndZgMiJiAwLy4QmIsurLO36bXLKg9J9M0+
         YuSXirpPSQcd0g2kMy8Bm1j1vKGDAaQtDM+o1NypbCyvZadFC/PSSX4/f66PgZKtfT20
         S/bxadOHgdD6kAckSEZqeokoiSECdoaGknwjfhC2nQqbjyUANrhJwFcPYjkUnk4f/r7r
         7utP4IIaK4oMrKZpGHm7T6aX8LeTCK5IHBCKsfh4WGZiGkFShJgwU2RDG+FDea/xRuPh
         YVUoBPtLVsWO0t9EKx92jd78j7kIY9sL7XcEuAgp8PiFKYjJ2Bm0iAQvXJOA6y4bHZX+
         2M/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677325; x=1753282125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bXPVr/G9SRnd6R3I/P1k9JsMvcyWlWkDxRUnOYYx1cM=;
        b=bS/z0ddn+KY7ocWdvBVYcjAGmat/KA3N3MOniTA2ma1hwVstq7XwWEcsmDIhnkyuLS
         srczg5OpOyWQcDfWHny8ED+AY9zP3g4AN1ko+KyFpn5VubD+A6dYj9cyokmXMqGfn2Ii
         XHsBIWBnnZoKcbk3J57FeAW/XHiPPtp2xhCCPvKv/duCRe6d1lWohW0KifVzLF5PYtaf
         RjaIefj7UDNFMKQiji1c9E4eSAF2byf++ZOEIlDuWTKA0DJOFFgjkKhDdiGWIqnjkrIc
         ANrYSMh7zzXruenTwggO9R7vOT9c53UPyn96tJTnRcokoLdMKg5C7kHCB+IgKbKO7kB1
         2Vpg==
X-Forwarded-Encrypted: i=1; AJvYcCVS47y0udHcvJMa7MQQxpyZB6ozj2wCVWpLPjqcaXDNz3+xq68iXPBuUzR0QipS6+nNhmu0+jBfDOVeaf0=@vger.kernel.org, AJvYcCXQpUGnms3Iu/giXr3DCFHyBZpldnDX8Ro6OHVq7dKrxB2sR4PD5xCOvgo3GkhxZv2kb8TSImWew+TftE8T1h4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUcmjqJb8mvc+NtBVlHr7CN9aXehCV2mmBQuYmlu0JqBsOW3Bp
	avcjLsNslp7N1C2SA7yXHaaXxMvHugR3OcsEim9MThB12WDS1Ye5EXAQ
X-Gm-Gg: ASbGncsgz9Psxr0uSRzK2Mo7f8gjLHrzsG66pkBBeE7qy2ykIg5ZyhK7SAocsQEKfIr
	s2YVuOAz8tzgYfO3uN6YANLeIV3wJu4/RkUMyN0bgg1AQiL1U8dKngL7XVwF9cZtxW3Z9EiNNKp
	5dSZqwb+JlXdfyw5cMFntRncICymONJrKpK5SqGo1XCsATmcR1rBjbK9hgIKDWySeC/utxJHG2u
	zllS2vInoYqtxVPtkhEYK6N+J+/KzMqY2eqIzRR5GjvaX1KTrz1PF0wfmrgWXXPMrn4mNIgd/n8
	F7m/b4htGRwuMAH7jVqa4wpl08nl3oHrUQCTYs0FgcvT+UD9+009vDYikYjs33pIcfjJqhyiC+I
	mNq/2uvCXKprLBo/jYYz2oqHu/rqSh+xDhWwje/aAgl6VbcgyMFxK8sYi1yG1PKlPa/wGA45PFV
	cRX2+o+nwWhcmZHuDr5gQ2hP8=
X-Google-Smtp-Source: AGHT+IF/dtXIRpCX2+QbvBlOKNCiVq/mN7KKeieR88SAXg8wV1F4ja7jwBHfC7ebwGqZjDwh0iCc/A==
X-Received: by 2002:a05:622a:2509:b0:4a4:3449:2b82 with SMTP id d75a77b69052e-4ab93c9949emr53972251cf.13.1752677324869;
        Wed, 16 Jul 2025 07:48:44 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d393f9sm71216146d6.63.2025.07.16.07.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:48:44 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id DD682F40068;
	Wed, 16 Jul 2025 10:48:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 16 Jul 2025 10:48:43 -0400
X-ME-Sender: <xms:y7t3aMZPe0c9fqMKP3E3crOYXMKX88oB_YDy84QdG4n0o9eXLNxyzg>
    <xme:y7t3aE6-ovGsl0uvcA_-ZSYsq6NcvFQTVrGlktkXiB6vMrnvHEFVgPyNoiHOlaFCW
    9JiLavm5AWsDrq6BQ>
X-ME-Received: <xmr:y7t3aJkO88r-WjTYjwjHtSKgTg7eFCdf14Z6GKjTE9BApZIdrIrOn6Lw1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehjeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgffhffevhffhvdfgjefgkedvlefgkeegveeuheelhfeivdegffejgfetuefgheei
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    udefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihhnghhosehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgt
    phhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgrnh
    esrhgvughhrghtrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhgvihhtrghoseguvggsihgrnhdrohhrgh
X-ME-Proxy: <xmx:y7t3aMH6HbOymezKw1aHRIndSfrPOOwl5yMSNFhMLbwRXugUgzKgvA>
    <xmx:y7t3aKhxeetrOqi9orXCO5Xw9ellisU5X61elqWnOAHDEOybqvEuzw>
    <xmx:y7t3aJjcHPV8D0RgnTOB6iY6vdIWKlG1PRb0e5Othn0GlL8kJ6Qh7g>
    <xmx:y7t3aNm7uBWl6R_6o74ISrqb7IvVsSCGaLV2FeHuuKapqoGLDRl2jA>
    <xmx:y7t3aNaE9HQw5lV26EGvlLJAegqiOIfTeJEzclNkxnABmEeMGZkM6Ysi>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 10:48:42 -0400 (EDT)
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
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 7/9] locking/lockdep: Change 'static const' variables to enum values
Date: Wed, 16 Jul 2025 07:48:16 -0700
Message-Id: <20250716144818.47650-8-boqun.feng@gmail.com>
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

From: Arnd Bergmann <arnd@arndb.de>

gcc warns about 'static const' variables even in headers when building
with -Wunused-const-variables enabled:

In file included from kernel/locking/lockdep_proc.c:25:
kernel/locking/lockdep_internals.h:69:28: error: 'LOCKF_USED_IN_IRQ_READ' defined but not used [-Werror=unused-const-variable=]
   69 | static const unsigned long LOCKF_USED_IN_IRQ_READ =
      |                            ^~~~~~~~~~~~~~~~~~~~~~
kernel/locking/lockdep_internals.h:63:28: error: 'LOCKF_ENABLED_IRQ_READ' defined but not used [-Werror=unused-const-variable=]
   63 | static const unsigned long LOCKF_ENABLED_IRQ_READ =
      |                            ^~~~~~~~~~~~~~~~~~~~~~
kernel/locking/lockdep_internals.h:57:28: error: 'LOCKF_USED_IN_IRQ' defined but not used [-Werror=unused-const-variable=]
   57 | static const unsigned long LOCKF_USED_IN_IRQ =
      |                            ^~~~~~~~~~~~~~~~~
kernel/locking/lockdep_internals.h:51:28: error: 'LOCKF_ENABLED_IRQ' defined but not used [-Werror=unused-const-variable=]
   51 | static const unsigned long LOCKF_ENABLED_IRQ =
      |                            ^~~~~~~~~~~~~~~~~

This one is easy to avoid by changing the generated constant definition
into an equivalent enum.

Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250409122314.2848028-6-arnd@kernel.org
---
 kernel/locking/lockdep_internals.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 82156caf77d1..0e5e6ffe91a3 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -47,29 +47,31 @@ enum {
 	__LOCKF(USED_READ)
 };
 
+enum {
 #define LOCKDEP_STATE(__STATE)	LOCKF_ENABLED_##__STATE |
-static const unsigned long LOCKF_ENABLED_IRQ =
+	LOCKF_ENABLED_IRQ =
 #include "lockdep_states.h"
-	0;
+	0,
 #undef LOCKDEP_STATE
 
 #define LOCKDEP_STATE(__STATE)	LOCKF_USED_IN_##__STATE |
-static const unsigned long LOCKF_USED_IN_IRQ =
+	LOCKF_USED_IN_IRQ =
 #include "lockdep_states.h"
-	0;
+	0,
 #undef LOCKDEP_STATE
 
 #define LOCKDEP_STATE(__STATE)	LOCKF_ENABLED_##__STATE##_READ |
-static const unsigned long LOCKF_ENABLED_IRQ_READ =
+	LOCKF_ENABLED_IRQ_READ =
 #include "lockdep_states.h"
-	0;
+	0,
 #undef LOCKDEP_STATE
 
 #define LOCKDEP_STATE(__STATE)	LOCKF_USED_IN_##__STATE##_READ |
-static const unsigned long LOCKF_USED_IN_IRQ_READ =
+	LOCKF_USED_IN_IRQ_READ =
 #include "lockdep_states.h"
-	0;
+	0,
 #undef LOCKDEP_STATE
+};
 
 #define LOCKF_ENABLED_IRQ_ALL (LOCKF_ENABLED_IRQ | LOCKF_ENABLED_IRQ_READ)
 #define LOCKF_USED_IN_IRQ_ALL (LOCKF_USED_IN_IRQ | LOCKF_USED_IN_IRQ_READ)
-- 
2.39.5 (Apple Git-154)


