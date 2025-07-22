Return-Path: <linux-kernel+bounces-741456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AA2B0E45B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E52547683
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F4728541F;
	Tue, 22 Jul 2025 19:47:19 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FE727F747
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753213638; cv=none; b=uOIeqAADRDJL6/4hFUUU02o8bXC6qCsREH+AVVv2gzZysqHmjqp0m+q6aAG+oCM+d61U26Das/Ymw+N2/JgBKTsCb8+ErOqP8K9YkgLTsDRZE1CVkbK6I+WkEsCFABYNp8bRcbtl+xeLahVHjKXlJgTuYRs+TihAx6xdaqagPRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753213638; c=relaxed/simple;
	bh=KhAupNvkqYbB+L15tQt/GviWL4AKCEiGwpuo76Nu0v4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=n4SHADrzGaHD4A/es6+ZbLf32jk1ltmPVGoVIi5+FTdZ+z8jsQ+KJnAByOkazWyb48KZn+li++SM4rw/g9VycKAkIJJcnhmNkt8PY452TEdqNzs1uNzZY47X5FeRbAayr0FG+96U6mIcD0IAFICU3CIcJLi58ZnSpo81cW3UCN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87c24b196cbso362517039f.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753213636; x=1753818436;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhAupNvkqYbB+L15tQt/GviWL4AKCEiGwpuo76Nu0v4=;
        b=JNWpTIpS+1h/+/O8lJK+YJmLkhXZsBqLje2FPag7HAOcOHyMO8yYSsbD8GvPsE+F7g
         UIZDBY+y+UlnuFSm6XNR4Q92o6AHAn0U5nuavzi7FLI9XSNWUBh43EEmQD37qBym4jzy
         kcS8y+tNUJkP36yvLybulJN5RUXVmgDWAHTw2AM2tazI+nJypMeyqHFXZTLG9ZgwHf/G
         lPY4daNDpV4PaT6FZ90iUJdpZsMJgw0VttN/oBRmVasqS76dolVP41ZEL/BOSCbQZrI2
         z0dMiO2gSb2f1Osi31Bx5ZycNRhNfvMoZ5g/ChrFncyk+qQW245kVwZWNn6BLEBLqWtR
         6xhQ==
X-Gm-Message-State: AOJu0YwlWePR8lFfOGGkfO3FhupNNH6Xndgc2q/bOK+4StSAY8XknTZ1
	IWOteqc80E1gESVsZKElxC/oasWUTVW5piVFGvqRXYE15/pJI/hZ/ePkHkUB2JP7CD1mWHZmpXg
	FuK0yrUSIgQvgbHCY1MXAcj6KiJ4mtXo5mcmHkGJdJ8UWMAwjFyHPKRMCiF4=
X-Google-Smtp-Source: AGHT+IHkT5bOsizzU4GRs55SoiHPfaxYPynREfRYvB8D/6LfMyvr/79oLo0wP85sSp16FuCWGJLBWrzBJ3OdxAlHmMvHFGDxa1eO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1584:b0:862:fe54:df4e with SMTP id
 ca18e2360f4ac-87c64fd8f3dmr67755639f.7.1753213636550; Tue, 22 Jul 2025
 12:47:16 -0700 (PDT)
Date: Tue, 22 Jul 2025 12:47:16 -0700
In-Reply-To: <CAF3JpA5JPbEByou1OKfuPMKH1o--0q113pNoPyPR-h3QjuZxUg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687feac4.a70a0220.21b99c.0014.GAE@google.com>
Subject: Re: [syzbot] [sctp?] UBSAN: shift-out-of-bounds in sctp_transport_update_rto
From: syzbot <syzbot+2e455dd90ca648e48cea@syzkaller.appspotmail.com>
To: moonhee.lee.ca@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	moonhee.lee.ca@gmail.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git main

This crash does not have a reproducer. I cannot test it.


