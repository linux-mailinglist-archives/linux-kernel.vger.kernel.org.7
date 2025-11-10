Return-Path: <linux-kernel+bounces-892317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F87C44D71
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3E93B0FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766B7295516;
	Mon, 10 Nov 2025 03:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdUGXTRp"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FF328A701
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762745583; cv=none; b=PEGIVPl6gWVlZxuuAYhfx1O3Bti6MA0K40RyjlwYS2pvTzOTZLaIqakXmQlWpAlItF+MotC7xMR4rMfZS+Ka5kjBL34DOmjXRW2DqxNOqnk2IoRkzJvi57S61JSqT9SSqw9m1d7L6XfWPzEOh3j26YIVxIU9qnwmW/7JN7dLC3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762745583; c=relaxed/simple;
	bh=wUyiywX8HHaEWbLEv2lmqnlnMpiUcQdXEeaTse2sVjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLX71dc3Tytm1F5wMffLqtVZ1OdEXaKSVFSnvCa1zdT8+EpKXE/t7IBWNJh6OK+x/i/QxGiWV0qBV0Xod8br7nZyFOZYti/6odkuCBWqGGJS+2W/psrFhnPOX/fbltJdox1z2MLsFyXPqNaQtGe3Y+g5ebodc6el4q2o+ggIziU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdUGXTRp; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3436a97f092so2056712a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 19:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762745581; x=1763350381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ybWNsbg/E05WgR7p5k3lqGaIc94oz7znz8JCSDp+Uo=;
        b=ZdUGXTRpC3pFdmNnKuSkPtZQ+rHg5XmEf8ygqOGLWJZFkCGPjR5/Z5HGlcYWyQoiQm
         XU/Uu40lmqaY4gTxMD7BTPW3FWd1u95cPmiKpuRUqaYG3S3LLIyjcas2rgfkU7BK5BRe
         dpqtfzjqtUQ19xzgDci+QmCBShikH3k6agDlCNgDp0vAu06e9xfbWgL2Z7AR+9hDQW0u
         6uHbqnXunVfgHolvuhprMUihHBZSVq7cUG1ZlI2k6KgjzyXXOfUxCamdbUlexVEUoyUw
         jOo+l6jBgVHwJoIheI3Js93XbgDDdPev0pKYAaOjn5/RPF2p5VGH85KH7ua39kwtUq83
         1i1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762745581; x=1763350381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2ybWNsbg/E05WgR7p5k3lqGaIc94oz7znz8JCSDp+Uo=;
        b=b78Mw6oI0RPXJ/inYiSaZshB2ZiRTa8L6LxaIQdh9raP6sjnKbiVD1XRQ+aGES3fDZ
         VjzNmIwMipwTd3wnDUYUL76ORWP9v0mc1Xp1zode+8njJax4x2dNtZESKwLUedqELAWc
         ZCsJRAs4mgWozFWCZ7Exq/a0ahHGUN2dOEDR58WaNX+XscajAXoFPH5zXPBPiuFJckGd
         FBOoQ1KH1GSQ0ocLTeAXECh5TvGctIH0ZAgooIuJXfVxfEKGewvpQQz8V0j1Cv93SJJz
         qu39zJoYQqqKL9HWOawEij/YSEC905l+kIZM9O3zcujxYOETl+Nm2yk7fM0fLj7nCjgn
         +jIg==
X-Forwarded-Encrypted: i=1; AJvYcCVJDa6mYuL5vz1JmZ3etbgDedPcClHFwGn795TD6NsdVKs3djXAGSUDI7v7nZhPCn1n0EukJy3OzHX+UWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcRfcxINBx+fABCPSCJnH6UnETTBrU3CgVpMwngftdOO3Howa8
	9Zv0+3/4VBb4Zau4TNuIhEhTPmRaFcg/7MC+XYyJm57flFLMQWZMYwMZ
X-Gm-Gg: ASbGncutxYKq/3J2zJ9sbQeKiXvZQQIPKnOOab7OZYEAidm2ObktmsgslwGHKDIUR+3
	8OFfsUvR2aLRLEqCn9j80D1W+4otIAgwAVDdYqYPpOdxAglDXfbWPlxweTlv/9xuaELKR0vsSes
	AByG8WOmRg5AICFuMSEogpSrcgN04jS2JMOjvDezXD4UgzVmsyuiN8keLDHo+Wf/GSQSMcY3VYu
	ZPPcdGOP85LQEIcC5Vx1C3wGZtegXi6otA8mb/EbiiehPWRstB37JGjId3r6Pkx63ooNrDCHEiL
	EiMkARxZAlYSDu1Q3wPz6pHtlbiX+xAwirmVuFNI2HeRPava2B8WlQnjIwPgP5InTmlMkI1wUz5
	PmGl1ZgLrUqJUyo9cbivfmOvnYZlCReFgewNYAoigPdfGutsqAbXuLaj/KTDxs0swUC5cTN0jrg
	==
X-Google-Smtp-Source: AGHT+IGB0ChoFCeyPh389xbUK5wIixXaUmpWEyfozp174FCz0qkbFk4vEPQ2Z/4r106b3OFiDjFdOg==
X-Received: by 2002:a17:90b:270a:b0:340:ff89:8b62 with SMTP id 98e67ed59e1d1-3436cbb4076mr8133343a91.21.1762745581630;
        Sun, 09 Nov 2025 19:33:01 -0800 (PST)
Received: from wanpengli.. ([124.93.80.37])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-ba900fa571esm10913877a12.26.2025.11.09.19.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 19:33:01 -0800 (PST)
From: Wanpeng Li <kernellwp@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	Wanpeng Li <wanpengli@tencent.com>
Subject: [PATCH 06/10] KVM: Fix last_boosted_vcpu index assignment bug
Date: Mon, 10 Nov 2025 11:32:27 +0800
Message-ID: <20251110033232.12538-7-kernellwp@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110033232.12538-1-kernellwp@gmail.com>
References: <20251110033232.12538-1-kernellwp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wanpeng Li <wanpengli@tencent.com>

From: Wanpeng Li <wanpengli@tencent.com>

In kvm_vcpu_on_spin(), the loop counter 'i' is incorrectly written to
last_boosted_vcpu instead of the actual vCPU index 'idx'. This causes
last_boosted_vcpu to store the loop iteration count rather than the
vCPU index, leading to incorrect round-robin behavior in subsequent
directed yield operations.

Fix this by using 'idx' instead of 'i' in the assignment.

Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b7a0ae2a7b20..cde1eddbaa91 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4026,7 +4026,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 
 		yielded = kvm_vcpu_yield_to(vcpu);
 		if (yielded > 0) {
-			WRITE_ONCE(kvm->last_boosted_vcpu, i);
+			WRITE_ONCE(kvm->last_boosted_vcpu, idx);
 			break;
 		} else if (yielded < 0 && !--try) {
 			break;
-- 
2.43.0


