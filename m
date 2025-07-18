Return-Path: <linux-kernel+bounces-736699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1130B0A0B2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F3047B1580
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCBB21C177;
	Fri, 18 Jul 2025 10:30:39 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B7D1DB95E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834639; cv=none; b=mfgSjulKws6pUQq2KceNFzYBBl7ctQ1M4DRBk6/UWZiHaC0y9HL7T6RR/fWWp/2ijF8jCugLF2KPI6IGWMtc08RfnV0jWG93mSsgIY8SdtETAMMfPH8obTubcKbFixSh7+D5hmIJWfSeG+7P/T3NaqlrzS3g+4am0sCyOEBTj14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834639; c=relaxed/simple;
	bh=Jfy+813P5sUHYyLJPaQ3rH1oP1312It9JFN75GQFnRc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VC/B7XZbMJS9JDzqmoi4gMS0B00Qi3LuymeS+CtOsBKGrbkb2yd3JEe29Sq1Mzt+4SrGWGQLRtTm17yvPW/DgErtHwNWjHQaPvM5Uo2r/PJ3dYnGW1bf8XMLUXmGGi5zvlkVPkSzg518XC4w7Pr6M0tb6FUjiAfPf+Z9Q7XtJA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86cf753423cso179711339f.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752834637; x=1753439437;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jfy+813P5sUHYyLJPaQ3rH1oP1312It9JFN75GQFnRc=;
        b=v14SBYc1eh1WEHdzqzwFjnTDesvVv6Z1M4GQLWGJr0U0Y0t0xfAMFTO8LHA7LPxQIR
         hWv20zlFaXDx/xV5La+izHJy7dEB0nuH+Mc8xBWPhw9JrppHzFJhTgDX5OrQbhKzNcNS
         IQXZ/dm6QD9JgcY11zNRPagJrbmdSKQ0odHl2egoWyRN5fAyjOM52/ivJlaLUrtlL4vZ
         XjcqTUqKz2TKfHVg0UA4U4Jc34EDQZUBSRfIzExhA+/0cqdMCg/G05QEha7Rxb8kjQYI
         9pSRpwyxJCWeMEqai4nYFtlUJACSOmnHnBNPF3jhLh0JI34ge0I1rgR8kDSvVqJitcj3
         TiYw==
X-Gm-Message-State: AOJu0YxPTlQrbqZTVvlsbAEOQPl46llk6KHYMhkn9bJ6CS55KcD162Gi
	tEuUZcKI4fWrZQEDkE1mINAkPSAHbzuCoHb15CJR5WeewEgtAZDL87cuGADVnWGgeIEt9wtW0+T
	sKoCaUbGwLjGlowrru+j0ZcePspf+5oZxhO6jvYXUVOWhqAq1uleLzUuPWY4=
X-Google-Smtp-Source: AGHT+IG4MOcAbM5SENlzdvLJCW3lHvpWcWNaD91l2lCLVKlVCZyWYNcJDFxriHkMsaHkpLj4sBMUGpnvTBeeL3DJNImnuEFpcUK7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:c116:0:b0:862:fe54:df4e with SMTP id
 ca18e2360f4ac-879c28b1addmr824413539f.7.1752834637073; Fri, 18 Jul 2025
 03:30:37 -0700 (PDT)
Date: Fri, 18 Jul 2025 03:30:37 -0700
In-Reply-To: <68799e14.a00a0220.3af5df.0025.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687a224d.a70a0220.693ce.005f.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [netfilter?] KASAN: slab-out-of-bounds Read
 in nfacct_mt_checkentry
From: syzbot <syzbot+4ff165b9251e4d295690@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [netfilter?] KASAN: slab-out-of-bounds Read in nfacct_mt_checkentry
Author: fw@strlen.de

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/fwestphal/nf.git testing

