Return-Path: <linux-kernel+bounces-892124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (unknown [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27555C4464A
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 20:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AC63AB487
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 19:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D88242D98;
	Sun,  9 Nov 2025 19:38:36 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12712367DF
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762717116; cv=none; b=OA4Po9vIB87KD/C8NUAXvU7LGV1OnL7wDzpX/i9ycJJDUZXKz6VQ7wVSMPxqom8MdoXWyrhRCfnyVk/6EPkv3D8jZvjRdILBqHGgSO6/x9pYIOO+HAszgA9GomA69OV5jOTW2L1pdBG/5EBC1X31FID9T/aF0/xoDkc1GY2c1kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762717116; c=relaxed/simple;
	bh=L6ptIwyzAZi/q4JHq/o9JXyIBQFNvCVX29puu3IoiC8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Sk90bObFQXm2TF1bq6a3ivIi0lrSA74DMWftHq7ehuOgjXSGqi7p1HRxkUINC1LGI4i/CIpQ6LB/x1UL27byzGNZTWl7EJdExWZQXgHQAzDxN+Tb80jq9lGoKAd+rWxDthlF2Hwn0NZHMKxYzQH0HFd/4UJ2Xvr8pnK7t9qhvlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43373024b5eso8869135ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 11:38:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762717113; x=1763321913;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6ptIwyzAZi/q4JHq/o9JXyIBQFNvCVX29puu3IoiC8=;
        b=EILJ6Yhp9IkEhot/3anduLCwrsSdxp0ZKeoRhPc7Qi63soGgxy1akFY93kaaisR7Hj
         Spax6y9zTQ4xyvxbBXkMYmjGNfR4yI78dibzCE7mSfTixtI1UOdTIh0d4nKjFaKPoSGH
         glqyR9SQAv6dzPUEQMXubTYZnqLehgrp/qnm7JW8olA/80R8t9dN1yqu7rO8J45xvmnT
         8Ip3z2UPnqxaSEYWXN8Gn2LU2/bUUAYAyCq5WMhJODZyrurGrM4Wek3JH13CsaViLq2G
         Lv2f+oumym7qLlD0Wm7KA+OaSCpY2yXR6F/eewnPNWdirHPPcpAbTxALTM4JeFCduR2s
         t80A==
X-Gm-Message-State: AOJu0YzEWJdKsCfIe37f+/uGhgN6AE6IdyQZdWcxVyGCX5qQJWiAL74P
	RaBGEprOEmfLQv7/lqwzLaOGCA5qu+z+uinwTg722/c/fmTVtBPUHuTcnB7NZcqQvKLBv/bppju
	RNLLpm3lIGjRoz2N397eymk+dBkEgj+JW09SqVWFGYFsOpFdhL2i4OiCRTXo=
X-Google-Smtp-Source: AGHT+IH6D/WmMgKLQWGh21PvK8j+yZ+hzHP1XkehFwHlwwZKlbv4yHfxf14dKm4ghaxlISYBMOsabDv5fmz8QQmbaMgEARFbGPVX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c265:0:b0:433:7b4f:f8bb with SMTP id
 e9e14a558f8ab-4337b5026e1mr29752905ab.20.1762717113785; Sun, 09 Nov 2025
 11:38:33 -0800 (PST)
Date: Sun, 09 Nov 2025 11:38:33 -0800
In-Reply-To: <68f66418.050a0220.91a22.044d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6910edb9.a70a0220.22f260.00c2.GAE@google.com>
Subject: Forwarded: kernel BUG in ipgre_header (3)
From: syzbot <syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: kernel BUG in ipgre_header (3)
Author: zlatistiv@gmail.com

#syz test

