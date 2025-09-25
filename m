Return-Path: <linux-kernel+bounces-832589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B04BB9FCC6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8394D7B45B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9E3288531;
	Thu, 25 Sep 2025 13:59:03 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFB129DB96
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808742; cv=none; b=UccqGTmoFh+Zt6zJ1yt212c8qHMZfW6SLK/dYhVG09oTezsOUoJWIFT8vosaArw9KTzr1Xl2UkimKaz0fujihcvy8LleiVgwmlc4NkGcyfmsKGW0d2/WD1iiTuLbdPI14174CxYn+PTQcT58kmlqK6CF3Y286sy5AYvk8FlrfPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808742; c=relaxed/simple;
	bh=dUXPBb8UoePfMeduek6i4pY3kcJw5egFRNTRJmZTbyk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h7YT2i9hs5s0nUk6Xvf0T9Pdoosz/XqsW2MuB1cZB5V0+MVdOr417z/FKHxKrBGS+yG0UGWKRixH+n8bFUGmkOeHKddzpdlFYUyueRUhcWbH79fzKsrb4gTJwzN/mXnPaR1hS3XgYTuLWiwW3C/HXc6DmRYM75II9xzi9N36MSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4248b59ea91so23380755ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808740; x=1759413540;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUXPBb8UoePfMeduek6i4pY3kcJw5egFRNTRJmZTbyk=;
        b=w0PZ8EaG9EcTZjp/s4TOIluuQod3jRb3Qo2mRYyTnP+dmoGxsmdk+YhK6qbgjmYwzZ
         ImvWn65K1xVIH6ZOQEQbAXQ7A23Jp+6L7panL0NeELAD5GZoyonyQMkm4xtgPkoJPZQV
         /HtjVl1Rs2cgnHTrMjZxDF4nYZj4Pc/LOUQvp3ABfwym3lFKJJb2YgBNj9vDcIUqSIPu
         RsETWyA/ZumRtBsREiw4AkYh0srvvR8wGcLkqPNIVLkU/TblQoY1l6skoi2uW/yshQIX
         NffzfCYKuNv6J+zeKgqbGiw5wn0+CW6aa170lWifGg6WvNf1I0Yx9wUve/+w2ZimLeBD
         tL7w==
X-Gm-Message-State: AOJu0Yxb1cp/Q3kjd7fF/yHlhy8bgpPMmeMW2JXsAvH+d6KsJlLmnwaJ
	/2JamjEHpjKfh8M3kwNESlnqccuTrUwLuAanhbK8grl5HBOPRLLYkf/mhzSkAJg0XTVloQ/IjvH
	zU6D9KR3OMqIahT2qTHgswLlhi8smjSEkk2MxGT7+IFjqYOxmTj8VHYRkYgI=
X-Google-Smtp-Source: AGHT+IFXd3u5aLEiLgJJcleues3ObZrhCo1k4LnTq71meAdH9OggOMkiv+u4LCfC6vLXuLyc4UCvwSUPciZeDWYOrzA9EXT7ncJb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1312:b0:424:388:6ced with SMTP id
 e9e14a558f8ab-425955ed07amr43319455ab.14.1758808740254; Thu, 25 Sep 2025
 06:59:00 -0700 (PDT)
Date: Thu, 25 Sep 2025 06:59:00 -0700
In-Reply-To: <68bf2c3f.050a0220.192772.0884.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d54aa4.050a0220.25d7ab.0021.GAE@google.com>
Subject: Forwarded: KASAN: vmalloc-out-of-bounds Write in imageblit (5)
From: syzbot <syzbot+48b0652a95834717f190@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KASAN: vmalloc-out-of-bounds Write in imageblit (5)
Author: albinbabuvarghese20@gmail.com

#syz test

