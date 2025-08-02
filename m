Return-Path: <linux-kernel+bounces-753968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AEDB18AE1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 08:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8671AA26C5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 06:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5ED1E47CC;
	Sat,  2 Aug 2025 06:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WedikyOl"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FBF12E5B
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 06:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754115851; cv=none; b=YzhZVTqNCg8N5iQVUwVj2gJVV2lYRtIA4yzZptAZu2MmgejkjTxfkc014UJkm1fQf/3iOotxT0lOZsiVOLYy7ras5Dfw2G3+Hz/kMih8XY8mjdQ6iO+rAlrX+2Pf/xowFVhe6AlqPWNxH+k4dh7/3lhw4yk4ZTJxZ7eZhJHbuTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754115851; c=relaxed/simple;
	bh=Z/lFC3wcE/9vJf+O9rI/pfdUAvrWF0fzNlThTQXrkuY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p5woKdJXRfxG0nETueppviagO+WQgeQQxV+kd4q0Xgc2Z7GH+xXm0RjW4Z2d4M4c+R7D9ti99YF8bhRJjRhcH5Qu5RSxSRflwBz1iKMQ+nydYmw6AGSeK2YZoTaG8+M2ssxcLsHoRG9r1CdcIPwXmqgSpG4m924zJl4GyV5I+C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WedikyOl; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4561a4a8bf2so15830755e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 23:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754115848; x=1754720648; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JaW6Z9mIwoz4/BLM3SJFes1csza6skaZh9LB6oOgbeE=;
        b=WedikyOlNPmcmak8DKA9Fo+EINLozTeLHWoCq60rNIAgaj49ckyMrCX15J2g4FcFws
         gM3QOURw26zUVMC0aK09bZXR3sTZyK4nMu23cDsgfBJlUYQisL25BZPjIdkRx1khCBes
         38YG6Cx61C2xeTQDlYB5V8hENABJ88B9ZcrFCDShudIYjNlSGHM/cVaCvGgCF6HxblTl
         HeIun4+5AnuAXLI1vqIi9EiirLQZAJusGMBthS74e8jwe6f6B38gEfsZ+g1w/bKgKxyP
         4ohzJNwkwhoUmzpv9pgOJwyXSrll/USLhtAIPMR+sFE9l5iRlH0JryoTuYJ3MGgoLtpP
         UvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754115848; x=1754720648;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JaW6Z9mIwoz4/BLM3SJFes1csza6skaZh9LB6oOgbeE=;
        b=nX2K09Khr9cpSOVoKWDzxHoSPbFrO8lVae+34LwjkJ4KaVqXGyRNO2QoAPYSsw5UGL
         trc0gvdsNn73MK6ByjGuQAyGUYxC9g82u0hx0t8B3Nx4rVjNNR95gDV54g7h4UII5Qk9
         q1Dfs484wgV72hoUQc54ruPYgOtHONM/hraLzJO3hbM5zQ1GPB4Jh9rgYyqKaprbcMFg
         PJFNxD9t9ADTv/O27H95e0tAeFb4xm+3/aJh1lFm9J6cFZX7qldCFXNRSNQEJmRsc0si
         90tn4TZfCvKJuqbxhAEEN1W9zYpOayTwu1AWZlsnUlaXQIgh1/uQ5wltCs2Q4K+fw5SM
         PykQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeq4tj30/vvvM2o0+f6YwIF3ftO9TvYWoufPwUt/9nWz6waKHNb8MoKNqK2XuERSIIKDoedTFPuEqEZQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ09QADrx+xNV/OdZjuJoOsk5ekFnYKM2HjJvifSWVYnmafVfM
	FrFBU3KniX6odwpt4t6P4mmMN8PXVqtH7wf+MS+/a4UTbljt37qhuHk1NQYGRKJRUoU=
X-Gm-Gg: ASbGncvzkIQgiYBa2yoArayn+5uJKcFNpMuN/MvSbq0Mnl458BTCBSRGvPugRnT0vXA
	j5knJjfBB+iX6l3rRD+nOrI4VXmR6AWBWDML9tMaBrKlEJ8vhw2MN5Sa59AYqfHlvwcpWCZiDuh
	KCBaxH/0gl52Btgs+usp1iTFDhBax3Km6/AB1CHCZD/N9htaW6wxJGOZh/77m153jnr3lGiZNE9
	jYYp0b2ivX1oCH/hJ8iyL5cxucq7s0R6BuWCZhcwDH7ey1Nkv2+9qZYVOmToyAt6Tgm6rR7q7gC
	/q7/9Vqik+gCkacyBGRuIznbx7y/Blb81jrKdMABSS3xDeUM8Dmwwc+Q+odzP1k4Vb0EAHZtu4z
	JXdT5+cOEKT7wI8KjKiYkhXT1V7o=
X-Google-Smtp-Source: AGHT+IG4kq4B/k0aOy67kcdi2FASS6phoKi/+WMSCcssfYjF9DnttMupTJHXdVJRkNmINvKpdBWMXA==
X-Received: by 2002:a05:600c:6d3:b0:458:aed1:f82c with SMTP id 5b1f17b1804b1-458b719088bmr7653945e9.22.1754115847654;
        Fri, 01 Aug 2025 23:24:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c47ae8esm8050737f8f.61.2025.08.01.23.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 23:24:07 -0700 (PDT)
Date: Sat, 2 Aug 2025 09:24:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, John David Anglin <dave.anglin@bell.net>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: arch/parisc/lib/memcpy.c:44 raw_copy_from_user() warn: if statement
 not indented
Message-ID: <e0a7bc4c-aa14-4326-b2fd-7aae797892ba@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a6923c06a3b2e2c534ae28c53a7531e76cc95cfa
commit: 91428ca9320edbab1211851d82429d33b9cd73ef parisc: Check region is readable by user in raw_copy_from_user()
config: parisc-randconfig-r071-20250801 (https://download.01.org/0day-ci/archive/20250802/202508021047.Mp1T16dT-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508021047.Mp1T16dT-lkp@intel.com/

smatch warnings:
arch/parisc/lib/memcpy.c:44 raw_copy_from_user() warn: if statement not indented

vim +44 arch/parisc/lib/memcpy.c

f64fd180ec2c0b Al Viro           2017-03-24  33  unsigned long raw_copy_from_user(void *dst, const void __user *src,
9e91db6b4abecd Helge Deller      2016-10-06  34  			       unsigned long len)
^1da177e4c3f41 Linus Torvalds    2005-04-16  35  {
91428ca9320edb John David Anglin 2025-07-21  36  	unsigned long start = (unsigned long) src;
91428ca9320edb John David Anglin 2025-07-21  37  	unsigned long end = start + len;
91428ca9320edb John David Anglin 2025-07-21  38  	unsigned long newlen = len;
91428ca9320edb John David Anglin 2025-07-21  39  
360bd6c658076f Helge Deller      2022-02-17  40  	mtsp(get_user_space(), SR_TEMP1);
360bd6c658076f Helge Deller      2022-02-17  41  	mtsp(get_kernel_space(), SR_TEMP2);
91428ca9320edb John David Anglin 2025-07-21  42  
91428ca9320edb John David Anglin 2025-07-21  43  	/* Check region is user accessible */
91428ca9320edb John David Anglin 2025-07-21 @44  	if (start)

Was the if statement accidentally deleted?  Otherwise it should
have been indented and multi-line indents get curly braces for
readability even when they are not required by C.

91428ca9320edb John David Anglin 2025-07-21  45  	while (start < end) {
91428ca9320edb John David Anglin 2025-07-21  46  		if (!prober_user(SR_TEMP1, start)) {
91428ca9320edb John David Anglin 2025-07-21  47  			newlen = (start - (unsigned long) src);
91428ca9320edb John David Anglin 2025-07-21  48  			break;
91428ca9320edb John David Anglin 2025-07-21  49  		}
91428ca9320edb John David Anglin 2025-07-21  50  		start += PAGE_SIZE;
91428ca9320edb John David Anglin 2025-07-21  51  		/* align to page boundry which may have different permission */
91428ca9320edb John David Anglin 2025-07-21  52  		start = PAGE_ALIGN_DOWN(start);
91428ca9320edb John David Anglin 2025-07-21  53  	}
91428ca9320edb John David Anglin 2025-07-21  54  	return len - newlen + pa_memcpy(dst, (void __force *)src, newlen);
^1da177e4c3f41 Linus Torvalds    2005-04-16  55  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


