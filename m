Return-Path: <linux-kernel+bounces-817781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 199A3B58673
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55E51AA5107
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B262C026C;
	Mon, 15 Sep 2025 21:14:10 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75727299928
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757970850; cv=none; b=JelFIgEeRCNkFKENCiBSXWbUG37xGUFH8psVviayZbn3sO+3pmI5Om/zs9tKDs0Ky9yB+GdKBFoGGNQplQC9PY9Y6urAFH5zcuaMZueJODv/kWZdXuDDx9xVq9tAPgOlhX5itBG3nX/YpoO7lBDtIomGkKE5r5fV4+owWtw0xuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757970850; c=relaxed/simple;
	bh=Q6jultGZaK4rTcevknymzYqhrZfnIjHOmqDzK9mWbqs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=EqfmM9jQxjkNILQq66TYp4cZBVo6lhgqPsM71iliHlYKtIh1FdFph/aQ+DLNSlyV6GYVl4qjq5UE70tn8mOqfEUgi1Yfgj99t3fuPs154kX1PiJjYjRy7KIaigikoNnhnCEfMvXtJl3a055ronl6Af/kBtNDZE5X1kNY0J6z7OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-424019a3dfaso16551305ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757970847; x=1758575647;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6jultGZaK4rTcevknymzYqhrZfnIjHOmqDzK9mWbqs=;
        b=oe920TEOOEK4dwy4By6Cq8vGugdfL+1ECig5rKc7coAIDjORfIIGEu7UP4JY430W7p
         YTYRtYti+DuK7H9hcnqS9da/G++6Ck8pweGhDIGRSPBUrA9+rtHRBODYBNUIJlS9IrVj
         PCo7AnojuFKUG4fv9dzGioxvlp3ALDTStDK1pc0Ggby5TeS0Zm08IKBRyhKFXctPr/jZ
         smYuNGenjZKXD9L4mWkmrBfPuhekoXvg7MwxJPSYVtFOY4beg/z2EhtxyzgE+E/R4Vb6
         G9EMAFi+k4l0A0lK6FIH0qY0GVSYWBevnRNuE8VtWiVZ07+GRZHPa33RBfRccXGSTWgm
         HVZA==
X-Forwarded-Encrypted: i=1; AJvYcCWhy+XeaeEGXyZB0V7fWEbDRpKSur6YSsuQSuxK/rVfH6TanT51qllM4imkRwPEV9QwWlYn1E3cuzAiogc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvW9hR/0/l4ZInbWqIQmb7ducAMo2W+nOPd47MBOyF5cIBFlId
	8g91CXOGAcCMUTJLKzB6DftT5xVVbmd4PiTlVsBKAaw2LuyDp1g9GJ+p76OsZjX1d/Ma0qDHlkx
	ab/iy3trKB/jW+zh1DbkEiu9s5mF814T8pe9pOBgfF9gebu4fXJVNoBtzRjg=
X-Google-Smtp-Source: AGHT+IF77HIP2sfcaxktHP0oIwpqGO5Xn6YFNlcp8vh5lIwyYQ1CdhvARpaRaoc53qi5MN2NDwqbbRdQDxfwm2JPDuETjKrAgp/C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1feb:b0:416:d40f:d3e3 with SMTP id
 e9e14a558f8ab-420a30271cdmr137055895ab.15.1757970847632; Mon, 15 Sep 2025
 14:14:07 -0700 (PDT)
Date: Mon, 15 Sep 2025 14:14:07 -0700
In-Reply-To: <7d02a204-fcf6-42c5-b9ad-b7238b9c703b@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c8819f.050a0220.3c6139.0d21.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: yanjun.zhu@linux.dev
Cc: jgg@ziepe.ca, leon@kernel.org, yanjun.zhu@linux.dev, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> #syz test:https://github.com/zhuyj/linux.git=C2=A0v6.17_fix_gid_table_rel=
ease_one

unknown command "test:https://github.com/zhuyj/linux.git\u00a0v6.17_fix_gid=
_table_release_one"


