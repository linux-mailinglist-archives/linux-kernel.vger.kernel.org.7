Return-Path: <linux-kernel+bounces-882940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A51C2C00A
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F973B19B7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22C930F808;
	Mon,  3 Nov 2025 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6GKEddD"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485CF30F535
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762175129; cv=none; b=GWmRa0ne2h5n31CK41SSkbNrq1TaF1Vk8Q2rn9Ntput8tNat4W+736mGj8mtuYcf1FWi0qAqvCjq6f9LhhoJF6lzt9lV6RCtlsity+jJIUO90+kN7FASzKj83z8oQVIrvax4GhrtVPmGu7Yzsr4rjfNRbnS6X2tfC1qmfoEHQ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762175129; c=relaxed/simple;
	bh=ij30OguEuI7Y2LhlP7nwZzEjA3ESY7I4DMVX6svoflg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TnSYOYyqtYDInxj9NvMqznevUimrOfRL/O9+8xczGEomn1HWkn49TXNNCYcq8PZjs6pDsrl9adFbDfr16M2dDYAuFkcBTx7KjabPe9PJ76Va59eE+970FrSlmJ6274HHpDuWqSUxdbQsrxQOup55LePYdU8eY122vqweNLehMZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6GKEddD; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b553412a19bso2927472a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 05:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762175125; x=1762779925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ozVWAVtXHSgX1obV8UGv2F1d+5pDX97t1WQ6RoJB81E=;
        b=A6GKEddDE1r5DmfYEi2F/GFyjr7r3BScabLcBtl5PmgGgBiVbz03zGcY4pXnl/GZ1T
         rmBKZOVyQypip9eerK3j1Mv8L7KajqW47H/k9G+6aYDgN0otBJc6+f7Daoqr/0Y2Gmf1
         I0DdSmURQe8uU2mHwzmchjUoQCjGWlHOxszkbATBxotOgJUedr+UomJFbu36J2Sd/fjS
         YUuQzjDQwFOd1Qdh5AdZ6YzIvh4VZCTdpOHzSjX5HaR4rL0DQFVMoThH1//Q47M3343v
         9k32+vGMekcU9Z0rau3zOOH3LEHUVXJyO+YamUSx4l0g1LoR89t0+SXnGqw+ixBKI7Lb
         eYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762175125; x=1762779925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ozVWAVtXHSgX1obV8UGv2F1d+5pDX97t1WQ6RoJB81E=;
        b=YliHPTOzHCQvaHA4Eej/iF/v+wmQ3ly7HklMwBb4YDHJBG0Ust4MqUAellCZU568h8
         7HqJYbuxR0YS9zuHrHxi/ooh5rHJtbq7bukz43sfUOC8RDT2wjIY/6ZHF89Fhs23sJJq
         bbFOi0lj40aTdcTfeJW6OUWvSfU0Lx8u5gXQme63WVME8wyJtXuFPbZg/msv+jVmv7vt
         oHxyWo1CfAKbsd8Uo9MNsQXD9KeKUzH70t2IEvv6JYjcW0c2hc/Uq5k5//NkcYZgIzUl
         oFKk85SEsjyHgjeFmkyTG3xaksvzsVVhJg/4rxo8d+JwtDfsbHNsRRsgUlDWl/8ef1Nh
         1SAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuIfcpVNkcqAFqGOfDGRz2tM6orgjdXK1727t2wlSoeG55d8cq7WFiDOMq9RpFyEQ1IRltc+/A46sijtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNfyj0FCj8HcG9g6SCQs6PssE0xaj7mR+1iabu7Z27TPqltQ3d
	tv7w0/+fiQwxGS6IGUj1pJ1AL91Pe3/imooM0eckl6zn4cPs+P28fNdY
X-Gm-Gg: ASbGncvy8lW8ddUG0/N7acJWuBmiaXZ7wJrMNei3cCD4zLq9KlTsQq7AG3EDBOl/8XS
	+bes3Om655EJve1jcvRkDg5C8VaWWg1PtHWGzWXvhl9ar/G9UIrtNeOUnA+3qN1Qa3c/yTu4nyA
	LzRQnl09wDnRv6Gvqg5ftgKv9vq96oWaBcMQAM4+VU8S4kjb+icvNscGd7fbK76GBty3NJ6m0jm
	TdNGzwDsVcmAprhZpvzhtEdZHpnVai5rg3TUEZWtuByt3fcxLjtmu9b0qhhmq4D36MkWKuplFti
	kBkzBS/aBWEFP+dMsiWQdF1RszHRg1lnF7pcooiA2k+C94z05VzxFJ4UNt5DJdpV0q+XYk7PaQc
	ogUZ/gzAtkZyHq/mDE1BRMd8fRlqx/sn5qwBLV7H9m7Tg6+w7xg0niH5IZkeX2h1at8TYLkBFxd
	yOfA==
X-Google-Smtp-Source: AGHT+IGHwAzpxLt+4KjyIZZ2CRKiTYWUtpEk4DW5DkV2QX7tfq+tbxLumr3SVs8LIJ3Hd/OpvUVPSA==
X-Received: by 2002:a17:903:230f:b0:28e:aacb:e702 with SMTP id d9443c01a7336-2951a3a64f4mr155339785ad.2.1762175125035;
        Mon, 03 Nov 2025 05:05:25 -0800 (PST)
Received: from fedora ([2401:4900:1f33:62e4:5a30:25f7:ed82:431f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29526871b31sm122753945ad.8.2025.11.03.05.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 05:05:23 -0800 (PST)
From: Shi Hao <i.shihao.999@gmail.com>
To: sathya.prakash@broadcom.com
Cc: sreekanth.reddy@broadcom.com,
	suganath-prabu.subramani@broadcom.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	MPT-FusionLinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	i.shihao.999@gmail.com
Subject: [PATCH] scsi: mpt3sas: use sysfs_emit function in sysfs
Date: Mon,  3 Nov 2025 18:35:01 +0530
Message-ID: <20251103130501.40158-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace snprintf() with sysfs_emit() function as it
removes unnecessary use cases of PAGE_SIZE also it is
much preferred for sysfs functions. This conversion
makes code more maintainable and follows current kernel
code guidelines.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/scsi/mpt3sas/mpt3sas_ctl.c | 44 +++++++++++++++---------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index 3b951589feeb..749f7163c7ee 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -3149,7 +3149,7 @@ version_fw_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "%02d.%02d.%02d.%02d\n",
+	return sysfs_emit(buf, "%02d.%02d.%02d.%02d\n",
 	    (ioc->facts.FWVersion.Word & 0xFF000000) >> 24,
 	    (ioc->facts.FWVersion.Word & 0x00FF0000) >> 16,
 	    (ioc->facts.FWVersion.Word & 0x0000FF00) >> 8,
@@ -3174,7 +3174,7 @@ version_bios_show(struct device *cdev, struct device_attribute *attr,

 	u32 version = le32_to_cpu(ioc->bios_pg3.BiosVersion);

-	return snprintf(buf, PAGE_SIZE, "%02d.%02d.%02d.%02d\n",
+	return sysfs_emit(buf, "%02d.%02d.%02d.%02d\n",
 	    (version & 0xFF000000) >> 24,
 	    (version & 0x00FF0000) >> 16,
 	    (version & 0x0000FF00) >> 8,
@@ -3197,7 +3197,7 @@ version_mpi_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "%03x.%02x\n",
+	return sysfs_emit(buf, "%03x.%02x\n",
 	    ioc->facts.MsgVersion, ioc->facts.HeaderVersion >> 8);
 }
 static DEVICE_ATTR_RO(version_mpi);
@@ -3236,7 +3236,7 @@ version_nvdata_persistent_show(struct device *cdev,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "%08xh\n",
+	return sysfs_emit(buf, "%08xh\n",
 	    le32_to_cpu(ioc->iounit_pg0.NvdataVersionPersistent.Word));
 }
 static DEVICE_ATTR_RO(version_nvdata_persistent);
@@ -3256,7 +3256,7 @@ version_nvdata_default_show(struct device *cdev, struct device_attribute
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "%08xh\n",
+	return sysfs_emit(buf, "%08xh\n",
 	    le32_to_cpu(ioc->iounit_pg0.NvdataVersionDefault.Word));
 }
 static DEVICE_ATTR_RO(version_nvdata_default);
@@ -3336,7 +3336,7 @@ io_delay_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "%02d\n", ioc->io_missing_delay);
+	return sysfs_emit(buf, "%02d\n", ioc->io_missing_delay);
 }
 static DEVICE_ATTR_RO(io_delay);

@@ -3358,7 +3358,7 @@ device_delay_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "%02d\n", ioc->device_missing_delay);
+	return sysfs_emit(buf, "%02d\n", ioc->device_missing_delay);
 }
 static DEVICE_ATTR_RO(device_delay);

@@ -3379,7 +3379,7 @@ fw_queue_depth_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "%02d\n", ioc->facts.RequestCredit);
+	return sysfs_emit(buf, "%02d\n", ioc->facts.RequestCredit);
 }
 static DEVICE_ATTR_RO(fw_queue_depth);

@@ -3401,7 +3401,7 @@ host_sas_address_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "0x%016llx\n",
+	return sysfs_emit(buf, "0x%016llx\n",
 	    (unsigned long long)ioc->sas_hba.sas_address);
 }
 static DEVICE_ATTR_RO(host_sas_address);
@@ -3421,7 +3421,7 @@ logging_level_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "%08xh\n", ioc->logging_level);
+	return sysfs_emit(buf, "%08xh\n", ioc->logging_level);
 }
 static ssize_t
 logging_level_store(struct device *cdev, struct device_attribute *attr,
@@ -3457,7 +3457,7 @@ fwfault_debug_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "%d\n", ioc->fwfault_debug);
+	return sysfs_emit(buf, "%d\n", ioc->fwfault_debug);
 }
 static ssize_t
 fwfault_debug_store(struct device *cdev, struct device_attribute *attr,
@@ -3494,7 +3494,7 @@ ioc_reset_count_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "%d\n", ioc->ioc_reset_count);
+	return sysfs_emit(buf, "%d\n", ioc->ioc_reset_count);
 }
 static DEVICE_ATTR_RO(ioc_reset_count);

@@ -3522,7 +3522,7 @@ reply_queue_count_show(struct device *cdev,
 	else
 		reply_queue_count = 1;

-	return snprintf(buf, PAGE_SIZE, "%d\n", reply_queue_count);
+	return sysfs_emit(buf, "%d\n", reply_queue_count);
 }
 static DEVICE_ATTR_RO(reply_queue_count);

@@ -3644,7 +3644,7 @@ host_trace_buffer_size_show(struct device *cdev,
 		size = le32_to_cpu(request_data->Size);

 	ioc->ring_buffer_sz = size;
-	return snprintf(buf, PAGE_SIZE, "%d\n", size);
+	return sysfs_emit(buf, "%d\n", size);
 }
 static DEVICE_ATTR_RO(host_trace_buffer_size);

@@ -3731,12 +3731,12 @@ host_trace_buffer_enable_show(struct device *cdev,
 	if ((!ioc->diag_buffer[MPI2_DIAG_BUF_TYPE_TRACE]) ||
 	   ((ioc->diag_buffer_status[MPI2_DIAG_BUF_TYPE_TRACE] &
 	    MPT3_DIAG_BUFFER_IS_REGISTERED) == 0))
-		return snprintf(buf, PAGE_SIZE, "off\n");
+		return sysfs_emit(buf, "off\n");
 	else if ((ioc->diag_buffer_status[MPI2_DIAG_BUF_TYPE_TRACE] &
 	    MPT3_DIAG_BUFFER_IS_RELEASED))
-		return snprintf(buf, PAGE_SIZE, "release\n");
+		return sysfs_emit(buf, "release\n");
 	else
-		return snprintf(buf, PAGE_SIZE, "post\n");
+		return sysfs_emit(buf, "post\n");
 }

 static ssize_t
@@ -4152,7 +4152,7 @@ drv_support_bitmap_show(struct device *cdev,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "0x%08x\n", ioc->drv_support_bitmap);
+	return sysfs_emit(buf, "0x%08x\n", ioc->drv_support_bitmap);
 }
 static DEVICE_ATTR_RO(drv_support_bitmap);

@@ -4172,7 +4172,7 @@ enable_sdev_max_qd_show(struct device *cdev,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "%d\n", ioc->enable_sdev_max_qd);
+	return sysfs_emit(buf, "%d\n", ioc->enable_sdev_max_qd);
 }

 /**
@@ -4320,7 +4320,7 @@ sas_address_show(struct device *dev, struct device_attribute *attr,
 	struct scsi_device *sdev = to_scsi_device(dev);
 	struct MPT3SAS_DEVICE *sas_device_priv_data = sdev->hostdata;

-	return snprintf(buf, PAGE_SIZE, "0x%016llx\n",
+	return sysfs_emit(buf, "0x%016llx\n",
 	    (unsigned long long)sas_device_priv_data->sas_target->sas_address);
 }
 static DEVICE_ATTR_RO(sas_address);
@@ -4342,7 +4342,7 @@ sas_device_handle_show(struct device *dev, struct device_attribute *attr,
 	struct scsi_device *sdev = to_scsi_device(dev);
 	struct MPT3SAS_DEVICE *sas_device_priv_data = sdev->hostdata;

-	return snprintf(buf, PAGE_SIZE, "0x%04x\n",
+	return sysfs_emit(buf, "0x%04x\n",
 	    sas_device_priv_data->sas_target->handle);
 }
 static DEVICE_ATTR_RO(sas_device_handle);
@@ -4380,7 +4380,7 @@ sas_ncq_prio_enable_show(struct device *dev,
 	struct scsi_device *sdev = to_scsi_device(dev);
 	struct MPT3SAS_DEVICE *sas_device_priv_data = sdev->hostdata;

-	return snprintf(buf, PAGE_SIZE, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 			sas_device_priv_data->ncq_prio_enable);
 }

--
2.51.0


