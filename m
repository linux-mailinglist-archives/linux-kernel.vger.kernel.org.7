Return-Path: <linux-kernel+bounces-825902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28845B8D122
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 22:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F70466052
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9798A2E6CD1;
	Sat, 20 Sep 2025 20:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="SCbvuNLT"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D256D2E2F14
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400753; cv=none; b=rcTV0PMRuTysOroGlWYN+TUBzrKyIoGs+HCAMmyTU2T2eHkzNX4Gs7jIqWOwSLzcPC+4K+s6aftwozXnGuteEyUiBHDcpyZlnHTyFSYEpzs57JQt7a+k1gfRlE62By7qY/MdK6BnolO8zsjDD+c+SyaxmOkPf2rBVrXP6uswVD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400753; c=relaxed/simple;
	bh=4BFlmqPFmB0y8a2YMn/MaIcIOGsPHlt2XA/KAa8fqQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V76zu1Zp0d0RSUE7QwjOpCrcEUQO8X7Id9XoQtBIa2RmfXl5k9c7olHWb01mTBEwkmeA0dyGV1n/s/qxLMOkSUI+My8hTtLve48S3JPe9A7hcNSn9S/+tK13kkwbHDYe4oEzz/biE3Ui13fH558VKc1qGAuCajVpptHujI+rDMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=SCbvuNLT; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-4256ef4eeebso3934445ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 13:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400751; x=1759005551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxscO8SXNrjDBekFMJlTFlhXiLgQFfajmO2RZqDfrAU=;
        b=SCbvuNLTfq73d56rhpwdP7lcF+ClacdDqjgdi/PAaNyWMG9Wsr2vnbg1BvJOKfgWs2
         ky0O/lbBtZB7CLCGhPiNiWnBVif6mjY+jTPR34wTKNkWGc7tMESgdiNKlhITopQjDwL3
         ngtMzwVmEayKBnKOuXbKY/CJR6lS3L8W+mLVnCAg7pa8Q944wsvTEs2VzU0d3uwsJlng
         dkuDAS3LwToaaefl/xkaRAzmGv054Eb2Sd+msJENQPgwf0bQOdgKUrlMU4erakRBQ7vo
         4d4vNG4qvoImhOhHBL/w6azQc2ME9cqIO+wuOSaYtDBHk/JyISS6fNI3Y+vbyIfrIRml
         ArEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400751; x=1759005551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxscO8SXNrjDBekFMJlTFlhXiLgQFfajmO2RZqDfrAU=;
        b=idZFGnJ22W+UkCrI2csWehPbtuk8mWWDSNFliZ6riYG73gc9OnoXkqzCMsK5HqtL4e
         emJtswrRFfLQGnuBYkKb6l4bvND7Xo+x4nwuYqpkMXKzHdHQxiIz/Fcq/V1dK1a9alJl
         4/nNW5X2PW/uYw+lIqpqmcQgbamb8PTl1crB6a2/GvVz5WvyBzC6uF4V+T18ybk4Wdjt
         zaUQozjqdWRrOOG9pGHuXeQl6eHED3o4ysjDdQuXByxW7tyaAW5HRrqFcZJ6n7W4EdkP
         E1zNWTFQM44ZFX6Iow12BTvFxSM4wXt1RGPXxr3z8sX5FodQNrFzbK5jNIbO4xZziEeX
         BUbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7ON/jBDFWqHSdlwwrL/trvIFe11KHhY0Ry2/T04gRJN7f5nuYZWhKZ4rKCIKo2cBru1HexRr2hTzZmak=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq6nN/pss0ASvdmQhl6dmXifsomyc5g9aGEINOVAYrlGtprwgB
	lJVxu9SO+PuxhL6dijiHvyVCx0ehzitQDUippVGmiKwOmDtDZwkxchIh0CCPKXlrdGE=
X-Gm-Gg: ASbGncs3GuCVVD6IYjS+EqTpP1ULQ8CbWEROCqS2F6MetST5rUO3KL5hgrSCb8YVIu7
	vsx57RKYRW/yby/hgXO4uR8ZWS70J0pVQC8z9e9hkHy+VN3/sUT6hRv1RIq6w6AJg7LDO9YZsoV
	Ev1hoh4/rvFjnzkiDvfb65FKx6ygwEeR6fYGkeAEoWv3rF4A2Wsfb6TsQj72z2AqLZ01hZXFyjE
	cEXI6uKPHgIADwowfcZL1RP54oboeOx+L2gsItIfwjsirdadFOWYAjB9mFnxj2thlfj+tEhJDp4
	iZitkFqpEJlGt3FzEhRhCJfUOoZMVJKHM6ShG/rErhQKpbMl8ZWRj7AGlf66xTA4E5eCU3Xjfk2
	st0jPBlAGvWMCJBd7Swd6NhEb
X-Google-Smtp-Source: AGHT+IERpRPEc12mV955tvnuQoeNvkZUC+MN7EtTp3JKXd3eHnM2oBc0U3F0kWPqnL99WZIdHZ+AuQ==
X-Received: by 2002:a05:6e02:1d9d:b0:410:cae9:a089 with SMTP id e9e14a558f8ab-42481922e1cmr116891435ab.2.1758400751055;
        Sat, 20 Sep 2025 13:39:11 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d56e429f3sm3768486173.74.2025.09.20.13.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:39:10 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: jgg@nvidia.com,
	zong.li@sifive.com,
	tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alex@ghiti.fr
Subject: [RFC PATCH v2 14/18] RISC-V: KVM: Enable KVM_VFIO interfaces on RISC-V arch
Date: Sat, 20 Sep 2025 15:39:04 -0500
Message-ID: <20250920203851.2205115-34-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250920203851.2205115-20-ajones@ventanamicro.com>
References: <20250920203851.2205115-20-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Enable KVM/VFIO support on RISC-V architecture.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kvm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index 5a62091b0809..968a33ab23b8 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -30,10 +30,12 @@ config KVM
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_GENERIC_HARDWARE_ENABLING
 	select KVM_MMIO
+	select KVM_VFIO
 	select KVM_XFER_TO_GUEST_WORK
 	select KVM_GENERIC_MMU_NOTIFIER
 	select SCHED_INFO
 	select GUEST_PERF_EVENTS if PERF_EVENTS
+	select SRCU
 	help
 	  Support hosting virtualized guest machines.
 
-- 
2.49.0


