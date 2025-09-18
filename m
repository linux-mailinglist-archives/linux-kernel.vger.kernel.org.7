Return-Path: <linux-kernel+bounces-823586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F675B86E94
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10201BC2527
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82F72BE65C;
	Thu, 18 Sep 2025 20:33:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB4C202C5D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758227585; cv=none; b=i1aEwOQ/RfDgdWB55oZJtbEvhXbVcG1l8uQZFwfZBJ54vfBVYhCvnFnItUJRwt25OjYf80vbz8oYI577aXCsyoibwcuKA98YNaZkWpEF2ygy5QSb+xdhW6PiGYn/qs5d0XMoFfOXQP5n25VwlqTUnpOkrXnEQiCLvW2ZB/M/ygU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758227585; c=relaxed/simple;
	bh=tZNfOt0nBg51fEGN9SAMNuj7W9TWJuzxtD2EwHxb9mg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZHgcV24gJTLqfTFsgKiCVVv7c5Al2p0Y11dPnuvAUToIrar6kckGoQnRG7Iuo6z4SVcozxxc8X7gg0WHlhxa4RgNn0pmVuaD9Dnq3wuv16RwuLUMF2plmaWg75r7JBYtCtE0YsQwI7nOODSc088WT224frYv12Xlt/OyVDZLiBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88c2ff21d59so271490039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758227583; x=1758832383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xOLgi94mmv+pTKcM9OOvBzHSL2HhG1EVnQD634oc2z8=;
        b=C5sFKEYq3+xJTv2/Nl6lOOZCRpfP3DKUtfTt1aKx4zs1Zbz/bidn86Hn13AY9gwirW
         AZAt+vm1qPBuMSnuL7C37Wm5y7sYbnXv3oMvC4x3Rb6n4dKER+pGdWRNRgu0f/L8OnQM
         MCf/+POIlo+wpCzclyn5RIDPRcdNELdfuRilMMIAUfN561a5AzlN/oVrSBVOpMDAj5+L
         qxlVikli6ruaonf0O4HoISHLJ+rV2RdvBK6tf+CsxtxpMXX3EzIRswrYnJq/bWj58kuD
         sijXlQIvpIj6cKJxGFUYpYeGIncfyRA9iVm4iTicwOLz9eZwxlIyinA0MIQxaQhVuMqO
         mv4A==
X-Forwarded-Encrypted: i=1; AJvYcCUoXcP3NuVPm+0JWrxa2iIQ0wOKC+EZBuyXpqRPL71LbrvImrEyotJ4QUXxxOBI7x4fRTEg8TBczMkm3Og=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuUp16+d5outTwhcTkDE/MeS++f5wbnfX5ooe0MvbVvkrq0la6
	OjbR6P0boYmbUfZ3kiiIJlnEEnCDodrjCiWQhos7Y1gp8iK0yKYucfmQfrEewwToCeghwZTIXso
	y9xTxWYalz6ZRQ1zUOnJDougHBMg2kGM4v3XJBpbCJl8T8xzDO087cvnPAtM=
X-Google-Smtp-Source: AGHT+IFPtszKsvRf1YfDPebIwD3xnODwUdOqd/NIMCD5PC1fUoqFTPIlHdGtKsLCRdDGIkWXdJxBup56O4pY/J2vCs2e95505lay
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3809:b0:424:7d6a:2b60 with SMTP id
 e9e14a558f8ab-42481981d0bmr14693335ab.22.1758227582916; Thu, 18 Sep 2025
 13:33:02 -0700 (PDT)
Date: Thu, 18 Sep 2025 13:33:02 -0700
In-Reply-To: <CAL4kbRMhZdBFgWvLQZY=ryWJy=y5eb-bg5MTbJPDJuVDM_Yj1g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cc6c7e.a00a0220.37dadf.0008.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING in gfs2_ri_update (2)
From: syzbot <syzbot+7567dc5c8aa8f68bde74@syzkaller.appspotmail.com>
To: kriish.sharma2006@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7567dc5c8aa8f68bde74@syzkaller.appspotmail.com
Tested-by: syzbot+7567dc5c8aa8f68bde74@syzkaller.appspotmail.com

Tested on:

commit:         cbf658dd Merge tag 'net-6.17-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148da534580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6299f5975c733910
dashboard link: https://syzkaller.appspot.com/bug?extid=7567dc5c8aa8f68bde74
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17361c7c580000

Note: testing is done by a robot and is best-effort only.

