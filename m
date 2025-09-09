Return-Path: <linux-kernel+bounces-808260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A37A1B4FD23
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FEF74E2D47
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595443570D2;
	Tue,  9 Sep 2025 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3Fz/YLx2"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDC73570B4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424560; cv=none; b=hVoMUxbUlPc3w0n8YNl1aBQKFSV+JgjnLP+Uu0NgSV0E524YBdZvOHvUWHH9RTjLXYHUl4DVZydqgJbzThhWnGoxoXdO1Aj72ykzGcGWKKVr6y5vZ9QzaePBbMcHKKP5w3UQaDR9IVT4K9AxAPeeppQdsjoJznqx3Kf2kTnYtes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424560; c=relaxed/simple;
	bh=sdAUUAnXyg3K/25QJcJ/H03t1J2tpAN5WH0WT43DIUw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aAKdDAshWl+0r3AnyIIdYJGWJtks4ZkB1Wy+2x9b7MUlgfxJxH6MDHT9MmIGXJOyboKfbGrvQEzbGUT/DtKe+zMQ1D1PgAesFn0n62UBn2+i2okjwQJ/YMfvPIOgBBo8yNt5fPlr22pYy9grL6OCM+S7hxE8j60ALqpAV0JaK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3Fz/YLx2; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3fc5f08699aso21880885ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 06:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757424557; x=1758029357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrUpdS9XW8kCmiI/HdKgdDuMgaTmT22blEzvxDbI6UY=;
        b=3Fz/YLx2M8b0ASqOsObwg/F7nj6Bz1m4S5gi2raA8xXcMWalm8Vza4oIPHmgsbAJOP
         fVjQ3DXRLa9zsLK16oheajgZ1lUoH7Kx1dfepg6OiMAn7rwb+iVdWN0Qm3Rdf7EzPzIW
         5AH1DjDwM7M8WXhc6Uuhg8+ckMZ17hLSh/1oAt86eY7xXKYGw0db1TVux1ylNkQzWL95
         StKd7j5VgC6YIulq5Iaz6k+GCU3MgvZraHDajQF3s7jIUGU7cDC7K2j6EA28rOkxZTWP
         UG/2n2HTeY3uE0Bpc9RFOlIFcKrB2Nc3wEIF6gOh5r2Ns6Jysh5pDMyG23QsNs/4hIA0
         kl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424557; x=1758029357;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrUpdS9XW8kCmiI/HdKgdDuMgaTmT22blEzvxDbI6UY=;
        b=AE7fdc+F6eV9WKzuZRR1GTFKbVWrhAJo1jOsfF3pbFyb6qjFKC//+yEwHAAPAp4ktj
         pH3QIpngIv5r0DO4XxBcpRjDNi+1PvQAbYVJT0AwIc8rxHSmNvCZaI3Fe7d7nQXIAvLP
         A9RNuyJKO4vyBqJiDSIaun6iTzbI7oXMQwufqpnHhXAmS2JdiIHw002CqrjnC+2frlsS
         4L6G1p0xu7AHKCPTokY/j0g7BxfbJnBnZjncIaIdGsWY1vkRJDeDb61QxL6bx3puShoq
         +R9KXdhfSgA/1kDJeRhxyDsetcwDFK3t6XlNkS5xcg3Ng+/bE9F+Mhdessi+o+gy3mV2
         OYmw==
X-Gm-Message-State: AOJu0YxD6giGrW2fnoQT+FZVZYYbt8dVqPYIbT3kohLc3tfIXqhEZvSo
	e8oMpRmVTcnB5cjL0vHy51RqDkLhQEVPVv2IeXv3EUKdIzilFc+MdYjQ+J7uc94atjM=
X-Gm-Gg: ASbGncsUsZGRq8bJQTvsthP3Y8Dr8O6NlM4Vy45f4b7neHtRqNjEAkj1vCLC8g1HqlB
	x+Ti2xf4xxB8YcoJF1ZV6C1dQZX1ZC2ttvzJry2jNYNXbaKuNruTFJ/AUb4VbEmZsDxPqr3jTC+
	8TegB/oKPOjBPL6iTKjS7kllX1wgQXi7wVlZxroyLXarcm7M2ugoRpBF3jWV7YHHl4p/p8PCsK6
	JpnSXFlm3Ztwz8D89J0RK7ricLNFiSGpPgV81NEpipz4d1cQ758wfT08RWxAZDgEi2PqtO8/4M+
	MLD6qf7x2A1CSVyaD3s7oZdNMAnuSUlqkA1ZGCcPhuO0iEze8722dU3nJNdDiOml5kOaYzDuoWc
	rGc3S5pO6+D7UUqWkv/Zzqv+ZDm+QVLwF7sY=
X-Google-Smtp-Source: AGHT+IEIjWqcE1zYENpDxaX7YutdAIuak1sO9GmLbuURziKcQXpN8xbXlPbtAPoitLTAuWNCpHzs7g==
X-Received: by 2002:a05:6e02:3784:b0:3f3:bbda:d037 with SMTP id e9e14a558f8ab-3fd965c4d04mr182350825ab.26.1757424557099;
        Tue, 09 Sep 2025 06:29:17 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f31f6e4sm9895116173.47.2025.09.09.06.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 06:29:16 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Josef Bacik <josef@toxicpanda.com>, Eric Dumazet <edumazet@google.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
 Eric Dumazet <eric.dumazet@gmail.com>, 
 syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com, 
 Mike Christie <mchristi@redhat.com>, 
 "Richard W.M. Jones" <rjones@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>, 
 linux-block@vger.kernel.org, nbd@other.debian.org
In-Reply-To: <20250909132243.1327024-1-edumazet@google.com>
References: <20250909132243.1327024-1-edumazet@google.com>
Subject: Re: [PATCH] nbd: restrict sockets to TCP and UDP
Message-Id: <175742455632.75115.15346620038817180242.b4-ty@kernel.dk>
Date: Tue, 09 Sep 2025 07:29:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 09 Sep 2025 13:22:43 +0000, Eric Dumazet wrote:
> Recently, syzbot started to abuse NBD with all kinds of sockets.
> 
> Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
> made sure the socket supported a shutdown() method.
> 
> Explicitely accept TCP and UNIX stream sockets.
> 
> [...]

Applied, thanks!

[1/1] nbd: restrict sockets to TCP and UDP
      commit: 9f7c02e031570e8291a63162c6c046dc15ff85b0

Best regards,
-- 
Jens Axboe




