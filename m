Return-Path: <linux-kernel+bounces-863748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F44BF901C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AACAF19C25D2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FA628000F;
	Tue, 21 Oct 2025 22:08:58 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B971D799D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761084537; cv=none; b=XggTG8j7SpNdOGyHjj/1qlKS7YLMp3jKoC980sgT5w83tTUCZTO10QV/30alB7LVAbImbJhkJNwglfAxVlJMoU3pEVH+lhknMnJ7rFJrQwDdOtMTvoAojFPqEls9G7KasQq1ALYqSfSrnIlBATd7S5IdFDBDZmGE00neLNSaMrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761084537; c=relaxed/simple;
	bh=BRkGrLQrNSh8R9z5Glb4y5FFkCpIsIQK4TzAzzM+zTM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ibOk4/egbqnXkjNNl57Rt8m6yaiCpKnmG+DRUAiKz0/HD8zCRYOJoOa0eg/TuRMGPFzxs/9ma3nSn2N+52o2CuUyidyOBXt2GSEOw0M1m1mQIM/aQfPrlOfOE350FVqmTGAgyofPYvfJ6uNmYHzse5XM+93snXA/5ut/8altwTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430c1cbd1f2so64550775ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761084535; x=1761689335;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRkGrLQrNSh8R9z5Glb4y5FFkCpIsIQK4TzAzzM+zTM=;
        b=lwAlq4CMC5HbnfeQnTGHHUSZwUyqIKXHo7zS7tOL2+y/JhhZEkESrxgXPZnsEfNZgG
         LKvjM9XKjmmnKfM6DH3GcyzBOTzI5pxUcvhQuwLUt2vcndPATGUlPT/Lfb6WP2fRUzBK
         OjFrpCj/PA31EnzCtWHUMRDiRKXW/e1smms2Q8bDePbT5wdfLOSbIHPegB1TaeDPa8JD
         3r9x06J8DMXbRloaYrRokXLOnOM4Z8kHSqLCVwaQS0cs8Bw8UIIKNnoLGCQXQrto8xsn
         IlZ0zQRLGEH3rwb7ke29+x5uMlK5JLveaxkZj0AisRWst7lPVm9lcb2+YfoU45lUdd5g
         MJvA==
X-Gm-Message-State: AOJu0YykpumYBa9vPeWeOjO354+Dgr36jSQsXqA0Qb2Ycz7wvXRJTKU0
	bwAKM51PUsie7p+LF6rhzoSXwBn2O9OXNZYBLefoChrA6pGLODpaKKPV/5oP1rPqcpcJWrpYzgC
	5JsEVrH3oU7UBBBVIzvzHVRTZ8LldiXhsxqV+d2QZI2OkIWZGb3n1gVoL8tQ=
X-Google-Smtp-Source: AGHT+IHwWWFpAUJgXbj9ADp28kaD+pgRaUO5HqgMVVPArmCceS+vL1eAhJiUfkKHzPC9ED0t3La/J0VIVjOkCS3g/jDU2pYQC+cf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ce:b0:430:bee3:34a with SMTP id
 e9e14a558f8ab-430c52b5b09mr239291495ab.20.1761084535425; Tue, 21 Oct 2025
 15:08:55 -0700 (PDT)
Date: Tue, 21 Oct 2025 15:08:55 -0700
In-Reply-To: <67389a73.050a0220.bb738.000a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f80477.050a0220.346f24.002c.GAE@google.com>
Subject: Forwarded: test fix
From: syzbot <syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: test fix
Author: rpthibeault@gmail.com

#syz test

