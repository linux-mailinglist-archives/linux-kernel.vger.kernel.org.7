Return-Path: <linux-kernel+bounces-741735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FE1B0E85F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 03:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BFE31C28517
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 01:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D441C2334;
	Wed, 23 Jul 2025 01:56:37 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454CE19D88F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 01:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753235796; cv=none; b=kPuvGD4IDSe5T4i1Oe5tPNvbhCgAPtJIJ9V+40H2lFjVGnuy35U8lzBbFC8xTuPCrKirlXwL5a+oIstf9H2RnQOnwGIbCDUcloyiFf+MgRi7khz9a7alruDnS8qo782e4YfcpEI5giFbfuyO653MAZvsPzngdAOwJGGWpn2020s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753235796; c=relaxed/simple;
	bh=9OlrydaUpg3OwHFmFhJUEKn5dj8ZSZkg1QuWWVFtY0w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GL3JHIKVlrfB4DLswB0cBOdqYH6uD0bh7Ifci6n8e/zAZ8c9wFu7KA8pbSj3NfpEM+7yDIcwWTtyhkJpQ4hHgjNMi4mUp1uJI6evbMBqaqRwEOyIIridyj7n4BQ+JmIgxk2w1MOy4kU8/muDIrzhRe7fsyR7zTgyoemCAIhMX1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87c467931c1so437056339f.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753235794; x=1753840594;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aep9h97yzq8BxK3rUKzUgGRp8xlimpOzQ2+X26fDUzI=;
        b=HDGlWvgBUnjY6/tFg3Jv+S/b7R9dGct18qzzEj+kCOG59G6cMLz/X0g5bsW0q7yrgx
         hlc8A818uVgp1xnE/6fuI705EoarVH6900MtrJq7GWx/p+mIkyY6e87MXCjIPvBAj3F0
         KTgXuLukqTlm2qpbiDyGM99EC9ZrrR/rLPTkLNHOIo7A9Tfx7N0ky4TagZT0+ZQcCgS9
         HCPg73quvTiL7C88npPD3TmBDHETXFUp1R3rWADxLyPhq0ZDm5Fwfz1uhQP9QXGtIACd
         SJb6tpRh1SLYdPOyUd7F5lqKLzJ9kaJaChYnHQ6dCePhBP82OAdVjhA1REyht9jnO6br
         ycVw==
X-Gm-Message-State: AOJu0YyIf3liH7eyHGO0Yf4WAf+OD8O4f0NNwENNwnTGbYgOZpFNE2WB
	fhNL6rVyVJSZkkdIYPHLgr9HmX1BZcSp9A5wPUUtY/aON/Vk2gmAsvZvQr7mlXtfIUZDUeSLind
	yVqtRnYg5N6TUydQljyUVffzejsRsH4INxbC37i/Q0lcccFHjmBt1pBfBP7Q=
X-Google-Smtp-Source: AGHT+IHtJG7clh7+H3SEv78FjURSode+esqqdFT40GSSK6sfBDYeTwvFoNpepHpUaaoYersSi2C+hAmikSJv34xlOt8Ma5g3XUZv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1685:b0:875:bc13:3c26 with SMTP id
 ca18e2360f4ac-87c64f5fe73mr311062539f.4.1753235794373; Tue, 22 Jul 2025
 18:56:34 -0700 (PDT)
Date: Tue, 22 Jul 2025 18:56:34 -0700
In-Reply-To: <0000000000009a83e9061aeac50d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68804152.a70a0220.693ce.0111.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+6d3e28b33490b3085412@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Increase BCH_MIN_NR_NBUCKETS

