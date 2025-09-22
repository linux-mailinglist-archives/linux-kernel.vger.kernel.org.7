Return-Path: <linux-kernel+bounces-826579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A87F2B8ED80
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 05:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65436172767
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD6F2ECD20;
	Mon, 22 Sep 2025 03:14:26 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F60C2D5426
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 03:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758510865; cv=none; b=lvHGj84XJ7uINSiRUb6VddHPZkkS/2MAXTgWMpxs8UXbWjxEA5WPM6D7ZvzLgnFvhNPkWH212m0JZ4hn8i2moZLKeYir/Bf69pqV8BraK76ZXishHbWyu85roLsjACCybUGpnz4w0u9YWK+MptGRC9qWagKKQXazY1qq1GvQYzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758510865; c=relaxed/simple;
	bh=Vn8kTjaiavDdyc8/wlZpxrXePEbx3gjEURKJpd8Gq8k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=iifzAShQpzxPy2YcKdzh3KAXlKePfvT9fz3wEJkDRTV09OH23AhtqPuLQH0lNdWa1fMpGgpoia5+CiGqy61mEE7zaTWtenpHrPWTscb5cBwtIUO/8KObSnaG7BRhzRACOIludGj172MxIQkSWkoKPJvZX84NkFQpj99zg7PI68E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8876712ea4bso899536339f.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 20:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758510863; x=1759115663;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vn8kTjaiavDdyc8/wlZpxrXePEbx3gjEURKJpd8Gq8k=;
        b=JEZLrdnxM3KxCmxDSG9U8ibve9JH13hty0T7QEWLd0o4ZtWYJBKSLwvRAj1+YPcqMJ
         qgTngxbsynVqMz3VcPoRiefu0iYDegp4VHKBQ9GrOSv2+Ouee3XCe8UbtzwfDARzVjVR
         bceoUdRWdLY+IL2O9cjgAdXF10AJTuOhGMMevrBREiIkutH5P43Py1+NnHDyxdrWsXe1
         YXJ7r1CnIewjIeVhrYcjE1lMMf7VZIKqquQWTie3g4k42rOkNzipswpjHT0NCDX85H+K
         TeTZvFgzaBS3VR+u4p9eiJwdgZmZ/VfPVqq8CDQ2Qo3eR8liibGZHIxpAujfpMPMTHmg
         FsEg==
X-Forwarded-Encrypted: i=1; AJvYcCVwhZG9ReuO5UM7+YOJT2Fwbvu61utN0P4yJDGHahthRe6oagxPH/6XnRfGzzDcv/Er8jpY4yQjudQcmKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB5ZhLfBXP5aE6OmSXQFIL6K889JgjMN3Uc8HxtL7Qoj4KvT8k
	l5gH2oVEKEIlPxI4c3qs/xKInrTwvkS+Pf9v42qInJjapBlbbR+2YI58wxkibneADAD/fu6+Esy
	RlWw+NyzDF/CAYqjKqa63rouiYIwRn9Nce5HEUJzY7DwBBukLPTyv5/1/KM8=
X-Google-Smtp-Source: AGHT+IGn8QuQpUdf2Zc8Baw/+bo8UnG4g9c6PjF34S8MjV1NfPMr+08tNQtXeEEb10svH+z1kONJei/p2YZxWzyt3A/ZVE3ARfxF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:481c:b0:424:85b0:e1cb with SMTP id
 e9e14a558f8ab-42485b0e39amr141979105ab.31.1758510863362; Sun, 21 Sep 2025
 20:14:23 -0700 (PDT)
Date: Sun, 21 Sep 2025 20:14:23 -0700
In-Reply-To: <CAB0g3m7-HYyWLitjUq1PMKDr2q5cDvmWypun80sSE2qL2_LWcQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d0bf0f.050a0220.139b6.0012.GAE@google.com>
Subject: Re: KMSAN: uninit-value in __bch2_read_endio
From: syzbot <syzbot+7fb23a5461e8c9d38a3e@syzkaller.appspotmail.com>
To: hmarques979@gmail.com
Cc: hmarques979@gmail.com, syzkaller-bugs@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> #syz test

This crash does not have a reproducer. I cannot test it.


