Return-Path: <linux-kernel+bounces-866902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D067C00FBF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8433B4FE13A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DB530EF9E;
	Thu, 23 Oct 2025 12:06:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3272630DD19
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221166; cv=none; b=VDL0AxauOk3sFAoNt0E7ocvu6Bh8KHL6esma38jntOlL1v7RC4occMF2eJ/szhOCMfiLpqEFL/vcUfowAzu6Ut3+lVaQGgV/Qkzq6kMHXssXQ25VusOVTuPrqkZKWimX107GzOsKknsYo5g41lr7WqjRhcqnD0zF2ylhgrndXec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221166; c=relaxed/simple;
	bh=bKrGhzLLDd3ycwNDxUuk1+hAXVHdvyCWGY6a33DSkKI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EowJ3S7/c6m0dXOT7uTx+l2ATF+bODikFkRGZXyJ11HXVDXqXSHz2fC+pjrcZesDf433HFrwvR+7jCX7rzklaxn4hZJuAeY0riYD6j/NfqY1KtB0E4fAy2RmwKUDCEdRPrsVDOStO7mZaAxrhNYUpuCnqTYvjxfCDh1u0TJDroE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430d0cf9b85so31776875ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761221164; x=1761825964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKrGhzLLDd3ycwNDxUuk1+hAXVHdvyCWGY6a33DSkKI=;
        b=LtaP4kh8x9rFWoYaLfYaUhFcJW6qyKcoj4+w+UxY5IGWoaaNbN8G4cEXKfO8zeUDAA
         J6mSlVeLbSZKOg8OVKnWWk9SjoJZh+2fzCre4XUCxkYhpdius9zWuiOWrT34GGIqpN3P
         GaEZ3ij2SItu3t/E5WKrH2Z9zqYUfPB6/HNlBcy4aMc3KPoHAwVskJaYEAswsb+RpAV8
         hhsAwV4Uj1bVfPM17ASwj6eNBs38F3CYFGR8EzQrDo7DjMKw7qERwNW+kWbBkNzIFeu0
         L9CZl5oT+IDUo+iRYHUl37x1D+WTWUAeYBpGho6B4eiag45YCEngt0EScEof//SI9uka
         ktpQ==
X-Gm-Message-State: AOJu0Yyiue1Wj/c9VXc3X1A32OyCgOEXXhwjEgepo3wpWDOTgCmVS+Ov
	7whrTKLKlad2CrxbdZd6jTQbbssgUxrvVenOouRN7DT4SHl7zs/d69N3YmwKemn5qUgcfucehK9
	BlIRM0AAY6VRvRsMXH/GdliW9ZF55ZdRma2UArvYJkuCNxfksWCzVxPhEKFQ=
X-Google-Smtp-Source: AGHT+IEnUuQnFlf8+qwaWKZfD0xcZhIWBr2CmldCZbjLLYWwwRhHygHED6bxKCba9Ln8ZXqRFTTbfLf2WnSSWQ3giVwN9CzKzw/T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168a:b0:430:9f96:23c8 with SMTP id
 e9e14a558f8ab-430c52507c1mr335429765ab.14.1761221163894; Thu, 23 Oct 2025
 05:06:03 -0700 (PDT)
Date: Thu, 23 Oct 2025 05:06:03 -0700
In-Reply-To: <687640c5.a00a0220.3af5df.0004.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fa1a2b.050a0220.346f24.0079.GAE@google.com>
Subject: Forwarded: invalid
From: syzbot <syzbot+1bcef6d2f176c7d376fa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: invalid
Author: pimyn@google.com

#syz invalid

