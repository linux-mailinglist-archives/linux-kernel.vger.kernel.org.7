Return-Path: <linux-kernel+bounces-874581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F931C169EC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CEE1892796
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A560234FF77;
	Tue, 28 Oct 2025 19:31:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD17129A9F9
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679865; cv=none; b=dSZaHuv7evF2qooMhlTSma100yonAlRZIkog97bAS6qzFDzOy7zVD2QyJ+m/W8+2gWqPXfvC3JTSxiBE9OG1HMwL2eGWtN2sZ3JlFxtUgBRq9N7L6ZKczIaNW9ElFFJWMpZih2Bpe+mvhBpGMfaslANLFJYf1cKtT7uB5QhTu0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679865; c=relaxed/simple;
	bh=Yi9ZdkKUvT5kQdi7KhN/G5xEcH3zM03e7B2Cg1YT/Js=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cbg1BwAW3P6Ptn16MC0rIKENV/fcc00S+5PioiTMsVganM5X4yt0pkqDNzx7m7t4yLxaCCQ8glAWkDd14f+fO5O/URn0SfH6mqWGMvdK6x6j4JWndtRueFgHUCfJr7hZKp4ur6TXekB5YfoRd/XIQ78U8OqhXxVMJvSQ8S2OW8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430d7ace0ddso84044175ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761679862; x=1762284662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypNwUHtYJLfsPaWjt/OGN+7vmfUgF+X9zS0vjQ5mmAM=;
        b=vtHzgMh9vHexJ2Q71Bv9PHiuSi/cIlc1fIfm6+FwXBsRLvEr2DEll0noo+EhZ54Q4+
         tIKFTPMrK8zoKP+L7aQv1Ow7+vrKuPlnEZv/EHmK2z2VfHsALY/TCISVCsHgV7UVV1bY
         LpiOVdaYtKxVh/Phlv+GdE5fBge/hVB6Bzqg1kTWV0H4DCQ+iV+rTf1t8yhO/FRCYoIa
         LY1OyUthr+pkEsb6wDP028GgK2/cU89RD6k7bU3GK1KA5Ukcluiye+q6MaMORwg0q0M1
         Y1goObqYBSX8Y75vlg5zTLRgU08zSpbSip8CRHavOGhn0AGd3DsZJU9/OxAdrw4Dw++u
         86Zg==
X-Forwarded-Encrypted: i=1; AJvYcCX731S8g6uZy9fZvDo6qBuGcAB+2viMjNhQ9+8ymLto8qSWEHmiiqy/YtStfKcY5897qkcUBcgi5osIOUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo/afrDfibW5SLnXuw/eHNCJVPq4LrfLkVHwQGt7ZtsdzBmc+7
	rO0In8x7x2kDyMYU5F8BrzDrlpUCiev/LH6bNly1CBWOfBtN8HCCMFzMqQp+QZ6Ci2TR3yTD7d4
	GnVhCOnm35AIbaBgIwBd+yFWKLTaxWq6pd3vckzB8hRB0MDICZLxxs2pUVUA=
X-Google-Smtp-Source: AGHT+IHNTLk+yJl9rchINFeA06RXaKEII7YKSbh5JOTFNOfOblbiFIlw3F4TatsCfJXqGmWlRWfl4okJC49RA++Cei6tc9Od5/D0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:220e:b0:430:afb8:eb7a with SMTP id
 e9e14a558f8ab-432f9036f17mr4465665ab.21.1761679861943; Tue, 28 Oct 2025
 12:31:01 -0700 (PDT)
Date: Tue, 28 Oct 2025 12:31:01 -0700
In-Reply-To: <20251028181937.VGTo3%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690119f5.050a0220.3344a1.03df.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_set_new_buffer_uptodate (2)
From: syzbot <syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ocfs2/ocfs2_fs.h:474:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:489:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:502:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:646:26: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:659:16: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:807:37: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:943:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:1030:39: error: expected ';' at end of declaration list


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=7aef76bdb53b83d62a9e
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13cc432f980000


