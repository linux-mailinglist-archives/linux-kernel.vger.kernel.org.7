Return-Path: <linux-kernel+bounces-849125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B35BCF417
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 13:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68AB84E26C7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342402652B0;
	Sat, 11 Oct 2025 11:10:25 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79A72A1B2
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760181024; cv=none; b=r5JM9bpM5KIM9u08arnNZltb9FskVhNdw+q16C12bhTwSx3YxHiqG9s4sYNQhhdLeMgSR1bWzmbcwteb+zAeCA8+xjqF212Mynfj7xcT1mFXdav5hV6v+4CBcM99twZPJIZ9+798zfZKiYdXC/eQWEBrCySoo0YecPONGZigvmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760181024; c=relaxed/simple;
	bh=XOWY8qWKb/rBeelAkoszPbGOnH9C6y4vlZvV21DGCVg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZiNGOSUwit9xuV+A7z9HbdT9ASjX/uzW2IHkv1ESwqiNvHAemHiBmz6Kit4wg0eBqGA6TI+7F74uqBLgn+JlXJ4Jn/GGESid3oMNY7rQaxyu+gsy91cbeztk6BKNbiBOIGcMH258QnknPqWlWSA9xvCf/GPcYQukWEXjDzyapsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42955823202so110110785ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 04:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760181019; x=1760785819;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XOWY8qWKb/rBeelAkoszPbGOnH9C6y4vlZvV21DGCVg=;
        b=b7KWsP5hBXLTQoQg6my7VWdsMQzKiVjgcgu+mA8YIzn5nXj+V7j/LDUQtQ6iiVeMZ4
         G7CkSc1ax25QUKF2rzIf0++F2uPhA7b7FH6/V+dTv9ZBrSAblJz1Fvv70KBz1398djSD
         J+mLx58gYOK9M9mPjz8ieNRgyW5mR+22XmCN54FT3q1EIXZ45SKyQ7CmGU2lrK+0J0Ok
         l08zvKaPmt+EUBru0WT3nY0T8mbw36ACoVeYxxyIY2PzRr9p+ipikEx04ugDI3U/aS+L
         b8bMpNHdX13UITASl37cWmAnKUWYsVbNSH6w+Y/ev+zVKDpdYBnO3gvIl7DcPxkG/msT
         ocMA==
X-Gm-Message-State: AOJu0Yzfo9iS18SCnyzoTXh7+99ale6+Wk+EX8S3Bq1yMskquoLfkHEy
	r8dSIGTNolenBfTsvXCO30IvYpr6TRxUnxVYzj265mbLEOoAOKvfKayYJxiPIF24lpJS7FCr6TJ
	ANPSdWeSi93zx5Ij7EJNpK0RpRKfjam/yulylfMayyVsWdhTyPkAUR0CKslI=
X-Google-Smtp-Source: AGHT+IEAc2lpJUpnzZGpaZmSg9oNnfMrur7IMqehzQt6YaW0Z/qN8CZ/gkHov2BBXDFJEWnrMr2Lo/nFtrmJJSkM/CqwosT7vOIQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a68:b0:42f:86a1:b902 with SMTP id
 e9e14a558f8ab-42f873dd768mr169562935ab.2.1760181018826; Sat, 11 Oct 2025
 04:10:18 -0700 (PDT)
Date: Sat, 11 Oct 2025 04:10:18 -0700
In-Reply-To: <680ae31e.050a0220.2c0118.0c72.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ea3b1a.a70a0220.b3ac9.0008.GAE@google.com>
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

