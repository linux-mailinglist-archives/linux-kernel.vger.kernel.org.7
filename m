Return-Path: <linux-kernel+bounces-765968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2033AB240AC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78871BC0E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8452C08CA;
	Wed, 13 Aug 2025 05:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MmliNpgi"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BB12D0C84
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064156; cv=none; b=d2wvW0ichqhhcbQKubdRstT+KhpMEpfL/wxiEXQtGT9IorLHP8G24oIcm8+oPUtjgV8e1s9E76vhx1fdaiW1OQ10S7QEmkcYRiktrZSbkqKrN6G/RuUfwAUdE/9Va//BuOOnkp/4OLC9P4uVCAACiK7rjAWroGmbDzZsyH8teIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064156; c=relaxed/simple;
	bh=5XEzjMGKnaeMJFhQb3Nwzbat+idzevLzr/emeLMFnok=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Sxlb9C01IvvDxJvREx+FfGoxzssZCoT6YSQXBCHolrIkwxmn7sT9fanKtKa0FWGGNKrn23PEiGZpzgzbNYI1x9asNMVNaPUDIexUviEb2mtxX4meG2MR72rnrslFBG1/MnN+7nnXKKK5QjwrKEsQ7LSfId1h2X9k5ECq3MacIQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MmliNpgi; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-458baf449cbso59712935e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 22:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755064152; x=1755668952; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1NATFWYnL9FpvCQHaSEVWqiysmgBFz5wmTJhKI3JDuA=;
        b=MmliNpgiE/VmRLHxzAL0+iYkaLFqIm9XMYYpGoXkcCzDp1VE3K+5MqRTwqY2MKT0Q9
         UYnD9ZkOVjPAp4HTLJhXxtFsHVPDPteUtVL/XEwK3O76gkIdu9eIPT8chZnbMMee3UDe
         kgfaTZBLJdvKhFVU6dosQTRlRlIFc912tK4LVFnWyAw6pZtbi0yQDPY1v1ISCAOfI7qI
         c53Ibvhg6ZSTjr9Rh/495y5pbY4h6pNnxfBCweBdFFFAXJgmYckQe62/un09B3tv8zBJ
         TV+9qAhEu1s+WIJTCdJkixR601r0p2yuSpfkuLxbJuhRu6RFSnVIe+O+Zd+YqWP+xh4I
         38fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755064152; x=1755668952;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1NATFWYnL9FpvCQHaSEVWqiysmgBFz5wmTJhKI3JDuA=;
        b=ahh4GCUDXN4TA4yVrL3ybhTqSqosS9Oy41ywNTAxcLEINyN1F2ASpAZO5gJ1Xahm74
         yiUETk2+jDX/55XYFtaw/hPmi/HTY1IguDJaGbgl/C8qE1OAoxkWmW+Xh8UdbUwKnqD+
         PdX2wOIWKdhInKMo8ka8I1w2QQPUER+6K8ayeXZiksI4hjw/xUUW/tPwj3dBz+Khy1eK
         tCLqvoRe4fk5fKFoCkXCXRs7j237YKRjxAIA1DeRQ8yMgvJeYcBp98a0fl4qn2tbT/XY
         6yqk97nLZYJCxz7Qp9TetbN0BaZLq/W/6aM2ayR3Ug5Iz9b4qb726tYwxgudLFwDj7Gv
         zCNw==
X-Forwarded-Encrypted: i=1; AJvYcCVo29/OMWslYuQeDSEpXSd+JXuCafY06hWsz/oGu6LCDEwL4G2pJk6m0l1naXBhVSGeQ01PI4mVn45doMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIus/8Crg+DlzFobaCpg7kb7Cdh6lnG0Xb8r2Z7hlO2v7jnYW7
	tb4FnH8RlY8iMe5Z/HKNpDxN4p7kh9Acqgqrrj8QOjkUk0DpQvA07Su6HWnQcEOj4FI=
X-Gm-Gg: ASbGnctpd+Lw0nPn9vjLL2b99ygOrRwIHViVc+svONS/+QIoPGtwCKsVXxInyof8Qnp
	Y+X9xPLUEv356J4VkQkrRqVSxxDKT37VZjScrKXsny9sHKXduSsfkDiCOzqhCH1Joi/xqzXVdXw
	Z5F3VXoiCkEhqp/me9seOMxKFqZXUUdgRXXPkBITMBi3/dzLGdrGM8wUo1vIAy4q/MjqfjXLnmL
	ebaOhZJCCWoE45JqSTdbYDnhWPJFakY0n+xHLc3OBJgXsTeIA4UvOX0qR48MM8qx0mB4+hohr4x
	EEbJCyFIf6Az0t05L4tmgssZb3lK757avPWaC6DnzwneYHwv94Zr/qE8VtIbzr/2x5TLWStlpto
	RRrt/SBaBRrzmoCeRdOIW46r04Tdk7MXe8MmU8g==
X-Google-Smtp-Source: AGHT+IFDvLxnIU17Hp8mu8s/hfxqo91PU/ydIDKmiqnIJjDK4g9R/0BJmMQ3yTeiQ09ZscNds3uIlA==
X-Received: by 2002:a05:6000:4205:b0:3b8:d493:31f4 with SMTP id ffacd0b85a97d-3b917eb6c5bmr1136780f8f.48.1755064151797;
        Tue, 12 Aug 2025 22:49:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c4696c8sm45376480f8f.55.2025.08.12.22.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 22:49:11 -0700 (PDT)
Date: Wed, 13 Aug 2025 08:49:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	James Bottomley <JBottomley@parallels.com>,
	Ravi Anand <ravi.anand@qlogic.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] scsi: qla4xxx: Prevent a potential error pointer dereference
Message-ID: <aJwnVKS9tHsw1tEu@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The qla4xxx_get_ep_fwdb() function is supposed to return NULL on error,
but qla4xxx_ep_connect() returns error pointers.  Propagating the error
pointers will lead to an Oops in the caller, so change the error
pointers to NULL.

Fixes: 13483730a13b ("[SCSI] qla4xxx: fix flash/ddb support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/scsi/qla4xxx/ql4_os.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index a39f1da4ce47..a761c0aa5127 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -6606,6 +6606,8 @@ static struct iscsi_endpoint *qla4xxx_get_ep_fwdb(struct scsi_qla_host *ha,
 
 	ep = qla4xxx_ep_connect(ha->host, (struct sockaddr *)dst_addr, 0);
 	vfree(dst_addr);
+	if (IS_ERR(ep))
+		return NULL;
 	return ep;
 }
 
-- 
2.47.2


