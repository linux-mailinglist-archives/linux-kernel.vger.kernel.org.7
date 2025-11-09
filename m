Return-Path: <linux-kernel+bounces-891960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A53C43E90
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 14:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521A83ABECF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 13:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFE82F744C;
	Sun,  9 Nov 2025 13:29:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032632F7441
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 13:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762694945; cv=none; b=dygsT3sFdnbjo2nrJSsoOcjdQ4uwfTbCsJxKXGt3oR2dqmFuRmTrSM2p6orbUaF2lHNo33cakzqwpzt3z+ldyME91fVMZJwNH0rBDVMCc2ufa1hdxFhfZ/+QP+y1CXTTnzj11ubKkCQElqfFL0PYwq5iqqC+Je+6xHfD+9dDx+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762694945; c=relaxed/simple;
	bh=aM146yxzwz8M6e+zV5yyUXkkCC7w+Di/lE9P8XVIXlk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T+OUofjTy1NvWQNLaUCM3JSaW1Clad5tWbzZZRCm2CmPMBsp0L3yk4iK24kVZj8Zs9es2VhjNx96oBIbio0BQcVzK1b6QMGi//7Xudd0VWh0EQ1g5qMoRigipG7D8Fy+HeWD4cbA3kglsbKqDEE4guHkIwrq4zaDRo2IHz1nonE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9434f5350bcso173812539f.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 05:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762694943; x=1763299743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZ3CBcY39rX+j6WS8jJkkWnJhEyFoE/ERQKorvmFMIM=;
        b=AIhkkag+3VdI8HI/9ygDBcbhzcgud7uPodnbAQBNykXo+E5EjeWwR59RWiyAyQNsnv
         Eg9fhHjlMNVXAoKCR5fEJ/z5Wa7PwWaPm8/fnxsSIkcFeJe64fWIPDB2CoYm2i967aOO
         JX1uTMDpX1gSt7rSdCdfFha7ACnsp3WKL3is/G95LkzUg3dCkzEfKcgWApBnOayE0t7x
         NvfnDJ5uwPg0A8VzMa3vRnX7vWeO3b1NV69XqVC/r9kBvz1P55AnjSfpwSsKuQQT+S4F
         O8b44VXAelcR5sTtua9rCngeVgI++xZYr8c65mJkThGvlr3FqzjhPgcSUtkaQDkA8Anr
         LevA==
X-Forwarded-Encrypted: i=1; AJvYcCUnT/MCHgtroWObVzV1IrXNRBQdkSBYV7eEoK3AhLzmdQRGp/WPHIiTneC1hjcCG9ueA2V7CYYAwcbUqI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxKg7iYYLCTdYlPWcI0o6qZHf1HX0yipt/GgWJn0GIfoP8mBOf
	dr43kWGsWG+RqL+u2jQANvo3uek35kjcVHaxKUkRvCOTeN/JuJKECa/P9T+I9YStbMYwrcpKXuf
	nSnR2oag7jyFvzbFDemL3zFyxzNcRAqacn4XnMG+LxE4o8STUjaaVkQ4EyLc=
X-Google-Smtp-Source: AGHT+IHfXIX4xx9r2ov9DL73z6Fsxt15Mm4rkqtLm/nu3uA0LovxuxnmmhbMIhWOokgN0iQUbRcqxi1jpO3M1TuDrngYTTN9RGEW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c5c5:0:b0:433:7183:c2de with SMTP id
 e9e14a558f8ab-4337183c47amr41294645ab.7.1762694943095; Sun, 09 Nov 2025
 05:29:03 -0800 (PST)
Date: Sun, 09 Nov 2025 05:29:03 -0800
In-Reply-To: <20251109132736.1141174-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6910971f.a70a0220.22f260.00b5.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING in chown_common
From: syzbot <syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

./include/linux/fs.h:991:9: error: use of undeclared identifier 'count'


Tested on:

commit:         439fc29d Merge tag 'drm-fixes-2025-11-09' of https://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=df98b4d1d5944c56
dashboard link: https://syzkaller.appspot.com/bug?extid=04c2672c56fbb9401640
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10eb8412580000


