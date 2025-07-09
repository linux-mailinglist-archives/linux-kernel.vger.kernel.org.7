Return-Path: <linux-kernel+bounces-722584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25278AFDC9B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 492717AFCAF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584781514E4;
	Wed,  9 Jul 2025 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gW+P4cVh"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461C4145B3F;
	Wed,  9 Jul 2025 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022821; cv=none; b=SxrE8lqfsGQUupR8BQnlvsJXxf/UKp68A+UbsOxT1vdu2jj+uQVTP7TKqXpAjlBndouU2sBgyKH1S+BK2166Q/qzxCj5hnzSppxQxLIokiH5lqPXxrr4s8AbXl735qtjCiY84uOVUzmxqFyHRk/u11I9gHkIj82681iSFyReh4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022821; c=relaxed/simple;
	bh=EcpgCEiHcibyxaOwHRX8bt5yDryjoNGcO1lh9/3JWjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ar0RP+LNg4JLYZOdaOrw8QZNGl/sAXmIJhol/BrUbJytH9vAHMFme8id8FEu+TXeRDfkaP45nui5NsZRDrLOaUTuWZD92EhEUc4flvkXG1CCN+j3i8mdWXuVjvdNBekpJc+lmv8JKexrv6yN84BZScScjENBhACcs+bajucBHeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gW+P4cVh; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e740a09eae0so5039953276.1;
        Tue, 08 Jul 2025 18:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022818; x=1752627618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+S+EPhy8VyFlv7h36Y9eh7ovmZghlSmk5oVJFc5gzbo=;
        b=gW+P4cVhuQcP/H0l47VDjek3OPNTCeErLQAdhWfSw7OVir8jWKQ4JiK00sDACWr0bA
         vqBVWL6YRyWQhgL8Wl0PAE7qbh18ykIDoh07pI1OvbdJZ5sv/UAXF4t6DjHpHURgE6Q8
         SVEOqawf1aIBguOT2MG3QoT+OixHU38mgGjnJy03MedT0fxpgO4XEChrHifr1KNsJFCE
         5/zs+MOi/Rx6ZKmw7o/4B/UbsJzXKbz9tHzbnYwLVnA4ox+z3L8it0CBVf6AnRF/0//+
         YqsR+wrLOsLmSBVDoNNUK9iMA3seHd5UL1YUMnRYx0Re3WlSyCH0iNFVMVE5SomozoiN
         pMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022818; x=1752627618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+S+EPhy8VyFlv7h36Y9eh7ovmZghlSmk5oVJFc5gzbo=;
        b=j1SoHq/CcjUX8fEsOdGk315pIBG/rp7a7tjRgtZVM88PaKPlKjd9IyF7vQcZN2f5WD
         dxT4wzHnqJenw92aRnLUY60NE/eU4Fsr3sHBy4huNfivjnX1TAOhO53R3ibAhU9ivB/i
         DZEQqcebmLvb+jtXW3Vu6J18/WJPUCy102aY28xNMCAZxytJXzPbB4QzxHbCq+z2elaO
         op80PXJUY0nuwpPOg+4M25boyjozePOvyczonrMy1X5Pcu0oCnNKaA75jg3jFZKWw17v
         nwbuPCbzcQ5KRZxZ9px+xcb1hcXM1XWLL9gZxqsxSb37rbySN5nm1PiC+JrPk/M4tLLf
         Y3Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVxQNOfheT/Wd67A/DVt8UoMk5FIJslGf60oBJnn/D2xklPKCZGk8cuQu280qbfDYS/OUDrgl8qMo8=@vger.kernel.org, AJvYcCWPqZew6OS9m4IHhyHFjj8JAqh5ChToeyFnc370JHKjvU1ltho2j/btU0orF7SHnT75FVtBN23VIjP06iws@vger.kernel.org
X-Gm-Message-State: AOJu0Yy65snHg9sY/xy3g2a49I1vqIXdFNd9xQwAyKot0wNB3T370z/Z
	PfgX8mvCZFuLbQJCit3tlmdajkuljF9/ZPj2Vx73k3Badiqy7g8WTdMW
X-Gm-Gg: ASbGncv+XJdZrie/nRDFd8RGpCgZ+GMgujJRXVmLMBepdTcFqIK7BR/c+6lDR7k5bRY
	kXuLBvqquaisd1U1z3pQ7wYkEhebJAteIlHme5GhpcZkMc5cUdDXHu0Bgtfvqny3hAkiuOs5MjT
	0M4XWcjzAf+uhbzQ5jk46a7e0ay7zQdyyRQoQb5cDIx7ofCcc9prdQrF8G19d1YrZ0zz53EZfAi
	vZhjcUpGMLnhi25sohpq1YplBan3gr3pbEQ+Ha21ycBg4rS9prn3MNJYovtny5rWbNfQiscyFTK
	ULUiO7NlASiAR3xIW+GQKymIV7TMmorIjPprXLIHz7PNFY2dexo5iKq9yXnGbb+6Lf71tnR8cIA
	VnuzHePQ=
X-Google-Smtp-Source: AGHT+IHgAhVoBn0DlM8BUKh4bCqB1qI3HV71RTmOzTs/ExvjbhBZ4AjtFQcsZLzN7auWvUgFy8e37Q==
X-Received: by 2002:a05:6902:18d4:b0:e81:7f36:5a37 with SMTP id 3f1490d57ef6-e8b6e0bc5cbmr1044311276.8.1752022818118;
        Tue, 08 Jul 2025 18:00:18 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c43ed8asm3656043276.26.2025.07.08.18.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:00:17 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	vtavarespetr@micron.com,
	ajayjoshi@micron.com
Subject: [PATCH v4 01/13] mm/damon: add struct damos_migrate_dests
Date: Tue,  8 Jul 2025 19:59:31 -0500
Message-ID: <20250709005952.17776-2-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709005952.17776-1-bijan311@gmail.com>
References: <20250709005952.17776-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

Introduce a new struct, namely damos_migrate_dests, for specifying
multiple DAMOS' migration destination nodes and their weights.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 include/linux/damon.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index e1fea3119538..07cee590ff09 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -447,6 +447,22 @@ struct damos_access_pattern {
 	unsigned int max_age_region;
 };
 
+/**
+ * struct damos_migrate_dests - Migration destination nodes and their weights.
+ * @node_id_arr:	Array of migration destination node ids.
+ * @weight_arr:		Array of migration weights for @node_id_arr.
+ * @nr_dests:		Length of the @node_id_arr and @weight_arr arrays.
+ *
+ * @node_id_arr is an array of the ids of migration destination nodes.
+ * @weight_arr is an array of the weights for those.  The weights in
+ * @weight_arr are for nodes in @node_id_arr of same array index.
+ */
+struct damos_migrate_dests {
+	unsigned int *node_id_arr;
+	unsigned int *weight_arr;
+	size_t nr_dests;
+};
+
 /**
  * struct damos - Represents a Data Access Monitoring-based Operation Scheme.
  * @pattern:		Access pattern of target regions.
-- 
2.43.0


