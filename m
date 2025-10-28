Return-Path: <linux-kernel+bounces-873600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF85AC14363
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214223B1C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E343054F9;
	Tue, 28 Oct 2025 10:51:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA985218EB1
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648668; cv=none; b=Q9FXmDwEcFLX2pOMInCtNGGVOobLWIdPXsI2l3lJ4PJIOlmnhrE3mYYsHnQy1HLqPmni8mCQoBY8VSoFEAjLOFq1Y8tZVmymmFjXSGTdjaYi8Z+t5eNCFy3I9hAWYnQKVwfSxTnTfE8xzSwx3sl6HCi55wUZI28iPkdA/58f3VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648668; c=relaxed/simple;
	bh=cYFIvuqeBFZw6zVspF/Z/fLLbPZugLpx3U2gIqaNBHw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BDnPRDJA/j0ezzNEpi0G925GzACeIG7TidOKiuQjw31iPgxzqt6O8qg2ArHOV8PQawwmEMD21fLrM6Z2+YKmaeeEjU5J1jSaeRmslJVh6bGNU4kSSdk8pTAg4rXMcqvkoZQPMk88Lp8CnB2KjXVksP1lh9o3HASSFubkFM2PPXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430afaea1beso75366395ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648666; x=1762253466;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ziw/tT8OJ4TTEphdYkOZ8zuCeEY5Ifomneuq/zhQNew=;
        b=URF8zNneSZxJsijWfeLZMrVsmRajcYLxtcjFZE+XxA5obtNH1msXb08lnizkZw7THh
         WP+1lnUp/hPSw8SlcSmSb06oMrlLLHY4DPV7sWQ5Dr80rpj7hc7YCMX8AgOu8sTVyBjq
         670L2JUJsg0mzb4e1vUkYksHb2YSGy+iIWc5I5ZRmiuZ547NPHThP4q9BGxU/RmQs752
         KIEWHkG213IuBNk5YLQzt5N5bT2LNPUvHAn1B+3HfQP/RivjO1vcFBuk1xtYS9PA8deD
         e5cMTAEBVv2WXUimqPPIoL3WKsG0hKUYCoTmm8QWj/S54oaZgfr6QtwIUFcK2eOzpXFs
         jcDA==
X-Forwarded-Encrypted: i=1; AJvYcCUjsgkCCdtTvoOfvMyAIKnKCAkSKd4frLRLmMH0B1/IvKm7bCxrNcmyownBvaTqJPn93xccclSPugZdihk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2dwBhcsViSPJoQ6c7zHLxacnDdDl//A6+dLBFCoQ4d1D/9WuU
	tuPvbmMvlYrATsB1Z7HuH2TF6vtL7jxy1NGxrFZzLT7MXuEHVDOXFZb8CZb+lktQDJhApCtfXFn
	lkm+GrEWoWNvyc5oRXfjFUhVhjZaEZj780gIRNVWeERGcV/GJEr8H8doFFXg=
X-Google-Smtp-Source: AGHT+IFoUlvd49QCkG/etBiMeGpnTjhSmV4msG9CmP39On36YoI4kijJCve6F3p7hP3nNOiHBS6jTYdilellaY4tV+YE+RvbpVyM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24f:0:b0:431:d9d9:de3c with SMTP id
 e9e14a558f8ab-4320f833553mr38081525ab.15.1761648665967; Tue, 28 Oct 2025
 03:51:05 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:51:05 -0700
In-Reply-To: <20251028104201.d8y_T%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6900a019.050a0220.32483.0190.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_commit_truncate
From: syzbot <syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-6.12.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-6.12.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-6.12.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=1234f097ee657d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=c16daba279a1161acfb0
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=130677e2580000


