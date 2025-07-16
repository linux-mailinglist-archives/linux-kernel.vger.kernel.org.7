Return-Path: <linux-kernel+bounces-733751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D36FB0789D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71501892B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7B02F5C27;
	Wed, 16 Jul 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iT3Lq+bW"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039A52F5337;
	Wed, 16 Jul 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677323; cv=none; b=tjpvHUiwCMJ8F/K7eYrK+KCtl6Jr20YnqzrWX4kDrjd/vQQ4aIn5Zsiio56P7lIgw0xSJVBIyWq9cDmcbDhPMKsXLW/NC9D+HGgeczmUDiwjqyKaqYBgM56J33qwZ/sWa+GtcL5U8qKi6XHPjYRW+Uje64PUyS83kxNjUBMl/ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677323; c=relaxed/simple;
	bh=qi+QVChNF8r4ZRImMMEYigXjb6VC+AHzdyzKRRP1h7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tbXDRdQaEPA7U5ifRLmwryjtUmAtwFGj5COLG/F/sNAMMoxIYkgs/aMf1F+jAp+dec8v8Nzw2TujWV5GFGqtvg/Gh7HtGWI0H1Vb/X18rnudWBUHqa+359kCSKQhvghpJvNPxFZwGLgs7mJJo2m1c52nEUzRGvhylBYjebpKlIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iT3Lq+bW; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-700fee04941so83746d6.1;
        Wed, 16 Jul 2025 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677320; x=1753282120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2jJtlf9oYQnJT+FKbRuWUa6nbrsl5qwGbSwAIcd7eA8=;
        b=iT3Lq+bWnya/xQujgx7YsuQsOAE/31Q2vHHDdLmOMtJoKK3cZQDYq4mWovCOOyi0c3
         5MLSz5tJjgbK3EiDkr3tp8H5RpJKH7rL47p+WujO/IuEWVNAi/th0YH5VeCuEUHZoJi1
         9xVLW5PHL+2pck5XndLfbOuFs4yfi5fYArymTNwQXRVjlyYRM283eVbLEflrmlXn9fON
         XD0SEfvgU/y9bDUn9V07RJOEkxrK4yPAayyadlqSWS4dnCRH1IAo8CWxn7Jd3moH74fH
         OfjBPBKIB8RrprcR/jp1Znh0HUThqJRq8MvwGDo5h4bWS5FfxNGCfCtg9/r40BhY6Ik2
         RPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677320; x=1753282120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2jJtlf9oYQnJT+FKbRuWUa6nbrsl5qwGbSwAIcd7eA8=;
        b=wbYcdltwQsPQY9MVaZkkZVCAkyDZdSIVMYuXEFJHkoQhr1eEpOicHKQsvMC2wFBTHM
         nZaJAeNHd+AyLMRjgQuF2I/XNY0frxeoVBAYkYJxQqi7mfLGub5Zv9UdPSMN5tj+xYIC
         /B2Ei1K3ltMZY0Vb9jcBRdmnuCIYL7mRNJ14PGnkAaeIpiAuYj4tODzSXsV1B+nZvPUG
         f9H1Q135uD8q2pI3IgLN0jZpjiBrEvgPk6LEQ1z9iXcu4T0dbWUxFwY6Ez4+v7Lyvj/T
         QiqQlT8a/4e10fyQa6pFn+mly+kzBL0j8BJoNgkSIPPF9B0YR2zZLQWMulBD+wJWOFYR
         dlfw==
X-Forwarded-Encrypted: i=1; AJvYcCUaRH8ud8nGdrlxvzXvRxca92TMzqj0+ZaA0LVY1UTlknV0anAZ7fymPjD+XTZ+7nwHAUvUuJ2bYJWCIIAiHh0=@vger.kernel.org, AJvYcCVzcgflL9XcJ35m9Ozl9Hy2jZXrQPf0XdWdzuZb1CRd84CSpd16vS1e4w3r/ke4/0EoK+djt4s6A7qkYzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbRM39jh4cEOaHQ3wnUPqhxYgvFoytzvP1xUC2MMPntS0IgmpL
	riGmHquxhysn4KAExnXTHYVAS+c3eZqQt9aL2dmano4lgY6eC+cNN4ID
X-Gm-Gg: ASbGncuVkzmdCa+bx9KkLrj61PzSAfIe4m/A+W0Z0YgfsOqy0a7Bz5HMjWtIYamqIKl
	UMFV306cStj0Zo0sXUGs0TYEFglY4IbYaafOiQw9yk97fAhYC79QbjxVngeTm6fu6pK48oYokER
	MiIdupNJ+1Rbq8LHlYUYVnHvRyvSFC2nyEEevn8XSiULtHHMrcbnDAorqNn+QFTyebxrA0A9FXf
	Dudmr/fslU54fjE80R4AcAaRCB3/aXVZS8w4M2VJlNUkoRfXdJpFEvwexsiF2I+3h16goZfB0wG
	PGeo6OZH8xR4W9Cc85Wsy92JjLW5nBzxox2MaekSn3kH6qBSph0vhiReeLPNK1TlMxnWQhOKb6X
	dGXr62SBkhUovUp0sVaLD7QGZQ4HLnZgd7lGBlgHCsL8j6hnZHCYzrVp5GJfTzz6CCq+zHWs2Yy
	1GNgSxyzbsWx64
X-Google-Smtp-Source: AGHT+IGjHp1Ke1LEs2zbb4+T5KyROgCWMtI+o6wcUP7tagagMNPKp5SmYUeYbfbyVctwuicdjiFBoQ==
X-Received: by 2002:ad4:5c6c:0:b0:704:7fe1:b26a with SMTP id 6a1803df08f44-704f480b480mr56588116d6.16.1752677319397;
        Wed, 16 Jul 2025 07:48:39 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979e459csm71272446d6.49.2025.07.16.07.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:48:39 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9C955F40068;
	Wed, 16 Jul 2025 10:48:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 16 Jul 2025 10:48:38 -0400
X-ME-Sender: <xms:xrt3aCd_YHf-HlOeaFAhgNsvlHiBaMDTR_elW7mTxBh0_yQJImF8Ew>
    <xme:xrt3aBvE0dbB2_MIyo5x-GWFAoytvq0T0HVbCKa8WuC-mvrJN_os7mS5vn392Jixb
    ghFgSuuOiifTdTbsw>
X-ME-Received: <xmr:xrt3aCmTY0uuQ_6mNIT5zdvfQqblZuJMlxdZD7rDSZVuvN--lZqth9sfuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehjeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgffhffevhffhvdfgjefgkedvlefgkeegveeuheelhfeivdegffejgfetuefgheei
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    uddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihhnghhosehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgt
    phhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgrnh
    esrhgvughhrghtrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhgvihhtrghoseguvggsihgrnhdrohhrgh
X-ME-Proxy: <xmx:xrt3aESMAZFH2pcHmcZ5qe3_RbcgcfjRxTGMdtqJeeEsfgx2d2hWbg>
    <xmx:xrt3aIJPyLrmI77ughtTlbB2rfltDAzsCyQTLYCnp4vc6LZTaxk-2g>
    <xmx:xrt3aOHHgAPN95-msiGuArgHdgJfcvB15aBCFE_aKOSfXguiPPSDOg>
    <xmx:xrt3aF3gQvh6sllKxHQR1vJZRy7tBt_q4y6khnnV3_qZiIZruQ4X1Q>
    <xmx:xrt3aGIgs95YXtFD6jzYcxo53Zt3CT6rw3Oir7Zf0HAokaGMmcnbF2Sd>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 10:48:36 -0400 (EDT)
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
	Jinliang Zheng <alexjlzheng@tencent.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 5/9] locking/rwsem: Use OWNER_NONSPINNABLE directly instead of OWNER_SPINNABLE
Date: Wed, 16 Jul 2025 07:48:14 -0700
Message-Id: <20250716144818.47650-6-boqun.feng@gmail.com>
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

From: Jinliang Zheng <alexjlzheng@tencent.com>

After commit 7d43f1ce9dd0 ("locking/rwsem: Enable time-based spinning on
reader-owned rwsem"), OWNER_SPINNABLE contains all possible values except
OWNER_NONSPINNABLE, namely OWNER_NULL | OWNER_WRITER | OWNER_READER.

Therefore, it is better to use OWNER_NONSPINNABLE directly to determine
whether to exit optimistic spin.

And, remove useless OWNER_SPINNABLE to simplify the code.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250610130158.4876-1-alexjlzheng@tencent.com
---
 kernel/locking/rwsem.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 2ddb827e3bea..8572dba95af4 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -727,8 +727,6 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 	return ret;
 }
 
-#define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER | OWNER_READER)
-
 static inline enum owner_state
 rwsem_owner_state(struct task_struct *owner, unsigned long flags)
 {
@@ -835,7 +833,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 		enum owner_state owner_state;
 
 		owner_state = rwsem_spin_on_owner(sem);
-		if (!(owner_state & OWNER_SPINNABLE))
+		if (owner_state == OWNER_NONSPINNABLE)
 			break;
 
 		/*
-- 
2.39.5 (Apple Git-154)


