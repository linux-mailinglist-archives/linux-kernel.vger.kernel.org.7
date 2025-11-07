Return-Path: <linux-kernel+bounces-891071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EF5C41C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 22:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 765774F5175
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 21:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBB5245006;
	Fri,  7 Nov 2025 21:16:09 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D3F21B9F5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 21:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762550169; cv=none; b=kr4h9Db5H5Lp6LZ5stfVDLK5VtDNo7/8VlTjInax8JaHUO4jLXmOv0gRHHvvct/VYK1+iQDDG49dlnq8t9xW/VMKH9W/cFf15RDHPz0YCV6SgVzdwk2Y9pQT+xkrJfEIqxOyp9dPwZe6BMvtKPPLyQSt1+YUuMgnyos4zN+I1KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762550169; c=relaxed/simple;
	bh=d66h7D/a/PMpnuSZ73yBD1fZLXWFfG/UZAd2B3FtjaI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Hk9tBWf2AEozNuSd9dM7CSi3zFmr+BAtQTy4sPX2ckktP0d1iyMpE4A4SUezb1Uj22tQ+EF79heA+nFAIXN9jYIv8KyJyr/OuhxjKkiB7p9MUHLnO8bwklwy4nb55EsV/aw9Q08ayKxj1P+DkVkBPVzULUuSzrqfmSAFOHXWtQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-93e8839f138so109618239f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 13:16:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762550166; x=1763154966;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o3cRQyMUQD7FRi/Haa2BkwmauUzMg7yY4yvcK1t+j/I=;
        b=AdrmzJ5Plctzf/pMc6DvLHgK2S1cu6wjZtwUT3Q1klRA/TkrelRlytTHjaNiZzb0u8
         X6gi+ztvjYCtVQTC0/+bILk33bWmuhpALyshf9bAbJJ8YTno3a65xrVyzyKQVAlMovZL
         X63JLOtzADj/1TjZkmYzWsMIBWw8TmSanU0xcNXgbHs1raOOb/klaW3Mun4ZqG/wbDf4
         y73vHHXyRvWWF2EIUgF1whBjB9mo2Cv8FCqfevITciZ5ozk/naWv2OWH6Jg6qdxP4NHl
         SOUbnr3ocCv6dxt6JOhBMdLVo0yP8kw3Nk01Tgb0+STKs70thHey4gZCd+0dvxcnLAXF
         V+kg==
X-Forwarded-Encrypted: i=1; AJvYcCWJks/3NxSIosSrqHdew6TK4cGfqKcQo8dNcBS+iJhRyZa/toUABL4TB+6xSjzFLDd+ukk6Gl+b8sALr7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBjqNokX7AN3TDRp6vMdkN58+Oepr0b44TbGKn887K+tYsc4QJ
	StEbGnH0hDSLmLsxenjCcX5+5oHAl7375MrKU2uX6tct5Aafs6ifnP7efdzFbDXb4LT6ZU86xyg
	vmuucQ+JOQliD6oYLJkeG8UV/ik20KJHQuvwEvUfCoceduldnNAveR7j1zcY=
X-Google-Smtp-Source: AGHT+IHCEWACXKM2gAl2bhq0UOm2SWenQ4HkoXq3z2ZxPSCkqPEfkpcgCDt8JhCR1RGOa8/S/dD4MFSj6R+QTHd8BPiuHFXiZOGA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3713:b0:433:3102:b104 with SMTP id
 e9e14a558f8ab-43367e59ac8mr12900925ab.25.1762550166665; Fri, 07 Nov 2025
 13:16:06 -0800 (PST)
Date: Fri, 07 Nov 2025 13:16:06 -0800
In-Reply-To: <CAL4kbRMaQ7HVrefO+KY7c0UmWW2qGr-TX1PS=K_hG9NFtENQXw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690e6196.a70a0220.22f260.0060.GAE@google.com>
Subject: Re: [syzbot] [rdma?] KMSAN: uninit-value in ib_nl_handle_ip_res_resp
From: syzbot <syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com>
To: kriish.sharma2006@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/infiniband/core/addr.c
patch: **** unexpected end of file in patch



Tested on:

commit:         da32d155 Merge tag 'gpio-fixes-for-v6.18-rc5' of git:/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=dce7eac4016da338
dashboard link: https://syzkaller.appspot.com/bug?extid=938fcd548c303fe33c1a
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11223bcd980000


