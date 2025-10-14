Return-Path: <linux-kernel+bounces-853337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 285F5BDB52E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B863AAA54
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D67306D3D;
	Tue, 14 Oct 2025 20:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gID5//DQ"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267B6296BC4
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760475171; cv=none; b=Uh+iB6Uq+F49odYy6YAgesHR+H++B6/wlExO2Ym96wGOQP7uy8atU+ARb6zxKl4+3OgnGdq6p/UhnU71jCnO3UM09QXndUMf++g0nbh2qw4D+zHAkBT9Qcs0+z7xaZuYHpk0OHrUlx7BMVLmDVtuE6mYznjMU2fOELaDWHBf+mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760475171; c=relaxed/simple;
	bh=V7v+pOaS/Y/gC5OrH8EAkdZLjfAruClStwZDceVuw88=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hWPN8bzZox91vydiFnRdy9fw9Gy+Tc3StE23HcprNZzf+VhuW4jZsPAqZPpFZ6oUerETstVYvYCOLrM0wEut3N92ZwG5b5htTERAkDqw9uJjq4zetf5QYGFK3SKuQ34MfrdfAs6GGedEaIpXGn2rSJCFzi+ZEX8V1qtkEsryv+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gID5//DQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77f5d497692so7087970b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760475169; x=1761079969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vyC4LLQcwbbHxZ7oSfAdTEYfnna/tBhmcvxxjsywYQg=;
        b=gID5//DQ6r3+rJac3MhLNP9ZJPD1sF6KLKyNyof9IfKq9gXxvpbldgv9+GkK5RQNHj
         CMc+SzEesgacBQdcbTs6WFyqktquffGYVMeXXSXVrdKLIU9xzVz8ad+8Er0DCXyVR40Q
         ExYGHJWKuEYwYcsiFlxnS5FKhehvkBbaPB2r60lzQFYmRUz9CxtsHkd4X5Hm0RN3xOeT
         mJi+O7cYgM1kGLs2NxmYWGGeB+DYuxSrppipfhaJ18Vxcl7ibQWEAnMljp/YpiXUinQG
         F/e4yYHzdcXd0SKZnRBebP5lJuibg+OQ+QnF4iKsWlPb/lyu+LaRmeEWbe+qpgANJOfF
         +owg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760475169; x=1761079969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vyC4LLQcwbbHxZ7oSfAdTEYfnna/tBhmcvxxjsywYQg=;
        b=VrAApDXP7hPAi30pQatpsnA6GuHym4/DO5qxKpdpaQp61Biv1KdKdTgHzfGAR+R/ks
         mpIKGq+awBLtf1r19Pc31Fpfd0gBq1aS84FqYi/1mv45xIYgM1Kqk/NclGTob8MiD0JY
         CCxl2J4hh/a/OGtN/Aoo60uf/0N6HZs9u6wQhf2KkT2X4Zbx0jl3k3/ykomz0uGHsdqV
         ilny+qLgLhDNSTc8NIiuzb9Aa2D1bpeBoHfA9q3qemb5TXyfI31YbEtNFKgsh5bua71f
         +Y4vyUqUx2dPLG5VqYAx7WC8L9LzDSKptg/dIizwoQeAz+QYT2miAtqeLqY91nMSHznu
         kuow==
X-Forwarded-Encrypted: i=1; AJvYcCVejhsByYGhs9mVaq7Tnhai00IhfLqBDZEUqNR/YJ3bmlnfC3fn4MXqIYR6484c6l/aS1r6eqk5xiTdWVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweo2L3EVtsNjDh2xHRLYz8nheiAkOAhC47bmvqSKR5DLXircp+
	U3a9NrukaWyRd6DO64d/wN/FuIPQpWgjd9JOt1rkd4e2xwQ39m5pGw5g
X-Gm-Gg: ASbGncu94Gj1hOlszb9EVkzYbGBe+TrBebcAaTbN5A2T5vjPf+5bA7YUJj+bI3i1NJT
	SuByxMqG7f3ADCFeqYDRIVMUu0swutYkUmipCqbo/VmhN0baNaEvAjPbJzC86ImjQ8hVpZaykY4
	FyxfkMwK0U7g4+CLweX+mQjWVyRfUTsI8JqAbfTSm9nzsc+OMiQWUKVo7XRQJ1hoMUTlWuBlF2j
	KuAx4K1NH0ii1FiJo4+EgK/EccUDSJpS0JV5qWqu7VGJDNYoLi+sz0FbW0LUJYlhjElIdBM1qP8
	uogqZA3V+kO96SetxBv0V/0cXyrqdBLxTk7BWF7MJJEOD44rIbPoHxcguo7ujeKLlX+V+xl5yNk
	eppClwJZFVS+ZwwmDTBYhr5Gl5kV36z5twLT1gZCF3VGcRqHhJTx2cZqbgG0k/VzDM9cBXQ==
X-Google-Smtp-Source: AGHT+IFCRRm40DDjhn2TEr20aRuaPJEvmy9taUntP1uHoQXO517vsour9GZ0smRONPkfXTDYh92yCQ==
X-Received: by 2002:a05:6a00:a0a:b0:781:1920:d12d with SMTP id d2e1a72fcca58-793858fb6dfmr32179732b3a.12.1760475169402;
        Tue, 14 Oct 2025 13:52:49 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bb18e28sm16176088b3a.29.2025.10.14.13.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 13:52:48 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: shuah@kernel.org,
	skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] selftests/dma: add dma_map_benchmark to .gitignore
Date: Tue, 14 Oct 2025 20:50:41 +0000
Message-Id: <20251014205042.1637315-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the dma_map_benchmark binary to .gitignore to prevent it from being
shown as an untracked file after building the selftests.

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 tools/testing/selftests/dma/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/dma/.gitignore

diff --git a/tools/testing/selftests/dma/.gitignore b/tools/testing/selftests/dma/.gitignore
new file mode 100644
index 000000000000..b4b99b6ffea3
--- /dev/null
+++ b/tools/testing/selftests/dma/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+dma_map_benchmark
-- 
2.34.1


