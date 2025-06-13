Return-Path: <linux-kernel+bounces-686025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C40C3AD9212
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 17:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C24E1BC3518
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 15:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3396221F06;
	Fri, 13 Jun 2025 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kg645UMD"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBD41F8690
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749829979; cv=none; b=iXu3ylsSEnZUODLQh1PliFqhWwK82kQwIbohkVm0aV9Gzr+5Te93c8YJoA/s/vWyhJj8SKWrYPsjJYpBo8G+0lSCXpbKpi/vanW5mJaDWhiST9eEQtIYBfyVM7CE5ePzxMFlsnx6JviJbk4HUQxsdh0bEWYt+uBE/lxYcE5F72o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749829979; c=relaxed/simple;
	bh=vxkacs+qUolHE8ofOSXElM6uFZzrXDwx3yDd3lw+TdE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qWXIeNU5fxsD2y0XoG0EHR/NWA5S+9Y62b0eVAyngy+s6kvA6x0eBj6uYC+mf1uB3MDOJzUg54jTLvV1wOqmU37jRCYAzYr8Nu0OXxNQGTKSJLtZvsh2UXVJ7cwBPmTW8kmI/JIzIFQFyBh8xIHZaISURMjlg7FAhhre9N/O/Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kg645UMD; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-869e9667f58so445543439f.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 08:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749829976; x=1750434776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OFF6SOp13MfI+rKYc7dCezNEaDk/WUOkhnG6IJMmr80=;
        b=Kg645UMD5Al2JdimJtX+fWBrF7WLVF+k6Od+MRlWVrWRXRUlFv6/C0HbftavRly7TP
         pt28jSaVtEWQWSKk6ewNBj0x8k7a41xeak2cP5QSfOs+NyLUiFkKE0la80pIH7SoEplI
         TcwHC4J4iKb0Hkj8ZcKH3t/l8WnIcqCQ4LXJVcmIIPUf9bhbuLAp7SLxNrq31qwvnTW7
         ZM4DVDgbTTdt53eu5XGNMd8scqs7QKeDnnemLXVa+N2ntPNTSrpTjXWa2BklvzMTerHF
         UYvkjuwM7ZMgD2651kDfj2+Am6yDuFX6120bgaCnyQvvqyTHC/dTtpXtMralEAPy/xP4
         GGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749829976; x=1750434776;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFF6SOp13MfI+rKYc7dCezNEaDk/WUOkhnG6IJMmr80=;
        b=j9bXIeYzYBR4Z1o3HrVHxZQD1IXCy86m7cLMhLgsCCDc2gi9CQyLJxWOAyyCfpRCWd
         1HXaKKN3NpNnLH7e6tmUPUTXBjqbVphnAOzvJoSkIY76KntH8KYDaVZGPotlLjrazNby
         sVcPJ+H/74d7lf7c69gERLdkL8JGSGogi/Kc6pXvEW/rKiirhfPVPXyg7CVQ4FiezXoE
         6bzFpMkfixHkWsJA9Ia7lRwPMXoH1uTd7v1Rqgr1A8gjBLhuqYEMbTrZCK28sXQbS/ds
         n8MC7Kr+3uheTGXNtAlM1N209gCygbTq9Ez3LXicuk8NoL/VixNMkEM1RiEr86LJbaMu
         IqJA==
X-Forwarded-Encrypted: i=1; AJvYcCVKYDhlJsHtlJtA9lHCmPU2ewUdePH7YYzDdQuue4owZC+O+cqPdWGaEqo627bCIcYiNH/YFoKjij5cgdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/c4Ub27LE5iegQ1kqMkxl2y+5y83/uZqmhsaLQQbE+YMDH7SO
	gEf5Je1UsaVuww6EJyhEyESumOCp64TcHVBBG213T2V14qy4+B91MB4/9U4aP4cliTMT0d3XYQF
	HWYIOoA7EzA==
X-Google-Smtp-Source: AGHT+IG8T3q/TFMjMeVIYD6samTw89/uinTNnuWwzxHnuwndVMxgoAdLhGBoyVqCfis1o5KW9rTeoIB0iQbo
X-Received: from oabkz22.prod.google.com ([2002:a05:6871:4096:b0:2bc:69a2:7ea5])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:a3c6:b0:2d6:667c:511f
 with SMTP id 586e51a60fabf-2eaf05ca75amr171809fac.9.1749829964975; Fri, 13
 Jun 2025 08:52:44 -0700 (PDT)
Date: Fri, 13 Jun 2025 15:52:36 +0000
In-Reply-To: <20250613155239.2029059-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613155239.2029059-1-rananta@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613155239.2029059-3-rananta@google.com>
Subject: [PATCH v3 2/4] KVM: arm64: vgic-v3: Consolidate MAINT_IRQ handling
From: Raghavendra Rao Ananta <rananta@google.com>
To: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
Cc: Raghavendra Rao Anata <rananta@google.com>, Mingwei Zhang <mizhang@google.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Oliver Upton <oliver.upton@linux.dev>

Consolidate the duplicated handling of the VGICv3 maintenance IRQ
attribute as a regular GICv3 attribute, as it is neither a register nor
a common attribute.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/vgic/vgic-kvm-device.c | 51 +++++++++++++--------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-kvm-device.c b/arch/arm64/kvm/vgic/vgic-kvm-device.c
index f9ae790163fb..e28cf68a49c3 100644
--- a/arch/arm64/kvm/vgic/vgic-kvm-device.c
+++ b/arch/arm64/kvm/vgic/vgic-kvm-device.c
@@ -303,12 +303,6 @@ static int vgic_get_common_attr(struct kvm_device *dev,
 			     VGIC_NR_PRIVATE_IRQS, uaddr);
 		break;
 	}
-	case KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ: {
-		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
-
-		r = put_user(dev->kvm->arch.vgic.mi_intid, uaddr);
-		break;
-	}
 	}
 
 	return r;
@@ -523,7 +517,7 @@ static int vgic_v3_attr_regs_access(struct kvm_device *dev,
 	struct vgic_reg_attr reg_attr;
 	gpa_t addr;
 	struct kvm_vcpu *vcpu;
-	bool uaccess, post_init = true;
+	bool uaccess;
 	u32 val;
 	int ret;
 
@@ -539,9 +533,6 @@ static int vgic_v3_attr_regs_access(struct kvm_device *dev,
 		/* Sysregs uaccess is performed by the sysreg handling code */
 		uaccess = false;
 		break;
-	case KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ:
-		post_init = false;
-		fallthrough;
 	default:
 		uaccess = true;
 	}
@@ -561,7 +552,7 @@ static int vgic_v3_attr_regs_access(struct kvm_device *dev,
 
 	mutex_lock(&dev->kvm->arch.config_lock);
 
-	if (post_init != vgic_initialized(dev->kvm)) {
+	if (!vgic_initialized(dev->kvm)) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -591,19 +582,6 @@ static int vgic_v3_attr_regs_access(struct kvm_device *dev,
 		}
 		break;
 	}
-	case KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ:
-		if (!is_write) {
-			val = dev->kvm->arch.vgic.mi_intid;
-			ret = 0;
-			break;
-		}
-
-		ret = -EINVAL;
-		if ((val < VGIC_NR_PRIVATE_IRQS) && (val >= VGIC_NR_SGIS)) {
-			dev->kvm->arch.vgic.mi_intid = val;
-			ret = 0;
-		}
-		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -630,8 +608,24 @@ static int vgic_v3_set_attr(struct kvm_device *dev,
 	case KVM_DEV_ARM_VGIC_GRP_REDIST_REGS:
 	case KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS:
 	case KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO:
-	case KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ:
 		return vgic_v3_attr_regs_access(dev, attr, true);
+	case KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ: {
+		u32 __user *uaddr = (u32 __user *)attr->addr;
+		u32 val;
+
+		if (get_user(val, uaddr))
+			return -EFAULT;
+
+		guard(mutex)(&dev->kvm->arch.config_lock);
+		if (vgic_initialized(dev->kvm))
+			return -EBUSY;
+
+		if ((val < VGIC_NR_SGIS) || (val >= VGIC_NR_PRIVATE_IRQS))
+			return -EINVAL;
+
+		dev->kvm->arch.vgic.mi_intid = val;
+		return 0;
+	}
 	default:
 		return vgic_set_common_attr(dev, attr);
 	}
@@ -645,8 +639,13 @@ static int vgic_v3_get_attr(struct kvm_device *dev,
 	case KVM_DEV_ARM_VGIC_GRP_REDIST_REGS:
 	case KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS:
 	case KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO:
-	case KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ:
 		return vgic_v3_attr_regs_access(dev, attr, false);
+	case KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ: {
+		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
+
+		guard(mutex)(&dev->kvm->arch.config_lock);
+		return put_user(dev->kvm->arch.vgic.mi_intid, uaddr);
+	}
 	default:
 		return vgic_get_common_attr(dev, attr);
 	}
-- 
2.50.0.rc2.692.g299adb8693-goog


