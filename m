Return-Path: <linux-kernel+bounces-854446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFE3BDE65B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DF34835F5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F3C326D45;
	Wed, 15 Oct 2025 12:08:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CEC31CA7B
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530087; cv=none; b=knc++jHr5be3VQfiR2gB9sCek7cTv2utUxBQb+c/pUmQ2jdfYbNTqKmxmVMVZnmM2WtXasMWus5n1jtiToeGENtgY+jvk3PdSyg854MAMramZclCrP89HuQAcrn9Ib3FRT2B2m+aynTWSx0b1upaKWLxvapnKSgBepju1U1mxN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530087; c=relaxed/simple;
	bh=ikafkcyEhGPo6V77pZ1XIeb6FhQLfB2Bg8wg2NG8Juk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XrtbL+SvaVzQ2B1zfvwCRT6Geem0FJDSMgwI+dLpKIBAnCIUREzzPUAvM0FHav/j/m8PrgZorVHC/vuBTc4OYZ+SKnDums5x/GJkUYm+FT6cXUs43m4oawUFPePY6vC8kB/JqMcbWszkfQikeMWaTfiylb5DV3i1yR0+pvefmZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-429278a11f7so134334625ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760530084; x=1761134884;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FyldEtwp1gai23TscGVppyYlBhxGh7CjaGIutLSt2gM=;
        b=GnXcwGlgyKitNj3ZW2YXA2hYwPnZdHBBWm2PrdabrP/q9WC9CTafHziwCvIUan6WSg
         V6QHuGWFB58Vcnk2t8ROoXxZQbCDoUpRbea+3q58iOk092TWw8s2SVryCQcnCneOUSUE
         YNLZ3NGvnE9qhGbRY4/dhazUYkxp+CG6DTQ2REvu967k6fRCt7Py1AfPq7/4yHNFPePl
         ik/H0ccb7NbKqtkeQH/PH1gtf6DnoVIjo5YPpq+y+lDk7CrfbqNYnM1mX8rDJlTswa/r
         wQgDOiqd5KKtxEcZlowkG56tK7vCZKqBEtub2y2Jor4hvSJAi5U6+J3wn/1G4TB7dzSW
         XgAg==
X-Forwarded-Encrypted: i=1; AJvYcCW+GMk4x2ZbHjPy7KF6KNllArhZBBk5dKOE1M7z9GXzM/orSBOncDqzAkjtO1j3Vz9V4PVlP4B1O8JuhGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0HS//dWv1UcuF76A3VRtTZfFGy7Yc51hy9DXOmo5zCKGfPUqB
	S8UoxXJhx2NXcA8U6yirL/YiNhNn5+CihstNHX4TqzDVuojy6TEasQ2nuZpmkNUviUyEKCGQ/Ym
	FTt/1mj4ZmvejxeFn+avOu7u/lnICFF3k8c5Rj/UuqtxSdIs8uMyyNbxT8TI=
X-Google-Smtp-Source: AGHT+IFUs2xV61Zf0+jSBMVHmQegBSNxFJn0g3yx0KHfRADZU8QekyoZnHSs5fRMGIG0qh5JXRBnChYI8lOYY3pn9m6HByojSwZR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214e:b0:430:adcb:b38d with SMTP id
 e9e14a558f8ab-430adcbb787mr18702975ab.24.1760530084431; Wed, 15 Oct 2025
 05:08:04 -0700 (PDT)
Date: Wed, 15 Oct 2025 05:08:04 -0700
In-Reply-To: <f945f2a0-c694-4874-a7b2-59cee4cb76c3@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ef8ea4.050a0220.91a22.024b.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-out-of-bounds Read in
 mcp2221_raw_event (2)
From: syzbot <syzbot+1018672fe70298606e5f@syzkaller.appspotmail.com>
To: bentiss@kernel.org, jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, oneukum@suse.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://repo/address.git on commit 3a8660878839: failed to run ["git" "fetch" "--force" "--tags" "b7cf8f2fbfc36c709a08e0b9c77990e491473738"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       git://repo/address.git 3a8660878839
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
dashboard link: https://syzkaller.appspot.com/bug?extid=1018672fe70298606e5f
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13bed542580000


