Return-Path: <linux-kernel+bounces-847745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE31BCB8FD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 05:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0663B0601
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24E126C39B;
	Fri, 10 Oct 2025 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ib2SFpet"
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945E26A091
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067539; cv=none; b=VorAg4yPmnjLc5CI7IddObSY1CNaDk3GHSpjIu8mhTQZQAaWAEdY1i3nSIMnwidv1eb9P3dqBnq1XcTAsJYnTPFXhwXOr0+4Aa90I9BbAuGgIn/Mih2CZjSNFNmkKj10kgO/BRArfcLsTTcjTnMioiEJzKdJjfqGQRliLBf8ynk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067539; c=relaxed/simple;
	bh=5qqJUczig2l29D4JIBSIymNxAk9sEevSR5zoATmnADc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n1F2halkVTKAWZfFc24OGKPJzYLp4EHFR4UH7oroykHRUWXe1GxEyiYZIvROuo+ZoV4NO07UDYRHv9MN9n0t0dz90RvNjEWzsAuhAgwTlHhD7pArOo5r+Acx3uV0T2dW9LP1PLqUU+VItDqoNVwbRAWu3n5DuDdq4nJKQmrpxCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ib2SFpet; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b556284db11so1446963a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 20:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760067536; x=1760672336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=caMS6Y18E0X9hrIxsvxznzwmexissryzyTlpkHtobr4=;
        b=Ib2SFpetce/YXj8vq5KGkxi7hC4F6vBHXNe78UdkjPBGMhvtM674Qo9s8r4OK8qD5s
         HkTvb5IVzIxgbYEbUKSZ0xS5YvyXvguWu9+OBDvtL2jDgggs9JoIsqyuA3r4xHWiPkpI
         cA+J8EHmBNVyENnkyovfw4HF52IWWb7EqZOIU2XR4QWS060k1hrGpHZllE3TbJe2WIvs
         Od/fvwNqtTOysH/soYwzNiaCySv1dgPK10TaCXpAc10t4vi4+ayMqRyDKJ/I8YH6jykt
         cOs/ZffUGQRMYXGdwHHSVHW6bjPhQqMKSIwcpfXUi+Ay/B9rXzItZWz7zeH3T7wkqSkO
         gptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760067536; x=1760672336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=caMS6Y18E0X9hrIxsvxznzwmexissryzyTlpkHtobr4=;
        b=Nbu/gBiLDJeexfUbXmYqivYdDApXncFkbvdVS38MLA5JJqzG5QhyaP5U54AjsiZ/aM
         0RDtRoLskwKRm0uRAJ8bCK+xLO0mEIMdSSwefnVUAMAHqVWp2u6MeJzXbe4hCm0UFCJV
         4llXJxNUKFkzIeK7ojpEQqHnuPvE6q1gqAX/H8VJgrBmf6WLIfg03H9aYSXajwYWhc6r
         UU+KNIccqFVjQawdoCutWP+k+rvZhCITZlSBySPwUuKAbUbs+PuTTuS6gNKJ3VGeVPYf
         boCs2ORRjHdouyj8L+s1hj8l7xO+/1A9eej6hOZ6PeJfQA2h44g7pyMZnRz2DnHkFaVl
         Gosw==
X-Forwarded-Encrypted: i=1; AJvYcCVKKKCf/eBLeLTa54AlyhHNE8522mmvGVzW/XRObONMxtp2vLoueKMIsY6+VSo0UVDgV81NN2IM7cQwjAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwruR20CeblsRV49xWKn/vGdMQDcVGFfOnf6vQWJGAh4FSGLrEn
	ZOQjHUco3L5MK6kLf+vcpQJWTkPxsGnSU0b04hopDt6aNgs9rO5OsVim
X-Gm-Gg: ASbGnctDdQ6uaDoPGWxs6DV+FUuu3fxtizGExbwiOVa3rR2lwRBKeulSSJRmbdBxjF5
	2nqqlCIpp4NEj0WyTe6JhvgMF1cAL3n5pYlE/62+dV/8vOhOO/0+uwZJ1eLUnvxYPksFU3UM2Hs
	kHw13Mog+gjWQBq9vqcEbe5OAz2ufm95P6hdWIc9L+15rQJ36D7P1sdxwWcAEuvdOQUNYbWziZT
	gO+hjZL9kjDGrwrS3JqVsMmEAeATZ7bfbzYa41I3spO2te5mAzw+7QB7zb98tTBMazGmWENoRdL
	K4AI35gd+HCxEM1AReJ4qY1SylvjSxp5mmsfZ1TNtfJzbSh7Bpqte3/TgHAT8j3+GhDdiWrVwy+
	c/2nJMGMYEUZMSSyT4HCFJHcfCL5mVhSiSCLHRX3H2HtgYwsi
X-Google-Smtp-Source: AGHT+IF24F2zhzRlHXkJG3vE8zteAajopgAiIJ6/HmBuwskVoW5wMnZM1SXUIGAoZsViQJiW5B9opw==
X-Received: by 2002:a05:6a21:329e:b0:262:5e70:3393 with SMTP id adf61e73a8af0-32da8138eb2mr13769287637.13.1760067535732;
        Thu, 09 Oct 2025 20:38:55 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d993853sm1260148b3a.74.2025.10.09.20.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 20:38:55 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 0/2] tracing: fprobe: optimization for entry only case
Date: Fri, 10 Oct 2025 11:38:45 +0800
Message-ID: <20251010033847.31008-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The first patch is to optimize the fprobe for entry only case.
The second patch is to add testcase for mixed fprobe.

This series base on the "linux-trace" tree and "for-next" branch.

Changes since V1:
* merge the rename of fprobe_entry into one
* add some document for fprobe_fgraph_entry as Masami suggested
* use ftrace_test_recursion_trylock() in fprobe_ftrace_entry()
* add the testcase for mixed fprobe

Menglong Dong (2):
  tracing: fprobe: optimization for entry only case
  lib/test_fprobe: add testcase for mixed fprobe

 kernel/trace/fprobe.c   | 104 +++++++++++++++++++++++++++++++++++-----
 lib/tests/test_fprobe.c |  99 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 191 insertions(+), 12 deletions(-)

-- 
2.51.0


