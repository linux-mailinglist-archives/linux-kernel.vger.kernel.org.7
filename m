Return-Path: <linux-kernel+bounces-849668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AA7BD09E5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 20:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713573BA61E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 18:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4FA2EC558;
	Sun, 12 Oct 2025 18:37:00 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6533193077
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760294220; cv=none; b=NDZHEzBoxu05gpkO9xyU2Q92j8ojrijqux7g/EsinAI1uOAofNUMqb/fvn67frlQDHDZcE72aP1WJ7SC3KuHlpmCNsqWQKEi/oRA8F2DfQVU4e11ZhtkETTvAGdGVZm4qO5HHUGdVkUnKMrd/Ae1mA+OnWi03GCuRnCM1ad017k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760294220; c=relaxed/simple;
	bh=BRkGrLQrNSh8R9z5Glb4y5FFkCpIsIQK4TzAzzM+zTM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UA8N6WXk2J11X6FwBw5G4BOYlu1+berKMIg30Sz8SKAcQXuVNGzQGADKP+otXfBSaX8M8ujSXhQrWSP2Eu0LJ2Twr7N0wOf0zgURHWtADgneAkHatiw3UxV218ZiI7uXI6Z5+EJtOq5ToH1D8SuizquFyxnSf/eDB+KgqCO0AD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430929af37bso5981175ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 11:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760294218; x=1760899018;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRkGrLQrNSh8R9z5Glb4y5FFkCpIsIQK4TzAzzM+zTM=;
        b=aynJiiN+SvWYPZBb3mysEToGbzrIiW+eAJ12/AhJu5WJ2fXF95MXT6EG+Ch16U3rni
         jB4c1uS1oY9zpo22GZPIp82F92E/0MPAII8sp1rOXNEEryaP1dnmKpmN/OmXpfdTn7k2
         3QmlOzKEtQLvXvMkhYVHWIr+kaK7oY0GGvQmTDFOITeyoAPiOYCeaE588YCSJ7pK9oVM
         okxIp+MoZs4baQaCukt2wDgKjDtW6QmbgAx35YMmlHZ3+QSoZLe30d3DGp+NhT2fO/f8
         xyCvtvTJAW2OMg/AZBOiA7tR2tY9YlosvztRWZZc9V5stk40T+9rOTMY3oO+lpQOreMA
         A9+A==
X-Gm-Message-State: AOJu0YxsWFWGKCJYDTjK7hnKckbTrGq4FYAsYXrevflU6xI2AHbmwVsg
	OzXQoeUQqtgRs2xMdFvtF8xjz8omzBKBfxG/vx4zpBm4eUfdXhDphxYMmDlrGhBisssh5mk6mC9
	iHLbefTd6nOJGtIYvUxOiWf0kDdRJhtYh6T1BjvSu5o7XBKKkhXgo+ONbVbg=
X-Google-Smtp-Source: AGHT+IEBfFs8dbuPp4ruPsYm23psrb1YvcJAQBB+nWYRMbW6Vdhx603qA0pjyZLqftdj4vcjOKk5IWZ9S7GQ26uKcGxMLyfmzvEd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d91:b0:42f:9e96:1a63 with SMTP id
 e9e14a558f8ab-42f9e961c7bmr110652005ab.1.1760294217951; Sun, 12 Oct 2025
 11:36:57 -0700 (PDT)
Date: Sun, 12 Oct 2025 11:36:57 -0700
In-Reply-To: <000000000000b3424a062114aaa3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ebf549.050a0220.5b5d0.0000.GAE@google.com>
Subject: Forwarded: test fix
From: syzbot <syzbot+7a2ba6b7b66340cff225@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: test fix
Author: rpthibeault@gmail.com

#syz test

