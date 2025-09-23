Return-Path: <linux-kernel+bounces-829243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C47DB9698A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7BA9323301
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA73260592;
	Tue, 23 Sep 2025 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="k0apYubt"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D556419B5B1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641513; cv=none; b=AonWSz86xOXlX/vGI5ss/wIEb6x/q+T75BAJ+HY1GedmVUD7UmneQz0SDUbjmfSjT8jdkUwiwLPAlfcRlNZH+zwdvwnXH9gwX/ZYOZ8ElyUnv7cafKQECo4e88LppA0DsfZ9dXKl55y/3DDU5K4sWNGzbKOJ91yVN1rFSM+G5zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641513; c=relaxed/simple;
	bh=3HNjt6CULz+cHwwdKVVXN2sfulSDWOqQIOjqdL72tRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mqAB0Ewmby93qlALDZZXhQGOxz7Akl2HvPTj0OqE4ICJeimXqWFgbwHkJ+3+CIT6dR06OWNIttX1XyLwWz4q2lkxeWy9JrCoY9ucm6AH7V/mYzhDyZphDAWeQ4z+CPDEI0Cq5Vgn2zYCILPWcrXJi8ksdAnojlIFEwKQDesEWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=k0apYubt; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-826fe3b3e2cso576642585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758641510; x=1759246310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2agHPfPZaTgXNBUU2YV+2DvStIzk8xrRXE1APYdnik=;
        b=k0apYubteyyMN0Zpf3m3PDZs/DmDyQzBORe7ena6vR2PjqQWDL2OF8HwkFnaPaQTE4
         fxmgpk7Z5Mq1+hbLj0TUT8HayiTp6MWqXzqZVtaLH6y+2/7S03Ljwy1ibNTM7hGPg551
         hn1tNyWWu18PXl32rE+oc1RwECjnJb/wgEPyhIkfjH9DTiZpZ4U77Bisrdwb4MqjEQFI
         dR1NfqBFxrHJ31FDmtX/2/puyXpNmDa7Cbne6nHDQkRDgNK5h3BAuv7+2gAO1PxNbw2i
         jv1xajk1efhkMPjZ/SVL885vuiTRxVMXzJhN+1oJtMbzGB/rBkad6SVDjfm+EG9uufyf
         cZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641510; x=1759246310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2agHPfPZaTgXNBUU2YV+2DvStIzk8xrRXE1APYdnik=;
        b=pgVYDC9FDv/9JBK7ZZqA45Ovdy3hmK664WN6Hu4HztSFtfHQBZVahklAgXMrxbrZYS
         CrPnIce3VUGrYpzm9q8aA5+VfLLuEyrgRl3i3HQHuvalwWTuGvV+sP/HLGLJPcyM0MU1
         sXu6xbntJnjq1gx3noEfpJ0V6lYv7HOwIT1EfKMbrWoSDGBO/cgBU2NnuuMwlaIzbHI3
         yqaG6HLbaHodCqWCC/MZkgJcY2luREvEAiYyrRLPr/ipevXdi9XqyPUTu/dCqahPkqT/
         FngvtIbixUxtjzG8mdZYhpoZ1MGV0BYb+9cKmSrspqn+hEaZFY9ePkgI4iEq6XpPY8oC
         RUJg==
X-Gm-Message-State: AOJu0YyCa4OX3RnSfubexNUmgMyueEjmcL1oiNmUpF+suf8P/juZU/2r
	CaLnXejyeoOI3yKkOVCNOIYVYh9Jm6IS4HmfCADY0w1UNtBclXlbmlNfbPSoI9AdDK274Z8ym4z
	2khv6vZ0=
X-Gm-Gg: ASbGncugCECBOlyEWubI/rgmRTVP5Tr3Bu1DO+to+J/00LhFcuIhFYFzE9J+O4+UOz2
	az6J6sToGRbWV70XNVXukXitkkN3tOM7t46xbsx06ZU4VmZZk4Hh1PT2tnUhxl5BKgnhqkgWFSe
	Snaqe4efyG/LDC8noYMcCxmqcoHf16rCDtScPlptYGkNMkQ17av3gkAilyvV5+Q3+SPSjk+qlgI
	ErLtj27RC6x7v4+1PlizrNZZ6l5QbtaHXf6TPhWX8q4yiRr0tKG1ZnKfzBd9JRsIPN0CuYshNuA
	JbrY6JyfiLFR7liMP/zOunFBVrrweVN4WEi7IXFh04wmmRAu+JhDon8r3GijevgoXRvGbZgucQT
	joZM6Q+ws15eYMfoSpJcdY8KW0LfziA==
X-Google-Smtp-Source: AGHT+IFBiermbVc+NGaH2KSDAIb6LQ20HaNdZFOLB6++JaSogyaGxikiQGxrCvgpFfH2xruK1FwEgg==
X-Received: by 2002:a05:620a:bcd:b0:848:81e5:446e with SMTP id af79cd13be357-8517279f40amr323834685a.72.1758641510121;
        Tue, 23 Sep 2025 08:31:50 -0700 (PDT)
Received: from localhost ([79.173.157.19])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84abe9c219asm365942385a.20.2025.09.23.08.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:31:49 -0700 (PDT)
From: Fam Zheng <fam.zheng@bytedance.com>
To: linux-kernel@vger.kernel.org
Cc: Lukasz Luba <lukasz.luba@arm.com>,
	linyongting@bytedance.com,
	songmuchun@bytedance.com,
	satish.kumar@bytedance.com,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	yuanzhu@bytedance.com,
	Ingo Molnar <mingo@redhat.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	fam.zheng@bytedance.com,
	Zhang Rui <rui.zhang@intel.com>,
	fam@euphon.net,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	liangma@bytedance.com,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	guojinhui.liam@bytedance.com,
	linux-pm@vger.kernel.org,
	Thom Hughes <thom.hughes@bytedance.com>
Subject: [RFC 1/5] x86/boot/e820: Fix memmap to parse with 1 argument
Date: Tue, 23 Sep 2025 15:31:42 +0000
Message-Id: <20250923153146.365015-2-fam.zheng@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250923153146.365015-1-fam.zheng@bytedance.com>
References: <20250923153146.365015-1-fam.zheng@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thom Hughes <thom.hughes@bytedance.com>

This is needed because in the simplest case, parker Application Kernel
only gets one user e820 entry from memmap.

Signed-off-by: Thom Hughes <thom.hughes@bytedance.com>
Signed-off-by: Fam Zheng <fam.zheng@bytedance.com>
---
 arch/x86/kernel/e820.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 84264205dae5..05dfb192d4b9 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -330,7 +330,7 @@ int __init e820__update_table(struct e820_table *table)
 
 	/* If there's only one memory region, don't bother: */
 	if (table->nr_entries < 2)
-		return -1;
+		return 0;
 
 	BUG_ON(table->nr_entries > max_nr_entries);
 
-- 
2.39.5


