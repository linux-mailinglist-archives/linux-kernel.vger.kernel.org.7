Return-Path: <linux-kernel+bounces-741215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA6DB0E18B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F005633B6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3999827C866;
	Tue, 22 Jul 2025 16:18:25 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD5B27A900
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201104; cv=none; b=rNjqgn/wjZMhGJLboeNpcOIqQE7wrWBblW+WXR06U14VjRJgLhYPJDgZ0/hLF4EyqnuyaAOfoMzXu2AImTHaom6Uk6oYXn2yhAHNrgfNiWoP5jaM7CgUDCFGGfdNevocyrzcEKhW3yMNEvptK5HBqiMuezrbeqNbYOY6xPk+If4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201104; c=relaxed/simple;
	bh=DuHVtFXpqMgj1fFQUByPAEK/yjp5h4mAFfEQMRjiOK4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NLWpTu9JAnoZbrWuK2aZKwT4XCiCA63b8LZCjZ10AwEam1yo69o9HeRyEIa3p3WL9ot65O1+9Dhwi6f5I13zit05FpxKF4TrFdvn/7YU/EWnfURfmIm2+h/a42a4XZjpeqcQuYIM+dSSL/bAoLJX5q8YGTT9F3AYi1DwT2Xxp/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87c1cc3c42aso679305539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753201102; x=1753805902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMRqdCXGwjH4IV5sAofExTZ5njgZyvVBo01g0egcTVg=;
        b=Ju4q+22O4dth1TmvQORaldmrvvrLfBtAv7hg3hJ8P/kHtoSq+134xpAVbZhlFL6PL4
         Qngq4sz/NpcVv+PRumcOA/pOL0LFxapzIKxG2uLHZw5xUyiCxIifCAqVCJAOGrxzDOBr
         1Vx8VJOdknIE/1r7C+IyOQ8VIoiSCsNbdcAZIVBpj//7StpZu9dai29ZquY31Y7eygdi
         WAbaPXdcNZ+y675PPR7M1da3FQB7kr5CVHJN6zSw5H0m4IW4wMRCg0L17yUoxITPfIFC
         wMuSNofsi2CD6XRIqSRzTcB3ZdXR00j7c4FRVkvPc5yNd1q0xU8QCr6jxC1mvzOBGMoP
         /nKA==
X-Gm-Message-State: AOJu0YwcsReUuV36sHwHWd2SITH153NnHAoiRxbl8GKjbbsGxTt2Q0oe
	8IKs9z29hZcUlwcuNeHjR80pz18rq6CJmHxeLweqyaUlZlW4GuXz2LqMrOycY6VrBAKnwC5jZDV
	DfoL4ZYCl2CsgLKETS73jOrkl0mr+z7esQPxOyL4PP6eV2QfvejXTCul9C+w=
X-Google-Smtp-Source: AGHT+IHS4PUkXBOUm1B3+4mXTJwy8ACfRdXJwFsBHUL04hXJNevwTroX6nZyFN3j4nSGxmQizBPqwZyRsqitaxtLkVljFafanQ6C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6808:b0:85b:58b0:7ac9 with SMTP id
 ca18e2360f4ac-879c092784amr2846880439f.10.1753201102490; Tue, 22 Jul 2025
 09:18:22 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:18:22 -0700
In-Reply-To: <67497eb2.050a0220.253251.00a7.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687fb9ce.a70a0220.693ce.0105.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+03b7bb8ca037d17926dc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix:  bcachefs: journal_entry_btree_keys_to_text() is more careful

