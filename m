Return-Path: <linux-kernel+bounces-759586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA37B1DFB8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5D71AA3A2A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6AA270569;
	Thu,  7 Aug 2025 23:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="Zy4dLUvM"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD0226B0BC
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 23:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754608021; cv=none; b=csM6edy3hPdXMsrPtdWj33SDZAK3yHd9+LrX5sVbl8iFeFfzGsBQ9Zmfptbx4nAmikQ68GfkxrzPi+WUAmiUbgPRNZc9oI0PdEdhidgXMU681B2nqzS/7Ut5/p4yDuXrHW0uzIjCk6abhZpOV12ZiMl3pEplwqENQe+ni1HsZck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754608021; c=relaxed/simple;
	bh=11osodxpZDPdqf9SuVef0Ee8RS8R6ycP2cLEpWfApw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfKW8ZFYFgAG6i3A6r+mxdRt+uekCCow1oJ75K6fIXhbeqPWwMYfV0/rspfB3AY3x2+dqIkDJXiHVgvm3IKSJM3SgzLM5Z7LWCy1XYdFHTNgK4mBB4A6hArlak/+zrJJoXpa300gtJ6GUNU4d3MOVleGNxVe0jwxzDXdmWNEyGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=Zy4dLUvM; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-41eaf6805ebso907130b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 16:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1754608019; x=1755212819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0LAU+2u10/+0C78Muwt+CLP14PGQsov9MOIPNpjq38=;
        b=Zy4dLUvM6YdftK6EcF1IlE5XYFQxKJdPJb6BJg7dpApDkJsjyWFzAO01oahHvXvogr
         2aXEmIPWdyHIM1a6D+8OqECpYFwpLC6dQHltdTlwKf+/upgfV4jn4BH6npELqnp98Fzl
         eVMQFo1JXj/4+5XdHFG63s7wuU7lxFetMd/lWOQZ2tGYlmzyqJSwBwUBS84M/D+hqB0F
         I+c/2/NUrWmbj1GJZcsgItdtBByGVtCaBdbDUv0B1CdHqjNtZWmdvcE7bK34WPhePAXs
         XRk2RP39O0kxEXjlL1MIWRSaJ5WcyNe9VSRWLkwIZP+bWf/vn+/qWe4yZhMMFyF2niFX
         MOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754608019; x=1755212819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0LAU+2u10/+0C78Muwt+CLP14PGQsov9MOIPNpjq38=;
        b=tBJ5bkbCmNLqohI5RlrNK/D/Y+R+XXgAPGmrkSWZJpPY/DBVWFPzDtTlIx3FKuXNGY
         pS9YtXKC1cSNoOtxxgi3qYHiEdTQfWpeOjvXyApwwnfExfGa+HCc7pa7Uy5JPpX9FbpF
         XXJ5fvGxN1UagOW1K/474SBTcbEwBo7nf7Kl7iQkuBzcoPkNaV4GhwhN8tl/RdXtb8iA
         h5E9XlVu+1LmN9f8vSeP7BL9WV4JUkB2PhkHYuuz/Qfs5sDdqidhbmmPq1ID+g1GUMPD
         ATc8XIp+wBWVSObzQ4k0BjnRzErWIqeEqRSrKM1kF6E+Tvl+59IfBiKzGMNrOeLvVEhl
         HFgg==
X-Forwarded-Encrypted: i=1; AJvYcCV0Acz6bXMeR3e9Kb4CLjrSoHHp2xZM5j+tJqEkdw+uzi6AsZdJNMc7W80ufO3jAPk6frDqb1pmrHaq8oY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMNoKVS2M064y041PRKaJlObCWKvfvVS6D0EV+c+RAjGDigZ5+
	7u0wnIjt7QlLohsTvS1Wu1FcHJfKC8Oh4gYpuAEyVIjblfrJtwFdk8JOaO2BDIoYvSs=
X-Gm-Gg: ASbGncufI9X9Geycq2z5VVVbU8uC53+kN/EwKPMNALpyd214DFH4ACfwFplQeWvargA
	i07/gxeImn9SM3QfoLx702zzP3r+xOMpS6h++9OyEGAi/qvJFM5lqLdb8zhvlgiMMckwzKMjLsC
	uHkT3+zqcvNe+Zn4ZzK4Rfig/NAwKe+eaMwJUf2JBQ1H4SFwij70DOOSYBkxY7VyNI5oR2AoZBZ
	K/jwub8NpDUPTQe+OqANOtxa9pynQa82f9FaBPtvxABL11JQ16XQYuScQgRe3koCghODHmV6LNw
	5Yw2AjnH2FiAY183RgFvciVwbYZrx6PjYmHlTT9Rew2bUUscgq7EG984Baz+UcL/I3PP1IQy2Uw
	dDHKVCbgGxeMnyboR
X-Google-Smtp-Source: AGHT+IG3YI98db3U5jyEiwKVKzbDF/UC2VWFGKQazNVvN6GxHdclxmttgoqEdDwj/6d2EukNXgKTUw==
X-Received: by 2002:a05:6808:d51:b0:435:7814:294c with SMTP id 5614622812f47-43597c1d781mr783107b6e.16.1754608018731;
        Thu, 07 Aug 2025 16:06:58 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:e698:accb:897b:ca29])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-43358892c0fsm3827725b6e.20.2025.08.07.16.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 16:06:58 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: Frederick Lawler <fred@cloudflare.com>
Cc: openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH 3/4] ipmi: Add a maintenance mode sysfs file
Date: Thu,  7 Aug 2025 18:02:34 -0500
Message-ID: <20250807230648.1112569-4-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250807230648.1112569-1-corey@minyard.net>
References: <20250807230648.1112569-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So you can see if it's in maintenance mode and see how long is left.

Signed-off-by: Corey Minyard <corey@minyard.net>
---
 drivers/char/ipmi/ipmi_msghandler.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 72f5f4a0c056..5ff35c473b50 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -432,6 +432,7 @@ struct ipmi_smi {
 	atomic_t nr_users;
 	struct device_attribute nr_users_devattr;
 	struct device_attribute nr_msgs_devattr;
+	struct device_attribute maintenance_mode_devattr;
 
 
 	/* Used for wake ups at startup. */
@@ -3545,6 +3546,19 @@ static ssize_t nr_msgs_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(nr_msgs);
 
+static ssize_t maintenance_mode_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct ipmi_smi *intf = container_of(attr,
+					     struct ipmi_smi,
+					     maintenance_mode_devattr);
+
+	return sysfs_emit(buf, "%u %d\n", intf->maintenance_mode_state,
+			  intf->auto_maintenance_timeout);
+}
+static DEVICE_ATTR_RO(maintenance_mode);
+
 static void redo_bmc_reg(struct work_struct *work)
 {
 	struct ipmi_smi *intf = container_of(work, struct ipmi_smi,
@@ -3681,6 +3695,14 @@ int ipmi_add_smi(struct module         *owner,
 		goto out_err_bmc_reg;
 	}
 
+	intf->maintenance_mode_devattr = dev_attr_maintenance_mode;
+	sysfs_attr_init(&intf->maintenance_mode_devattr.attr);
+	rv = device_create_file(intf->si_dev, &intf->maintenance_mode_devattr);
+	if (rv) {
+		device_remove_file(intf->si_dev, &intf->nr_users_devattr);
+		goto out_err_bmc_reg;
+	}
+
 	intf->intf_num = i;
 	mutex_unlock(&ipmi_interfaces_mutex);
 
@@ -3788,6 +3810,7 @@ void ipmi_unregister_smi(struct ipmi_smi *intf)
 	if (intf->handlers->shutdown)
 		intf->handlers->shutdown(intf->send_info);
 
+	device_remove_file(intf->si_dev, &intf->maintenance_mode_devattr);
 	device_remove_file(intf->si_dev, &intf->nr_msgs_devattr);
 	device_remove_file(intf->si_dev, &intf->nr_users_devattr);
 
-- 
2.43.0


