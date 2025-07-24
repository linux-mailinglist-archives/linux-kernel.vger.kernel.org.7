Return-Path: <linux-kernel+bounces-743642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1792B1013F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5225AA2F6D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A77220F23;
	Thu, 24 Jul 2025 07:03:09 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6B31F2382
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753340588; cv=none; b=I+GZCpk0AsFc2YcMAKP/IJ6pTRYbK82csdQH5eH8h0Xr8kuLw+b3tLAEEQBHAEWCOUflcTLCJhk68fy92XY30e9ByAWxNxEGtv/YP+nA7yQCfNmWSarBG2nXI1A8X5RVShgRYwflIh/XwNGIOWq0K0rWkY02H/LSCUg9Hg80smM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753340588; c=relaxed/simple;
	bh=YOyODkHGBO9vR3EZYlRl3PosD22drik4E0pMEj5dKHs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IwINMjpZ5lymdEx728cvjgvYaujXTOd9Z3Xi/L6J/zydSsKmLRIiLV4IeV5A8c7zEiM7JRedhhpAghE5UE1iAIGhpsk6To72YIGP4WYwFPXIdvoWFqAj8knrkPUdH4M7Tm7PjUISGYfw+25mMduNlb/9AR60bXnknnUz476MtxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87c18a52977so74225839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 00:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753340586; x=1753945386;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQWpXqGPrvVPEsI1/rTv2fKt73p+91t9xYJ+DrK/fHs=;
        b=FESkryHXpZYOkO1qvenfV3BCFhOrXs370/7hsRac81Oycmfsh2o5bejxsLRIlroQ+5
         NRH/vVzCsNgYGhGF1xJZ+8RPVRuh2h4Z28GYIL2Lz9FIT2WGArLtkHmq7K+3rX4o+uNn
         yRjwBhZnwIVwspDQhn6i62quMqScHriDmRBv3GfLqlv4C8NOj2n39rauwIZTDQ22/CuM
         FdmKPnVYATDCtABYdXMXJ2YP3+aXkKX/eRYJ+tqHMral75N/QLFoAsP3ZwVm5HjN2lM/
         kLOdSGoLObX2c9glK0JzoWq/7fBbLfcaa+jcH4eyne9AW/X4SfLmMl3CwXA/W236kZEo
         82rw==
X-Gm-Message-State: AOJu0YzL+rXzKEHoaNCaMNIrjOoCmBLsOP8ERSl0myqKNSHHl4SbD9F6
	if3udtCHQAkn5ESbThKa+fHezyWKrWOlrV48CJ0Lz+saMGV75aSYSDZPyJUNt+J+Z3jI0Ufwed8
	fJjSJ1NZ82Qk/RrGRpflkdjLxPb4kFvqF8TSI4iYBT1fo0eis3aXxJpLhDDI=
X-Google-Smtp-Source: AGHT+IFsUzZlgE0impW8BT0Yj3glS+s5tffWPwoMTK0afSWWOwBqsCk6qPFEBgmSSWigemtV8jqDdAxuXpKvzFB5AM0tg0acpIBB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:490:b0:87c:6d3a:e88a with SMTP id
 ca18e2360f4ac-87c6d3aea5dmr761861339f.2.1753340586456; Thu, 24 Jul 2025
 00:03:06 -0700 (PDT)
Date: Thu, 24 Jul 2025 00:03:06 -0700
In-Reply-To: <20250724064051.431879-2-moonhee.lee.ca@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6881daaa.a00a0220.2f88df.0015.GAE@google.com>
Subject: Re: [syzbot] [fs?] [wireless?] general protection fault in
 simple_recursive_removal (5)
From: syzbot <syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, moonhee.lee.ca@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com
Tested-by: syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com

Tested on:

commit:         3630f043 Merge tag 'iwlwifi-next-2025-07-23' of https:..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=16a740a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=51ebcb9cd994f900
dashboard link: https://syzkaller.appspot.com/bug?extid=d6ccd49ae046542a0641
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1449d0a2580000

Note: testing is done by a robot and is best-effort only.

