Return-Path: <linux-kernel+bounces-738034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54282B0B373
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 06:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ACB0175C5E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 04:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89388188735;
	Sun, 20 Jul 2025 04:02:08 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8718122301
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 04:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752984128; cv=none; b=mFgTe64ftslMaAJW9bivAms2UjBJdoYQIQuQYbWK8j/Ghdro9doyk7fJLE/UV81DSDkcUAdxsbgAmg0NX2UQ1MF55j9V9tE8KnYFw60ZyyJLplxTM0ufCqcvlP/3tv49rTZ3XYQGU2kkPqxQhX9qXrv7XYqcTGB7xQfUEHtsVFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752984128; c=relaxed/simple;
	bh=ioax8aumBii614bwbmePLQ329YHYaX4pUUw016g+CRE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=r5vJjsySw06DsCucnyBXU6R5txdELYXHtvagGQxeW4rCs65wAwNe4S3XQUbbeaKsaQIUE64mqm0LzQ5rXaK4XIvrtYagitjHUmFWQ2rNwT2mkq5Q+FqzWqODvF4h9PKdvZogbw6d37QX9HnT3YOmtQZi64NPKloqw1AKtvAPvn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87b2a58a4c0so301920239f.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 21:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752984125; x=1753588925;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tPzQYSICJN01ary/ZabqVrCHon1KF49j87hTNyjftFA=;
        b=SVbBK3vu+06T4fjc097WyfeP5D3/Rtp+j07ptiD6huByRkvgJKoMnxVZ0rqcey1FSV
         /j78X2mgdAIyq8ReGehtwS4MzPrFsH5eoizfk7o9tNFWxhaIXXDfyGfVdEFzyz7EWgBj
         MQgopwmpVDwnUWCMFYQDdBrCPEvhtZgsMbKp4o5iji5mlF8rWMvPVz7a0yG4JoZ2pgmT
         Xuk2+0ZgiFd8mbDSxoDNzTX61zhrsv2wOOWIFyAFfIlgZBcPIy9kygnhMPgH/P+CF/iR
         xpPmfOiw5cKOee/0jJPCwW3nj29F0a+C4rBTNSzrbIJWrp2tSL8UE8aUj4E3VcAt0LKv
         oJVA==
X-Gm-Message-State: AOJu0YyjG3DmTQ/dE7jq9DYs7KdcHMV1H1yN42Aljrnm12HdqtvD/CcQ
	LE1NaXkbNme5CwNuCSpja9nR1zn5WI6SjJriIUSh+rfkZuRNKIk4R6as1R7benIm0+n/pyxWcX7
	bF9vUbq5TUGQ1adyFXvHyq+Hzedww9E+lyngKWA44oAeXdWQUtMOIvw+Bo9w=
X-Google-Smtp-Source: AGHT+IHjFz/4s9GpsQ6H0hLI44bqOukVssIgFSxJF5yMfKUz8n1Skc5XRb3ylfswwwvxj2lGKQTIZr+UKmL8wreY8qqZ9NSb+9v5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cb:b0:3e2:90d9:2488 with SMTP id
 e9e14a558f8ab-3e290d925a4mr107160665ab.5.1752984125623; Sat, 19 Jul 2025
 21:02:05 -0700 (PDT)
Date: Sat, 19 Jul 2025 21:02:05 -0700
In-Reply-To: <67a21f26.050a0220.163cdc.0068.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687c6a3d.a70a0220.693ce.00a8.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+3201be560ebfa39bc6bd@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz set subsystems: net

