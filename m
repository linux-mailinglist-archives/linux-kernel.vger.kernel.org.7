Return-Path: <linux-kernel+bounces-861493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 817B6BF2DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2EA3134E2AD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3998F2C0F7F;
	Mon, 20 Oct 2025 18:09:18 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6AB11CBA
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983757; cv=none; b=sBJQppfz7cIuAURGp2U0M1J6zo3XE+VyLQyPkQ+QetsUtsoGoegF3LQRntRKzPwEzf5kPleBr+Ph4IlWzDz4NU/Z+7UsO3J9OJs4pcRTqQeFUJn3yVZszV8txHY7qDrT9yZx2plpYBOtB7BP5zmry2jK+uxf9L9zK/AxRm5Vihg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983757; c=relaxed/simple;
	bh=55NMtRW1UtmtPtbEs1qlcCx0jla+cZ5ycM6VKr0KbIw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FRwEvC7LpQJve7Xi9ThCPpo0BRY5tq2LH6+HwXMXM9ZrOl0I4dO9WsHxfDyNnr/6hagQCNZ6+fxaQ1TgjXk5QAChxLUz7q25I3iAhLzs7DMmsduuxEeMVH1Jo4/Tn5xgtN/zM+ZXm4lGbyMK+Z/gw8CgoW+WDJlFbhA58UNmRQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9228ed70eb7so1331894839f.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760983755; x=1761588555;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZC5D2/stYzjkWKubRrS6EEwX3TMruWVvn+3w2hzO/bA=;
        b=Ht3ls0/NrA94qHj8EvfQFHtMOqJ9EZph1tCI7tk51Yf5x3dey3vnRGGjP8/zMvrKho
         SNhAnNXNruzT+oie4Jci5Md+MFjTnJW9dqNjDB5gRKaBlcAbp1Y41sDcy8yjcQEwAZg5
         rkUZqO4sXYErdNSGKAaOWxC+8hGB2fhjCz4cYYNzP+dwRNoT1cvqq2KCsgN3mIwGHs45
         oAArjDV40pS17+gMOMrFtK1zk8FkfgkmyoDNTUkXPJfVKMGqTpuCSXqZhIFgfVbZuuOQ
         I/Z+V2fr0QVZZZbZPEWaVC6DJHFjSIdhT0L4cH1mdh6GHtl+VfVZCSR0IUN/SG8StH2Z
         wURQ==
X-Gm-Message-State: AOJu0YxcOqCtM5BEJ7NcXORfrHjkVbdrL9nCslNGvdkIafnvbKniytHr
	JX6qI9BXeZH++HOT0IJK5wE7iJ0wTFcpeAmtz8dIm9wtOQX9InyhCsNxsGD29yJqtAN1q08Xs2I
	oXiyQCACPYdRloAIRCBS6mBDDRxW7bWHXjU7ZoOubgEa/HgFhCNh7nDEBWw0=
X-Google-Smtp-Source: AGHT+IH4txqYkWKnQNTOCis63nM1K3FWUHJUZzWwbyLK9oCdXgdOt3JZ1SKKWp4fTTZrr4gbmsx/2GJCPfdimUWiJ4cisdqRA9HY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d93:b0:430:bf60:6b01 with SMTP id
 e9e14a558f8ab-430c5268fccmr196115365ab.19.1760983755553; Mon, 20 Oct 2025
 11:09:15 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:09:15 -0700
In-Reply-To: <68cb3c25.050a0220.50883.002a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f67acb.050a0220.91a22.044f.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+e7be6bf3e45b7b463bfa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: 
Author: zlatistiv@gmail.com

#syz test

