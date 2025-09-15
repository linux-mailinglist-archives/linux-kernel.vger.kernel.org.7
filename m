Return-Path: <linux-kernel+bounces-817727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32327B585B3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F604814AA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6DD28BAB9;
	Mon, 15 Sep 2025 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvYzKB9s"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C430E285CB5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757966827; cv=none; b=bswqTOqb0qUM+dOY3tpTmpesvU5W82qOMO6BSe44x8z6u/XV5aw87Oz6QQyiFkLoG+O5rSKQjDF7k3NKEPx2e8HV5gx7n64aZ6Kcb/whCZ2d/PrfZKjC10z6AZpGBehU5J+WSzv3mfoXEtVS3y92TYjgXi7R/ZU24VldvLn0gDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757966827; c=relaxed/simple;
	bh=Bp374DX/U/aWjXzAxxMNXNdVpAbYUiHoMWgNCmnD4nM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sh0IJSsZScT6mrI4uckiGEtwLTCDrRzv5ksw2PUkeYg22A2zdtSIvS4KxX+cepoKuZctyNpszINZKCmmboZenwJ1OAQ8AVnd4LVE8qXG0ig2Q4OWpC8FWA6fPr+y+j3+KPpmAG61zp/jgaaOXXoDqknWdFa++QiGKVnoq9d5ZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvYzKB9s; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45dfb8e986aso47990895e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757966824; x=1758571624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iMaZelnv0gjVtGPE0leSvjV6B/t1yvdFRKvRCI36mmU=;
        b=ZvYzKB9sQNTz9TdlkWrIxo5IfNWq6setJckZpLZ6bOnpLJz/kASNi+ZaZeAC/MoRdQ
         y87zgSB3hGCCwvpR5uBBOJD6GgyZybuyeJNXNDW+5fSzAVWVULGiGCqP3uHgnvyS74S4
         J7FK0r6zURWaXgtkzfoV7kXyYYUit9H5tVH8LenWDQ5VtfoPdu8Z/Z2+PNJMMVbou3I2
         FQtGzYvE9j+0xMOKTRT9W2kEfiUFWbJLsiuf9iMnvmlZFVTU13NCz6rWuaMMBaGbfT6G
         /ChDkqNVpG/q17WOI7y7qaov4FQSBy+KQLHyeDpgA6CJ/3WHG7OQbxYndFWXO9arpz2b
         Jt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757966824; x=1758571624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMaZelnv0gjVtGPE0leSvjV6B/t1yvdFRKvRCI36mmU=;
        b=kxQLe3BHIUhNhFijKBzW96BYjKENFcJSHmN8dOcbDWmlPrQKMxXiSh8eIjfY0Ama7L
         M3XhnTP7bLhgnUszfmXE3WJC9W4cE36VcomWGceBLQponFb7Y9rMYt0LbnTyOGfI1SgV
         79+6dWYyrextqn4zg8szUn4ltqKomUr/zkzpLXTBIBPPYwi68pNYuQDGAAhssp2aAGOO
         LF055FvSnvZHJr/N3A374C5GmkRUYH5Fs9IfEuYgb+FfkVRQLxQSbxrQno13cQeioUMN
         nMXBN4DulJy96K329pwTB0nu8EreuEDsG1H4+Af0G7p3ZmPHK5dkKPGMQxS00d6+z0Gu
         PdAw==
X-Gm-Message-State: AOJu0YxqjMlbv0LxYFOhKSD7uSS8ZlduEDSkRXkS66vC2gZlqJvVC0wA
	naOO9nWX0I0Il8tLLlWs/x1tCuP0bvtPdQTqGwwnMBRKP3V/xRVW48eS
X-Gm-Gg: ASbGncvHBvNJb1hs5a29NOYTaCYhptZkGiN9hcN3gVG72q8S5xSaj1jK8BCan8P40O9
	8KzJHcjnPBEKZoHdVptAl0UtN1mKY8PcK58zsB6T+Uj7SHpNzY5Bz23vIATwkdVU7Eyif452ztx
	RNoXLvT/IRG9qrFm/s/qOVgVCwkHfFN4vN2Gd0hZF9uBSNfdHLXznPX4tNOaDv5SmbNFL7r06hq
	FjavFB5v8jbxGmB48Iil+/5yTIhMtxvq+ETR6od7ZlZCMHfLnBfAP9efG1lDvYrHpfr+VRKntfu
	cCTylhGbFPoaDx7UyGEqAVTEFN9CNpFhU8zIFvRFT94zVzVBQR10ghwLT2JCdm3WI2sQ1IIujH/
	jTeYURt/Lx5bG/D55sWL7S8coQl3ZlwmhhjUT17uVSSc=
X-Google-Smtp-Source: AGHT+IE6RC6QQj4xdst05r+LwYKAnJLbln/3bNeokossDxipclPSYD8h8fJvmCXid878uJsfA1X5Mw==
X-Received: by 2002:a05:600c:2251:b0:45d:f7e4:88b4 with SMTP id 5b1f17b1804b1-45f211fee13mr110158435e9.30.1757966823772;
        Mon, 15 Sep 2025 13:07:03 -0700 (PDT)
Received: from localhost.localdomain ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32114c62sm2840745e9.2.2025.09.15.13.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 13:07:03 -0700 (PDT)
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mikisabate@gmail.com>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	alex@ghiti.fr,
	wangyuli@uniontech.com,
	chenhuacai@kernel.org,
	mikisabate@gmail.com
Subject: [PATCH] riscv: kgdb: Prefer strscpy instead of strcpy
Date: Mon, 15 Sep 2025 22:06:44 +0200
Message-ID: <20250915200644.200498-1-mikisabate@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As pointed out in [1], strcpy() is deprecated in favor of strscpy().

[1] KSPP#88

Signed-off-by: Miquel Sabaté Solà <mikisabate@gmail.com>
---
 arch/riscv/kernel/kgdb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/kgdb.c b/arch/riscv/kernel/kgdb.c
index 9f3db3503dab..945f82a72954 100644
--- a/arch/riscv/kernel/kgdb.c
+++ b/arch/riscv/kernel/kgdb.c
@@ -265,10 +265,10 @@ void kgdb_arch_handle_qxfer_pkt(char *remcom_in_buffer,
 {
 	if (!strncmp(remcom_in_buffer, gdb_xfer_read_target,
 		     sizeof(gdb_xfer_read_target)))
-		strcpy(remcom_out_buffer, riscv_gdb_stub_target_desc);
+		strscpy(remcom_out_buffer, riscv_gdb_stub_target_desc);
 	else if (!strncmp(remcom_in_buffer, gdb_xfer_read_cpuxml,
 			  sizeof(gdb_xfer_read_cpuxml)))
-		strcpy(remcom_out_buffer, riscv_gdb_stub_cpuxml);
+		strscpy(remcom_out_buffer, riscv_gdb_stub_cpuxml);
 }
 
 static inline void kgdb_arch_update_addr(struct pt_regs *regs,
-- 
2.51.0


