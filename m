Return-Path: <linux-kernel+bounces-814697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF0BB55762
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42835C2D10
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7887633CE82;
	Fri, 12 Sep 2025 20:06:44 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73A63376A6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 20:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757707604; cv=none; b=TX/khCZ81TjKGyZ6ODLNoKUgMCRJXfQL/gQ1sgE84Ngsf7bU6Y41ExYYjkKwUdcG4Dr07HQDRFX2w/Y8IWpK6Nc6lKg3LKJPwX3X/pWgjynnA3EojO8tF1YJ2P1QnxJPAwgp2KRwwcetCIBQ+Bblps1Xxiw8zqEJrZTK+Ox2X4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757707604; c=relaxed/simple;
	bh=Vn8kTjaiavDdyc8/wlZpxrXePEbx3gjEURKJpd8Gq8k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Zmpj/Khh3QDAp1aCIv6YUeQ+XaM2ZaG6f1fOyQafsxeolHXID/lpqgh5QA8hIXxh81rtgsA/ewLP73sbzcJ+uWCSK467nishWDAK7cv29oFEUHlA+aCEW4+GEbefTDrTJhoAo7jCEkipRy6uhBhIrfuO5V9gXtAaaOGoLm37Tgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88ad82b713cso282451439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757707602; x=1758312402;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vn8kTjaiavDdyc8/wlZpxrXePEbx3gjEURKJpd8Gq8k=;
        b=bX472xsCrvhe9oWDeAe2/VfM1ekXWS4hSds62WiYGl1RRcySSPUxH+3yLaYSqmBicD
         SobsPMZooHETikyjLmxXFa/ihKNlr4wTd8kuwI0HaUDDhGbV024MirjbitZkwHHq1lOq
         4Okt/WJBdYUUu8P2S20hjyDsAUKEBDg0W+3OqMDejFvzhfCAsXCzfZH/pUFNYPzgiZGg
         uRcDiR/zEd0HVFdS9C6LNX8FpdDORzEDqvGFcvxC6cEqHu9sqXnAzEsUY+7BELsODrqm
         yaN5kPkxTxJqsYk0tEow7pjb7O6/tLXLPF3B9cETFPUK8jdBVzwJyGc5x61ipb+2yLxo
         2qvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtkf96fiP9K72G5wh87VxKwKAkNUED/mxjs650PvF7v1ZegPw4Q7ABgBM9mYnW4CHde3GF9L87EqyLU58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuAI+d/V7qQbC8Za6Xz9EWAFEuHoU26Kco1WRm5F6yI40nd0cx
	ZFk+Lw8KAz/lrJyPovzX86YMWzcYs7R0x+iLcrefbLL2RnSzrMo35PPu4UNNucNIkn/utWHVTga
	5/N4P3N0uYcMOHANkyVIqbTKuTB9UoCDbrztz5VrzfeMPcpt6NYBba1bBJW8=
X-Google-Smtp-Source: AGHT+IGe5Wk6YE6UlNdFqd1Peh9ol2Z7QyziL+R5YMsiyKksyEdkEC/iOf5DflIECn9de1E0ih1QrfYz6E27vJIpGnypxkPrxWrv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4807:b0:422:1893:3b70 with SMTP id
 e9e14a558f8ab-42218933f43mr39727645ab.9.1757707601773; Fri, 12 Sep 2025
 13:06:41 -0700 (PDT)
Date: Fri, 12 Sep 2025 13:06:41 -0700
In-Reply-To: <CAKX1i=DvuPZ4LUPxn8W5d2-5t86xEJ_T2J3PFxZZoxL=99QzJQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c47d51.050a0220.2ff435.0361.GAE@google.com>
Subject: Re: KMSAN: uninit-value in __run_timer_base (2)
From: syzbot <syzbot+7d660d9b8bd5efc7ee6e@syzkaller.appspotmail.com>
To: rodgepritesh@gmail.com
Cc: rodgepritesh@gmail.com, syzkaller-bugs@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> #syz test

This crash does not have a reproducer. I cannot test it.


