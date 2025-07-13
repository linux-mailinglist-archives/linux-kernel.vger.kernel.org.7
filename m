Return-Path: <linux-kernel+bounces-728908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FF5B02ED7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 07:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C401A60EA1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 05:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AC91898E9;
	Sun, 13 Jul 2025 05:52:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F961367
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 05:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752385925; cv=none; b=u0Mg+T4/6I75PkHa45c4/zHBorUE/n5+fs6eL3jW99AzPP9eSdcjVEn0txJ1ZZqFHQSxaKkSos5NK1BtjGKa/4lBe+pRwy+wMgJQ1/jS26Wvjflw1r82pzy6Xuk5IL+21T//NpRfwEFEqVGuLX90IaNMd9Ejin27ZmsERNU2c4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752385925; c=relaxed/simple;
	bh=AVyrHAejsAhNrqLXUjq+hCbRlf2o6NYTnFnqzRjYGzI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NQn0ebAjPkahu/4DLZpDGAbHfEt2HrKY5y4g595urHXkxU0ktQvISHGiuBKkiEG4q1mrZjzGW7DiBF9OBFdY1H6LSVpWqtlsdQJKHkjbL2G3ahvb+NdKiEmNRONS1HJGyhC1M9DVQAP1nKMdxulZAvb81ZZWk40ZodCaOSlclmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86d07944f29so721805239f.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 22:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752385923; x=1752990723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dd35LQ9Bg9dmV1aeDMI4+RRqPvzWkVVXhKh+KI+J74c=;
        b=AjXf38AAnrFqBKJI2ZajTE5Zaf2NETVqpVPc7lRVN037Z8LM/FIdQ8aRrBGV7oMRSx
         uHJpuraT4kFKIN6hhUDFwaPlcbU07Wqmo2YP97Th7BqKIyhv/hNoEZAKLnOS4GCY75OG
         ZzhVNYg4k8cXYE7mm6qVl6SUkhCw3msiQvN53MRUI2BJ11eu0gTsfGaFBkbNlLQbVtSN
         lqcrHTie2VC7xUm0xpVxDaWX8/37jDn9BI/hReVbyegT2+WP7s8ZSEBs0rNDZWRA/yv9
         s3AFvphnuNkFgs3f6ekjslf6RmtGAJOTp2Ekfv2Ce+zqqAh/ROZqR8CsuGiLPtA8yD7G
         uXjw==
X-Forwarded-Encrypted: i=1; AJvYcCXLPFXXsi/8FfkmOXRm3bMjJb9CzODttlf9A0ZNwvrUlT8REnaLV8n/UTenEhA/gc5M4l68uYJWZtOIyVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+nhhSuRkZhCdu5ctiazXtTzo9DqU5ila9zErkJsurs9Px3Pyt
	bwLOkXouu0PEe1RKMhewHE6aL8TqZiTLYASf9fY7aQykvOWj6vWx6Es+dd9fs6MPwj9aGZ9mlRC
	/DPLURpLJajJr8EPj+3m5q+yi3yDkqt6Z6/ym4p0RwXGR6YHkjiJ+PiJj4JM=
X-Google-Smtp-Source: AGHT+IFJVEqnY7nH/aXIG6sLKT3FY4Ovu2eu7s6zXlBzOE+1Il2Ss746993D0tu9X+m5UYImjmSGLJ8AaNNCTe5rFbzmdMdWmswR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dd2:b0:875:acf6:20f with SMTP id
 ca18e2360f4ac-8797883d111mr954923139f.10.1752385923329; Sat, 12 Jul 2025
 22:52:03 -0700 (PDT)
Date: Sat, 12 Jul 2025 22:52:03 -0700
In-Reply-To: <b62708b2-070e-4122-b7a4-b7fa1d73cee1n@googlegroups.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68734983.a70a0220.3b380f.0023.GAE@google.com>
Subject: Re: [syzbot] [kvmarm?] WARNING in pend_serror_exception
From: syzbot <syzbot+1f6f096afda6f4f8f565@syzkaller.appspotmail.com>
To: kapoorarnav43@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file arch/arm64/kvm/guest.c
Hunk #1 FAILED at 844.
1 out of 1 hunk FAILED



Tested on:

commit:         15724a98 Merge branch 'kvm-arm64/doublefault2' into kv..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git next
kernel config:  https://syzkaller.appspot.com/x/.config?x=82bd3cd421993314
dashboard link: https://syzkaller.appspot.com/bug?extid=1f6f096afda6f4f8f565
compiler:       
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=125c07d4580000


