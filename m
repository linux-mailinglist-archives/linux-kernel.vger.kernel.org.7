Return-Path: <linux-kernel+bounces-804830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45553B48073
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 23:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E4007A9821
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 21:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A081F5834;
	Sun,  7 Sep 2025 21:46:20 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7CA219ED
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 21:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757281579; cv=none; b=Qx+x4osO9i1BRkzksmZIV0+U6SUuIXa/aOWO592kCkiwvG2c/fLd3G/6rIXyhehwucKrLhyB3WGRYivqNglb/JrTrGrkzg9AeorgUX90z3ydAqvK/sHQnOwZQcwfyx0ehJA037OvjvFr6FMV1mrlsy3jyHYjdgxh9XCq7GiD1EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757281579; c=relaxed/simple;
	bh=FIu6pRzOeVy3C06Ag+VUl7r3NomEfbd7//vNcmPmi7s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=fV3Kj5nX0mR6ADrO/yc4P2XQMVzJvbFC6KHeIFfyNtP0bGyztJtJxZzIUdY5rvSBvhzp1r1T8VEDaq0h4UfV6KBoXbSc3BXIjYSJwBFxe8QaOodgUXM0x6LsMMRGrPwjodprS6GHp+sIlad9/Q/mZttJpwGwwS3Sf+1UgAzKEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3f66898cc14so46926315ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 14:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757281577; x=1757886377;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FIu6pRzOeVy3C06Ag+VUl7r3NomEfbd7//vNcmPmi7s=;
        b=VGtmBs/O8cLMr85j5k+Isgks1Gy4TRTpaSa9t6HMnMyEJ2WWHAe1g9vvKx9tCha2KW
         ngedpE2GiFPAUd7fikZJFuPc+YX7WRuzrYtg9VkD+liLxWlFGqBgsd/xcuQLK7Df5ihT
         ACo/oEqS6ZUZJlDOx27cGewNfHzt0FcZ25gTUXpxJAoQzoKme2JM0l997ysA+wEUbu/w
         WrJxC1lKc6fMaoWGoXHk/SIupBxWijcXyMQly6Kl3Vz+Qa+wxgZ5DBOWiGkoJi2+m0zu
         OgGF74XiV4//XeadzG6fO+TzNHNf/bMGhJn2fmIXaP39aaJUTnwln8pgNx0M7RXJfcLt
         SW8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLYbIvSdJkh/27uSlaCycH7mt33crE7YSDplCSw+Bxm5Zz2iOq57hK6lxaEmVikgZP5FULMPqGDKZ3uHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/AxwXThua3/IXT1UmwGIzSQNu2AIDttgrpkUrUhOABV7KDLJq
	JgtsaOCQM7MgVIufcU9ma2bHX0mVPz6vUrWowAhFtWTkmKcehg4leq/U7az5Ea7HCvY+a7W8Uu6
	u5eGVQ0Mbcp08qF4/3yEBY7peieTTRi4G5OG48hGdOimu9jQNud2QnPxIIQc=
X-Google-Smtp-Source: AGHT+IHxNFv9Euy2EVXBmWn61vQARCZNGXvTq3AbBUpLoccsFpvRYx/AqWu2Ye0OCeA8E8KwqJDpKOs7KmOyBjAV2c4ZvrlKvnCj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f54:b0:406:e1d9:5f4d with SMTP id
 e9e14a558f8ab-406e1d96066mr15673265ab.5.1757281577387; Sun, 07 Sep 2025
 14:46:17 -0700 (PDT)
Date: Sun, 07 Sep 2025 14:46:17 -0700
In-Reply-To: <mQ2yJVWJrF-8nTP994j61yzMa3nn66J_WsQMdow4oAj282aTD0rrZa52JKsDkBeR7QSPmi-U7kK86Gi_uCrHdX_2yTy5_1-FwaDWvWX5b9o=@proton.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bdfd29.050a0220.192772.01e1.GAE@google.com>
Subject: Re: RE: [syzbot] [net?] WARNING in nsim_fib_event_nb
From: syzbot <syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com>
To: maksimilijan.marosevic@proton.me
Cc: maksimilijan.marosevic@proton.me, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test: https://github.com/mm51593/linux2871306d95759d0e38f9ce636e1bef6aef431aa8

want either no args or 2 args (repo, branch), got 1


