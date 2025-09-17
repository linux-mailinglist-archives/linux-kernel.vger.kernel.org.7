Return-Path: <linux-kernel+bounces-820343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9424CB7C416
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA20B4644EE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845FE309EFE;
	Wed, 17 Sep 2025 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="sdvs0fDL"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7518534A305
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101328; cv=none; b=bKJnvz6EOQ89GpsUYeobVaicu+6rAjIO6YZxzTdwOA6SQTZRBQFFo3yZA0L7Rv4omJzw1ha/f5YScPIFdepkPu6swBWrXOxnAZm+xSLGovhoRcuIhVrBY7UZaDEdfk33CD5tai3v6NvE0+XkohYTgERuX7zFcT+4p4c1IxY9v24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101328; c=relaxed/simple;
	bh=HomK9oR9q6PgZ6KTjkrL0ZAF4ixtQM3rr4sUa8Fd5OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrOxLk282tkWn5LAWaEilyOd83Gqbacld0sTXr5aezRFgLDqr9URJJvkQ0b23fBKPME761rckndJNbIwZgY+stM6MHc1YT+4b+r5XeotE2iA9idMz2OzDJt2JW+bsnlkuQBHEgfe+uALiMfgb2S4vNcubGyDPXs6QWCXtTCEdqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=sdvs0fDL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-268107d8662so4608405ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1758101326; x=1758706126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/CvHxpYU6aT1JADHVD5nQ98mr1UgBNDG9QHGX5cLNQ=;
        b=sdvs0fDL+fmQRx4+XxxE3b9aXLyW1htEcXlyoM4Svot1JDLnZ8KzEZtzMP2j+A9KcH
         zew8ka7Cjiz6f0OmchCUAkBj5M+uIih4NnBIoqI40FgAxqsZF5KUA8qZ2/Hg1EP71/2v
         CGHZQzRGTCAJpXN1Clg7ughI6mIQaOLD654LBR1z7pi/ztn3w/aPS5dPRcIfsmpyNyf4
         c09stCP4lu9iS2noUc+WBr6FB18ftTE7jph3cCsja3wyoAba4qk7tA8EvgNQnbJJBtKo
         I2Y+a860saPGnJXwO3agqwwfbdaRjDbWl2De2o29Fc5ePUiLwO1UM2UBguKZIOHcLlI8
         MW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758101326; x=1758706126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/CvHxpYU6aT1JADHVD5nQ98mr1UgBNDG9QHGX5cLNQ=;
        b=tuAViu0++caZTdZ8azZlMadS6sYsksYwKwL3jgcyfrDUh7W9X84okL0ef5PlmUcYdb
         vzc/6ByP81buRyCP7bM62Q7P/njdP/KWWs6vV12BqNDl3FgGq+mpgrSi/uu3yWFtqJcD
         wwtPB9hLXEKyzZab5wuuOdbvtYti594WP6N6mE+NzpPU2wxpME6CNiiyBPbXdnZfh0/w
         iQ8g48k/MhlCI0NJ6j3uquOuepJIe4AXqZiH6e8Q3+55ayxqxCFAGVHKuUNYq8El72WA
         DSHKPfLDlFtbEDHmMQyGwh0Bz4Mkab8cs5ukInNNJ6zDbartvsTLXQQ6p2vzVir2r8vj
         hVXw==
X-Forwarded-Encrypted: i=1; AJvYcCU7vGhxk6ySmGIlrfFnfRFlmBjxR8HUrQArQ/thc9GN7zRvie9nlNVGRLcTd2/JqWraBN4nv91pQ/VPPHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIjfmCzjn/GelOWwLPVUHFuqfccEztjT12szsL37Kvmm+KpsM4
	UX90ydj7psbVvts/msAQJafHDYn+YlDNr7N2iiYZT2NeDQEtNAEs6xhuzyI0+YYLwINllNoQW67
	duLWbKgJOxg==
X-Gm-Gg: ASbGncvp2ozNvryYpLJM/+Rpk5dh/4e5Mkts8gZPB9+0kjIQlIbf0ogibADzDCnaI+e
	Yh1oBwjMPcC9cHQ6v/CqlJQaBFIDA7kI3NRYW11ZDcvqDi7UUxx4/9Kvt+Ib0lF3mLHPeNQ3Paq
	IjmwwmivNofiMmXiiGASdsSFig8n2HCYxT0aLZ+4ca4SKWZCHA7qjovH2vHLJubDWYkSVKu+vUL
	aHlIgZpiil2/RDqbRloZzFiGnuU5jgiLgxOhY6ReWMHbvLNrc2XDoFDxW+WGKr0TavWA2970WHI
	Uwe0081ILkkLEELUZMIh/602SHgCuMeO6woHIbBwilv6/QMtwG1qnQ8kPpz1XUnlV0e6IWV5tNz
	ZXmucv1dHcnDCjD35N7fx9W45aWxSxm77vF0Kx+2MuwGLVSC+EF0=
X-Google-Smtp-Source: AGHT+IFh/uBlLQN+Z64/3NY4nlJ9THrCXhkwHJPZh1q+BGnbJDaVlEFVI0umfFifgHpYECE5AHRbLA==
X-Received: by 2002:a17:903:1b2e:b0:24b:270e:56c7 with SMTP id d9443c01a7336-268119b2a8fmr20448045ad.7.1758101325500;
        Wed, 17 Sep 2025 02:28:45 -0700 (PDT)
Received: from localhost.localdomain ([193.246.161.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25f4935db09sm137047885ad.61.2025.09.17.02.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:28:45 -0700 (PDT)
From: Lei Chen <lei.chen@smartx.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v1 3/3] KVM: x86: remove comment about ntp correction sync for
Date: Wed, 17 Sep 2025 17:28:24 +0800
Message-ID: <20250917092824.4070217-4-lei.chen@smartx.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250917092824.4070217-1-lei.chen@smartx.com>
References: <20250917092824.4070217-1-lei.chen@smartx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since vcpu local clock is no longer affected by ntp,
remove comment about ntp correction sync for function
kvm_gen_kvmclock_update.

Signed-off-by: Lei Chen <lei.chen@smartx.com>
---
 arch/x86/kvm/x86.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d526e9e285f1..f85611f59218 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3399,9 +3399,7 @@ uint64_t kvm_get_wall_clock_epoch(struct kvm *kvm)
 /*
  * kvmclock updates which are isolated to a given vcpu, such as
  * vcpu->cpu migration, should not allow system_timestamp from
- * the rest of the vcpus to remain static. Otherwise ntp frequency
- * correction applies to one vcpu's system_timestamp but not
- * the others.
+ * the rest of the vcpus to remain static.
  *
  * So in those cases, request a kvmclock update for all vcpus.
  * The worst case for a remote vcpu to update its kvmclock
-- 
2.44.0


