Return-Path: <linux-kernel+bounces-745613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E911B11C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD961893D2D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAD42DE71E;
	Fri, 25 Jul 2025 10:21:27 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871302DE6ED
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438887; cv=none; b=W0tozPXeyOViOaMNUUX4LMdVzDWcgOuWp/puMuITafxsQq3Y4gsuNHgmc3lhvbkXRCYTHK9qQQUF/4l0EcYBSr24np/5A+FnnAmmsvYvLwN7IBVNf8HJzeLGrPPjx3W85GOzo4EDfI2CyeFPC1+yyie1bU90r832GDamvCy0MCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438887; c=relaxed/simple;
	bh=nS8sBQa5W/Du5q+hZRKZYwOkT4zNovYlUbG6dkuIPsw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=noJLdnUR+vr1PF5Ys7YelHdugK/zvRyC4jqeHZ8Kk50DdnszjwcnER7WJ4TLoJ2uwcN9M+6brxskUTHUZHjHTVpOrfMLJhYCqrAZlABkvbUirQDe2Ll/cOPANdZXmftIhqvPyqzmfLp/vwK9SWQdJ1opBtUdmKFIZXlla1JvHNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86463467dddso216783739f.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 03:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753438884; x=1754043684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfjMseACJajmFQUWdcr1KnZtp3lHOyTwsF7P7BpdQfY=;
        b=V34T7Ug4h2q6JYJ6hKM0rc6e+M9Dxvy5md4Mee6yqSxuc4hgIAIm/6cfAAJJko40eH
         WsigPFSENooHewYxlXPrRh+IurY2CNzdyAET36MCQWVwZi9QjMf8dT0SxhioR7wTuNfb
         ql0nGCkNJKaR9Fg8a5lm6WTVKkdphbw8KBvyJioHziHc2WkXN6dLk89VlgYL8QHdor/3
         +VaKL1zrKIcnnLsy+0nRZvHeJbnIFpADVo4rfF7eAeuzoi0X2mLfPvQtAVIAYJ7MC5eG
         vTw5kMz9ZpY2gNIUiocLMAQGIogOWBoQTc+m1YB0kiu2E9ejBsjlaimaskszV41tqxE+
         XPJg==
X-Gm-Message-State: AOJu0YxNVuLfL9kMupQ4kJBSJiIndVLgclaPJDgLwQIj9d+/u0cl1A/3
	/xaDykuQ38yUXhiuIEwzecKDOoglgv3UBC1D5PqgN1Yt2w4YxuZvY+aLD54lxOPgmBl80KafjaQ
	vgyZ2w9PLkTbM3konhv0VLuHiMPcav87HsESHSBua1oDt4V7KDMnDX4ssruU=
X-Google-Smtp-Source: AGHT+IEgcKSv1TWOmsJIRwNaDIGzUVlitUUTaFLXBhGXTDthK7qxMHkqRAebc54OVFzXRa5hFMkfRc6umffQW4VLcFFRL+O65nem
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:97:b0:3df:2f47:dc21 with SMTP id
 e9e14a558f8ab-3e3c531f82cmr19006645ab.22.1753438884669; Fri, 25 Jul 2025
 03:21:24 -0700 (PDT)
Date: Fri, 25 Jul 2025 03:21:24 -0700
In-Reply-To: <68794b99.a70a0220.693ce.0053.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68835aa4.a00a0220.2f88df.0043.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [kernel?] KMSAN: kernel-infoleak in do_insn_ioctl
From: syzbot <syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [kernel?] KMSAN: kernel-infoleak in do_insn_ioctl
Author: abbotti@mev.co.uk

#syz test

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 23b7178522ae..360fde417016 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -1587,6 +1587,10 @@ static int do_insnlist_ioctl(struct comedi_device *dev,
 				memset(&data[n], 0, (MIN_SAMPLES - n) *
 						    sizeof(unsigned int));
 			}
+		} else {
+			unsigned int n_min = max(n, (unsigned int)MIN_SAMPLES);
+
+			memset(data, 0, n_min * sizeof(unsigned int));
 		}
 		ret = parse_insn(dev, insns + i, data, file);
 		if (ret < 0)
@@ -1670,6 +1674,8 @@ static int do_insn_ioctl(struct comedi_device *dev,
 			memset(&data[insn->n], 0,
 			       (MIN_SAMPLES - insn->n) * sizeof(unsigned int));
 		}
+	} else {
+		memset(data, 0, n_data * sizeof(unsigned int));
 	}
 	ret = parse_insn(dev, insn, data, file);
 	if (ret < 0)

