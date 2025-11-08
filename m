Return-Path: <linux-kernel+bounces-891656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC88CC432B6
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 18:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A004188DB0D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 17:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A1823E34C;
	Sat,  8 Nov 2025 17:54:56 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5995B19F137
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762624495; cv=none; b=ny2fw0IvtQAB8ThROt0uLziYr9eok/exMPjqmMk8ZxqBvsV9yJLS6j6KdL3+TAEgiEQRzZE4nQJJfeQHj+/RJXVAm6DCzmWdNQey+hgatlRjSZY72Qimj+WF4ew0qHOG6V77idIcEZ8mnKU87bWuP07Fu2tsA/4u+YH0N+HNPRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762624495; c=relaxed/simple;
	bh=BRkGrLQrNSh8R9z5Glb4y5FFkCpIsIQK4TzAzzM+zTM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qPuylD8J1dFpHkKq47XrDkF2kWvPewwt/ZrU7hfb0/glJjyjB63rVwenY+a7Xg+l2XSiuZiaYYOpT8+/odZHasU1gh0tVgPXSBCUVCqX8SphOOJcB1e6xQam7E2lgM/8a760mGUgVVtlbFtNT6Otki3pDpZrNkZIDALmJyFOLMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-43300f41682so15909215ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 09:54:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762624493; x=1763229293;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRkGrLQrNSh8R9z5Glb4y5FFkCpIsIQK4TzAzzM+zTM=;
        b=Sixb4Gc4d4xA6Z+Shr1YtVXbvGzdEKQRxUYJvyVvr131olzOcIOlaxAJeXnzFOXYqk
         WiswnXyVkz2XkzLvdv0M86obv2hvG1GA8U1IZBK4IK+gw5n6HMlDDWO4I822KZhMAEPq
         1H7oTX8KhLQNYTwzCKJYJrkslBY/1Yq4Pl/BqtZa6rbPXky/CoB0UJoVgfHkE2MBgI1w
         9otrOdLZJzyaf+R3fKhNlxPz+qy/ypQPZ6smrAY/m99hyaj9W5Exnh4yErPB1DiS04B3
         sATdUBw+kwjR8IyS/3GOHtn1lJ1eWyTJaaUZWUXE51lGDzlNb28+GLJSKLhAGIg8b/dT
         U08A==
X-Gm-Message-State: AOJu0YyzjhVrP74La2tSaziyA8mY43ExtgOi/QKodRu5AJWJGscAKfPP
	EViRoxkUAc48QvXWzzEwX+tY2nj/uBY1QbJ2ayNBSHplQePeu0jUB2JDqmAWASuCtKZE0Nxfp2a
	JZJD0B1OPj9wmFWQJ1/Z4dxpx6Ip8tGeDby6vnYefeBqBabu6I4zozl9i1/g=
X-Google-Smtp-Source: AGHT+IHFciSEqtx3pFhZFP9qRqItuba4NBZtFB+FjsgiB/rX1wyOEfqTD+Lxw0ATrU4G9Nh5LyfiMIPy2a+UoRGtjBydMoPh4jiH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3713:b0:431:d8ce:fa1d with SMTP id
 e9e14a558f8ab-43367dfa274mr57538135ab.4.1762624493525; Sat, 08 Nov 2025
 09:54:53 -0800 (PST)
Date: Sat, 08 Nov 2025 09:54:53 -0800
In-Reply-To: <68ddc2f9.a00a0220.102ee.006d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690f83ed.a70a0220.22f260.0089.GAE@google.com>
Subject: Forwarded: test fix
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: test fix
Author: rpthibeault@gmail.com

#syz test

