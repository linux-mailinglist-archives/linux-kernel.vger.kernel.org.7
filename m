Return-Path: <linux-kernel+bounces-882124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25012C29B23
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 01:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BCF92347A50
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 00:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93305695;
	Mon,  3 Nov 2025 00:14:00 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8FE18B0F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762128840; cv=none; b=kRrhTk2bpv33f52htfjFfYFeC6RTDpaTo1HCiIk/8JdNSuUbwlym/4SaZdU5g/sFgEAsKx4OewFH/aMvxj2vdyv71qn3TC6twR66FqmEn3WDyk35E0qRPSfh2M+etQzEFgFxCsdzo88h5t+d+dBl7/hBGB3q+OPTl+oVVoGshL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762128840; c=relaxed/simple;
	bh=pE8wmq8bULXpVfXNeVtqtkI05jrh4XrKSUyVstTlMKI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ei+8u6uxFEBkW4PTjyXyzy5RB6X8knlUlKbrRlerhu5lRr7zDKhVNn27m8BPwvZx4OqFXWlJEFvAi/MB65dyz8seBaBpA/8QEQbxw4Q6Na1T7StFTXca3LlJl9ZUDxUMyVpVTjUZuPegj5M+kUwxeP+HlXF+zHQHOm9sUeSf8sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43327c30cb1so8613555ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 16:13:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762128838; x=1762733638;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pE8wmq8bULXpVfXNeVtqtkI05jrh4XrKSUyVstTlMKI=;
        b=rfiTe5yYbK8PuuYyb+nRpHRHKihpmEnklR3wMSynGJ4WX8bs++oKE+FYlTAHcknxs5
         2n+MyQAeK1VxEPBuHELq1224UZQV4+oWmbhTAYlS6p0LeUxedT0ErnWdSyTyIW3RUkDb
         3KcGO/yrWFXZUseGdnynMTfYJpN0Uj9sPVIeqGeaVtgrP4056fnFUQilUeHGUEQM00Ks
         htipFnIlP6JxUxAfRotPnl4/tAebSKJ0hQbYaCzNw2qcjZYYMRtlloDK8O+SSs/WlhXS
         G9wVXPHf2OzmMn4RDwJRUWSuG1j3uTj6DvOee7AhTrah2uhOOacL2IDjAxDU0eUdmb4r
         1uBw==
X-Gm-Message-State: AOJu0YwKKQ9qgB4SnZ9v0j63Y9NY4GE1cdWAgau4tfiDvRSNNpSuY5lu
	ia3Z0TjhhZHfHRLXM+gAN39ihpTIqUpXfOAXgz+s+oC7gz6hr+ZQlGLEklwRTvv3krX0URsWI2c
	90ggw9xcqKcHjpTSqO5dfavJKQfGFXrZCEQEGwTOHiRFM3zcBs3eI4B1gZLQ=
X-Google-Smtp-Source: AGHT+IGo7nx95SWhz1Aq5TPFRvmKKs5oY7Db5vMHYhH8kO1AziBiLPquN4udctRyiJfp19CG8sToS3O6x62a16kIymMh0TLQQ9nF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c01:b0:433:312e:e33c with SMTP id
 e9e14a558f8ab-433312ee500mr16568465ab.1.1762128838386; Sun, 02 Nov 2025
 16:13:58 -0800 (PST)
Date: Sun, 02 Nov 2025 16:13:58 -0800
In-Reply-To: <68cb3c25.050a0220.50883.002a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6907f3c6.050a0220.29fc44.002c.GAE@google.com>
Subject: Forwarded: INFO: task hung in bfs_lookup (6)
From: syzbot <syzbot+e7be6bf3e45b7b463bfa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: INFO: task hung in bfs_lookup (6)
Author: zlatistiv@gmail.com

#syz test

