Return-Path: <linux-kernel+bounces-744059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7499FB1078F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA4A4E2E59
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F14E262815;
	Thu, 24 Jul 2025 10:17:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EEF1FF1C8
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753352225; cv=none; b=g7qmZo1zhLrXq/G3qZZ2lD564Vte8LJ364oa6+Tm7wD4zKP/QBQhK94wZdCJBZssGIytVAGHsDiq7pt3EHk5bIOyOB/smIAOGzFHC5csmoUfFhN4hizuTLHkD/bViP0uaIEaMQ9UNEXAs6exkv62FErVvPfK8GhVPgg9AejQHVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753352225; c=relaxed/simple;
	bh=D/5UIasNUSImAED/5qCuL9PaTZs2TXLkOD8hcFdNSLA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Bm1Sk59Km3/dwYQTB5B9nC+y/305RBz1wQ+SDR5X9JzMhKaBSpszqCRBKEfMpbYh9k38BpsOZSabLNgmWthVNii6oADYQvA9NBXR326BE3KK7iECTbAmV8Z+ESb07xyxLGC3yhKubSBeTcdPEzqvntjEqtp3IrHWaEL5mSWwSQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86d1218df67so86682939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 03:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753352223; x=1753957023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SpU8/uah8QX8iG4Hh65abI+k9t/qiXj3b2vhPTvqWms=;
        b=eN+4Km1jcYHNgJCm4hK/f+Z/NCD1SQMT2Or22lf5rtz9KI+K9H3xXB5jBCigMjsrLt
         f7nUOw5n+OI/6pdUuVNlEukQ7nhGAFm0mpEWJS8kbsB+sBJlB1sJpjL1BsZQTztgai4r
         FKPSlkbOSc807fZKy26sCx75iEAFveIimh4PSB1guwY1Jl4jt+0f3fwaSzjgZn4Zxcvl
         lIdm2orOV5uMzcFs5RF8vU7PS8h2TaUjaYctZ9ToariPWYj4KPeF0wWJzz1rDzdOFtC8
         sHDOdNoRzlGaX2c/hPk/IRH1wNMaoUZZGhMxZMXHPSEIDJFIXQ+wZjXst9j6Pxv6mRBr
         VuAg==
X-Forwarded-Encrypted: i=1; AJvYcCXBHfMEP/k0QzvJ/O5vxyeks33JDrOzIiO2js+TNL3BO6oZHOSNEKEem0cO4GtwCfSSyRgQaKJcDY8wr9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnnbrnf+Tm2UDRuIC450sS3+I6jo4K5iuwYGRUjM1K0FG8WhGo
	U2j3F+8PbA49/GwH7iHOm3Wi2RcFXRWKvI0cKKOekjq7eUvz5E3z2ghqwFCVMxmGtTXBFFNUpAB
	LmNObo1GVWWb7gPtOnRe6/6GeicinWxw5uXSHpjbJ+KZRUYoPGdujAWCQKyI=
X-Google-Smtp-Source: AGHT+IFUfiyo+d4QHuqivqXpEYDcBTzrouY0GbCUYzs8hwUUQdqQRwXSq2eG09wAXbnaPX5bLY2QJ+VZpO+B12JBiSUAihA+ieZ2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1584:b0:862:fe54:df4e with SMTP id
 ca18e2360f4ac-87c64fd8f3dmr1236603739f.7.1753352222746; Thu, 24 Jul 2025
 03:17:02 -0700 (PDT)
Date: Thu, 24 Jul 2025 03:17:02 -0700
In-Reply-To: <tencent_71A2963037984AD4740F774567DC3C213609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6882081e.a00a0220.2f88df.001f.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KASAN: out-of-bounds Read in hfs_bnode_move
From: syzbot <syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com
Tested-by: syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com

Tested on:

commit:         25fae0b9 Merge tag 'drm-fixes-2025-07-24' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170ae0a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=859f36d9ccbeaa3e
dashboard link: https://syzkaller.appspot.com/bug?extid=41ba9c82bce8d7101765
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=152e3fd4580000

Note: testing is done by a robot and is best-effort only.

