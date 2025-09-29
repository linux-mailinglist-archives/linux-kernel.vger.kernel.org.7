Return-Path: <linux-kernel+bounces-835929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 567C8BA85F2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9455C189C199
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032CD2580EE;
	Mon, 29 Sep 2025 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Tqmkh2vE"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE9E3C465
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759133799; cv=none; b=tAsR6Vwt93Lr1YNTcF5Zi+c6FV0SRiPK9rbCiwW4ZL2ia+QYz9HI7nf5QHdNLRygeDpelkF8T0hEECdjsL6BCGJE5ovw2NvlDpnIGZI3gZtT9V13V1a38qiGp8EUhwjQFB9V+i6dqdnM8VlmS9oAXfKWQ4o2Qu/lkV4sOCL0eWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759133799; c=relaxed/simple;
	bh=fT9qct/EXdaKRdXVtW6iy9jH8+BPCKrXR25OTC7J/NQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Yrke1GfUzmOdHD4DeKG36dnEqUIWKOUUw6U3l8PDNj5HRR9ymWHdiSr3FjZZa9jWfAQ0tYvcgIUNDSGCz9QlyKZWvbvApxM/B/4hH7LBRaYV/GR83M3VmlO9Gx8O9f7soNdJgkR5+E8V7zaKe4ptLCNKCrQocJEJ7Dhy/yceXE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Tqmkh2vE; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-330469eb750so4957296a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 01:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759133797; x=1759738597; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sj/9RNZ+daEA1X7yKVXnnH8RJIjqfJc52SMXbLdJl+Q=;
        b=Tqmkh2vE0Cb5IIxMoxf/dGP9XjXsymiT4XuBEuV57NHbwuKMleNlh2uzZ19rIssign
         TUpz72l26vLFppqvKNnUJjma1wxTjOki5Vhe35kESKMDoWDMV4Kil0YxBACYOHIk9jEG
         +tuuNMXYmoPHZi96vcHa60cQ6FoPE1xEN1PKb7nL1gcFNN9NQxLLNN+xbWTNeTHsJCku
         AIfq3JKRBh9ziyrGETGuggEg9t5e/iRcOJZLDycGV3bMuzp52nhqaZPVaPKdmDT0XMqV
         Wvcf6ZEWZ5fbB+NcumejHDWZfnK2npUhI9hUD7ufYxqc5LuaGzN2TY8AQ3Rzx39nWbT7
         hiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759133797; x=1759738597;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sj/9RNZ+daEA1X7yKVXnnH8RJIjqfJc52SMXbLdJl+Q=;
        b=tTsYjZppS/eMXXkTB6RZ9kDonuDXQWLHC/Ocrxf3almkeTI61xk0ZmdMDiqN9xJw3F
         f8Zeai8NwnS6OYVd6QG/hQ0oTc1sX0xqgraQS8oNw+hGT/hUZ78ZhN1bZzHusJ2akaXV
         HnNnsZWt1/D5RTcl/0sc/st3xL4x28Gvznem7actLgiQM9mAIN7ddoehLL2Tfh91wq+v
         TfLcCF3pXmBfr8B9Z2Ydn8/+abap+hka6Fd8+q1fKBTLjbQNctyjk/L2olZjhPiE6f7e
         WlxJl3OH16B6OLGYUw7TWlgxQrScV0uEePUhy/FNPTXZKbF8ps4bbfNGbYndwQDMA/57
         /BPA==
X-Forwarded-Encrypted: i=1; AJvYcCV+cXRT8xQ9oeI2XPtzMEDet7tKZe/aI0CgkOvtqTOqrv4YlWpV4Ey96voS5ATS5k/75fAPdiC0hBQTo2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQrw0TgVM2XFLdQdUQy+pi3hD3uEGTRR4CeAgmSPNohlm9bBLf
	U6GyUx5w0eSQmA/6qyIjk8Q9Qkt0CVnkMMKyDRZBcKuQ3kW6k8+zE5FWhvq52Usyr10=
X-Gm-Gg: ASbGncswlVYN0mXPbHCLOHiYbNDX4gpA4D3DUrHiFfjU5TnaNPuaEyw+1aa+IvHG2/p
	u31Y/Z2hOB1qUFkunnathwEet88gBeUHtW6rheFcr05zcWv9PVI2h8kaXw6U4lS0eiLSXvBmXXm
	SsStqzLINs0MZDngkvQSHiJCn9knWip7bjttiK2dRVRMsIlNT3i9RdCiGAvpoTFVglxutjiol1I
	suTGT3hxqkVdNdb+xBFc61arhSBwpObEFD0EgtTkZbhbHhIFbM3nSK+Co1/y/Arz34wqZW52LU1
	dDvUsaXeoFdQ356buWn8lA5vURVzb+ev5IOJtNkCkls53amBkE9x7m/GWfoXQF5HzCXY1JGv19g
	I80b6BQNIOc0dVm6GXi+hh2DjV8ND4MDHPr515ryxzgYj9bsLzUuIK5YI4eTCecyj
X-Google-Smtp-Source: AGHT+IGiP419V4N9F1bGIFD547BjpWNVr9OZdtoGYQyB69UrN3gsFpDrq3xuXiy3FTY/yZwcTTCLTQ==
X-Received: by 2002:a17:90a:d60f:b0:32e:3837:284f with SMTP id 98e67ed59e1d1-3342a2d8c3dmr18391337a91.21.1759133796626;
        Mon, 29 Sep 2025 01:16:36 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be36bdesm16286509a91.24.2025.09.29.01.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 01:16:35 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: corey@minyard.net
Cc: guojinhui.liam@bytedance.com,
	openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipmi: Close the race between __scan_channels() and deliver_response()
Date: Mon, 29 Sep 2025 16:16:02 +0800
Message-Id: <20250929081602.1901-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The command "ipmi -b -t" would occasionally fail:
  #ipmitool -b 6 -t 0x2c raw 0x6 0x01
  Unable to send command: Invalid argument
  Unable to send RAW command (channel=0x6 netfn=0x6 lun=0x0 cmd=0x1)

The race window between __scan_channels() and deliver_response() causes
the parameters of some channels to be set to 0.

1.[CPUA] After ipmi_add_smi() calling __bmc_get_device_id() ->
         __scan_channels(), the intf->channels_ready is set to true and
	 is never cleared by any function. ipmi_add_smi() then invokes
	 __scan_channels(), which issues an IPMI request and waits with
	 wait_event() until all channels have been scanned. wait_event()
         internally calls might_sleep(), which might yield the CPU.
         (wait_event() could also be interrupted by an interrupt, causing
	 the task to yield the CPU.)
2.[CPUB] deliver_response() is invoked when the CPU receives the IPMI
         response. After processing a IPMI response, deliver_response()
         directly assigns intf->wchannels to intf->channel_list and sets
	 intf->channels_ready to true. However, not all channels are actually
	 ready for use.
3.[CPUA] Since intf->channels_ready is already true, wait_event() never
         enters __wait_event(). __scan_channels() immediately clears
	 intf->null_user_handler and exits.
4.[CPUB] Once intf->null_user_handler is set to NULL, deliver_response()
         ignores further IPMI responses, leaving the remaining channels
	 zero-initialized and unusable.

CPUA                             CPUB
-------------------------------  -----------------------------
ipmi_add_smi()
 __scan_channels()
  intf->null_user_handler
        = channel_handler;
  send_channel_info_cmd(intf,
        0);
  wait_event(intf->waitq,
	intf->channels_ready);
   do {
    might_sleep();
                                 deliver_response()
                                  channel_handler()
                                   intf->channel_list =
				         intf->wchannels + set;
                                   intf->channels_ready = true;
                                   send_channel_info_cmd(intf,
				          intf->curr_channel);
    if (condition)
     break;
    __wait_event(wq_head,
	    condition);
   } while(0)
  intf->null_user_handler
        = NULL;
                                 deliver_response()
                                  if (!msg->user)
                                   if (intf->null_user_handler)
                                    rv = -EINVAL;
                                  return rv;
-------------------------------  -----------------------------

Fix the race between __scan_channels() and deliver_response() with the
following changes.

1. Drop the redundant __scan_channels() call in ipmi_add_smi(), the
   function is already invoked via ipmi_add_smi() -> __bmc_get_device_id()
   -> __scan_channels().
2. channel_handler() sets intf->channels_ready to true but no one clears
   it, preventing __scan_channels() from rescanning channels. Clear
   intf->channels_ready to false in channel_handler() before starting
   the channel scan.
3. Only assign intf->channel_list = intf->wchannels and set
   intf->channels_ready = true in channel_handler() after all channels
   have been successfully scanned or after failing to send the IPMI
   request.

Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 8e9050f99e9e..73dab3b21221 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -3405,11 +3405,8 @@ channel_handler(struct ipmi_smi *intf, struct ipmi_recv_msg *msg)
 			intf->channel_list = intf->wchannels + set;
 			intf->channels_ready = true;
 			wake_up(&intf->waitq);
-		} else {
-			intf->channel_list = intf->wchannels + set;
-			intf->channels_ready = true;
+		} else
 			rv = send_channel_info_cmd(intf, intf->curr_channel);
-		}
 
 		if (rv) {
 			/* Got an error somehow, just give up. */
@@ -3433,6 +3430,9 @@ static int __scan_channels(struct ipmi_smi *intf, struct ipmi_device_id *id)
 {
 	int rv;
 
+	/* Clear channels_ready to force channels rescan. */
+	intf->channels_ready = false;
+
 	if (ipmi_version_major(id) > 1
 			|| (ipmi_version_major(id) == 1
 			    && ipmi_version_minor(id) >= 5)) {
@@ -3633,12 +3633,6 @@ int ipmi_add_smi(struct module         *owner,
 		goto out_err_started;
 	}
 
-	mutex_lock(&intf->bmc_reg_mutex);
-	rv = __scan_channels(intf, &id);
-	mutex_unlock(&intf->bmc_reg_mutex);
-	if (rv)
-		goto out_err_bmc_reg;
-
 	intf->nr_users_devattr = dev_attr_nr_users;
 	sysfs_attr_init(&intf->nr_users_devattr.attr);
 	rv = device_create_file(intf->si_dev, &intf->nr_users_devattr);
-- 
2.20.1


