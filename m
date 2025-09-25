Return-Path: <linux-kernel+bounces-833112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783BFBA13F4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8771B7BB9BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F2631D396;
	Thu, 25 Sep 2025 19:44:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515ED319875
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758829445; cv=none; b=EeJn4G+cboKPlbegTwIwIkdIChOaFnFCslomd/agsSmFZO51UiK3FJ6RYfIt2dxowAoE0oWWYf+cH3HVqqdT5uvE/zjRwOfTmsNocsG3FpH88cr/jt0UOei6lRvPBghJo5RB1X7HyIFRrfpmBKBXz7glBz0yg/o+8P532xTPPCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758829445; c=relaxed/simple;
	bh=EA61ik5Y30OAM7i1KnxnJQs7gbO7/nd1TZE8yqIwVfc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oX57A70rdHLupHOFzNkiuYTAONaVs5MjOJsJg3XA99jHAuHBs5WRg6zTwA0TxS3zhFTu1STUIJxwkQ64vmk75IUYPDnXPBhEB8+nRbByMqFq2rjWNw2YaHrqGMaTp+2l3yjAYoqNJ69VbKVsx6eXcQzN204imJlYj6unlx8Jfss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-893dd6dfe1fso163641039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758829443; x=1759434243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=344nvzD8AyYYWLikT07PUQKC+fnV26AQ5tIe0txvRKg=;
        b=Tvw8W0lrlbuIwTCmscKl8MI0VIJ12cDe+BEatkeY1HFRJOsC6Tb1UZp4vkrnQZPU9s
         NXir09pJyc21bnuWgQ3JRAl0SNFpbv1a9WMyZ5Q8DqOwGXS6xJpW/+fBXRwjcwTSatfV
         SV9eIiSSGaL2GSFIIxOM51qMAbRDyW1NMQK7B1gAWNUboCCXUuTYzRM+sNOVzIqWufsH
         mH9W1SwxbrGH8Pwe7hgTk8Cpk7voWZLsn/iQaB5CH9cS+vskjWgLL+EsGUKWt940QOgj
         SG+ZbsCG8wPGeCIZFtTX2Pmsi6JU5AyJMOVYAfEKd2dNJxXXn8tmWS5Wd2fdK+Q8CNkk
         KsmA==
X-Gm-Message-State: AOJu0Yw+J33F/m80XGBTeYGpN1evl5z/V4CqP7EGCLxjxl8dv6wlxdO5
	u67bCkqk1B1RxVWlGI/DlJmEsSCVwT0Y3rIq5ORfhcFmGagmJeYs1P32uj/Sw1Wf0mijj5YBr/q
	DLTYEgC2sx1Xg9h8ZMKsT9vuYCzx/4fqN6vcB2qERu9821N8rpdZaxNDVqYI=
X-Google-Smtp-Source: AGHT+IG4l9QKv+iNn5khYLLO9gghvhUBRklY9wlJUMBBXq3+iKMZ79cCmyb0agqRR3JlWu1B7SMUu71Fa9BnoJsVq6gW9gKcYVA9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4a:b0:40b:db4:839b with SMTP id
 e9e14a558f8ab-425955fce62mr57692135ab.5.1758829443470; Thu, 25 Sep 2025
 12:44:03 -0700 (PDT)
Date: Thu, 25 Sep 2025 12:44:03 -0700
In-Reply-To: <aNV1BSMAPsx_oKiH@rpthibeault-XPS-13-9305>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d59b83.050a0220.25d7ab.0063.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] KMSAN: uninit-value in ntfs_read_bh
From: syzbot <syzbot+7a2ba6b7b66340cff225@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, rpthibeault@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7a2ba6b7b66340cff225@syzkaller.appspotmail.com
Tested-by: syzbot+7a2ba6b7b66340cff225@syzkaller.appspotmail.com

Tested on:

commit:         4ff71af0 Merge tag 'net-6.17-rc8' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a71d34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cf2d8760d8941fb
dashboard link: https://syzkaller.appspot.com/bug?extid=7a2ba6b7b66340cff225
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=146ab4e2580000

Note: testing is done by a robot and is best-effort only.

