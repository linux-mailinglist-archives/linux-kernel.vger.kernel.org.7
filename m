Return-Path: <linux-kernel+bounces-894165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C698C49652
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A96434A490
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC462FB963;
	Mon, 10 Nov 2025 21:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKohWu4L"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A8E2D94BB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762809859; cv=none; b=lGGBiptebITgVVUIkMD1A/aKn3KP1yL1tUMpLaBBrace329/6G6o/KlWjDYpwsF1FJkMayNlyaC8jSPl3TjrNk2x0gvwE87ZHJJGds+EVCG6ZVU2YkA3Sufu4JyVVd8E3R5x43NXUDnno3CKatMwgMtlakjlN+j9o0fJFqXwiMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762809859; c=relaxed/simple;
	bh=ILC8EqHycIViJiTgFVW7YCn5z2UrVERqAStRLuThOis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CT+/jYHToHOyEMdfPHpVHSHS4yM5K0Lbq+sC4Li82rsK2PhHD7iGC0AouMPmHTsKjbyQBgG1EGkfiZXlhVPbOqyE+KtpJU94IWRycMgCRyO0I7B2W1xuJ2RUCEAPLhJZPHmnPIwBV8UaMLvP4INC/Twk9y2JKTLPnP0Ifto96MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKohWu4L; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3437af844afso1984945a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762809857; x=1763414657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k6duLziMK+VfzyNFuW9Lctu3y2VQtauByfZYpl4hDew=;
        b=gKohWu4LhH61N44Qyuk+1nlcmvx9B9BWxGqI6aa16REw6HZta/siq/bDRVOqdGElsB
         n6E5nL42OTtNC3fS/NNMILT6Gmr9w3FTDDU756kZjQg1IkEt+yypcDO/lDZR2l3Y13/c
         b9WKGeXPgFaJirXGeCHn36gmoKzAghJMspry4rftU96IlrALe+f72qSfyduz9qOCaCYA
         MzNHMq40zhrN4qMKQ4/vNl0mKzKZjaHd+4c0BBnQ8ZwCSy9bPtVE4YYFKEWVWkpAk2sv
         ASRKKxHDwx9fTM1FXkh/AB1FTJgkTSSo/FKAWI92fEHOjcIfJzoq9OETzZZ1URIK35yW
         BxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762809857; x=1763414657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6duLziMK+VfzyNFuW9Lctu3y2VQtauByfZYpl4hDew=;
        b=s+yTunzMyvNlInjfdxt+C6uz00ZhfxLBUnP8WLj7kwYfhTBxm2mKWmpz/F5FfWv6er
         uW+KRsbv7r/GCBdSrRj3oYf0z8bFur5gAmpSzXfBkemIwuDmtn4hKMxTK7szueuXQWPE
         t257FwKqPqNIXw9tqUlqavUm2yEOQojsWlTiODgWtlFmhX5yQlmFbI0QQEEUYEU8jfId
         wv8C8hFOccLz5u3LMVtmwyUEl9U5MeS7tymLl0ef9WFD4Tn5dHB/iUQCFpW3zwSVphQI
         ZT+KsDFY4Bbw9Ez0aWmFufBQyBPufus9f+woHjOjBPJeSfQy9ve/Nf4zxL/18GO9M03k
         rLpA==
X-Gm-Message-State: AOJu0YzkrhPKaws1utybbu5cXZq/RTld85MohWGUKBpRxw3mBaHm68st
	ssHrezBAIdWD6fI59yFsTSUzznakP1t+FJIf+CfkUeI1wr+07E16YU+PtHbP+w==
X-Gm-Gg: ASbGncvuU1em3CWQH+8v9hVa3L6aukKkYDSKRfJG8xrNQNxqQMNSc2aVrM///uemGbQ
	Y5zPWEUFbUqNQav3GXp1avv6erOh3QSO/loU5fjebTYVicjL4Zz8jMwMeu1Omg9KFcEJ2QgHbjc
	ypgbfwTlvRO6pf8sSJ2Ocwg8oLEQukfV8WjwF0p0xdMWmgcAQTvGNJJV9XKOtyf0Dk8liIHZZ+m
	X2hQEcq0bwHbCbnirhI66PydOZD03PKsAA7vt66lYiLUJTlt1jsXz/FDmqYWn0keuYd04QnDigL
	G5El+yq0++oMtXAc8pUgDa8kNodPmgwl8owH45/GZjcANEoceevoRjlShSqJUtDnAPz1fx77zzO
	5yVuZWkWxdv2IUhZEla0UQHw3b5ZF5HEmx8bncwJmY8w6qyS7WfsZMAn4bQ==
X-Google-Smtp-Source: AGHT+IGMVCbpScz+xrgRo+0WUNSGa9ellSVQEz5D/jFfoQqmJSKuRToeKhBqwIFG5sBlp5pSy0IPyg==
X-Received: by 2002:a17:90b:4a8d:b0:340:f05a:3ed1 with SMTP id 98e67ed59e1d1-3436cced91fmr11367730a91.21.1762809857052;
        Mon, 10 Nov 2025 13:24:17 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba902c9d0d4sm13174657a12.36.2025.11.10.13.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 13:24:16 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 0/2] firmware: stratix10-rsu: add COMPILE_TEST support
Date: Mon, 10 Nov 2025 13:23:58 -0800
Message-ID: <20251110212400.282952-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

First commit fixes 32-bit target compilation.

Second adds COMPILE_TEST and cleans up the depends.

Rosen Penev (2):
  firmware: stratix10-rsu: fix 32-bit compilation
  firmware: stratix10-rsu: add COMPILE_TEST support

 drivers/firmware/Kconfig         |  2 +-
 drivers/firmware/stratix10-rsu.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

--
2.51.2


