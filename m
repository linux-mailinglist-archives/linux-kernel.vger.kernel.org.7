Return-Path: <linux-kernel+bounces-893720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0287FC481F9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A329E348749
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E053271EB;
	Mon, 10 Nov 2025 16:45:36 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93422EA755
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762793136; cv=none; b=g0eAyTw8EGEdUHQ8j8tR7fK8SVeZpm7/4SVw5bwTM3kDT/k0ro6ubJP8HQaMGHK2U/RmbRs8Ed+GreDPLDB53A7+38HcSskp/2bylvmZBc/P7LzNfJL+uPPVfeG+kBzZ0qlN2RNgcgguGQQUP3zxnceyxpHjhiUoxCU+asDdXLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762793136; c=relaxed/simple;
	bh=BjiDhxswYYNUyE28zJ/AWR1tX1LTmsGEqwOu9cfXM8Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NvjDBgzNSZG0BYjH+wZJ7MlEmaCBvFHlnUkIDp+DlIZ0nIZTco47WLfheUfIQjdNuNtZceIvGH5swwmNvuOBO+aFm1JoPLdd6iJD2iEFuhzpHG0imqSbYsBwd9rdEEr2mXH4UUk6Z303y7c6ePmA8OyigNOetX7QmQ8EHT3bywk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-433795a17c1so30096715ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762793133; x=1763397933;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BjiDhxswYYNUyE28zJ/AWR1tX1LTmsGEqwOu9cfXM8Y=;
        b=JYpIYDtJy1GLZUnNz223Q19weX8JVdgr5a+bgZXPX7BeblsY4OydDyuSpyCZ13zF4y
         t/xx1iAkCwIPKuSMKojEkKDPmPUw3VLG0qguuXUQtpa2I6itVfhL95Gvd2wUfdVsOzN1
         gkTj9vEJ2a5yjnnb9lEHidIZ7Dp9jv4itgyo/pwuoH0ZL/lwEYLn3UBQ+Ekz6u2jjxlv
         X9RXxpRPhOA/X1/sM9dGg9Qi5ZNVJLNexm4f+FprjR1VvdZMRhFq1bbDA5NK64ynNULn
         p42c8sgfHIWjApzGN1NR1vG8h3f2ii3cujvFjKbbr0Vo7Dl/gvkH4t2VmAyeM57tY0Wj
         V/DQ==
X-Gm-Message-State: AOJu0YzxmXqoBaq1yYWaH3lezTS07bRi5yVnAcrKdf/LV6D4esO0S2a6
	DLBJ6LmgoXd+qFbbOv+jSNy/RWI28EePhzfrLzpyr7KnClw6Lc7FNjn3HJR3T4ykQc6tY8unCIi
	mFhHVxp5RlnNZKq8ksTDIs3cOe58HXJgGDtvpZxuHcNgB0TkRgpIKTH5a258=
X-Google-Smtp-Source: AGHT+IGauh7rvlc0ArAzvWuPipK43MvCZFG4aklqijZBqUWNc8BaTJZj/oHpX9POusxUVQra3P9n4ETtyfz3VlmHImf8JbYLL7/R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:260a:b0:433:5b75:64d6 with SMTP id
 e9e14a558f8ab-43367e70fc7mr116129555ab.28.1762793133664; Mon, 10 Nov 2025
 08:45:33 -0800 (PST)
Date: Mon, 10 Nov 2025 08:45:33 -0800
In-Reply-To: <6903e832.050a0220.3344a1.044e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691216ad.a70a0220.22f260.00f8.GAE@google.com>
Subject: Forwarded: Add checks for key_len in indx_find
From: syzbot <syzbot+4d8e30dbafb5c1260479@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Add checks for key_len in indx_find
Author: kshitijvparanjape@gmail.com

#syz test

