Return-Path: <linux-kernel+bounces-851725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B0CBD7249
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CAA62350401
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874703074AA;
	Tue, 14 Oct 2025 03:09:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82DF1E9B12
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411345; cv=none; b=BGdbFC0EqZpunwhx1rTty7bpMb8XMknCHO5m/WpjQzg4AmCnarH+C032xCDoqiYddI8/u6m06SOy1IElAMqziAAbeUEXTbLMg19IjK3oMYl373ZFB1GlakffzXdad1I4OzFuTjGdC5UJM+Hu/8yLz31Ot5qSJSJ4VfnJ/uHhTNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411345; c=relaxed/simple;
	bh=zfUeEjTDs7VxyffUJrHHCBJZwAjZ9gB4gJZACcyd0VY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Tb2tq8eg+aDXdZLb8IpcSq3QrQgPIdf7YngnvSprGxvofw7+E1lMBdw8NnSe+9CjYGpjMe69Mn8/PFsBJXxnFEJnqSucpJla6unOGhlisgfMg8+iIXZD2o6fE0Z8qKppi16ACYSwT4BA9sWOy/oAqcZq0QCO6w4xOfCtY7N3f6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42f8824b65fso295262975ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760411343; x=1761016143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u5ZcN+WGhPDkvmZ0gYFv7Iw2+MSk+f4EUl5Lx0btTtw=;
        b=iQI3FTNE9cXSJ1lO4MwGSyifvhzuoGTdU0QoA/NRS9jHLkceSY7yRBnN3QV7bKu5fs
         C7vGiXV8Em8PqBT8QH/2NRj5prYW+8JISCTrYQBevtnYt7NZ39SrWBYj9+GEGwGb/r5/
         t1iOJZvDoQ5Eiyzyz9Xd6CE/eOSO0/qyFVAqWuJT6n7CJgSV0wbf9AKh2J1dRWsoTTg7
         KTda/gX7kYGIBH9xUVNrdXLUL6PF14xDS3VSOPy5j1e76DiilejPem58FekqdkPR1LBK
         ZR98mIXq/D1W6NGaWys6UnwgjlvIfsun55JsV+Affo9H1BMtRgYkTn4qdiNT2Rr9Bksg
         /nQg==
X-Forwarded-Encrypted: i=1; AJvYcCUc9FGnznwcSoNNlO2NyxtLgDzDLMO/0/nekvTAi0++mn72JX7vag6zwSgu3Q4W4EtADw2GuytDIMxXbA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdMQw4HRIO/cP7p4Ca3zMobzizALDyobfxSbZe0Ce+zPiM9rUD
	NWOSCiqsDJj+LWb6DjJPu4TEYpszvSuEMkRncoLnhyKJjdpvwK50JaPmwudJx+wj6dS+uUffEzS
	lAh/yHARspCvElQ7FohO6eVZep66q6U8guu4ER++1CBOTIBN/i4CzRfA9l88=
X-Google-Smtp-Source: AGHT+IHHE6ozWGbmyeAJJG6Yl5WCxvrYFq9vF/pCB04QzDiUme4p/CxfExj5rC8YKOEx2GO9rwxaeg/ih6OBUe0gPCkxhmuKs9E3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3497:b0:430:9f96:23ce with SMTP id
 e9e14a558f8ab-4309f96255amr27137425ab.8.1760411342838; Mon, 13 Oct 2025
 20:09:02 -0700 (PDT)
Date: Mon, 13 Oct 2025 20:09:02 -0700
In-Reply-To: <20251014003959.13323-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68edbece.050a0220.91a22.01f5.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in hugetlb_vma_assert_locked
From: syzbot <syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Tested-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com

Tested on:

commit:         52ba7632 Add linux-next specific files for 20251013
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=143e7892580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=271da434ef3da10
dashboard link: https://syzkaller.appspot.com/bug?extid=f26d7c75c26ec19790e7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16a2467c580000

Note: testing is done by a robot and is best-effort only.

