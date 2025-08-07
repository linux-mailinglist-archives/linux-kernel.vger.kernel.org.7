Return-Path: <linux-kernel+bounces-759583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBB6B1DFB1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE8B3A5EE1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7C4227B83;
	Thu,  7 Aug 2025 23:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="2gv/qL+6"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6BE24B29
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 23:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754608016; cv=none; b=WUibb9GHA6KJB1Ys233ZfLN6r+tuywvxzR6OXrdM57zbvMgVM4BC/ZKtaaFro3aXCpKWY2RUREw98lCjB/O0fxEM2KnS1QO2/grCjCXOIdY4gmNMsCvm7Gl2JAQDKPwM+v+uLVHpduZ9XpoOLElkV2Omsh38CJhQbxNA/9v389Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754608016; c=relaxed/simple;
	bh=NVOuYC3xHbyWujKXJL7jLfVwx5wdzvzuq0RVO6u5wOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ioQ86ok+e0WyzDuNFWSLm+6ODOvW/jfceRc9f2/5IKnRWV6WndPj8EKHRppW//UyMvA7f6qP7LH4hISPfisX8gBQHYT8A9DBk7Dgo09+wZPpcxZ67FQJc6Yv3isGRdH9d7Q0iVEFlP9Lqbg2AgrBwc/07dklN7aCf8wFcr0qdFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=2gv/qL+6; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-742f983e313so1270110a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 16:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1754608014; x=1755212814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=75Yx08DWsWdAobw9dHH5zVWLwwU9BE9U1Hzf6cU/Nt8=;
        b=2gv/qL+6G2DXmEXFZRnDc2/qfOLr38lCUh3Bz9yspZjeFedt/PVNfsOOJ2a67bcEKK
         5aA97GfuWmSqXqad7b/MLkh16F2gHUYeyUhwKIq1bvTlckMdDR4COPZvWM7ES5OIyRcr
         xgAeFdI8PqT9xUvuVZLQuMtc5K3cgx/0F+2jDa9XfcqBst5gZOI/xUCjSCJuhOSp42Tz
         9e2JwURmWa48TwLaXOS04OhMhg99GDgd/1Rt5+McSgn2OTCLD/dxJyQ35TTGNPI3Xdi1
         CHce9Ys6Zkcwz3ZJY0IO2OgaQLEf0gaHPE7OZdpiGimiWuyBOqTLbyMlwr/AG5OVXCdH
         g3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754608014; x=1755212814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75Yx08DWsWdAobw9dHH5zVWLwwU9BE9U1Hzf6cU/Nt8=;
        b=qLCWXK7ZonzHMlt7fwRwYSzeN5BOuq8r3EgObWRZKOt6I+z0fxr3XIzTZ73xt1VSKT
         xZtKYaPCji/4lKMoejhiBbg8p45dWD0aj4hXiK2a2nj61XGg+5Wgm49PX25m87EqZnvW
         gkj3TKXIZwMqtIbn4huKqCmR/Jhpyt7DCDLOXPfCKddh+uZiZGSwXfKk+/lHj9x2i3za
         /75ZizbsEfzabQf/AuqJeMx69H+cuTK1NqI24L089GoDAs4Kguk2O2U+HrnJImTUFwBQ
         aKCEgY3AeqyS2PXj9LOWtnEocXPoNyFa1o1rGFLM0l26SNjnLUkG/L6rBGJgbPHPNH9R
         kWdw==
X-Forwarded-Encrypted: i=1; AJvYcCV4IflurNjZVYnOidIJmJ7839lawES+NqrgIkmGPuO4WzqBbIoUoGlLCldLEwA1z8JZB6lKUfpK1GNet6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0L/esU5irmQdayG7/ZV+lrD3Q8/piDNHfVO2cZvzu9ahyAVqb
	HZcL+QxAjXUAcwvMY/e6XkQKl9Uan+hTxuBjaWpK/i6S9ZMehDpGHSdIe8NRnPhsQTk=
X-Gm-Gg: ASbGnct6eyHqLvam1+pu0z3DQr7T/tz2GDwxuDprI73ylwfWNTToqRBjQc0VuJD5FbD
	tMBAX4zdjECvx1FktJoXfc5SjcjjwN3NUPweZmsQBKzLNsopudzYc+4tt3QwakNXiqYlcrP2TeF
	xcEPPbo0L1k4P85qAsOb4IqpBgeNIQQwHa57M4hvVRsFEmiwqm1T3G/wtviotO/NveVh+lpXDh6
	AadS6jQnuARPqq2SZNSet01kDHjJFW7r4k6Oc1ZGfsHd0ahKIfm2knZrxyowzvk3l0q/PaRx3Js
	Bib6gn6Xgi9Gv3CWXFBp7HrKm9oIjPymRoERV6HqlxpE+0Wpw6x0E5WXsa9HuMbkjSLoKzSOyac
	Z1rrLjsCYvI9YdR7Y
X-Google-Smtp-Source: AGHT+IH57LnjubbD5UYK7L15NYiY7VlrhKFaIgo13Ia+wW70HiUgMFbemwc3ZpgTi1ORzEyJu7SgvA==
X-Received: by 2002:a05:6830:3c1:b0:741:9e2e:863e with SMTP id 46e09a7af769-7432c86b6b0mr530342a34.13.1754608013676;
        Thu, 07 Aug 2025 16:06:53 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:e698:accb:897b:ca29])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7430a0ad042sm1386716a34.6.2025.08.07.16.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 16:06:53 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: Frederick Lawler <fred@cloudflare.com>
Cc: openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: [RFC] Patches to disable messages during BMC reset
Date: Thu,  7 Aug 2025 18:02:31 -0500
Message-ID: <20250807230648.1112569-1-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I went ahead and did some patches for this, since it was on my mind.

With these, if a reset is sent to the BMC, the driver will disable
messages to the BMC for a time, defaulting to 30 seconds.  Don't
modify message timing, since no messages are allowed, anyway.

If a firmware update command is sent to the BMC, then just reject
sysfs commands that query the BMC.  Modify message timing and
allow direct messages through the driver interface.

Hopefully this will work around the problem, and it's a good idea,
anyway.

-corey


