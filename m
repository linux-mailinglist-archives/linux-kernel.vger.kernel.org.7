Return-Path: <linux-kernel+bounces-733729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CB7B0784B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1251565A58
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758F925C81C;
	Wed, 16 Jul 2025 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="lZ/UvWGE"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232952620FC
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676735; cv=none; b=daL9mdSzy/RDgvK5NJzv/bQe0gZo8vvw1ItwLyIBTSLA7ZVPG7JWy8ydW0FPYA0powz6/ORHPVrgFeG9NfnLzT2tjJdhoJcXmN9a9spL9A+aGInMarnMU5bjnw+GkeO9k9zjJfsUhV8SoKbgGkYI4TQZA5D/w95JTZUQO6EWba4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676735; c=relaxed/simple;
	bh=G+S/L4vDU7ik5AAtN9qkBKBLi+s5yYxSyrlW2Liq+UM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mmJFwW06DfxAnFoVZ+MKt2QgfzqQPMyPI4w6pOQMgAtC1n/T/4cgKPL3yXBz1zU8kDGKySVgmknYVAf42w8Stj6ABHbkdLlLymJl21ON1wqS5T7XLdu6zqPnOQSAe4MfpPwBzfa7+4hZo+DoOi2iLKCt8jwnWT0c2QSZPS1SDdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=lZ/UvWGE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so47997135e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1752676732; x=1753281532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sa4++ALrt6t+/8Jjl/X2ucfX3WrNgLwrbp0fvXsZWM0=;
        b=lZ/UvWGE/MQuu4NfytzroISBiP0LI/yNhRVG+lCK+09feSb1Bb41ecPMPzT0GOWvS4
         YFkD1mkQVV75QBRS+G/WBDdvUQV+as+1AxSlZEWLlwTlOrL+I6v6RW8IK7D2YzGl4Nsp
         IXuKuiMP/xRFIi0ZexOzCxdpzHVFOVAEnxo0U24B7bNh1XjAsBXLCZoSigo4Ak4GXGMl
         OUkIgThJM22zPS60zzFTxd6mVPH4zrpNFbtLAA37sjjGCECglcVgYuQjAerqOWF59MkJ
         H+LwIOoxboMhIUh0lNb2rXHuoEGsf4Yrmns/CWqy6YaKWuDJb0QMKetgWJ55BZg2d8Jr
         zVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676732; x=1753281532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sa4++ALrt6t+/8Jjl/X2ucfX3WrNgLwrbp0fvXsZWM0=;
        b=I3l1CSVcb9frh1t3JxeyoY9E99aYpSgyrKvKMcVl1mBiaMgYkuT3s8S3BYQyHWpi/Y
         p279Tjq4t6CDwSFzOkLvs0ygHX0h+T0V+UmcJnic8RDlRyNlUT2MwUo4Oi0ugEjAA6l1
         H/Sqn9cEoZQ+++NyMXNxw8cksuw/bt3266mmpir3lEzJffZ7lynn361YzJ/RP0LNNmTq
         FFBet1aMAVjeswAdJEBqIzrFjCBXnKTSmuk9QuJvaPYz8R0zfj3gfqmzqZmfUwZtZzoE
         kvGFGRdy0rfH3cuMAtEJhRvnEhlVO5bmGJ3Br25HlsloY9ZxwJ38+4q0tVaXOZUAy1iM
         C7TA==
X-Forwarded-Encrypted: i=1; AJvYcCX0YbKJRBHelnRIeNmTiQHHd4Fu39XIiHc9LUA4NXoSRNheCzjs5//aS7epvccWvbjE+/ruXHQU42PvKxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7QnYS1xcib7zDbmx15Qeer8wd9jJylKhzVvR9z6WKkGkZbwMJ
	eYLCGOl7f1J1SqIZgZ6r4LFbb4Pb3KHLq8uEEoL4bZ6kvCDqkYfpv/VkUx5XjQ/f4aTOQfvwNvY
	unqdV21E=
X-Gm-Gg: ASbGnctPOwHKm/wbSeOc1hBpMjdlGkzWl6G6QlncCHR5S1nbuCWeN8FzaXGQnYpj940
	vem5YXHWdKXl7EFs4dKPzlzyvzAcgWVLCImq2LOVq8Yqr9e9SWaVm4YF1gm2t4rorOls4qtMva9
	1DwsSqI+izi4MqRv4TbF6ZnxKMK0s6lapGjPYFb+EDVADzi859MXQfEqNRZ9f565FrIHe+2kRgy
	7P1O2ciOC7Okj5qkTjL6Uwcaii+ZxcX6DNRkdMd8i2ZeEjrQHFfXKBOLkQ0h9NwlRRC9PUjA0AW
	/2KmqNZSaRvqIpqyO1DudX6CfO2fCGyvUEDAFXp/fSmwDbpbH9u/ICMHU+qYM4JCtOA+tB1mbAv
	NazO4uVTGAdEZkHhnIwAQsoOOBXc1nhZA7E5Emz5VP0LawP7L
X-Google-Smtp-Source: AGHT+IGf2Nv6Qpohj3Wa6bab7v4TtpxjOwm0RwXHgagimM5JxzC2vsSdod5ASrIKxtXObfnaxVfabw==
X-Received: by 2002:a5d:6f16:0:b0:3a5:2d42:aa25 with SMTP id ffacd0b85a97d-3b60ddc6025mr2426874f8f.50.1752676732281;
        Wed, 16 Jul 2025 07:38:52 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:96ff:526e:2192:5194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e14e82sm18202521f8f.71.2025.07.16.07.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:38:51 -0700 (PDT)
From: Antonio Quartulli <antonio@mandelbit.com>
To: linux-nfs@vger.kernel.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Sergey Bashirov <sergeybashirov@gmail.com>,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pNFS: fix uninitialized pointer access
Date: Wed, 16 Jul 2025 16:38:48 +0200
Message-ID: <20250716143848.14713-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ext_tree_encode_commit() if no block extent is encoded due to lack
of buffer space, ret is set to -ENOSPC and we end up accessing be_prev
despite it being uninitialized.

Fix this behaviour by bailing out right away when no extent is encoded.

Fixes: d84c4754f874 ("pNFS: Fix extent encoding in block/scsi layout")
Addresses-Coverity-ID: 1647611 ("Memory - illegal accesses  (UNINIT)")
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 fs/nfs/blocklayout/extent_tree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/blocklayout/extent_tree.c b/fs/nfs/blocklayout/extent_tree.c
index 315949a7e92d..82e19205f425 100644
--- a/fs/nfs/blocklayout/extent_tree.c
+++ b/fs/nfs/blocklayout/extent_tree.c
@@ -598,6 +598,11 @@ ext_tree_encode_commit(struct pnfs_block_layout *bl, __be32 *p,
 		if (ext_tree_layoutupdate_size(bl, *count) > buffer_size) {
 			(*count)--;
 			ret = -ENOSPC;
+			/* bail out right away if no extent was encoded */
+			if (!*count) {
+				spin_unlock(&bl->bl_ext_lock);
+				return ret;
+			}
 			break;
 		}
 
-- 
2.49.1


