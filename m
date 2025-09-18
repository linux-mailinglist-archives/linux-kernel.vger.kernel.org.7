Return-Path: <linux-kernel+bounces-821854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCB2B82759
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C332480C65
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E76E1D514E;
	Thu, 18 Sep 2025 01:03:42 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C8038B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758157422; cv=none; b=B+nN1R5HovbWQ2uht5uTYCsTT7t+I1WqdqFdyuLA1huQBAm/nLNvCD4JvzA5oubBQuPULy803Xdp9CETAxP7SYD49SMedCDjRAR51PmA6v9UKuSXc1h4K7rb1PH37K6t5ElCwFDlNds6MHaAUmL1epFK5qFKdOFRoS+HhIhNB28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758157422; c=relaxed/simple;
	bh=xQBneLHGSaWhoWXgwO+HeLkkcwXMKlIllVytZGaj3HU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X393VdfZCtghAnuuYeQoauw5zFXqWHtey2an4UG3vMc7z4x+IK3VH7zbAhEcpwue56jVYcQnZ8D2Pzm+pvRvUMB3SjtVFeFzR0xgxMMoQZG5hEjcT8J34+05W101YomKn5kI+Q9OnbKA2VW1CimX40h9iGcR+zjCjUU73ucCQrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42412899f90so9622175ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758157420; x=1758762220;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQBneLHGSaWhoWXgwO+HeLkkcwXMKlIllVytZGaj3HU=;
        b=obUjFNlEGi0XrLRU235UmE/D7nuqp5vkYUXKa6slLt12y9buaf8U8NEgSPIn5O164/
         edvvAJ+1BbvG2ScDCX1UWDPfpT7616JITnVMApV3D1bEPxk7K9Ar8TD0Vc91m9l9AI/o
         8bwr7dMysGDL+Q76Kbrm7PBfMhk/qBo7FcUhSo5b3mLpvEu0aNcQau7IsqPzB73sRu1h
         sdltqeM8j7+nidSaA6P26pTbhcdf/2DIXL1fB3hdu+V/Xnba6FI+RM7jrhK1VE/999pU
         wCmCjFE74wm9SQPd7q4coh2wsDXtBgsP8wxr7rjRl221yYxFniMQlGV4fUtaRrr0wT9f
         Qz1A==
X-Gm-Message-State: AOJu0YzdVN2p19fCa00dvBCunjEslsYOps7viNJToPRGF6tJ+oeAG0gF
	+Tbo1bOtvcPnATmEqI15X+Mc4QysD26N2waYNawrIlnqN17pQyNCXqZpi6yGqwhuzP8anNNtaxx
	AJFvncbhBSrWjtAV+uejFtEYHb9+/wUrrK2+a0khPbr3L3kfrykIMejD6LFI=
X-Google-Smtp-Source: AGHT+IH5ktm1mraTeKKCNDoT/P0ES/QOVTtc46GYdgZbJ3BXdswyaKooccHHlSG2VvHxGhzcVvIFKOXsKhmkubh8U4+jdrNDYUBu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148a:b0:40d:e50a:35b0 with SMTP id
 e9e14a558f8ab-4241a56499bmr53622995ab.32.1758157419915; Wed, 17 Sep 2025
 18:03:39 -0700 (PDT)
Date: Wed, 17 Sep 2025 18:03:39 -0700
In-Reply-To: <68c21301.050a0220.3c6139.0031.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cb5a6b.050a0220.3c6139.0faa.GAE@google.com>
Subject: Forwarded: WARNING in ext4_xattr_inode_update_ref
From: syzbot <syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in ext4_xattr_inode_update_ref
Author: eraykrdg1@gmail.com

#syz test

