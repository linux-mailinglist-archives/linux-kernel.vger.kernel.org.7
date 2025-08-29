Return-Path: <linux-kernel+bounces-791235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAE8B3B3C0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4564368037A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CAA25F973;
	Fri, 29 Aug 2025 07:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBI7oACq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040CB18FDBD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451057; cv=none; b=F2+GnmYU+fhl4dUGxg649bMbUKzwnwbUNgjEYOtPNrA4R+/mQp4jlFA4ZiYFuVevspj7BKJfNDhCv+7w+BvC2gr139uKNaLx2zsO+Fs+YNpfy0UO5ZPUiVFrB5la/D9wYh8FWewJ461CB6WRMn2N6/lzq/QZvzlmx0WjIOn1Rko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451057; c=relaxed/simple;
	bh=kAvLvzdaDPJ6ECP5JdqAlgLO+8zgi9bbHR9EEJehkkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RaE7KiZFVNLgFZGw3gOj46D+UwfBpo5MGiEloAjxbu+KBGJ/uDo8aOIlbQEp290/nYXXryECAvZfABPRdWGaQVzoPk7HISvjkfY6VVksTdXU1GBcqh7z1WcWFsGLWsXkye5eeNmBXL4WFLprCJjUBqhjWd4be+IZjuJoewY4uyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IBI7oACq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756451054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HSxQ5uHqTcAFdl8TpMUsBZcieGblejZiliIfARmISnM=;
	b=IBI7oACq/91SyNhDcw4wm0Nzo/u9tLqxm0x+kBdp5MUs4a6j/pKzzkN2GK22g8U676cFQo
	x5T4hz4xE5r0Xly1seiG6him99Ulfo9rh/8qo41dR7Zd/Vd4nCk6LGbt0gdlZeuajQBtrf
	+oa0UaY1sMeoujQVQKnDtmB2Dcw87P0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-37OaUBGNNHWFsQBR7FcLTw-1; Fri, 29 Aug 2025 03:04:09 -0400
X-MC-Unique: 37OaUBGNNHWFsQBR7FcLTw-1
X-Mimecast-MFC-AGG-ID: 37OaUBGNNHWFsQBR7FcLTw_1756451049
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b2dab82f70so52570821cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756451049; x=1757055849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSxQ5uHqTcAFdl8TpMUsBZcieGblejZiliIfARmISnM=;
        b=Q1lN9nqkPIJz6GvjXSa7aEJmER+bevMJalQHt7WQwv78FEdbyFPUlPkgP4tK3E3oyV
         GM907+ZYOsDE4RJVU1NEOAXaTCkPfBAhcfwaYpnbMaFQmfxLBBeZ1KcGPTBYNkV+VDyA
         ol7yFymKHMh0QXhvD9nPbkM8e6+QvMeZLLrzRrOxpaRFsGh4YNl2Tlg5fV2tpWQk/gIQ
         zpd7ezNppt6zuTUh7mM8tL6fdYaGmcLqUCK9SvzbgbJRGEKVIvjniCkEcSKwJpIc0Omt
         fHrsyGC/sutc6ReOuqsAk6qHzzMv8RlqdWvhOIh6Pqb3C7CyLrRhz01m7sSW3L6lcKRK
         q2Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUxL8Bg3ooR7TJ4yIV4HPunBo0x0lzfwkv2f38D0Y50FXPCWHU2tD+oIB2BHxw7m91m7BmEQiX95t8LGNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQIS5ofS3wieK9DLfXid73NQPx++nFno+KSkFvuCKf65OTjFXH
	FR6JW8/3tSazGUGCeq1kILyYybby7Gua3m/ZZLipL+OButzorZ9w4i6AYZ+eHaTMGyZDnsxCL7e
	mk3XuP8BdwQCszgwq307nVX3wtIeX/YV8uRlMxaE7KmND+Jrw+67F7lHogeRW0sAUMg==
X-Gm-Gg: ASbGnct9HRz2jSlnUN7u09Z3NFRlCvkzyREMnk9EtB4Yg+y139GonCbaxjFfUJ3WAyE
	WXxOUUIA7KNI5y3Pv29MabO6EnF8WB0YsR2eKXIRwJzlGDs0NeYkBNcu62F4MGGH9XgwJLQsico
	HBGapKR6rJhc7CtMtyB4k5re7LV+EONQGWsXGudX0xN0yWYibkxdgrUllaJC3b5PjLsVHP9p3k6
	/2Z+E/LbELbyi6Ffz5wVhcY26T8X4IRNiIqFne91yF41u6EJAITG2N+yaxbaJysTYO4TF9hh4jE
	fHI4utEVlZJJq7ipX/uNmgERRb+bbUeW+fpgtMtDOC8HQqZLqpnJ3TQgiOeLq7lUV3jG3JYkwzW
	E1m+85U1tjw==
X-Received: by 2002:a05:6214:2623:b0:70d:bffa:21fe with SMTP id 6a1803df08f44-70dbffa249fmr190374776d6.32.1756451048968;
        Fri, 29 Aug 2025 00:04:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvNCGAKglGCoAmY/c1Jkq2J7bhpvWeJJJNXZT684KY70w9wlcGMPpA0aV6SmC50M6VwQDWXg==
X-Received: by 2002:a05:6214:2623:b0:70d:bffa:21fe with SMTP id 6a1803df08f44-70dbffa249fmr190374536d6.32.1756451048411;
        Fri, 29 Aug 2025 00:04:08 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e01:ef00:b52:2ad9:f357:f709])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70e57e4b20bsm10805846d6.33.2025.08.29.00.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:04:08 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	xen-devel@lists.xenproject.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] x86/xen: select HIBERNATE_CALLBACKS more directly
Date: Fri, 29 Aug 2025 09:04:02 +0200
Message-ID: <20250829070402.159390-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

The config XEN_SAVE_RESTORE's only purpose is to select
HIBERNATE_CALLBACKS, when config XEN is set. The XEN config definition can
simply select HIBERNATE_CALLBACKS, though, and the definition of
XEN_SAVE_RESTORE can be dropped.

So, remove this indirection through XEN_SAVE_RESTORE and select
HIBERNATE_CALLBACKS directly. Also, drop the XEN_SAVE_RESTORE from the x86
xen config fragment.

No functional change intended with this clean-up.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 arch/x86/configs/xen.config | 1 -
 arch/x86/xen/Kconfig        | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/configs/xen.config b/arch/x86/configs/xen.config
index d5d091e03bd3..98b6952ba9d2 100644
--- a/arch/x86/configs/xen.config
+++ b/arch/x86/configs/xen.config
@@ -12,7 +12,6 @@ CONFIG_CPU_FREQ=y
 
 # x86 xen specific config options
 CONFIG_XEN_PVH=y
-CONFIG_XEN_SAVE_RESTORE=y
 # CONFIG_XEN_DEBUG_FS is not set
 CONFIG_XEN_MCE_LOG=y
 CONFIG_XEN_ACPI_PROCESSOR=m
diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index 98d8a50d2aed..aa4040fd9215 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -8,6 +8,7 @@ config XEN
 	depends on PARAVIRT
 	select PARAVIRT_CLOCK
 	select X86_HV_CALLBACK_VECTOR
+	select HIBERNATE_CALLBACKS
 	depends on X86_64 || (X86_32 && X86_PAE)
 	depends on X86_64 || (X86_GENERIC || MPENTIUM4 || MATOM)
 	depends on X86_LOCAL_APIC && X86_TSC
@@ -64,12 +65,6 @@ config XEN_PVHVM_GUEST
 	help
 	  Support running as a Xen PVHVM guest.
 
-config XEN_SAVE_RESTORE
-	bool
-	depends on XEN
-	select HIBERNATE_CALLBACKS
-	default y
-
 config XEN_DEBUG_FS
 	bool "Enable Xen debug and tuning parameters in debugfs"
 	depends on XEN && DEBUG_FS
-- 
2.50.1


