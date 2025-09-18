Return-Path: <linux-kernel+bounces-822033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B42FB82E7D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E94317DC7C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D5A258ECC;
	Thu, 18 Sep 2025 04:49:36 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C16218580
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758170975; cv=none; b=s/mYawCDwUSyl0lymmOfVVdz2tw77TEOIiubXAdkaB/lqkMqev2OcEc0niLrnz6mZ40Q9rfk9RborkBJiwRChXjD2Ir7292OReVrlfYtBZYH5yNLVc2jpz6otdHb2mr0D2r9G6xwikzu3fFqvXQGKI9C0CrK6NNdY2Q6WXajNPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758170975; c=relaxed/simple;
	bh=uoo9bzN76YjjWaHl+/q269lKlZCz9XHJVttTIWhwvoE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d6VTBgugj7v4afPrE/ksqDgZX5zMOLh7TakbXp+YUP+8UQCxpijB65wDfPYlqVzzpc/9PuZCfyan6osiz0x9vGISbkCOnVbTfyZ+kzK+htL48mQeMNMNbWXMQYhnKlQFRyeN5mMdjd37HwLB98SX1WRfxL0Y+hi2rvZilw8Qc/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4240a41d2caso5835325ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758170972; x=1758775772;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uoo9bzN76YjjWaHl+/q269lKlZCz9XHJVttTIWhwvoE=;
        b=B1iGUcgQDNphf+x4eA2t2aT1gCQ2sYXP58wV0pPgxRScnyIAtuKoXpbsGSkAEXhQKq
         rStd2W53+nRvFv65Cu7n7d60nMpMQSPGgFSZ3Dh988VPzn0u8PF81/dyPxWrOxlJ+wJZ
         4x7D+1PtnTK/hT2JqhkeFdSB1jNT7IlKpN7cPxZpKXHOO6f6UmrRpcpZvrdKz615zO9R
         Byy66XfoCCkpI8oZlDu72Fgafd11vZhMJ6lo4Jc4vnMAx8r5hrVwcM/p29mxj0xpDcVZ
         fxlulLhoYHvQ7slpXTuwn+n5v4R4Pqkkfsn+EPnoi/6Qi/eCjIB0FnSdsR8uMpNJBiAY
         CxWw==
X-Gm-Message-State: AOJu0Yzm1AXWU2btl9SfmeZafQ4WyN8behC7VSsBwROt3h1JACHBxPM3
	Kno7x1bqe3uykxbHVOEa156PDzzLbKHwHr6el79unqILWDFxxheo5DDL8jBqL1M5FyD5UU9xERA
	Ll4KcNHR94xXl044WIZo4kMhbGIDrfnFp3MkhR4wuI7/4PnIoiIS33tfeCLI=
X-Google-Smtp-Source: AGHT+IFQ9AbzWsHuArqVpSmj11gxd7XMsMB6klhuQDy9EQQ4AK487dhKsbfMymD8x7Ll+cMburdIodZRY9NtVwIrRJs1Ak0rEKO9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda5:0:b0:424:cf7:7d04 with SMTP id
 e9e14a558f8ab-4241a4cfcf6mr61804355ab.4.1758170972096; Wed, 17 Sep 2025
 21:49:32 -0700 (PDT)
Date: Wed, 17 Sep 2025 21:49:32 -0700
In-Reply-To: <68c21301.050a0220.3c6139.0031.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cb8f5c.050a0220.2ff435.05a4.GAE@google.com>
Subject: Forwarded: WARNING in ext4_xattr_inode_update_ref
From: syzbot <syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in ext4_xattr_inode_update_ref
Author: albinbabuvarghese20@gmail.com

#syz test

