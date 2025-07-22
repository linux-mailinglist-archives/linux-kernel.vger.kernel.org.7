Return-Path: <linux-kernel+bounces-741550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7E6B0E5A3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1342F1C88412
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A0128640A;
	Tue, 22 Jul 2025 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcgSzxSN"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF8C27A917;
	Tue, 22 Jul 2025 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753220405; cv=none; b=EsSEKtezKogpGZQ9wd9o9NHqGu8ytQDrzDUZYuHfi3mx/IyV897b4+6J80nBBQ1gc53vGjaSK6wawai2dr/Ca9GntmMgMXsS1zqwM7d97FldSA/S/VunLM5JhdAXrY9JNMsHm8XxB4LQv2py/Ccr9xgVqebKpjrv8IubuQYdrZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753220405; c=relaxed/simple;
	bh=AGV2ljNHwiVSiF0+v+JILnRZWzWMhK1YpCFFFm1vT2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I1+y/zrqmr1wL7n8yHrONeUahsbYr3KRyoN+iSeKf3FOkSUmmEUOenjOil23ExfxIHm1/4u4wNhu3jBYiN5uoGycz2LLpzsU4Nj02nvemY7P3YkUleazWBxqTyR+0tWwvYH+P57pIOmmYzyOxqVlesCqx2N2ctSRk1sjphSJq7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcgSzxSN; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e32c9577ddso570157885a.0;
        Tue, 22 Jul 2025 14:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753220403; x=1753825203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AGV2ljNHwiVSiF0+v+JILnRZWzWMhK1YpCFFFm1vT2s=;
        b=dcgSzxSND/OhT3z6cbvCRPQj07RvE/IqFmWfyAl7fnlPthzJ/cQ9IMDirS1Bo4GK6P
         AG3Hb94LZwGhUDJT7xzQ4KRGWw8MhbfZ7/wtc8navZtQz4vviC3M3sKAoFo4GNjkQVsn
         pLvBXULk8sWt1xGaDhGywdtDYjEz5xYXle563VjYXiNeJhitE9UZ4Z+BfERO/Zj+NPKB
         p9aO+9T6VKLlTX86BnnPjYNP4jnpeZRS0aEpCixE48m7wcLeyVSy8e0YyVjPUMyPXA3k
         6HD411hLCG98A1A/nVQ/1KnApIzRASvDo5f6F8lLCM//siPPMXZmdI5eVAbWvdVhtp05
         nklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753220403; x=1753825203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGV2ljNHwiVSiF0+v+JILnRZWzWMhK1YpCFFFm1vT2s=;
        b=KWQSqrHofT18GuOu67b8G37ylrmHie6TeHK2zwM7eTcEuFEZeIPLvKGsqRQxztv+/8
         hKPEybM6HZU1+saKQ0ojB70mlZP+B/HkSO3FfWFcaQk6xSFVp2Q33N14Z8YFl1xRsDzS
         KNfl3qpj1/rMneUxiRgA0HIXw9QYoCyVKerzUK+G/Eaa1L2DYqLZCg9Oas21qr43HTLj
         322pVVO1j1zML1aWbo6Hh2pGqup2O5k2hBz7NZXyJUYIa753eL7odj2gt2W9kfaYIXji
         zGUaN4ADnX/rtI/RdAESMGL+JL+3S4GHugZpCxSDi9ZyqZ6+VpjX+imBuBydr6OBvf1T
         27cA==
X-Forwarded-Encrypted: i=1; AJvYcCVY0lhEPC3rPLKOMfwT9kyTnJz3gYyJhoCkJMS9sKJ2qXkQ6EzRF0atZgSS6Pae0t742guKdoWTC6A=@vger.kernel.org, AJvYcCXYg9DSMS+d9qLzSCO+zxR/I+/vHZ1FGASHIGNPDfaEvJ8Env9M3HNC/hkZGGplYnr+Omjp2snGysiVk2YN@vger.kernel.org
X-Gm-Message-State: AOJu0YxzW4kxQUyksG1xUfze5I4aJ/za43IInNmLtdJcgkFo4BslJkWB
	kRC+99bbo8ofu25aKjEkMHdRivpKvDJ79tLqcALOSUYdWJp7o0qIOEqa
X-Gm-Gg: ASbGnctJrZOFy0DRBsuKtRZTCd+63qhMie2BmM16qNn4Lqc04IBqEcCjRy+/i8Jbj9j
	0ZN+ZdvBq4P3kM37BDvCGi5FJvqK//+6nQWvmtZGsP3zhy3tRTOGviznLSSRJ81IzgoM0UbCFG5
	nyG88YuEG8pQJdiEiPV/N936wLdRQAhlfIKNcPPYHrHbrrmcF4c/CHFiTnwQ+VlwUKTnC+QMw4L
	Y84AXHI+vnCg/gf/tcShXTbp/8s/e3OvK36N+OX6KZUv8Yt1L+Lxzt8iXbAPrnvL9yS7pGz1K0b
	lSvBq6AEbA+upwJPcdWPgpywv20T2s7ZGob6IJrrc8nUexMCtYd5E43zFlP2yBcXiYhpBgZukaL
	8PJ5+otp9ST/Vnk7/1nZ3tlbrLwY2R14=
X-Google-Smtp-Source: AGHT+IFEnNMg/ty0B/bwN73PGnG2lWFM8+F1DTmZbEEiHTsjkLQerddgZegb6HZ/1eKjuyheFjolAQ==
X-Received: by 2002:a05:6214:5086:b0:705:14d1:f407 with SMTP id 6a1803df08f44-7070062e5camr11133626d6.26.1753220402947;
        Tue, 22 Jul 2025 14:40:02 -0700 (PDT)
Received: from Gentoo.localdomain ([37.19.198.68])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051ba6b755sm56145466d6.58.2025.07.22.14.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 14:40:02 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: justin@coraid.com,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] Doc:admin-guide:aoe This file was missing shebang line, so added
Date: Wed, 23 Jul 2025 02:58:20 +0530
Message-ID: <20250722213704.30353-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This file was missing the shebang line, added it.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Incorporated suggestions from Jon/Ted in other series
 cc:corbet@lwn.net
 cc:rdunlap@infradead.org
 cc:tytso@mit.edu
 Documentation/admin-guide/aoe/udev-install.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/aoe/udev-install.sh b/Documentation/admin-guide/aoe/udev-install.sh
index 15e86f58c036..cbf64152bc6e 100644
--- a/Documentation/admin-guide/aoe/udev-install.sh
+++ b/Documentation/admin-guide/aoe/udev-install.sh
@@ -1,6 +1,7 @@
-# install the aoe-specific udev rules from udev.txt into
+#!/bin/sh
+# install the aoe-specific udev rules from udev.txt into
 # the system's udev configuration
-#
+#

 me="`basename $0`"

--
2.49.1


