Return-Path: <linux-kernel+bounces-878510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB602C20D89
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 265204EC17C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1AC3271FA;
	Thu, 30 Oct 2025 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhylVDr2"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF143271FB
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837077; cv=none; b=IgaMHVcnGZ9LXKrLachcAYczfMxpvAj9M3rmfKpN4WCDF4wHcg7b0+H3J0RsIIIX6vs3u7z89Z6z8tI3/0VgZmRYPm02CoJ1USQCwr15JyF6AUAyWwL9Is3dHgDUNWCNZ82l1HXTHc+LbtnKy2qYNHNev4+wGs1w9Y7WaGG54TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837077; c=relaxed/simple;
	bh=lT8pY7VpXHxZOVd1czQCJxzZlYwnEuyse06oIeRV+Fc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C7yh2qafT+Cl7jX8dgx4nW9l+Da+30ZbdtHbLGEPmwazDA8KjJOaweL5V6SxaYDWmaAQjxbdc/vXk4BGz2Xhul4TxxtSXTwY5nD7nAYXGsl7Wg37EGLCx51QumeHZfM0+YDY1LUkFU/awP92J8CnwHwUbhc+GizHuTMenI7wl9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhylVDr2; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b6cfffbb1e3so914617a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761837075; x=1762441875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vhBRftSrNtDpB9m0SoTTwtcWSN6u49zEAs37m1LLadc=;
        b=OhylVDr2lwNJr0kjTzhhsQQEjjKt8xckJ2rVQqtmNgUQfP++jde+j2tAtJ27N9Sbkw
         WzMJWNw5L3nQNHFYN0Ml6ZRjXH42GZ5ygJfB5DRTIORpzNPyguZvP/9/Kf7Ja3BVDfcY
         i5Zownknklp59ls2NpEVrMc1bFetyVGmau90AKKtGAm2wCHgrnJs5Ss0JEfT5S/UFltq
         W5IjRh5gJjs7KuEKJvKgZyPSmIVPRw9BlrJxBI6qv0XLF9dpcxO44x5KPxJqTEeoibGa
         8F3c0IsZ2fX9J5rETkdVXtCX0ps6eLiIasGwKi1gbSK+yQzJmgITGMtHlNydKGd18Z0d
         guWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761837075; x=1762441875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhBRftSrNtDpB9m0SoTTwtcWSN6u49zEAs37m1LLadc=;
        b=srr1AqJooyIPjEjmp+SnWUCYVq/5ziNCxzvqx69FSk6IAz+lMFKVd5r3bhfemKkPVE
         ZlTNcRS73IgG84J758+KQem+4Xef7v04ETHt4tXqJNjcHv1MZ5e2Pq/yCmn/GAI0RSuP
         W2x6WfrgigoqwuhqW87Ogfw2kRzivIWi9g2yV35UZF/uqy+RhMH1DfQNsUmQFsKhmqgL
         C9nNhcdkYxD4vP9hk2wwkSrhngpaJ8e+bp8KpWmRJ3Rz2r5heeqH3+3fTpnghqOj14BG
         Ju9V7GhN6id1WKwh1KndaW5HiS+/D07mFEftU6IPJGkx33YxNEQSWWVhs0EwerKvWNlj
         mwTg==
X-Forwarded-Encrypted: i=1; AJvYcCXcaau2tFBUgHykEztTGQwy+H7ZH/0CQwbtC1H7m3NbwU6As6rLFQUNrt+Xc/Z4P+oB01S8uQJY98htFqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKkkRV4oYj2QBybEIjvR+4kySBPghjXJb7fu9Y9QOFhFtqa/UV
	yLYZMZ8r2M3Tz6TiQXJzv+ojCqRI1eNlpebouU7Vcegfgrj2dGmX9z5U
X-Gm-Gg: ASbGncuZnnDVGMqKpOCQH+R6dnEkkbId4spb3kDBD4dh7qHX1KbPoNv6e/dpJmVYcAk
	NcI56ktCho4JujtJ0YwFQq6o/Gj5fD09ZqAsUXTXIbJ/H2iLxz1I41XIh1eK4FYMsRgyjOnugFu
	g0thUflglRuerfd147qQn1sUA7m6I2avSAk7vWox+TOAbLOJgbv3xBplZjTn342IeDNGrH2AmPH
	coBx6QrRri6S73Rsblsgk3Aak4ajrs2gDbAkRFLqKDdzUXduU0mxIczSQHj57UDQ2UykWlxSCod
	3IFZSllrXS0QfChRxb/tjFtIFeZHe+kH4OMVmM81F5vQtoTsG5+ch2MbRSXsMvyRPwLTI7+vGR0
	0Vgobi0j5kBsBd/g67CFbO8f0iEXR4WWnlEt8gCrQNRLTDckjKP3nWoXUOKS5HuiCwWHG7deEHs
	3XgQnzXrYrrlmr6ZLw4TQYzJ884nas3Xjw
X-Google-Smtp-Source: AGHT+IEmDJsPUeNmdNto41ham/oBAJP1/xDXePFvCThGXIL5Hte3EwYty2Wqj2o+ytJ+3UW61AGbwA==
X-Received: by 2002:a17:903:234d:b0:290:c388:e6dd with SMTP id d9443c01a7336-2951a34ca43mr1215835ad.7.1761837062978;
        Thu, 30 Oct 2025 08:11:02 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-294eeb94d63sm32840245ad.5.2025.10.30.08.11.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Oct 2025 08:11:02 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Scott Wood <scottwood@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] powerpc/fsl_uli1575: fix device_node reference leak in uli_init()
Date: Thu, 30 Oct 2025 23:10:40 +0800
Message-Id: <20251030151043.63402-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The of_get_parent() function increments the reference count of the
returned parent node, and of_node_put() is required to
release the reference when it is no longer needed.

The uli_init() function has a device_node reference leak.
The issue occurs in two scenarios:
1. When the function finds a matching device, it breaks out of the loop,
   the reference held by 'node' is not released.
2. When the loop terminates normally (of_get_parent returns NULL),
   the final parent node reference is not released.

Fix this by adding of_node_put(node).

Fixes: 91a6f347921e ("powerpc/mpc85xx_ds: convert to unified PCI init")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/powerpc/platforms/fsl_uli1575.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/fsl_uli1575.c b/arch/powerpc/platforms/fsl_uli1575.c
index b8d37a9932f1..36624c88d5f3 100644
--- a/arch/powerpc/platforms/fsl_uli1575.c
+++ b/arch/powerpc/platforms/fsl_uli1575.c
@@ -376,4 +376,5 @@ void __init uli_init(void)
 			break;
 		}
 	}
+	of_node_put(node);
 }
-- 
2.39.5 (Apple Git-154)


