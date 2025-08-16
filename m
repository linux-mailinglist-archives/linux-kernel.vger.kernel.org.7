Return-Path: <linux-kernel+bounces-771602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6A8B28942
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 02:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C3F1CE33F9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A135482EB;
	Sat, 16 Aug 2025 00:30:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF1A23AD
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755304206; cv=none; b=SwV4uvIqIK+5tnxBsgfVBsPImUGxWxnF1E7gGdyNJ6vTI8lO6vZ7M7uh8btsT0UVuGG7VhOWUaZSsZuT9mQwBURzOAYfLesQXjfkns1bY15S1/hzlHYuL3bge+N1vI5v4Fw4lRjdcWMoFYXVy6y0Loe2173N6lg8LWMY3jVDCtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755304206; c=relaxed/simple;
	bh=VWUiUzQK86HWSwGuF8xInFChZoi2gS7Rymc5YjbW5Jc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=egT9xh43RK4rZxikT0LxWKT08vTgaT8gSTJIt0K2jbh++4VcJ5rdYJvpszohAa2UTQReBWgi7PjJ6B1iQjOLyF1LzbiPu8VHPTv76QTxyFzDQGorfkTbuq5rIMVT2PYmafodrC04Q24Kzdah2VNP+sYb0TyjmUTafR6C4KHbJY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88432cc8949so272791539f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 17:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755304204; x=1755909004;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=COIfik/RujH0ZCMLEJoppWLOYa7oLNPGVJSWQTRhpbY=;
        b=H2tzZs6wlnmgQ4x1npqf4DuOEcf7Uj/bs043LB+vnqo4Xx/6segJdatOuNoV3FEk8m
         3ikioW59ShLJV0gSg0NnwdteAGOZaAvQhxHYf7z3Zr2GahnrZUp8BC0BwX8VbEvrIJAJ
         BODJGbRiTzWUorRKJUkLeHmCymevJcs798lot7m1xuu/YbpCUvQq1mfiTul2sd3F7mFE
         wTJVuHHCESZiS7DjU/F94ePipl8j+lNMWl5dRBqBByyD8P6KRvGCSrGJT0apoJ20We5G
         ZXwES9/xr+65N4o3zdz0oVScTIkIvcFHQdFeuMM80FbjFutm13+c6HHZIxOnRGb5JzCC
         i1tw==
X-Forwarded-Encrypted: i=1; AJvYcCWZNZ7YhPtgE2+ZM1WRw7I/q0locr7arAmVcCuX6WdKIP+s1SpAEi0pCQURL8DrA68xT8vOWX6tgtV7yFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMLm4+ZIe4vDRiRm6KtRTTszWXfOchSVe2V7ocPPrtO3yNx57A
	XSugQkw1lRqCcr0dxu8xyoo6OFMuEMQ8+YAJ2zJPK/18OxrM9iZZar+hm0hGvH9suZ/VlgRpOnr
	qxloEs1LiBjTvpWDX3zX5/G4PgimJc6hijcNOQJ9/Nyr+P6/KCXbbxAWlVmU=
X-Google-Smtp-Source: AGHT+IGCPgu5VDqf/or0rvRi+5fvi5mHaUDTFi6g/UotAx5ZrpDq+WzqXhoiqrBWQWgr6NUqvygidm0bU9AuzJFp9eJfOYIlACQY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c08:b0:3e5:4869:fdbe with SMTP id
 e9e14a558f8ab-3e57e82cfb9mr73498675ab.8.1755304203940; Fri, 15 Aug 2025
 17:30:03 -0700 (PDT)
Date: Fri, 15 Aug 2025 17:30:03 -0700
In-Reply-To: <20250816000900.4653-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689fd10b.050a0220.e29e5.002c.GAE@google.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] WARNING in virtio_transport_send_pkt_info
From: syzbot <syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com>
To: hdanton@sina.com, jasowang@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	stefanha@redhat.com, syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com
Tested-by: syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com

Tested on:

commit:         dfd4b508 Merge tag 'drm-fixes-2025-08-16' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130453a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f81850843b877ed
dashboard link: https://syzkaller.appspot.com/bug?extid=b4d960daf7a3c7c2b7b1
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=125373a2580000

Note: testing is done by a robot and is best-effort only.

