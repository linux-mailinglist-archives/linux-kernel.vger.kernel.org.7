Return-Path: <linux-kernel+bounces-875328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C7FC18AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E05AF3547C2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1E42D2494;
	Wed, 29 Oct 2025 07:27:09 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FA1221FBB
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722828; cv=none; b=F7yGhAJwmTLPCdgqlg9p8Q787/ptfeuIZtPpw4zrAAVQcACq0ekxdEfOgA/Cft5OF5ZB9gyUe4XW9aXp+lPCHU5b91rwdjDX4crAaxdOp3wgrvP8c980T1pt52UUnTFOW+wnr16mY4HURY15beyab/rO0RBRHEHweIjMSvzilZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722828; c=relaxed/simple;
	bh=wuT6XUVaci3IMWCb11Y86W3E9ZmO40H5fCuWm5kRyAs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BjqOAf6WJAhGJk0WKNTZW8KMpsvqPnrAxoCPe/WIsmPxEox8O1mxem+Tf6JmAnh98anlGNPTINPvIR7IpfNMDG0XuqqEVxsxmlx1vE+xxrqwwEc65xdW/UGtwhY3uN622bo9shRnBk7/uxq58ufBSFfprejET6Ea9C6DMWIhPsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430b3c32f75so72707485ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761722825; x=1762327625;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iBRwKaCvLel41iSwAGvu20GyQuo+39CGB8h8naGem08=;
        b=w74v8AM+x5IEMbsc7I/qdy2ctRH2dag1RcuXpId/OJDnp1RIY+QpdiFQkYhOav6DwG
         GfsLxGjm+j7EVhalqPIPtXakxXzEJ5RXvaWtxmV59jqkAyFyWizmG7txXVr9fsAOaxBX
         l0hQjMvlnJ9Rd8kc0DAtUzB371dC4XydEyjUKFpCwwaT8j546tbmLvwqAY3Do2YFgtFS
         KPzfd7jZeNfTciCQPfBKcPkgz/do7P1F6rkU+ehnH5zG967nMu9vsWbJxSnF3NsGP6Ud
         WYwy6AAL4BsvlMSd47jCCH4y9bxuPk09rucA1F2ljb2rggLrKajER5ltZlC2wG1q48SD
         rHJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSk3c4t+OXB+OPs2n6oShuyeuA1JjaLQN0VA3ijGZ0xawpKSRz8zxoH0x64Kj3Qv8O6FDTdqVwADLmbCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG3j7u88Y+h/8xEF+CTrvcUkdc0dZCE2VU3If9Jq4KawajBfi8
	bKanda8BrrLwA0xXxmiyKkPD7OisZcVEshzuCk3wQ3PgdFyFSaSiG8UwdaqboyknFVu9lp2bphp
	bEJjRv3vmWUrj+/laM3AjMuBmnf+N6ewsKChvtYCRLQN0DIxx9M+kjQsaEQY=
X-Google-Smtp-Source: AGHT+IEjlmX70DeLRJEciLAkFBk3zY+Bue0tF3APVQoqaplK6KVc6rciNLWIz2GfTGPGQsk9vJ/XMKGvMokg127Sl6WzprunGUn0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:220b:b0:42d:7d2e:2bff with SMTP id
 e9e14a558f8ab-432f9044a31mr23383885ab.22.1761722825196; Wed, 29 Oct 2025
 00:27:05 -0700 (PDT)
Date: Wed, 29 Oct 2025 00:27:05 -0700
In-Reply-To: <20251029062544.2my66%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901c1c9.050a0220.32483.0200.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dx_dir_lookup_rec
From: syzbot <syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com
Tested-by: syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com

Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
console output: https://syzkaller.appspot.com/x/log.txt?x=14969932580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d92b13f7aaac42c
dashboard link: https://syzkaller.appspot.com/bug?extid=30b53487d00b4f7f0922
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1363dfe2580000

Note: testing is done by a robot and is best-effort only.

