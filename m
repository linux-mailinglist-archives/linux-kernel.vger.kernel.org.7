Return-Path: <linux-kernel+bounces-755749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BE7B1AB49
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 01:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F6C3B217E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF73023A562;
	Mon,  4 Aug 2025 23:12:42 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E2A1F416B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 23:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754349162; cv=none; b=nNylwpaopjZ2cJgDZNngZj+YUDoDnL+E4t7D23c8bXkv7GMq7o22KCq0uV8v5wEwZxRh37S9nCLHYelNILXjyws9PrPg957XqP7peSZFzjXnqF16IrL2WbHbtl+W0z960clc/5C0DOm/mIVIoDJNr05FFShFNIboZJhUHwEkfkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754349162; c=relaxed/simple;
	bh=fiF9kDPe0p2kKbbDr7+vDFCiUkTueA4rr7jM/Jmk58g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Es/CsBd/MUJ/lF+EicQOEiITH25JpdpAxdBPv0lMj3gL3F1O+wMBVPWoKqcXfNP8qmC24qFJNHje1matFU3K0mZykwUxQ10LPoGKdxhTC1bIfB9CoVIx1xGmKYY2tdS3cOygQxFOQ1rwbKeySw2TM3ampJ/prf3wl/vdXYQc8Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e3f6ae4d0fso74123435ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 16:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754349160; x=1754953960;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JN6l6xSAuBQaBMhhfF0JzN0Kn9m8fbaz5lRgwPjV4KA=;
        b=LtYt6k15YFCfPoxzl8vHyyVZKUfhO+LpEsF3RWGDj7P0GOyR7AGISU4up6ZRdLYLVD
         NZFTXmZiwM61NRnHe2GxmqnfwXzYiwgHsV/aKaWEnQOTCyKU0Hq5PS31uh4hDDPiDcqG
         kD05DphOT/1asFIetCvlX3cKKukpQ3T+aF8ho4KjlaUMAFcdsrbCE1cWckUrYOn50ZWV
         KptQyBeKUbCqYu9N8UdnewkajtHHqM369z+k2+yC0P1pOeuuYd+YSCv856UuU3xE7u7H
         YeHWzjpayAGtwpv6cOBPrbR/9iDaZEapgzBWF7m5zZuNhSuB1BMWzLGzsvlhnAC1ky3b
         2sow==
X-Gm-Message-State: AOJu0YzFcPg+OYE8w60pnCxrNVRG6oBxAaLWJ1T/k7d7juEvdpXWkC8O
	stN0E474WngsGQjSL8ouXJ5zL2qVqp4mVjqNk9MJ75xyS1cht2CvcxM5GEJoutnEzE4yZOjQ2wC
	nhj6F2O+vk/RziotH5BDv3z3nIlNs+iijjnNRkx55nV5vDRUTzgiCxfXyTVk=
X-Google-Smtp-Source: AGHT+IFLftZmC+2SaPPciLWveu+LqTP9rw6BWgEhv8ysxj0QQ3RQvQMKNJl5x9Kz/j+wNHlXx4UIhHj+UwWqlIQQE9X39vxcilS7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:440d:20b0:3e3:d822:f180 with SMTP id
 e9e14a558f8ab-3e51024e94bmr19038515ab.0.1754349160106; Mon, 04 Aug 2025
 16:12:40 -0700 (PDT)
Date: Mon, 04 Aug 2025 16:12:40 -0700
In-Reply-To: <66f9024f.050a0220.aab67.0010.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68913e68.050a0220.7f033.0015.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+7836a68852a10ec3d790@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Don't lock inode around page_symlink

