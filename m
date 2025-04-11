Return-Path: <linux-kernel+bounces-600388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 649DFA85F48
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 15:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95ED99C00AF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 13:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7741F4C96;
	Fri, 11 Apr 2025 13:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T9kC21xw"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DBA1F4616
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378433; cv=none; b=Xt9D0Hrj00cqktwcFqn9Am4eBmPT6iBa5GoW4AwFu06ugkfmgazO5oRokEVd/lwvRMO75gKP0P2bdQlIlhAngUiViAeDx9TAsGZBvEnak2DIYdaiV6iEu4XA14qrMoqp19sL2Cm5FifY++CRKzj87/EQJgwkoGnVzPphs5CJZhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378433; c=relaxed/simple;
	bh=ldPo19FYLkdC9LtTNfMtFSNkiI0cDGvCEhUtivH/b38=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z6aDSwww2eTThvHwR5YQcRj7E7Q3kYZ+dfRN/zhgHqb/KLKe0jUWwmzka2yu+BL8IOZ5+/I98Se6q77+Kn3jQC6BLTqgPag0oaEXLPj7UeRwvfYb61Bb6PlPHp+6NH+oIF/RnAmAw/zxsf62wDRv5mm3BL8iOVs76pimzx4rwes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T9kC21xw; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af96cdd7f5bso1410194a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 06:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744378431; x=1744983231; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4g2/yGXEKl1OCoyKSP0aAd6iujvLtuHh//72VEdm0hA=;
        b=T9kC21xwj33s3J7B1YXGx9x32xOEXFXccer0LUsrjI6xd+WV5+z+sP5+dzWQqDi0Av
         JKVAgxsAUGqRMNgbrXOLVB8zQWRU9ZmNb3IXkGRh51ywHmUqFr24BSOT36GsHoNcKa+I
         X9C/FIyrSCZnYg/FA7URi0qu602THQMN+06n93HiDOMZ2AFhlSvM081c/pxdW/6TPJix
         ekE81dAmP1VYHxYvcDydhQKzzRIElVsubfNIAUrXuh5MXIq9uB0gJ9AWP1mu8ESyBgBE
         Ix3uT0tre3CCa3besMbPefmkDdNsahdDlLNH2vcdjVFBl1XpuCXPKnNivceYz5MNuhNw
         nWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744378431; x=1744983231;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4g2/yGXEKl1OCoyKSP0aAd6iujvLtuHh//72VEdm0hA=;
        b=OtVmbBf+TZMs3euAlI4OTY/ne1FgFERvZdKTYUv3CsHAF8XUO5z21JTHgnel+V8pwg
         0n4tH9/hh3cS8DtOQqeG3fVTGzIEfOtGtqo24cM9Vjj98VOej0vNHkxrFyi06EcXZYtn
         oagaRwUcp+z1NkmeOdwjNdjqDBcs1hFP8RnuKJl92PC9Kg07cd1gbXKaKATjf/+oa9Id
         7Ymv0/K3JZmfryi61VAaeiz1VJml69mf3NPFOvnqhOLW6jsCZuOlihevVk7/9a7LRpb1
         +y02LdVOk/qtCX2C1v0eSMeCYM2Ze58MSrs1ZaS+qC+p1svxsjrlkD7N1C/OA0zpGHQA
         hAOA==
X-Forwarded-Encrypted: i=1; AJvYcCXnthTD4DKke+prGcOSaZWL/SFgIw1c12ldr6kepjf8Wacqx7ieqfND7a0efU1uzRysDtd+DeY9Ay+sLxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjAxTjYbfSqNUhbmw49Z4ZoLZbR74cNvDuBPmhGmGacw+1Wk1e
	ukBJ9pjCZkduuM054lu0FNwjQMpEHYrF07TxbYvLNWGSpDtON0C4G+tdlswRXWHZ3VVaVUTpF+c
	HnFsMFw==
X-Google-Smtp-Source: AGHT+IE6SnW+E2UcTarv9RF0JjGVhIc1w/GHbS5+IUmBSxMiMg0FWAXESXXjo+IWqcn9srZlCgeM+oH2+leB
X-Received: from pgux9.prod.google.com ([2002:a65:6aa9:0:b0:af2:48c3:360f])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:2d0a:b0:1f3:36f7:c0d2
 with SMTP id adf61e73a8af0-20179990733mr5205499637.41.1744378430727; Fri, 11
 Apr 2025 06:33:50 -0700 (PDT)
Date: Fri, 11 Apr 2025 21:33:08 +0800
In-Reply-To: <20250411133330.171563-1-chharry@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250411133330.171563-1-chharry@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250411133330.171563-4-chharry@google.com>
Subject: [PATCH 4/4] Revert "Bluetooth: btusb: add sysfs attribute to control
 USB alt setting"
From: Hsin-chen Chuang <chharry@google.com>
To: luiz.dentz@gmail.com
Cc: Hsin-chen Chuang <chharry@chromium.org>, chromeos-bluetooth-upstreaming@chromium.org, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

This reverts commit b16b327edb4d030fb4c8fe38c7d299074d47ee3f.

The sysfs node introduced by this patch could potentially race with user
space. The original motivation - Support configuring altsetting from the
user space will be added by another series.

Cc: chromeos-bluetooth-upstreaming@chromium.org
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

 drivers/bluetooth/btusb.c | 34 +---------------------------------
 1 file changed, 1 insertion(+), 33 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b7040747b890..304ec6f830f1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3688,32 +3688,6 @@ static const struct file_operations force_poll_sync_fops = {
 	.llseek		= default_llseek,
 };
 
-static ssize_t isoc_alt_show(struct device *dev,
-			     struct device_attribute *attr,
-			     char *buf)
-{
-	struct btusb_data *data = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%d\n", data->isoc_altsetting);
-}
-
-static ssize_t isoc_alt_store(struct device *dev,
-			      struct device_attribute *attr,
-			      const char *buf, size_t count)
-{
-	struct btusb_data *data = dev_get_drvdata(dev);
-	int alt;
-	int ret;
-
-	if (kstrtoint(buf, 10, &alt))
-		return -EINVAL;
-
-	ret = btusb_switch_alt_setting(data->hdev, alt);
-	return ret < 0 ? ret : count;
-}
-
-static DEVICE_ATTR_RW(isoc_alt);
-
 #define BTUSB_HCI_DRV_OP_SUPPORTED_ALTSETTINGS   HCI_DRV_OP_DRIVER_SPECIFIC_BASE
 #define BTUSB_HCI_DRV_SUPPORTED_ALTSETTINGS_SIZE 0
 struct btusb_hci_drv_rp_supported_altsettings {
@@ -4197,10 +4171,6 @@ static int btusb_probe(struct usb_interface *intf,
 						 data->isoc, data);
 		if (err < 0)
 			goto out_free_dev;
-
-		err = device_create_file(&intf->dev, &dev_attr_isoc_alt);
-		if (err)
-			goto out_free_dev;
 	}
 
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
@@ -4247,10 +4217,8 @@ static void btusb_disconnect(struct usb_interface *intf)
 	hdev = data->hdev;
 	usb_set_intfdata(data->intf, NULL);
 
-	if (data->isoc) {
-		device_remove_file(&intf->dev, &dev_attr_isoc_alt);
+	if (data->isoc)
 		usb_set_intfdata(data->isoc, NULL);
-	}
 
 	if (data->diag)
 		usb_set_intfdata(data->diag, NULL);
-- 
2.49.0.604.gff1f9ca942-goog


