Return-Path: <linux-kernel+bounces-839779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D293BB2659
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 04:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2B14235C4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 02:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4910D157493;
	Thu,  2 Oct 2025 02:50:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1063529A2
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759373406; cv=none; b=MvEaNIG55eY0ifE0cZD1KR+HRI8cFxO2Qyop0TmvuqxhZDXQBlVfzaHzvRZvt4yPQlExNkfc6MV0lc5TuzVelK41KkEnB1nzRgzphkT9djoaOXvMV+nF+qg9c7vhjI/msnwKP+Q5JDvMeh6e+gzq3QQyt9ytsoJaFgqsvhciYzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759373406; c=relaxed/simple;
	bh=ZLrqAaOBrvnI4r3szYnFj1I9UP4Tx3OqwNedANk1biY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PTWqNQiqWIZUcUD3+usG0ESOz6gblQkZELuCGBQeTSOyKnPdj5pUIpcGaCmZMnFNR4O7WmeXNq0/2I5+AiDUdkuAGvdf5khfTn9edPX9GC1T0zWrFx79UKuzqqfnvhRRGqQB4pv21fGXg+SuKbFFTOy+ZRHqw10daOmS9plzaWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-92c4374566fso40451239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 19:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759373404; x=1759978204;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXkCYyVq+Ok8Rfz7LkQRm5taj3jhnYdzLypCVreUpOQ=;
        b=p9Gjdz2Ul+kXJzGySIvnqD70C1NqWhk1xVGoSFUpjKYGVpiHy1QiBy07nedMppahaP
         FOrHdxpUAture0JFxb0jiPjWDxQ52Yh/UOmQXk/InPgg+KpDUjZfCHU/9EtCpz6IPmti
         dqcwYBvE+3smyrJt25umPacJcTjeXpnmmQRgwMuXSPP+wbidDMy+m7TC/t+Vwn10ifKc
         wh1PE1Zk9YHUK72M8MC4+Z9WodBlFrYsPuGz2aK0GBLogvJ3+36iVpU2f1O8VzOCLoKg
         a8fFU8gMLSvyWbvmRI06tOTwuo3qJ9mPXy2LpZisj4+EexOB+92jFHEfTGD4FpKItQ1L
         mgqw==
X-Forwarded-Encrypted: i=1; AJvYcCXluLqeOWMWDO1m77cKb64/1kXCVdrQWSJThAdEM3D3Nxsem2nwem/xcbkn1goaKkCjGtq1dyrD7BQUO44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy10RK+EWX62T54dvLVtf2+aGPajSpomFMlUFaf2c/jGaAzGks/
	JBqE9+4l5LUUEWWH2UeVIc/0SG1jninSmy7LHKUFpiA47xDW1bmAk7H8mTcJwTiKL79pcjzxNCE
	5PUi1zrt5xxxXJAYteuklwhnspeisOBzmNYCmZMUPi4k9qmUQ94oDMa8YIYA=
X-Google-Smtp-Source: AGHT+IGr+AJiP1ZEZ27TFDXMlUXIf41qC4roBHiJek7Cv7nZRHTTs9a8+sccW0Tp7nADTyHqjW7I5EQfOoNN575UDOJAH5EEpW6x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c82:b0:938:9f22:ed34 with SMTP id
 ca18e2360f4ac-9389f22f4c9mr566606539f.16.1759373404188; Wed, 01 Oct 2025
 19:50:04 -0700 (PDT)
Date: Wed, 01 Oct 2025 19:50:04 -0700
In-Reply-To: <A4321695-9F12-4C7C-ACC9-72FD84B6DB2C@nvidia.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dde85c.a00a0220.102ee.0073.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
From: syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@redhat.com, jane.chu@oracle.com, 
	kernel@pankajraghav.com, linmiaohe@huawei.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mcgrof@kernel.org, nao.horiguchi@gmail.com, 
	syzkaller-bugs@googlegroups.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
lost connection to test machine



Tested on:

commit:         9cfbc23b mm/memory-failure: improve large block size f..
git tree:       https://github.com/x-y-z/linux-dev.git fix_split_page_min_order_and_opt_memory_failure-for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=118ae05b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=714d45b6135c308e
dashboard link: https://syzkaller.appspot.com/bug?extid=e6367ea2fdab6ed46056
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64

Note: no patches were applied.

