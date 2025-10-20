Return-Path: <linux-kernel+bounces-860617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C72BF083D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BADE13A4014
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458052F6566;
	Mon, 20 Oct 2025 10:23:18 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A5B1E9919
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955797; cv=none; b=mIi26CpaERtJrAzw4i1Y3I+zz9v0JMcHryP1hbnT5wQXdjZLA/oL3Gj9XjjR1/Zgk2/qu+10eIpzTZ7LF+WpRDuoc7IjhCsJbSKEOJt9EsmD5YP4cOaxlx8T8AnyUNTyuIinXfKz2Nc3UwwGKSIShI0FyOFK4KYv0cTJd3ukd3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955797; c=relaxed/simple;
	bh=q8iTwWxV6aAGQRZoQ5GTvOeC/Ir3MLyotU2BKkvhx64=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kmOrSW6j4tTeA5RLupdyn/aEkYlP6TTcnkhrKD/z+5oj3kxvgV9ZIglASgeCAUq3W/yxA3nVHwUMKt3DanWpkHxEEni/P8s+fsrQaVQ1/LrMflR6SxRL0b6s766oKtSPhqdQ0dUZXfxhKoWNzEFgS5wIrXSidPy7IU0lqavpoCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93bc56ebb0aso1300546039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760955795; x=1761560595;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q8iTwWxV6aAGQRZoQ5GTvOeC/Ir3MLyotU2BKkvhx64=;
        b=ViypCJu0eKNPsFbGF+T1RxxLRgq99T7R0Abc9/k/zh8phzDA6uL0Vt/N/sE6uFSo3v
         tpISG8FGafPTAn9GdUoxSLL6nlSBhx7837T3kiAB4TQx7lrXcmMMAR06sl7caIgvyE/2
         438J13lxvai18tajnxarG1udZ3dU+/z7qJ/9yFqQe5OzWFNWi40xcHimQWWy7tVAk0er
         RstqxpmMhem7yOffIK4Vozpt5Unfep904hYzjcsf6bJe3AigCtZq51tqe23C9/flkJIa
         8vSdVexBRqimO1AxpsBlUTbvBnzXEtPXqLBcI7JsBS5iL2jj5dhDp7gZs2uqGdXyMfpH
         T2aA==
X-Gm-Message-State: AOJu0YyQaa2t6PF1gArTjuvK5pCb4GRUOu+33FmGm9JCUMEfBHvNvy1s
	MwAq9GAFAiI/9JQ2LU75hzVfenaKYRD7nLeKuVcypRNlHVt0myIHtL4vRHQehuN62v0at14zfFb
	GMf8uTqnKMMmOEDTSsaRhsXdw2nDjYP9R5yq5SNyn2P3w0q5Jwp05xPAl0P0=
X-Google-Smtp-Source: AGHT+IEbToY3tHLK1cjbQz1cOmF39i71niNJ0D+LKV1KWZm2l/GzU4hJ0HRBe3PGXm1ICKS3NtREDHm7NhzGUJSilZXDj9TZJs80
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1588:b0:940:d4e8:4717 with SMTP id
 ca18e2360f4ac-940d4e84e51mr628169939f.13.1760955795596; Mon, 20 Oct 2025
 03:23:15 -0700 (PDT)
Date: Mon, 20 Oct 2025 03:23:15 -0700
In-Reply-To: <66f86aaa.050a0220.4a974.000e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f60d93.050a0220.91a22.0443.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 211ddde0823f1442e4ad052a2f30f050145ccada
From: syzbot <syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 211ddde0823f1442e4ad052a2f30f050145ccada
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 211ddde0823f1442e4ad052a2f30f050145ccada

