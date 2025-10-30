Return-Path: <linux-kernel+bounces-878900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6951C21B30
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CAC7463DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8935A365D52;
	Thu, 30 Oct 2025 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1lVw3Fc8"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC83213E9F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847777; cv=none; b=EB9Lky0BWrUHwwNmhA/0QDz3z7paSpb7AYSm292ImC9D3Kb9YOYmwLMgYchrEzhaDEJkbWQtx22QkX0gcy6FfzKmZT9qSut7wQQbHXTG3JzALDwpSekvsHVQUAnluQ189o/PzhfW5HNMPCtTnq0TdCr5VqLuuid/zOmChwwtsAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847777; c=relaxed/simple;
	bh=Hs1pM8LrCPsKFJMLLjY40/qaHszKmItfHSs5Ip57vv4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aeYpGYI/Wn0bhaU2pmmfX4Aw/TtgP78JKgRNk+lWd5HMOageW+7y6hy7nJEl6VSMODoupid2jJdBcVGWsTobZCUlAtbI8rPaNIe2r1C82h/YASn7fM4d15SSwkVxER4h47Lpr6riFaRMW5OB4fMugCFzCkPlZajey/NPQgu3Y9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--thostet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1lVw3Fc8; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--thostet.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33da1f30fdfso3059451a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761847776; x=1762452576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pxbU2yjowbmDAWtqBINWVzp9cCDjUVE/Z7xeFsXr6PI=;
        b=1lVw3Fc8wL1jBa7zFVcl/cJcWzRyl9gjk7pXGec0peLITzTw0SQBuozZllmN+GeJYl
         JluP9K8N7wRmEgco4O0Kzfka2ZBJq35V5zmFk70LuHLGqxQuBDJ/nD3FjK6gtuT05J+/
         ICR+M2NVxeowcp2HsgvoCMT/IzWGVmjX+gvYbb0ulB9iQl9u6+VlE86g+/UIqWscB6eC
         QIw1TcbIB3KDazBrPLhj+8ffVoDZhHdDu0bXq5JpN82klfTnAtwcI4Fvh5TDMtduTTCK
         Tq9JBPRh4rfuJ8mq1talBKBiSXpso6FeRKiwNlHoqwHBrsNp6nuNfBh+xRrsE1WNsRi+
         tkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847776; x=1762452576;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pxbU2yjowbmDAWtqBINWVzp9cCDjUVE/Z7xeFsXr6PI=;
        b=aWjjPJbwn40/L+SZwsFIvN3tGlgJM5clMGG/TYLs/UHeavi3xmqgM4uMK02jWD3D0O
         xAXbofFFNE1g3KoqiND2CNK7nV0Njc4BmrqyU19wr9gAE11qb3HtDLl0jfyXecCqjuM9
         60b4AUVxS8F34maNZydm04QFXbUXqIsVm7ghukD03QYsURWSRCwJJ/54CcFisc+v1uBb
         UPOhjuh5cL15gTD6G9afiVw1e7QgqnGBSmC+a8BLY3iLm2J5LyPAS/V55d0yQ1WQAFaS
         9roK/U2FOeQteLq6ROJp8XihYzCXGYOymOkBPYtw4xSL699+YSzOCIWjRjvb/j6yKiPO
         mqfw==
X-Forwarded-Encrypted: i=1; AJvYcCXm6kQahYbF9SsdDr53PGjlTfuH2Mt7o12pmQCmvR+K64r5nxkosYVGUtGR3Qu4qBaxGk0RFN3awik0DTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMbD5rxhTT3SdMaLwsHDzCjyNM2yQy6/wyGbHo3Fq2FbgM7wHf
	X7WfGFpf4gKKpFQU7cOHDB+0KuvBvt4REliNm1Fx1x8EDoCsJLzgaS05RlLf0O7jl4q+jJbAxEw
	5S9xRa6QTqg==
X-Google-Smtp-Source: AGHT+IEKGSgDJLK8DZHzMkJrDQDVHZwHSDHdaAuqpHRm1Zrxjo98F2lFQTGqgyjvBI4CUV7pCmHq1okdBWDF
X-Received: from pjyw17.prod.google.com ([2002:a17:90a:ea11:b0:340:5f65:4ff4])
 (user=thostet job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:51d1:b0:330:84c8:92d0
 with SMTP id 98e67ed59e1d1-3408306b9damr858011a91.24.1761847775593; Thu, 30
 Oct 2025 11:09:35 -0700 (PDT)
Date: Thu, 30 Oct 2025 11:08:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.997.g839fc31de9-goog
Message-ID: <20251030180832.388729-1-thostet@google.com>
Subject: [PATCH net] ptp: Return -EINVAL on ptp_clock_register if required ops
 are NULL
From: Tim Hostetler <thostet@google.com>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, Tim Hostetler <thostet@google.com>, stable@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"

ptp_clock should never be registered unless it stubs one of gettimex64()
or gettime64() and settime64(). WARN_ON_ONCE and error out if either set
of function pointers is null.

Cc: stable@vger.kernel.org
Fixes: d7d38f5bd7be ("ptp: use the 64 bit get/set time methods for the posix clock.")
Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Tim Hostetler <thostet@google.com>
---
 drivers/ptp/ptp_clock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index ef020599b771..0bc79076771b 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -325,6 +325,10 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	if (info->n_alarm > PTP_MAX_ALARMS)
 		return ERR_PTR(-EINVAL);
 
+	if (WARN_ON_ONCE((!info->gettimex64 && !info->gettime64) ||
+			 !info->settime64))
+		return ERR_PTR(-EINVAL);
+
 	/* Initialize a clock structure. */
 	ptp = kzalloc(sizeof(struct ptp_clock), GFP_KERNEL);
 	if (!ptp) {
-- 
2.51.1.851.g4ebd6896fd-goog


