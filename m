Return-Path: <linux-kernel+bounces-829247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E13B969A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1382418A6E8F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F93E273809;
	Tue, 23 Sep 2025 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BYWNwon6"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4AA1FF7C7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641524; cv=none; b=D51hW6rarKayBKdoboTN/7sY7pOWKfFbKpjzFVb9JGKJDRX7iPSzf3KN+Q95zHvgrQjvjGQTIewZuySifCz7KmK7k/UsVf7KNBaS0ChzuXydbf4N9dKE8TC6JCX0VfHzZMJ6dGdJLqHLIMK43kd1/mJO1+0tEaS/VU6ryKadJ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641524; c=relaxed/simple;
	bh=1YwZpHexCtqP9eAf1fTZ1LlVtJXXtxJcq5y9B0el7Vs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bwQTGWlnxvxl9eHQVrghPIU8LAg/A53VuXPi2VpKRH+ONJqcTbLFf6AGvjVlkil+9E4Q19zDzmK9TjycqdZaX534YiWi0W4w/vtXMgZCbc6gwRdLJ6Us47hZ3vuX9aRoYwciwneQj4WdZGw4vAqiIKRIDaMjVp6iAXF29TLyGlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BYWNwon6; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-796d68804a0so55832796d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758641521; x=1759246321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST/TiPE3UoG2aOPw0mJW/QZGPve3OqLp6tKuBIFjGhc=;
        b=BYWNwon6jAWJfaFUXukhsjTj/U055EoAAsEkT79ezCrnhy/urtfvlMapmatUiYti1B
         8jT8GZEot1DN1BroiiRe6beQcok16LWQVu4CtVoEGTJcrwW/lBc9grn4SZ9kdyP54LqV
         aebDVOQJ6FNc/8kn6Pb3M4lbuTLiInl0CbWiSZYxLFz/ziPkKpa9YX449DrURMynGvfc
         tz+Yv1FWC5WFzok1s1tQ1Cq/BosX4YacmL9HK8S7hMKy3tLCaoSv36W8KVTBdXPThfnQ
         7kwejeaT3QAjVekKSVAS4ziyzoeOnwNBedebuXKMzvQF7jah9O/1yKIVktXgvEz5i4aE
         X60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641521; x=1759246321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ST/TiPE3UoG2aOPw0mJW/QZGPve3OqLp6tKuBIFjGhc=;
        b=b5Y5/2cHD3D1qnLQNpitqdIUtHLXdZxAdYP63HBcUD3cyYhNTOaR8afYDGSvvdmfpH
         DfZJrTA2vvbFMY1bUCePSOEeyT5ax4786nLBRWDeuX25o7/ILIW91VntYzOUoH/B7lBe
         K8/sw3sk3pcB1s35uqaLVk9ontwQJa3fQ8iLgD17mxcPsuAqJr7bEDKrHaNv9IXqp+cG
         QtanWjMk9nP/0wtjqPYaEO5xKVJ//PIVKyhF5R6Ad9dyLsd3NrneTTk8Y81S8ZRrMwPs
         lIvGANdUgiZeOM1gwy4wyKN3YbSHpuEB2toDq69rJ3HNEbhlKPNn0wiHCS3DfrBtvYcc
         PJoA==
X-Gm-Message-State: AOJu0YyTLuKHzsed2b6Ni0nfCrpaFGj7tnDx7YuQUheRbjFJiRqbQZL3
	1i48i9K/PjK6SaYmyeRdGDfem37qTkFh9GHr0gXG4Sk+M8kHPUUCX98EQIxVpThO698gMymuKh8
	Obcp9EWc=
X-Gm-Gg: ASbGncsTy4EW2IlylxwVOuu7XgVkVvXbjL2/gmbDgaL7Uo2jQTPl3hB02l93sbR1ypN
	6qleI3Wo7ZN+MP20ehHToANk/zZEgW4dMyIf0vFXcQSMpjlzlo86vJbRyzySU+BDzchKvt/k9f5
	uczqSIRdCOHWIJ6Y0INQkVrBYvsBvMYu005YoRoIwbmAQnEhdzo2lb6HAuJtbMdRO3ooaCnYPG0
	E2Wq+8R4FEfTtoP+lVhW+2qSlmX+Lc95C7sLI8yIpmZOnAuCT25n0fYP3g56yRp/3XaJ23cArRe
	ohoEoUJ/N2lytlH1EoOzaZaK4eFnjC7HTYsPGG4S6Of1p3DDV6S91QFZmgWAfsWOk7orkr7cgIc
	HY48ZfAtb5KnXX+AI+8dC+HWC9VM2Ew==
X-Google-Smtp-Source: AGHT+IEvanVRKTjJIXXUzM6LDTiGRKMr5d0J8UNTnUv1MjeOEx7kiAqkICaVyGwRNy1LTn6CuXzPng==
X-Received: by 2002:a05:6214:202e:b0:791:c933:ad45 with SMTP id 6a1803df08f44-7e7145081f1mr33486566d6.37.1758641520758;
        Tue, 23 Sep 2025 08:32:00 -0700 (PDT)
Received: from localhost ([79.173.157.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7b6a2fa0c5esm50177486d6.66.2025.09.23.08.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:32:00 -0700 (PDT)
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
Subject: [RFC 5/5] x86/apic: Make Parker instance use physical APIC
Date: Tue, 23 Sep 2025 15:31:46 +0000
Message-Id: <20250923153146.365015-6-fam.zheng@bytedance.com>
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

Signed-off-by: Thom Hughes <thom.hughes@bytedance.com>
Signed-off-by: Fam Zheng <fam.zheng@bytedance.com>
---
 arch/x86/kernel/apic/apic_flat_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index e0308d8c4e6c..e753125a1de8 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -9,6 +9,7 @@
  * James Cleverdon.
  */
 #include <linux/export.h>
+#include <linux/parker.h>
 
 #include <asm/apic.h>
 
@@ -21,7 +22,7 @@ static u32 physflat_get_apic_id(u32 x)
 
 static int physflat_probe(void)
 {
-	return 1;
+	return is_parker_instance();
 }
 
 static int physflat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
-- 
2.39.5


