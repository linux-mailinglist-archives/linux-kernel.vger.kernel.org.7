Return-Path: <linux-kernel+bounces-831127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA54AB9B9D5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD9C426734
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB5325DB0A;
	Wed, 24 Sep 2025 19:11:15 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF825484D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758741075; cv=none; b=M84P2OhqFJA4p6jfq3EcK9i/J4tt8ik1CnRQimztB3s7YCYue9eVSj6HJnY+OYwKtsVyCPfgcG8CBsFYUsSjTRQa957wb2ILMqDcXLcDW5PSshqvn4W3Ad28Tf2cJe8FoNM6GTzOgSSZqEprRz3v/1Jb7Lz38idAto3C4gnKa3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758741075; c=relaxed/simple;
	bh=FmHkEOPcGrXjAQlgnB40beODsdm/11gSe0xolGqNTK0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FpDhO80r1PkX+HnLjO6Zg9ipW9DHZub3sO9gqeHsd3vQ1JLrNMOawJEnNEmk8I+BdN+FKGYBlcI8gwzA54+/nlP54hUcfBoxck4ozp//l4LEQiQLCxUkEJRzFEey2AiPHCLRflW3/xihMMvw6srzVm+6ljn+RdN7d6d0YoRwf58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8ccb7d90c82so28435439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758741073; x=1759345873;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FmHkEOPcGrXjAQlgnB40beODsdm/11gSe0xolGqNTK0=;
        b=utSqnrUzLxc/33ev4fKpX0XhNwLFWx+pW8lOlgI9gcfHXeetOUGXPwZVfqMzGKr1J7
         higOSpRiDZPtt9O2e3SeLQR4ngCR39TgVKNEQmkb7sa6386x6zjYDNLSW1IjnsATny9p
         271Eymr6zIDPu8s1PsFjNysiGSR7rO3NarX9iGCCsXkLWS8p+e2HIQO998gIQryeOFNn
         LUPmOeqqaGRBJ7t1dnownpmzUmhicV3dcWqPQcagg8ZrHCAhlRfXTGfsfu2sfGeFkWGD
         P6ikLkKHy40YDdWHes8OjD04JruMpdOvM9DYgQwlCNvun/wdGnR5U1wbtXi2mTjMlKCI
         JRZQ==
X-Gm-Message-State: AOJu0YyekHUazqb1mnxvxvEj3tu0BR/jsodEhoy7+PTeBGxdoddlWASY
	YQCYroY0455BAryxk44X4M1fvGuV+i5Vgz2sRLZ2pD2iesWL5W94scZkwyN4D4kPGJgLoouvLXf
	dTz3ylRF2AaDKjEHZlwOesBi/1cRDbnC71w8t1CU98FiVFir2DvEGnWePLJE=
X-Google-Smtp-Source: AGHT+IFX0EKE/eAOCt+jY0XuNzlz38ITmOuza02HzEQB0OE7JLhD4zR3N9o1/lE05Hkh+2U62Wj4zFO/4/cndpvI6osyehmokHlf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:230a:b0:424:64d8:73e4 with SMTP id
 e9e14a558f8ab-42595666537mr9247285ab.28.1758741072814; Wed, 24 Sep 2025
 12:11:12 -0700 (PDT)
Date: Wed, 24 Sep 2025 12:11:12 -0700
In-Reply-To: <00000000000051d14405fadad8cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d44250.a70a0220.4f78.002b.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
From: syzbot <syzbot+dcc068159182a4c31ca3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git cec1e6e5d1ab33403b809f79cd20d6aff124ccfe

