Return-Path: <linux-kernel+bounces-884250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86157C2FBD4
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E919E3B7A69
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA01E3101A3;
	Tue,  4 Nov 2025 07:57:28 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E322230FF06
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762243048; cv=none; b=pDsV7aivTvif1AhHTGjyPROodvGnSmeLI0xdrDiAjNkONH8rQ9pL7bOnd62UUhki/Ypa+8UKAViQfFLtntAVS1rANvxpoiqWJ0bXWuLzMOrnyUZyf/s2BYUR0UwZWWLQECnNUjcJsKb3c/BLZxLm7ECill9T/2P4R/12qpa2wGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762243048; c=relaxed/simple;
	bh=XOWY8qWKb/rBeelAkoszPbGOnH9C6y4vlZvV21DGCVg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kPgmp7SWNtDTRqL1BpEefgqYFF9yx88GnZMHElpzoJrWbqPLA7W2lt+/oJXsf7YzBRAAhYpvTW7sjbpxa/xg7Ixg1384j4P6qG2+Jcklz0TuL5m2E4vFM4W/2wmQP/VxIlDFJc22vxfseAq2uKJC/57lxLlCcPeqKc7fU2OQOW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-948409cc397so213924939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 23:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762243046; x=1762847846;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XOWY8qWKb/rBeelAkoszPbGOnH9C6y4vlZvV21DGCVg=;
        b=lBDuWBjFbYmL217JMBknObo0ipMV/DvR+gQtUPEEZ9sKYzOszKHXQrM3OKIGRDlo92
         u/xYxCkKfBymCXp17ONvU5f5FqUOfovh89+ZUvTPuZ/yyXyRJ0SGTQ5e1LAmRMKRWf9I
         AEet8xZoTM+0JAR+knPdB8G6z5nOkfRfQv8B8jwXy7ConlJbxXba8QinHVnZTbZQbu5X
         +yIkxWDiK0MKHV/DnlgftRmM+2DfpmrQuwZEEFarfC62LBZ1qV0H1OXQ59NIoBZRhSKI
         nmHEqnDUglfbaePa/EA7ACRsHqS7hZgExLk8fdZvTpPVkClzfcMq1h34XSLvYkdmSOS2
         ktfw==
X-Gm-Message-State: AOJu0YzR+AZi8GayFcMONAX+YTgSZ3dpy/x3UaeS14t0ntUYJK7CujwK
	AtETWjvMh2ncZi7YnY6DDf2n8p2Af7IxA+Eht6Gc17ECPcWTWHh6qTF9uQlwm9Rcs5JR10UZCRE
	qmMfUHQhufjbU89zIj7k2/9mfUTmqtnMeKvwxay/ipa7LZkBLmXTq6T1fEro=
X-Google-Smtp-Source: AGHT+IGhasTEImQvNnTP1N8RTfV1bN+ZLhhz0ceOGVfy5/iaI5r4WqdxyoqHbXJujwu60LMcUISnpYo2++sBTPkoRa9cUVqkRNdy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1684:b0:940:da1e:552b with SMTP id
 ca18e2360f4ac-9485927e8eamr404067739f.2.1762243046120; Mon, 03 Nov 2025
 23:57:26 -0800 (PST)
Date: Mon, 03 Nov 2025 23:57:26 -0800
In-Reply-To: <680ae31e.050a0220.2c0118.0c72.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6909b1e6.050a0220.98a6.00a4.GAE@google.com>
Subject: Forwarded: kernel BUG in __filemap_add_folio
From: syzbot <syzbot+4d3cc33ef7a77041efa6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: kernel BUG in __filemap_add_folio
Author: dileepsankhla.ds@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
9dd1835ecda5

