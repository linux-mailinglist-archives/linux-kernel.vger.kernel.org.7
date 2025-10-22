Return-Path: <linux-kernel+bounces-865189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9E7BFC6A8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EADDE4EE1DC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7E734B428;
	Wed, 22 Oct 2025 14:13:09 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53FD32AAA8
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142389; cv=none; b=PlHsp3q3N7QloLLKyWUpA/4i+eARQOEflPaJxCdvd6kYRzGR4gwvizWScaOGhvfb87RWQ9cat9Mm6hCEuiNbL9QkaMk4Q5rBhdt8WtjhwA/X3XiSvw+zkTyMH3lLrfotAeLly6BtiX9cGZmESH1Pr4EMjNxj8thSjFX8htSTvgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142389; c=relaxed/simple;
	bh=Vf4nF2zN2JGPAsg01PG9jRy7r+YQieM/zi5WTcblOuo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sXttA7+HsFL3dddz+WI4IJt/kc80R0fuXJ1LmJYXg5J77QF/GmNzF3BoW2uvPupAMJvxa48JTFTSy7gAuth6FRH0jeiKbG6FfevT5pzA7pqqnIfNO7Iokjh3IdwUOH0SI8lizffuwWk9VYXVhWFxlB7pUYh3pNAfPuwWpcu2z1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-431d777219bso4634485ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761142384; x=1761747184;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vf4nF2zN2JGPAsg01PG9jRy7r+YQieM/zi5WTcblOuo=;
        b=TLnhzlLcmobIAuizK9pBPI+WJce0zt9XWH794o/foOOEJmYQ/pVbFWwKcAGOgUi/H0
         5P64o2diRbgGJjPBIFNLUT5OunKj3LNgH4rNFR8H7whiJXK29UFVFpUafACVBTKnvl05
         ve8W/D3kX+2tDmnVTZZQa2T7VCFbwBuA8dTMHvCzJRQsIiFSEjlerkXz7WKeUwNUFRbP
         XlCWSWwhdtmL1SXyCo2BlhEO+QnI2cXQpW09ts7CXGO3kQG0JB/xF4ZDI1mIZXAYmWXz
         XLf2ILFcmsFDp9efc/dG3z6mRx3zFedXQayIZradZPGbO0PGp9/BpxWnbWievDIX7yiW
         aUbw==
X-Gm-Message-State: AOJu0YyrHGuncUWF6k70aW2oGOgP2X7u+FPaOzuXiOhYr+6tWH8CP+PW
	CrMRYvi2rcXgbNgwmu3GN4XprhYbHiiabg7vLF4uVez9yO7TWU/2VBPypF2POeNd+zBQB2BaGGK
	lS69xvu0WuT1gz2MGQpgJy8aDVBG8/+ooXmMoDBEHxZJnyDVBkHYd+aU6xgc=
X-Google-Smtp-Source: AGHT+IHste10cxPyG9mqv8WFeQnkH+P1bQTyx4IgIcFheSjyF52uLH3fgMb+bwRtpxxOaGSwzAAU9B8zwj36DTaDHbiDs7R8Do9u
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144e:b0:42f:9353:c7bc with SMTP id
 e9e14a558f8ab-430c5209537mr265300165ab.6.1761142384499; Wed, 22 Oct 2025
 07:13:04 -0700 (PDT)
Date: Wed, 22 Oct 2025 07:13:04 -0700
In-Reply-To: <68689a02.a00a0220.c7b3.002c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8e670.a70a0220.3bf6c6.001d.GAE@google.com>
Subject: Forwarded: Re: WARNING in driver_unregister (2)
From: syzbot <syzbot+6616bba359cec7a1def1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: WARNING in driver_unregister (2)
Author: abbotti@mev.co.uk

#syz test

