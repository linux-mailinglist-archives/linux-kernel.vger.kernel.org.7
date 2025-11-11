Return-Path: <linux-kernel+bounces-896076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06785C4F96E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B62DA4F2BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB563314CE;
	Tue, 11 Nov 2025 19:18:58 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAD6331A73
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888737; cv=none; b=Uwv5YQduZ/wsSsP6Cmi7A6QWN+cyVe3rlmKgILKJk4Kd7+RikCCQUDvM2gitMVvbXwIl7SUNJ5AaDmCoEjWdYP8zGgejyurM3jSp7hNwPfUIo+dwa/opQyUnLRnAB8saOkmdzJT0nOqzAEwkyQuF59uzYI6UpIhVo2TAHP0OClk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888737; c=relaxed/simple;
	bh=VJ1zkAGscie6zKC6DDKsXnhL7LpCNlgFt60oYfQ01XI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PWPYUcMX4bvwAICYe15tSy5t9OQRILEXSC6BPsd1gV4b6g1tKi0+VRfImN/p5SbCTOJLNzuIvSsbBXUe+TjuIuCcplcrr9eTgBSbDJhQY3KewQf1POD+uBDupQEb5w/lZBZdHGkQnjQncX80W/kYZOxHueiPPF/a4fEceBzdh1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4331d49b5b3so1112195ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:18:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762888735; x=1763493535;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJ1zkAGscie6zKC6DDKsXnhL7LpCNlgFt60oYfQ01XI=;
        b=KYe+PgVu8Wp7MnmZsHJu+0GFs34Kg8n+KNR378HI8aKgGEeZc+kl+tgeTIg6X0LuF7
         YQqA0MOo/VO0ZQvMplnUeYkCeLaJ6FejeOfMObvLPH6Lt3lnZf7A95LfRmsN2Mfh2uaH
         hrk1rvvX40sZwR8QyRQ1eK3F3plfeeS+T435Ntx0AL1KIyAF5YbI4NodOpVNkE+rX035
         m1PewF2M/3ZyRF5ewc1Q/l86SiveFbLlOTEWpzRpDShNkOlGLR/TYTTmSIIVDlHde6Um
         uJW5P6ItrQY43HuVyLU/vmde8y5Me4NyBOjVxkd0bee2v0JdyJTs35XrsJwuvvYKI0Y4
         PFiw==
X-Gm-Message-State: AOJu0YyR6Ec0YUMvD5tEi2pCl8cnyKyS0A52Xh8byXcX82hMlgpKdx0o
	3m5nvdVS6ByL0psi4QeMeV8iasaBNIU2C+uQGe9DnbZvLNGb1hSZE9RO8VZja3ZCkS1icneMGvO
	hgQpxJ7tzC38t99mk6XSrYCZ3ez1gMCPYTcVsKPcNuEoA2VByZ6T+Vu4Ld+M=
X-Google-Smtp-Source: AGHT+IGaNf+mHf2WynMUjs47F3rAIHoYcVthVONOGD9PcjgILJKrDIf9gCC4cRK8Qh9X5KGJQBtiIQITSj1fn64bYYZMzym1uoPm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2293:b0:433:5736:968f with SMTP id
 e9e14a558f8ab-43473d1ba4fmr4380875ab.13.1762888735406; Tue, 11 Nov 2025
 11:18:55 -0800 (PST)
Date: Tue, 11 Nov 2025 11:18:55 -0800
In-Reply-To: <68f6a48f.050a0220.91a22.0453.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69138c1f.a70a0220.22f260.0148.GAE@google.com>
Subject: Forwarded: test KMSAN: uninit-value in cfg80211_classify8021d
From: syzbot <syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: test KMSAN: uninit-value in cfg80211_classify8021d
Author: vnranganath.20@gmail.com

#syz test

