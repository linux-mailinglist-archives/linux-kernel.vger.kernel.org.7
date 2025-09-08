Return-Path: <linux-kernel+bounces-805484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEBDB48940
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD2E67ACF8D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAD72EC555;
	Mon,  8 Sep 2025 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wisig-com.20230601.gappssmtp.com header.i=@wisig-com.20230601.gappssmtp.com header.b="RVTtCky3"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A538B2ECE95
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325427; cv=none; b=rJqGgOEjQ2VqmaO4SwyF4fUgxRAvgvX2XQoRoqt1xfm9vB+682N0L+C31JmWQSq54cN1JQltvqFAMYJj/X5xryXuw7MqiwvQ9XoiyR25rH6o6dGTu8SKpe3REd/flFc4w9yuSuvRTOrIwmPJTkFwNcHE/7RYLu2iMdWnaC2AOuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325427; c=relaxed/simple;
	bh=HMpgJJYsrvED0XmB3cjGizDlb35n/4utAX2/PRWb8oc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M1vDryATGs5XEySEKcL1k1JdAIZZhf5U0SbC2KmOuu00EQPet+dNRJsiHWdsP2Fg4wiMzukb56TfJCvbEuLlYYMSHg9laJGmHjLmilHFdCTRz46ruekVqta0cN/neAwlHRPbvGFWTicdOhAnpf2UqdgnkaJiGa+/q7U4zIeAjKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wisig.com; spf=none smtp.mailfrom=wisig.com; dkim=pass (2048-bit key) header.d=wisig-com.20230601.gappssmtp.com header.i=@wisig-com.20230601.gappssmtp.com header.b=RVTtCky3; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wisig.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wisig.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77287fb79d3so3350659b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wisig-com.20230601.gappssmtp.com; s=20230601; t=1757325425; x=1757930225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWTgQOxdqLA7bbACHF0iom2AL8JpAV4JtjBIv5pIaSk=;
        b=RVTtCky3hgXZBXaFDpm7MGfiKVoro2q+ModIiEjqwJDQuym9kpmkwTsvZcY7Q/iHXn
         3HG2bLeM9mzAfkt34v+SXxDrhE5cW01XAQVjWTmGQKprHccFnUNKdReUCAB22CREhzWt
         6F7XJUgpslPLTjPh1vbqf/0NjqjdgCOQgdEJcAo7r+3/koH0MWLWsYwDyKWCBzB4LpxM
         DpuXW0z740jjTF1e1ZwwKdwr6U2wxGoGBjJwfweooyAN/3FL7f3a7/jKBYceJsBH3wBu
         Y9ZHOB1YBiQkdCOHMa8gCAVeh5V1NrdAdZ5508NgxYBbGu0LRXlPJQhKtujPgwt+elzi
         UjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757325425; x=1757930225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWTgQOxdqLA7bbACHF0iom2AL8JpAV4JtjBIv5pIaSk=;
        b=BbnS7v3dCcSs+SET/sQUAtKSKMea8PWeOTh5UbXXxovT5wyST2Sty0HL2vn9FcJkj+
         xFX1Pn1iCEAR51Bzkt9pEvwtDkhMZ1AVzQ1gGjWrwm5KR8y27YDlGFP2RLYH2Koff9ZL
         szKZwteEKYmh5QsJvTs85VPwZF/DQWhjmmf2mqxFkv/cpdlCiqO2Lgsh+DQq8rNy5B3U
         sz4GqmtmXmsyFx8Qc3m8k0KNDMg9dou1n1hmIQqkcvp6rgnA2rTVKhm8op2iZFH+2FSQ
         f4Ur0aJnkxzs5VAoAfr4CxAS/THILhVWV/ltDM7Ph2NiG0E5ZsRx53mh1P0BmT5b8q+D
         dZMw==
X-Forwarded-Encrypted: i=1; AJvYcCXCOPELbPTniCaocLTUzt4P/fy/9KXTldmiCGeJB0OIkMGe7pbRSt6tBoQUpvdwN9RXd1phC1CaGQM/uqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx11wuS95aeVroBNBSXCzwhAGA104qatan3Q1HrC6U9exQmvDjP
	8sEfEv329aSkHucb8N5dzQ4KI3wMjUn0i9rxAjGYFtiNiIjS/h0OGuctvyjMouKzXKqYGXatsM1
	3t8JKjg==
X-Gm-Gg: ASbGnct4sX0v6DDXELE5+CX+81lRrrOywACFsoT8tYA3BmJC+Uc41vZNNrSS9GCaWZG
	uF1pUaHHxOf3qF7tNbQ1myjpIjcHU8bgwwQTkZOShpw6V7UDWRZMIuKtM9+2fTcBVF2wIJr/WEZ
	yBF8itwcBhSE91DxGjRQgIh4AKr0SiG7mO3E4wSrzUJcndpOQ6aep4DyXyoE3Q4W/RhC7lt//Hd
	dr4Z8REIMyFmhH1u8UbMz/kYBa2vpXbGZg0jtsk3fprdlQZoX6ulPTboTIICJ/7J06boMwEIGge
	pwPt4O1rwRLH2tiDMT+8GOCnvpEWaFnKIswvAvzFCX2t9/yyoVjRYLJweg5LCnLRS7/AjGMKb/1
	aZ4HOS/M422OwmfzDlmXNYy67
X-Google-Smtp-Source: AGHT+IFU1aSBrBrFZx2ZfVhEmk3pOf3CVfts7Reidk1Z8ewIFL0cEQIJNZQxjP6jAEen4fJ6zRs02g==
X-Received: by 2002:a05:6a00:1742:b0:772:5b42:63cb with SMTP id d2e1a72fcca58-7742dddbd66mr8479762b3a.19.1757325424878;
        Mon, 08 Sep 2025 02:57:04 -0700 (PDT)
Received: from ash-wisig ([14.195.146.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7741f5b3c1csm9190990b3a.60.2025.09.08.02.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 02:57:04 -0700 (PDT)
From: Ashwini Sahu <ashwini@wisig.com>
To: mst@redhat.com
Cc: xieyongji@bytedance.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] uapi: vduse: fix typo in comment
Date: Mon,  8 Sep 2025 15:26:45 +0530
Message-ID: <20250908095645.610336-1-ashwini@wisig.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix a spelling mistake in vduse.h: "regsion" → "region" in the
documentation for struct vduse_iova_info.

No functional change.
Signed-off-by: Ashwini Sahu <ashwini@wisig.com>
---
 include/uapi/linux/vduse.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 68a627d04afa..10ad71aa00d6 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -237,7 +237,7 @@ struct vduse_iova_umem {
  * struct vduse_iova_info - information of one IOVA region
  * @start: start of the IOVA region
  * @last: last of the IOVA region
- * @capability: capability of the IOVA regsion
+ * @capability: capability of the IOVA region
  * @reserved: for future use, needs to be initialized to zero
  *
  * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
-- 
2.50.1


