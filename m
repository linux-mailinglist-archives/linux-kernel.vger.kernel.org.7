Return-Path: <linux-kernel+bounces-887158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1FDC37698
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 20:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2B51899200
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 19:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE86321422;
	Wed,  5 Nov 2025 19:04:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F6B2C11F9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369448; cv=none; b=rqd50KLqG3rc/XE6SysPe0JRGHIoSLXRiXeHsmbIsSnIH3c4sAwammVVm7tum5cFj2TQiBv+uVa8jiy1gpxUPwDbo0EPHFN8EqAjoqW0C0eURJPgEqtgtazBjQtjL6orCHZm3Tvue4vJlMuf4wijeD0o+X9j3bKhffo1z+n9Pjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369448; c=relaxed/simple;
	bh=foAD3VAp5D7YieYlBATJtz5KKRvnEtO8TJhnZDOQw0E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=OpiOgEnEIZvAHNUcfV3th0VOo8eW3YXKrSqVvvK2t/oXv4Wql6GbcbDG+7nACQcMV/P88+EXeFFBqfag4/ktTVusZv2vPFxi2H8/C4l7UAczinxbn/IFiQHgjKdH2WaNioZrxSffOhOzN6Zmblhq9lW68aoHWkcfwuclskyqwqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4331d49b5b3so3870725ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 11:04:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762369444; x=1762974244;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRRzlP2SUfiESziI9LEaCdshMF/xNXFnIzUbHvATzWQ=;
        b=EY5UnFOv9Ey0NijjDFqjQhEVxKxLf/ODUVTO0GsPd1oevk+mP3nOl3+5g8BXb9iEpM
         acQd9WLljBiIaBjFHqZ2/3oifYL7KCdFHtzSMMqWUrslg99L9DxNbEY9R4Bb+Sq92T9b
         A9PIn+pE18qYZ4XugPSpNQ19ob8BLutL0NA9pzaTJzYHF8zkHvLeqJ4OacbZvugb0E+0
         VMhOS5OZcMerKRn2QPKHak+nHcBDYNO+hCMUwcuNljeMQ4uITANFwGMqtYqBQz5P1393
         zSEyU3WJsNYgLasD1DNBp5BtdsdtLSbl+vanq0FXgE4AVrOCeM/Dk1AEvuAQ2x6lucRD
         4rFA==
X-Forwarded-Encrypted: i=1; AJvYcCUWTa5HstrIvnGguYn/S8ajhxvwwEG/XZYgJdHwFMCsQbSHbgg5cv9te6sjwA1iz8C+Vl/rNz2xRamywuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrHTYBVT1jRIFCTvZmmkDxZkI0m2RTQxZsWzSMqUs7k5R0YPuy
	pwypDlEr2RcAQ5R8x2TvFVPWi3lnejzUF/oxaoLpjw9dj5UgcIIy/IKVNFuw7QCgq9Qttj/iQMK
	2ni81p8LekhaReaJF3n0ykQ7LNG1joLp63zegxvEuJXSa8tlBncmO2ys+BLo=
X-Google-Smtp-Source: AGHT+IHc2NID+f3wxoc2C6njAHWuBl+T8sz7NoKzzIOo8RC/YSjusT/IcfAH8i0LQQx3fH7zUDHvFRLQ4+XstPweDk8nR0LX1mNb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8b:b0:433:2a39:1b96 with SMTP id
 e9e14a558f8ab-433407cc96emr57471205ab.23.1762369444660; Wed, 05 Nov 2025
 11:04:04 -0800 (PST)
Date: Wed, 05 Nov 2025 11:04:04 -0800
In-Reply-To: <ecb7b4e7-5006-4642-8807-01b764cd4b2b@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690b9fa4.050a0220.baf87.0059.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_unregister_user
From: syzbot <syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com>
To: ssranevjti@gmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, ssranevjti@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test: 

I've failed to parse your command.
Did you perhaps forget to provide the branch name, or added an extra ':'?
Please use one of the two supported formats:
1. #syz test
2. #syz test: repo branch-or-commit-hash
Note the lack of ':' in option 1.

> https://lore.kernel.org/all/20251105142251.101852-1-ssranevjti@gmail.com/T/
>

