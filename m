Return-Path: <linux-kernel+bounces-754338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3D3B192EF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 08:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3A91898252
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 06:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C3C27F75A;
	Sun,  3 Aug 2025 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="efkYHxAn"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FA12586DA
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 06:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754204273; cv=none; b=DPF6vW6o9lfqQ/aHbeJHndvAQIoqtjLcT+HEGj4fyJZlxCp7nVo12CRJP24E+zQaga7e0uqyWdq3YTpRfRMAQS/1HmxMtRvymPMhoesEEfEOzWypkubIRrD0/aqE1irN06I00RiImHMeI249OpdNISIzYVbnKE54j5J7Xj4hPuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754204273; c=relaxed/simple;
	bh=3Q+/Y1GGbBB3cZCpx2+SgdSBiEzvjUaz/Mt8EQnlbnI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HxWb50CQdtdqrqV1x5D12BVAH26106FLKAIxYsHc2kt76uXdb48D/oyrCsjj6lgPtlsXzsexwQrmPMxeVYw2FhMT3jzUjw9RpGYR6i4C6qFlJe07Ig+fp+2N2TPPDhrr0A38d87I6CbM/Q1AP+VLqmlLAs7+Ny7/uO9/fbDDe+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=efkYHxAn; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AD2F03F633
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 06:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1754204263;
	bh=4L4BWM8flzXDud1pJuJoJ3jcEt3Nv7W53k9mRGZ71vY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=efkYHxAn/Vn03uyJ6/+X49NJVIbTPWauyIvjeZRLy4lusmXT7VAbCQBm+ko19Wjud
	 BV1JCdMEgVJZWHidveAfE/RPUutVC5Y0q7FXK2nuJkCcTno0wsc6JUvwkUEaDy1xIz
	 nEtM0HAYGprMKmWr0+ypWkgzSEZyLAz0iC/xLkKZ3okzP0DSq0NK74aijjURa4S9lp
	 yNVtbKcncubT50BiXizKlOFbpRmM1wHq2awPpK70Tyy1pkuu4HtdX9J28WrNtCKVXv
	 JyPdij5U6NxKYuqCsHa5liTV7OhcwtsFb3aFucgQWb6wklOtohSQLnGWmk3fvlLRuh
	 cPPcrBE0plWvA==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-55b8422dbdaso1884226e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 23:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754204263; x=1754809063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4L4BWM8flzXDud1pJuJoJ3jcEt3Nv7W53k9mRGZ71vY=;
        b=n0L+WL8hLGjPKQzfeVxUKLDrXydPqmj+mXU5rv1eIfJ6vJIzgTfuAgpxx18jvfv5xj
         NQ0nmSfcQHV7TEYheu/9fnmSA8pFx+Mfzxc3AsmJAMUDsD3jFP2brCC/TV75PCjNGhap
         En3nLa+WkwmLWKc6vsFA6Oo/IpgT4DZ2g/M2iMdk5mhqtutG8gnnIRAFZvLZGuqevBuE
         PVc4Fa99lNwBRFsjKlovGy+qIzm26KlFd0g387cvRB6nxuaWo901JZSeuH/uccBh5AvQ
         SCl42BDUAg0s8az8gQvQzpwT8fCxO8Bt0Zb/AycoSNu5WRbZHfkVaHr4ZcAoGprSsniD
         F6tw==
X-Forwarded-Encrypted: i=1; AJvYcCWgsaoGW8duOE4Z/j7LAycw7dhOnWkxRst7UFC8FuuAHVd3g6CRf7Hj8GR/3ECaB7+Ex1NWTrFEqrdQ8YY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6GQhcSd79JlX+c+iavjoF9LmLeu1kRpn8o/cKcicK5YE64Vvu
	6p2Rbx4o1Aj5ypwTXvyKIQQNqwmd1S0bQqdsLAQX7q9YlTXAyi+tRf7tdHXabyb7qPzUBCpugRt
	kQ5RPHkyiTiuzPI3cBKQgi22eZYO0EDp7Uh1xEpmTyjaA9ekyduoH77osfdghxmD4wrVsTqYHkc
	XZTA1plA==
X-Gm-Gg: ASbGncuPSupdFKqLqX+ml+A+kStV9knXq/LQBkm97LQk4aYdXRAfaeO/E5HyVBtFxrz
	YBkUSxMw+LIeiYiC1dsUvGYuHEW0g9xn76fm7RNpaUPoQW2o5tT+C+kVn8Bnj3qdDj1eGcKj+vw
	xY7U8G+0fUiW+Tp18z+jY4R4qWdy1UgI04AG1H30TMVk6xrrvLoAVVfGcpUHmOESio6B+aq149W
	ViGcXQkakgQDr0YdGe4RMHZcgSHbSztssgF1vn+kscavHNODzWHnxQMjk2DBkogDV4BfXPF5oU3
	L4A+UYY9bQVw8q85uJv4wHYhGaueeJuL4deb/vJWtjlwwaV01COATh0r
X-Received: by 2002:a05:6512:3d22:b0:553:a469:3fed with SMTP id 2adb3069b0e04-55b97abd668mr1440900e87.11.1754204262796;
        Sat, 02 Aug 2025 23:57:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI6d54OeJNyimMjiPKB/keXc8zPMccEG3pKCflM6/1aolOs0KOPeWteKjEnWhIcEPkGSsHhQ==
X-Received: by 2002:a05:6512:3d22:b0:553:a469:3fed with SMTP id 2adb3069b0e04-55b97abd668mr1440898e87.11.1754204262342;
        Sat, 02 Aug 2025 23:57:42 -0700 (PDT)
Received: from localhost.localdomain ([162.213.32.233])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b9dbcbad2sm288627e87.56.2025.08.02.23.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 23:57:40 -0700 (PDT)
From: Aaron Ma <aaron.ma@canonical.com>
To: even.xu@intel.com,
	xinpeng.sun@intel.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aaron.ma@canonical.com
Subject: [PATCH 1/2] HID: intel-thc-hid: intel-quicki2c: Fix ACPI dsd ICRS/ISUB length
Date: Sun,  3 Aug 2025 14:57:25 +0800
Message-ID: <20250803065726.2895470-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The QuickI2C ACPI _DSD methods return ICRS and ISUB data with a
trailing byte, making the actual length is one more byte than the
structs defined.

It caused stack-out-of-bounds and kernel crash:

kernel: BUG: KASAN: stack-out-of-bounds in quicki2c_acpi_get_dsd_property.constprop.0+0x111/0x1b0 [intel_quicki2c]
kernel: Write of size 12 at addr ffff888106d1f900 by task kworker/u33:2/75
kernel:
kernel: CPU: 3 UID: 0 PID: 75 Comm: kworker/u33:2 Not tainted 6.16.0+ #3 PREEMPT(voluntary)
kernel: Workqueue: async async_run_entry_fn
kernel: Call Trace:
kernel:  <TASK>
kernel:  dump_stack_lvl+0x76/0xa0
kernel:  print_report+0xd1/0x660
kernel:  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
kernel:  ? __kasan_slab_free+0x5d/0x80
kernel:  ? kasan_addr_to_slab+0xd/0xb0
kernel:  kasan_report+0xe1/0x120
kernel:  ? quicki2c_acpi_get_dsd_property.constprop.0+0x111/0x1b0 [intel_quicki2c]
kernel:  ? quicki2c_acpi_get_dsd_property.constprop.0+0x111/0x1b0 [intel_quicki2c]
kernel:  kasan_check_range+0x11c/0x200
kernel:  __asan_memcpy+0x3b/0x80
kernel:  quicki2c_acpi_get_dsd_property.constprop.0+0x111/0x1b0 [intel_quicki2c]
kernel:  ? __pfx_quicki2c_acpi_get_dsd_property.constprop.0+0x10/0x10 [intel_quicki2c]
kernel:  quicki2c_get_acpi_resources+0x237/0x730 [intel_quicki2c]
[...]
kernel:  </TASK>
kernel:
kernel: The buggy address belongs to stack of task kworker/u33:2/75
kernel:  and is located at offset 48 in frame:
kernel:  quicki2c_get_acpi_resources+0x0/0x730 [intel_quicki2c]
kernel:
kernel: This frame has 3 objects:
kernel:  [32, 36) 'hid_desc_addr'
kernel:  [48, 59) 'i2c_param'
kernel:  [80, 224) 'i2c_config'

ACPI DSD methods return:

\_SB.PC00.THC0.ICRS Buffer       000000003fdc947b 001 Len 0C = 0A 00 80 1A 06 00 00 00 00 00 00 00
\_SB.PC00.THC0.ISUB Buffer       00000000f2fcbdc4 001 Len 91 = 00 00 00 00 00 00 00 00 00 00 00 00

Adding reserved padding to quicki2c_subip_acpi_parameter/config.

Fixes: 5282e45ccbfa9 ("HID: intel-thc-hid: intel-quicki2c: Add THC QuickI2C ACPI interfaces")
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
index 6ddb584bd6110..97085a6a7452d 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
@@ -71,6 +71,7 @@ struct quicki2c_subip_acpi_parameter {
 	u16 device_address;
 	u64 connection_speed;
 	u8 addressing_mode;
+	u8 reserved;
 } __packed;
 
 /**
@@ -120,6 +121,7 @@ struct quicki2c_subip_acpi_config {
 	u64 HMTD;
 	u64 HMRD;
 	u64 HMSL;
+	u8 reserved;
 };
 
 struct device;
-- 
2.43.0


