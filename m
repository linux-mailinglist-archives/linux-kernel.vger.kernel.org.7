Return-Path: <linux-kernel+bounces-890996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ACDC418C3
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5DAA3AB9DF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D3430DEC0;
	Fri,  7 Nov 2025 20:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aGv3EwSa"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6AD30B526
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546324; cv=none; b=if9cONrWj15MQDbwJEjbK873TnCQb9JmeQ4uC88Yp2V5QUzDPX3QZ1d01AYgHUwQ4pxy4vmUmkJeqXc9RREMMH7CZJ8NClggtGTKJX9PvJ0l7z+x6Q85SfijvuEIAfRUgPB84XKJzLZbPXOnEqyC11wS9uDFzH0alCGQimQW7G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546324; c=relaxed/simple;
	bh=UBLmYwQUKIRlECodStHOn5ZyGn+RVuUZH1lnC54MR5o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BF1IaPDAgQJB7X73SoQQHRnnjEaz98k4hzAv4yduQa7IR9smFzYft5tJL4iXNo+FMRCoFpDTgWjL8FtSqeftX4oOT69OHfroqk77J/Kc0rOSxNHz1Q1ePB0uxmZa3IpTE2fSwzkJLiJrrLxD497PvzSd1XUB8f6LjdQ6OcYY3gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aGv3EwSa; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b0e73b0eadso2421819b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 12:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762546322; x=1763151122; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zY5ooH63yC1l2oevmKp10xqE2ANPXtJ+gHeVu/JOJ04=;
        b=aGv3EwSaLNkfI1Min+8nUD+YWF+9IozV4stZ4DPEz2mV53idTcNtkxsYoUPtspKrpE
         0UHXvJQE1dgZQifV3KeIAQjM1o0sQLYwxxmdcJBS5ifmgsqwAqeYl2MH3w7MqFOr9fCJ
         Kk7Ofk0DSFFfuwwYjx8VUQY09I1WOzD5J6Qix97kxxOEYFzAHrQEtq8AkzzedrNRdUeQ
         oBHlbtq/NSTUcoUQ4PiwGgT3pQZ15dSmAkocWRnt6816jQTmhwr8YHKPywB0nciia8SH
         JzqAuCMKaNjNYCAwX5ymqKQSjGLxXWLpbKlAagdLKLDiWc3fRbqt+Jfc+JeMtkfZq7L3
         Rq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762546322; x=1763151122;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zY5ooH63yC1l2oevmKp10xqE2ANPXtJ+gHeVu/JOJ04=;
        b=n/eNvU3c7u+ny9rOSBWo1H3FyVjo73Kai0YAeXJ+xFQOiuJpvfumHbe0/Tbna4qPAH
         HY+oY2T1kmAPtbjt28cScKnfRLXdvf5r9fgEFMnrN/4bLpz+YtF5B5v3v9EFEqql1K7P
         vR0xIskQ9oyCM7npnerTM6f28oB8BRdTsdD5viHNNBYpctvp8WIX3P3Rm7AW3us9oC/H
         lBwZvwuEPgXl6Oy5Qwx2IN+yV3MjC60KLXBfYJRak6MlqBplYG7hf1HcXo9t8B1FG18s
         wk3HgTR4aNvJwDTBtC8M8+23296hyUF3toKm/c749jyB27CfO7MOrEomvGtUburRXDMF
         aWiw==
X-Forwarded-Encrypted: i=1; AJvYcCUrjnLJ8UKB/j0GQTQ2wP+av6c5767bZxFp2xJVtkCAV9IAv3mgJAeHvK8DNyBaWC8vo6GWgOuT3VYgbas=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI2h3XLmpX3GRHEy1U80yO6R++bZz7TX0spNdghuCA+Xq5iy7U
	aH0+VkrBVgMDwU5N/duXSUaVWlLm+hAangDibA/GjxPOaHrmgefokLwUsX2IBhrJxosBnIktA17
	IPOsc3BTQvF4hLA==
X-Google-Smtp-Source: AGHT+IGxOHMW9tvmB7BFaZh+51NkzwK3iCtiNQKTGPfozT1eR95viIjcpptukgzHxOaiA2buBP9aC0pf/SuY+g==
X-Received: from pga20.prod.google.com ([2002:a05:6a02:4f94:b0:b6b:f3ec:692b])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7f9d:b0:34f:ec32:6a3c with SMTP id adf61e73a8af0-353a1ae2b3bmr494680637.28.1762546322264;
 Fri, 07 Nov 2025 12:12:02 -0800 (PST)
Date: Fri,  7 Nov 2025 12:11:26 -0800
In-Reply-To: <20251107201151.3303170-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107201151.3303170-1-jmattson@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107201151.3303170-4-jmattson@google.com>
Subject: [RFC PATCH 3/6] KVM: x86: nSVM: Copy current vmcb02 g_pat to vmcb12
 g_pat on #VMEXIT
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Alexander Graf <agraf@suse.de>, Joerg Roedel <joro@8bytes.org>, 
	Avi Kivity <avi@redhat.com>, 
	"=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>, David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

According to the APM volume 3 pseudo-code for "VMRUN," when nested
paging is enabled in the VMCB, the guest PAT register is copied into
the g_pat field of the VMCB on #VMEXIT.

In KVM, the guest PAT register is the g_pat field of vmcb02. When
nested paging is enabled in vmcb12, copy the g_pat field of the vmcb02
to the g_pat field of the vmcb12 in nested_svm_vmexit().

Fixes: 15038e147247 ("KVM: SVM: obey guest PAT")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index c68511948501..51a89d6aa29f 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1126,6 +1126,9 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	vmcb12->save.dr6    = svm->vcpu.arch.dr6;
 	vmcb12->save.cpl    = vmcb02->save.cpl;
 
+	if (nested_npt_enabled(svm))
+		vmcb12->save.g_pat = vmcb02->save.g_pat;
+
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK)) {
 		vmcb12->save.s_cet	= vmcb02->save.s_cet;
 		vmcb12->save.isst_addr	= vmcb02->save.isst_addr;
-- 
2.51.2.1041.gc1ab5b90ca-goog


