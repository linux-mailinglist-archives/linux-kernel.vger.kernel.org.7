Return-Path: <linux-kernel+bounces-875498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8C3C19364
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2F8D58789D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C3F324B0A;
	Wed, 29 Oct 2025 08:28:10 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1C631D399
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726489; cv=none; b=nHn5mDxgTZlR1mpjmYH4nAseR6HjN2bMZNAA5BCglxD3aoRRA5dPcXqAYcmADEefS/mvEGKHkNJJABM+EwzJWHfBnHgxixkPwCGoUKmGCvLFhoNS9EVrzU607ZMEJIDiy6wilg5MnTiFc0TRRlVZx5cA0bqmYd/3l9iCWnBq4nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726489; c=relaxed/simple;
	bh=mIgswed/E2wpTIiSvcvgQSMBzucT5AMHZenlCFvI/Yo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=J3ePvPz5ovMtBJ9cxHw4fxvrIA03intMmQgwiVxkeOXuRTAaRxFzw4HNJLsBmOXgf8k7me0olrijegwGpF0E7efQh4HZS/L43gBFZ3AktWe8otyrkZ8EzZdSf4VT3Rs4OSKg3e4PX4fZYhjc9g1SzcPM82s7R1WZu5XDVxhJBfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9228ed70eb7so2104810139f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726485; x=1762331285;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfVYEBQoLV+MU4H5DZe9yM/NWN8GZHTc80msAHffpxM=;
        b=nU6awGsb5T1v8MABnF3xSul56t9qpGURyEEcUXlIwfQTQqNaeM5d81qPx7vERCMJqC
         nofXzdKr1yaXuStKazeYJdqMZBRAx3KDKYL7QNQ5hk675f3q2RYWO5jzfgD/r+wcWl4O
         ax3lSV1vB8132UAOxnKuId+/tsiWZ8KKm355g+IqOoNjXuiEbpaWSkw+AVgJ1+JAfx/j
         gU8KzfBy+JrOtEZ6ssjumtsxn/Tm5X06ahyKNQxG97ulpt4RBuSt+BOxlCn5JmcyRd9N
         Obf2Qscmvm3t81Cjl1v/K/pMdR3sabdliFDYjnu7HKTrzvyH3FsVhqOd1T0fjzC+UkAM
         W2Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUzMor/+eih2m9Gh0apAWg3OAZKTZtmondcx1iI26l21i4V2e5mmg0kAODBTueg5d5NcbhsJJcMcq4ZDmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRVSjnzuX/NeByytQR4n4Rp+yT3lbty+0u/pC94g9nkdRHe5Al
	SZXpCqLqEx3bFcra/RvZG9xgtxgQYsK5opstErkiI6cD2QM+PbrABIYwSkuu+uFNGVwsVyaNKvI
	RSTN9PVOPHFYHDk6rxvh9Ky87nzvhCvGdT42AiZoAu13tFf7MrRWjQH9IYw8=
X-Google-Smtp-Source: AGHT+IGK+SRLLivlGqqVB0LBhinlkDgF3JousKXaHPGUiXoGzSN3AAXQX2ppo9UibDqM1Dxw/ozq5BqSZ0Ml6KL8oGCyJVQ+nFex
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b0d:b0:940:dddb:701c with SMTP id
 ca18e2360f4ac-945c979dc7fmr315726739f.10.1761726485427; Wed, 29 Oct 2025
 01:28:05 -0700 (PDT)
Date: Wed, 29 Oct 2025 01:28:05 -0700
In-Reply-To: <20251029062741.W5kof%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901d015.050a0220.3344a1.0418.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] UBSAN: array-index-out-of-bounds in ocfs2_block_group_fill
From: syzbot <syzbot+77026564530dbc29b854@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+77026564530dbc29b854@syzkaller.appspotmail.com
Tested-by: syzbot+77026564530dbc29b854@syzkaller.appspotmail.com

Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=174f6fe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d75e2b3488f52930
dashboard link: https://syzkaller.appspot.com/bug?extid=77026564530dbc29b854
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e3dfe2580000

Note: testing is done by a robot and is best-effort only.

