Return-Path: <linux-kernel+bounces-834834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1B6BA59D5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 08:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CBCF3BA65F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 06:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7050258CD7;
	Sat, 27 Sep 2025 06:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPCzd3pL"
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750D25F995
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758953544; cv=none; b=QZ8vAC6K6bQsXvBjO6ynBgoKYL3IfkYvT4RN6xyKymnEwdaVG0ayALqxS07zdjSNlaxY5EkuptS4HZiZSGA5ZMvm0kJcMkKAxaf2quxU8Et4V9wadYby+IYMLi1gtzsTpzB2+UTg2P0kvWtMwZKR0xGM50joUeEs7cHa7iRaIcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758953544; c=relaxed/simple;
	bh=1mzduihlymOwOuUzpa230b/9HplV9BYgnGrs5Bj/ugc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dM+9L+ybss0xKKYh4LahXTr6OELD/ZolS0u4EAwk7/pWpaAMhMRxtdgQh79MJ09zAn7htTumpV//UPr3yd09meUJ6hIyKO45FSzil41UXxQ31qaUTunly1ol2UZSbzpj4kZXzi0GlsrM5owqJbjojnl1AJFTp17uQ8xemZLr2pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPCzd3pL; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-780f6632e64so1546934b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758953542; x=1759558342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8sAn5hC327aMiooFzuB7A3KTTq87gTWKySZ/wTATxc=;
        b=ZPCzd3pLkhaqWECEhiuJ/tHnvpXSN7WfsfCYyrZbRDiOndC8xU06LPbAV83YWmW9Q/
         /66kbK1WhfawpSW4coriAfWq39rj0zgrSRSlxY7YKZk0V/tf5Pp0MBMBZpc1iq6jsMB0
         t8ofOtirSd3RgvvPjoXFmZoY9fJKxEseSzffEdyqOPO1emwl8RKGRveSJpFrU5jVGCCM
         f2vYuzdrM2J95x/2hNSLcJyKSxwGddxnkhDkNgARTkBEp/pkAU2WgbWX3yl+tzIcwb3G
         aCU5qqzKOkN/F00EXfQCCjBoWmoS8WE2swQqXyambMjztI60vc0/XNJlI5woJAOTC9ga
         QtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758953542; x=1759558342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8sAn5hC327aMiooFzuB7A3KTTq87gTWKySZ/wTATxc=;
        b=sI5RYhntdGnartlzTWo3HuMNe0/68YX2hjGm/CVRl1wJLi8MDtnVaWEcTKIy8DSIOg
         y8TUOWP9nTVEaJAg8g7AxGWpXlcOr6yB/6h5THkV9Fqgx4rZNwWSfyIRqhdSMfQmVnuM
         vMzecRfVqUmqUE9W8XYlpBA+ysidnLGd2fUTerPAA8oiRvjEXArEfClFGVPgnC/HVmrz
         dYcvTK8XvIohZtJjhs6DK6Tf1aZyyo45NZMxz89Rl5+IOxFdg4T1LIqO8kut1NnB9PKK
         vt7G2JP8WrpPc/lRzPZ0MWYjshKbzBe+S+5f1QqfTxDkaijdROOsZ7vOowoQu1iymE05
         Q0og==
X-Forwarded-Encrypted: i=1; AJvYcCWNtabisPFOrTM36Hvh/EKO9vA1BBa+E0+zLdtz75ZVjN+FbHSb8126fvi0HOjeKjlIUl48WANFBikMh7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YznbPDwB9s/AOFip57OOopoo+M3TjujNCpN3A5MClCOIjhpWBae
	uNwmh+Ueg7gopgCW3STHJ9Kp26LD1IkUwS+pK8a78zqMFqjJ6FaHfp2Y
X-Gm-Gg: ASbGncuOTNuAm/vlY3qSNLCNGwYDTM1aqvGBGh3/gjvPpfBqmcHcX2qqfyWYdwmBGDR
	AnTnEAKf3oULUTIBXqs5Ta3B0aqGj+ayVD3y7bvboTvmEhWL1X7L/3jVtaSdQmsEr5cBsotaXe2
	NDzlSqIdiABK3Z3EGnHSeGZUOFBP/SFgs8aiYDqWW8NayOPsYTP4+tNkNE+SwBnqJfIGa1kM8L6
	vE9oeKkxR4ws+u4BPAF2fEbXkbapUIWfpywyFekOl+UiWinNnD7BQCdZ5kyVZy1VC+CzfcmlSiW
	TXz1L6pmMgAjbhiTnSytkg+pNJfMwOsCMzOEIaO8sKAowgHmmGpcTtoNL9jUznYCifCDFWsZGmA
	9JHVOzCyB819qgzuRpaBQt0D55578rg==
X-Google-Smtp-Source: AGHT+IE6mkLCpiGbrwrJeQJpeI8hUbeD8pN++q6vBROWRxM+SfOiGWJswZDLpzroKY3f/4THyxpj9Q==
X-Received: by 2002:a05:6a21:32a0:b0:24a:c995:e145 with SMTP id adf61e73a8af0-2e7c1bc5581mr11500386637.19.1758953541864;
        Fri, 26 Sep 2025 23:12:21 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023edda8sm5891178b3a.43.2025.09.26.23.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 23:12:21 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <menglong.dong@linux.dev>
To: ast@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	jiang.biao@linux.dev
Subject: [PATCH RFC bpf-next 2/3] x86,bpf: use bpf_prog_report_probe_violation for x86
Date: Sat, 27 Sep 2025 14:12:09 +0800
Message-ID: <20250927061210.194502-3-menglong.dong@linux.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250927061210.194502-1-menglong.dong@linux.dev>
References: <20250927061210.194502-1-menglong.dong@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use bpf_prog_report_probe_violation() to report the memory probe fault
in ex_handler_bpf().

Signed-off-by: Menglong Dong <menglong.dong@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index fc13306af15f..03d4d8385f4c 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1470,6 +1470,8 @@ bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
 		off = FIELD_GET(DATA_ARENA_OFFSET_MASK, x->data);
 		addr = *(unsigned long *)((void *)regs + arena_reg) + off;
 		bpf_prog_report_arena_violation(is_write, addr, regs->ip);
+	} else {
+		bpf_prog_report_probe_violation(is_write, regs->ip);
 	}
 
 	/* jump over faulting load and clear dest register */
-- 
2.51.0


