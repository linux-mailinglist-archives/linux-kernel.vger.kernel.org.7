Return-Path: <linux-kernel+bounces-873590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5A1C1436C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330BE189C632
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8612E3043C9;
	Tue, 28 Oct 2025 10:47:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95341309F00
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648425; cv=none; b=R8IIwHJdCddXTEOUHVv00myiQlFoI9oikJ8kVaUUEZdB1nf8/t1vp62/NU2YqHjAbaTPb753E1kiA1ZdLZ7HU10/XKLQc5MV1IYSdEKFXm0T+OwquqdUQWlFWlJ+ry/4g4oCJfB+8N9a6x/M/xnFinG55eeHLrDt4KWJuDuRkS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648425; c=relaxed/simple;
	bh=hSYj2myRX9IwSW60+FXGnEn6hLaz6s+dKUbXgv5VwwA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YWSUnQAmVk7v60Wyb6QSZwdZVVuRLYhaey41yVeQJnBwhQP+XVZ7NrJiij/u6QsrLCLRv4JoiGcSVxFXy9g2M+arT76kYX++nZXO0TuslM1GDK349cwBZ8JB6ilcqTELa//eFG5EhdQBnoVLqH3kJE1bY5tG2Ij++V5jHbYsLRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430db5635d6so72744985ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648423; x=1762253223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=id/yDjnQWwuH5DTA5MbrY9nrqUnWxWcXQTVt6TbiYA4=;
        b=dr8ZxVo5Y/xI22WFq1h6kJj1AtY03R1qsbaEzr/sSalKce+/RVoWQCtL24P1kX9hPx
         pdNe/5RL74q8iuLRS6Fuvj7TjZZhW6TCtCiFBR1O1icuRTxjON/gdZprH2LE3nnXCX8X
         GvGGi3jWd+vCFItfVtQDvAGW1GMp1dd/uzb5X/UaLbsViw770lX0QlGpqUu7ZTi3NWax
         gNFOr3gyTb71+PY02+dXKYHeWFh68tJae217bPvB/VdfuQ58AnZdhhzIr/c0HRgp2DyS
         wMFf+XHzNP+gwTrvSFD1yUyRiRpr6nKk64poVQq9SCvKkIdWqInOJWlV4XHvUpNpiIjB
         HPFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6t5irkqX4E1vRILk1J8HTkAeXQ5/K8+L2BDWWWpcMaqtPnlWaIP/rudb2dPY6bL5t40Ltr/PywWcKCyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOSOm+iKGH7+uEA5ACn14j1fkRXUpYQ8dueR7AGFs++PVtSKe8
	MFCtS8eqpG6Q7AnPdW+KkjRJbr7zEuZVF49qYGnFNTKd1xB9/1SdOGXvkhtAUqlyplFu45V5iOM
	vsVJs3IDHM50F+STlwsw436HZNlTDAAyjKSa9brUchzAxSqTnG6VpVks3Byk=
X-Google-Smtp-Source: AGHT+IEc+82aXpHvSkoOA88+apnyUQHpCzH/D7i/c58qeJnbNtgwdLXWZe0wrFJgIx5d7fa40LXgZTT1IrEJJyWVYr7RL5JEIZeG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0c:b0:430:ad98:981f with SMTP id
 e9e14a558f8ab-4320f6a773bmr41252165ab.4.1761648422843; Tue, 28 Oct 2025
 03:47:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:47:02 -0700
In-Reply-To: <20251028104121.ety-O%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009f26.050a0220.32483.0188.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dir_foreach_blk
From: syzbot <syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-6.1.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-6.1.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-6.1.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=b20bbf680bb0f2ecedae
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15b81f34580000


