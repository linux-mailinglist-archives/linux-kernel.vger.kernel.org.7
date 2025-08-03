Return-Path: <linux-kernel+bounces-754537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92583B196AA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 00:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F48F7A9EE9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 22:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC1219E96A;
	Sun,  3 Aug 2025 22:15:49 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB30D33E1
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 22:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754259349; cv=none; b=snQiQrLE7/qKW5mn7J0IdY0UzMgi0jQf87/RAEuQ+hYic79YleCULBPfSOxx9DhOMU63yHRlpNeCN0fISQgHHD4dQfaq8R61fCAHgQfmM8PfTBG9wx3pXMNQQMK5mIMZGGzYX401jx299wYLFF5Tx9wmUadT/qPlncQR7FdHvP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754259349; c=relaxed/simple;
	bh=QMQ+BfpuAtwhFz524obGAZAsB2l8UAiRPXO+yvBbQtE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=kZEtp8RSMuCJCPpO2yZoJ+tv6k1WiofuBNd4+pWzJzCIT595nLreW5wUcg82hkXbnnI14ea5OU7S/sSVzAPMVM96esn5dd/EA43mGV3tpa/FTsL3NNPL/JpAzFRlz8cridpFQauK5l0MqeXYTWcUZlYG6nDH3WcrVkHjfEio5bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87b2a58a4c0so235919439f.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 15:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754259347; x=1754864147;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZfSAUsGeqAjQwP9TbQYbCnlpeRa3UwT8odZHjhZ6AU=;
        b=TiCRKIeBLWJsaEGzontY93cgxlKjY1pERPrUVoN2W1/B+8udqqxeofCceDuyu+lUs6
         YcVMbk51eYpis777KY0OMl/exJF8EDOflAF4P/sLoVKN1bxWN64VCJFFFn2rIp41hdlY
         SzvnoONmjEufxYH2EYBI6EM1yesgomQKDp06GaxHc3PmOCc6z42rZZ/MfytKRM0dGEru
         gR32/VXhB5b+k9gUDfJQJfwGGJbo1xkXq2YIzOIIU3hu6mkkDvFSX+rffnZfSwoHz9Bv
         fEILEj8vJrurs3bqcGQjSGI2MkLG/zUresWpWMYAznnjwQfaUiihSW1AZWIcSH3arIuP
         8j/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8QFBpNqq32wlZUU+tN1Mzp5+sCTubMOK1W1lZd+msV4y7p68CK6qn5Z7gnuDUQnpr6rRiCisG8MdDKqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0uj+CUWLfLtWindWzc95TBwyWi8hQ1ngK1N8uiq80/p/2YLZd
	7hvDJluO1bQ3E6YSpqa+h89w22cRMKcemL36VLMuSE4B5cLePqWVZwvt2lfTcq6boca0NY6+VqI
	BdHqsGC7V9umVsMrZOeohELTHYPZNwRGqKEuL7dWAZlbULNHSX6sz4I3nLsA=
X-Google-Smtp-Source: AGHT+IEVoYnNZcwQ4KI1P0dWcNIvdcOKsW+Gy9VG6xvtAB+yjEgZPNdFUZQRHCVsHXevXdU6DjEblq9tl4wnqwVhDZofv46fnBqd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:150d:b0:87c:2a75:b071 with SMTP id
 ca18e2360f4ac-8816830a020mr1433886339f.2.1754259346896; Sun, 03 Aug 2025
 15:15:46 -0700 (PDT)
Date: Sun, 03 Aug 2025 15:15:46 -0700
In-Reply-To: <CAJuRXzA72HYNbdQqSajpWeV1qeOkHDEy_o4bmyMX3cwf5OL-ww@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688fdf92.050a0220.1fc43d.0006.GAE@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in fbcon_prepare_logo
From: syzbot <syzbot+0c815b25cdb3678e7083@syzkaller.appspotmail.com>
To: sravankumarlpu@gmail.com
Cc: sravankumarlpu@gmail.com, syzkaller-bugs@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

want either no args or 2 args (repo, branch), got 1

>  4b290aae788e06561754b28c6842e4080957d3f7

