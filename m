Return-Path: <linux-kernel+bounces-860011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC588BEF227
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7EE1899BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7462329B239;
	Mon, 20 Oct 2025 02:57:39 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC51735949
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760929059; cv=none; b=oF1qyuiWwbIfD2u0CoCWOaM7e0fb9WOOpkeaF/1gX1C1HGU8hvn3MOWsP/gQm01263MUf7fINAEcuV+iJTPEAygOwfM3NQFN3sFj6RbMIvLZZm7R4IZ/8quTax45pmNhes+jdvvmwpxzWPGPSCWFrGq0OTXU/bKxPDgLjuLf6qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760929059; c=relaxed/simple;
	bh=EZw8MEUobbXmfmITxyomEqYZScaDF9oWLR3+Ht5CyG8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AcceHXm4yV27r8V5PYuTh2rLkcfL5GKSrWcyMSQ35AfDuWVi8WvemrFHUp6whG6Ku83OrG0/v/pHaEJWT+uxSnE2RReA3P1g4rtHhr9qkN7kfzASoGXvdy0Y12o01dmtYLxyZYeWRxyBMDT2xLwWXVhAqEOjKyZqXGXATcnxz7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-925332ba890so1056315039f.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 19:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760929057; x=1761533857;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZw8MEUobbXmfmITxyomEqYZScaDF9oWLR3+Ht5CyG8=;
        b=ulher7QEVJ1kuBCIX16DcY9fZT16t9+BLtLiwDNr6UYKB9OJoDyhVktbHpTl02HnaM
         G1nrJAXTA/py4bCx8hPpVlNU+dqyh1EMzkEIk5H5E0jpD3puEEGCNnp9j3Yaw2tImyN7
         G2Clvz21h5f7JgibH/DpQ078n0DPbLY6pG8Gch7pXF+cRp29V/5VTZNuM/lH4Ok653+3
         D6Fsz2jx+tguc+jxP2nfYsqJdYHuM0p99V+Wx1FkGdFxmSSZI892dMKrcKT1dnOkPAvr
         GxYEl0BN1WlhOPe+1JG/ngPiTEWkQj0xyU707+EyZHPIfP/01R06pK3F3w5SrsoW1UEi
         zgVg==
X-Gm-Message-State: AOJu0YwmqOWMgF8gu8p3FWebEnijAiFW6W/O0GI/B+qPOn/yFcA+k3qq
	x3PZ+AB1vP9+0AyJI5Y8usWfzX5ji0jRYA2P/JUFpxfD5aucQ0PHMdAmCvx68tBkTpb1NegIpv3
	Y4ZFcng73sUYYG+SJL/VCp1F+ArdNfQv+wYFmefx0+O8jfoUAKnPgSDhWoJc=
X-Google-Smtp-Source: AGHT+IFxfJIyTJaidAJCMTfmSUR+8/r2IsqwymvHw7SQ61go8VWjh/xkHhXBv7NQj6A1rO0gLJb1D3biwSuRZ3tBjWjwehg1j8qB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14c7:b0:93e:8d84:2a3 with SMTP id
 ca18e2360f4ac-93e8d8403c2mr959308839f.19.1760929056893; Sun, 19 Oct 2025
 19:57:36 -0700 (PDT)
Date: Sun, 19 Oct 2025 19:57:36 -0700
In-Reply-To: <68f1d9d6.050a0220.91a22.0419.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f5a520.a70a0220.205af.0023.GAE@google.com>
Subject: Forwarded: [Testing] net: key: Validate address family in set_ipsecrequest()
From: syzbot <syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [Testing] net: key: Validate address family in set_ipsecrequest()
Author: ssrane_b23@ee.vjti.ac.in

Please test the following patch.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master

Thanks,
Shaurya Rane

From: ssranevjti@gmail.com



