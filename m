Return-Path: <linux-kernel+bounces-849052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AE6BCF154
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BABF43B17A2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 07:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A270622FDEA;
	Sat, 11 Oct 2025 07:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScfPwGuN"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A69226CF1
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 07:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760168556; cv=none; b=jNC+2388GQC7+cX4C95qIfCGW3N5IbYW4u5usaSdaxrfKp33yD7q5ljhOTpcWEvMebgVvLY2eJ938qCMzqsHv///kbNLCtf56IiB/eUUfTpVxp3NMIjlyrV17IRGYg68u+aw3ehvVh0Uqcyp+aH0XlXVOve/C3mn0s7fb3SIIvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760168556; c=relaxed/simple;
	bh=NpFtc9Ia/VUtbsEj0nTLyL2x93ej74vMvRzTFZH2utg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BXdKRpmqhYg0nkPPoBey2oCiE/CH8Oul6SYsv9JhCSC4kmG3vs+inJZyt+HsjIS0K9h7aE19RG9wHOVhO5vOiFkERr9119OyFUDNaTqUFkzGrOyujtsl6Trz3uQU8I57902YnJr3A9hNWoMNxSDaLeg3UKGo+cNp2fbk99ZtenY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScfPwGuN; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27ee41e0798so44638715ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 00:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760168554; x=1760773354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cZO3ywerteuN+FePy9qJsgDAwYZUo+tnTmcRp4rGvok=;
        b=ScfPwGuNXzOFkqxCqjzP1QHJgD/OA83Tyc2X7WYB/V8R3tzou8bbKlueu+mWDNNoqd
         4ZbMKPhgXpaSVTtRPzaWjJN9Ew3Kt7mIFIcfBoxYvkaeY9pFir1bgDC4++i7lhSJnELH
         RfR86+oGCMS7G2e2BArNkzx99DFksKyIDI7KqCiURdBS/Xipzj+HhpUjBUpZAFQ/5xm4
         BwY/vjmEygJfWk+lsPM5D99JR2YoSphqiDY8Qg2UDn+JMoXrFL9oxcsoehigwu9Mgphh
         W/42bvy6LzM6Crrlby3bK9T40msOMEqWWvWCaCl7w3cjwDjPAm+RWuZ41Dvxw4He1yc7
         wEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760168554; x=1760773354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZO3ywerteuN+FePy9qJsgDAwYZUo+tnTmcRp4rGvok=;
        b=q6WhiFtqvpH46o0MR6+hccENZ3k+8KoBINMH5oRJTKSgsu9g3meLvQXKx+7XAdusVj
         8L4Qc1+KljKvaGEt2vB1How25+eGfjEW+z4GUingXLUCgicbcSYbBVLGm1PGHaKWxKUT
         iGst6dzZGXWzBJQCUOXmRCyFkk74bQglVh25hufTLN/Fg8zvXf6O0BBuhlvxU+60bVOa
         aoJ0Xo8Qj8oXeKTYXtHn3aiAVEp04InuYjg8+6xxG3IHkzdi3DvrfJ527ZXmbGzDwr0h
         CYayGifvUEFgYgG6mdll+m4YfcSin8x/uFXVmuLplTqm5CKGouHg8PRPM8BJhyS7//75
         FGeA==
X-Forwarded-Encrypted: i=1; AJvYcCUyID0JfJ2W9hB2/P2Q6bW/gVOC2JHl2x0Mi7F5HQr5dszOwIWWlpdV7KCHvhYJtHbh1k4dIOgJ4MlIvi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzspC2uG5AyGu+ku2/w/bNZiyMBPKoZ5ZoHUH5tig6QASccMlqX
	Zhm4LkEGlSC382ZFzerpDZlU3C09RZUEqAGfxUITfH/+6355CA5qMtgM
X-Gm-Gg: ASbGncu6eJQY5sd0rE7DRAUU5knLsunPQhfAyuhWnelWjhe/o5FeLEqMQxoZh4Lqn+s
	M0jhEUzdjB6az6YNpAJYhDvJMADiWC68g7a1+ZPNmmsUH3pNWzdGiMVlg1cCy7JBDo82Uku+2o5
	JN+E+RXeqC5Fn9ezEVaKS8yTcN7mPPFO9hc6CpMubZgBG+wDujGLo3tDJW3Th3pA2o0a9ZGPWrm
	63mEcmz6w4PPZ+CPx2Yyg9/HTY6IKT1tMo/itzRiwPwf1NL75QgdeU/kK2Bm5jjFk9Wolr7BI3m
	2KtAHH9jkKckjRKJoPdOkCpGr6zIlNNnYF5NZJl7a+RkIWuyQe3hbcVNT+VtRONG513EzyVjTw+
	oGkIxqNPYFpqE48fpy6NFG4TQBXX3nZZUEusdFTgavTdC45/QbyBdqHIeH3H0eEfgx9cFL0YE7E
	Y2tSHvoJY/I7AkxmfADGGZzbCb6mJsc34=
X-Google-Smtp-Source: AGHT+IHVzsN4OObaUacV8+iwbdoA5hLuvUY03lsbXr/AKHdhX4aXGovoDEJRDGRsbYt7U199Icby8Q==
X-Received: by 2002:a17:902:f607:b0:25c:7434:1c03 with SMTP id d9443c01a7336-290273568e4mr188544205ad.10.1760168553718;
        Sat, 11 Oct 2025 00:42:33 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:87ea:a5ed:8e4:bfcc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de6e2asm77493045ad.23.2025.10.11.00.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 00:42:32 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: heming.zhao@suse.com,
	joseph.qi@linux.alibaba.com,
	mark@fasheh.com,
	jlbec@evilplan.org
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
Subject: Re: [PATCH] ocfs2: fix stale extent map cache during COW operations
Date: Sat, 11 Oct 2025 13:12:26 +0530
Message-ID: <20251011074226.821546-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hi Heming,

Thank you for the detailed analysis and feedback.

I appreciate your review. However, I'm trying to understand your explanation 
better. You mentioned that step 5 (write with zeros) cleans the file data 
and causes the refcount flag mismatch. 

Looking at the C reproducer, I see:
- Step 7: copy_file_range() creates reflinked extent (flags=0x2)
- Step 8: ioctl(fd, 0x40406f06, ...) which is FITRIM
- Step 9: write() triggers the BUG_ON

In my analysis, step 8 (FITRIM) calls ocfs2_move_extents() -> 
__ocfs2_move_extents_range() -> ocfs2_move_extent() -> __ocfs2_move_extent().

Inside __ocfs2_move_extent() at line 50, I found:
    replace_rec.e_flags = ext_flags & ~OCFS2_EXT_REFCOUNTED;

This explicitly clears the OCFS2_EXT_REFCOUNTED flag when writing to disk, 
but the extent cache is not invalidated afterward.

Could you help me understand:
1. How does the write operation in step 5 clear the refcount flag on disk?
2. Are you suggesting there might be two separate bugs - one in the FITRIM 
   path (which v2 fixes) and another in a different path (which v1 would fix)?

My v2 patch has been merged into linux-next. If you believe v1 addresses a 
different bug scenario, I'm happy to submit it as an additional patch.

Thanks for your time and expertise!

Best regards,
Deepanshu

