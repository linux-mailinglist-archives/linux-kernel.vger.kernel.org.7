Return-Path: <linux-kernel+bounces-877665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727D9C1EB2A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18CEE3B398D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704C6334C2B;
	Thu, 30 Oct 2025 07:11:40 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5607286897
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761808300; cv=none; b=kArcX9kKZej8OQcLeW3P0q+p8wMKNL53cshjy+3JGoKqDoi8bNrmoVbZESbrNgF0Ch5xki50zZ6lFT0Ju/KsIBgdEY6txBXIUYCY7bAwqMzb2AfN2J8iXz9AAM1DRUUDu1Me7dUTxBYbvKkYEBEpvZBlveql0K+8M+91E4eRXw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761808300; c=relaxed/simple;
	bh=Ere+qvdUOcj2o7IUQg1mdM1BYQ4FXgURpWZjQ17EUUk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z5vRGA5tU5mNomnUgkhUFaUJ8i/g+NUdDwURoUsVRn78kaV2bF9rWUFEY4u27C85X/xoQWvQMpvC/MVwMS37sqSVXk0wejvvEN65How+1CQCMWcveAdJwkwkIWsYpmb1yc/xGWM/jtDE12HEZAGoUTacibkgNQjOfVwDnpVDpRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-945a5690cb4so234933939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761808298; x=1762413098;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ere+qvdUOcj2o7IUQg1mdM1BYQ4FXgURpWZjQ17EUUk=;
        b=CQWlSRFjiSU/lDe1eeep1yiC+nQ0G0HX4k6p/1E66kq7eL7ciksw5frb/KDEYb9d90
         mIbCTe40ddyhFwLqMnt9rwp9PTRV94omxApYcNCHwHt7MEUpFjkL0Ajj+70Ic/W6iBiY
         gtn6ueq1m7+xbTd6ej+LfuXS1jNTY+jErjHAdHuwJAhh+DRUqHYHWQaOlkm+pE6a6eXo
         8V5rmrXKU6VOFC8kBtwWqJGJtxaCna326o0Daw/wAKGTdmgNDrP56S8FRu+ZZcpsQVEo
         SWnAePPLum+dhK7P5zd1Gcq3JOW+XuJAviAq8ffEycXz/KXCI2wnVEPJA4/3l3yvXXx1
         3tnQ==
X-Gm-Message-State: AOJu0YyiULlsetfqC0Mh8t/p/U40GZ4AfRUBRxRRsJmYPXg8I3YW9nne
	QFeMqYRE2cdAtB6WeiytQ1R+z7pAohYHDrYWg+Yt74I1ZQi39rqqUkqKRAmNQu2Ee4VgNJjS14y
	ndsakRhS7+Fk0wmxhK0hVPcDhWOPHADdKZgNoAq4qxKh94aRo4RrMKxg7joE=
X-Google-Smtp-Source: AGHT+IGUlCPvV0BmtdbW3irFg1zw12q/y1X4XiOKSaxZ5LDqUq9orIBAyUcxzUKUAPrbDSFdQf7f7nUeJZ8mvW8VJ3x8aSBdaKXP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c9:b0:42f:8d40:6c4b with SMTP id
 e9e14a558f8ab-432f8faca17mr72858865ab.11.1761808297793; Thu, 30 Oct 2025
 00:11:37 -0700 (PDT)
Date: Thu, 30 Oct 2025 00:11:37 -0700
In-Reply-To: <68b6d7b3.050a0220.3db4df.01cf.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69030fa9.050a0220.32483.0227.GAE@google.com>
Subject: Forwarded: Re: [syzbot] Monthly xfs report (Oct 2025)
From: syzbot <syzbot+0391d34e801643e2809b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] Monthly xfs report (Oct 2025)
Author: hch@infradead.org

#syz test git://git.infradead.org/users/hch/xfs.git xfs-buf-hash


