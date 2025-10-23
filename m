Return-Path: <linux-kernel+bounces-866574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7FBC0022B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE6D19C1BA7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E8C2FB98D;
	Thu, 23 Oct 2025 09:08:48 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD3E2F6587
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210527; cv=none; b=B6b0NJnaOeyS4HBeDtX0j2TN+oFcsP9lZLTSRdZcsVMTctwGVTzBcygW3MhO6KQxhrUdFPFjQc4wKppPDzXkZJ7K6LEZLkHbKIbWo6snn7eABy5t9J9t4Jop38kzoIffMar2JX8py1Xj3Acanv88H5Ztpj0wJBowNbR5k6Oev2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210527; c=relaxed/simple;
	bh=S83kUwtpJ3k6awSLpLKn066NV5nY/cY8h2WOHk1k7AM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JlU3Clg3c23N8rQ5h6wlCVt1yZ0uM2q8Yp5dWBftx6HIdOcaxuNot9MDLE6D71aPqO2klsxfTVzjLdwwc4bZaO3fkDGvKZT/VvFDP9DxG1isi8L61CMh6RrdrMCiL2YwWonO5TDUQK5ytunEhPnscRIUUvPD761NJimAZ5fPbvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-940f98b0d42so172563239f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761210525; x=1761815325;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S83kUwtpJ3k6awSLpLKn066NV5nY/cY8h2WOHk1k7AM=;
        b=A0W/hMpdFIWN/dKHvcIXgw0QL3r1QJBTQs5tJIPM99NH1uSE1RDL8Pyvjmf8vx9SPJ
         vPWLjIRDZZILuiKiNtQUkUaH28MKVkWJ12BnZ9ChkdKynS88yVSe/tWJWFdkj7MCyD+G
         2Zo/xFwFCfhw9xMNMGuvOtJ4MMRbwSj0vglYHQ0r+1pWculArSw8/pZCwHyrq9BqZ6cE
         oJM8U5h2MzefW8PiLg3jA0WSPMa4d6KtH+bVQVSxikMC5APK2KavJx1rSaJ/hgEb1gM2
         wdnBlUj9MHcZuJFXX6YZG71BY4JGJDpQz0IqyZc6tr8dewn48LYC6LH7rWx23hbIhtWf
         o5pA==
X-Gm-Message-State: AOJu0YwkDj9NxSg2ZcFKIWwgSBNhSeQ8XmpvCCL6QC89/nc5OYYTv2Dv
	veo0tr4r5IuwlWf3naRACpLA6HAKlZ7bgYZRNSmD4K9G4T90OM57Rv2BPx7Lm0UcryTO66NcRkN
	+iAGe46ZrMbftaF8Svlcmz0tFye3U1wduO+B4fndE9BcPkOAV/Minx3roDmo=
X-Google-Smtp-Source: AGHT+IEosYj5tVuLQsqEaGCM0hJeqn72P1r9yEofTHk0xPU68WTw+3EUTXbBQWBjBgqkNpJHzoTi4gy33qLeSDDfYBnmWYFiJqUW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b04:b0:893:d33f:e5ad with SMTP id
 ca18e2360f4ac-93e7647703bmr3545947839f.18.1761210525421; Thu, 23 Oct 2025
 02:08:45 -0700 (PDT)
Date: Thu, 23 Oct 2025 02:08:45 -0700
In-Reply-To: <67867bcd.050a0220.216c54.007e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f9f09d.050a0220.346f24.0072.GAE@google.com>
Subject: Forwarded: WARNING in ocfs2_unlink
From: syzbot <syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in ocfs2_unlink
Author: albinbabuvarghese20@gmail.com

#syz test

