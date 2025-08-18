Return-Path: <linux-kernel+bounces-772875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EB6B298BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14B377A9E52
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EC8270559;
	Mon, 18 Aug 2025 04:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LJB1YjhS"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8981726F462
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755493108; cv=none; b=mED4EqiG6x70tsR1Y44sIOvRUIGW5Yo50ZJ3vP2L2oXA3IIFKK+2WzkP2T1AJCzOcCCnhZ+2+jCZoTmqrHFUx7XL94r+2PvOYSYXMuHCslkUfvsS2koD3sqWQd+xfvxJbX+MNhV9WjLu3cWhQ3woNt4xDg/TI2QtbCTyCgrqJlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755493108; c=relaxed/simple;
	bh=yeEgt3B7oP+kZLvu/rWotic5mkE4aCWzjFVNCBZaVhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaB+29JKUyTPBNYb2dFJ+KTXge4Se4c485Xa46dkxETyAdb+00MtIOA38TOhcH4wmNI1Jlkp7HS7G4+Gcq7b/lkrY8rFeOWbnmrLkeIW5yBcyX/h3aASIQLaATFA+V50ANY1VPK/wsZksHgXL/IiKfOxerkoJpAfthP0kWUqHFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=LJB1YjhS; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2e8aff06so2888137b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755493105; x=1756097905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaG3DvsXq5/AKyC1GLSjgb34PJp+nqhxTUl2VKU3MC8=;
        b=LJB1YjhSPDi3ASqdXd9e/3LjdPdQdKuh2m3QLX0xEEkeGWoHBtjZvukIpWej28w4sz
         54om+6mfqUJQRaifI5eEyVSxcDFgVlIDhblGGCXgNVhkJ3iLBK9Wzur/bpMs/7teNJG5
         tw0JrDsiZ1TY0JMxtwoYgMMk+Bl3R+Q3Uj3uIEnjY6mmQn46H7s46lpI5Ffde3licWB+
         1ee6PnKl0m6sMHiKAXbiXfa3EfRhYJARKX8Ypt4r0mRWND6jfIgIkjZcehzpB5fmBLLv
         6KgQsIAz8+iIIvAwLj+2DQKWjpIvX4quMFvEgKJ5bf6mPAvwMSBiqb8exMPcRLuBD/jo
         OI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755493105; x=1756097905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaG3DvsXq5/AKyC1GLSjgb34PJp+nqhxTUl2VKU3MC8=;
        b=wKMSn7jaWn/xZNhAxrY2GOluB1Hf5iL7rq9RxczTdZAYY5Sg7Qzr7BZeBfs9kmkB3W
         7ADzuYIWP1eR+5GVipSnCwd6NEpK+z+V8Vl38wsylZ7P2Gy8mSxvZj1Kz57xNoH6GRI+
         cRKo+ly3wSs3Y3xbmpaxQdwdRTwMQ2QMgUErWoBdRzM6ldClXsAwR65ao1n1m1ZBROTf
         uAArmQpaxH4PQZcuevPsgpA9E5eAJnL0jdw8uXzKXfUdQID82Kt6bXy+MLZskwMbXvEg
         Yiv+BJfruYMT5Oy2Zs2rKfs31+6RrNKoHDdsEHujXHfU4GRufENawpUrRc94cKVsZ3RY
         F5Eg==
X-Gm-Message-State: AOJu0Yxrts7+ruuJ4WwX9RsZB/Tbr5lcWZ/7LS7qtzGWEEhTNXzcyAMT
	k9PiIeGLbFdTSPfsIpBzTyAuwIX3rykXzNDdiUXMfhMTePwbTLmuB7rV8T8V+hxrAwCf6GQDeQa
	/xJOJKD8=
X-Gm-Gg: ASbGncvqAprIrJV86mUvfEjdAlW0a5EhxnAkb0VIpWae0eQOphP+Ff6aLkGDhgyJdpx
	oTzwDwB76GgQiMMds+o/Wzpsnm4TUeFb24l1Mo13TepWv/nHloyfmKKlOczPzdtyDA9QyXJUwTn
	yAc9Hv0bv3q3SE+DUEYuNmKIT667H5NQMT/hkOMn7TV2jqH4hVAHFq1PdqAybn04evsFzCVI31k
	GhC6OVxQrTk3CRIDJv9h0SfpixIHdMNdA/FL5Ra2c6npRI28e6lUlbjgFxEYp1+amynOFxFDjeh
	JULji13ivY1TcdnjGsx4pzU0KrE9YBogySPGwmQ47uqWes5aJjTrFCRwIY+IXaG3EGy1N0C4fMT
	zKSZgrIQhBEmzi81hIy9ujuD8pb/W8VSkqPlKDgKd
X-Google-Smtp-Source: AGHT+IEemk+BWiEUx5FojBtceZEGdoOXlJtGCjztrL0+XbJGAKrKEJt4aBwM+DlqJqMugoECLw6zgA==
X-Received: by 2002:a05:6a20:5493:b0:22b:8f7f:5cb2 with SMTP id adf61e73a8af0-240d2dec932mr14433397637.8.1755493105211;
        Sun, 17 Aug 2025 21:58:25 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.199.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4528c264sm6124047b3a.43.2025.08.17.21.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:58:24 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v6 2/3] ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
Date: Mon, 18 Aug 2025 10:28:06 +0530
Message-ID: <20250818045807.763922-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818045807.763922-1-sunilvl@ventanamicro.com>
References: <20250818045807.763922-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_iommu_configure_id() currently supports only IORT (ARM) and VIOT.
Add support for RISC-V as well.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fb1fe9f3b1a3..f022f32de8a4 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/acpi.h>
 #include <linux/acpi_iort.h>
+#include <linux/acpi_rimt.h>
 #include <linux/acpi_viot.h>
 #include <linux/iommu.h>
 #include <linux/signal.h>
@@ -1628,8 +1629,11 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 	}
 
 	err = iort_iommu_configure_id(dev, id_in);
+	if (err && err != -EPROBE_DEFER)
+		err = rimt_iommu_configure_id(dev, id_in);
 	if (err && err != -EPROBE_DEFER)
 		err = viot_iommu_configure(dev);
+
 	mutex_unlock(&iommu_probe_device_lock);
 
 	return err;
-- 
2.43.0


