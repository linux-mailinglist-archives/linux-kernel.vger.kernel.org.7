Return-Path: <linux-kernel+bounces-850256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4048BD25C1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F5F6349E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1677823D7D1;
	Mon, 13 Oct 2025 09:47:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AB92417FB
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348824; cv=none; b=iwz5+bEnGqh0flScqLjuHZzQJsqszNbY0UbcyWpOxKK9/tS+CPNS10vxxMpF6HlTWbYbT15w8UH2EMt6IFBOpfJGhfuZx3fpGdsrI0G1COgqHxLytiGynzSt5BlTkeeclivozaUIs02XQUiXc2v2lPkJuE8azokAk6h0iUeb8pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348824; c=relaxed/simple;
	bh=ISX/bW+gUW4VLPw1CkdSS2M2Gev0JUif22Obp3cXhG0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=t5XrhObG4jblzaJbPhdWNrbTRuHUZCnGVptawvHgCt12Ly5ywT5PIdmuEA4HYxxjaiECDe2b/IisCHLJ12kAxWqnrw0w/jZMVnCvU/gc/lnazcJI4tQEghOOKZGU00zHL7pDVHHgSGNJ8IKqfUKrwfzQAF3upOzb+DSautUZ3Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-92c122eb2bdso886008739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760348822; x=1760953622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7yUePllVEUuAcNH/kJuUslLKWNGBeI8DJiFfZXK3dLc=;
        b=UX9fmlTIbGvFLSOp2qF9GEI3Zb9Vy4bnG9+SSiRkfMtZOSy40CwbxplET7iJsMHnjz
         bBqQSHLClnk1yVLGDKxL5cDTrBmvmnxODfLnT4KxgRzl0VwCSyiEEk9DMtSXzjN0RbQZ
         5DM39zbJNec87gWFREgRe2+pTcwTBxykkEYu2YsfYd3WWX/w9Kf7D1ZFR6KLKvX5hlkh
         EQ8U0XbJTSLOzlzswBT8thi2zwh/igQC3PlETjkp4QIetRCjy1BWM/BD8347lFmfzj/K
         yazsm+8clOM+LzaP6nB3a95uGnU9sBOChmfDTon0Gnx8X8Tnbv8Sru7qtgEIujuHATqe
         P42Q==
X-Forwarded-Encrypted: i=1; AJvYcCWx8BhS/t4eD/4Du3oOHHOz198xhH40Mb94+uqwa2SONuiXRCA+4opksOlrbLlhhTAGOqcqCqHXgMu8zBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoSNm9SWmZosATnqw6FD4e48MOV3Hdgnr4L29WyYSK1ORFB7s5
	DTpSqo1ICWrzi7/+YHPVc0a7D+3bYW6zHLRcX9E3evjSh2/CjnbjycGUkF9cJnQHAfLXKEebX+s
	SCySYClXvN8xu1k8XeP4ry7seMSwH5Q6STgd/qi0g2+b6GykUqqFa1evSRuY=
X-Google-Smtp-Source: AGHT+IFSSPFkOVilVF+bVBIHghmtW0PR5jlnl9NIOO0de0z6/eV/Dh3gsmO+Oh8M3Up01Qd8tEU5EGxQZFWHwbsSfY2lsYSHBeOl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:168e:b0:887:690b:2594 with SMTP id
 ca18e2360f4ac-93bd17769cemr2624284239f.5.1760348822422; Mon, 13 Oct 2025
 02:47:02 -0700 (PDT)
Date: Mon, 13 Oct 2025 02:47:02 -0700
In-Reply-To: <63cb0577-d542-468e-8adf-1d978ffbc465@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ecca96.050a0220.ac43.0019.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] general protection fault in ocfs2_prepare_dir_for_insert
 (2)
From: syzbot <syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com
Tested-by: syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com

Tested on:

commit:         3a866087 Linux 6.18-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10f14c58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5bb1f39a1998d400
dashboard link: https://syzkaller.appspot.com/bug?extid=ded9116588a7b73c34bc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13c47304580000

Note: testing is done by a robot and is best-effort only.

