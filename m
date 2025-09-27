Return-Path: <linux-kernel+bounces-834747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C18BA568C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 02:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F846C0986
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 00:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B85282E1;
	Sat, 27 Sep 2025 00:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ji76DU+Q"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6424C188CC9
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 00:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758932302; cv=none; b=HRqoUQC5vlKN3XSQDOV1OytPyUtMNEvA6vMBT1eZFV4RIzh1en3FfobVxMT6Kt5vrnqYesUEhrsOij6tqa2eQjlL9LbeoM1iAJgSPM2+sGv8+VA9mMQtJSXvEHmNTYPaNWzwjovFgNO2gdAB8AOiG/asU9HE77poSrOnOONmX0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758932302; c=relaxed/simple;
	bh=OCMM1i+marxjh6pUkwTDhMRBuqlU+02sLHnJrahSSHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GiWUc6FgTrYyzbT4dYzATD/Ppg6XBkOlYukDaiHigtCQ+2vnj3KSWgcr9TMWZ32+6lD4f5iyU3tf2iTXxAtffUxy/VgxPevaKE5llIOCj9WGE5iPjQmI1aLmUZWQ6l5knMCd3e0F2SGnQy6s53F48kdc/shnUOJi4HNMWJyQRig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ji76DU+Q; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33067909400so2059843a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 17:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758932300; x=1759537100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xoCdX6M4UpRUuPuNk8r9g0MkweOF1WQ1ahjsQ+1be2I=;
        b=ji76DU+QqbB+DgNlMxXt2KlSbBre8YycpupJP8mMKUOXqBQ2/QjdZS3HjgAfAMq5K5
         HPFYBqOEJ6dyhgWxcCr/foew9HGtqbkSbakhCf9fk/JGyOA03XTgcztfjKtTSW+VkRkN
         xwY6VvUKmYbvw25D5SzwXltiiFQL602rFGdIB4R+0qiU+ovfHlEakqN5uX1I5jNi1aUo
         fLATDnxZ5unFzWRaB1ntHV9jo+/IvZZDCdptPSZJuJdBW5Zv6wIiD7WvLW9nkfy2Tb/g
         uhDWix9ML8rydZqSCfjbZYVJzjTfPnN8dABdiZ30RR42XsGgosfoFPHR7z5EtTIYPUoR
         mcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758932300; x=1759537100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xoCdX6M4UpRUuPuNk8r9g0MkweOF1WQ1ahjsQ+1be2I=;
        b=N1+ZJ0AyzeHusL+3sinLIjVCus31K517xpfE/ZHWOtuGD93YpX/7lUOgpK5vynldQV
         OELL6dHuaAcZ6cDrR2PeD2BuCHkA7LT5tIQ0MmdOyKrvxfFtXPAm70kjwBezVM0CPDzW
         kKQa98DS+fxfhJrxYVXX5IIhWLuxe/KqqBDcYDbdGGd50xCgUyBlxV9W8maGsV4je8Kz
         MBTEUTOLqmyqzlFpgonfWgiqXVmZlJmlSRm7nQF40ZC0PqBXxxgtqDCJaZ7Bndqh9LuX
         t5NBCkDuqohhAnOXbu5VqJjk45NlvLQlPsAdkz/Kp8pC7XW88buuPq/27OpVYtv5DNk6
         Zq3g==
X-Forwarded-Encrypted: i=1; AJvYcCXtfnnwvcTxWrfiphgy8XvDaLE0lbLDIfc9oC1npMavqU41/8spE4/5SN6B1gjI5kTMXjXm3wAnRK1rAsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfZ53ETre1HfzydYDWqfW7zqi4u5AdjaH43eL2X9vefxKiFUjk
	LaAZhNsRZ9LFu7x6ylCmE74uyl7EVpbA/UaOtTrw0JMI3RbYoAZbIAva
X-Gm-Gg: ASbGncuzFsNVVw2MTC8v9i7xVAtqdg1sSHDONAGxPKyAxhYUt8p556p84MEHgydmHzs
	iDuFkDecoohT0IJphyrmF22t0Q3CNA3ssSLgnG0tn9geLvskUnzkjskz6sdTrUaYjhI3rBtWSZ1
	ataY1ymeo53TUe8MOiUijmusD1JgZ7PD6IpjC6oJ45QToQPiZL/kQ4Ylq4UZzxkoRtB2+ktXpae
	3/H5SJ05fj0ZBJHiZw7HXS6tWbcLxjdjuNrQ/X0bT6+nUSsMxfwAltwR5VXORdZbwezY1ZknaRd
	lw3bqirAGM5xvpxKf1h+u249bVWb8bG4xyQkjr8bjGHh2Jq8YeahArv7jl2OxLqpo5AYQ1iGGQg
	OHib1QkoX2DRV4W0CLkncRwyNa72l3DYZM2hhU6PQTZmcgATcuusIbGyK/MJl0BzE5KIKoyGC9m
	gqdrbQy30RPSpV
X-Google-Smtp-Source: AGHT+IE9iOU0xGbfc6wu5KJMpk4TLbi5OzVytsj49pIWcOaRGPjom/RdtIiWb7W0JE+msvBxROCd0w==
X-Received: by 2002:a17:90b:3e83:b0:32e:389b:8762 with SMTP id 98e67ed59e1d1-3342a158113mr10059781a91.0.1758932300355;
        Fri, 26 Sep 2025 17:18:20 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:9584:386:9d60:7b43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-334352935d3sm3151967a91.3.2025.09.26.17.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 17:18:19 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix allocation failure in ext4_mb_load_buddy_gfp
Date: Sat, 27 Sep 2025 05:48:15 +0530
Message-ID: <20250927001815.16635-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andreas,

Thank you for the detailed analysis of the tradeoffs.

Looking at the syzbot report (https://syzkaller.appspot.com/bug?extid=fd3f70a4509fca8c265d), 
this WARNING appears 4 times, so while not frequent, it's a real issue that occurs 
under memory pressure conditions.

Your -EAGAIN suggestion makes sense. The approach would be:
1. During memory reclaim, use GFP_NOFS without __GFP_NOFAIL
2. If allocation fails, return -EAGAIN to let reclaim skip this inode
3. Preallocation cleanup happens later when memory is available

I understand this requires modifying the function signature and updating all call 
sites. I'm willing to do this work and properly test each caller's error handling. 

Questions on implementation:
- Should callers like ext4_clear_inode() ignore -EAGAIN (leave cleanup for later)?
- Should callers like ext4_truncate() retry or also defer?
- For the unused "int needed" parameter you mentioned - should I remove it in the 
  same patch or separately?

I'd like to implement this fix properly rather than leaving the WARNING unaddressed. 
Could you provide guidance on the preferred error handling for the different caller 
contexts?

Best regards,
Deepanshu

