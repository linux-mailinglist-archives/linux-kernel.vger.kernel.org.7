Return-Path: <linux-kernel+bounces-835403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5261CBA6FEA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 13:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D741894B86
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 11:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F072B27E05B;
	Sun, 28 Sep 2025 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcX3vygr"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C198287E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 11:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759059248; cv=none; b=nGEEkoc+0nngfAinsY8ahQun5n7On4oiQyUKm+F4HEBjtNLfROQjiPbnJ4HtZm8AY3CtSKfiNOWhBIeM8VlIvtpVjqWRKEg9MTbx7HIpQWpRTAJBJKhSuNATrz0jsEi0Fupmof4ldk4gwfu65rWz1kDf5wZNMTCilLKb5Hca4Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759059248; c=relaxed/simple;
	bh=4pEzXbyqNaA08SPPfKeyNhR7oN7okL0k7w6lDTJ3Vao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a5C4KedHiz7hCIddruxSQDrBvtxMQHHpS2NOo0IH6BG48gfn/dbZ2VMAueP5AZEOiX1q+KwAZpYXATpL4kHaWgNeKcLhxXiqoS1N6gaoXHslJB68bpyY08G8/MdWZ0I+SjEvenXGeKEdQjx4S47+RODWxrxwTga+tZJQvQ3H1Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcX3vygr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e37d10f3eso24882385e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 04:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759059245; x=1759664045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tgw6TjSJVeFP42Ff9QkzhsbHEBT9jT4Y72Hq/p7Nq54=;
        b=bcX3vygrPWCt4uqtr8xRrFuO/K9QRvaHBwPx5G5jYWSWoKd9DyPd1frjhHRfN76IO5
         RIZDjhiS7dQDXsWbbJ3xaRE6TvSUI1QpIppORzeTGyP6ieKIpjWpWebjgrW4cEdKkBah
         k7Sk1D0mSYoLmdpH6vnt9nMwvn9/LI8qA0db2hedIvs/OLWaU4iWwnCIqGAe3LON0GEQ
         J1JLyE68ymDmKX2CCiZaJLvXxX4jqDIODA2vH0iFR6y41YNP/7w+m/Xzys9mbOxvn7ri
         cH0Q2unjcU0wWEJdiThT6JXNrDKAkyCCj78lfPZ+shywo2FGZJFuKgfVpdOcM6jpl5O6
         KdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759059245; x=1759664045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgw6TjSJVeFP42Ff9QkzhsbHEBT9jT4Y72Hq/p7Nq54=;
        b=Dw/OHqybxqVMEIc94qzCNy93fbaXXyT2F4Gt074rG/iFofWJRTwTWUWRA4sO1lxI2s
         2CpeNeHrR2T8xi4O7MdVdZR6h8ZkCdX5qcEK2LQThYwH+1YM6iQ5FzBMeO1ceZVwoYg3
         AjFu7kjBOn2OuNadyRnMm/Gnh8gRceiv0wWAGekFd5mpuvH1Sgv/RTp7rWyTS1ZbtAPc
         ySYw1R88YagaBo0yxjxCepxx4Oe04N2ufP78Y6knOO0ynO1yBQI9twV54YQu9eMsu5oO
         n9OwCsPYOZ0uVFQlud3CHi3r3fzAOhAu7D+AD3diWmBFqXZhOrES+7mkKeYztlCnZcrO
         PwCA==
X-Forwarded-Encrypted: i=1; AJvYcCUBi4VxGfw0AOFjt0EHQUngbuv99pYKkJLmo9hp1J2a8tWDT0DmDD4AwACngT2mc8lUsFLbFNDWPpNaHwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw6x+T5bQNrj+Smt86EXNtStTUGMMeBD2tIusFssdyEH/DmbZ2
	KrPixUWj8+d0r+xEsdcX8qxMl7oVSV4XkKid4MYslOaiyQSGV+frSM56
X-Gm-Gg: ASbGncsYlJK+Q2EtZGbr25c4jamXKRse4YM+/MVNbmynfIlbyZG4xgBN3dunIOUZlK4
	9Ei0gVf/1N4XnUU4IMGH8SvvyQLSImARNGFPlOn3ACb9oQEgIH37tOA/CG6AP0LAC7obEgJxuid
	2cuRYqRmgc/f3IG0BUWEByNVJ3HtzPRHqPhfHW1gAsTl75y38RfwT0LE6gJs2EubV6KFzkH8ZUg
	V7r5+ewO9BWw3PnqdvUz4VhPa29KtvhLzbl7rhIJKXLSGibNDpvZrtjxJTx78jxgFCoJf0tbAW/
	/H/xHaBABXB00Ndfb7xSKUcf1bdLUjdoHh8E6O6MgvpS2evp67a/xRhIDS+7p5BBFNFPTVT2s4V
	0ECRA+lGWkX6FYrGK2JIif9F2QKZ9Zsii7Wb0SA==
X-Google-Smtp-Source: AGHT+IG/rzcz2uI2Na97ExP28EzFCPCjQ1Y1kmUih3xOPsR80Z5IybTMgEWtmNWOKR21alHBoAqfjQ==
X-Received: by 2002:a05:600c:1c15:b0:46e:3956:6810 with SMTP id 5b1f17b1804b1-46e39566c90mr117278375e9.18.1759059244915;
        Sun, 28 Sep 2025 04:34:04 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996c03sm187074365e9.3.2025.09.28.04.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 04:34:03 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 0/2] staging: gpib: Handle device clear and trigger
Date: Sun, 28 Sep 2025 13:33:57 +0200
Message-ID: <20250928113359.6197-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses the handling of device clear and trigger
commands sent from the controller when the board is operating in
device mode.

Patch1: Send device clear and trigger events
Patch2: Return -EINTR when ATN is set on read when a device clear
        command is issued.

Dave Penkler (2):
  staging: gpib: Fix sending clear and trigger events
  staging: gpib: Return -EINTR on device clear

 drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

-- 
2.51.0


