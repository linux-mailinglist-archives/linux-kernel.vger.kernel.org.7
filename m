Return-Path: <linux-kernel+bounces-895038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77664C4CBFE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49286188D10C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325FE2F6563;
	Tue, 11 Nov 2025 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBsROoUC"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95F8264F9C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854340; cv=none; b=B6FRR/AnlJ+4yeR+Z1sNIFUWLF4M+Rh/BYvMMpJJBJOyYiI3CMc1PhTYHeA50uRMZR7JsRuz+s2Kpe+FppCt3/xbfXHIeuHgiugaytz+XGKvHt9XQ6sghuafMFd0bB2uR8LaQ8Oh/7/8PV4gIwd5YX6tzf5Nc3J4F0pR4XMXxqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854340; c=relaxed/simple;
	bh=gPYWZCrFWH5A95MUItopTio1Dv+bF3Yimo8m+Fu0LPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YoqfIy14ksPuo2egRo6jb9Am8HOAqYFHCH8hBV+cSLUfboTgnr4207wQPH4m2B/bHjmynxNLLGw2yJUB8eLLJ2wk51HWZrsL1IFrxO9vCLt1UyJizQYP/lPKu7hGiQTvYda/dXlE31iSRQ3psfO15tenfTw6VRxGaloA1yLVI0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBsROoUC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47778b23f64so13936445e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762854337; x=1763459137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDWEaabtponRDh5izzcawYcKRcbqPl2YaKoP5YJjm8U=;
        b=gBsROoUC9Xo1u7tpHfPLvqGhnkjjBM1XDhz2WXjEvRXoBa1Xj9DFu5qyRdii15qD8O
         TOMpVxFJPXmoGvGXlawgFt25Zp8lKQAmTzVFsqNVbpUM4/u3qAvW69LYMwaOM9fK+m2Q
         sop9/72fwLrNxEJZqq40f4+jUvh0cdpB+6jj6UeGjHCBhBIt1C8n4FVzDnypiNQe06/Z
         P0vuR7NZqnu8ssu1S7fNuwwzy+7XuMMKA7JbqcANdDAvWZncPy04h6bA96KRYhyXB5lO
         PSRLKPZsTu4ZsMbFbrcC8teRLBMOvHSec8nHHn3A13ubKZdpFegjuNXQeU8gksp5uF55
         GEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762854337; x=1763459137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DDWEaabtponRDh5izzcawYcKRcbqPl2YaKoP5YJjm8U=;
        b=OfMhQocJjw3C/Ct0w1NxTwl+lDHObyLYgOgU6Ya9wBigJ/ScFuSozONi3/EoGiW7Hw
         cr1hK8Bly9jTljNMwaIcrJba5CLDyqqA3nvtu2e3Z/+0BPKY/mFqi3azaVo88lgcX0Ga
         +RxYKhcL5vKpbpv/HXo78qJAfc7r5r8Ca11ThI2xb1N149BPu7XR1n6VYrS+2eO8Wk5l
         m+lviQ5HAgctd67xvQgdeug8n017caeuH8PPY1kpPsMr4N/paREDi9XnS7o8dmDNl8bw
         dU3KmM3oxhFTIVTTFis+WbZ9uNFdOZLAHjRabrdwvwXJOHl7uDpvVtlsBLkOuF9Yr+J3
         YKBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9taYrdWTo0A1DkVz170gyw6aMbY9BFrKvifWYto07V91uS7WZe1dXABa2QtOpH/JqUP8vELuBbAQQiOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF0C3Gt745uGR/4qCu5oWcdLo4P/OUL1yg/35NX/dTCxEZkQBy
	3Hl3iDVIuRBrOF7wtULGiII+MOpZ9PLr0/hEmBI3TqVXdXQVTaFKLvpO
X-Gm-Gg: ASbGnctGvRB/V0D1msA8B2IzUAftdcXaJIAIpVQ6N1Nhll8inSWw3g1WZTCoTz9sfOo
	BHl9hu8cQhX7kcwPKtgYuOZVZocvRQ6jGzhBVGr3htdxwO9c9iA+jHvLPf8e4ntFmKanuGQmSpp
	HGNFSGKK/cp2wZoyoLXShgox/tkpnJxa6rYA3GZX8SUKl57jR6YW93i3miLp60JR6N1Z37xf+J1
	TjZmhwtQaB2QXRZalzZNtsRUbUoH6hHMPAcifUqpuxdJNHWuqNtMqBIIbQcW4Msntq0si2LM1dz
	eU03WmL7nFrwL79HwIH9PRGsY90wOUTCxqwvsBcdt+slk29g6hf4lpWHyimMkgt6gM4/LYYoS+t
	80kjWhTsvOgv7hn+cjhkt4zGWl4dNTAuz3vnLTf/eOvhE2R4XpEB7Ff644WjsMrU7oBHhm92he4
	8Z2QdmMhWMWYg9n17qTQbuETB3WjM=
X-Google-Smtp-Source: AGHT+IExuH+PVoLExRQBwIKsEjtrfazluW8ziX/dmQroSwi+F/XKMEr1tAorQ3AKtLmRG7bYHA7BUg==
X-Received: by 2002:a05:600c:4fd5:b0:475:da13:2568 with SMTP id 5b1f17b1804b1-47773286448mr91686425e9.25.1762854337066;
        Tue, 11 Nov 2025 01:45:37 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cd45466sm359537865e9.0.2025.11.11.01.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:45:36 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: johan@kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH V2 07/10] uapi: linux: Add common gpib interface headers
Date: Tue, 11 Nov 2025 10:45:09 +0100
Message-ID: <20251111094512.6411-8-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111094512.6411-1-dpenkler@gmail.com>
References: <20251111094512.6411-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The gpib user space library needs these include files in order
to communicate with the drivers. Copies of these includes were
previously used to build the user space library. Post destaging
they can use the includes from the kernel headers.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 {drivers/staging/gpib/uapi => include/uapi/linux}/gpib.h       | 0
 {drivers/staging/gpib/uapi => include/uapi/linux}/gpib_ioctl.h | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename {drivers/staging/gpib/uapi => include/uapi/linux}/gpib.h (100%)
 rename {drivers/staging/gpib/uapi => include/uapi/linux}/gpib_ioctl.h (100%)

diff --git a/drivers/staging/gpib/uapi/gpib.h b/include/uapi/linux/gpib.h
similarity index 100%
rename from drivers/staging/gpib/uapi/gpib.h
rename to include/uapi/linux/gpib.h
diff --git a/drivers/staging/gpib/uapi/gpib_ioctl.h b/include/uapi/linux/gpib_ioctl.h
similarity index 100%
rename from drivers/staging/gpib/uapi/gpib_ioctl.h
rename to include/uapi/linux/gpib_ioctl.h
-- 
2.51.2


