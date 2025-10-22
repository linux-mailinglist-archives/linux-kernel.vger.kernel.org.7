Return-Path: <linux-kernel+bounces-865962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248F8BFE6BF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 00:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F1C3A4C7E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA001D798E;
	Wed, 22 Oct 2025 22:33:43 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F32284672
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761172423; cv=none; b=NG2iPLGB3FQJhUoofuJtsCQ/qDcaFvYq6o013BlEUNz7dGjh99F3u9rJc7EmZAlmFXQuIQu872xbkodAl47AAiX0NRS1z4wzDmNk98j3FDNfV0662sSF56L4vdwxcIyn8TLIX3C/oIA8lAw0U8vL0BG3e/3rGUakFPmMz15w5wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761172423; c=relaxed/simple;
	bh=Y8gMb8z2vBf2vy34p+idRo5aoEWGiyBFw26ZcIADLa8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Apybvj9nUfoJK0Qd5xnzshU+nfT67f/qyLFZF7m/7Yfu5yRLnOHyrOcOJnJurpCFx9O6ecqJJ6RLV25Uf1S27CmN5R+ZHQ0ArNQWwB+2e+uRJ/oOe+ZdDeJGf7y7GCu01rZIn7PoBxxM4KN/fGSvtlFfpHuzsH4x3f61prFWGn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-940f98b0d42so27327239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761172421; x=1761777221;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8gMb8z2vBf2vy34p+idRo5aoEWGiyBFw26ZcIADLa8=;
        b=W9BtuAwshAqFaGAHNJ2+YOFgiCEfFIDYWAMS01eZ2hmesvhCDjNi5pMk4MSnjZFGZc
         2gOkj6a/erhIC1jz8hpi5WkklpgjvzKMBR4k+zp4nvZLL7J6wY1ooBczpG/hRrb3hBNB
         uSLjTfSsms1A/RAn5hbWe+4Ej3d2r7/22ljeQ+I37aZAlitJOHOpDnc/Fe0InBhwBahE
         iUiARs17NTIVxVOzKbsIyOJ2u+dY8Sw/VFuO0BqMcBD2CdpNeblFe8F48eTBaELBrJxE
         FcylOdf4yl+Hl6kNT/v/EsI41CGV12LhMzAPrGkG7tmtENEZ8GS/EQ5MwNZ1xKE7uAzu
         gEtw==
X-Gm-Message-State: AOJu0YwK0KlJLKLdURW9AZSEVABWRcfTBIub9Z9uqKTm7z/SxmAj/hK5
	91ZUnOiqz9s8tk7m5XI2bws/RCsRGK0ySDj5jw1zRVztbhS6nhpS7hZoWYuvd3r+V8oBhDRS94z
	lujZ+1rWGzYE1KW7Rup09gLFI1JhBBhAO5AtLpuiFAAcChg1mSoq6UUku7r8=
X-Google-Smtp-Source: AGHT+IFxBcxfvVDAurlmP35krR8cwfwOj3E+k+HQLWqDlaOBgBQ4gOgn56hcTcMs5IOQCDM2I+V/SelA+JZCo7M5POJu+fEu5cGf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15d4:b0:93e:8a49:6425 with SMTP id
 ca18e2360f4ac-93e8a4966f6mr2676365039f.4.1761172420789; Wed, 22 Oct 2025
 15:33:40 -0700 (PDT)
Date: Wed, 22 Oct 2025 15:33:40 -0700
In-Reply-To: <68f6a48f.050a0220.91a22.0451.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f95bc4.a70a0220.3bf6c6.002a.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [gfs2?] WARNING: ODEBUG bug in gfs2_fill_super
From: syzbot <syzbot+19e0be39cc25dfcb0858@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [gfs2?] WARNING: ODEBUG bug in gfs2_fill_super
Author: agruenba@redhat.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
for-next


