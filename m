Return-Path: <linux-kernel+bounces-823843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C66B878DE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2333B7B93E4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6989225A623;
	Fri, 19 Sep 2025 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QNaMHQKw"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50901258CCC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758243607; cv=none; b=rhBw2qZDp/LcyKl4Z9/YR9pp4VTwczz8ri7b+NshxYSgfKu7H7JKaCefXky3jJTHGIleF7bB0bnsU06r9T6O2t6cRfLIppiPoX+DtA8NSH5np7FpFPTD4zFFzSCsDPEnakLjKUK1uK/IZGz5eL/BVwVLC4aKu2nKGPLs+30YEy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758243607; c=relaxed/simple;
	bh=LsLpFAxR2r/kYmw7xHJtCSmeqll4la2sZk2Tqpzc9oc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MEG7CvyjHtbDH8wM4i/n2+tqQaOP5q+FWD9LRtBUEDyYD8cxQY2yed6W06ZmmuxSiqtMjZFF+Y8TRInsuXtg2ryKOjrTPnHlUu5HFWmKVeILKAAPyKHv97ILNVx3Un8HbhU+kjf6wzxd1+WonvX/W9Wb4dtKFIc7f8wrUCWa51w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QNaMHQKw; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ec2211659so1547731a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758243606; x=1758848406; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2SCjX/C9Pl/3F4W6bLgbAPLvNsr2cRYsD9OSEcrvFjM=;
        b=QNaMHQKwdDRuKv/nJSRn9hSD+jnscU1OLxtt6X3XdulK6AxSPy5K4tPHsU6yftI33L
         hF1PmpzG6I0Ge2VO88F5967IljV+ImmAAkkKyWbLuBjFIY94mcSnpBt4uvQiuli+H8/X
         gW71nsR/ggpF/MvOxljHCY9UXyRs24d3QY4SgL/GRPVkWWPt023gdm8XLe+CdTR/ZIDD
         jfulmXfdkczbib+sIXXjEBc5anNOQx4trgnUX6HioO4hxfU5wvaf66TqYcy+exIeo/M9
         rdqkbWYBUbEbjhyycQmWIHiCPXrN3Cd/YuSxJIRlpksRZyU7qtGbs9KjtmQul6Ny4O7b
         PGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758243606; x=1758848406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SCjX/C9Pl/3F4W6bLgbAPLvNsr2cRYsD9OSEcrvFjM=;
        b=KCO407yvjrv+VmGsNhJte8Gd55MSurLa96oFQ8g7R5V5tmfXHhTe9+cLFleda3UYKu
         pxzew6oJdB9/68PkNdN+Kv7lDLBuHJxnuGOBF9LUKFqRlSGAzG2I+NDYlwxiN3R6PMJk
         Vpsn/B9wpozW+jLq+8NGLSafH0PiDDFQr3tYBjeGFpIPBMjO7ljYMWCXofNPdm74NNpF
         wULiNzbVeZ0Hp89SoscSrN5eSbCy32EtOY0ptwlS0WqoH+G46YKnJ/yFtVPpE51A78Uk
         imCk+acNO3S/tZ945R2i9H0LWdEixPzJ8vjeewGH+j+pkLc6o0Skx6rOkKVXlDyMwka2
         Dyng==
X-Forwarded-Encrypted: i=1; AJvYcCVYXAjdxeKrzPYcU++99av+OBdYNGI2ES9OJJp65JfYvWaXn3CgXGXi6fO05XQbjrazHtVQdL68g+VOMPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf+18DTMb7xBTHnI39n2GzN/J9/9TzQ6KbT+jc+zEsB5ZqG3SK
	mPFqLFqYhEuVcNgPrzeF5nNCCJcLecnc3gW7YALxM5UAhzSh6hYNJnEDgPryIsXGzc2cCLEuh0b
	oN/vRfg==
X-Google-Smtp-Source: AGHT+IFUBVqY6omtVwJGu2LCApfEsfDNlkWkBfC9sU/rre8XJpYtigGsjXv/+phjEKVu5Y5A7dIXEO9/TmQ=
X-Received: from pjbqi4.prod.google.com ([2002:a17:90b:2744:b0:327:50fa:eff9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e12:b0:32e:a59e:21c9
 with SMTP id 98e67ed59e1d1-33098379102mr1492674a91.26.1758243605678; Thu, 18
 Sep 2025 18:00:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Sep 2025 17:59:51 -0700
In-Reply-To: <20250919005955.1366256-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919005955.1366256-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919005955.1366256-6-seanjc@google.com>
Subject: [PATCH 5/9] KVM: nVMX: Add consistency check for TPR_THRESHOLD[31:4]!=0
 without VID
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a missing consistency check on the TPR Threshold.  Per the SDM

  If the "use TPR shadow" VM-execution control is 1 and the "virtual-
  interrupt delivery" VM-execution control is 0, bits 31:4 of the TPR
  threshold VM-execution control field must be 0.

Note, nested_vmx_check_tpr_shadow_controls() bails early if "use TPR
shadow" is 0.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 253e93ced9dc..5ac7ad207ef7 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -555,6 +555,9 @@ static int nested_vmx_check_tpr_shadow_controls(struct kvm_vcpu *vcpu,
 	if (CC(!page_address_valid(vcpu, vmcs12->virtual_apic_page_addr)))
 		return -EINVAL;
 
+	if (CC(!nested_cpu_has_vid(vmcs12) && vmcs12->tpr_threshold >> 4))
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.51.0.470.ga7dc726c21-goog


