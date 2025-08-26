Return-Path: <linux-kernel+bounces-786140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC8DB35592
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EAD8189E8F9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D152F90F6;
	Tue, 26 Aug 2025 07:23:11 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A94C2F8BC5
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192990; cv=none; b=gR+AN+xu2wbPStp2RmBbImYsYCngFYtIbx3WGv7Zp6XLzGDTLbVRP5PwwV1wOa6MTa/3lKBIiPWYzu7PHQVIoNOE9e/o8mO/feSuf/juPlZHnI8kqmnf013B5FEoInARy23sTG2ZcWtEBDJhf+UT/2qgPnxdNnrNQLsy1oT7PN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192990; c=relaxed/simple;
	bh=aFdMvz1kmKlqIIgScz3tafdjN1lhIpcPvbt3nOC1ipA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ea73UUJTf3WRIALg7rDc7Pi5lcr04MkaL/YOKx1SOcij7GZYjeYN37OE83TogPJzpb1wdPyys9HoJFQM/pr7AYe5uYmkoHmDTasYwU1qd+o8RyZyefBNqlU5tqxFp4Tot3IakaTOltkAi4zJLG4FRVKDE+8Jxoik03egN1JVycI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e6649d783bso121321445ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192988; x=1756797788;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFdMvz1kmKlqIIgScz3tafdjN1lhIpcPvbt3nOC1ipA=;
        b=javse4H4GNBrNEPdgRPZFdTrVWktVvd4UQZlyUEL64z+J95VuEa6HZ2emKAr48oMiJ
         8EvooK8oBRSvYeoNWyJHBOwxwWVxgdLj+jgEf161iAV3464iEwUMX6yPGEaoITN1Kdf0
         fdHF+AeTK7GKfB/eg/vRAT1hWhMKOGEjTGQw4pJb0kGTuGOqoEKD0O/2vXq7g9v2j1pU
         hdl4SRbnGWPjn6NhukljPHle6G/27dEACVYUjueSFjKWmTtLOqrCjPf+wAXLN84g+BmX
         hteIn2PgPBTBY/FRcvsgVvODykCbr/eKCwaQuoNhj4+VhD4hqXSuB1sZTXd2orb9CqdQ
         cf5A==
X-Gm-Message-State: AOJu0YwSicF6/DspbrjvKhkqvx/6+G0mQzPqFmefpLBd0UbrX6Mk8GqT
	fNTDaMyXPk+6PtTo2SwedS856jA+ux9sXtD2XPx4VQyL3T9EYe3b1SUAv8SIqCMb7L80utRgEOB
	OldAQIrAMNbwE+oerhiX/UIC7UuCH+zeqOaNKlNoH1vPZ4I0iufUW6yhbxqM=
X-Google-Smtp-Source: AGHT+IEtz9EkxDQEyB0ziRUja8V/I1jTQF+J5cWGtaLG+2+E+DOJjJivQ0gqzFwkuoi9GpzMDBAmf5+SE2Ge6goL6zuAMlJ0OICc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144c:b0:3ed:4687:769f with SMTP id
 e9e14a558f8ab-3ed468777d4mr75046595ab.31.1756192988536; Tue, 26 Aug 2025
 00:23:08 -0700 (PDT)
Date: Tue, 26 Aug 2025 00:23:08 -0700
In-Reply-To: <68ac2451.050a0220.37038e.008b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ad60dc.050a0220.37038e.00b4.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 5b1ae9de71335865d06ff0e60eadcf368a735edf
From: syzbot <syzbot+a77d690840e60bc2ddd8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git 5b1ae9de71335865d06ff0e60eadcf368a735edf
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git 5b1ae9de71335865d06ff0e60eadcf368a735edf

