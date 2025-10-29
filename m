Return-Path: <linux-kernel+bounces-875523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9287C194A7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9FC4567933
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9862D313537;
	Wed, 29 Oct 2025 08:40:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23B8306491
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727207; cv=none; b=emHX1JGIqNHYpmEADYT9mFZzKtAPX1loUETIiJZgSjlfc7vkTu+lekEp9v3DAfJvcESqAM2RmfsWnvD5VpRgy+anOiAhMO2YVd4I8ypMdEUSYftWptMc46SEsvttdZhZtL6duveiQ21SRjK4uioc0IMGsdINLy5HySjfSWSOs7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727207; c=relaxed/simple;
	bh=HtUvp2wHodK+ihQmY6ospnuRgcT3zBA8s4VILfxWHnY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NhUlzKjKtjnnbnjRuptbUNWZA+Pnha65knA5BdkOW3T12RMqggdojFE9LmaGSDQZ78NevrJrPOGyFMwd4vElDZRviz6TPqaBgsagCVahx0r8matDAofcD6lwcsFfXGKq/yMPEw4NyTV/AZ/M8ayd/2htEQVOeG73oeQ34iZAQx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-9439a1209d8so1411019439f.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761727203; x=1762332003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2VJ/uMJsXkDZKk+9VlBb/5JolIWBPrHcip488F/BYY=;
        b=Jk8EVgXxY4IdUfrZD+WjInJnZZCVUMxZ5xLfVFISYd2r+IPYnWPF7pJSrZxv4wEuDF
         08dvjPA3xQaKTe3BI6SFZcL00onjn9mx8xvrO0CnfjPvg3htHt2OjrdvSSc1wBEBw7/H
         BNmkLVoBjseC3jz0EJQSdR3Q99V51LFMG6Lra5YSdxRE0/oT1VayA8PO8WJ4F6lQQ4uT
         sBLS+ejlJmzfWzl0ZE3vkNEmWjW5CicqL0TyMMIhOITfTE3aCJq+kDbF0zC/akjU0T1m
         YOUFwEX9JR8AGnuO6xgqmyB+jAw0XNz8SuGaT3moJihj8esP3OytJmugxrf0wm4L9mGU
         ABow==
X-Forwarded-Encrypted: i=1; AJvYcCXsnbw2JzUg2ycgaOuh0NJAJY7S9oTpiBLuac3o4EwNaGfN6NWXHu0vt9dP0swWj6Ynl06JMO4zp8eU7ds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf9fl3HGLoaUEtTwk8GAHouhmXA1duzWbF7/oHEnfI8aTZnXUa
	1br04GkzwMDCyhEEpM8cbUoA8JVNzZolyUwC0DIL3jVwOLbXHkp//v41E5Hk1GgaycOhcs9VBXk
	wASr7KjR708SiYnKJmzjmwBke9w6vdZhgH9hchQdfPWZlOEtullQJ163RoLA=
X-Google-Smtp-Source: AGHT+IG3TNl1hAGEM8QjdsC7lTMfcIkHS956sCV2E2hilaEK4v6oNr0GIIVwSWEDVWHQG1HpDiezFbW4tM524Uq75YADLAxCDvGu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:160c:b0:941:a4a:ebc1 with SMTP id
 ca18e2360f4ac-945c9841f37mr316245139f.17.1761727202889; Wed, 29 Oct 2025
 01:40:02 -0700 (PDT)
Date: Wed, 29 Oct 2025 01:40:02 -0700
In-Reply-To: <20251029062551.GvRBN%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901d2e2.050a0220.3344a1.0419.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] divide error in ocfs2_block_group_fill (3)
From: syzbot <syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com
Tested-by: syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com

Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
console output: https://syzkaller.appspot.com/x/log.txt?x=1287dfe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27097ec4bd719c4e
dashboard link: https://syzkaller.appspot.com/bug?extid=fd8af97c7227fe605d95
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14ba9932580000

Note: testing is done by a robot and is best-effort only.

