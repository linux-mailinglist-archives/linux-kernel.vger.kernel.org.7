Return-Path: <linux-kernel+bounces-769298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FD6B26C9A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF49F5620E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9309D1E4A4;
	Thu, 14 Aug 2025 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="NNDBuBEF"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52081264628
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189120; cv=none; b=Liys3X0ovAn7TBRLvDIhZbG32k+3faNYCprURaulrJBDrHQvkxCaq2vak7SLHGO71prsLmilO6L5wC1EEdDLJzSBLYrfnSEqopcwqeZefl9Y50VLw611I/apO0GOI2jdE/H7FVfbEGV0M08RpxSWLHHxIv6vI3muz0K5oaZzTq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189120; c=relaxed/simple;
	bh=9Wa5jqPAwkgeEuFRsRyS/7h6RN1g8UcKkO1sNImbBhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NYXjauEjGfN/TGw/g7TTo6aKDAnzdi5sHIkx5QdI73YEOt7fp8O+X7bePhgkLCCRFh9awwVhhxr48WaFCt/+keqJo/nsiTNwwNzE+w9RIGHtpIVbBoKICWssaehSQaoqgB4w2px1q1kf8HT7gfwjtKHAG8EpBo6NZhhhBKMYii8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=NNDBuBEF; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e8704cdc76so110047885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1755189117; x=1755793917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lTcvVfxgncNMa1Iq0eQuGoB8h78T3XfCXO2iDvh4lTw=;
        b=NNDBuBEFt1e4LDeCJ9yvW0YqjHKOvSqYgGGx1lu6vRqsJmc7wNa0SBD0M2ZDDyHqgl
         cQ3Yxf1rk6RTk8O8K1fwNmqkQ3+b4cBznnGzuobpl/0ipfEYU8mbqcbXA6K55vv4OtTc
         Ulqwrtf2sHSwm5fYQV7eOt152uAzMYTx2C6GZWp78Z5Rhs+sceOZwO//2hfLpz5qqwO3
         hfHkYJgoONBioykETUfIxB1Tqqb0vRWv5yv4jI58ImulTkifPwLNiiqq+Bqu7G81rpX+
         Dw3EJK1OI2Ggbjv2xTbdFZSbOnxATrzPf1POzAvMk5ZJYFqsV8Agj2Y0dLGV5hYP1/M0
         2ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755189117; x=1755793917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTcvVfxgncNMa1Iq0eQuGoB8h78T3XfCXO2iDvh4lTw=;
        b=m2PDa4V/JnsO6xkit7fJx0+EDgrvd/yFxIhO3FCrR122GLzTkcXGPuBlaARTgxdDal
         OYQ1InPaReWswRHMpg6Y0dpBAz7BrV0bPTlaode4mERoAZfF7jUg01h9GlcU9/pgZUQx
         2U6qtjLxz44fW5WfnxJnAsHz7jy7axtqT0fvPnJQDdzgYIDDVj90T1JHLnbikYLxDZ50
         9gALeTulH2OH1t/MTenQpChn0Xhqxr7QbIfqvLgd8KEAc/zYPypcLnPXU9A6nT5dVtPh
         sl5vuu44p/O5rq1ixWdM5ZMFREXPuNH8d+VFYH0RypD/xKnvjSj2rOPp0Ep8322G/Ld/
         ZMaw==
X-Forwarded-Encrypted: i=1; AJvYcCVcCMeY30aCp19fssRI0QcFtz7G8atVpRkY2hSI4eot0xiKAE0U3WXr8bqZDsC4vdZKcSL9yP7df/NhLiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxic4/0Fidx2dcik6OOxsN+G89BX3bM9MWGxWpsAXQhqvVWnt4I
	MPr3XjywnJKOUsFRaojIfnrgac+sjVZU1m9JLkewgZ2Zu0L3HpV14ZRXgv2KqhWYuUk=
X-Gm-Gg: ASbGncu3x3bh2Lu9EEAhEHo7dT6KM+j450qHuPRTiZDojitnnHwaRy5/0vkzhkSngW8
	CTfqiJNUVn+wofmbRaTdirGP5YSF5jGhTZW6+InToe1uqSOepbe1/PHFVMOGscaMzJWeANL4Phc
	x36nxgVx8cl7j3lYo5RQaN1ZIx2ZWWEd2yS0vmzoo95q0Xt4AqlZg5jaaYZRKwOT8WQIJoGj6LH
	+StHRihPz6Cc5fGyOHdqKZIUqm6N3aCwIfj5rq45koLViK/19/n/4pl0nQDqcPIoGnCM1sEfn+9
	pdQqLwdC1zkokGijWzlA5wLRf00buf8lT2KhT9+A4jUf2MQKf2ZBVYdOoqVnEhfogFztcQJ1Rew
	5uq2fWbzvn6/FIyr80E+F3VCX6XirUEsVfEa5vNCxnXNQubYMsyrp/s5PTjs8kxSyxvQCsYJw
X-Google-Smtp-Source: AGHT+IGbI/dL3O4lK+AB9+uWgN01ynO7vfbJIS46vI8nywFNU3aZvLm4Hh/hg2gSbWXDC4HQ7N2wKA==
X-Received: by 2002:a05:620a:4727:b0:7e8:6402:aeb4 with SMTP id af79cd13be357-7e870426c07mr560417685a.18.1755189117053;
        Thu, 14 Aug 2025 09:31:57 -0700 (PDT)
Received: from vineethrp-dev.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70af5bff7c3sm14747576d6.78.2025.08.14.09.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:31:56 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/vt-d: debugfs: fix legacy mode page table dump logic
Date: Thu, 14 Aug 2025 12:31:47 -0400
Message-ID: <20250814163153.634680-1-vineeth@bitbyteword.org>
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


