Return-Path: <linux-kernel+bounces-595121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF34A81AA9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 03:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CADDB7A993E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 01:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAB119E96D;
	Wed,  9 Apr 2025 01:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VVbHapFs"
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32900199FAC
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 01:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744162954; cv=none; b=Vu+MJnPedST07SVK5tFnGzFsbaczzFLe561KctQraf5CCH51XuMSDoBZIGi2dSUQ6QCWdNZn6CK23a6Z/AyrtnAB1tHhaG+ewpJUXTBd4zZ2Kbbae8yWD0HihuCxWtUOEzl9nJQHDls51NHqHB9aPGdQNdW1QQx/QSmCNy78ybg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744162954; c=relaxed/simple;
	bh=5toIafPmhc/haL3HG49K5CRcLsyLaW1wFooqUrjy0WA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hQKCktAf3fDk8hVLzdIGM3bu3bYmLwKkSeHHZn49DnZLVQVIileKYFwtrXrtK5stoNkx+U7UuD5ju09WfzUhemKMJ/6JLurqT6iHlj5byRajQwfy0AE4e6GD+zuU4UuLIn2MjxcCV3ppt3ADe3Bog+qeI98aeZC/EyektpIgBqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VVbHapFs; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-854a68f5a9cso504785739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Apr 2025 18:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744162950; x=1744767750; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oIEN3z0aQQM7LJjKHwApKcNtci83koae0N7JV02vw/Y=;
        b=VVbHapFscUd+qvXYQJ93XZ+/Ys8pTzHCtuuBpRCY4IO0EqZPXFkE+iarNaxCjlxIEs
         5tigXfpyHAkDbV08V6AqbPAlwMFywcJb4JjqZcqyJzlN1YmB4oIRNTMp1SJ9IMMsKU9w
         GDgKAfmdjqbTe5lnakMWFLZ53EqONsrxyXxl4KHkJoD/ZHHSu3wBD6B32E22kZQI6wpk
         zvMtiXa8x9WiPkAQ67/6ycwk0+ojZ4ynux5eBB1Ao0neYVHnkZbbOHDICwN2+a+dxZmd
         bx9/xZ/mfFmB9CL7ahmbk2LBKF35R81qpaST79vM4tJtu/mMS0aEt7xs+Ebt8Hpn7rgk
         t+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744162950; x=1744767750;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIEN3z0aQQM7LJjKHwApKcNtci83koae0N7JV02vw/Y=;
        b=f/owXPVPfjPDpfJi1I2BYkWm+8z1JQuioWsYn+AHV1QfqENsZzjX17bT5swfuhVrvP
         CH4NYcGVPkaHg/g6KiQ9ZrqX2Dr6RVGxP9ly/U8wl/fWuDmRgnsQYtUs6bNXC7svpm6x
         IqpTo5fDqLQjwn8+v3XjcPSh3UNbscoKUACHOKCLN5w4b7BPfG8UUtZAH5gV7PiWphrQ
         6EYLpEBIxCntYV0jWzwmAz1tsvEjIt1vc+DYsRUNJiRwZlC7xDuTNsYeGVQHOlm+kN+l
         2YYcKGqfidW+KEi0n8ZGEkZjzqdVdC1F6cV+uYsMf0BcWRkSQxoUwsVgV87h+jPqf+pa
         7oOA==
X-Forwarded-Encrypted: i=1; AJvYcCWkYBdU6H+WEO5TXxQLxnbCYQNH9vLhI3x6U3BmRXs82NUiOrdnSMg+T93kBg0I8O0NIjwxyJyj1t/W5Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4XqAGTeicjEOwAJXwAjGyHpjST5xo/aeuIWJwLNp/7o54dliM
	QpI3tyselgwGxI1Nt5ldXF2MK0jh5lCJSZTHtg/yoqGFHGV+dPKwVqfclTZ3y3+g7yuhyrB6FJA
	qX30F7P7/1Kj+dbzxIickzX3YuKmpL5L2
X-Gm-Gg: ASbGncsNBfqNOJU0yzmBvc4AMeRy349LDpKFoUPSRpKOPQotiF5EPbrPAI/xdl8Pj1+
	oLGfbx0cgl+3Y/eLNweT136uhi+BRdyGo00DgyGC8FiW8HPgbivy95m//1VqbPKpx9+Z7oM78jo
	pXJRikrcRT8yDYfU/lBdmB1RFE4x3RJlEVZTyuokg6gcsJCYosoCuLiHS/qTNxyiMd54nN5zbgu
	iSMzo60hi2wLd/HIN63dKEb0YmSsoFiJCffbxHFPcBM8k3ZH0kYJx7iRU3LhCsYe7hTjwUau9/G
	GGgrPavPV6B7yvUaLRHv31zljlJdpnmSt/W8XFNt+3u8/Tu3Xw==
X-Google-Smtp-Source: AGHT+IGM7Z8M7ncP4ETqffr0iKCymQadEZEMupFufdYPXiHD7qOLIGlk7QsWPMOkh6slQDF+A3/thCqHo4dK
X-Received: by 2002:a05:6e02:2199:b0:3d4:6ef6:7c70 with SMTP id e9e14a558f8ab-3d77c2cb51cmr14533575ab.21.1744162950229;
        Tue, 08 Apr 2025 18:42:30 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f505cfa2b4sm6542173.10.2025.04.08.18.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 18:42:30 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4B2383401A8;
	Tue,  8 Apr 2025 19:42:29 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 3F671E40F5F; Tue,  8 Apr 2025 19:42:29 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH v2 0/2] ublk: decouple server threads from hctxs
Date: Tue, 08 Apr 2025 19:42:06 -0600
Message-Id: <20250408-ublk_task_per_io-v2-0-b97877e6fd50@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG7Q9WcC/x2NwQqDMBAFf0VybmQTU4099T+KSBpXXaxGEpUW8
 d8bPc6DN7OzgJ4wsEeyM48bBXJTBHlLmO3N1CGnJjKTIO+gQPP1/RnqxYShntHX5LjNy8y2Oei
 mMCzeZo8tfS/lq4rcU1ic/12FTZzrKVMCQEqpVFakGWhdasEFX0NsDsY/59XjeTMdptaNrDqO4
 w++ON2DrAAAAA==
X-Change-ID: 20250408-ublk_task_per_io-c693cf608d7a
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
X-Mailer: b4 0.14.2

This patch set aims to allow ublk server threads to better balance load
amongst themselves by decoupling server threads from ublk queues/hctxs,
so that multiple threads can service I/Os from a single hctx.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Changes in v2:
- Remove changes split into other patches
- To ease error handling/synchronization, associate each I/O (instead of
  each queue) to the last task that issues a FETCH_REQ against it. Only
  that task is allowed to operate on the I/O.
- Link to v1: https://lore.kernel.org/r/20241002224437.3088981-1-ushankar@purestorage.com

---
Uday Shankar (2):
      ublk: properly serialize all FETCH_REQs
      ublk: require unique task per io instead of unique task per hctx

 drivers/block/ublk_drv.c | 92 +++++++++++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 48 deletions(-)
---
base-commit: 88e581728f3f0036110126adbaa0d88d3cd3b48d
change-id: 20250408-ublk_task_per_io-c693cf608d7a

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>


