Return-Path: <linux-kernel+bounces-845807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2197BC6243
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 19:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB663C3BBD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 17:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A66F2BE7BA;
	Wed,  8 Oct 2025 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zh8LER0V"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE5C2165EA
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944332; cv=none; b=DvBdK5iq7XPWnp2F2Q0V2TzaFc5xF8BmgtCRxqA95SzdQRQ4TqyQEkx8YB3wk0/yW2toxLDnkrULf4Nb3Q1qrNmECgHY73juSNPZ9L/CiXPIQwKjUeuULaoRw8c08EzQUp5gft02FgrjaCmZjtwModMaTwC7CuQ5JwnznSJ4IkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944332; c=relaxed/simple;
	bh=OBWc87pQeSBPnNP9Y6+pBUc5uvdElUQm6oastV3iVD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e/ufQR1Od/bN2lS5HLYSfcM8NySC/lkQoeQiiJkROmd3Qkqo2pmH6lj7ZNpivJwJgei1pNM6IhG72BHYA2B+FCI4PzuACd8AjCZMSDBmUQ0IGOw9tGJtlZDk6v86YLouL7miq7SbfoaCGlHaDi/LcfXtbxdns6sLCZTvSkeXfS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zh8LER0V; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so667165ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 10:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759944330; x=1760549130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=41XZ0Nc+5i1FOapXe9kYQ/jcLvjFNXLmKvQlP4jYRDA=;
        b=Zh8LER0VL2pk8CLUHU2JW5CnoxitNYIcMW0HDv57m5JYMvQQTw8G5vyUTwUmjk3Uft
         eEZFz5rJ1fetqeBNG+WG5dreH10Kfl+KALeRjIicQsNF+nFanmcUSeMgjQEeBgqCMwhp
         3tG5fU6VZhaz6WovP3N355qDqv0BsElmJI363l1tXc2JYsBQARuxUOW7+kXBGezaj2NP
         hNfecoBeeINfSTzT8r4hhjAlx6QPaFhBOUhJ7GimwSdUa6yDCCD+PGpIzSup0nJ3wsnv
         oZ2aQEJZMEPMQExuPVaeIxmOPB5dSlmfEBMOV+AB7EQ4PCv3U3kNHJjXNbJY76ZD+4AV
         ZWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759944330; x=1760549130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41XZ0Nc+5i1FOapXe9kYQ/jcLvjFNXLmKvQlP4jYRDA=;
        b=hvuLgQtqgMCjX8NJZLypKemoNSYgdOCm7wHZH5NrM/eSDJTNvh+Djxs7D6XM1J+NQ9
         mtEONHkwguU/c/Wom8CPO51zlTpGdBil/qCcPv3SL5Y/d52YnYoUzPUmCzCv0wjoqE/j
         gAVnKV1Z/cT+WryvbGxzXZSsT7KoiBmxM0zGOBFOIMb8O/5+Bg3//zhYcZw2RH6vxpih
         6fCZt9ir68tBDIZs/GBZ3hbL3eXIbShVLENmJaxtFyN4xl88IyxVPAmiYl+SIdW02W/+
         lP2l5+6rRbF7u03ewJBabYeIb3QT6/K62A3dIvrKcfEiaNSI4D7d43qV2lO7qk+Yq6mD
         do9A==
X-Gm-Message-State: AOJu0Ywoyn0F/oZbIO4KRVHNBAmnkDexXCBQmqXt1fNFeJbrLnp4tgtZ
	g7jZng4IjbTbRta+NPYc8KGweaYw/ZJUmV86i0mvjaeAKuPZmiJ+DYcFKPtwma1l
X-Gm-Gg: ASbGncsg6qSOgetVrrB6fd8C/6unjAHMg43CwugMfpG9awAfurJiQtllLkft8Jlgu3f
	asu/1IzcrNg+5HTP7E75wd5RB1gcy6KIDf8YF2ZWJlKO4gwayecDLZFwdaTBCe1raSKrRwdQiN4
	7hX1p2W9soull6B9wRvryWlPUMGNG67DQiE4s/OS3ld9jY/1CK0+CbuxNya/JUE4h5nYlZZikxP
	PriYQrTmqV8a6jga40YsXJjRKsiNykKFh1udWBlqfNyAwZ7BLskWqRkYbqjKeLps92uTPMlMobE
	zs7NbYrVZZuA96Px2MNBIp/dLUy1DYsAcqhhewAVCC1YzjKYBHMioCXeRiif3qDq/iuwZkf7U6D
	lJJ4uMz3fNbwuHXN2dczk5BYmgLBPKxz26uemoZHEFn1+4Tq8IN05Y7oAJh4f6u10yg==
X-Google-Smtp-Source: AGHT+IElTiSwjjSnRQ2YldSSmOA7Pun5HHGSGRiphAnOm/twua0zyVb25UTGjox4glkPR20eg3ChWw==
X-Received: by 2002:a17:903:3c30:b0:270:ea84:324a with SMTP id d9443c01a7336-290272c1898mr58357555ad.38.1759944330387;
        Wed, 08 Oct 2025 10:25:30 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e2062fsm3039115ad.48.2025.10.08.10.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 10:25:30 -0700 (PDT)
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
Subject: [PATCH v2] ring buffer: Propagate __rb_map_vma return value to caller
Date: Wed,  8 Oct 2025 22:55:16 +0530
Message-ID: <20251008172516.20697-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value from `__rb_map_vma()`, which rejects writable or
executable mappings (VM_WRITE, VM_EXEC, or !VM_MAYSHARE), was being
ignored. As a result the caller of `__rb_map_vma` always returned 0 
even when the mapping had actually failed, allowing it to proceed
with an invalid VMA.

Reported-by: syzbot+ddc001b92c083dbf2b97@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=194151be8eaebd826005329b2e123aecae714bdb
Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>

Changes in v2:
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


