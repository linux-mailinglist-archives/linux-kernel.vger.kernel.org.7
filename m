Return-Path: <linux-kernel+bounces-754196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD8CB18F9D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 19:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75FDD17E441
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 17:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5535248F7D;
	Sat,  2 Aug 2025 17:55:40 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A06346BF
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754157340; cv=none; b=QzOMVYLgzcHXyt5FjpGsRK5Hawijrq99xDf+5dU6b9ili24L8cZn7FMjQfwhUin3SDdLJ3s8G+dNov9M2LhsmJdy6elshkRpQNQL4xzG3s8nTOChShUH83QskTmnZs63stO+EFrEDTBRbMnhnw8NVWf0Fg2zcKovoqyhsvTvWZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754157340; c=relaxed/simple;
	bh=xTyEiwkoefl7JQ7tTqXa4AMF+DHkXuNN3XdWqCRg+Pg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MfPYeQ2/CoPxf4FCUGtYklEEsytLbP6sX3WZASTeNtQ99hAsUab5eJxgPfyK9Gv4TISHodo2EiI+DkOq7yPTSkSGVeYqQk/xmWMOi8VrA05OdzAGYwQFuhqi36zES6zyUQvnnGdCCPh6MOhNauog88MqWxjSd5uOzT21UJ5WOHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e410d877e8so16492095ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 10:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754157338; x=1754762138;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTyEiwkoefl7JQ7tTqXa4AMF+DHkXuNN3XdWqCRg+Pg=;
        b=dYOzKUZJFxLExgIg2NECcd6pCEVOQ9YuW4FJ5nxkRs/LMlIhrQ0feOKnHxObTAilnI
         AQnvn9zHSI9Ube7sMcTZr0sf/VseAb2HBXxG0BaJ0LpnKvDvipVMeDKQGnjBh8cLf/g9
         bN2QLQIwcWUutedEXhC8cKSm82q6UGTZFKm5SuaYuqCSC2Ihj1m73M6L5ZwBjJCVJZTX
         mUHiZMjY78A8/tBXMEbg+D2FsEZ8vbGNu/11+ulPJ4gXHpHyshddjdaWHQGcoKkCPIO+
         HaxLKdYSPZ7eQ2fxDpomZ0WFSd5KoMqcfAZhwuPzzNhNHf3sCnuvinr9Uv4QvYpIOmlA
         curg==
X-Gm-Message-State: AOJu0YzIIgQIZ9c9ShTqOmdIThvJ36C5WBBWQM0etDxpGTsL+Bj2VDAQ
	X/c4daYX3M+NhJI/PYGAk91CffX2XPH+33e3zouLk0acWZj7hQ2t+m6HL2GOep+ke9xIBlhM+hY
	214XQLfAzSuYCFzLa8ap86RakBnxZ6sagx81Bcvofs/Kdjjd7tpRMKehNaHQ=
X-Google-Smtp-Source: AGHT+IF/nrvuiRRWNbvMCR3ZSjPJhf3+nb9HamUeJUjFKvkFxkemH83dxgS2KXNvptGQVlGANunusNwI+i+GIWQA0pnZPXkqfNVZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:338b:b0:3e3:e633:ce03 with SMTP id
 e9e14a558f8ab-3e40595d6a7mr170495565ab.9.1754157338256; Sat, 02 Aug 2025
 10:55:38 -0700 (PDT)
Date: Sat, 02 Aug 2025 10:55:38 -0700
In-Reply-To: <6834671a.a70a0220.253bc2.0098.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688e511a.a70a0220.249f57.0006.GAE@google.com>
Subject: Forwarded: Fix unsafe locking scenario in del_gendisk
From: syzbot <syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Fix unsafe locking scenario in del_gendisk
Author: ujwal.kundur@gmail.com

#syz test

