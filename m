Return-Path: <linux-kernel+bounces-733755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F15B0789A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B8917CE09
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ED42F6FBC;
	Wed, 16 Jul 2025 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKHa4NUk"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAE92F6F90;
	Wed, 16 Jul 2025 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677331; cv=none; b=AGECsfzCkEp6We4ZpD+eeVbY9ZtrRg2VlT/aEfJPEHC8/He4Immyq3bj3He4JTqPlNr3I6EVwBsxPgrbTb00Z8xoQhgfeCIB+/GauDFfct8QI9PGMHWU7jI5LzPAX1PvJXl15We72IyafeP8oFgbiDO9QTC3fwB/eZePEZIK6No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677331; c=relaxed/simple;
	bh=B/G/h3DzTZ5l3gzwjOz1Y2kYUBFTft8COk37YBqvG8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QAFqld6NcyURXOYMEMPD8XqQ3Y8utyPbV46k+C9p0euAr+uErySKuCBtLqw1NvfKDXQuNLoEnz9vw6YaIn4g/LAYFr1U83MhsJ+khbJxWsFZzN2UNPgaOJLiNsrSzEMn1mQiOhzThQ3ImjjSnIczzNNJDs8yeoI5nDbKCWJdbdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKHa4NUk; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6fafb6899c2so223276d6.0;
        Wed, 16 Jul 2025 07:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677329; x=1753282129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fFUKul8TI0PZYiKj5Q3Utj0w+gDkfjmndLdV5N94D94=;
        b=bKHa4NUkwqQcKHmLxQc5fMzjzY+s7W6xO7Hgvf0vGTYmphWnmpwa/ZBAf9jS2OGJ/X
         NCmqt8QfF2TSHKyDWu/HHhT6UtP52ZAM8dEQqR7CSooeLj1IZSe8NIsBrmEH4vPxtVA1
         lDFxcL0KFcXV+kqrly3iXf4/RDBVBogQErNaoTHwl83L9QBdCb0yAq2EVC/wuRUVFd5+
         SlWVnxoHVkk3sGLGdFCWJc/I/z3hbY2S2QgAKKNXYSOfGaVsnWXA7/ALIORdMJ50iElt
         SqJ3ni3E3gftYKsCZPtMqVoF+I+xPCIlXhLSJyrFg/S1Y0iLIns/ZI/32dd7+IHxD5Fx
         ZKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677329; x=1753282129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fFUKul8TI0PZYiKj5Q3Utj0w+gDkfjmndLdV5N94D94=;
        b=NfebBtfmLh8KvNpLKwtHw/3IooxWZ1ltTPlauW43eX1mM9fvqbWJ3zQrQDsQhZez0j
         81D4w+qFK+90ayj0yS+oup6nACyoUgF/Gx7PNMFfIhMJw3xHUDWMEd+h+fvViljHFBDu
         JX8+1ibpLzP47HWqGBovp/za1H+1/hZEK5agnGMemxF45TgcSTLFtD4CcCP6VDsmQk/F
         /d7/yPVIZdwWLmHZWmRMaNPxnjjlOCDQJEfSH+xLV1q2mWJq9AFI0sTjznmAsWIeBmnA
         ieEyUQJgGSUGPhBi6J17IVmSm8QidhxuZV8/stSutDL7mMVIZmGs1Z69MZhSIPJwKCl+
         dhIw==
X-Forwarded-Encrypted: i=1; AJvYcCUhiBeY4WaY8fjsqijrVvJ9pE3HZ1NLtoGYctbAZ5K9+cS0qLOiuYfPzUaqUJJtSisLwJsk5l/5KJVeSQc=@vger.kernel.org, AJvYcCVu0BXTz/rzUESps23cgCIcrQNTptiwF21uyOgCH6W+n/hrTrM8YXckzm3+OqgPaoj+edGJ5SzfzEyV9HwFKf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvMvYEPIvhPo+11vfg8qYP+54MkKvAuVsjk4vTGPK2/2iEgf/C
	glZspxe52M5dBSviGGGyqx52lE7KSr5N0IFCnUIHJUUA8yNOvKq7B0nE
X-Gm-Gg: ASbGncttRaVANLftK0WylyiC4Old/Lx83jPOY11qv6YlZlznfgDnBWyT+MwBaEugl4/
	fq9PoDEdVJ8hzrAvRC3ti1/GulY7GYPswemmTEt25aUxfH1F3fwDD1nQKxg82JlZTZ15/9qygEY
	/VePvX7vEGVd19/Wyt4WXE5Y32drye/5Dgl3z+LpmdmCa4EEQK9U+w/Agm1+qVugzbsEt8SZs1A
	viXy6etfT8bJUaRMKzbIulydS+Ke91Ba+t/8jNxZPh2HT+P7dUu7umzAbJH7vdjL1JV4+bfH/Vf
	fgj6I1H0a5ikruWgt0G7HlcmEVu7nZNuQupS/NEw6NtVJtZ80cdpVU0X0Gb1dxtdiC2i09IVb4x
	c42o0Fv8y6AkGkEVjJ+x/zDp3uujKJTkgFYha0wPiK/e9zMSsvA09jLGwRXo8CRFSQJEFbaA/z9
	3EXGdb7/+gGq+a
X-Google-Smtp-Source: AGHT+IHeGtrBpWGhlH8jTxC3f6x5GH1RdbWlaCb4ayWLo/Ftp78eUXfDL3UH40PwYdL2VRUAWYkPWA==
X-Received: by 2002:a05:6214:4787:b0:704:7cf0:5916 with SMTP id 6a1803df08f44-704e1c96802mr98849596d6.4.1752677329050;
        Wed, 16 Jul 2025 07:48:49 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d39749sm70825116d6.58.2025.07.16.07.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:48:48 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4AD0FF40068;
	Wed, 16 Jul 2025 10:48:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 16 Jul 2025 10:48:48 -0400
X-ME-Sender: <xms:0Lt3aNOpLgs2VlaATUoyNizkJ_X4jjIAeuPzHNaskyetXrnN1pSMSw>
    <xme:0Lt3aKDr39AjZsnzsDTFM0BAu67Bwj9WBxfmljb67X76X4CuIFVF2fwfJjGSCFNsm
    VNqxrSB4x6LURQTIg>
X-ME-Received: <xmr:0Lt3aBNfMyKSbuoQpBP9RERGn2WDQuSgeanayK4Jcl4YgBEcuKo4Ec0WyA>
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
    udefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihhnghhosehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgt
    phhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgrnh
    esrhgvughhrghtrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhgvihhtrghoseguvggsihgrnhdrohhrgh
X-ME-Proxy: <xmx:0Lt3aBdwvFAaVTNZi6zO9t8JthDaSPErvALS1L732qOBx5oRxeAXTw>
    <xmx:0Lt3aC5X6pH7BGrOwJEsrcoowjVX1IYHGL_eRhXmq5U4V2BbgB0V5A>
    <xmx:0Lt3aDLA-bRchLTQM1FMQeti7lfpQNHQT3vlra25_7yYCfCQeu8rLA>
    <xmx:0Lt3aMUInCtrGdQQw0u4GiEfMywefUMnmk1lt059sfe-BH85rdfGMw>
    <xmx:0Lt3aPFBV8yHHrsTwbFrh7g0JUqmUbVE1m3gpBFeCsoMQWjFBw7d07Pa>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 10:48:47 -0400 (EDT)
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
	Erik Lundgren <elundgren@meta.com>,
	Eric Dumazet <edumazet@google.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 9/9] lockdep: Speed up lockdep_unregister_key() with expedited RCU synchronization
Date: Wed, 16 Jul 2025 07:48:18 -0700
Message-Id: <20250716144818.47650-10-boqun.feng@gmail.com>
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

From: Breno Leitao <leitao@debian.org>

lockdep_unregister_key() is called from critical code paths, including
sections where rtnl_lock() is held. For example, when replacing a qdisc
in a network device, network egress traffic is disabled while
__qdisc_destroy() is called for every network queue.

If lockdep is enabled, __qdisc_destroy() calls lockdep_unregister_key(),
which gets blocked waiting for synchronize_rcu() to complete.

For example, a simple tc command to replace a qdisc could take 13
seconds:

  # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
    real    0m13.195s
    user    0m0.001s
    sys     0m2.746s

During this time, network egress is completely frozen while waiting for
RCU synchronization.

Use synchronize_rcu_expedited() instead to minimize the impact on
critical operations like network connectivity changes.

This improves 10x the function call to tc, when replacing the qdisc for
a network card.

   # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
     real     0m1.789s
     user     0m0.000s
     sys      0m1.613s

[boqun: Fixed the comment and add more information for the temporary
workaround, and add TODO information for hazptr]

Reported-by: Erik Lundgren <elundgren@meta.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250321-lockdep-v1-1-78b732d195fb@debian.org
---
 kernel/locking/lockdep.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 0c941418a215..2d4c5bab5af8 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6616,8 +6616,16 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	if (need_callback)
 		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
 
-	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
-	synchronize_rcu();
+	/*
+	 * Wait until is_dynamic_key() has finished accessing k->hash_entry.
+	 *
+	 * Some operations like __qdisc_destroy() will call this in a debug
+	 * kernel, and the network traffic is disabled while waiting, hence
+	 * the delay of the wait matters in debugging cases. Currently use a
+	 * synchronize_rcu_expedited() to speed up the wait at the cost of
+	 * system IPIs. TODO: Replace RCU with hazptr for this.
+	 */
+	synchronize_rcu_expedited();
 }
 EXPORT_SYMBOL_GPL(lockdep_unregister_key);
 
-- 
2.39.5 (Apple Git-154)


