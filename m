Return-Path: <linux-kernel+bounces-873596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DAEC1435A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93ADF3A22FC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92F830C619;
	Tue, 28 Oct 2025 10:50:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7915307AC6
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648606; cv=none; b=qxZUbSXt1R+x75BmhpMbSgBKt6kIuqjo5vPoHxds99G/b175FeHlBFlXTqnkouAALeCOkHrL/MiUa5EWgqFiNa72c5q7lvevyAZgFQsH5C8em1rBBsal4BpD4Yirn6eor10Um6hPUY0/avkZxCyhwS9UvzJnkCKVwL4WbVhJCzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648606; c=relaxed/simple;
	bh=VxoI8oOQVj60FDTlSAosHNESSzVevd7tJKHlu4Sk2U4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=E/SCoUgcCbmT6M90I6E8RaL7zm0xdHnNob4eImWh6be21kR9aKQ2BuG6V0C/w+oDjJf+k2tdRF5gR658of59wci8VNl/d/R0IEkg/q+0UZPCpohJdQCfshNuxWOda2QOlwSPI6DxMrZ3yVOleEfRvqp1i9tvAl8oMT4WLHWcW6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430d1adb32aso56915735ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648604; x=1762253404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axTOQba/ADxsHKIoAWrRtTO1NJj5Nt9MjhS0qXuRVGE=;
        b=sdaxl/aSuH9UoNmmrdQX4I3dSvD1X//JOa961gkLztiLAdJ4ELBqIiZotuHYEdODAt
         ylGOUC1495L6+ru2SpZ72nf7RVm9MGYuLmayTyJccf5/r9bVDKrzDoMgjClFb/dILNCw
         cp5peNYrB1+IF0VfJr3qe/Y5P6T/pYWGdSYTxPK21iX7yEZ+cdrfKSBTkNv4zEXRrjs2
         iwYYAvGaGrJ9eaMUydCD66Q1MVHVuXo7pHBS/j/ge5YcbyjezncVqyKaBBx9SgHWU8dP
         UCM1mIQPwPO5YCQVtBSllNIB3T60OflcZ5OTcSY6nxf3cWGcfSZcnTmaq9OER5sYjObF
         b03Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBCXffLhI+m1bIP9r5l5fhJc+7F9XZouRbAN9JE1EPehMLToWNCGhk4Sj5+pBpKZU0qwegUVkgfkhTaEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvWoBeB4zbpKrm0RLExhbRNZNSUZsVFMHgUBGNcCCDu5rAiSkF
	gZvEuNAdRc1AbpMzB2DsCG8JiOFYfEUBBxTKO4GAVVS8LK1X5nO8+QKVAgKY5BwS9UR57C2ouYE
	V9j+WKU4mgONHn+hQWUagjlmhZGiSJW8yaV1PCWc3vOqTYPfKP50a+2uqBfs=
X-Google-Smtp-Source: AGHT+IHdhADEE/GL5F3jKe5V5yGjMbqop/Ia/P5tU2/bxxsAH1olv2IX99XpatspHklsrGYmZlToOamd0UAZR6Pb+4nsUL38DBst
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a03:b0:430:d448:eb41 with SMTP id
 e9e14a558f8ab-4320f7b0dfbmr44176805ab.31.1761648604035; Tue, 28 Oct 2025
 03:50:04 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:50:04 -0700
In-Reply-To: <20251028104159.Yh5Ro%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009fdc.050a0220.32483.018e.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_set_new_buffer_uptodate (2)
From: syzbot <syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-6.12.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-6.12.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-6.12.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=7aef76bdb53b83d62a9e
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f157e2580000


