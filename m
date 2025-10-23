Return-Path: <linux-kernel+bounces-867246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA79C02037
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B748D3B28D2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E803328E1;
	Thu, 23 Oct 2025 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEB4YJkx"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C0E1DFDA1
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231795; cv=none; b=A0Cv8Ady1+JFIfx9u9viKASEfKhisc0iIHrv+GHMuGsRgmo3iZgrt8+DEUrP1sdRpW9mOcSo7s1wNkHzh5doq9QbV87FasJ6+K3rX8a3EB0g5K5gtzZC+TpwLpu08ztGpeE5X/SmvjExBQPvcZ9AqCxrPILQ+aCLDAQpFH4xPTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231795; c=relaxed/simple;
	bh=cVWNGUBv5f1XokI2wDlImIvCfth9mSxGURr6U6l3IwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AaBBHU0VuYbZm/nkvHZm1ysiGG2gBfVdtPTgZseVa2zNd8tShEDobfzojJUiOlyJbjSeXbOvpx+w6DB7GL7uF8J4w8q8+jzYSj4/thMLwMzMOYcfViRoJITNtngLrBcUssfs7REl3t2bLsgPM0EgOFtadAeOhv5Waf/xshiF0LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEB4YJkx; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-795be3a3644so5494836d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761231793; x=1761836593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IDejrPpS8JKdp0yoRJvhpKqRYlatSQOWWomM9QOqSGM=;
        b=KEB4YJkxCFExPWwdEpTYf6ptld7ndILkIZLblr4jJehxBxV18zHFJ3ZadhSfUICnox
         +Hw5JOSd2XCN/htG1V+OwHfU0FWxRIsFRBvbrVsIddLiz1l54SsApuRXe4jxD6km+Riq
         IvK8bawplDJf+0yPZGiI6XtYTsaV5lUA5KuC8BlNw60ae9S9doPwpHdarkbW9gzMssNg
         tGHke8SnTw9jBvmGpFMU3axw7y35g0BlsY1ag6nPGmHWlqNI3mRw3KzWLybVLHTADjbZ
         +Lz5IIPrBjgCi/ouu1HBBHhbqPx/ctDlB0G1ekZnTbr2ZgQm4GSUQJXhBFiEVdvrw6Hr
         IK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231793; x=1761836593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDejrPpS8JKdp0yoRJvhpKqRYlatSQOWWomM9QOqSGM=;
        b=DA3bhYGhRDIRhd7lUuVSlR8iYtdwYp2+u2E5TbDvBIsEoxC793hcB5tgf+XPiMCX3y
         SE8ax7NOI161ZTdg54M8c3vkLbtq3JCh3qz3t5MNj5P8J6mcQkEfNj3erfcTNUWTs8cm
         C54XNgToXRhJ3V2aRNT0LkCdpZzf30Apr0aN9VR9szKgjchwZSKbXSHnez9yXszKEa4w
         oY+nTwIaFAYFnrbJg33Iqdw7NjnAfm/LehD9ZCFrFJrB9FEo+HQJn/Dfh0oKs5ktXnuX
         n6jVLvvne3iqwlC6dfahJi/6HzfGR2p52i/u9PmBpY6uKI+Zck+1U7k28Qurv0wyfwNQ
         AU4g==
X-Forwarded-Encrypted: i=1; AJvYcCW4sOfN/rzHZC0sf6lJ91rAyScqcXywH3GPhERetEtNdHoR1iecGjDD6GVmcXwzRkqQ/F7/73IjmuAgf+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxGvMMngPmmP8XsBxQqsf/eXxDzSZrAEpFkkQXenhMDDNKaf1s
	oUCsxfolPfGE4NCgtXbsm8O8mdp1etSMnfheYbe38pMsl9LdDD/a7/MK
X-Gm-Gg: ASbGnctZy3x38Z5OxkmLAILNpTLHLSx3VW72CDeZPQqGdIkHe/KIKCyXQvRHlTO/iOJ
	P/hfSLXv6a6V8LpvSoPJ01ebXe0DXEQ7eoDreqvHLJJEGiCK0ZgsFvjA77Tv1Ag0YMkEHL/m70x
	Dq1EOTHIfAJDYYJnFqPf+9/VCQTO92WpecjLRmXIuHARqtYIcba4vel3GRe+jmNArqV63Ne6SXg
	mCuEIvKLKaPZg+29bEMNoxlmIOevihoEJ8D+9nubxMoByu77h5xcrSXShPuK34CS/J7WeDBPAA0
	ErJlSbN4WmhP9Q0gIqnKBleTHd1fd8TtsDnPlXnZxaDWv4/BBFV0El9BiZ7fC6s/Vt6GKh9GzC/
	YLI9lrbq2VhzEJgpaS0z9PmWJi0tXwk5kHOjydeYoFFGVznkZr72wtrSMfq+4OhyMz3656rH9U5
	U=
X-Google-Smtp-Source: AGHT+IGIjOHXUHoB7tory97+mHmrm9QpKeKeYeXqegjPa/rTqwpqY/INhmbtlixC/59BqCdhkar35Q==
X-Received: by 2002:a05:6214:226c:b0:87d:e791:45f3 with SMTP id 6a1803df08f44-87de79149d1mr133613806d6.48.1761231792328;
        Thu, 23 Oct 2025 08:03:12 -0700 (PDT)
Received: from tremont-lap.lan ([216.248.122.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87f9e7d020csm16628336d6.35.2025.10.23.08.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 08:03:11 -0700 (PDT)
From: David Owens <daowens01@gmail.com>
X-Google-Original-From: David Owens <dowens@ptxag.com>
To: afd@ti.com
Cc: lee@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	pavel@kernel.org
Subject: LP8860 driver writes EEPROM on every probe
Date: Thu, 23 Oct 2025 10:02:53 -0500
Message-Id: <20251023150253.971072-1-dowens@ptxag.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have a display device that uses the LP8860 as the backlight controller.
Recently, I switched from direct i2c writes to control brighness to using the
leds-lp8860 driver and noticed that factory provisioning was lost/over-written.
Is it correct to write to EEPROM every time lp8860 probes?  I've read that the
device can survive ~1000 EEPROM writes but I don't see that limit specifically
called out in TI's End Of Line programming guide
(https://www.ti.com/lit/an/snva797/snva797.pdf).  Even so, Writing to EEPROM
during every power cycle doesn't seem right.  I know this driver has been
around for quite a while so I hope I'm just missing something.

Any insight would be appreciated.

Thanks,
Dave

