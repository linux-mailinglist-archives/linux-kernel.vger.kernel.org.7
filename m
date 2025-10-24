Return-Path: <linux-kernel+bounces-867984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 327EFC0410D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBDDD4E2135
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6635E1E47A8;
	Fri, 24 Oct 2025 01:57:53 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DB28405C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271073; cv=none; b=hPGGmpDSok9fZh4GrUvNkNb6UMXWxW/lA5QaBQ/62lTM7VfQDndhQGbo/n2oJSrL5odnuvZGyZoRIcR6PoWbBAC8B4OjTsrrGzYu2Z1ZcM1eBWWOGSAab5DR14GkfTW+vY5j9Fj2Wuoqb7sZSjzTO3q5RFPG6/c7M730bZmeIas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271073; c=relaxed/simple;
	bh=IteMu97IjHShSHgzImd5JSYnm5D+nLz+FdT9D8T55gA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NTrL7KLmz+HzsGh4OkZG/eYZq1ZhPBvXfC5CF2pqMB4ddkytW7zfMCcmYJM6IU7xnJVBs0NHd7lumVLa/9S4SYnJ5z8JUswXpIgPXO6a8mZVfLug0VxeKbn2K9BKX4+wY3mVTYIAFro5+VcIekon4ejlFF7pH64odtl9zxoCKxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430d003e87eso56622345ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761271071; x=1761875871;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IteMu97IjHShSHgzImd5JSYnm5D+nLz+FdT9D8T55gA=;
        b=S4oY7S406uq2jps6GVlW3UaJYyNSFHHEZ82FBGVnYK7u+zh4eBnrHtAjWUG6ysE647
         3HrLB1Rhx8u3TopgBl64aAIFu5/w3fz+ZJ8yXro9Ko/3F+mYhapX2tmIso1OzfgKElTZ
         mKpLXm9NAJmEAHybqHOAEFkE+0Un2MYjEqCs0WMYmRTMA0yMYaM0T7feP06J8BOc54Kk
         +Zf/Egw/sqKFB7jIaiJUb3kAD2eK/ScEKuSrWpSPVB1wZr/HSwHt2bPzcEGzoAHsZYk0
         6/9t76T4IjGutjvO+fWJlAoZVWpSTmwz4I7NuB3X+fhVMc+oNJPyVFny2unOITjaXvgx
         C3Hg==
X-Gm-Message-State: AOJu0Yxmt/4gdDJYXGAgnx8l5d/jp+TYOezrmBnSFGtLA45Lf7qgAGPJ
	6BKMf2ZytqFN9d/OTMMyWJGj9l4AJQJ3Y7VfRx7DucY5T2Z7w+krqhNIdRZqowpY+kYbY+zA3SN
	XPHkl5k3a+JxOdpl7lOXUwkaRQ8jFSB1NQQdKG16rWM2wVZyASjbR3SZ5DaE=
X-Google-Smtp-Source: AGHT+IGXp/aO7oOIYR5q3zJcH4JMMiAcJ0DQUQc8juyxQbvnnoVvee/tn7mut/eMm6KB1M5OISADrbOzHZoeOCLGJBm6qe3+Tc0I
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3783:b0:42f:9db5:26be with SMTP id
 e9e14a558f8ab-430c5234288mr394148595ab.14.1761271070843; Thu, 23 Oct 2025
 18:57:50 -0700 (PDT)
Date: Thu, 23 Oct 2025 18:57:50 -0700
In-Reply-To: <67867bcd.050a0220.216c54.007e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fadd1e.050a0220.346f24.008c.GAE@google.com>
Subject: Forwarded: WARNING in ocfs2_unlink
From: syzbot <syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in ocfs2_unlink
Author: eraykrdg1@gmail.com

#syz test

