Return-Path: <linux-kernel+bounces-823860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F815B87979
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F06F3B50F0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2BA246770;
	Fri, 19 Sep 2025 01:27:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31124239E8A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758245224; cv=none; b=Uj4dZO/gZCCcBTL74BmpB2xO7bJRyb8w9HZKGpfJguCEbYqqrlnfblLKxi8+9JiW5eP0oiOUQKgOg5p9vYq0gLxbv9BIpOI/qPCIHOvpOlTbFthFgipjUa/XSaXDp5I4xLAWvOcT3P9yQ2WuvwZGFHg2dROVN7amwu+qpu1t9YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758245224; c=relaxed/simple;
	bh=TvAjvLUzPXrlMGzOwNeheAuZyk3o2khNVEQJhoEKPXQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gbK78tHmmkV99MG0a+9dJOtStldyPbaD/ydjY0idNEOGt+pRL9dPY4lBoBEDPHMaBl/WiPa1QhmR13YG4nO3IOO63PwU3h+TGOxQxqsitMAJB/xUX+yS+C5aHTYuZES9dF3yUHtXLUzIgQ2OsHAiPij2A0lWaofXdFw/RqiQVnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4155725a305so21839665ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758245222; x=1758850022;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2H3OA3pX5SOBoK6XYroKXhf4Xi80uinhZ9BKahBMUc=;
        b=k0Pbh5uDlom20M3wofEbqiFsDn3Vo8TBwGNtcNRXBTdoZDN9tYjoKGSecall2KpKHB
         WTWZaPbab4pV9ZpLy9VChVv8kPoR4+tNhfuQbcjP+pCqc/cZY8uF7WEqa0qEiUS5+XKV
         vt0VAgIGTy/CJXjCpNM6gYp0dENmmW5wnzVqOR5cShD9pX805mVJVIUN265OwyTXHhJ7
         jCkaDw5E9EbT6JBwHgmOJTOeXJW363+XjM1rurolYjD35dIHZSa7DMYd8hp5TEkulmzp
         X7wP3OmMfZjZgOqg2QqQWQbysosKrbfqqF+S47mjcSbtR/8dvygI+Iyi0CRFFOOsoUHu
         uCdg==
X-Forwarded-Encrypted: i=1; AJvYcCX9xU2EQQISksZFVV54mGs2bm/VaRIc2Z2K9gfE+fzFcLt+6aZkQuM0AdqUcCgSrSw33PUbowiAzKydyJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV6PkXITVkWyMQtiV3m+bii7m6vlYiXygqgRZ3cxkLoa4rghnT
	SSKTe+RhSvCK0jUM2jBsZ5vMw8TuUIDKJfQD8DcrhYhJGkrXSf7Wuf5fOpGl4eaFt+RZiYcnfbO
	luxpZaieebiwdZV0lNF3YtVXO5GiVJT/doqWoUf3cC00CZ/DqBOxr6vktNsg=
X-Google-Smtp-Source: AGHT+IE0nTSooBb6CKNztSpDLqtgxEy3ez+D1/QpCnVTeaymqPp8VB4efXFN7evAP4RiblOHqLwM2f5cXyBLoLzApVfxqyS3Tl4j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2167:b0:424:1e39:bf02 with SMTP id
 e9e14a558f8ab-4248187f948mr28684325ab.0.1758245222423; Thu, 18 Sep 2025
 18:27:02 -0700 (PDT)
Date: Thu, 18 Sep 2025 18:27:02 -0700
In-Reply-To: <CADhLXY4XxHAF95Nq2NSg5kkDWWdEmonYaGM_6a0CfdfedHAF9A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ccb166.a00a0220.37dadf.000f.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in ext4_mb_load_buddy_gfp
From: syzbot <syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/ext4/mballoc.c
patch: **** unexpected end of file in patch



Tested on:

commit:         097a6c33 Merge tag 'trace-rv-v6.17-rc5' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf99f2510ef92ba5
dashboard link: https://syzkaller.appspot.com/bug?extid=fd3f70a4509fca8c265d
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=128d3f62580000


