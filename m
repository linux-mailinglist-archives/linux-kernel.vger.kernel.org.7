Return-Path: <linux-kernel+bounces-764700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0C1B2262A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8AC3B81E7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1282EE5F4;
	Tue, 12 Aug 2025 11:53:11 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F92A248F6A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754999591; cv=none; b=mSmqNeNAm3U5enK5I1SNiKxH9XW4Ln0WPFSGyM9/L/AiEXsQ9seFCeY06W/6xSBi9P5O2wHqgy+FLdcQR7SoKGqbXcbG8+W01L7Pu9n8KZFyncgh4yNLu0msb7qNY95POaQApL13/4Zqu7P7dvU/j8+Y82ZXVR7SGYyBzIAQNZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754999591; c=relaxed/simple;
	bh=joC4jihkaES7PJZp425YJBTOpFFfmNeVymxE+lkSVO8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RJMXRCCwLdKHaJ38mlnYPrgcRkNjsFqOPA2lO0ANuHeBYJI3jqQcIpCWTP/fD2aZQ6Cx2busl7hlpNS2XQeddy6p7SDkE1AuETm3bzbmXRKiTfXZ9lftbcKzqX4I9Ld2mw6DzoFFtkVFnUVAswtV//jTp8L/iLai/Y9yW+OfR+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8817ecc1b33so1240648039f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 04:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754999589; x=1755604389;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=joC4jihkaES7PJZp425YJBTOpFFfmNeVymxE+lkSVO8=;
        b=CKpLltTgHwKSRV2IuJFGTROTAn66T3mKE31Ti7MaOEHJpPCiJKpComUwE6+9lA77kk
         Ey0awrRQ9XzwSMvrEfG4RncJjyn3MT+Lofd+ErbIYDWl+UMu0m8qsDMvJVGBXgf4sN4R
         jmmOG2pGZONeQAu6Ig4WFMcb3TtXHleB1Hcjf9fMF+bYPqEaMlRKnalQyxzxUhaZGV9M
         gebdFWI2R+ij6e7BeWBNqEKFGqpEMrHSLt7bvDn7eld4Jvh2EPcgC/1QAw9REieMBm80
         08Mn/tgnK55WqzkcnZ/K1iLUTnVuyS4KZV15ZDmZVy47wsuZzVV/x8xz0GNajtCThv2W
         0oSA==
X-Gm-Message-State: AOJu0Yw4goDNd1bTlrrwHAOGoBZXB8PGsnb067YQGUI6SAbhDp7C/aD5
	33d8hQIhQR1sWXBaG7wkP6h9H7iGRCOOeKZolMEyhFLNIsmBqfh+kZ72IjEXdazpi9BOLVVjWDM
	splaLPO6dT+8KjukTdLPFQbfhcDTKsvlTsSxPfw5qQdhQSaDHYhOxZ2PMA/A=
X-Google-Smtp-Source: AGHT+IHL9/DDblEaq1OXkzHZh6lu3nH8LUDnvynoN3KuUmX3Llt0EzVoBymrl3vGRIhxsbocUluWURCbmDIwrLAKRZKRS6zJTk3q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:7401:b0:881:85cd:d08e with SMTP id
 ca18e2360f4ac-8841be2bfadmr585610739f.3.1754999589273; Tue, 12 Aug 2025
 04:53:09 -0700 (PDT)
Date: Tue, 12 Aug 2025 04:53:09 -0700
In-Reply-To: <689a3d93.050a0220.7f033.0100.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689b2b25.050a0220.7f033.0121.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 53e760d8949895390e256e723e7ee46618310361
From: syzbot <syzbot+30754ca335e6fb7e3092@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 53e760d8949895390e256e723e7ee46618310361
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 53e760d8949895390e256e723e7ee46618310361

