Return-Path: <linux-kernel+bounces-781172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2C8B30E6E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45260AA70EA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5232323909F;
	Fri, 22 Aug 2025 06:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/fOlzxj"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6955F7262F;
	Fri, 22 Aug 2025 06:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755842668; cv=none; b=MvlcU2yw2f9Bw2IvtPbCOSAWRbrP0peYgqAHPQfUGFNrMKFqu6r9+eHXvD5s/JaQFv/pgVWQ2J5cikeWv2MPSjfS8JIyy2MfRIjOJShHu9071zBBYZ7aGEjSpNhe39x+4db/sWHt5xESYL8mjWuDvR5pPOP5lz9GjfuAnIvDi+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755842668; c=relaxed/simple;
	bh=UiUYReCj5NOMEOAHaFcJU7PwriRUfom/Ix6fZbdArBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iBuwzwx434WLVngm9Tb5UoRCqfWWTIh9JcF47TlU8Hz/8ZXNEuRmAFsChlmsZnpRj/HGQUqytm3poEFIeP8ZRzCRmiNgRrFsn8u2Gon6i2XlajA6bfDOOEO7GarkMVjuS9DSbsT+s5zpS1cvJzx7sKBc1SecZS8yrTtpypPh93o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/fOlzxj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2460757107bso13652565ad.2;
        Thu, 21 Aug 2025 23:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755842667; x=1756447467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sWgKWHd/sc4pjgErj4aUjUcK4gHol/ug73h3HW8zsiU=;
        b=E/fOlzxj57ctRj5QCu3bHJQMLIxwg5VpQ08hqnqq1PlKQL7y4XTcQGYfXruj/0fqUd
         MXVeksB8Q4fn3CSJ+8vnZMgXS3jTsB33H7jSeTefUJ7vmyeniHpVsmXhR6lD+mTT5II4
         lUMt7OG5IsWku4jf+K51LcrZgQTwu2TkeCAlXL8qcJIWxAL31SdGZtVa2bTT0hWdfJxd
         gtHYVmyWKHt6F9jl5yKKPYLaeeqfx891cGguR4tqzPhdCmp6C4h0S3O0eh4XBFGEguGu
         A8Mr9SwfXC+CgsU+LgneR7+nxPubWxjwiStY+w9pWt1/5MKhHFrmVxl8uQAnX0gKaLHo
         2ZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755842667; x=1756447467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWgKWHd/sc4pjgErj4aUjUcK4gHol/ug73h3HW8zsiU=;
        b=Lya+EX0XxNu7m2D425XdInh3euSVHaSAkOwa+gzO6dFzNYx/8BUgu+fNxExLE3+tui
         cVb8Sv7v/+x59bNTJQdfIncrEkcA4wtMKLVRQ8/dV+5+PS5qlbTY1EnQLeNgcC6wrzaR
         xXrpdQ/MCDiVZx70lQNeC6T5n2kanH7RMkIfaBUXwOSPSI7/QYczaeRrqkxPCanzuawf
         fJRtqig1c6e5LCUy3U3DVxuRO1yGD9dtXLnYyBp19pH9Ec3YM79VY419Pr76PH53Iv8W
         +52oL2CHyIdsbAbcr3HyFRzcZ1bDqj1tn87f3tJ3rp5CBRHxOwiTqT+SkXfGYXWjG+ew
         3F0A==
X-Forwarded-Encrypted: i=1; AJvYcCWCa1h1JZfNvjyv2Y3NH5hxUJ5Tdm3sqtBlbnxwjCWlOggIQBHzNTnYjyASH2eoHMfvJGxIl28l360KMgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr5wewFsKedCtnev5ZjbfM79jbCXKqz6P0Oun5JLh0OxjQ+5Jn
	dWG/YIflRQf0BVj034qtQPJ1hAOJDXw1JCgROcd1XKTwbYIsAeP4Z3v/
X-Gm-Gg: ASbGncuGu+SjgUCBstVDCcJVEokmGY3Xu14SAYSNAETwfKqcUzq0+s2Vhe1673G+SEb
	zpa1IgJtspQVnqcdbby45b5Yj/IsFgPk7inJQ7W1O+8FkScdUkmpkU+M66fTyjf7U9lSdBvfTyy
	7TaIIkcpEt8udOXP3WLHJjgagURcSpbbgif8jI0abnOr8fvHPtLFvPgHK83IgOdCsToN9lbkb7N
	KkBncx+8wvE55+IxEXc6rQpBXn03E3woDisOHfrMs9wPrpEcYego8H8B1TmcEgSzgUJbyVbXFOT
	gCKKtiuuLOr54sOVm8SjLlF0El0gQYoDKheq63L97EBR9YU5klDeMF1D/6FKgrBIPIfwA8vaWK0
	wkijnUAinUKAaMdYobZ8PY8/K8kOJyBFqW/srNeiG4j9ICVSjyhynHg==
X-Google-Smtp-Source: AGHT+IFpLU6XrEIPrFgTF4JVMX6edxo2lc6RP29jAi2GsYoM3sNOLe6c4U6XTtz35e6YcOLq5XSf2g==
X-Received: by 2002:a17:902:fc4f:b0:240:6fda:582a with SMTP id d9443c01a7336-2462ee0a951mr25812385ad.23.1755842666530;
        Thu, 21 Aug 2025 23:04:26 -0700 (PDT)
Received: from fedora ([172.59.161.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed33a727sm73267685ad.1.2025.08.21.23.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 23:04:26 -0700 (PDT)
From: Alex Tran <alex.t.tran@gmail.com>
To: robh@kernel.org,
	saravanak@google.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH] scripts/dtc/flattree.c: stringtable_insert optimization
Date: Thu, 21 Aug 2025 23:04:17 -0700
Message-ID: <20250822060417.52935-1-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Increment string by string instead of character by character.

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
 scripts/dtc/flattree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/dtc/flattree.c b/scripts/dtc/flattree.c
index 1bcd8089c5b9..156ca5da89b2 100644
--- a/scripts/dtc/flattree.c
+++ b/scripts/dtc/flattree.c
@@ -222,9 +222,7 @@ static int stringtable_insert(struct data *d, const char *str)
 {
 	unsigned int i;
 
-	/* FIXME: do this more efficiently? */
-
-	for (i = 0; i < d->len; i++) {
+	for (i = 0; i < d->len; i += strlen(d->val + i) + 1) {
 		if (streq(str, d->val + i))
 			return i;
 	}
-- 
2.50.1


