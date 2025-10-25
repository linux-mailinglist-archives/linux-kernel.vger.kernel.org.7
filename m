Return-Path: <linux-kernel+bounces-869940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3474FC090B3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 15:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B40EF4E107B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 13:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9822C0F64;
	Sat, 25 Oct 2025 13:15:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F742116E9
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761398105; cv=none; b=GIQioGuK6aT9PQc3P+UiVn6Z2R8H+3w+aZ/DSG8cq3hSCVg/iBhH1U1hHzAfxTXPJ/kKnHw+bCMgYXbO3NuK3alOcg00UNGwQe42VBCfckk/xylcWw6Hd26hnQL1nvyP7xImrAXzLL4ToEUBPGHVLfceyAmaJ49qp/Ry8NrL9zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761398105; c=relaxed/simple;
	bh=VM8Ejy377V0wU7Fa+ONuUt8iSUwRD1Aomwe6zvDITjI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D9CEuZC1kIygArxEvXNLkeaqPsbMv1FaVSZCSpSNHovdor2njD6SDCV2+YzQYsj13ePF2/nFvCvCmK9C+UB4PPbXNXu6jG/NA0sFXMb7ZlY8u0ql0CSYQj0CGtFNLy8DUCJ02c5gxvU7VxLof5Zp3heGxJgcmi2alDs4f/LjWHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430afaea1beso40082485ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 06:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761398102; x=1762002902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lq56I845xq/Y12jBGmUt878nhCQiCseEayYM9Ay70+o=;
        b=CrTh3C4XZQgjP2Wd4fYCoYjOHyrPXRwvLPFYPw255inOgnh75VfnlXvBtqgLpLyrX2
         AVda74LMywyB8KKRKI/bjKQi0ulkZkedw9G7E+hf+CT98dOK1LlJsBo8Lx8S/Tq0qYT6
         QY9caYJCQGs+a1lrTRlalnut4HIXxUuav/qFviAWLnRrRPZxqC0om/ZFkV3FXfIZt4aF
         SxCVziq+F2hT0NbVfkNNU4WZhk3KsEvEsTr7rZ7fza9carNNBpoV1jlCxUsCiTWtYvD0
         so95DNZMC2p6dBR3A+sne1nSRx/ETW2eG3S8tUkSTPKBRWZRu6s9FOo56NfDGRQRWzL0
         PU1g==
X-Forwarded-Encrypted: i=1; AJvYcCXbWHrm07RKJJKbwQ1aONXMkwtbZZR9CitaTb1qUwI9NwOaZwRGsrROvjX+0UrYNHf7CeKTqxcjGaGttTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQc6B/UjQPIzBLJu40NJsx1vNv2bUQz9U7AQ31wUGyhcZ9SGqR
	ZEj6ox11jtn3JXw0ItXSS0zm+052L2qsGxRYdNKAODqGFG8zz66hS99Q56OtwxL9YxBUgepg8TC
	31i83bzL/a8qy84PD5inxh/b48aX+wm1LD485dGToX3RA0TRUPsVv0YenDMA=
X-Google-Smtp-Source: AGHT+IGPmmlMHkkmVs0EnCnUS2h54DmorGwjGt/fcuBxxpTEk8HqQLrdrnwlTT6ISykfT2bn6sDe/n8A1CohiVo2Zdg4cjuIqWUd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4405:20b0:430:c553:752a with SMTP id
 e9e14a558f8ab-430c55375b2mr361777925ab.30.1761398102193; Sat, 25 Oct 2025
 06:15:02 -0700 (PDT)
Date: Sat, 25 Oct 2025 06:15:02 -0700
In-Reply-To: <y6cshcj5anakdq2l3yq43febnftvttwjvoeounl6pincoayhfc@fjiiuk6ah4tt>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fccd56.a00a0220.1c5a1.0002.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in raw_ioctl
From: syzbot <syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com, 
	krishnagopi487@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	matthew.brost@intel.com, rakie.kim@sk.com, syzkaller-bugs@googlegroups.com, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/usb/gadget/legacy/raw_gadget.c
checking file include/uapi/linux/usb/raw_gadget.h
patch: **** unexpected end of file in patch



Tested on:

commit:         72fb0170 Add linux-next specific files for 20251024
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=e812d103f45aa955
dashboard link: https://syzkaller.appspot.com/bug?extid=d8fd35fa6177afa8c92b
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16ea4be2580000


