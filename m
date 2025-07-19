Return-Path: <linux-kernel+bounces-737974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B76B0B2C2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 01:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC283B63FE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 23:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4A428ECCD;
	Sat, 19 Jul 2025 23:27:16 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D5B224B00
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 23:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752967636; cv=none; b=C3gLVWGoIe8BaDuyznvkcqKPzNZ9af1LlhLM/pHQRocoBmOVpf8tVXOo1zqsxOWzwldALBPU+VXHPByj9I6omonVQLTi87mMhZkvzDlRGrP0N43Y2rjq3XzGfF0Lsj/D/iIgs2c+lV0x1gkQTH5cDjhpgEdXfo9n2R/la/1fcOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752967636; c=relaxed/simple;
	bh=nvWm18lkwC7jEtM37SUfTrGX9waWdbmRWDWCNOISSOk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FEOEgrqknCza+fpv25mp3xW0amYveaCsc499d5+OGtXRkeePEGQzQTr9NNH7f70bsiWKwhrR1HWn58P7qHDnckzKCSOff847u95Ek6mkwO/gxXAMm6OME4rvdh1av72fZXPx2VF7J/vz5cPDOpM7yn83UlBec6Lw8xmJqzdaI00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87c29bef96cso105261339f.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 16:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752967634; x=1753572434;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lrFN5I4Oc2L279PU6A6j7eY89aSi31qYyO2TGnMnZMA=;
        b=UXkaJJB8UcutkX/N+/KvCXM34EgJ1/CuWvdPkghU8qi4HEep6WFdZ+f4W/HpFeUpsT
         GflTX4s+NpIcFcobPiArrpqfQoSRVt/3m6HHxzsaOYChopj0XZBCor1ROtzrp6k8sQFR
         gNmyiw2L4OjlXAMTaXfXs4PoA7ICSAEYq5+OWD4q5HK//+jmooc3NG67gnK+8vkKHn/t
         Wl5CdgJKKR/W9eWO5VLygJDR3470qRK+KjkRBZ/1XTJZg5CwaCpxthV5Eoe+UJTIAXQ5
         TvKRMfQ8uIm8ub9C1yseKSfvtUtpBlZgf7bGTvVZxczZNrBAl/xC3cgUpVOB+R4qWoLL
         xSzA==
X-Gm-Message-State: AOJu0Yykwop2FB5gXIJRcmWihw118jYvFB6YX3QCmec6BbbRCpotoSBz
	259KvfIEIRAW35nzet3nUdk6hkEAMsE27PU36gsQ1Bavb4J2LvSAL5USqOj6KXrhOjl5k7YiHZL
	DdYdTbeD6wnbmL3mVZyRfJ8Y2Ct1O7bShYwESspldwlPeypatZRp4Oo+fu/M=
X-Google-Smtp-Source: AGHT+IEaFYM73wmbZGR7TtvQNcWEYnip2Qah9FJA5lA0AqzFkFh8OBlYz+qp0Oi/LsASLhTWdqVbUbmHXcuUa+RfKKfoujqdEWoP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6933:b0:86c:f603:8907 with SMTP id
 ca18e2360f4ac-879c286e1fbmr1330789339f.5.1752967634092; Sat, 19 Jul 2025
 16:27:14 -0700 (PDT)
Date: Sat, 19 Jul 2025 16:27:14 -0700
In-Reply-To: <0000000000003361de0618679a80@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687c29d2.a70a0220.693ce.009e.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+52eec578b7504cf32002@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix:  bcachefs: fix the memory leak in exception case

