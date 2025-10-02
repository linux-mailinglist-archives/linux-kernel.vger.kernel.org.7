Return-Path: <linux-kernel+bounces-840528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06726BB49DC
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA68F19E4183
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DF2258ED9;
	Thu,  2 Oct 2025 17:04:34 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870C82F872
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759424673; cv=none; b=JP/1E70+7DBa5wUtkCh2dVvt+WM6HUMzg6sKTTJLofjrglAqoORJOjHPCQeDxniTNnWHOSacDqZxZYwKvSIkoPQrZ8Q62Bi3GyzO7cSTHMB70G7MIvE7ydBgFU2HnSc+852gWCUjhVDvDM32lvRlZWEsZs/5ChmQ1IrM80bhGBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759424673; c=relaxed/simple;
	bh=u7zoK+yqJFcEIMZfIosfM/V9RANxn1tlApxJHhoJv98=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eAD3ogrdE6gC4XrPV0X9M746Xezp/9ggEXgyWJJ9lwz31TyibOGU7+QNjA6Z7DjgxqrVHWQPym3VevO59Wp7h2qETfDQD+KltlzY4+cWDEfJRm/iVT0LVbwmnaN36pJi20xjaMDkYfk0ihwZmyptbfiepNChEAVevbMWFQfS2+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-92677af9082so335215839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759424671; x=1760029471;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7zoK+yqJFcEIMZfIosfM/V9RANxn1tlApxJHhoJv98=;
        b=vny/hWrNOO+bDWFHxd9wxllUXqAt1vD1nzwIoMxLCVVL7bjoaoSY/VD3TmMMKxdlUs
         tDMPc/NrYhBiGWKHRdghqfFFUVX+foJsWN42sotxsZ/9XyfVVA9ASrmPd1/6jQE47T//
         HVoVWKedclLnTNlFUKvU0Nlb2NPBEn8FpoHuzgI3iZjc4Loq7dh1SHCepy5TQKyVl2xX
         KgbEXjD2CMH+0f/alqQltZcEfqIi6332VxGV43/Q1oTnrM+8j8ib8NvJ1SbinIYlrl3E
         50+fYzdhpzyrSUVqC/KWqg3+ty00H3dF2LMF3hpTQA2MuOwEX0ClT7B5ThSg5wSDPHPs
         hRuw==
X-Gm-Message-State: AOJu0YzUN2ZoC7sBTPl0/+73Eyt3gs4FpU0zf7GQF1ocnA4qo4npa7nQ
	4s8Ectx/CQAN20cJd/+PdJgn/tQImnKAZbAAbvNXT7BW/gOWTdwjvSYGGdNZdNJz+JKGpTey03q
	cHWZUT77S9ttjrwkR7AFQYpvj+asEQ7TM62tz9pqjh4yC7/Im9N5IqbX7XxU=
X-Google-Smtp-Source: AGHT+IFpKDe1oPFYfaJQ8s5CCfGxZLPRIsnic7fmUEKaxH2GSaL9U2NguP44O1xPA5UccVYF83PWKwXkylJ470BSIKX2DF3V28lq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180e:b0:42d:8a1a:2681 with SMTP id
 e9e14a558f8ab-42e7ad6e886mr2971335ab.19.1759424671685; Thu, 02 Oct 2025
 10:04:31 -0700 (PDT)
Date: Thu, 02 Oct 2025 10:04:31 -0700
In-Reply-To: <67389a73.050a0220.bb738.000a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68deb09f.050a0220.1696c6.0032.GAE@google.com>
Subject: Forwarded: KMSAN: uninit-value in hci_cmd_complete_evt
From: syzbot <syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: KMSAN: uninit-value in hci_cmd_complete_evt
Author: chelsyratnawat2001@gmail.com

#syz test

