Return-Path: <linux-kernel+bounces-747987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215F4B13B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC0F3BA278
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CD0265621;
	Mon, 28 Jul 2025 13:12:35 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA5325D540
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708355; cv=none; b=nVrV15BVcU/dOR+LahfCL0XEe44fQrxya/Bh+iPNuMqtsus6FW68xYasQHh3kjbxJMwX0AeXm01RfhEcanA4Tf5KZfd0ahSiVd6bxipy5Q7miBHeU6ymMpLBaOvHyW8Fn0KZieBEGQoXncUwWf5ARFiFpoheQGuSX0Y3qkebjcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708355; c=relaxed/simple;
	bh=OsB+rrQdIrdZpdXP6h5I3YpAgHNUTD9dLhxvBFqOM3A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lvbuncQsFpg833v8cvmr2hGsAtNYZaYt2vvpCguUyrFeRv7v4zl4Z/8oze1zpxWqFocrS7V4yQQONn1UhDEtQVjjTbJUbQWxh9BL31hzdhXgv9OLcx53UWNjCd6A0pFa3oHmI4FfE6DFYpjOnYUnYinyX3MURK8py6+DzXahSLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddba1b53e8so49700545ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 06:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753708351; x=1754313151;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OsB+rrQdIrdZpdXP6h5I3YpAgHNUTD9dLhxvBFqOM3A=;
        b=IamFMfLMWBI1YtWzTNkZWRsTXBIH1Fh6+FiDS+U4xBRdqi50xsMlmG5rPBrC6BWyLv
         3Qznpc5R0F+wdBDlw919dTEhHmwG2721bO0CBGMxv+Kd+VtCt/ZxSzIyboW2XXTq3iMR
         6ToIY4UZsvWdVDbHyxkwPZA4+o8JKQJUFsUv6Vo01wnnxFIGqVwfBLSa9vINPYQAVR+d
         teQEMf7QK2hhOn89kIwmho0dzoGhB8XLgokb3HykukDunBcHjmzz6/doyPtDcZ/LDbNS
         MrLrmm4omwUmTXN4tyqHMZMD3lFDJwNHjYxTihCX2MSESbjSVvA8zT9dKve/kCSkOzdU
         rVEg==
X-Gm-Message-State: AOJu0YxuNlgfdneNjKsudzqMjKpxfc+QGZwplFKzcqpDbUknVLSfNwM+
	eMdxD4ctZqY0KD88+aib+T33Ix9UMWbXcDCEOyNC0pnkQu6V4GvzAzizyo6aIRDMh5sl72Sx32O
	zj/IdgYlBJ2Mv2+5ux+2CtOuwnUQvNH+mLfpXITw9uJ+2BAzZXrzpudLKrDU=
X-Google-Smtp-Source: AGHT+IEOGg07Jnsuz2tv7gxY+Y2Yi51WG7H3tr2RyLYf2LQFbz7IG7KvAxzNblAXMiokFcfrtKIiKDv23MUHVJQf8aoIsI/v8UFU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d96:b0:3e3:ccdb:6ccc with SMTP id
 e9e14a558f8ab-3e3ccdb6e6emr159970145ab.3.1753708346047; Mon, 28 Jul 2025
 06:12:26 -0700 (PDT)
Date: Mon, 28 Jul 2025 06:12:26 -0700
In-Reply-To: <0000000000009f2fe006185570d8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6887773a.050a0220.3cc461.000a.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [bluetooth?] BUG: sleeping function called
 from invalid context in lock_sock_nested (3)
From: syzbot <syzbot+55cd5225f71c5cff7f6f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid context in lock_sock_nested (3)
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

