Return-Path: <linux-kernel+bounces-876809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB5EC1C67E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2633F34AC57
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4882133970F;
	Wed, 29 Oct 2025 17:19:29 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE9631283D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761758368; cv=none; b=dtzfdsYwUN0nlVTGBognik1wsEY0Vz/7w+T/g8itXY8WVFd8xBr40TI3LO6du1gInqO4ncuocWQVoTkeU4dUZkxymSuLDTXG6h5QJtoEaYLSPJdLMpoH6hvg1NBa3Y/XiUsRzc8igw6X1tyPq2UbIcDzsT7YuULRwkq5FYwtjZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761758368; c=relaxed/simple;
	bh=L6ptIwyzAZi/q4JHq/o9JXyIBQFNvCVX29puu3IoiC8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jgN7d3a0JhLZ4+5xCNURYAPAmb2XKRIN+L8SLRV6YNLsBsqHWowJn/Er8fn7r8ZD9ozGHgx8koHyiq0VEIZl2Sns6H9e9dgy6d092YncRIZaOS8JG2W/gAAJCO9LSvHK787lTTcJkOsauOYxsiOu00vm79HOwwtFAXZppwbbJIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430d4a4dec5so1250715ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761758366; x=1762363166;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6ptIwyzAZi/q4JHq/o9JXyIBQFNvCVX29puu3IoiC8=;
        b=ockgDF3AHyYFVZOKLqOOLmQ+/lbZIVMm9fO+npilkymLkBj3KJx4J+vAPsYqSc3VXx
         eSCxfLDb2ft20RnXR5aiVko/JJRKtgweXiz31ZJCoEV5H8fEp4whHYw56TNMn/LkQAqI
         GEdXFErOaOEGfbjTHejbeblkxwET9FtdojLuLHVqJ4PCfFmp2V/e7KCeCws+v9MnqYhD
         LzJCm41j2nv4i6IE2hYJnZwjhh96+UxUZc0s9gSH0Cv9gYF0UDa1d+KLCWNXTrOu2V0o
         uMbdG5GkEW6rbgGvoGyXQcJWsGZb6b7nr5+B5md0W4TVqu3NM0snquCfFR17bywTKe6l
         dRmQ==
X-Gm-Message-State: AOJu0YxLl1bG+vy9vzWZqp4vkJF+oCMVagN4lRz6a3pHiWPYSN4Kphql
	xsugm8S6WkrYv1HjFqeCZ2ReBbGfH4qRnKz0axDD8KI/MoPNV/OH8qkCRrDmsQeavjMAr0Bo/ZE
	VzYhHv7YQaDkrQ/TYw8DK8lDKFC5266OdD0cTz1hrYBkTavXtfDFuvbzWxxw=
X-Google-Smtp-Source: AGHT+IFZfXhoP2RlRysYJOn/g+mq3QVg2hGTxQy5E2xTVFE9gKoYXjH10l1kyKjLeWT7WjuAF8L8wCoCgvpXBCy41xyAoePozeF3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4802:b0:432:fd1a:2d4f with SMTP id
 e9e14a558f8ab-432fd297144mr27849815ab.31.1761758366692; Wed, 29 Oct 2025
 10:19:26 -0700 (PDT)
Date: Wed, 29 Oct 2025 10:19:26 -0700
In-Reply-To: <68f66418.050a0220.91a22.044d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69024c9e.050a0220.32483.0216.GAE@google.com>
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

