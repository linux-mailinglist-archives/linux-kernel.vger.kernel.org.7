Return-Path: <linux-kernel+bounces-841890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBC4BB87AD
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 03:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BCD24E1BEA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 01:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F2712E1E9;
	Sat,  4 Oct 2025 01:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k31ZZfSm"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AE527461
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 01:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759540534; cv=none; b=i7ABLU0XxJINx/kgp81cmGytuMLCLvvVyc2Q3cZZYEwfvWt+fWutdr1NSuDwDCsujXaYtDA9U0LMBsEQdTjVnbEq/VmQO7huUjJr2bji2hVMErdoXm007ACcUANxLMTcqxhYD3KCwsCBg4kDIbbmqwh6sZnMY+bhbwPDmI7mHpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759540534; c=relaxed/simple;
	bh=ozrD/peI6GWbnjfEB0am4HrVU0aHO2Cal0rob+h8+EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WE4I6drVbiEHNgfEWhfQ++bJ4swQxuK1+3tKOwA3Rz/S7WhHz/Hx1+JkOxrEmRrjiWUdHDtxYS+ZD6PbaJooi/pxh0AUadSswWXGk/6Op/j7M/qPV37XBJ3C0WXILfRtuUXUl8DIKSCfoSp46K4D9gxozQDFLtyElB2sH5egKlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k31ZZfSm; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7835321bc98so2947787b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 18:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759540532; x=1760145332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ft4oJcHCndXOje2FL6bfxG8G5ibctH8M0O2TsZseJRA=;
        b=k31ZZfSmBhYF+LpSypimkNtQ3SqtEZmF1mtB0zwblCKVzcx02P8k7FKAhhRJMeg4ij
         osEJoh4cqgdV3941Mng/lK6FRx6LYgeksKyp5UUWGiGpC8p46hlYVQ0TJlQx8KrLFKM0
         9s3oU5TPG6pkxBw+ClRwLy4I4ke48k2Cw1t7ULCheDPFJAte4YfFCMNeqFuTnUmmPcXw
         7ae1XS+Dk8eeKEIq0YH3NiHqha93mKCmXGjOFRFIVm3upvFwM2NBucUKhpIX/wPFx25t
         SifAHexwR4PETDdwYcCaWXxZaK1o7DXFPZUls65egWVr7scv6bPvNK1wpLLadFCWsQl8
         YkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759540532; x=1760145332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ft4oJcHCndXOje2FL6bfxG8G5ibctH8M0O2TsZseJRA=;
        b=rt5HIKEkgIQP1w+65ZHWp5spa7iUOHmL4mnsOzFavgIjEKvuXZOX+nVaFGfCFDxasN
         cfJOhEOi7VLqfswlJWsJY0rWBcHJm33FM/KG9dLJS8rhufPIu/Hiqur5BH/QShQB3lsb
         pfrxNEeoCf2ffftLa1cr3zfkI2hqA+z9iLMxxtVI2f0a3USk2IIxXJjEihvbtz45ucHv
         cMn0/n01gmiTepNvfHYmZVtET0m63M3mfuWzyrPhGC3nq29Ki9Ng4Ne9nvT3VHvOzC48
         b+zSky5LKQOBZr2iF4XdkYynOLJkmKL6WTziEcfrCXyQpapn+67pMKvYH3CeHdm86Ylp
         9G1w==
X-Gm-Message-State: AOJu0YzWhZ7eU8QdMHBK6IKeQ501lCrMpJ95Eh8uec+MiVzwJwtsU1qR
	bORi9zhedeZka+3EJrmLxhCEydHWM2Gyo682IWyCc9gB7a7Arfv25psx
X-Gm-Gg: ASbGncvPb4fnllHfHaJQTuPWKwyEpXf+vtx3QEovHmGAnWKkrpf5e8IvdHAsYO2a8NU
	FLczle1FPeNScDHybL/XHTefbx3DUtkmtE/YPntphw0HKFSM0CfSfJed5gYea0lT8ALMinGd8mC
	8JDl24vkgfwUG6Ta/oHXJFtsCMqZnN6/xaY5I2BYcbW2gbrOVdwTzu9p9TcCdN0gFymCl3yprhX
	SzT2mdjoM5gcmtcopMCB0QADgJxsvMZ5cZ0LK3f6m4vezmlXd0L9VQFUwiWYjIafqVEj81j+JTY
	cb6J0zlmHoremTSYOF7IK/4BCrroSxTLbH8cRoydBV1pMFv9TmBdtkTVp/mvLnPRRp2svMj0sIL
	S9JP4ZTkHV2WIH/l93H9xWh3jvuBWi+C05D9jIxNshI0cLEvNicmWp6XGgqyBJoFyXej2fHW7ii
	Y0F/lLlMYB5MthHFOPmF6OkDlPHdQ=
X-Google-Smtp-Source: AGHT+IEyCHmvms5vErzLy5gTZbE16mnhBHhNhmvwIzKJKVDW6N1jGKpi5QbCIBUQ7oN61aL3umREug==
X-Received: by 2002:a17:903:298d:b0:264:70e9:dcb8 with SMTP id d9443c01a7336-28e9a6fd918mr56953665ad.55.1759540532424;
        Fri, 03 Oct 2025 18:15:32 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2401:4900:5d47:aa18:ed90:18ec:5962:971a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d574csm62324145ad.108.2025.10.03.18.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 18:15:31 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: abbotti@mev.co.uk,
	hsweeten@visionengravers.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] comedi: fix divide-by-zero in comedi_buf_munge()
Date: Sat,  4 Oct 2025 06:45:22 +0530
Message-ID: <20251004011522.5076-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hello Ian and maintainers,

Just a gentle ping on this patch. It's been 10 days since v2 was sent
incorporating Ian's feedback to merge the chanlist_len check with the 
existing early return.

Please let me know if any further changes are needed.

Thank you,
Deepanshu


