Return-Path: <linux-kernel+bounces-837303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A796EBABEA0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3436F18923E7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD1A2C08C5;
	Tue, 30 Sep 2025 07:56:06 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1F922EE5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218966; cv=none; b=Z8fJ/2TPeDAN4Q9AmMpFugM6DX1EeLKpBKM6Tjr+iK9PKnm/rmw7fVLRgghiPWzSymAZgdoy3BemVx9lozTPU+GgkwihUhFk+Ie+V2UClSnQuEZxAoP02Y5ksN6SuHv/korXwqZl0pghqSVCUuwfKLs1NI31tHSoxAWwC85Pfe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218966; c=relaxed/simple;
	bh=6CsWa9ZaCwwz3ohupNsBYFxfqhE5121wCqpwTTN+NiA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D4qkWQCVAWlAscP2xx7az91YuLIWEknkA4mIJDDZrPrCQZ4bdQXEn7dTe7IYgyxpAL72mRJlJHMa6YbjAWDxC1BPVaa2r5y604KrLOTUOb+1U9xbCGyrUd2f/+Smon13JI+KnbvXImhjVIGM+KKzY8B43NgYb4ULrNIpO1THGAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-9286199b46fso227432939f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759218964; x=1759823764;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tXNl92Xpyh86Io0sJvUCUcmpZC8PnFLBMfZKhFkgjRY=;
        b=NwtvvmtmjhyYhCaRpSwdmWhIAa4ABhTY+LgC6fMzB01+aPVihl6b79rfPEr+VpqMUd
         9HHEmWzRDaku9cHHsyCtFDMRdnMMWhvPiAQSbFCgYo/z1mmQ+G7gunX6nIkia4vx7MzH
         FAdrg3TqGHbT1He/cQrd72PpJwHOgnQxJAW9Rr4eZKBYoprpwGBlfL6UI0Kp8j3My7G1
         3bLhR7uxPMsDw7bbcMEZhQzLgnlp5JQMKZcUBMYTiUsdVWDgYqbdBULl9dmlNBCa7GPp
         zUvphkZWx071Mg1f1YeQm5JQhfeQXdP8JM0lFrLl08gfAqEqMtTVpqcS5y1cBC2hH3+9
         MgVA==
X-Gm-Message-State: AOJu0YxbTY6vga3fXbF3VK4Xew5jM5oznRxwz3bRWpb927YPHm+F8RhW
	IgN2SuHsJoMdAEvIrqSJc/e/CwQMJTDLHm03UjCocEiOlAvpL7CKvlFDeJWn6oZ8UtnzF3Y+Nxz
	u38zA73UJsiLANIS1zwg0InH62Hyc/f0ilweIg/QjQXgpYmp2Mr1Y1uq6SdMfgA==
X-Google-Smtp-Source: AGHT+IFJdYNq2IEB8JTecm1tYAkXpaOLNWKPT0VmOvmZa+fTB4PpOqcl1Gj3opIso4GtaRLK5GFX5Mnb0LhJzVDbBsFFCOK0IftF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2ccc:b0:91d:e35:b317 with SMTP id
 ca18e2360f4ac-91d0e637f8bmr1517400439f.7.1759218964124; Tue, 30 Sep 2025
 00:56:04 -0700 (PDT)
Date: Tue, 30 Sep 2025 00:56:04 -0700
In-Reply-To: <00000000000094071d061e9d0f66@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68db8d14.a70a0220.10c4b.011e.GAE@google.com>
Subject: Forwarded: WARNING in drm_wait_one_vblank (2)
From: syzbot <syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in drm_wait_one_vblank (2)
Author: chintanlike@gmail.com

#syz test

-- 
You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
To view this discussion visit https://groups.google.com/d/msgid/syzkaller-bugs/CAAL9DyBcAo3nP_ME%2B%2Byw6feb5X-ZAcKPepfzBND0RYPYRLmWug%40mail.gmail.com.

