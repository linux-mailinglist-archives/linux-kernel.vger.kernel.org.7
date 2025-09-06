Return-Path: <linux-kernel+bounces-804012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2909AB468A5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 05:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCADE5A78C3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 03:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AA3236454;
	Sat,  6 Sep 2025 03:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmYJw1N/"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5EE1FBE8C
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 03:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757129574; cv=none; b=ufqT1hgBOYtuzipZtl6QHxoCFh/2byR6jvZO8N8deiBQUrXNam0ujQ1ln/ujhctp/PVyjGUGNbEMnyou5XMxRgccs6CxtIFiKu6YiNMw8J7YKBxbYGtm4kSCsNGcEKjT8VtAQ5MWQx1IoHhMSxEXYr/rl9Iowj331pHH6H0i+1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757129574; c=relaxed/simple;
	bh=XRYe6k301hVMrjUu3bWA/ITB1UE99EqwDnjHlWIAJ5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OX/Yca2i8DvbpH4bRq0UowU+rulul4p7+9NE0KVVGvUK1ZEOUyxZFLn7gEzTXNCY5gt76r/LvptZZmqouJ7ssGzNjhvXplTmcsRzPqvs4CKqjVsX1wQmiFeXuhNTTPFBwxs2EsLM4Yqi3ghVadxcxCKek2gpZ9huAxgc8jVHs+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmYJw1N/; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b482fd89b0eso2339380a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 20:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757129572; x=1757734372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRYe6k301hVMrjUu3bWA/ITB1UE99EqwDnjHlWIAJ5k=;
        b=PmYJw1N/bldRyQ/R4+c+7xDkmTZX6W+qyV6elO5LvmwR3XoeP5P12VgP6HPWWMxDY2
         ESQhUqqb4C378diRjuZUJh9S88CoB2zPiQErlEsGxFR1VfqUKM1D1IntG6Nze6q1MsQZ
         v+qsJMKhY9KKggJvL5wDPv7KUsEFTp0v2LYx8U71xIO5dqSc9t+YmHbOfXjimhXCM+HT
         LWvsUo9UOBhr94KJDaFeL9wTrQ38lP1BgBgr1giX2sNO0RNKiZ/fnOxlyeQ1V40lqVfA
         ER5deamKsFenqS114B0rgRyiPLBjw/JzJauAMWXU23q1aQ7GY4pHLvXkAaKefJQr8N7F
         ukoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757129572; x=1757734372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRYe6k301hVMrjUu3bWA/ITB1UE99EqwDnjHlWIAJ5k=;
        b=llpNENP8/lItI3QyClNTnFI0dGUijk590v2D2Rj32erQWXvyX6astJrnwXV4qDBbRa
         olhVyBj99sm26NqNQ/KmYOkCd4cA1Y0mGdr/5LmvViQSJmc8Oawm5W6kXpBEAznEp5Wn
         +zut8hobplnwVCvXn0maxTnrGCIMhjpBNLHQ2B6XZoVQvjOfadvxv01Ud06uD0o8ICqO
         OisyCjufU+21M9Y/gWSXFOjvaWBjVWM/AC2rMlENfwkPzdiNETB0rpg7TBG1XcQ1w/wS
         6u7aNU7HD3qHj5OQDaNA3LqbDEtU2OPSuPRtbOBOIZjUIUyK/CQVVkfRlPDfy6VTnm94
         RVRg==
X-Gm-Message-State: AOJu0Yyp8etkoEqP9PtRfEbM0YpGoC5uous1tu+rHHJ2HeTZNUBe92EL
	6WZKM2J3dtAdThmS8RNjQdjp2T3lsB/1ZDf6l9quB+cbC7Xycjl9UEB/
X-Gm-Gg: ASbGncuT6kQ8vI58Wv4eCklFzRrdvwwK7Yf1WCQGwwCajDbGFfka5b/qEy8/0H0BRIf
	9msghL158KPajZtbKkPCXWvx9O1GXz35jtMxomzclw8krNcH4mahqylcB3y/qTydqWSoXlk2osw
	qcbQkYmfQVHixFjQLhupdI4QQePp+s0yzKNVqxG6W0chPm1uburCk4oKF7e/lX1Ras6ZoteOa4j
	CINS21gnXiABH9vCdVoKfXzwhPlq+Xf5Gki2sVxxiAtPuYn3g4r5BH1JY3wVna0CNzxuqC8zETR
	PmEAjrqM5aWPVKhxvMhoGaekO6mPCTw+BBL0Hrs0QvFQVvnfFkiEVlSgmKJOIhV6pE2PsvMl4xn
	n8ZrTIRJmr8kRs+IY5hQFUbwF6OSMZdBOoRsp9Ys2VIZuGi6n/Q0QIS1qFpZH3I6fHXnhuJ0=
X-Google-Smtp-Source: AGHT+IFD+yJM8Pf+7CeeOLD8wDTPXIYXZQPOwGu6jciyhpYr2l3Nko4l6TlhZzxIoEVifsTXm/4KNw==
X-Received: by 2002:a05:6a21:6d9d:b0:245:fdeb:d266 with SMTP id adf61e73a8af0-2533e573305mr1568029637.1.1757129571910;
        Fri, 05 Sep 2025 20:32:51 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77248cfbc9esm18474920b3a.99.2025.09.05.20.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 20:32:51 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+0192952caa411a3be209@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	aha310510@gmail.com
Subject: Re: [syzbot] [media?] BUG: corrupted list in az6007_i2c_xfer
Date: Sat,  6 Sep 2025 12:32:47 +0900
Message-Id: <20250906033247.31888-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6805a24c.050a0220.4e547.000b.GAE@google.com>
References: <6805a24c.050a0220.4e547.000b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


