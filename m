Return-Path: <linux-kernel+bounces-617881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E86A9A733
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 10:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF1C1889D10
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 08:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8C520E716;
	Thu, 24 Apr 2025 08:59:23 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2D0204F83
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745485163; cv=none; b=AjTksqfA/SIvN99GBnnHYdefU6wRtv2XT6EzT0UZvFconhWh1X5REPClFNzn4IHks4MPVUunaXN142YxUJcvLfddZ97K+6uv5xU8nNbqZvq8IADdHQ9TsESZH74/OV9054qYSoEKITXRv7tC83AGSDbFwf7BpU77NIUSOvaND24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745485163; c=relaxed/simple;
	bh=N47ykR6NUWtRq4erTcl+KS/Qyu7ndgzqN703DmZda64=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=PQATx/4BPKNK6S0cMJ4rBycZHAiGIz8tt8Ex72bJzIdktoDMSmtPa0/ysWz4yBGCHbBYDSYqP8RyBBSflxoAgqDmMtuYMjrRr8QK8qbQ/sSSSSxcGCUzwwlZvS0s3CEoMt7wv1JZqnN1x7UAbDW0C4F8BqXRTY1WtueRv2z4OeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d5b3819ff9so6077705ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 01:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745485161; x=1746089961;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Z93bCrJfOW43DXKBTDnM6RhhcZ/O5Fr+k9HY7iqBwg=;
        b=YVlktwNLZyCt36tR9UWfUd9BYwPVU0fO4QUC9pKCXja//cXeYK0jBRsKvB1c52Hos/
         H8aXa+3ZGxpUnmrU+vXWy2L1hL5/hjnZqD3EnS+I9iyrBqDdOEqwTfMlmQ5+znlrw689
         lEYlSUQ++tG92JGKqOGnfvkoffX6h8rCb+2SLX4JNp1eBEcy7+YwfgRVeRsWBzHWrIOp
         Nygjqohxto86O1GvimLZNiFVsPQsxUXBz9LSJa0OxQS3SifTju1lEQuuJOvMHLgAPp1s
         yDbJQAYh+cFeFKpDIPho0SJk/RULG1SRgIfahqNnABj5wQrxoVFhhRGO6buTzS1cMtOt
         tuVA==
X-Forwarded-Encrypted: i=1; AJvYcCUyleUmydhbuONHIelQ+wozl6N7KmXAk3IO8khxsMkhjMzf4AODL6sCnEKWWrzXTiiYDb6QyHGQ3hG4e+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzfYreGdOoYhgML9CvrL3qEHtNZ9qKo3Ln0UKBJe5hlUYeumBz
	UkgTuXPjN4+8sffRd+321xoj2AVP7A0YR+gz3g5zNYp22HnrnbCycOMmwVvDquNZ06e/oJMdSec
	MgHhG0oAECLxKVRzljAl0Tat85ewm9DzEUlby49TLB8gYutaUwnrg57E=
X-Google-Smtp-Source: AGHT+IHqxxBuf6pSikN1iLEFp4B9endVU/Hv0sCKywoL7eyZ2dC3aQ2Ce+cuwI38I1xNL696T0xYiIOk2NWvsKszYNR1+nXruKvw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0e:b0:3d5:890b:d9df with SMTP id
 e9e14a558f8ab-3d93041e57emr16671365ab.15.1745485161215; Thu, 24 Apr 2025
 01:59:21 -0700 (PDT)
Date: Thu, 24 Apr 2025 01:59:21 -0700
In-Reply-To: <20250424085914.82201-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6809fd69.050a0220.317436.0049.GAE@google.com>
Subject: Re: syztest
From: syzbot <syzbot+b4a84825ea149bb99bfc@syzkaller.appspotmail.com>
To: contact@arnaud-lcm.com
Cc: cem@kernel.org, contact@arnaud-lcm.com, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test

This crash does not have a reproducer. I cannot test it.

>
> --- a/fs/xfs/libxfs/xfs_ialloc.c
> +++ b/fs/xfs/libxfs/xfs_ialloc.c
> @@ -1182,6 +1182,8 @@ xfs_dialloc_ag_inobt(
>                         if (error)
>                                 goto error1;
>                 } else {
> +                       pag->pagl_leftrec = NULLAGINO;
> +                       pag->pagl_rightrec = NULLAGINO;
>                         /* search left with tcur, back up 1 record */
>                         error = xfs_ialloc_next_rec(tcur, &trec, &doneleft, 1);
>                         if (error)
>

