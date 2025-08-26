Return-Path: <linux-kernel+bounces-786057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85699B3547A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850E81B235B6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 06:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670EA2F5335;
	Tue, 26 Aug 2025 06:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEkQoKn5"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E871514E4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189405; cv=none; b=fRaifgXe+g+WqnrIAz7aZeeBJZCmLFUeLXS6W47awPfXrJ0N0aHmz26Qu07Gq4MlCc+/qFnD2TuA4zD5l6E2me3zszr9/ly6wuWJZLQvNTw1OdD1FawTKDPTXoGoEtCPQM5O2dqHbH9YNLi1xicDulZ9MPfrJfzq8YsGDRkVk3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189405; c=relaxed/simple;
	bh=1uRVEFKi9vJV+/vtXQE4G/BtGrwhstO81Wap54XxkWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e0rfZYx5deU2hyNxME4dSn8s9oXdbRbCZTWzwpF0kIEiNEQpvrYP1fe7/S/TFH+gM0TKaRPVyvPBqD5Qcmt2c8w0FvsfyYWIqafS888i3WIrdgs1OgaSZDOHxZpc2L3HGOQqVaeeb/fwhX2o4ME1efhtxLF+9c5bBl3V1hUS22s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEkQoKn5; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2e6038cfso5821263b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 23:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756189403; x=1756794203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GSS9CL1BDt/KxL+nujeo0VUaPSx+hlw1HrZE8dR99xo=;
        b=ZEkQoKn5Ioyo6GeDku9TscbmahVpEm1fGKMbLQwrMPOPbta5jlbyFK9tqRhebyW+ix
         9GP9wT6fPr1qL0fkc4ZmGMxZcXS/tsk3mlpNpCdMKnGQeIUQVBl4Axz083fVV7N99S8q
         W9oQdASS16AiKgVREzYWhhLbvMmBDkWxtSyyAAlbtRDB+zFuij1lGRZwvq/GACEcWZ/h
         oILpSkJ3Uwz0Vxs1d+duZqua/f+M0z94ybAPyOnSinERKKUzSMl6CSu4t4XU5tkejspP
         +xs0QA1w3Jn1JMFZf8mSv/7FJ9xmvI5YMNNLl04pnif7kMWg0K+KjcBcfDn4KfU/pKDE
         Yylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756189403; x=1756794203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GSS9CL1BDt/KxL+nujeo0VUaPSx+hlw1HrZE8dR99xo=;
        b=PbpyfLDRxg0eeSOBTJljPC0YbKKObfL49MSiHBiPX35xR4ZGQWqWLZvNipizulM61K
         AQsfflWLk7lb5CuUoxH7gaXJoGek0TQJkVysZF6m1zAE4BkhuOfHk2cI7NaPACuhByAa
         Huwa01e3I3SCv4NuUEdUpuBtHpHIU6wtvA3Ys86NKCILFOFZv8/+ettn/1dOiJYuVhmj
         kwP7iK/npjC1422QFjqr+frTW++rlep5fdYl+JkCcPnx5x5QhZGUUcq69oKyonAkIPGq
         XX2/da40+sGMNACowWwR/KtYBLKtSeFJ1xLBbx5GlqouAj9l2tScnz2Z82wp5UQiTerO
         hFYw==
X-Forwarded-Encrypted: i=1; AJvYcCUlZgCAOl5/QjBOniuubdRwHMLqd2PNCDTl9S7pDeoR96zNgHT0zc0kpUbeISGOVJlZIXFGkh4kTPsAjS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzkuYRNVVahtqYvFAEU1gXmd/8Jg00bvp6xcPwqvZHAlhBUUiK
	mHikGAyDPqeaQNVn5f6KivOK27/B81iwC4nOMqBNesCfFKr1nwx3DjkH
X-Gm-Gg: ASbGncvXmXCY+ot9XqKGdYAzY7IjVaBFnY4nM+z2Q4y8Jv8WBe413ZJTdnVZWuPYBOy
	SrJYYdfxWaIBkDp+lQ+/9BjuzG0f+K2fidk2yUw2mPq9gMW6c0WC2NB2AfH5SEq2sB264WXYH4+
	nX58fEBtF157vdsCEvJac/+Uat21o8xuRjrzDh1ea3pcMSV9rn21PaHGehhs8UDcT8q4I/05c9K
	wq9cw3CsteHfseIs6PY36uoZSJKryselSgbmrcrryo0sJ7jdhtSROavDt/Z+XFuiY8GpgXArdmO
	ihPQBLOrRYQCDWFvAp8xrUG/HjW0ECby8KW5FzaP2IoKRd1PmA8L+RXckhnmxod6s2PBCNCVmGq
	eWjBZeO/iRwrKxiw/E6Sjdp/bh/hpsRikQnhFzO/0lkc2ukDybQOJLArpRP14znw=
X-Google-Smtp-Source: AGHT+IGRLTtVhf5gNNom+FlSyhvO5Na/XW6FPBbeHGtKXN2dl2ENf9MJuoeexJXgu1MdjlMBXZURAA==
X-Received: by 2002:a05:6a20:3948:b0:240:16af:401a with SMTP id adf61e73a8af0-24340cd32b2mr21363713637.32.1756189403516;
        Mon, 25 Aug 2025 23:23:23 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771fbbc3bb0sm492535b3a.66.2025.08.25.23.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:23:23 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: vbabka@suse.cz,
	akpm@linux-foundation.org
Cc: cl@gentwo.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	harry.yoo@oracle.com,
	glittao@gmail.com,
	jserv@ccns.ncku.edu.tw,
	chuang@cs.nycu.edu.tw,
	cfmc.cs13@nycu.edu.tw,
	jhcheng.cs13@nycu.edu.tw,
	c.yuanhaur@wustl.edu,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 0/2] mm/slub: Fix debugfs stack trace sorting and simplify sort call
Date: Tue, 26 Aug 2025 14:23:13 +0800
Message-Id: <20250826062315.644520-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the comparison function used for sorting stack trace locations in
the slub debugfs interface. The original implementation violated the
antisymmetry property required by sort(), which could lead to
unreliable ordering of the output. The patches correct the comparison
function to return 0 when counts are equal and replace the unnecessary
use of sort_r() with the simpler sort().
---
Changes in v2:
* Use cmp_int().
* Drop Cc stable. 

v1: https://lore.kernel.org/lkml/20250825013419.240278-1-visitorckw@gmail.com/

Kuan-Wei Chiu (2):
  mm/slub: Fix cmp_loc_by_count() to return 0 when counts are equal
  mm/slub: Replace sort_r() with sort() for debugfs stack trace sorting

 mm/slub.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

-- 
2.34.1


