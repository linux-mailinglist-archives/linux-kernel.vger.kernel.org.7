Return-Path: <linux-kernel+bounces-898611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E54C55977
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 734544E2CD9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695622877DC;
	Thu, 13 Nov 2025 03:49:10 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCCC274B23
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763005750; cv=none; b=SN6XYIyOKmNc51vS7cQGJi1rZYoIy7yOK5UUeAPdY/uxKUXv+BAH2f+HPZXNsQMmPgCHSRVS/emV2HV+6nlqDVxoFtBl0iqSmRa2oea+omyiFiaiyuqbiB+kzIH3Sh+XeY38+l18/MOWH1N2auuWT3CycrWanSkyBhfXw8oOR8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763005750; c=relaxed/simple;
	bh=BRkGrLQrNSh8R9z5Glb4y5FFkCpIsIQK4TzAzzM+zTM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eSETBUPU3FBxAXpvYAxQ+vyIqirIRcsYXsVo3cZ9RYn3I7TTl/DwgOOcq3xhPjG4ob5rxaVU/Rc0qMQ9jLG0HDUkPSdXHddxdJskgqcUK46JEueDxH+TmoOZE4T6F2Fn67E73L+dALy5UdVekPadEC1Wgx+fJHlG+Bn4ZbHqUak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43329b607e0so6637315ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763005746; x=1763610546;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRkGrLQrNSh8R9z5Glb4y5FFkCpIsIQK4TzAzzM+zTM=;
        b=eCyPKK20E0GewCwSEasUkOiot815zSyKZa0HWwCMLwsGr5bDE6c7zrQtuhctrneGyY
         /kh1Om0BMTYp6+BwwijwhBhw39QJ1SUjBs0uzxsdFQiL8887IFtsghk1CQvi68hsWZal
         XNO8zp1Ztqw+H2+5QBDzJmEVca8oNbU39wBlCgLAlFg/9RPPJmuL/+QabBisPCH59Vv9
         2KjZ4w3eUiAuFj+RIQsHkKP1w+vAHynEqc46mYO5rDcscnqdbx1k72PKPYhKejQHLdsb
         Sgon/ceXsaKtm6EyziEco9mdHx2/nyue6DPu2qgkLkvizDqRSt+9dCgW4et2IN4AI1mH
         RuDA==
X-Gm-Message-State: AOJu0YzlmnQmdRq7FopirUgwqjrQwnl1lWp5KwqK/LAZR7pm2phnN7jR
	ldDCy/NVeXd/MuRMMfBlHY46h2WRxcJhyBn5yt0bq21ud6g9ReaGvDzoj2dNtsycOvMaYL8/FOs
	g4X8L/1f7GMzqK0d/EkmQIiqMbwZ/dP/cU9TDi6kYPlfX3h+2hX+nuAhK3ns=
X-Google-Smtp-Source: AGHT+IH2nkNU9nJBktqU9EomF7NWD6cuRDMlCr4fWsHjpaw7xUUEEGISck2wSGjD6ttl6cWhpyOym6y2WawOPKIsSqrmqumMFi0P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1705:b0:433:7d04:55da with SMTP id
 e9e14a558f8ab-43473de79b1mr69423835ab.31.1763005745765; Wed, 12 Nov 2025
 19:49:05 -0800 (PST)
Date: Wed, 12 Nov 2025 19:49:05 -0800
In-Reply-To: <67c72724.050a0220.38b91b.0244.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69155531.a70a0220.3124cb.0014.GAE@google.com>
Subject: Forwarded: test fix
From: syzbot <syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: test fix
Author: rpthibeault@gmail.com

#syz test

