Return-Path: <linux-kernel+bounces-829250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F844B969C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58628321450
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69087212551;
	Tue, 23 Sep 2025 15:34:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90948946C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641647; cv=none; b=niYfodhwQKI4Of1ZUM7waRVpvIP+xU64uN9dkxDwyBAump8M1kct7AI65nwz51Sd6PK+IT4/hRQRcYzLbGAjk45ckvj4iwByesQQI5wHO96XurDZXjo/AW2yWlOnNETp2Qx/w+vZzl5NBmUE7fHTs/I4T5o0BExgi4YFW4liIf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641647; c=relaxed/simple;
	bh=L4Tq/wlgBXJplCI0ucRhcEwWqvx9uTyZDFnY9miS8IQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LhqpBGOf3ztBm+3N9Obocub5uUJb1TbGZksa5U3x/GY5hBYdwkTResf/nG3iWNBEjD+5ISO6nu8sac911s0LPQeFRYknHIWsd+KsWnEi21EZDgrSu1GvGquqFNBD+ZMb9bC/NOE5lZv0SMs1MDJgyWG4pq7X46t92HFKW+KE2cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-425635e2928so44402055ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641644; x=1759246444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4Tq/wlgBXJplCI0ucRhcEwWqvx9uTyZDFnY9miS8IQ=;
        b=Sy0x8uLt+7TuLR03ZTlrCZ/z90E4SPvkwXfuQOCYeJ3hS4U2Sd+/Qy+E3SDfrogYaw
         h7sn2E2k5aHYIVUimoOei5dSVMynXErCqbvsw9whRij2eM/mFKs+bqNOMqN/ZVMn+Owl
         p1XeqsFUKfKY/RQet1IRwCDG5fky1TdY+pNKxboNTgIQpuOHe73+mUiF2+EjuoTOVlT0
         UBCoIS8WDL1lHQI4QaAZgPUUoxM6GbDSl9x535Kyh1WCy2t4CB5nWnUrZxOB5GkQu9Bi
         7ChRuOCFDMD5YclgSt4h3v8Tm+yY82qm+ULaUYBfB/kwgGT3AplYR5FDlCKDZ+lu36PR
         9zkg==
X-Gm-Message-State: AOJu0Yyn59YYh8Ezczkt6W5uI4tHIbCA/mdJq0GMJ6+AQuRb6Iiggv3f
	6UsVnVNiCCuIk1VI66eEQgEey0uIuGnEaOO+O4uh7uDg26ttu5fpG4vPZuM001I1b2rzL+cKTw3
	4g386t0WaScXX6smAC26BL2oPUj4ZmfRVAGAdenfxg4ehzTK99rxqKgiIpV8=
X-Google-Smtp-Source: AGHT+IHJEhChy77IZdm4Z74ltoAjOTNbG+r/J7p82XDD7VACFhCIqe4yhm1m8aJfZvytbzuR8U4xSD1NWwzgpqojU3pIEGmXFu1f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2186:b0:411:e396:5e2b with SMTP id
 e9e14a558f8ab-42581e0e67amr44637855ab.4.1758641638417; Tue, 23 Sep 2025
 08:33:58 -0700 (PDT)
Date: Tue, 23 Sep 2025 08:33:58 -0700
In-Reply-To: <677c7b81.050a0220.3b3668.00f3.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d2bde6.a70a0220.1b52b.02b1.GAE@google.com>
Subject: Forwarded: WARNING in max_vclocks_store
From: syzbot <syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in max_vclocks_store
Author: viswanathiyyappan@gmail.com

#syz test

