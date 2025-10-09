Return-Path: <linux-kernel+bounces-846253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D13AFBC763F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 06:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D762E19E4EF6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 04:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B04825C802;
	Thu,  9 Oct 2025 04:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BobXPTxC"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CAD25B687
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759985675; cv=none; b=VjF1EvMjYtL7rU2Ags6Wx/0qVhe3WMz87eQ1s7LvXAHMApPwpBkKuQDbrE5Qx3FGjCRgTLQOGBz/NpnfIPlClvi4Pyxz6YVkqG0oaMCtR0GaUiE6E0Pd4KxCppUxj9Kv4OrJrXi1B9WsyRL1BQctEVE7MRGEX3EL3N7PonL9+tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759985675; c=relaxed/simple;
	bh=w+Kuafgc44tEvaLcNgVbY1Detnyn1TP+rsKy11PWdGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JvkE5UzUfI7Rx8VaIJ2Zx8Q5rHrSJmeYygFwkxmmbgqmvNxqDl7GIfsCRuouSi8hV3z+jLueNFqPvyWRMa9GAMl2yKZHLCqVK7lDz8U5ZF6e54JbszFClgR4Caib1vhHjY33gs6ivLPQGk62q1fu7Eunoevz0sp3pxaeOujoELI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BobXPTxC; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-269af38418aso6862075ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 21:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759985673; x=1760590473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Tfw9ZfkVYbFeFtQQO2RdnGi20hC7pdXgzL0TwKkXK4=;
        b=BobXPTxCYgu9Jp78A4hBylz1ia+ra6VKxVHTQXFYbNZnjwC4uSmqo62zsvGKb60+JY
         dqEiGJNjndK7okyynbvnKYg2sVTQ8i4BGikV4ttrayFCDy34fEAKKKFHx1WAXWdj4pQu
         RC/2N2GTGiovJvM6s47/5oPn3LYkM4S2Lw2RF+O+zWuxix5n1ZlJjZeCJCUbSAJn8JC1
         SafpedmoKncblsu7uVI3TIPPfeolaF5ALVu4ZKB6g1AvhZZAAhp0/NqcJpZ0ECHUNVpC
         EmKXX5dnjK+GN1S92DGUVau4G7QGMrX24Je+wVX06jJxnHzMRDRSymF0sD3ZEwUNj3kx
         gV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759985673; x=1760590473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Tfw9ZfkVYbFeFtQQO2RdnGi20hC7pdXgzL0TwKkXK4=;
        b=b/HwLUWUH/Iluxlv2YnUja/IeJYzYdTXSNblME4cWOgg0g24FPJ0OXYyVHHfsw/Cl4
         zhQNVciiGkxA4MNIbLHpFfJL6BaqcOcs/Pgs7EpB5cCZ4yQFyh4RH6+CIRvgkkM/CsRy
         812fg++JR5tauYjbgvQZOpArfW4j7z7AEM1k8ZFrzUVBsVGThT/t9h68Pt6biT6BjGT4
         WD1K57GxnGI0ZA2EVyPX76ArD407+gvmb4wa/GvuKI0elGPoqj0e1M00euNm/rn5xZoM
         vzZz5ihewT3j3kUfHBkC4slXdeEDuZmPXgNXcriNVuNJbxuru7YDVDxEQUi8p4bXENf5
         2S1Q==
X-Gm-Message-State: AOJu0Yw34T1a8Hdwn6dwrJYKEBY9Rpqq0cS+KMTDgGoMAlEnYF6gvcN9
	ntMXdUl4qmhEaMINBkUNn8QCvStTIrPOE0Xx0fYUP2RsaBkTTEfq0l847j+0wYYXWtY=
X-Gm-Gg: ASbGnctco7Vz+hUmQJ1BMlozGDbBIWvdif6gnriKFDA6GntmG2h5/gIroNBC0i1fVZH
	+RL9bPkFRZXgNBKPbGJOHhNO2HIL0zvBCwsKcnDM6GGtWymmgYYKkaUDtMBMha8S089T6xff6s0
	Dp1hxk00S6jIEAsKJLrI6REUVqY/OIHBccoVw45rUhfeBbTGK63tmPB5DdjCPLLkyOTnAb0zrN5
	gblPzyOPrrbgphMXNxlCbpWb+q3CNnnHMONbce7QY850NrWQ+iBBxwyTaHaQasKRfA+uW1js/8D
	4vipwhMppUhz9D9xWkY0DZsQY8qiGIbclZaPKfU/ZLfSmEfkLhg1Lwdm8BmvBxbyo6XHdluSTiQ
	lSs6wUs32dyWoSFL+uRjcaxOqMt8kDJaaysJBRWnqJWGVGe4NueIxA6vSv+yoMLKoqQ==
X-Google-Smtp-Source: AGHT+IHs5oQxzgPYgvjhGgUXIMHAfemFYJF0eBPmSz+QPLzUbxC4cmQvyXqohxlvHOS0JXDY4GoQVg==
X-Received: by 2002:a17:903:2d0:b0:265:604c:17e7 with SMTP id d9443c01a7336-2902741f0b1mr68383795ad.60.1759985673202;
        Wed, 08 Oct 2025 21:54:33 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36cb1sm14161475ad.100.2025.10.08.21.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 21:54:32 -0700 (PDT)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>,
	syzbot+ddc001b92c083dbf2b97@syzkaller.appspotmail.com
Subject: [PATCH v3] ring buffer: Propagate __rb_map_vma return value to caller
Date: Thu,  9 Oct 2025 10:23:45 +0530
Message-ID: <20251009045345.8954-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value from __rb_map_vma(), which rejects writable or
executable mappings (VM_WRITE, VM_EXEC, or !VM_MAYSHARE), was being
ignored.  As a result the caller of `__rb_map_vma` always returned 0 even when the
mapping had actually failed, allowing it to proceed with an invalid VMA.

Reported-by: syzbot+ddc001b92c083dbf2b97@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=194151be8eaebd826005329b2e123aecae714bdb
Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---

Changes in v3: https://lore.kernel.org/linux-trace-kernel/20251008172516.20697-1-ankitkhushwaha.linux@gmail.com/
* Same as v2:)

Changes in v2: https://lore.kernel.org/linux-trace-kernel/20251007171256.20884-1-ankitkhushwaha.linux@gmail.com/
* applied minor cleanup suggested by Steve in v1

---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 43460949ad3f..1244d2c5c384 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7273,7 +7273,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		atomic_dec(&cpu_buffer->resize_disabled);
 	}
 
-	return 0;
+	return err;
 }
 
 int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
-- 
2.51.0


