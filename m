Return-Path: <linux-kernel+bounces-828706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C5EB953F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00DDE3AC960
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0023A31E89D;
	Tue, 23 Sep 2025 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IuncMa0P"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F67431D72D;
	Tue, 23 Sep 2025 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619650; cv=none; b=V08VEZR/nmUW70jVAhzbq+fmO6M+jRUlvGy/PIlT+YPHXhWWydVgadHEdZmBCCWB8T3a6mP5Jyani7alMoKVqBzOqzf8AxYmRiOkWGS598kMEC8VF/+05rNAyhf2ZGzdcBYGvq/0TZ5+yy4gz4o+bJFWq+NAix6PMcnRNLs8o/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619650; c=relaxed/simple;
	bh=eyIIdTjx3ux5wRuz1p0zgd1DFnyWJOh3j0XIa9U2jd8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WoPVOkEeWSo4l1tXRIkkihXc3OQznU4GcholyB5h4x6AgM2AdhD7DhLjn+QGksPpg2YnrdpYrd0PJDETjuKt+5nG1/WAhocqg4Jq6yWjS346q9Nbscfi9A6tsYNOze6CAbKajs6JE6Ou5WZUA+kvgvUT8VVzFdPZEVev2roBbB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IuncMa0P; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758619649; x=1790155649;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=eyIIdTjx3ux5wRuz1p0zgd1DFnyWJOh3j0XIa9U2jd8=;
  b=IuncMa0PNQ7Igy2MNLMzkuTLnt9CQItwro1el+LVhAodhkHUt2OtDNDA
   yVMkM4Yw71/y7S033Vb6CPmkBpMGi8RdJUIB7QeXf+2THCPXkBfj2Ceih
   oH1lyMoGbMH8ZvUA2ERlVvStzAOJDSmzbIPHAawj7fxXCagZeLjAxnXfF
   Aek4HpR9Yb+/Osr6iXf4rF3djmlf8RYUMNqW44IpsfTe7Es1spNlgp1/9
   uD1+dAasUS2pvU2HFk5795HwQtpsd1VgB6VkwT72qri3XrSWdrs/3mtbD
   Xqi9XIsWymgVvSErgqtYQKqDKiQT4c2U8UFBqoOD54LZSxi6GbQ7q+G9B
   A==;
X-CSE-ConnectionGUID: nQDanS68R8G3FZHm6TOniw==
X-CSE-MsgGUID: hXKt3J9jSvKe2lVR6nUxug==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60946384"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60946384"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 02:27:29 -0700
X-CSE-ConnectionGUID: 6dUb6JBUStiEir0O2zGL7Q==
X-CSE-MsgGUID: d8ytfTgFSq664iPAid0n/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="176300637"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.234])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 02:27:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, 
 Nickolay Goppen <setotau@mainlining.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250917-dell-lis3lv02d-latitude-e6530-v1-1-8a6dec4e51e9@mainlining.org>
References: <20250917-dell-lis3lv02d-latitude-e6530-v1-1-8a6dec4e51e9@mainlining.org>
Subject: Re: [PATCH] platform/x86: dell-lis3lv02d: Add Latitude E6530
Message-Id: <175861964166.17451.18306095476735575891.b4-ty@linux.intel.com>
Date: Tue, 23 Sep 2025 12:27:21 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Wed, 17 Sep 2025 22:10:01 +0300, Nickolay Goppen wrote:

> Add 0x29 as the accelerometer address for the Dell Latitude E6530 to
> lis3lv02d_devices[].
> 
> The address was verified as below:
> 
>     $ cd /sys/bus/pci/drivers/i801_smbus/0000:00:1f.3
>     $ ls -d i2c-*
>     i2c-20
>     $ sudo modprobe i2c-dev
>     $ sudo i2cdetect 20
>     WARNING! This program can confuse your I2C bus, cause data loss and worse!
>     I will probe file /dev/i2c-20.
>     I will probe address range 0x08-0x77.
>     Continue? [Y/n] Y
>          0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>     00:                         08 -- -- -- -- -- -- --
>     10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>     20: -- -- -- -- -- -- -- -- -- UU -- 2b -- -- -- --
>     30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>     40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
>     50: UU -- 52 -- -- -- -- -- -- -- -- -- -- -- -- --
>     60: -- 61 -- -- -- -- -- -- -- -- -- -- -- -- -- --
>     70: -- -- -- -- -- -- -- --
>     $ cat /proc/cmdline
>     BOOT_IMAGE=/vmlinuz-linux-cachyos-bore root=UUID=<redacted> rw loglevel=3 quiet dell_lis3lv02d.probe_i2c_addr=1
>     $ sudo dmesg
>     [    0.000000] Linux version 6.16.6-2-cachyos-bore (linux-cachyos-bore@cachyos) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Thu, 11 Sep 2025 16:01:12 +0000
>     […]
>     [    0.000000] DMI: Dell Inc. Latitude E6530/07Y85M, BIOS A22 11/30/2018
>     […]
>     [    5.166442] i2c i2c-20: Probing for lis3lv02d on address 0x29
>     [    5.167854] i2c i2c-20: Detected lis3lv02d on address 0x29, please report this upstream to platform-driver-x86@vger.kernel.org so that a quirk can be added
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: dell-lis3lv02d: Add Latitude E6530
      commit: a15b5aefa8178846ed614745569fed0d1fb6cb87

--
 i.


