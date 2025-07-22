Return-Path: <linux-kernel+bounces-741378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B241FB0E365
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F24177A456E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50E227FD64;
	Tue, 22 Jul 2025 18:22:51 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7B726A0FD
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208571; cv=none; b=kdZRcfqavlJfEqad8kBdo/Enh66QyL1HrG99eCyeIt/aRuxusXFnITzrhB4e2XeL7GdReGwsccidat1sGdGXlI3FIZDiT4VKvZiCsVNTi+0wuzE7KQ1v8owz4inPtCduvYNzsRWlbvXy/5kpsvrWFAefPXopG7AWBuPJ7i66DIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208571; c=relaxed/simple;
	bh=oMdykAUw/PNnCAqxFssXe9AdIblfs5RDZadj6TVf0c0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NrOZRBRoSm2S4uvlksHfrUiJkVF7RgjFAWRUrLt8geaJAgt8I3TwBxw283nHMpDBf8eiv5FzcJtrm0WH7m5QPrPUv8v/dz54oPqcjmy7+OGLO3t83YT1lY1Go1n4sWfCLRyHQL/dUq6Y3GvaCCcsD3Xvxc/mhvaAPodwI7onoGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87c2bcfd156so18609939f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753208569; x=1753813369;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTqe+KHA+99J4Dn+ByqK+2DHn0R7rINO0ylipLZhOQI=;
        b=ry+yxjM9MW7eiBDXb3Lv4RhZbLsEEFEw6AnFYvMZtb9+mBy6+3MVZRbhZ/zYFYT+Dl
         FRb8UyuVJvFvunziWBW2m6x1WQ3GPM3u4WNw5Zff0O8j57Sszrk/opC9FsyeZA0/USsB
         m0fu7YgaV98qK85EtJAo+ravNJpVSdcw2rLda9MA9Gp8DujjD0horzu2kV1AEZX1H5la
         v14vZOu4RdF9uGPAfnQgj7g+kW/LV5t/Bkpc6/O0ZEOdAxmL/gf+KC5QIJWDIzYDN87z
         N6fVfXQJc+bQGAcGYXXiRUzdkhzu/+rnEtc5dXKhYcqS+mnkK6Mv5+14BZEpbyXvBN3x
         OrQQ==
X-Gm-Message-State: AOJu0YyTYSF7+lGXsQ1tPIT2lECI0KqGwiJRRrblbTSRJTIIxnvTceNo
	clVVvENGSsRHJTAUIKHYipCc+dWP5ik5bHFbDDSfvnA1xSOU2Wq7WwV2Hpopp88o0YmXXs4Rqls
	VGrvoFHupci2uYbjoiDqvMyV8ySaIqlUIjFlx+w834CoN7FsalxViR5j8+RY=
X-Google-Smtp-Source: AGHT+IF41TZFLm5tAzLvNl3OidZ0zGUfKgMvTy7HvHsNCTD7gaYmvz1sOjcm0WYb2Dp7OEadWZGq3ZmKRufetPZV7eFJwX8+jas3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:256b:b0:87c:788:e1e7 with SMTP id
 ca18e2360f4ac-87c537b39c5mr687559039f.2.1753208569148; Tue, 22 Jul 2025
 11:22:49 -0700 (PDT)
Date: Tue, 22 Jul 2025 11:22:49 -0700
In-Reply-To: <68226041.050a0220.f2294.00ac.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687fd6f9.a70a0220.693ce.0108.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+bfdc0e00ec47a6f7f6a5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Fix possible console lock involved deadlock

