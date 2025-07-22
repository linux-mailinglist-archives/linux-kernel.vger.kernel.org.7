Return-Path: <linux-kernel+bounces-741381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C156BB0E36B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C597A6B01
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B41280338;
	Tue, 22 Jul 2025 18:23:46 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DA6277814
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208626; cv=none; b=F25mWUWEdpg8WR18zaNQR4glwqTouGJsOZl88R4DDW/xMoyEPzgugNelyzcd02t3CCA5GcFuBt19LxI7V5hMclBgKQkE2f2BKVbR1MSG+xo9R1bbeJwXDa99ddekWfsQ4lxYuLbedTyNkdVpnY45wBduHQnctO/x9RmGAGHMW/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208626; c=relaxed/simple;
	bh=oMdykAUw/PNnCAqxFssXe9AdIblfs5RDZadj6TVf0c0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Tx+TBovw14vsubrF6Cz8r3aeXgF4SY6Q4upYXpwE2GAMYvzJeWQjksKaRyu1J0EF10vZkhXkksfqcLWi3G4IgcL+HBO3HB9r5hR41L1JOuwh1maCa+hpz0OsXuBOzxwToqViedhdosWljC261p3yQcONbj1qSOrxouBxnkVveWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87c24b196cbso353020539f.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753208624; x=1753813424;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTqe+KHA+99J4Dn+ByqK+2DHn0R7rINO0ylipLZhOQI=;
        b=mZVMD45sO0Lwk3S3jDL+gir1VEWFazGpmgR/KzuH2J1ya8VOgQn3e9S6D/6eHl5cuW
         W0qRvDRKckt5mL95kIMdOvjvS6aluYyUHe9+zozbEr3QxHdgYzsp6cNmDUM/9AdH74IG
         lsBo2PlHSxQUCCXAZssvmyCzoY8Rewm5Zlr7Wgk6JbHNKbZF7reI2vaui6DW2h6RD2PG
         iIcSkd5Vqn1XOe+HXJHIG6xo+V9HU9K0jNYqnjiBCPIr8sIG89aNpSFA5AvkJi6B+BTl
         aFiPdohParXS9JfyewnIavY180HW9u5dX/iulicbv0hL5r2Ai1FLDojhIxSg8ILEH6Y+
         PIpA==
X-Gm-Message-State: AOJu0Yx6kuvBA0AtgKq8Mu6NH4kggQxCxCMOxs32wkNtTuRIrVUoypJ9
	1vDCq1+6cx6ZTeGc5u07LjMySoasYshrcBpoZWYASx0pWJ7X9KJnmAsqs5wuVn4zaLA3cTDsb1H
	vseddjLExTfjAIlWGn+N7z8vQQ7ZKReA11oaOFPDsZ3hIfesYDNM4XdteqMs=
X-Google-Smtp-Source: AGHT+IGgs7Vp5oeLBZR35v8MJA2eScWURzQn/E8VYIsLSmDtY1uzC6glGO1AKyS9ADDejqUr36S0tj3A/3klcwWZDL9AZdLwb8j5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:358f:b0:87c:d3b:a358 with SMTP id
 ca18e2360f4ac-87c64fdc182mr18601539f.8.1753208623954; Tue, 22 Jul 2025
 11:23:43 -0700 (PDT)
Date: Tue, 22 Jul 2025 11:23:43 -0700
In-Reply-To: <678db48f.050a0220.303755.0065.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687fd72f.a70a0220.693ce.0109.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+8f9c94814c0235823861@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Fix possible console lock involved deadlock

