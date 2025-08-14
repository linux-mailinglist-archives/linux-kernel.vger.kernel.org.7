Return-Path: <linux-kernel+bounces-769296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B86C1B26C92
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B8A1C842CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3082D6417;
	Thu, 14 Aug 2025 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="mpLLMizn"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96087266574
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189040; cv=none; b=R+virAlf/i8Xu+usQgbfGsN4HsZfbHmib4xpyyAlOxG/UT4xfRCz5KvPJkk4suRg5HH4MjXFMqbct04utQ1SKnEb4mNJ13SN9aoBEui/lOkmE62gsK/m9/+A3yaLHWdSyp62PdxqN9NkvbGepwxNSKSWKPoRvS1UfTenflrsYWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189040; c=relaxed/simple;
	bh=9Wa5jqPAwkgeEuFRsRyS/7h6RN1g8UcKkO1sNImbBhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CW517vyYziq+UiTCpeWPrYLzs6vTc/HUo0d5P0UfCSud3lktY3z9Rl7coI8cb/+1a4TZhbXCywvvArxdTdZD3vH1Rh7L6Gf1eeMhdxhap0otNFPcvidZZTG/cJFX5h5fYsbDe+nZABoBqktxG4BatPoSBX2WHJGbz9Fip9f2xkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=mpLLMizn; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e8704cdc76so109885485a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1755189037; x=1755793837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lTcvVfxgncNMa1Iq0eQuGoB8h78T3XfCXO2iDvh4lTw=;
        b=mpLLMiznQBU3O/5Nr3Tb36BKD1baNzneFIjsghUNYeuuiYYaxnShG5I+I7fMNcV1Ev
         qD+rz9PPKwXaAOR7pGTmUNwy5r/5yse4IXD4F74FNqLGUw3+7vKWt513shpWVEE/q+Ka
         xytJjP/3sFM4kMjINob7vNkLjKZsAcZOV7hQcCv6l7GHbnDm1ZY41a7a078xV/5WtIeo
         Si1yY72lerN7LYWb53i+ptH5KXru69ia/qbxbmlWWbPrLo74Sw0kskKUPnHI23+XZUEq
         AurAjAwlHuqXeryUkHrHN6sFIEV1yvij8LAPNTlvhhCyVwihZ8ogz/u1XfdztDUC92CE
         49EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755189037; x=1755793837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTcvVfxgncNMa1Iq0eQuGoB8h78T3XfCXO2iDvh4lTw=;
        b=DgYaNGbvrzvA6EQXsWPUuwDdKiQVd3JpedTzoLowCcP4mAud/C3gUIQJpx4gEvRHba
         69UpRMKctv03qCuWGi50RDf2HJq1JqfPbZ1+aXjm8+nWXdUZqnhUI1HSYXa/evFsAWRD
         6Kx2BO5HSDDbHjTCBgLjMjQc/eMlCQKxIGhmbi+hFRhNzEGSdhHKpTbWVA6R/XtjuKxP
         yM0po2McWW8LzETyrgWVFEsex4RRNuhiCAQVEB92BUquKpXG19hGcR+Ok0Dz5UbtBFgE
         /3Swyv7IP/SFhtwBdLdrIFWurywH9yTgHW8jswn7N8/cPSJk32drjCF6/hSW29xXh1+5
         5VKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs5Xm7lXI4fngu7pHgl7ERM6isBNrkRCYWzJCKcO500EzzJfs33NLfV7Xi0tekv5ceB/jkLF5iaqUMB74=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTsrUDpFnJzLLKLsm9tcgS7g7JRv77eGGqF9iWqsRRNsVC/tx5
	rwyqoIJ4upf1cdbkmuWy3gA+U67VIlqv7i5wK5zzKeXec1L7HaCNy73qhjJ5vjvQY+0=
X-Gm-Gg: ASbGnctKwX0233godD1q2L3Ja+ZPY/Hv3vXLyDZMHVnCnkNdAV6vsCFU26HgCNAEVWL
	9OOB8dM79OzALFlrZo+DlS0vld1apTYRB+OhWbMc039y4og5AWlWY+y/EkdvErOXXewbjLeFqUk
	knfRpr3Ybm7I/lmJB9ZE6UxWJlox1RxMaZ5oOcu9G+8n22MUdHTN0U6NIH8Tn2exYsYGLa0905B
	Ixl7J34Ux68r5QdIKkkBj2/AGR+Q0v+mmXKSlQGOz3AhjdrarNhevFkjdrGnnSEvJIl1k0OWQSw
	ONXULkS1bKgKhP5E4spE0oKaYdCnv//6ofhKVn6pFybyQ9WTLZbK4JIXdCLutDTkG07FXY/cPFw
	8WMonAyBGxNhApgdezXmMHEIg4dWbChMwlXbEHjjQFpxtFXx0cXiKo0MFO71vgpuNT/F0Nha8mW
	raOQZT420=
X-Google-Smtp-Source: AGHT+IE875VpR9LBaN9clxrcxJ3h9zgxKT9RUmPEPlW6JReinUjgAiko9WQ+nb3Q/3zGXUMFYHDA6Q==
X-Received: by 2002:a05:620a:3910:b0:7e8:6d58:b4b6 with SMTP id af79cd13be357-7e8703c8783mr622951485a.11.1755189037156;
        Thu, 14 Aug 2025 09:30:37 -0700 (PDT)
Received: from vineethrp-dev.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e83075ffa6sm1131637085a.4.2025.08.14.09.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:30:36 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/vt-d: debugfs: fix legacy mode page table dump logic
Date: Thu, 14 Aug 2025 12:30:24 -0400
Message-ID: <20250814163026.634182-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.51.0.rc0.215.g125493bb4a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In legacy mode, SSPTPTR is ignored if TT is not 00b or 01b. SSPTPTR
maybe uninitialized or zero in that case and may cause oops like:

 Oops: general protection fault, probably for non-canonical address 0xf00087d3f000f000: 0000 [#1] SMP NOPTI
 CPU: 2 UID: 0 PID: 786 Comm: cat Not tainted 6.16.0 #191 PREEMPT(voluntary)
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-5.fc42 04/01/2014
 RIP: 0010:pgtable_walk_level+0x98/0x150
 RSP: 0018:ffffc90000f279c0 EFLAGS: 00010206
 RAX: 0000000040000000 RBX: ffffc90000f27ab0 RCX: 000000000000001e
 RDX: 0000000000000003 RSI: f00087d3f000f000 RDI: f00087d3f0010000
 RBP: ffffc90000f27a00 R08: ffffc90000f27a98 R09: 0000000000000002
 R10: 0000000000000000 R11: 0000000000000000 R12: f00087d3f000f000
 R13: 0000000000000000 R14: 0000000040000000 R15: ffffc90000f27a98
 FS:  0000764566dcb740(0000) GS:ffff8881f812c000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000764566d44000 CR3: 0000000109d81003 CR4: 0000000000772ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  pgtable_walk_level+0x88/0x150
  domain_translation_struct_show.isra.0+0x2d9/0x300
  dev_domain_translation_struct_show+0x20/0x40
  seq_read_iter+0x12d/0x490
...

Avoid walking the page table if TT is not 00b or 01b.

Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 drivers/iommu/intel/debugfs.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index affbf4a1558de..5aa7f46a420b5 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -435,8 +435,21 @@ static int domain_translation_struct_show(struct seq_file *m,
 			}
 			pgd &= VTD_PAGE_MASK;
 		} else { /* legacy mode */
-			pgd = context->lo & VTD_PAGE_MASK;
-			agaw = context->hi & 7;
+			u8 tt = (u8)(context->lo & GENMASK_ULL(3, 2)) >> 2;
+
+			/*
+			 * According to Translation Type(TT),
+			 * get the page table pointer(SSPTPTR).
+			 */
+			switch (tt) {
+			case CONTEXT_TT_MULTI_LEVEL:
+			case CONTEXT_TT_DEV_IOTLB:
+				pgd = context->lo & VTD_PAGE_MASK;
+				agaw = context->hi & 7;
+				break;
+			default:
+				goto iommu_unlock;
+			}
 		}
 
 		seq_printf(m, "Device %04x:%02x:%02x.%x ",
-- 
2.50.1


