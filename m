Return-Path: <linux-kernel+bounces-870096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B58C09E74
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 20:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6281B22752
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7EB3016E1;
	Sat, 25 Oct 2025 18:37:33 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744DC2FF167
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 18:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761417452; cv=none; b=AUyeL5TkfZIBrNQpnqdElFbBLboBfxIoQR0dJurcDBAQTOdnaW571ztGdSbU/i5raloNCiP8yZotvF+Z9nhDXxbQDACSm72vnQ2qbCISdCNlRuLqEK3xTQGzrJ94datgECiezJ/IrA6AtpBnrXMfbv9rWUo4od529QVRjmoePtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761417452; c=relaxed/simple;
	bh=Jzrlv5c+xfxqekayEMDIeeF/qVyIyYd5u5zrPTV2rZc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mkS7ZXwCd3G28RI4ecaRmIcJilkpYiJrsti0U1EX9apC4hdkhilaGptGW1cfVBF1N4TYocar4OdJwIVpM+jGf3UjHTjJFsyVTp1BzvWxQHov38fVcwd2hhRvoQx3lmJRl9W1oXFQguEtMHH0N768VdIKnZesjF3X6kfZmCSuRjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430e1a4a129so42395425ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 11:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761417450; x=1762022250;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jzrlv5c+xfxqekayEMDIeeF/qVyIyYd5u5zrPTV2rZc=;
        b=YQ6Swyst4GQD19WwnFS2PjQMOlGKtCIgwYLWkKueERjQZeJmUvlA96rcSH2BnIEmC7
         6JE7O7YLVzc35cghDCk4uASZzOOkC5GaPG3aYPifUZSjqP2K2oztuWw4Zh2baMQDQnyB
         R+ZQSuLB3YKcWbsV0U3Pola9MnyreXfeIzRd81HfkxZTsX6D7gGjZlurU2WTfTctdlqp
         0lMonQUqAQT/TEH74+b728qGuH8ReRSs/eKcyvZyO2OolZEGghk+//FKkIabx5+6yka4
         D2GqVFsxTmXWTIslRtO5fLCRq5EjwZSa+ASwBIEfz+MwnM5/SQMrOgsIO2I5DYfKeSjw
         vbfw==
X-Gm-Message-State: AOJu0YzdelwZD7cuSxdgrkCs0TXTT+W6Uvkr28jPnlXtK4j24zkjk3gS
	SQKh9+T4rDM+7xyOzmqB38fxQLOoDvyTFxS5hRFhQ0yK/ONNB8q2Sng9gddzavxITLSl4CV0kqB
	lIULdzcvgB3X6eCfnYYDwO44Gc4oDpsVAAld8lGe6J5uHAVD/wyk7GrUhAPQ=
X-Google-Smtp-Source: AGHT+IHBwT898SE9t0OkXURvfkB1hMorqxeecbdZkRQLGpsHq9Qmt3SW08l11k4LbEAViA7/AlGjmXTEun99F0HiJ0kCTZTmBpIZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164c:b0:430:8bff:c5a2 with SMTP id
 e9e14a558f8ab-431ebef1db7mr76232635ab.30.1761417450570; Sat, 25 Oct 2025
 11:37:30 -0700 (PDT)
Date: Sat, 25 Oct 2025 11:37:30 -0700
In-Reply-To: <68ec7960.a70a0220.b3ac9.0017.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fd18ea.050a0220.32483.0002.GAE@google.com>
Subject: Forwarded: KASAN: slab-out-of-bounds Read in mcp2221_raw_event (2)
From: syzbot <syzbot+1018672fe70298606e5f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: KASAN: slab-out-of-bounds Read in mcp2221_raw_event (2)
Author: atharvd440@gmail.com

#syz test

