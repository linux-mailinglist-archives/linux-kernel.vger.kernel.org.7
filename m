Return-Path: <linux-kernel+bounces-823564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ED3B86DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B1D5648AD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEC331B838;
	Thu, 18 Sep 2025 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eM02LC/a"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1BB31B81A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226302; cv=none; b=mp+xAtQRoY3NaZn43qmZRpuoDd1V6x06NdS1Pxc64p/d+EMCwJn91tysTfAjpL3KzyA5lg77/26eNHcwXEP6tsf9IisKhGe7oxZmrLxXwWU6EsQfnLF9YmfIcmJ4SCnTr1pP3zqo3TAB7Lt1/FQ5ocCOJN0yCjQDj4O29qKl6Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226302; c=relaxed/simple;
	bh=MlzkbCzxBnkF0Ot5onCFMHUEUOT6VSHs/kNPIgP/+S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTr/0HEhtn/HrJOlRJaF/XJ2TxQKImPuCnC+dDZZ5qaZJLipUDlFXVBVmtNvl/IFbWYquULn2zH3lbaJawb/225MUoEIPtihKAAoI9HwFzAItf/I1RTPLL4wf3Y01ujQokhVKVlHt3wZQYMzzhOuGLh05hVoMtQbnoNIzZk6C9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eM02LC/a; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b5f3e06ba9so27786771cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758226300; x=1758831100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhfQTSFAJZS9gqyA7ko5YffZgh1O242sf4VUlqQppZ0=;
        b=eM02LC/axWmr3jPeOA08ELiKDGqjZNpRcV7k4H1oFtooYPItDtxlLJSuKSh0lhQO8D
         llHgYBMJ9TejkpkYA3Pct7MQJ3hzDoPczGJorm0zPCfQ/adUAhiFxdjbeMBPsRcUHvMe
         hs0sKRJOfdbuOQTzemhZQmnRQJZQ4ZwQvpxS8t9a8GU+tFTUinhbpIiRSK7lbtoZTmI/
         xDdP0KXWjjZUeVMmYWj14L6oPRXRyMWYKl96x3ObZYgFqfIkY6wARZhFSLkMKvKuey/i
         dW6X2FsFQrR6mGQWm3bj6ubypfH5BS30WRMo/+RGAxABobih94f+7Jd3WCWOUmVF3ROD
         6qJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758226300; x=1758831100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhfQTSFAJZS9gqyA7ko5YffZgh1O242sf4VUlqQppZ0=;
        b=fx7WEY47gst+ZljO2+3H+6GzTBCcKqXxRiwGp/RHbRil+9cBoUbugCCUi6ZWV4w32R
         Z93uuxHAdPGx3SPYvpV1wR6fy7rEfgk25s4IevusMrX83HXX8JVFQ8vnVECKncHC74qC
         EKsVOjZ6Ry6t2W5Ms6PLcF9598aw4jso0sDqSu05YmdniwLu/BxH7ZvpfUjualsJ3uPo
         3+stl0zuJWDuG7DijfiBX3yEt0U0fB4TQlhv3QjP4CsKIoF7+xMLOqbEWRTNNIc9ivBv
         hVDCZddlhbhyfX7qyW11fpEgjzjxDX0F7I6ZHEL60qtjd9ZJRjiIht0FOUF+DDL57VLu
         3QFg==
X-Forwarded-Encrypted: i=1; AJvYcCWZnVGWlW1Dr5aJqz0tRbULzVCtbgjXDKXmnmNJfi1eGygrRhRkZjELHbXsr1MYxOZod1tTLdfBtiKzp4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVJWKayW4s9JeJWAt6W6O3v46hYB1vz/EDC6qzhS2Iu16prQ1W
	OPU4BXinXTv+0F4t3fE3/Ee4eyougPg3DA5nh8fwSLLqXw+sLgDp1P81
X-Gm-Gg: ASbGncvKOwJ3tOTxLW100Bh8I7u4rZ9vAm98lEumemhw+xUHmOCk3D6Bviviwb4YRfl
	KYwCuLvRLZsKwwIrvYWfJm+awACyg1qdENVNQmF4duob6/8+RiroheP90qNV1P2CZNzWomwFfs1
	qWc5/6CGkH9d0+LzPftRG/yUCQfDMqbVoZ6RqaBuWL1CBBT6T59QKHJMKBxvYOX6Fm4i+HnAYkB
	rQduwfjKTqHyZle1ik7N0rvDPeADk2A9anVD4/6/cupx+wJ++GmgXYX5LeSuP8IFKxSkL0h9D3R
	daz4AW+6iQ4QCQ2loT00ZjWJ5ivYV5eQAJggl9SnM4fFjzf6287z7ezU0whks/XrkYXTKJBhdzy
	bsz/VbwfV2GtdVYvtPjRGDytmT27A4iewFSEDyK++5my+
X-Google-Smtp-Source: AGHT+IH78xMwfYsunN2DfRqB0zpQ4ad+WkU0hv4qihFufyAmnZbwnOXpnB024qM+pbW7ssyAVZOIjQ==
X-Received: by 2002:a05:622a:1892:b0:4b7:acab:852b with SMTP id d75a77b69052e-4bdad82345amr55746341cf.26.1758226299961;
        Thu, 18 Sep 2025 13:11:39 -0700 (PDT)
Received: from jl.umd.edu ([129.2.89.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83630299579sm222392985a.41.2025.09.18.13.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 13:11:39 -0700 (PDT)
From: julian-lagattuta <julian.lagattuta@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julian-lagattuta <julian.lagattuta@gmail.com>
Subject: [PATCH 1/6] module: store init_pid and idempotent in module
Date: Thu, 18 Sep 2025 16:11:06 -0400
Message-ID: <20250918201109.24620-4-julian.lagattuta@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918201109.24620-2-julian.lagattuta@gmail.com>
References: <20250918201109.24620-2-julian.lagattuta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: julian-lagattuta <julian.lagattuta@gmail.com>
---
 include/linux/module.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 5faa1fb1f4b4..5ac5f4992fe8 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -599,6 +599,10 @@ struct module {
 #ifdef CONFIG_DYNAMIC_DEBUG_CORE
 	struct _ddebug_info dyndbg_info;
 #endif
+#ifdef CONFIG_MODULE_FORCE_UNLOAD
+	struct pid *init_pid;
+	struct idempotent *idempotent;
+#endif
 } ____cacheline_aligned __randomize_layout;
 #ifndef MODULE_ARCH_INIT
 #define MODULE_ARCH_INIT {}
-- 
2.45.2


