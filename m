Return-Path: <linux-kernel+bounces-874667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E2EC16D01
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733A81B23CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF72128643C;
	Tue, 28 Oct 2025 20:48:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F34749C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761684484; cv=none; b=mfBn32E36QtjZrhZPb/6jwFfqVOTf4XkzeISpKBGmQ+J975viWDkAzE1+asbM5jbgkY9Q+UkYEWTBEXRzbyDHKqIPfBbNaWsjmRpIc56K6wHqVDupR7UT4kmF+YmTaxLG1RBQ86w/HZMfw8nnNNU167wb+DPqdx7eI8DMKsdL5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761684484; c=relaxed/simple;
	bh=ckvBcyzWzn/yWyuauvfzoEllDql6JxZ9bAS5pkWNHNI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lLBSTwNDgsjfSOKyLWrE5YasYzATM0VmVHCE7bUUPAQjXoLwV9HPzrBCiDMqRqt1RvX5LTSq7D+StUcdcPAJEN+uTf+VryrUe839a/GVIr67wSUymHaNUoOYPmESPI2DxYHylyASDndVnVStnm3B0X0gJ97qkox+Re44NOR4pJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430d83d262fso255932255ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761684482; x=1762289282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEhHWHgd5l+xijAy1BZ4PiBfiRBsFec85tw1ukkZBkQ=;
        b=MKH7DQ+O3jK3GzSJItkbPJ3cUQDMJcp+ueLQTPol7GaazqcvljA9OhWvXP750R5Dok
         DvMZD6MPd1iuPfoLkQ8ibMgtDw8+FimJvNFfKx1+vNex6gDqZKMPvRyeO6HRY+MAryNV
         lY8u+Z1rdmsC79SRnJath5dvcqhssQz40uIiZfKppURr9/hSmHglCiYNMXb/zfRz+znS
         AkbwPUYSMW1JlmsuZO9FeUOTOIF5RAPlVpFOEcWdlN09p8WaDp+eDOfxbkXy9Bnw2jyM
         wJShK4BRDI2BHD4zhvxe4ihogDblW90Tken75mnjptgASD4Iyj8sRT07opJt8ziH17gX
         yvGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFeiVxMYAiO2oN4gCFdjtwG/W7mgJ/GdYwhtZ7Fv84CmNMhqInCypJBpk9wG364de6qG3p7biOm8tydBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx31RiadrS/pqNJ8+9a9vyXVlQagIwLZbq04vrotUooA4crm/WB
	75Lci4G/2qBsAI4M0Ju+Q/r/eaYH5kgD6iVe270UaxrdIaTipKcL4m6EdKp1glO+txL3NcAWJ7z
	ijTQrAspqMrLzR943uPdZjKivPgnaksg5rPrpuduI9OfPNRoapoXMELu87AY=
X-Google-Smtp-Source: AGHT+IHpiE/cPmWcAQrOh4IMsZFYQqETWbvOVvRSTFnZsgmCe9MMpZPwnFvvjC/1iDHmbW3eiUeWdNnDxNA4ad1bSfSNVEVD05tH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2218:b0:430:c477:fcde with SMTP id
 e9e14a558f8ab-432f8fc7f74mr8639555ab.1.1761684482144; Tue, 28 Oct 2025
 13:48:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 13:48:02 -0700
In-Reply-To: <20251028182104.36i6Z%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69012c02.050a0220.3344a1.03ea.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_set_new_buffer_uptodate (2)
From: syzbot <syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ocfs2/ocfs2_fs.h:472:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:487:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:500:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:644:26: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:657:16: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:805:37: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:941:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:1028:39: error: expected ';' at end of declaration list


Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=7aef76bdb53b83d62a9e
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17d377e2580000


