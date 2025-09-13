Return-Path: <linux-kernel+bounces-815372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00059B5635C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6972E1B22A33
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C9C298CA7;
	Sat, 13 Sep 2025 21:56:48 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F8D28134C
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 21:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757800607; cv=none; b=ABrw+Q2It3SUONvvQV1aGcgaZTZh+erSaCambqqIFsStYLXfMiDhkyogg5u4/FZwQGajFKmOW0hrjuybrBpudTkkQ4Xuhk/t2EX8eBSpzkzdbV1HdDp6kvRGulKO7tg7dqZ2ql137CzWXA/zzrYGKzQ/pKZF2quhvTxiNDqUYSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757800607; c=relaxed/simple;
	bh=qxJ3cz/1X99QWrECfgIXypaUFQiGiMuj5bZt6lOmk+o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MZTY1Xivbevluicv340FcZ8ltCREjvOvsMj8K0nchxp8MV3oNyvdKnjC0/1QIemsuYzxSOIojYA9Rd7XSavaD5UiPCfz3CXYyb0N78weIWByqligr445q4TmL4/rL8M5kB8+2G0AmbDh9V8M1kj/mfTpiCPMSQv+bTFJ7dIZFbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42218094a8eso17531325ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 14:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757800605; x=1758405405;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxJ3cz/1X99QWrECfgIXypaUFQiGiMuj5bZt6lOmk+o=;
        b=AERNy1br0htNtWOESzahG8aT8P/gXfuLSlaSsSThIVKapkid8Pu2zkciPXRk4/C821
         tWLd6Wuvg+DH7Q+Gu7QMVZ2im1zO3KIeaq7CYVXInBTcnrSevJyeOTCWonwzn3Z9IwDG
         kGv48RRghPyFsQh/07zOZ1QjlfaMnd70WEWLbKwM0Vw8MKJGxI9f3CLyPdpR46WOxByo
         1HkL9HjACLoXy1UoMFaud2C0Ywiy1lv4Rz82MP59OMFlnZ+UcYQ+fIwtgaisA1lGdzVk
         v4t2HKWn+4QlJblL4ocwm1Yh4sZkVksFvB7Ysr7iUzj0wwVkpSuV9Z9iY+Ymcvjsa7cH
         adXA==
X-Gm-Message-State: AOJu0YxJgYav09XLzrgYzU5rXN2h1R9wCGAFcAqODXdyj+Rti0EMRxEv
	dvXxUskCXhxdloxgSaSasHdihJtqTpUndV0AJzhJ6Vmr3MMN3xYg5QL0mj+q+Vje9BlFTqsiLaU
	RkPbvAr1yQGhGXGh6dcMYQrfy1TQsnWpsxDw9sOhvAbOsi8VHXNjLwx17k+I=
X-Google-Smtp-Source: AGHT+IFsVZa3zV4ZIwWIchx/kArEfcm3G9zfOnuTczuYltpjr+K6tQT7xJtwcHGPaWztC7E3H0BGYp0nB9t+kmguetF68XrK0Fu7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1568:b0:41a:6194:c251 with SMTP id
 e9e14a558f8ab-4209d31a3e1mr94267315ab.3.1757800605717; Sat, 13 Sep 2025
 14:56:45 -0700 (PDT)
Date: Sat, 13 Sep 2025 14:56:45 -0700
In-Reply-To: <68bacb3e.050a0220.192772.018d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c5e89d.050a0220.3c6139.04db.GAE@google.com>
Subject: Forwarded: [PATCH V2] WARNING in reg_bounds_sanity_check (2)
From: syzbot <syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH V2] WARNING in reg_bounds_sanity_check (2)
Author: kriish.sharma2006@gmail.com

#syz test

