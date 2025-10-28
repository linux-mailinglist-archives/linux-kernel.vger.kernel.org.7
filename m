Return-Path: <linux-kernel+bounces-873592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4D2C14375
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F941A24BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D066B30BF75;
	Tue, 28 Oct 2025 10:47:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F211230BBB9
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648428; cv=none; b=mwfOaS2qXM3MArtCIVOgsZypurzzofluiGMeL4mVMIX69NqN1VwcI2lhQTip6D2O8EYDiPTAXw6Qiv1lTzgjqalrjOGpDyIIsmJBRkWDewuaxDQAFmPgD5hvXV/Nro41CL409JYC1aS6gGT5W9ZFIb3nUQA61Nwdhgz/egiCwPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648428; c=relaxed/simple;
	bh=U+B9usxaLcMfaNT2GSGDOeQR7f44p56pdkmhs3eThz4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rbU4o60J30qb1G1oFaF2vrAiokxY7ZMABPx8ZOrAcsB/dNwzv32vR74kRBgCDfyi3JiEBU1hxjJpC0DjYw/LIVH4w/831PMkC0Z/m51hL7I6higpGywM4rnSAwL+AenFlRwja7GztW/e8QaIFzwp4KbyE7Ytfz3kHZNytYbG06c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430c9176acaso76590855ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648423; x=1762253223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qE5MTFIGUy3kZLOy1vqCbC+sD17lx9Km4P0DjXnYIaU=;
        b=MDNILzOjezwr652s7q3uk5dCwWGSUuNsseErMxMQg7e9DLW69qSGsGZvI3IQI2VxAx
         +40yV8gn7/7M7RGTMyMK+Gqv8ntobktXbZaEEeeoxjDqgft3ZYVycRRfdihY4c8CZkub
         zTJnIv7j0vYTMx3+vLhLhRkvaXPfFo+OaXu4eCjpwatXsL16RykSL10z8/Arje14YHZ1
         qoT8cbdGV1Qof0+91qoWLi7QVEWn2D5LRWVSrgudnmw3ozOFIpgQCOsS+a1UKxP+0sT8
         StGY1oKKyEmT9EU9p6zjaWi2P8U5yU5bHFS3Z2nI6xE0hIL9idrhkNGOkcYfl1BLIvEz
         MPhA==
X-Forwarded-Encrypted: i=1; AJvYcCVh0ujr1Z14NK9HRpKc9c22N2i+uM/rAsbjSp0OBgXg8elMEAkfOi7XSei7DMPNAPpEKhnPaQmXxkkjIRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCujX+8t1Y6lcSY8lWPKzFbMuRRVN3KgG6/DoHDb7ug8OE5hzP
	wgenbRXSmei3CvqnhKd4hQ33dRunkYqa6i8eMw30kUpsfHSAqipTjQ955/j2Vg89HPpk0BERIzh
	hi5wXvwqoFRBAtSu9w87VXejvZT96GaU8J1QTn8iLRJKwm99yu7taLejMlQk=
X-Google-Smtp-Source: AGHT+IHjnmBgA5S1MacYsiPthTE0mdIM6ClliQRXqhcsPyIVZNMVbl8se5dbS2jjQzGqlxu9GEN/1HUstmAZHiLXWQQSqUZ6kErj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:221c:b0:430:b4e1:bcb8 with SMTP id
 e9e14a558f8ab-4321042b6bbmr37806415ab.13.1761648423117; Tue, 28 Oct 2025
 03:47:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:47:03 -0700
In-Reply-To: <20251028104156.MqXWB%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009f27.050a0220.32483.018a.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in __ocfs2_flush_truncate_log
From: syzbot <syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-6.12.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-6.12.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-6.12.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3fccdd0bb995
dashboard link: https://syzkaller.appspot.com/bug?extid=4d55dad3a9e8e9f7d2b5
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15a2dd42580000


