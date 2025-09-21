Return-Path: <linux-kernel+bounces-826295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B177B8E1FA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57992189BE14
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 17:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3663426E6E2;
	Sun, 21 Sep 2025 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxo8s54O"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4870B26E161
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758475769; cv=none; b=qs/FpolV4vsLcwFFfmwHDh9xHJrjJqZZqGerwaJmvMe3e0kz46t6LuUJsyC31w0XWnTJNkKqc1q1a0iF/7RHp3Ee0xOr1Fxos24o99llp+9D13O3/Ma3rIct9tFZkOOA6Sh3NaPBLF17YGz/H1UgA6a4nbb01OF/a/vgfqnePAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758475769; c=relaxed/simple;
	bh=EKTu85teQ1TxZrXrUJn05KIs5vLfN9ijQcWezZYc/pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GYcgAocPfgrvKoKzXi1IOc8GONzohGXn++9XlMc+ffbKryD9EawaoR/j5DUFbXXIfW43W6LQSmCK8mQ3B47lIMrY09TiZUKpXyUAc+iB6aFA6bkry1t3BLKiJ/VymA1OWe7d6OBW+222/8L3aHRFjrYpUUWRetojY8S2o99aTow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxo8s54O; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77e6495c999so2212810b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 10:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758475767; x=1759080567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K0uzWoATR0pUTQbyWW9yEXcY/reaD1e4f5P0l2JW6cU=;
        b=jxo8s54OwjFxG50Jf+0X1eVaivE4HM+9kFb3vZEC7YP0hwq8jKkoT4FriDYScCdK5s
         sHWyAiEVA8bWEotbec5/xek2kiOHObQ6LWEbKMfkoBa0QrhcwVGH57J65V6z2lud6Seq
         /oxKky6pPuiV33m/b9I23GsMuaQB/qG+k3SoozITBG2GRunnv90CMOptew2PoN7Xj/VS
         K+/y7dFrgi9Mlmy28ugrI3Irr+bX8+5nryIFk5Mg7Z3I/6hU0PQDdF3bhY/mngmxK5H+
         uhD8tDcjtPvkRuSxtjftF78NzI3NCi1dunUPqU0urxiibKdHiISGEaT9OqQsDSSYBRNx
         IlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758475767; x=1759080567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0uzWoATR0pUTQbyWW9yEXcY/reaD1e4f5P0l2JW6cU=;
        b=WnhEfTMEYvvVbjHfTnmZXQmsXmz8vm1HAKpzSI3s7rjnG71ccIkuNemJJnstiVf2t3
         m4hup3c8q6nbWxsP7mMe4Vb09UmawAPfDuhKIejkxkjLEmp2XgZiB1gKP54Nugd0/ywc
         CZyy9IYgw1Q1tgawTTZ0PKgowUr77VnMJ7uq5RtT4VqgInsSkPJH+vzL+N5VB16D1Mc4
         K4qIm1rgoeHiUGI69wV5XrvU+Ccd1S0caVJdkxRfVn8ccUvgTH/Z22c5YPRUWPoQ2wI1
         zdDjU1JvsNAHxGREZbRmhBcbx8fdce9HBpFh9ubm7mUUpXJ60rXK34aHx8NmWacZPtjC
         8zmA==
X-Forwarded-Encrypted: i=1; AJvYcCU7LZUteBOzS5VTzZPngcK8U88IddrAmB94hhiJjBOzhaKqrq+H/3m7SyO3nOzQ/+4QKmCkS0EPHf6iTeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGR2fOvQUpAObhQvl6XO9femfKUjbyehxXjESwQ8ifL0qTbblP
	RC2S56RlC3vGo500n23XZ/5TydJ3b5DepoI9r348RmApoSeNNCDEjx7y
X-Gm-Gg: ASbGncu1PcEtsPZ8x7TWAhefZQB2qWi8i5fc4ShSXNkxpACTnjju/bnoy8Jy/XuHDnB
	q+q7PpFEXQoZm13lMDcL2iFjPOfGkPQv46vVoETkuahKpBY96WjHfbGleB81k+3S+FhyXP3/3df
	IYzIe1eHt2X5T/PSRt44h6ImLAPA1z+WySWJf6qfR21fqK4Ox1vpsG4H6huhOCS90ahHUUsqk8y
	n3mUE5bEqfhi4ghAYYODOCU3k6vId/YJJ0HKVJ6Z8YBX+T44Qr1T/8zdNF6J13mCDNf4qo+rD2V
	bqjGYT1s6k3ekTLDwARXmXj4ywWpWdWk+1mzAGGJv2+XHlJBd71oGrw1O/iR7Wh1Rmoaq+TsuRv
	y1qVoX+rmEJPuLjKIuFeT1oin
X-Google-Smtp-Source: AGHT+IGuNztlcymR1AZgLQugJMoVKgSqy3Yf45mv6QmCw2RApZSDv88MTQ6VcIfL8NhXwZBVgnXGxA==
X-Received: by 2002:a05:6a20:549d:b0:250:b053:53c5 with SMTP id adf61e73a8af0-2927405e4c0mr14591768637.51.1758475767523;
        Sun, 21 Sep 2025 10:29:27 -0700 (PDT)
Received: from archlinux ([36.255.84.61])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551b31ebb2sm6726467a12.6.2025.09.21.10.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 10:29:27 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH] selftests/kexec: Add .gitignore for generated binary
Date: Sun, 21 Sep 2025 22:59:17 +0530
Message-ID: <20250921172917.77705-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test_kexec_jump binary is generated during 'make kselftest' but was
not ignored, leading to it appearing as untracked in `git status`.
Create a .gitignore file for selftests/kexec and add this
generated file to it.

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
 tools/testing/selftests/kexec/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/kexec/.gitignore

diff --git a/tools/testing/selftests/kexec/.gitignore b/tools/testing/selftests/kexec/.gitignore
new file mode 100644
index 000000000000..6cbe9a1049f3
--- /dev/null
+++ b/tools/testing/selftests/kexec/.gitignore
@@ -0,0 +1 @@
+test_kexec_jump
-- 
2.51.0


