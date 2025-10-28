Return-Path: <linux-kernel+bounces-873586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 738C6C1434E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A131A27796
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80951312836;
	Tue, 28 Oct 2025 10:46:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A523A2F0C67
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648366; cv=none; b=u1iLFWmegcZc4TxyqBvHzp9+u5b5evhQMtKYIbgv+T95gmhZCfCdyuDlRptTYn3ION67VK9tMGHtak/EdY2mo1b4LXRbCVWPpA28hB2m+3585aVRkyD36OVqND+DPOIVLaD40SE8fcnfC6k81KuA3GQFDGEms1JyxoWAJQ788to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648366; c=relaxed/simple;
	bh=stpPBCis7W/9Ub453OXBAsn9a3ICS019k+U20igFBp0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AU3rI4dbrWXKiSD8Ul7seKAQJnFwKjhx686RLJwuRz+ju2oXppPtGC1R3hARrHlgn8NakB9MHD7dqfdfVWOXS2+VvRtvIktAV9raGTEycTZatv20taAEKtrBO0WA9SeFC8RD+U06scc5Hu/KqxyksOJSacktjuK/fSQRTVN3jGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430b0adb3e2so75583745ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648364; x=1762253164;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wG+tyQfSj+NSyiVb2sj+rGzjkDr955kMCjJEiJP6sKQ=;
        b=AmUydAAC52xnCNUXRqUIObjpc/ufQuUwpLFg1KtFO0ZEI7kcGty7WMZduDU7P6z/v5
         qXz46LlpYYbncEfzODaECOqhpxC722mrjtE5V3Yw0j/qaxzq9KQgIyGNja+qFRG/TInU
         826VFd3uK92CwT0ou9n223DcUVTreOoGAHLcqhiTF+E/nVgamM94kbv1x9UaAarEjxXz
         4XuG9VYMToV+ffBLLXVroelrKisXsDGvTXGOKt6ieiwnn2DcBOLxzB1nXgtX8kz1Ca5m
         8hgm1KZM4pDaaoyhOGThZqa1ajLUZLGCaLZMDSZ0QOXk4yw6NDgVwgrwTpM0ZwnbqsgA
         P3Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXzfbicgvx6WaMMsdFRMGs+GoMPEFx8VsyA4VPkFcfcTrJ+t53XaJ1j0hHBoJ7/GmSUQOzC/p70G0/pmwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Va2xrjZdlVqAkfdBWI+hBuZnN2ppnypBhfEKXs7csIQnNaRI
	nyx1dfpzJ16nHrgQ3wxmLPKsEA+/Qaj0yekSf4u7TkobvVlMVuBnPDcIeB+ECemJWg2x3Ou/XDo
	dh6XlFbH4K/Xr3FAGinvRpJrOuRUETJruGpZg1LaAsR13cpKUOvz9hihXkmY=
X-Google-Smtp-Source: AGHT+IEqZlxFkFpXM4uMtZI09x3392I9qty5CMJ5vwkCjkvZEbLV7QIK4aSKVn/aFxQThblZtMAhSQ3VJR56mojQc1JPdOvEkUzH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1886:b0:430:e5a4:6f26 with SMTP id
 e9e14a558f8ab-432103bc903mr39848765ab.6.1761648363791; Tue, 28 Oct 2025
 03:46:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:46:03 -0700
In-Reply-To: <20251028104122.AvpFW%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009eeb.050a0220.32483.0187.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_commit_truncate
From: syzbot <syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-6.1.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-6.1.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-6.1.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=1234f097ee657d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=c16daba279a1161acfb0
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=116d8704580000


