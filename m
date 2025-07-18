Return-Path: <linux-kernel+bounces-736863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AEFB0A452
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16D83B4FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432CD2DAFC1;
	Fri, 18 Jul 2025 12:40:09 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C6A2DAFBD
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752842408; cv=none; b=rqRssSwE/Xj3b8/BGQo/0WTomYH5LVnZicXe88pvcgGkZkmW5Jh4ejFfkDbcY6Uy26wqw2rVhZ5PSKwMCknNV5mxzf1C/neKDpauD8GrR28mdxUMgx2lpSJ1324in7pJmP2IeMd1ZbWzQ0bJMVv69wwWFEVxhRslXwbEGQScsTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752842408; c=relaxed/simple;
	bh=mzscwsgISffBB8jc2mM7fD3cZTKwDC1PSJfyhTtO3WE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mDtkdKGsE7BgD/d9e7TdhCRljVIwps7+SnEcLfhvDrBtzNRkCG3mxoh/IkWtb6eW8B6wzFQ3NNWKj7HwBUV7rIpeeEDdUj6flqYTScm8QB+AIpKtdM/nZ37PipvGW37IYBMbe5ioe76Rn5RmjZ5NSioWSsOu7pFEKmDZJXE015M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86cf89ff625so206152039f.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 05:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752842406; x=1753447206;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bXMQ4EI2qf+spXg7gsTmiqYbL/gnlWUvWHMjiMwLR1U=;
        b=uKoS6pj3fNXrW7xwbIEPIYxqeai3zQCvl1PVqHMNj3W/OApc20XL6ZANIo+6axqXth
         kLTqRPloyE8f1FToGp5nKj4dFitWdQjmC7XuHXmnxAES0MnQH+a5pU9X8D7YhwVDDdWz
         bzQNKbD70AoyVzWD7waH2mO8P1JYTFbRPjj+pev7mCOZgin/rkZjNN6+GMGEp79RPfs1
         XAErm7uouzTdTiq5nJDFkFqUT8/gf4j9xTKpcJhhNxP+EOXraUJThp818z6fZXRs9SAg
         hvtTjpFeNUf8EFOehz34rHG0iX/bSD+lk9MIJSEFop940PAwUIAfnW5vZnTbg1HApi1l
         lP0w==
X-Forwarded-Encrypted: i=1; AJvYcCVIQXDssSTVZmA0WHpgWCyxZl4ix5D6bp2f1OgZYc9tPl+3gm7JDRJST+5IMcQ+5WQfCwda/0qpgW9t2P0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUlq+1KSUFp49IAfSxEjrtEmvIdslx0UQ5QJP+230Jk1EkutvH
	J9ybitsRBhXYvqwfNlTgbqULpQIfqUNXm/3hy+k+TZAgalM2XVSGux7tU0xGO01NqHkLg3mt03o
	BAEQQ0X5K/53vDFhqVkoHKrSkoU+OLevMRTRw7vZM70DZ0pWX1JpNAoON8fA=
X-Google-Smtp-Source: AGHT+IEtI3go74d8Yfa8ebzUCb8mt0RY/vBgcEcGs0d7b3rfKrdNK3NCht9XEELhl2uE6+aFFXmleoBIuo23qB7iVJgXlk0fvhWb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:8c93:0:b0:86c:cf7e:d85d with SMTP id
 ca18e2360f4ac-879c295c88emr1085820139f.12.1752842406491; Fri, 18 Jul 2025
 05:40:06 -0700 (PDT)
Date: Fri, 18 Jul 2025 05:40:06 -0700
In-Reply-To: <df725c07-3ee4-477d-b4d6-21fb4afc61a8n@googlegroups.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687a40a6.a70a0220.693ce.0063.GAE@google.com>
Subject: Re: [syzbot] [fs?] KASAN: use-after-free Read in hpfs_get_ea
From: syzbot <syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com>
To: kapoorarnav43@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/hpfs/ea.c
patch: **** malformed patch at line 36:   if (ea_indirect(ea))




Tested on:

commit:         6832a931 Merge tag 'net-6.16-rc7' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f09d04131ef56b22
dashboard link: https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=129db382580000


