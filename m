Return-Path: <linux-kernel+bounces-737935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272A0B0B21C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81CA67AE4CD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 21:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612C5237717;
	Sat, 19 Jul 2025 22:01:09 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A653C170A2B
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 22:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752962469; cv=none; b=rQGlhcDXBxHZYMTfvhbicpQofO/Ia5VczRqdUH2J9pqpV36c80pCfmbz0YhhgdCTVmcdpvCs9FM72AGh8n64+lwmSs9SV/cHo2SHGsc9mIRZLgxPW6mo0RMbUZXtKlGjc9kzd3T0A2McfgPvEKEiSURAnbo5bMEAWn4qGA8ekrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752962469; c=relaxed/simple;
	bh=5w+enorSqrTUVe5hlglaL1pX8RaC0uSKgm+fpFGl0iM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ymf8+2dkGmoPLJ9YiIXSQiheeOK6MOEut8PcVhlAX9WtZmvGyUrLg/qrUMy48aEej97NEgHuSpNIm1PLFIT1dv7OnWtIkqG6gefNUzwYyl0/9UEONhx7HHZRM0SxkNGjilQ9d2pXBjrBbtxZX/lDGSodMNlkpwIYCb37hqtRsJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-86f4e2434b6so352969839f.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 15:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752962467; x=1753567267;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4nFvvvLMTDjjCyIfgcu9w4PSjyqxVRP1u0VfJtfkPsk=;
        b=H3+YIyAXXTgZQcniIJs8r8kEbvUUPNhsyFsJ3nRelN2wZSieQ/5QVu1Lf2gBOVvEmc
         CKlPl/3KgvDVz5M+PjbkVuDsG60qS0WFEZBR10/T7POfy80bYp3GzkXLrCSFNmjJxSFg
         wxHNbwPfjFySfBGGoC+2K6/ok17+QqSuYtzyybavAp1MUzztUjrnw1qOn2ht6nHmVwOr
         P3YkP7a95Xp8sQ8IRRHkrNjBfKxzoFy7f41LxJ4knwFNHqstq6Pr8vrD44j9Zyuiadsu
         m8rDeRTx+KWCRfMakzt23850SOuiyT/kjxLyS3yjBw/TtOMZUdpUAYU3EM0VdN0votv1
         MlWA==
X-Gm-Message-State: AOJu0YyDwBrGuUOhn5jcKflAx5isOVTuvl3/NH2WVdif5WkeXAqxQ8Zr
	6ShWQlYqeeTFuiAFQlrY9YLDw70eRYh+VEUE6LKs46XNK0UkeCsGyOMVf+gJ/OQmeQ1kPcad8KS
	VmSessDYF7auyQ0URrwmwItUBFJjE2E7DaHGCppqHqVILPepFniNyRtGXu90=
X-Google-Smtp-Source: AGHT+IHBRCD/hi+/v3+W89f8eVE78BGItJv8hB4/k9nH3P7vd6U+w9AuGMutk8vsF+7w7FhML5dISa3klBAvMyQJyJQZBb/D8UuO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c0f:b0:86c:ee8b:c089 with SMTP id
 ca18e2360f4ac-879c291915bmr1502661739f.3.1752962466725; Sat, 19 Jul 2025
 15:01:06 -0700 (PDT)
Date: Sat, 19 Jul 2025 15:01:06 -0700
In-Reply-To: <00000000000044bbc206189dfce4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687c15a2.a70a0220.693ce.009a.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+6d3021bf0c4cb4ffac17@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Move bset size check before csum check

