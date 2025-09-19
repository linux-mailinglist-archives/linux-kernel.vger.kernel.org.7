Return-Path: <linux-kernel+bounces-825347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A53B8BA1C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 01:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189FA1C20DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D30B2D3740;
	Fri, 19 Sep 2025 23:22:08 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C92F2C21D8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 23:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758324127; cv=none; b=nzaVLyHGESVrs0f98ElBGkUCHZ+2Ecz+HhgXMUNjDA2TTBA/TyeXunUmWJ5QupbHsk3WtxtzYlB8wwrqZdMCPcWcLwOV6tOXMWVtr6GHI6UGyzKQwk7hDdg6RHkQR8ayJ5fU0w3kyHRQlewvrZt5ZvZmCYVSxz9fHAZs/FN8wmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758324127; c=relaxed/simple;
	bh=xQBneLHGSaWhoWXgwO+HeLkkcwXMKlIllVytZGaj3HU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ANlyRqMMmMG691GbHXak7SmdVHMy3yk4aUnxeOCb4TnIrIkLDDQrIxk0K5N7Mbja1+smM+UHwm8MKOepgKgSIUNKJarsFmQOYUF6U/gH7DNDzcHFbWu/60FPhc68SrTBT4SPbpYyA5ynSddEpOOz8PqDCeaYBffyErECHZDi41c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8936161680bso286613439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758324125; x=1758928925;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQBneLHGSaWhoWXgwO+HeLkkcwXMKlIllVytZGaj3HU=;
        b=WD2a/D0y5JrXgwBLmukY2yRYE2K6hKf8hmGPyrClfrdN7XCaQrkjlW0XWiGXAfNQAU
         ySMcpXZxm0YviTviZGNVcojWIe5WCeFOhPE1hXdZ7sHeHPf4SiNlxz0JmqcQqTRipGTb
         9F5R+2C4GRTlvOSuSs0mNSw7gVXBMFYr3RhnaUmWrZvLG0TF+lsGF0x0VCeziKGxR2pI
         QFELZ6p/oS4qVf1IXDhfW0hyxcSene4O+2BbR4tAiaJy5gH0X29A6J2Db1X5+Jzm/rvk
         z2G3UlXz3D/MExN+RxDWcALKziduLhRQ4DETw2k9i+Z42k4l0elWLh6+af0Rk/BxL3ks
         rIcg==
X-Gm-Message-State: AOJu0YycMdKYN7jg87WAs9RrXgj/143/TZCAq4b7JbQmCQPV9zizhtSH
	4CuxE/C8w9aFVEuUW5U0/dyO47/z0t22OjlWDXxX0A0CpsBNGC+bLixtzkfvzagR5NwuwL4fXt4
	uKV6Bl+gVnlZA3JfKqscLEiW8lXNDmiCrX8FxTsJ+XZQiVeDOO7eRpj3zuIM=
X-Google-Smtp-Source: AGHT+IFjCmAJunWWqmcTqWksDbMIZnkyIwOt2knAZNZ6OJZf6GouQvYuMhPJwdN+jIW2B57cAWRbuvsJuUoIsNUZpp0Ow+B24JS5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:460e:b0:424:8653:8cd9 with SMTP id
 e9e14a558f8ab-42486538d87mr44734015ab.24.1758324125548; Fri, 19 Sep 2025
 16:22:05 -0700 (PDT)
Date: Fri, 19 Sep 2025 16:22:05 -0700
In-Reply-To: <68c21301.050a0220.3c6139.0031.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cde59d.050a0220.13cd81.000a.GAE@google.com>
Subject: Forwarded: WARNING in ext4_xattr_inode_update_ref
From: syzbot <syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in ext4_xattr_inode_update_ref
Author: eraykrdg1@gmail.com

#syz test

