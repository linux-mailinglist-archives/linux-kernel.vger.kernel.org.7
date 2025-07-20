Return-Path: <linux-kernel+bounces-738267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3A8B0B684
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D5737A6CFC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AFF206F2A;
	Sun, 20 Jul 2025 14:55:52 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B142AAF
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753023352; cv=none; b=BbZdtoiV3Y+Ni8ecZMULRWmWH7fvlSMIIHYj8EcA+9k2eaXi+5t2a87NQEFxDAvImYHH9pP3jDa+z5YmEF2Trc9aegg9ufOZkMCFuf3sRzg6wAPNXyClVk5feilJKe3pN3tXvowuMVIKaH2CBD49FK8lB3SZZ8ZIfabkG0P+Z9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753023352; c=relaxed/simple;
	bh=5w+enorSqrTUVe5hlglaL1pX8RaC0uSKgm+fpFGl0iM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S/P5e2QmoImgkbC/DBKXKvDkjpP/venxp9DxHRDELPv/qhVtmGvJ5O59cmeMsxkYS4buL/snuGqy5OBu+h2U3Gm4noG4B4DmTQYc8cwl+XMm4A5nXcVWnQpY8N92YxqtKfcyl+7qk95ja6yslOtFF3Ni0K2FZGX1wXnBZUGhIlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3df2d0b7c7eso36040205ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 07:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753023350; x=1753628150;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4nFvvvLMTDjjCyIfgcu9w4PSjyqxVRP1u0VfJtfkPsk=;
        b=LpzjtTKzXdKE/7NbXSJP1iOHpBx88Xsl1ardgj6fx6cae7hHrTul8n18Wf9U5CsuuC
         mKKGJa43aIdxMPBQoUuSHgpvTI/FaSF4jtT9NGJqzxQs35Rl+95OJaiBIjTWq+W6bjwH
         ZHVGkFWyAqXJH6mxVtagUVLMEiRczPL814XQ77GUQoXfpWIaejs8T2hYA2vG89E8eKa9
         xuajQhf4ab32JFFAyw6ykQHBS4Ayyx2X8RFUGZ0L2iPak39Bh5gdoszR8XYAfA4Y71fT
         gDKwDRbaE+t0x2q4LFWtfnEQeRJvPvPQA+tHLbuxvr1P2sXPKUq9qp/+H/IQWatk9Jb5
         5trg==
X-Gm-Message-State: AOJu0YwGYI+5DcV5agAAiq209fBedmIf4ZTdR+whQKnQoEwAUpbGb6Ki
	MXkaBuQ6et3qdzkqfj0wHBXlpL/yBNSJCaOL4+8DuDxj/+oA1MdMY4XALfKNMmB6ev+hEjXiK0v
	OPm6HBFVvjdgC0ir+9ZSpmaxtd2wej4TH7UKw2+I3X265TOLPgGqK8zN4NJ0=
X-Google-Smtp-Source: AGHT+IFP/o92SoiZYDgpQ/IpGkwJpumKROLUI9pFQPEeuOkKrvzuuCKw2Yd0O0aqgl0waaW3DqClK7PVNZGI/LEvV3k8jf70iqwK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8d:b0:3df:4ad5:3a71 with SMTP id
 e9e14a558f8ab-3e282eb104bmr165807315ab.11.1753023349878; Sun, 20 Jul 2025
 07:55:49 -0700 (PDT)
Date: Sun, 20 Jul 2025 07:55:49 -0700
In-Reply-To: <68209eb7.050a0220.f2294.0035.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687d0375.a70a0220.693ce.00cb.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+7d5c34b9ec9fe139fc0c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Move bset size check before csum check

