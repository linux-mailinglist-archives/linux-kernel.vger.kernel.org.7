Return-Path: <linux-kernel+bounces-847674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0BBBCB649
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 04:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 832984EB90C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 02:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D250214A8B;
	Fri, 10 Oct 2025 02:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jh9J+M6Y"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E061DEFE8
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 02:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760061660; cv=none; b=rUW2gZpcsW3cXndUinbFEdECJSBJSbKrEU2J+f+1Kt50Z0xC5CvduQkHB4zWm8BmXH6Fx7J+QFZj5wQbJEvCS5lyHxu8hIsmd+I8gXrRYZvA8ueVUBJZr2/awJxq/KxyyzEtdKPxylcpx+vbFLaL53k8mNsXYijOYP4Ja8od23M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760061660; c=relaxed/simple;
	bh=ZJ0ZO8tVsX63PTkbuehFWFQ5H5Io+PO6mAdzl1iHsj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hbOFyWpoIdbdG/ZkBMAZYB5BKrDV/zYO4wt51tIvpCHd0aaJnUB31vkO1smCUBwaOCkJ/KS7N8Bdxms4riGvj+kw73YUGv44YeQfqLIzgXgYMph/myp6P0Peu3764wTSshM0HROHILQQrJFscI6HVsiLVRtlfC/KSpz5uzmIO38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jh9J+M6Y; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3369dcfef12so1970429a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 19:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760061658; x=1760666458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJ0ZO8tVsX63PTkbuehFWFQ5H5Io+PO6mAdzl1iHsj0=;
        b=Jh9J+M6YpttG/NXLy0O4fSWX7tTWnbRmspYGVUp5eIeBG6DJtNTytM5qThCs1ccojr
         drioEHYjlTeq95wSIB40BsV6j/zczZQCA25o9F3uiijEcpQ8igxl8nhektbJMDtxtH+i
         cmBvXKU3kO1nvQZ21Q6XfpS4+5z+PnR2SmbQiXwJra2Yt467kByFzGdCxCA7xOo8RhCx
         1CpqlYutMM9JqyHqV3dhNEpa06pG/eZSFl/brX5E5wvDhbSsiwhRcgiDOOAhiR0iRgeW
         OgTLMG8IsL0IC2cUTxJC6p58/tq1+t5+SUe+i0IkvfH/5iADUIDlB7kasw/Uz50XBF3p
         MFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760061658; x=1760666458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJ0ZO8tVsX63PTkbuehFWFQ5H5Io+PO6mAdzl1iHsj0=;
        b=UveBS4lAqGbM/9oJRd5yzFASgWoMu15N/6XxG4+Gp9y1Q2bQrosO+QE3rY5MK1HKTD
         iqX+O9bY3RoHopLYGO8iTsuEu50z8NQyaq5JxgmWhStTMuJbelPM/AnUL8wu20xVTSjA
         xdLqCDZW3W5Qx5FZrYSJ6c4ioYufETWTyfsBWqRl8oDXbn35rTtSw1kT6vHZK/y/ZXFR
         HyMGvqrqKRMIEHDNGXMlCIqcI1ihohhUdApBnIM90wJSutFF0ZxPYUKcNUwNu2dEb+dR
         WZd6xCqrvm4U8haNmx4PJ68s4i82oE7JmON/un5SeqYroUw4vKjiwsrD5zhOsmS+2LZF
         2hwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcK7Wqbh8vPYJA4bAAyXMx2gFP1W2YuqVXoCYpd6fXZzeis8objvcjs06qqxrqsALpE1yIAhTpTv/pQiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQpANqvH+36c4TDsitYkcAwG/Wd7UhOcy58KPX1VGCcjwX4XLA
	uASpKxdUFRlHbY+bpG8IsJG/8hjU5mOqg9txB8fBmo1OoSGkKWHIVsfG
X-Gm-Gg: ASbGncsCvnruhCc3QblVzxpkuRUbPoIRsHQP3zqKEG4CjFl/WJjTykVTY9mtBbQK+85
	IyDGWdjAzQl/9zku1Q8Wr2qhzHDlIuZK0wkk5Z4ZHBLSvq6hKYkPB0ijhM8NheaII7a/0f+9NkB
	HOXdt3ywqD5BcK1zVuK3a9pkNfZWtxvKr5wdklDWq+Be8j5MIMZAEP9nCsGw6mgbiMxwj5W/j5i
	bv8Joy1s5AgiVA+1sSSsGqU6sjMcL4DVxZG2xzS13iZpvwaMuaNaVOiaF9z3ryy48AXuWyc3LBP
	pbRopgmFFjE416+tW3KjUiR/lj6e4RtZwVSYAyld8nEOsQroOJV5ugttuXZiv9HceXM6IJ+9u5e
	fRwd/qSa7tZ310fdySeNf7Qb4YE862OoAgZDaHIzYhV3UxmRKNE7n/U3L8g86ACFX+WgelGbN54
	SngFE9pSVCHPwZJxlngFZ9VHH8nCI=
X-Google-Smtp-Source: AGHT+IF4/vxKx1CP0CXz1kH5ziINSy5FUdO2xGkIxifAZOS1HIvhxqzvJEmlrdJ2EGLNh9neLRf/JA==
X-Received: by 2002:a17:90b:17c8:b0:329:d8d2:3602 with SMTP id 98e67ed59e1d1-33b513b389fmr13709247a91.17.1760061658518;
        Thu, 09 Oct 2025 19:00:58 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:cfc5:62ab:555f:ccdc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992db864c7sm1073619b3a.82.2025.10.09.19.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 19:00:57 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: akpm@linux-foundation.org
Cc: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] ocfs2: clear extent cache after moving/defragmenting extents
Date: Fri, 10 Oct 2025 07:30:49 +0530
Message-ID: <20251010020049.523924-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

Thank you for picking this up!

For the Fixes: tag:

Fixes: 53069d4e76954e2e63c1b3c501051c6fbcf7298c ("Ocfs2/move_extents: move/defrag extents within a certain range.")

This commit introduced __ocfs2_move_extents_range() with the while loop that
calls ocfs2_get_clusters() (which caches extent data) followed by
ocfs2_move_extent()/ocfs2_defrag_extent() (which modify disk), but without
invalidating the extent cache afterwards.

Thanks,
Deepanshu

