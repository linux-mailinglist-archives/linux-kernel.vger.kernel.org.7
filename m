Return-Path: <linux-kernel+bounces-898799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DD6C560A7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976903AF168
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CCE26E703;
	Thu, 13 Nov 2025 07:24:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7226D2FF167
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763018645; cv=none; b=rH+IV0xDUZ2bge1RaSZ7nsrfIS20ZoQAKsL6NYziDPi2/fWXuE8YhVgbq996tDsa2NHLOY969lidVX5UP8KRqrObww9rOwsKUqUgO1eCd26ttbrTSivrJrMFRuNy09bsyoZ3cJPPEc3+uU23R48bUD+wsEGjQfVSBqfcF8Eqbjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763018645; c=relaxed/simple;
	bh=LTKOslVxt0GwzczsKH3HLgx4PRqnfgp189PkvckpDTQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BFRgoaLI7KP4x/99H6xDGP2MmPx3h1PuuG2nucGAoTzpx9pMPI4zQw8g41kW0AaFTxM42dzXF7OFe/PEW+hk+9FH8FqR33VNFX0gP60tSkDRhsXRvjeHAjUMOCCeNIoPq3nk6xLq8TGf+FKN9yNCx0wEosODgnqBgRCgIotjRbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43377f5ae6fso22302355ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 23:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763018642; x=1763623442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QwhD92ZC9+T0AS2viZmXj5BXsavT1B3l8pbL/LjXuY=;
        b=mPURjeE75CyTnvG4yDejyZx/lTrceFf8n1XtwxzjYLZr2HP3IN8V+D0krdpWa0knkQ
         5WN0dqbSb0fPrsjXEuf/3LIugxxd3+O2LooLC6ukMQaVrib/xlfQz4SV+dTsboDtwlsW
         vzLIa0Zqm7zIpr4luJvxYCWcjH88tG1rQU7GaT0khO8QBo+WbvIVnCp+QXa3W2r6+NUq
         hTy9U25t6K95Cfq0xDAROqDhzLcSulKcOhK3DJQOBaQCZNpxboCD3y5iquQ6NZGWQ+fZ
         +qsR+5CPNEuLUfUnYcpQYk/pSHz4boj2VhJVlzCFqpz+4bbGwHVoX9thxeX08wm9P3G5
         kKaw==
X-Gm-Message-State: AOJu0YxaCaBTu1GVvPpWF2lyAKCH452F/q64qhekCyqinWxQu+gW40ZI
	bU91DHenFcx8WZB85p90kQYviEyW9MTWH3Hdzwka+Y5SblxeyEX47VN1osIGqPov7BTwV0w65do
	odDOtdxBTr13L7Rk0lUOVVJEQyeNvHah/KOl768DzzSksytg6JdaQFd001+w=
X-Google-Smtp-Source: AGHT+IEie4G4F1nV1zrQCTClLxYKQv+AMu9ZGr5rcIdTp2aVlQn3yiEFsHjSJwsNbZGExVT16Ht9/bx0ICLmI93jsU5PdXf8Rjqv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1561:b0:434:6f29:6cb with SMTP id
 e9e14a558f8ab-43473da2d18mr84365325ab.26.1763018642535; Wed, 12 Nov 2025
 23:24:02 -0800 (PST)
Date: Wed, 12 Nov 2025 23:24:02 -0800
In-Reply-To: <67da6f4b.050a0220.3657bb.013b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69158792.050a0220.3565dc.0020.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [usb?] [media?] WARNING in
 media_create_pad_link (2)
From: syzbot <syzbot+701fc9cc0cb44e2b0fe9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [usb?] [media?] WARNING in media_create_pad_link (2)
Author: ribalda@chromium.org

#syz fix: media: uvcvideo: Mark invalid entities with id UVC_INVALID_ENTITY_ID

On Thu, 13 Nov 2025 at 01:45, syzbot
<syzbot+701fc9cc0cb44e2b0fe9@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 0e2ee70291e64a30fe36960c85294726d34a103e
> Author: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> Date:   Wed Aug 20 16:08:16 2025 +0000
>
>     media: uvcvideo: Mark invalid entities with id UVC_INVALID_ENTITY_ID
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f0f0b4580000
> start commit:   07e27ad16399 Linux 6.17-rc7
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
> dashboard link: https://syzkaller.appspot.com/bug?extid=701fc9cc0cb44e2b0fe9
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e38142580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12da427c580000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: media: uvcvideo: Mark invalid entities with id UVC_INVALID_ENTITY_ID
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection



-- 
Ricardo Ribalda

