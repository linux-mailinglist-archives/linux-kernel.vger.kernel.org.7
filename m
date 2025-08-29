Return-Path: <linux-kernel+bounces-790962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20739B3B069
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4CC27B21BE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 01:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2292222BB;
	Fri, 29 Aug 2025 01:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQB7p97b"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7EE219A89
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430599; cv=none; b=eROdSGwLxYNhOmkBEtAVejHB4HIA8xJ333EF5ceDQo6Kz/Ej0b/A7wm8TYlFtmlbPQ+9HTxUpg5FaWZezgR/qLZOwPHExfRXnluL2XJVXXJNnmB8mArSSOmB5Tnl27PxncT6FpKvPeMPtng86mArNXZF2+x1dP9tmj6jnEBgTXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430599; c=relaxed/simple;
	bh=wFobh2ikRNoFGCtqUBAYK6BEm5r28M7qwkKY1uAIfJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QW+t/D7Az5XI/zQi0+tLWwIx0YKO160yGO5CBz6tFrNg9o52XwltxXKf8sMpI5OWVxdOi8ZF2ZfWX61P7Ay84r08tIlKma7xAWZvUdDQLJSjPxOWgWgceywtSSLfNIEX6NpR/lGV6BJwtg6tjA7RsWdyfmnVbL4vcKjOGdRe+9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQB7p97b; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24664469fd9so14765575ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756430595; x=1757035395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5etRR+Xxyc8+k96JgNEfZBUH5eJcJpsRvKz1dcHOpK0=;
        b=SQB7p97btCsEqcbnNLKPAGesxhm1RPlxBvNXfhwMHg937a90r6JkLa0Hu8og5JaxP+
         Pp/DPPo9kIosWiJmNpDauuz/FTjmu+RkN8kzItNqUUJ8Gn72OkOTP+Ec5lHUHzijfT0s
         umR62yOjmjzboUMlwFj9JW73y+GYAk2iLEYP3A3nMv/x+4WQBoq2xmuZ4icOmNuTsa3W
         PUJypzRPm/9upX9ep5hbvqcrl11srLCS/je4moXFz7c2YKawCBAO1svjKb/S1wMVHLCa
         E4lsETqgYFky1YHlnyL+j09FF4MDOCZDRm8MOl8F71E4z94AkmN+gaQzU/LVQ8TVQFiE
         1j9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756430595; x=1757035395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5etRR+Xxyc8+k96JgNEfZBUH5eJcJpsRvKz1dcHOpK0=;
        b=ACc9t9/t2AsHK+ornlUoV8Ta4XcdxXOcIoXKZfoh75/cmEbyHX2hmu6ncxa5welCUZ
         qCm1LcipZwFAtogqDZ91LgXtf7WTW0/2062iv5FrGlXKYO5VIjv0JT8tbS4lQsj+apr4
         dxUDglk+mCjVJwi3F5HWMZe46WpSR0T2RzhWz4PJF8ruOkVethBks/IjBwmZuEh2UMI3
         xl1ZJmztdJ37vW3wuZwRJWEjDVnSR7iuKIGgcuDZBNeRWy0vo0z3JLwcGL5Zucnd3gea
         5r284mnTzYvH2OEinQQKI/ZAtoFkiSxm1GIY7rkKzlt+1K1egStA2Sqi0CpOHuc7v4RW
         AF+Q==
X-Gm-Message-State: AOJu0YwjkgWLZmpafo6AWCRvOQDkUh1HN3hfFbbxr8pJYnf44P02VTAe
	zryP6dmqxnoBNxntxn4mnQ83G1y3BS9YHV9yvIuHb1r17wwdPeETibP2
X-Gm-Gg: ASbGncsIhkTWlEiYB/uOMRWDkfUI+7tijGdgmyOQMGqlhXW3Ma15UoMlukl+5Hm/5he
	z8hjF+q1tiUgZArQnmiQ5gSZ/UzUnFMzCWYNsfZ2ILZsuU/W6mfwjMWrXD/aQ69QjuxruEJsMAx
	njN2EZ+f5OqnDY+qPkE/LYmOXB2DfQz+9c0Y+1paqbDHmPGRAIv6Ic3mlcijLKI2xO3LWiEdL9Q
	qr+dnxVhFGRYLBXh61+SPpZI7Jrn1LRZJvEvIK6eJNxaASu2NZyX2Thi3lGHjtcELarGMJkAssB
	v3C0mfsUS4l3Zmh6dNlPz4zygBaoi6iFyUHbo/YU9Cc67HHuuBaFpij3TKpwS/SSXUASXuARt8L
	0w0NiHdBX6d0R4wqKixbc/JYSOarWb4Tb
X-Google-Smtp-Source: AGHT+IFOL5/8jeKRLI19TqHM3mhGBgfETGu5API3EikerDK+HmoLabzoy+ZWuskuyafiE0eUmMNp1w==
X-Received: by 2002:a17:902:d486:b0:246:b46b:1b09 with SMTP id d9443c01a7336-246b46b2296mr246876345ad.30.1756430595128;
        Thu, 28 Aug 2025 18:23:15 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:500:7a9f:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da183asm7686885ad.74.2025.08.28.18.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 18:23:14 -0700 (PDT)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v2 0/2] i3c: master: svc: improve IBI handling
Date: Fri, 29 Aug 2025 09:23:07 +0800
Message-Id: <20250829012309.3562585-1-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve IBI handling to prevent certain error conditions.

Stanley Chu (2):
  i3c: master: svc: Use manual response for IBI events
  i3c: master: svc: Recycle unused IBI slot

 drivers/i3c/master/svc-i3c-master.c | 31 ++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

-- 
2.34.1


