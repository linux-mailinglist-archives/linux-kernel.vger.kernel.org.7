Return-Path: <linux-kernel+bounces-747180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B70B130BC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0845A176657
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001C321CA02;
	Sun, 27 Jul 2025 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="Qbj2kGuo"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01A181724
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753634837; cv=none; b=fRkgYMS0SVidgLnFq0rZQNr/bKg9HY1bDtMyx46UK5j9BPfVtcEfbKx7NDgCMAN4wKqCVTaIRAZStOwOvNlKWGa/hO3QlCw9buXi483vpovtSXX4kWIzFG2AyrsOQclcHbTJMcAEOm2YNj6L9/Z79q1XXXyZ20Ul6AxihISLt+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753634837; c=relaxed/simple;
	bh=M9yVNk5VPH+nJY2mgtSbO7qIg2TP4lSJLOthOIJsw+8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R3rUaDkzHYxAz2aSoxwzQ8Wj9APXphFZhg83Qb8L4HHoctc4XCYWXLWXa5BdukbSQeZudi/YDyJLhhaXxD3piGKEryqEb5Ay2IanK8K7OoeG1dSiz5JPErpO+Wj+rycpA48FNRrOK7RjR7089+MDVg5Fk/i7S4S7C0Ea7aW+d80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=Qbj2kGuo; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-73c17c770a7so3928046b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1753634835; x=1754239635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BXCicH177Dmjz8c5JGGpzyWjrgYU+8Yecl6WQU8pDFk=;
        b=Qbj2kGuoRGLvdzyu8aC2pU5sy16Lr9AJdS8iHElB8kG2e5TkbBUolA8NBB53xfXqOa
         HDgd3V5VzjZHK/B4U3oQYVm5W+s7fasY6lbtsDGxs7vhkOum1w9DkmXIJJT4oxR6zOTm
         voq+bRYPW6useXKR4+ND3tEs8CqoFmqhAelC1n2vqOxCjI5QjKzviIyr7oD6kGSUyJ9f
         gmuGNlLCNzH1Pu+y3PfF5jVvFe3cxjlXKhrH6qszYMRJdqnxBlAtOmCk4DM1Ng0wXUTJ
         3BDNdDFr0V3Qj2inI217BawbZlhYgC9pkzpvn1ZHzcvF03nDScjke+sWGRwg0T0T7Kor
         wFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753634835; x=1754239635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXCicH177Dmjz8c5JGGpzyWjrgYU+8Yecl6WQU8pDFk=;
        b=D0ESmEMeyXsuJC/ZyUAqvyWajhK7nzGvNosDt+A3rzi3e/xOrPv9LrqG2ODsnV1/vQ
         m7hUJ+EyE9Jj/L4tepaS8vGyhd8ZW1RBsjMNazG3XV/YlpUwe5/+SYSvawB1NKpg3I0G
         n+iSHuL2YdCN49AgFhhyQ4lpUxanbYK831mLQ5xV1L/dZgY3zRtAxzVPEeVqsuX8Da/a
         0gmkfoifvdGjn6uHKSsr7h75pIiA5WNho+1S6dAGqOdwNvFFIY+IsQJVXtpkxZbtIdyh
         Qq9c9/m/HEiikPZ5nTpmNk4Sp6rfib8AWZThKX+VbOfuRckd1W5MPRhPhnsc4N4r9Sjn
         5Shw==
X-Forwarded-Encrypted: i=1; AJvYcCXCS8vkyeI5d7FqO8weciXaLfb9AD3puZK2Pn3/LjEoY4u/p9EzRlpRxDdB0WP2iwEuyOI/GAaRrGTjc4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKU4kO7d0JJe59v0sEhZF+ZolSFMHkWK9WulGEJKcvYfbxHXox
	aJTsqfL+u0yvhXS/dt1ruBj3gqMeTKjd876BvyWxQ0L7J9nT8/LCEUwZodCnFpAWPzQ=
X-Gm-Gg: ASbGncsVzPf9rew+PQ80w3qcl3SUZ0v8EjDxoi2JF1PqjjfQELSofd59mzwg2cQgd6L
	Ts3Js9yETTZijJYDBGaP2F8rWtGMV3HoOTSjAIA8pbKcgoA+9gL7t2fBRgu0uFxbsqVRW2Le/tf
	fh5QSrHgph5Txk8SNwL7vMWG5Aj4yxxOzFlnEOowpcjsPLjHwfeH03BL9RUc1b+RzlCKk/vQDTQ
	csHDRML/bkAZuizpJlPo/DyX5fVrLD2bg4PfH+/4mWEiJe3YWIQog0EGd2k1u2IVLKpITEbxOp1
	R5dZ/RdExATRq0uSMlSUIMXlCUHXFgRDJvpWf1prUVSt93U2rSxshPguUYWmJ/YnIAyXONV7qsY
	9UBfoH/M=
X-Google-Smtp-Source: AGHT+IGkCU3DHyt9I8/j3dpgBoULEMbtlNBnRe4ybvw/TCAOP0+IrPEGmmuhB3u8w23Zud28XJ3YHA==
X-Received: by 2002:a05:6a00:2d1d:b0:73e:970:731 with SMTP id d2e1a72fcca58-7633740769amr12440290b3a.16.1753634834876;
        Sun, 27 Jul 2025 09:47:14 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640baa00a9sm3402878b3a.140.2025.07.27.09.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:47:13 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangyeechou@gmail.com,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v2 0/3] Optimize wbt and update its comments and doc
Date: Mon, 28 Jul 2025 00:47:06 +0800
Message-Id: <20250727164709.96477-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

Some minor optimizations and updates of comments and doc for wbt.

v2:
Patch #1: Pick up Jan and Kuai's Reviewed-by tag.
Patch #2: Pick up Jan's Reviewed-by tag.
Patch #3: Take Jan and Kuai's advice. Change the name to
'curr_win_nsec'.

Tang Yizhou (3):
  blk-wbt: Optimize wbt_done() for non-throttled writes
  blk-wbt: Eliminate ambiguity in the comments of struct rq_wb
  blk-wbt: doc: Update the doc of the wbt_lat_usec interface

 Documentation/ABI/stable/sysfs-block |  2 +-
 block/blk-wbt.c                      | 15 ++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.25.1


