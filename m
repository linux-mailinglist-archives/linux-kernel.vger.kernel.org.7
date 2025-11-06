Return-Path: <linux-kernel+bounces-888812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9702C3BFBA
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E7B562A35
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4F0342C88;
	Thu,  6 Nov 2025 15:08:36 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FC730101B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441715; cv=none; b=fBqQ+BL7yxtQ6BYoLGUsI2qJQWVKiRT3GJOwD3FV6xRBYlWBJDpfTmBNSV5QTYY4pQtFCcc5/1KI4tePaNtqqD/cGzGuI+an/f0+bFZowxZVBwVJzfe9lbu7CYhEEE9x7axJrPNm/130sjdDZUM8rWPaFqgArmARs0iM7ONCZzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441715; c=relaxed/simple;
	bh=Zld3DkMTs+vJ5Ts4TpMbY0eaRnKgv3f/ScNnAbIIwEU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Nbv2b2J2IDIGkzArWxEKRCwSdI1HZw7u9z/4eq6hBF19r1NE/wAdJAmFApM+X8JOcVsPYSnda3G9ONu7y7vAI2jtu6K1G2yjVQEJAFxlwsfV+pVJpnT6iRtvxvHRrWBwWVW4JWY7iEEXFvaxr9rXLjroqEKH3tweAaznqxpAQmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-9487df8723aso39801739f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:08:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762441712; x=1763046512;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zld3DkMTs+vJ5Ts4TpMbY0eaRnKgv3f/ScNnAbIIwEU=;
        b=SINClbEOnNOVaVXFU6XSlU2t/t5mVYANd7fDfnsKruQnAXhjmVGbEprzDtYrK3Jt1z
         X7n8Bw/Xr2z5fSEC/mW7Nb+WlbDK2fASvR5IupgP8MaFKf5nHcIwu4Bb1irfvNukaOhg
         CUrfvzGJKK8r+Mkp+7mG1czbPZmMMZhIo6uiV8mWWhdjdMuLidWhwjAq0OqCVwAyM+l7
         Snv7z98L4mfRD1ZCwPF8ll2FlFMTPVdFksK1QNw7LG1MoNiAhZtQYKDSM6qJ7FbduEel
         fpmRXgddWGD7EiqmoPQyx1QxNcpiV7T8mcdKyw98hPZK3cyF8HU+jPwAfzeh1eNdfTD1
         19uQ==
X-Gm-Message-State: AOJu0YwqYi4rQK7Zr0jh29nOsYzw5g8NirTjyYm63vZsAqZnmnZvvz42
	pIFvu8OpiBfC3ELIAhNX7WLJI6U7N2BYzd1If+iyICWmjVZrQAGhrISktzEcMu9pYTu5Jt3wg1w
	uE224kFi7NFxH+wQXRDoJBUDYU6L5Yt6v2fJ3GejIIc5vXkS6PS1I69KBs4k=
X-Google-Smtp-Source: AGHT+IHhsqW1c9zYzJx2ZoTzNVe2NSyOx0rM6+UwZC/VimMGW4k9h5iGMzRRYVyU0mGxMIdfPO++dHl1kocZIeHHioVWHIQTANoE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26c2:b0:93e:8bec:6a87 with SMTP id
 ca18e2360f4ac-94869cbfb0dmr1069016339f.1.1762441712477; Thu, 06 Nov 2025
 07:08:32 -0800 (PST)
Date: Thu, 06 Nov 2025 07:08:32 -0800
In-Reply-To: <000000000000a4a7550611e234f5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690cb9f0.050a0220.3d0d33.0160.GAE@google.com>
Subject: Forwarded: KASAN: slab-use-after-free Read in handle_tx (2) Inbox
From: syzbot <syzbot+827272712bd6d12c79a4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: KASAN: slab-use-after-free Read in handle_tx (2) Inbox
Author: viswanathiyyappan@gmail.com

#syz test

