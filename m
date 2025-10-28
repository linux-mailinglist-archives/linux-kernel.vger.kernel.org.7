Return-Path: <linux-kernel+bounces-873581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8FCC1432D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E865E6BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEF3311C2D;
	Tue, 28 Oct 2025 10:45:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62D230FF23
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648307; cv=none; b=rJLhie3KDJVDYZlwyBM7zWBJrAr4EGCNcmN/kyN0bR749OcZYJ74vgLahI5M7qWfUsg74qExiBR3iSzEeJuhLBG1GJ2tAu8Naz8ZXtOf9UXMZaQPtILanUVsW3UxajMDJWZPZ0a6LKss10grSs3HKTUiYRD3J1b7zy3FNlb+6nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648307; c=relaxed/simple;
	bh=mhw7bkhO1UXuZxCIF1aqRyCiaDh1UA+fZXkISegKJMQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JApWf5wi/NkVDM6jO/NdmvpUFBpxk/k9EiYqWxe4XqpaVypP31pqk9Lc7DvkivcSIPavbSQWU6Jjw0I2NFZiLTsTCEzutrD8vWTMFvc7cyexsNnxWEXGba08SzaIbqXd1lZVDdsvPbQeQkcxNAICghje3N1O0ccUkG+Uc/SQ91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430c6b6ce73so174102665ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648304; x=1762253104;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vmis4gM60CK6GdOly4Yclz36YJ4ujuNMIEaPJP/efCk=;
        b=bWz3VqMBlOk5Rc9avRH3lU644q2GzckxFqlLrBR3y4lwThT+k73P2ftTZuDxZhull6
         ef8eyIDVfE6GKnyBm4um0SIm46oAVNYNlHrRSOUmqGgPXt3LYzYeLrJBTAA9kqkaPZxW
         PxLz3DSBF/GPQ8rcNUA6vuJgVLxFOBj9D/jYVtFCFOehrMW0AtN0/rRNYSSW4nRtjrPH
         MyCJTUh9EzI0h5odM3BSQj18s6Wqvpce+6FgKuHhJUvUg4nFCA2KHRdn9yfmxIynPWdU
         wyEpimon4fEXmzdEYAsda6Ysb1zX38DQk9D6a5pn9WA9itYpAA/M/g9bhTtxYWfC43UK
         o5/w==
X-Forwarded-Encrypted: i=1; AJvYcCXeNzbl72Vxu0e6HQjwbkaQJpoCZksTGBmMspOG/6EwTweEeS7VPcgr9LjCu3My7LT9/r7FsdQNMy0meTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzao7/oYz/h65+OhCSnE98sM+imyA9kTGTDt3ULf/AJyUZ1mcA
	iQCe2bUIm7UdW2NGq00/sbCos+Y3KYZOfiGpAZFiCztaOfKhWaxv8tB2LGEZiNETyU0YW6RFLqS
	2AU7nv+z+rAbKneuow17hGxUIZsdYizimcglaTTTF0gnBd/ymSlOVQiOpr6o=
X-Google-Smtp-Source: AGHT+IH/i7PSXm3TL2GzLyEMMSmt9+Ahxy77uLF0o8fxlOYsu4nMLTzUXnI+JUxXA2WqUTExabwtPphS6ARdDd+EEm/tExQFLq3T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a07:b0:430:b1ff:74cd with SMTP id
 e9e14a558f8ab-4320f7bb9bdmr49057965ab.10.1761648303829; Tue, 28 Oct 2025
 03:45:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:45:03 -0700
In-Reply-To: <20251028104117.Q0izB%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009eaf.050a0220.17b81f.0018.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in __ocfs2_flush_truncate_log
From: syzbot <syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-6.1.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-6.1.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-6.1.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3fccdd0bb995
dashboard link: https://syzkaller.appspot.com/bug?extid=4d55dad3a9e8e9f7d2b5
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12f157e2580000


