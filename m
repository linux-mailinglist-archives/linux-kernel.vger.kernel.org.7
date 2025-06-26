Return-Path: <linux-kernel+bounces-703898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E74AE9665
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 08:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88AB63AFA6C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 06:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE9D237162;
	Thu, 26 Jun 2025 06:37:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A77313A3F7
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 06:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750919825; cv=none; b=VzfFwKN7f3XDkSQSNQOOpaZUv7mNeAVFfdC2HxH/46pufqMvCMsNuRQ49GgVBBWOLDRQurOwS8c+21QryJCOSXMdA+K7UIG0v1uva3I3s1iIYZTz+HhnEo1qR5d47bCBn5ti7hv2e6OQGnZbmPAsEtgudQ/KkjRWADAtx4u+Uec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750919825; c=relaxed/simple;
	bh=DmuZkk1aCaprzdgt06WdsoPZO2TDGaBAxPyIIyEyEVU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GdEv4jAtCnNJmmJMLihwwEhaQcOxE8vSWpZaSUJrDnVxwVr0K07EjTP7L94QUx2mSXyAOyJnBbwTqwvhlVxzehxD+73iA7Nw8UOMYgQmvSBTYar+MvkYK2WP/KXpzfJtC4moX1AxqnW86hQEYtDXkRu0yAE9OrdNQk7acQxXwXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-869e9667f58so135020139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 23:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750919822; x=1751524622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0/K4EnAqNHlkESLS+MpoclzvATZKCXAy/CTRmbMi5Y=;
        b=HRcsFL5gVO4cFlMvRODHdWaw6OsiOZjzqpBrXKu8E4SDljbb/3UNE/gQvaaTC1snpi
         7FEYltkXF+ivBlrJt5kxuei+OXHRzI2x+430FPct2rnl55jPD6VSMM5nWQ2QbKICSVTg
         5IoswySQr4i5pKw5xtpx03D+kx98SxRNV3lA9aeuEgTyWJkPhMNDg8cV+lUHUGfAtU5Q
         JXBikJW0IPvSmnvk5kDsiUB8DU8E9NrS7Aip0HACBIiKiSpzAmm8DJsJxVmFzIH52O+C
         Qik1+xM5xmtk5lOLljLn5N5WuJlhvp64IbtZ9Vc1E4tcXyFnl5TILD+c7bUkP69ePaOS
         BwHA==
X-Forwarded-Encrypted: i=1; AJvYcCVclS7T6BCxNkfoSx5pxwBpfDjUqp4cEFq4c8heF3+sNyNeC3fme66TDCoBFf73gfpLn6sMSF+mEODWa98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3yM9F8KkcUScSaDI3+ePPqf3eGqdIqcZ9fsg6q/iDJWGm71GR
	LHYhz+9wH8rwyw73MfEwL4znXbv/CimwtM6OXaQ33gEvaAHEQR7pnW20YsBx3cwtsd4g24vMQEI
	sjysc7kN2hHhtgmEfCLD+eOCJR2SGDDkVi9Kz21/GhJQ0zgNpebHjuA99odA=
X-Google-Smtp-Source: AGHT+IEXxdtHO6gaP4rtT5q9QpCHzaC1rJufXe13EVgrskRPsRpqgUeCD/yNdu9V3Mb917yfLhWq7vRYsfbwLMgYyDdrVd7r4zqG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d88:b0:3df:3110:cc01 with SMTP id
 e9e14a558f8ab-3df32a123c9mr74691965ab.19.1750919822221; Wed, 25 Jun 2025
 23:37:02 -0700 (PDT)
Date: Wed, 25 Jun 2025 23:37:02 -0700
In-Reply-To: <197c44ef-aa46-466e-9381-a0edff657762@gmx.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685cea8e.050a0220.2303ee.014f.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] possible deadlock in btrfs_read_chunk_tree
From: syzbot <syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quwenruo.btrfs@gmx.com, syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/btrfs/ioctl.c:5417:1: error: function definition is not allowed here
fs/btrfs/ioctl.c:5430:7: error: expected '}'


Tested on:

commit:         86186e83 btrfs: implement remove_bdev super operation ..
git tree:       https://github.com/adam900710/linux.git shutdown
kernel config:  https://syzkaller.appspot.com/x/.config?x=58afc4b78b52b7e3
dashboard link: https://syzkaller.appspot.com/bug?extid=fa90fcaa28f5cd4b1fc1
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Note: no patches were applied.

