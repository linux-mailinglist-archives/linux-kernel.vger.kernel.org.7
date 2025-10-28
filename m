Return-Path: <linux-kernel+bounces-873222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F975C136B1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4C664EC9E0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E0E212566;
	Tue, 28 Oct 2025 08:00:49 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1914A32
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761638448; cv=none; b=EvTdPOUq5OLge/08nwCsZ0EzNfwFLUlJXkJcGqW3fc3ZQuULTjFDrx2v0JFOssWzjdsClIfTCvgj0eGOBuqWW4EsWdY4gJ4D9MsZvJTPm4T66czj00v62vxmsTh4gnxg0fuHJqJEFqx2D6PHDerUF3e9UUAEAQGJ+2PGgT64sEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761638448; c=relaxed/simple;
	bh=n9ZQGorPCL7fakg4rIcDvn0bMqSs/RIGXRzHOexBJAU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=oAM9shH1Pp+oIzGcKG5+VFIn5LQiBrRxNFz5BnN7lRvCxCnW+UfB/9C3sYcogDzZHsKX68jKx5UrXwGJ71ENNHVVATQgfalyrv/J1oddZAMzZYi/+rxWxnwYJV86TSFPYy3Cz1aPIgXYLBwQ+QSaagHbN1RnBaHVlOdGtPU9dRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430e67e2427so75557335ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 01:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761638446; x=1762243246;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n9ZQGorPCL7fakg4rIcDvn0bMqSs/RIGXRzHOexBJAU=;
        b=WIAcqZszkhMDtQXnXtwAtE9tcWD3n7TWPFu7mdJOUYwlpFCxSLX8mMtZO0YkwNvQAu
         FcNX0BNZF7WYVVmszR6q1G4pS66ZsDuJx2JWRfHS8r7Za/i5IadBHXkj7L2cNEYZIfUp
         WixU8QFx6lEe+JlEykMWVOfapYmqQIXEgixtaweYJX/3D2EfvySOMmwnFWrWNqRygd81
         bFU/eTvn8jMizxzgT+O3B2dnqpy589yvCvQWMx+iA+FLPXSqOB2Zj5CYjQFcNnTxGMF7
         KGhuXikJgcaNYPvcxFhlXz4OojMMRxj+pM7QATCd54CRkZDLlStHua0xp9YG9Hxg8dXJ
         oa0g==
X-Forwarded-Encrypted: i=1; AJvYcCXyhRpkoZdhT30Ng+f4+pcefiUwFobU+djYIFtrMF9eKBNVYMeGG5RL9nWy4vTLt7/2EMKB4kVMuC/fV5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy836CemLkvSdQ8KWvfEEaHGGiGeTtgD1r9Eg2Lw8VVhTQEG79D
	cJUFYpBPaGhZN4Cn0oxABS6BBRFSFr3FEWwr1f7mRenkyYGcyaro15u+ioMVcmjzv2EtKOgzZd1
	2+MrLG6owxAMq2MWRaMMdJKENj6NWVGFdxvIzsFxZMtDnOwNOzWpRoWQwYlU=
X-Google-Smtp-Source: AGHT+IHPScCVLrIAND6OoYHP0v4m2ihrEnlZoY6bhrYVH2dnHbkTScPIh4bmTKihAu94V5Z1sfQMEVjNt8MYJ74yg2wX61ydOkRQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3787:b0:42f:94fd:318f with SMTP id
 e9e14a558f8ab-4320f6ca7b3mr36302685ab.9.1761638446543; Tue, 28 Oct 2025
 01:00:46 -0700 (PDT)
Date: Tue, 28 Oct 2025 01:00:46 -0700
In-Reply-To: <20251028080045.394850-1-junjie.cao@intel.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6900782e.050a0220.32483.0139.GAE@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in pc_clock_gettime
From: syzbot <syzbot+c8c0e7ccabd456541612@syzkaller.appspotmail.com>
To: junjie.cao@intel.com
Cc: junjie.cao@intel.com, syzkaller-bugs@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> #syz test: https://github.com/Junjie650/linux.git ptp-gettime-guard-v1

This crash does not have a reproducer. I cannot test it.


