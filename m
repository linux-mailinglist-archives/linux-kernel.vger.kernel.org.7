Return-Path: <linux-kernel+bounces-832906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E27BA0B89
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78F207ACD16
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7099530AD14;
	Thu, 25 Sep 2025 16:59:55 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29C130AAC6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758819595; cv=none; b=Gt3OTaLMoCPLpAMk9TWhzd7NIpR+tJ+FkKX4QwYfVO9AFNLkSP8Pgi0nemCnp2Ar2psClE1Q5HvaFz5aWGGfK/NGWcP8kQiyfnD6gDn8JjC3wtooROd2TuCxQduBriNDnrDgUPjVRLb1OzWMJS2uPDPwuIL/JCwYCBe5VTuD51Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758819595; c=relaxed/simple;
	bh=9e2q4rBHt8H+em8IpSFWOwpYgNRzTUHsSszPxRSjbBY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Jm8Oedj4FHc8qrKKKE2s4NxTYCIcNt4i9Aj0cSABNOZcrSkx5qONkqI+T4DNLHWF7FULFgHH5H3r83VytQEM8ZHsFwh5gPp6dkrXDWiILI/AA7qRTPju+sCNBZHBXXA24Xi3TscJf+3oE/Q477kOuTCT5sWaVnvHwnUELSxePDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42594b7f2ddso17479895ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758819593; x=1759424393;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9e2q4rBHt8H+em8IpSFWOwpYgNRzTUHsSszPxRSjbBY=;
        b=TOPnX+BNRefinK2Fn5dciILBc87vbauHEgLUHRuNZkJwARyO0P+QIe4eR+0bJOkZxX
         bRYjDdjX5Ngy0tIg4Ge3nPV1eIPEtq9XvoC9BIwgcZizrDrFvi4ubFHty41cZ1DJE7Bn
         aORyrk1NftYWiJDEI1bkXhU1dqciFqMtjPkEaHcMUaaC95RtKefu1MJwr7Nw9ZuZKp7s
         n+F3USHpT01mERjf04EPdJp2hHE7DovR4mXBTbBOll39Xdxcky7SNuwcG8iKmG2jqHjt
         NMFt5mt1mIRv6yZXcor/WtAZ544aGwFXm9Er24Gh8AAHPxM8SYNHJ5yapyz3MCcZIyNs
         WtMA==
X-Gm-Message-State: AOJu0Yz43ihL1xPMpiuA8sbTz8sQoWmbLYjxkX8j8UK9gmHbefAxd/85
	nq1SZqD6tBZCbokqdEv28Mdx5f0JPcU3pJLng35EeFyhPva52FR62pXxO+rcT9aDzBgRA4DPoif
	HcObQgIFj4YxA47lvAXAXcDgDSijjq+KDBA5MDlCSUF9njG4HKhjUm4A5n+4=
X-Google-Smtp-Source: AGHT+IHuIV4l7WO98Ss+deladC0cpSSZjn5PtZzLGDLda2zAq5nY8GVD3VzJTe2tlJxWYXTvn+vFWefin2earVa6P5iZXlB2xmSF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d94a:0:b0:3f3:4562:ca92 with SMTP id
 e9e14a558f8ab-425955f38a5mr55682365ab.10.1758819592771; Thu, 25 Sep 2025
 09:59:52 -0700 (PDT)
Date: Thu, 25 Sep 2025 09:59:52 -0700
In-Reply-To: <000000000000b3424a062114aaa3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d57508.050a0220.25d7ab.004a.GAE@google.com>
Subject: Forwarded: potential fix
From: syzbot <syzbot+7a2ba6b7b66340cff225@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: potential fix
Author: rpthibeault@gmail.com

#syz test

