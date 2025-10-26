Return-Path: <linux-kernel+bounces-870439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 327A1C0ACFD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 16:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94743B1D0E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 15:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C98420E023;
	Sun, 26 Oct 2025 15:54:38 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822601C862D
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761494077; cv=none; b=bn2Ybxfs3msNQB31ovxHjk0ra+54Jrz8nslG/PJ4+GRHvVQP5Xeplb+3tzYVzoTh21u4azgLnx8CfqC4GbOOOCI5iDt+V0g4FSn1dI+9rgOCZj4UYI5tEhkqj5XZb/tVlgJ//0ko40VmKfhXqvv/f/eW6pv8eZ7OQRyICgpSbdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761494077; c=relaxed/simple;
	bh=REmMILk9al9CbdeeNaLEEFF3T3b9U68t7o/gdOkrbL0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GO5bmgshW2nvR/LsBF9FftyMchSTwqS3LBmW7iq6n+kDVh8bSMdOSz+7iRLFXQZnch7RvnaoTB3qMNd67d97mEnDE6Gpnpg9exL7JJ6e0MV1i+L2FsEO8lQRdcM+3DK3kQcEXVMM0nJiKmBKCKG/OL+zwcb8nZtjP6SwFi8xJ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-9228ed70eb7so1136512439f.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 08:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761494075; x=1762098875;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHfXnDgmakSxgzlgwOdiGngolOxyHhR+Z/lDndNpERU=;
        b=rDoV9Mg0mQrbPRINY7dmUdyay6oMZpjervKwt3q3Y1uV+zUud2XpngL7CEEBE0O8WO
         LrLrpul3vPbLPFlSu/uDK4DmGH+fcS/UGDpM2L8NszqBMIF3FgnXWHydCkcNVhSEHT20
         AhWp9MR0nEcOJYedwCeN8M+dlTs1Kt4qb6HbWHgd2Qw/HTcibiukrdVJHFZTIliNX695
         4s/iuxS5vVXv3iWxNZamzHG0cggtWukJnpTv5ZbQGkY/8qmLr95axAt6iZTXQj6WLuLy
         iVPvb6bpp1By2qI4Vol8SgdRaJq3u9w376iqQQNybbh8N60ywDarmwGeOVpIlFcK7CeA
         hXTg==
X-Gm-Message-State: AOJu0YyJfkoWLxIMzvnh8RMJKV7wiPFMQ1CxDJfnUIf/ke6L5zLSuNaO
	PZ5NDpX3PCfEnYyHSkY6o1tPpzXNV5f/E/1Ducz3iou3hscFUnyrxhLf15A/itHizMUwXlY/EMg
	89VgeNjnwOTOeed3JzK19gGXt0oeECAKiVYcJ3FRO0wrPcN5LPgak0ZYMaxQ=
X-Google-Smtp-Source: AGHT+IF+9Nl1I+qd2+SexJUrSzJw5RrUH2/VIRh9u0REryZLYhwjjM8JNSoCOrDVfmnVzE4s+jEo++Nn2yaA3Bpy5jc4O4QBKqJ1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2183:b0:42f:983e:e54d with SMTP id
 e9e14a558f8ab-430c520801bmr489131805ab.4.1761494075715; Sun, 26 Oct 2025
 08:54:35 -0700 (PDT)
Date: Sun, 26 Oct 2025 08:54:35 -0700
In-Reply-To: <68cb3c62.050a0220.50883.002b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fe443b.050a0220.3344a1.00cd.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: 
Author: kubik.bartlomiej@gmail.com

#syz test

