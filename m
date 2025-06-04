Return-Path: <linux-kernel+bounces-673041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C94ACDB5A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 11:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94951626B2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 09:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D605F224AF2;
	Wed,  4 Jun 2025 09:46:53 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030314A1A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Jun 2025 09:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749030413; cv=none; b=jkeXJGfZ2lpNnNo+X9ppJLiQwZKGLvDET9i5tK+wMmhZ3+ZyETU4GMQ62Or4oQG6GJ2o+nmyNIV06REr5pipubDgfUB9IiNQ7fR5Bx0CfLZPRhX+ftzv+6xO+WvvzaZM5ccQoeIsejF8CScbjaW27ZEO6Qm3XXVDZQb0Obp8roc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749030413; c=relaxed/simple;
	bh=hVtHhuyE249aQIV4VbWHyBeFM2ZuATkK5EJGj0FPwys=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EvB8PpMn8xncmADsCkfSsGFy3LB9sca6EE8oCM7gGNHdw+jr5iG7brh5E/azrIeL5PYiMSa9va/oiczYliSPs6w0dy1vcR1C9wEBaorORbgm4Ih8yvM3BujrmWETiAgGOPt4IWVEbeQxVVYjgEnwIrjkKASIuaTFBuRSiWOJu3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ddbec45b07so8385285ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jun 2025 02:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749030411; x=1749635211;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVtHhuyE249aQIV4VbWHyBeFM2ZuATkK5EJGj0FPwys=;
        b=cug3KLkw8TpjFmEmSw9P1su7TZmp75xRKFno43iFAHA24MSpE/hrb5Sc5guQI4QMk1
         UzwkqZGZsAc/dYMAyw1qoj8G/F/7ySbf71h8gV6EOeSYAMcMeHFQDjdkwXC/4Cp2IGeL
         eALuIY5u7hOA9NG+SRLZ9jSJKqMqnTWomZ0F6Wq+ZWankxEd+QLIixNEkxMFwkNlnxgJ
         KvHvXAUWGZnqyfCKYJaf2FRFUwkFZxaxvLg6ZWpeqGoYAMaMUsHtGudeYA4ric9iryLy
         xfsp5cAbVieRBdk555fOOBhdjo2Nyyb+w7A0MFdzt0IKwjkmk58O5lREoY0ta3Eg4vI3
         Ubeg==
X-Gm-Message-State: AOJu0YzU39DfwLKmwYo0l+A3pSxlMqQSjtUQ1oGzkT3unu41hmLkXriH
	docd6YgunD2tjYlvcWgi+o08HyxOfkoJlOfmdVCDj6ZL5Yg3Hg1kM0Bc/oSitTce+5DnPbyw/cW
	KVn6IbQOPANB4v1KzX41yLu9yaehx4j3uwFvthdFpc07Q7Z/m+kTJdL31Lf4=
X-Google-Smtp-Source: AGHT+IE7AV3XrORmioMBS8PdK4EW1hYtPoT/Hy0qKWL9dpqx4NhZyiIwrOqWaHfBzbEYWdgMn0jgFc91lQyPcBhgHpIGTYQETF3y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc3:b0:3dd:babf:9b00 with SMTP id
 e9e14a558f8ab-3ddbecf1cd3mr23409085ab.1.1749030411056; Wed, 04 Jun 2025
 02:46:51 -0700 (PDT)
Date: Wed, 04 Jun 2025 02:46:51 -0700
In-Reply-To: <683eb35e.a00a0220.d8eae.0062.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6840160b.a00a0220.d8eae.0081.GAE@google.com>
Subject: Re: [syzbot] #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 5abc7438f1e9d62e91ad775cc83c9594c48d2282
From: syzbot <syzbot+630f6d40b3ccabc8e96e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 5abc7438f1e9d62e91ad775cc83c9594c48d2282
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 5abc7438f1e9d62e91ad775cc83c9594c48d2282

