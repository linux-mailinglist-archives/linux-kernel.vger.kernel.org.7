Return-Path: <linux-kernel+bounces-844564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2AABC23AB
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 19:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7153219A29A8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 17:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA74A1DE2CC;
	Tue,  7 Oct 2025 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZx9VgAg"
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF4F2E8B8E
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759857225; cv=none; b=MHKRQxrU9yR3kzojzMTL9K7UH2gm2PUH0t0bk+HTSyuu0Tn+IcYYVr2T+RFPB2jNsmxl4GgtZsGTnRQ516Q1pJVYt20VM60j5nraaGfDRtL3djkc+NmPRAUvauVLurRoWvR/5cORPXbcf4IT8EYzBz7m6wPmPLGOx3Gc5hbXOyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759857225; c=relaxed/simple;
	bh=6hkEXSoPQClBN9P+2M59L/xoo11QDhuwy3o/ItrIwug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eWdbRho9El1SWhcb1JZ0zRjR1aeOzalGZKLJGwuCeNj6EvNbbY8dVtlmmBVN+1chyhQjr2d/ItwW8ylECyqDiks8baBYcPl2vih5UfTEK+wx42YySNe7RsxogS8MDCuJ/hGqEwrZwoxgenGITT+mDHBYyXnHVcaU1L3Wv05NQ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZx9VgAg; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-330b4739538so6612901a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 10:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759857219; x=1760462019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ndiW8EiHjsJuqlvrDnKSTbKhst7QkkL0u0UDEfXrL54=;
        b=BZx9VgAg4A2J/75tOqLJHhPNOJVQzQwaPA0t/+lD9GMt+4M+lBGisQpB+KWMsvYNpj
         FK4WmeaPtjlowQeMmCPDgo/F44H0Kt1UtF0BK/6fw+TpXr6GC4EIxd6gBU0U9liFxQjN
         kNoBl562iK46eU8ZD27cS7bF4alhQogjMs1GG7Jl8fz3chSdL4nGeobUmnQkM3IU1KEa
         nKC1PyQeeTa58mmnt/7VZzQcnynIqQyCPLRxu9jqhilYVl8xtHwA+C/1314vufhzW7l8
         ZVO05lvTt5bZeJvi4bv/gD5BvSWMBnD/dT6ZM+u027Y+71sBkOHuv6xv4hev0CIANcUf
         C2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759857219; x=1760462019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndiW8EiHjsJuqlvrDnKSTbKhst7QkkL0u0UDEfXrL54=;
        b=Vb6QyV9zzVdWn+h4g+h1ESz9ogZjo8JDRFE/bRoQQK6RXHPuNRMtHaeiMSDA9oveU9
         EvgVCbICzsYA0XSbvsyYmEv/xXWREwiAVplUUHkQNOh8fnN1NW00sqj2w2hBZmdTGdZ+
         o0Hr+fnCuoRfJBGYLx4Y+7ywbDqVv1VwzwvpDjEEA58oNMBQRAEXNOItCEQnTfep/dQK
         gOgr7NDi8YqpEMOxaGEsAJIZzwvWWRAwSs7MapM3AqLpWG6t//o4PpQo8dalBiw3bM6z
         TTf1lPP7xOwQPsJa2bmblPdJg8BtkS6iCoNbOwx5Nt6sgupgKE54DmbHNr9YO5JFa6ya
         Pfqg==
X-Gm-Message-State: AOJu0YyugzU/0kf2mZYQLMeAJ6pxOwXagfiCCY26Dz6+71HxDmk6P64v
	/5CkTyAedSeGM7dHBhqy8FMqDEAFnttCizQykXUGzF28sys/HCqD7YuKB/jt587z
X-Gm-Gg: ASbGncubshaWGDoXt7uRQm0PDvuXyyUqed6m641pjoJeIqhEkB0QQCmcGQLAuLGSLMr
	TNSP6hftlRMOEfvcN+8KGWJYoDQe/TCscotg3Sp1Lnqv1+0Jux24bHDa1h1FL0iA1kj1zYo7a+o
	noxNinOQ3DlBIbDIfCGR9h8RZQ9REIi0QvHxhzcTCvErdA9ngnEneEbmmzxKfFafBv/MdxQJNFe
	fxxYRiIrdKGzTCOSUJs6WB25R317YRGiQIvwlNO70eQ2vAxGkkv5O5c73oWVxmVjss8dlzUYHU2
	BjBe3Pai/UC1XVGnqB4L4E91+K0mr0jmUPGhcaBp6/uWTyayXLgR90j3Bwelhxv4CW5tjwSnRgo
	tsxWHTkoHjburt4sCww2DQULXbSoBDzca1j33gc9rZuCdwp16/NkajOBqrjBcf4BRMA==
X-Google-Smtp-Source: AGHT+IEw8/ovBuazt3eXRnTgiJXDDXOaNSZGFtByXDec22X8YVk7CtYfnAhylw3oRk25QxNUr2BtOw==
X-Received: by 2002:a17:90b:1d09:b0:32e:a59f:b25d with SMTP id 98e67ed59e1d1-33b513cfadbmr293892a91.30.1759857219077;
        Tue, 07 Oct 2025 10:13:39 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339edf4992dsm1906075a91.0.2025.10.07.10.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 10:13:38 -0700 (PDT)
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
Subject: [PATCH] ring buffer: propagate __rb_map_vma return value to caller
Date: Tue,  7 Oct 2025 22:42:56 +0530
Message-ID: <20251007171256.20884-1-ankitkhushwaha.linux@gmail.com>
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
---

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 4ff71af020ae

---
 kernel/trace/ring_buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 43460949ad3f..4efb90364f48 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7271,6 +7271,8 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		cpu_buffer->subbuf_ids = NULL;
 		rb_free_meta_page(cpu_buffer);
 		atomic_dec(&cpu_buffer->resize_disabled);
+		/* VM failed to be mapped */
+		return err;
 	}
 
 	return 0;
-- 
2.51.0


