Return-Path: <linux-kernel+bounces-738262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDEFB0B67D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83491173746
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820DF21884A;
	Sun, 20 Jul 2025 14:42:23 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44293C463
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753022543; cv=none; b=kTSsgMsacbQttcC+Pxe6Op8n6xXIRylSmY6wf/u5Xz0IK4blOeeeevkEcnuZfCsR1skHkEzMDh/Mcz251JBnOyLTeRvVodbdWyPiBkfNtvv0PTxJuaf5lh4VEKvc/FAw3XKMrBbEaE3TriD6opMY15o9vCvZC/u0OqdN5kZWLKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753022543; c=relaxed/simple;
	bh=E91f+N7/iHA8kXw7SfG5+zqx49309Choh5oFQqDyc1g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UKTpM5eSzE/QPDPFmd4YVoX4lZ0L04ZVQmI5UXBwO11nUt77VGsx/+e+fSRldvdM4QzF7A4hyzKH0sQDOqniAoj3wVTT08yJF9Y9QCuvAmPZ3WXLzemXZHeS2DmGteBpW4dtJzCEmGbZw+eQCxmOjwwbQIKjDLdNEWJ1+fVO3AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e2a16160adso27446085ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 07:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753022541; x=1753627341;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTqe+KHA+99J4Dn+ByqK+2DHn0R7rINO0ylipLZhOQI=;
        b=rYR+Bv425C67cegbjvTGtSV8La4rFpv6Itd5HXU0pVxZw5UYFCbCEZsmASYpOdUXUU
         50q5Kjkr+2Kz4+JM+1CRwpR33iiw3SFLl50yAE6xkWPLB9cBMeO7XmoDNjlMBkd7wyrv
         2inaHv3qa6ZH1/qWTuuQ65LUW9TtjawyVmYSXg1iZIhBHqY9ty7s8JJtwK4xZ0D8+7a+
         s9nv2vzChYHZxT9ZyflIdf+mhp2IYq8DcKTpnq/MPMfVNV8CghspiV3d3ZIhhMAfY9S2
         Blr36yLT5MnqeeRXUPGDSuwBwWqRXu6ZgN/by1AuA//zQNobkcz/jRVNKK8gscZazI8s
         kRUg==
X-Gm-Message-State: AOJu0YzfMXCFFenP1TIJAFHbgUk5BVyKYXIVLeP349DFsb8Go6nC6sNY
	OWEYQE8HPKa6V6UBa784nJ5KXjYaxwYuXeueKPksewmIh7VDkJwjZK6gWk6HkVXHq2dLlqpgwpD
	avaG+STXzjLWIQ3J0QcFcao3bOXPGLUQpFCNzHSKwGjzrWWEaq2lDOB0dn0g=
X-Google-Smtp-Source: AGHT+IGab8QfC+i2V/xf4ErttWdhWSiboVDr1VlFPd3QACN2RYy5950dMmRPDUNHre2qPa1bIM+ljPMHzyMEquuGqFEnIydNN59L
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1808:b0:3e2:9b17:754e with SMTP id
 e9e14a558f8ab-3e29b177636mr83061115ab.11.1753022540934; Sun, 20 Jul 2025
 07:42:20 -0700 (PDT)
Date: Sun, 20 Jul 2025 07:42:20 -0700
In-Reply-To: <67e23c28.050a0220.a7ebc.0038.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687d004c.a70a0220.693ce.00c8.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+6f4fcb1aecbaa2aa6825@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix:  bcachefs: Fix possible console lock involved deadlock

