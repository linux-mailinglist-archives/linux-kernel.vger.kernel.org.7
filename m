Return-Path: <linux-kernel+bounces-785015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BD9B344C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 556C07A8CD0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299832FC886;
	Mon, 25 Aug 2025 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VqTUePK+"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600582FD1A1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133861; cv=none; b=s8hcagc7A/u2BzDO5bcA6+aWfjZS2WDFjvXusCGB8kIaH/g/CmxO6AF4NjXAN7HdBWdZlYuKhrXlaEusG3ruHl0YNZ+f4kCOEtU0KEhENaAJQxLcK2E1eIfG7oVnUUAtcjG1Fb+kqtid+FthxRFuESalNjjEKayxenjF0NqUZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133861; c=relaxed/simple;
	bh=I1KnJytDI98uzyU9VR0CMYknvs4wi7QfemM11ZziiWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g9sRQvQyRD+w45UDTpEe4360nzLdLlEjarCoJD5CaB5hLmKtLP6BdIypyN+NUHIJjXBFky1gF9mDSorB4HAXMwDzg5icjc6jDlq6MMOfXSReOFLl7acXwhkxnHO1EUxpMPksmYtcikFp49n/SDXKAo4wRrMUG5wy6SIVOoh7k8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VqTUePK+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77057c4d88bso1024101b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133857; x=1756738657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXrNbcwSvagaIiS5O7F6FLpYe+f/n3DenUIqxElurVQ=;
        b=VqTUePK+Ti8hEY7IFvvvAeFjp+G+fICLnxFbV2iCeOrggd8SC5+K0qAxjW0Ye7rI/9
         DVR7YZA1539ptNqSnUJUhsQMErEzMW0AzaqQ/63pcFp0o5qPBIZniamX+8ChMNvQ5TZe
         2PcsjaPloqk2RrNd5cuLShdre+AIzlVViRq6RNl9s/acucVXT4BTmag6DNJoK2i6AXRD
         3Q2fJb06R7+wYxcsU+5SXLceGPUv56pdd+xgsE1zjwhbmLTp1fAht9KnJprqYGxyRQ0v
         ZIVJBDDPIv/Q9hdtlQ+a167K/EjI/fA2GHl9E8iWqK4PMR7MaW0rS3AjRzlYgxSEjdN5
         Ae4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133857; x=1756738657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXrNbcwSvagaIiS5O7F6FLpYe+f/n3DenUIqxElurVQ=;
        b=i5xrAtydzJJ+NDTjZH36kEMiPR9wtpnZ8unnA9IIyn8i0LBxpMZxg5oEO5SKN/SPmO
         kiCUm5VhaKybR59e0HHj3u6EI0jeOp3sSkdWfBAi44jeyfuAwqtiE8/50GEzWA9oWUZN
         VXvEDMcRh2/WjI7wfgXAmD1t13uyVObnczGjoRbttFAM3rI87hZSQu00KSRbJ2mOI5WZ
         9liUY67L7fXvZ94Zb2w2zrkgcxJSHRdFIviRUirPEDDqJKFohQexUjvc4xOrY7UlCJUB
         1sKlCdlXUzKfC6X8G0H77qog9t/eB9UpTybqjtIlBI0Ka/gKUHbKv4Hfg3Q9b3Q90Vg5
         V1eg==
X-Gm-Message-State: AOJu0YxLv1hw7bqsLX1Yaxea/OcrJohXItQmVLo2Jf+27aoQWhYj4aRw
	w0GfBSMpKtKxkqQYJGYbAn8/EQwvEvgh0TusOgwA6Wan8qkhf/wdE0Y+fEnUCwL/igU=
X-Gm-Gg: ASbGncsfT8T4wyNdIFJWJYvTHwmOD4N4iWYxUHEBdDw/pSc3dxKnmabM1SCq58rrzyA
	yA1qOUloMU081MiK7ZFHXrpNqbLJUmAM2ygbcavE9iDfhi5OZ0YniT/wsmf3nQ8bKCIn5TVopN9
	q7lv/r6Kgddtu+H96QQr8iXT6QykkAd4+ektUwlX/59/lZBGoQDpn8TFR8277Nbu7pfI3dPPx0G
	63AMDRYWwJ+l7ihYbv+2/2zbb/b4Al7KvgKxnTLWVRBQeah9vvXMhR4pm4Wbe15vgptokXNGt7R
	CqUDBUjpOZnLGMB0zTG0D74HQ9Ep3Ke+/FKdJ5kTuO/yF8aJKdSpWmHi2D98eGUOuq3IUU4fn6P
	QCPE8fwCHKNDSuMsmulgZ/zu0Hzuvjqy/eB1BnCRnFyL5xQXvSwRyJKoNHb85
X-Google-Smtp-Source: AGHT+IHPWyaefTjVEriFn6wD+uKtAOPue43MQG2E+07bD3h6ezfyNYQoVQXZCOE8Earcz4MwE2e68A==
X-Received: by 2002:a05:6a00:2991:b0:770:3c63:5906 with SMTP id d2e1a72fcca58-7703c635b38mr12867003b3a.14.1756133857394;
        Mon, 25 Aug 2025 07:57:37 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.57.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:57:37 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org,
	linyongting@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [PATCH 2/8] mshare: selftests: Adding config fragment
Date: Mon, 25 Aug 2025 22:57:05 +0800
Message-Id: <20250825145719.29455-3-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250825145719.29455-1-linyongting@bytedance.com>
References: <20250825145719.29455-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mshare test cases need pre-required kernel configs for the test
to get pass.

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/config | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/mshare/config

diff --git a/tools/testing/selftests/mshare/config b/tools/testing/selftests/mshare/config
new file mode 100644
index 000000000000..16fd9a3ca12a
--- /dev/null
+++ b/tools/testing/selftests/mshare/config
@@ -0,0 +1 @@
+CONFIG_MSHARE=y
-- 
2.20.1


