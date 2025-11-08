Return-Path: <linux-kernel+bounces-891560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518ADC42EF0
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 16:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FED63A63DA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 15:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F22B1F12E9;
	Sat,  8 Nov 2025 15:57:24 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64A91EA7CB
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617444; cv=none; b=aW0hMbXbo9Wws619r4tBjiaXYVdosNfU6z5Py7gY8Zs/FkDNDwLRm+HggMkKESQB3GnmwPl6iu4aztzLwQle8Z+7qyBX3+hekEf5YBmfJzEbj1ZF1hX9tnf/IQV2HB3KGP9mxV28uq22PUrnMr9Cpm1rdptTRr5kTv/sg5Zx0rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617444; c=relaxed/simple;
	bh=L6ptIwyzAZi/q4JHq/o9JXyIBQFNvCVX29puu3IoiC8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NUtW21vGYL7lIIyaX6jzlkgntYJSzAABPqka7/sBgRRrTRBMepCMERh/LK3nHAWNPB4382EqR9NuC/VywLjQqo5J8QDRzSoTQGFHb+tcKsgA6qQ6d8Me49dc/uO6lzuw6eMj5mkc23VeA5l6vjMtrbH5zPPmKfTZksmgfDJxvyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-43335646758so18075045ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 07:57:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617442; x=1763222242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6ptIwyzAZi/q4JHq/o9JXyIBQFNvCVX29puu3IoiC8=;
        b=M6ODwBGUnpWkT0RL/3Jk97BshMIUGRZeTHPXLQb8DPk6915Ida8dFpNJPG78sg9/Qa
         eBHkVWrfuhNHoaRQe/b9hHlLPh3aSA2LVD03TM9C7bYrbUtJEQDywUcLMbG4OWOsJpUb
         Om0E0EBan0dQTvFJt4HqefVoilmbTXX0EofmuTJIjEaRwuYGNdBRxCYSODvhYwb0T6Fc
         lSQvKumwRlxaKKpMscaF+9PIWuaurDYY/ABSt/cimRMXY3GKDm2vByreV7GY3ljdAHzZ
         H6Vyn/2vO023H85RMwZBZJatT7N+gIrm72tBVuDJNhDK6stKu4PtVkrT2MSWO6btkanG
         mu1w==
X-Gm-Message-State: AOJu0Yz30twfi+iofu435Dbzkf+/S8CveRHsB6J88Qd86NfdFzZ3zvCl
	0iOozNWicctl/LNnssLGg8FVml9osnkpAbmwF9N2HqLl2ek9Y/QDl9mZJPSmvxlw2ZI1AIRvkh4
	t9+n86srIu8CRoaiSjzGTJi82q2acIy7hssucmk2q0YjeMKoDoG6Z9JiIxYQ=
X-Google-Smtp-Source: AGHT+IFDbrf32cEVs9nk7fcflcYo0LBbeeh8iHjG9iT0P7iUBiT57N5ZezjVzdrrBkIssrE0FxacDSKQnxz7lNeSd/hKCwXcZg3M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b47:b0:433:258e:5a92 with SMTP id
 e9e14a558f8ab-43367e6e9a5mr43832995ab.32.1762617441874; Sat, 08 Nov 2025
 07:57:21 -0800 (PST)
Date: Sat, 08 Nov 2025 07:57:21 -0800
In-Reply-To: <68f66418.050a0220.91a22.044d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690f6861.a70a0220.22f260.0084.GAE@google.com>
Subject: Forwarded: kernel BUG in ipgre_header (3)
From: syzbot <syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: kernel BUG in ipgre_header (3)
Author: zlatistiv@gmail.com

#syz test

