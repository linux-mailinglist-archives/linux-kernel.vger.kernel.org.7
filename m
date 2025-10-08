Return-Path: <linux-kernel+bounces-845621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C5ABC58A9
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A2644F937A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677AA2F361C;
	Wed,  8 Oct 2025 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g+Z0Y4l7"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1DD29B237
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936574; cv=none; b=gK6e5mqG6dQg6YUNinYRmrMDRuPdC6iqrUeoKVWB46Q879ztz//lETtMfu2IqGWAGLEyknKlChnY9dLxGAKEpmDjR7IdBImuQSs0lJj1q0nzV2G8DaINDNNhK0bxSS7m1A+34Skvom54QfErYo+BmnPMr4rXY/2NKS8TqgeWeOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936574; c=relaxed/simple;
	bh=NlnLqAEEYjD2IqgaKAO3MM+UKt9glTRY5F/bnfqHehQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A4azPW499P71AdbcCgIVtmh82Se03VaSTWV2r2ClODHsR6kr6hlQCTeSqD57m5bxeRQNopVSkEVUIUiOFyVtj+kBtkg/hjxkiwaNJ4fPfLxrxkPt1Wowwmn2wPXpTKkGfqDpevj/RPyBhEWiqqj1tvrMNT6ioioYLYu9xx96SM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g+Z0Y4l7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e491a5b96so43082645e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759936570; x=1760541370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XqyXBvURAsE3+8/zFllMyhdxli5Va7fIbB+nLoRS42M=;
        b=g+Z0Y4l7FERzQIrH09IOyO0I/malCdC+K7MCUEzIKr5twuo9aP7FTUb2NfoZdJTTzd
         xLp6QoFcOe89zN1p7XqGFIUBpI3Rg9EBFKiLg2v+TzZwVc6HdS+cKzbNQhT1QOS80MY3
         D8G1pUB07z85x3CGbUX9BNsKQn70cJDLiSG8OCJs8V53ohZJw5DKbi8DuxHmPxbSY7py
         ufZ7+/+BOTUpS/IgGlAypTbBmjhXhThe80vyYQGlft+CBbrF0f8zR7//Ajsbw3CgUJVO
         AsVyzVczvgzyd2Rr2Y4EPPJSECut9j9jF9tl/kAAR41E1FyylZv4q1tkOh9dU5x/gwWs
         xF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759936570; x=1760541370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XqyXBvURAsE3+8/zFllMyhdxli5Va7fIbB+nLoRS42M=;
        b=TOkV/QsOE+EsCK044M39Lw3tIB3qtZQnzU4epTE5XjOAOgiti6XB0cwLZTj4KoWwDy
         Fexq0tls03ZPEcLQ6w5PgAMADgLFF53B18FL5IV2yJTDfW46qMVsS+oRx++CphUreEa6
         qBU2C0Es3r9/4QwL4iE36n3Ib/dth784b2XE/r3P3FNAiMObaunBXwiJPf7d12sPgwli
         fQBIdmFkYkp+D/QuCeDu3S+YEFLMkN2uflSk4dcdq8T+FM/tEAXgj+RiAES4q71On4J7
         gT1f7HRhhCkFj09ZDf/Y9BFvQQqp54gdNFmHzlRmDWO1OKP4UPKuXH06ThzYZbHst8JI
         ldfQ==
X-Gm-Message-State: AOJu0YzhCKLcaGNLjRV/X9sjSKQtgjFEQa3TZXc5WcBllwXmtZuGpeCx
	8waOX82NwyObRky6cGJ8FQ0uNO2hwV5J39BUMDTJd26QRkxR1AYB2DztfOPBDbZ2Yn281pkKnAC
	/8NVe
X-Gm-Gg: ASbGnctnmU1LQEp4IP9gjKl8GvI1gtUlXgizNiM8VmSMarqghkQbKUB2bGnVQdD5uZL
	dYEwBKewJxyi/PV1z27y65vl95+fJagbcECfdbfClty/sWdmE+1p6yZLCLeK0u5pJM11ZR067Fy
	nwyDTNmRKSLWC73tGEXNhOBnenMPh1K2GfKYUwOrbM2YmtYXQRleK3YKKjp9SEJA5CZlv6QOUQq
	jt76pV2QkaF/qidIUYDKc2sJEddD30wlHNAf1s15r5Eh0sMOZKkNRvZF7d5KO80vW51XmuLu0E4
	vN7lv76cxQx8tDkiv/4sCi1NAxBj8psDQpU2kgLLFBnVEyL+WFIPbvBeQDURXr0JaCkE89qMGcl
	S2v42DSRFDlN0xB+RkFSq9f4/ZRHIqJrrEDMMChA+0yW1q8liHkLT0JuN9PEIdz0=
X-Google-Smtp-Source: AGHT+IGxUZ69RSaAr72i0Jlq1CRq84UjMRAHUoPSowy6BpE7V0vBY1W4lUxIlK3QHaHD8JCFgPtc+A==
X-Received: by 2002:a05:600c:609b:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-46fa9b106cbmr31182115e9.31.1759936569983;
        Wed, 08 Oct 2025 08:16:09 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9bf8288sm42480555e9.2.2025.10.08.08.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 08:16:09 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH v3 0/2] rust: add new workqueue functions
Date: Wed,  8 Oct 2025 17:15:52 +0200
Message-ID: <20251008151554.340806-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Recently the workqueue code has been changed introducing two new workqueue,
system_percpu_wq and system_dfl_wq, as a future replacement for system_wq and
system_unbound_wq respectively.

The change has been introduced by:
    'commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")'

The old workqueue(s) will be removed in a next release cycle.

=== Introduced Changes by this series ===

1) [P 1-2] Add wrapper for the new workqueues
  -   This change introduce two new Rust functions in order to add a wrapper for
      the new wq(s) defined in the C code.


Thanks!

---
Changes in v3:
- added a proper comment documenting the new added functions.

Changes in v2:
- added system_percpu() and system_dfl() in order to use the new
  wq defined in the C code.

- fixed misleading paragraph in the commit log (no warnings are currently
  present).

Marco Crivellari (2):
  rust: replace use of system_unbound_wq with system_dfl_wq
  rust: replace use of system_wq with system_percpu_wq

 rust/kernel/workqueue.rs | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

-- 
2.51.0


