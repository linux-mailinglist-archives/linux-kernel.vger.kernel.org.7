Return-Path: <linux-kernel+bounces-846132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D17BC71E3
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 03:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C85189A503
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 01:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F41154BE2;
	Thu,  9 Oct 2025 01:34:27 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405DFEEC3
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759973666; cv=none; b=A2IvE3KeGorXWNW0hfkGSXzyr0ghr4Zvbp22gKts0etgXb+pdtN6kKldbcjdHp/VG5RKUmBsgUBaLVJKHSNaT6cLiO+3TCw+eo3Y1lelzq4FhI/T4L2617oidQkA3cCN0TSlHlI5BNEWbdwEObgL/W/nTS93ZOlQW1XtLgfJXtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759973666; c=relaxed/simple;
	bh=7q9prtpR/UeW5cPq8ztJZu+hE8uD5Z9ClfXirmxYxpk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fgs/zNUfFwEJPF8y2poZkwvF2TcppqiJC0KW0l1CUYAO9giXG1CfC5EumbXxDvJuGyHwUF7xdzA/MNQXgA20nkuGpg7b8bruMM+CKMAueU6GQz5x0zubfZ9ZMgTLlCCyVvoTaaDyf8POAUsCHuLZXr4LnGdtEPkP8SNtxkuOHvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42f8824b65fso25276745ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759973662; x=1760578462;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7q9prtpR/UeW5cPq8ztJZu+hE8uD5Z9ClfXirmxYxpk=;
        b=Me9ZYtcCx6AGnMv33M0JEXcrcu8LWDmKBmTlHRm1FW1/buDIBRpcXx2gxZZPjRyALe
         +X79DUBY6WpNXkiNfLDdj1TwNXzK+5oUAG5lXc57u1VJXr29qMgslu1GM6ZNpgEiAZlh
         KdqQY13yeNvIcAwConkL7734Y6N/FiT6qZT3FwJbvW1bRMeTqXl5hLpwP4KlDweX9iHF
         19xTrokjL4IyEu36MpT0rVJGsQ1Czd5ZuRZNdlMWLxwYOK95hLfduCFC+/bPvOsmyXgm
         jtnDKxR96kjL0eHt2306OhdobUaDoHqlttU879U7TOcPRtiMNXfxWGJHFpiZ06ACa5sx
         jknw==
X-Gm-Message-State: AOJu0YwoNob2wl+k3IyG9fj71l6HrxKS/GgHhXmHXBOJtc+oHX3MXjKy
	S2AA9DVBqMJ7TVT6IS0SAM8mNgBLDOl5f7Ah59kiFYInn/Dh+mTt7dwPdZehCcE5KgI1xSKXjEs
	IWDLvRGZttOt2MefiDJaW8iT5kg23pm+NS7fvjGOUuADQlkvAABvSPQNcdGI=
X-Google-Smtp-Source: AGHT+IH6sFRYgda3i6FT/gxz7tgd98m4sg9ZlO97mDwlT7Btp4giFpTkgg7JNcaE2HiKZctumY0WVNFWXPwhq/55TBLUPkVNMxTk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1543:b0:42f:9410:ea96 with SMTP id
 e9e14a558f8ab-42f9410ec91mr274105ab.2.1759973662186; Wed, 08 Oct 2025
 18:34:22 -0700 (PDT)
Date: Wed, 08 Oct 2025 18:34:22 -0700
In-Reply-To: <68c58bfa.050a0220.3c6139.04d2.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e7111e.050a0220.256323.013e.GAE@google.com>
Subject: Forwarded: kernel BUG in ext4_write_inline_data (3)
From: syzbot <syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: kernel BUG in ext4_write_inline_data (3)
Author: albinbabuvarghese20@gmail.com

#syz test

