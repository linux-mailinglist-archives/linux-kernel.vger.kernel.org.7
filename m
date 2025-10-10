Return-Path: <linux-kernel+bounces-847861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DCBBCBE78
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE7F1A62BD4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A582737F9;
	Fri, 10 Oct 2025 07:24:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A72627144E
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760081046; cv=none; b=NZcjkocupUYAJ5nLtzgZWiBnj+dcpheVuaxMfxtPH2Qph8BE6PwZHMZAKSSKKB+pN7+2Zt7coEx5lKFIVZZET1niIu98hj7E9Yh6MKKVFCn3leBQM0VF7X2kckCHUd251QOGZsZn68bW4aCi8sO0R8A9D00dTL+lEYKFkUeNelU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760081046; c=relaxed/simple;
	bh=Jg+d4M7SD0tg1BCcESORZKIiOOrCQxdG8BTeosz9N8g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CMFr9LQxGaVCR2fgmbNbSZb61/Joxz9aoTqgPVSE0HkPXL1cdRQ8qfaRE2K7qNX16mC1O4omsgRA/M0fmn1mJfEVh3pLnoWafe/63H6b8fEroFYA/yYSLgSeqncryGlBCnvtK0sYSuGu3fkAi8bT4qwd+PP5YAgywhJ/8S759Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-937e5f9ea74so429155839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760081044; x=1760685844;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85c0lO31mJmxX7OG2HQ6romLReQO9OCVh5cFYAjQiA4=;
        b=nLMmPuF3elRO8U76YQc4ZKBOBTKsAF6fGIpdGHhjmw74ZkUQLTINXJZwsbpsuVDy68
         TrK0iB0nHvlPwKPyAu9qO1mF3ZpgJZFlDDZODgsL6DvPCB5mfEKX5i2uFALvhB+0NVh3
         fYw4HOWAXGIpgdT0VXF48XJ2o/3DN2pZa/HRWsn2LsD2P7YUkbb/Dmc3w9IxL91qg0cj
         +UE9aosRDPtSTCVO+xZPhFim68GDcJ6QttXtNipqZh/TEwRQ6ivcNtoJRnkcsA/9Q6dN
         ottuC4xuAGIv/DhtHfiihEpjkO7XFWIl+jtHRnC0FV3lkxfYI5jrMlaDs4ckzlvdHDD3
         0eug==
X-Forwarded-Encrypted: i=1; AJvYcCXVGMRZRPdLSD7/8scXDpP74b/IN1nteRUmPPWrsMzjxK6VRkeb/CT/x1MXw8YTyAsPGTetBh8gYG6Cod4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNZTTWoMqoBOEaf6t04116VzqdK36ARDiAxNeWCC3ri95FdJ4e
	x3iJ1ZEY2yhe0LSxxYoHkc4WfTrtR9U2qkc87pK1twnNNMQffDJPUnbRDKzIZorLnKbHvuFgJbP
	DdteKr5NGKtsWJz06L+JIxlSLm2q9BscK/59lDW+imJwVLZ3LmFjxSDrZjrg=
X-Google-Smtp-Source: AGHT+IH9YdmnB2MPeJu4hJxqiBrxo57sGfjXN0vwjr7W+/+/+p6zwPPzsFWiRrpzBzWe7uajTaaIEEhiQD3ZQbKbM5mUjQccgD7r
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1514:b0:8fc:2095:302b with SMTP id
 ca18e2360f4ac-93bd191f136mr1284776739f.16.1760081044336; Fri, 10 Oct 2025
 00:24:04 -0700 (PDT)
Date: Fri, 10 Oct 2025 00:24:04 -0700
In-Reply-To: <20251010033310.8501-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e8b494.050a0220.1186a4.0007.GAE@google.com>
Subject: Re: [syzbot] [net?] [virt?] BUG: sleeping function called from
 invalid context in __set_page_owner
From: syzbot <syzbot+665739f456b28f32b23d@syzkaller.appspotmail.com>
To: ast@kernel.org, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+665739f456b28f32b23d@syzkaller.appspotmail.com
Tested-by: syzbot+665739f456b28f32b23d@syzkaller.appspotmail.com

Tested on:

commit:         5472d60c Merge tag 'trace-v6.18-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=178251e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db9c80a8900dca57
dashboard link: https://syzkaller.appspot.com/bug?extid=665739f456b28f32b23d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=120851e2580000

Note: testing is done by a robot and is best-effort only.

