Return-Path: <linux-kernel+bounces-836663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CA8BAA405
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 20:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990A2189B619
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D3622B8D0;
	Mon, 29 Sep 2025 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="Rzvbh9FY"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFA8223DD0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 18:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759169188; cv=none; b=N6/4XNRor0zdOSGLCkxv8uy9QFnwoQHJQa5mI7A9qVoeHeGdWPd3dqN9iTObT+Z7HwC46uMBPVvJEAe5qpoEHaEE4KSWpWaFviZJJc6P4kB88+P+OWHxnfmBfWSHw5FtlnCdUDLdmRGjNHXvRqPtRgioY94N0HxCtFLYt5DEgYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759169188; c=relaxed/simple;
	bh=CllEzYaABmEe25CfR8zTqYyf6jhqRbzgE6ZATTipq1k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GqB466m7q+d2BabV/kgRH7Zg5gq0TPqtXFQm89MW0FwNRLTFmGj/oUVmcpV3XU9dF2+NhSCEQn3LYDrwQPhePTRp74+hvkdhR8kZ1O89OEFB6iMB1vUsFdJJyZoYAJWjYRgF1k+zAblzkOzleeqZ57TjVDbzqcmucFD9Jr/205U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=Rzvbh9FY; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-38627e78203so710767fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1759169186; x=1759773986; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vyEN0tDG41iChb3NGwo/IHMuz5VdNgy4oMVazcYf5Vc=;
        b=Rzvbh9FYlOQ0NcSV+MbS8vNAIJO/oDV13GelGizMR2RIK3vyAhrIMaW1jwDZLtehYo
         1Yo5MgQAPGiXMfXX21CxlGaAqbYt6MdX7f3ZXdaE+b44A7EDLMo0Ae/1BOoT0wJNwreL
         bmNnO2BPDKJJOAnWWrE76t7AH7/bmah4sfvhigEvLxqIBG/v9GE+miBT32OPv2OCRW78
         wh4Plng+HfluRvnvAf/0nT9cMPDxSEMSbx2jHaeMN2jHgeWhYU1LMTsmuOUxyIylzJPO
         coyXVnb79WKMjHgULUJPzEz4iGE0PSTsIeDB4c2lx3ZtvyYp57dslTKg8QAEdfQlBZuL
         HiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759169186; x=1759773986;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vyEN0tDG41iChb3NGwo/IHMuz5VdNgy4oMVazcYf5Vc=;
        b=YcwV43bXhS/zMRYISwaHya3XzmIvS476PsiFxDHH4tTQYM+Lm/9T++zILH6SfQH0jZ
         UVt9Y5DYqLFTpY9UwwsSa8W9YD3d8Bl5ZpU5rzXqJzTK+ECI1FQ2pNWZtHFaXGZyJcl4
         qQa+q7MtaN8gUGNEQlkoMBtpzlJvA+KqBrv7vBFzGABup7wnlZmt3lfHCVTK1OusJpCc
         uw40kWVTiHxRqvwCe9WEDPHwdKmOnKNHRtOUjwlKtsDKkB6uZI3a1Zn8J7srWtKJoTA7
         9Fus5oxhJh3jb8WRneH9WwIuB/9b11I+CP96jK5qi3SEpnrn2sSPHZSrdtWKWrclAmcr
         YJnQ==
X-Gm-Message-State: AOJu0YxAYjy9qcCq8Kss3KjB9+jjmyt7LMTCDzDDcH67Lq+8xxR6kzWU
	31OmdLqVbyowohXZKxQTZIXPMm19XfnIK7D/RAVdXA+CZvweWDmqYoff2TP2+vtXLVKQTVsqcTL
	1+Wwrid0=
X-Gm-Gg: ASbGncsaQG6q6WalrHlyecxl6+KI5brLDzBtprG+DHQQaiiQXwF7eEmQBpTRAhvdgiO
	J43y6GB2Gb9eOzJICnT6PJRy8yPdmeRKs4oyN/nD07BchQqzQ1t5g0S+e+dMIwr8yeP61+HNX3C
	xBdrkN9NJcj4eT6mRvAdND54BcjoBPe21um+WQicCbXMS3kpocNpzedVjHy4DMp3cvj13+YG7ss
	JzaRKDaujqkH3PxU34RaE4QWE2tETSvraG1cA297KEJJIor+J6OdbMkfkLIG1RANVbp0C3YCeFq
	zuTIWkSy0JzRcflPzfuOWhuMXPhXnSk1rrqh3bRq0yjI+uWHv5IetsHTYMxvETkXRTGn7jZWR5s
	2dGfALUoRwR7WQLloU538NFzHRPupMmBjrnHW
X-Google-Smtp-Source: AGHT+IEJWMH4fmiY6y2jxbN7/QYzeirQNBM+vpEqsAuSSOHUh/rSmLuJfwBi4Gs9am85/a7py84Ohw==
X-Received: by 2002:a05:6871:79a5:b0:36c:94fb:7e89 with SMTP id 586e51a60fabf-390f09caca4mr249535fac.21.1759169186006;
        Mon, 29 Sep 2025 11:06:26 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:5542:a82d:8748:cc0b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-363b2ad67a7sm3794847fac.22.2025.09.29.11.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 11:06:25 -0700 (PDT)
Date: Mon, 29 Sep 2025 13:06:20 -0500
From: Corey Minyard <corey@minyard.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 6.18
Message-ID: <aNrKnJ5GNGkf-yqv@mail.minyard.net>
Reply-To: corey@minyard.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6e64f4580381e32c06ee146ca807c555b8f73e24:

  Merge tag 'input-for-v6.17-rc0' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input (2025-08-07 07:40:01 +0300)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.18-1

for you to fetch changes up to d46651d4e3c0caab554c4c591c0b6c3b026b1e93:

  ipmi: Add Loongson-2K BMC support (2025-09-16 10:15:54 -0500)

----------------------------------------------------------------
Bug fixes and enhancements for IPMI

This request fixes a number of small bugs, but has some more major
changes:

Loongson-2K BMC support is added.  This is an MFD device and is
dependent on the changes coming from that tree.  There is a
conflict in the MAINTAINERS file and the MFD tree changes must be
there before this is applied.

The way the driver handles BMCs that have become non-functional
has been completely redone.  A number of changes in the past have
attempted to handle various issues around this, but nothing has
been very good.  After working with some people on this, the
code has been reworked to disable the driver and fail all
pending operations if the BMC becomes non functional. It will
retry the BMC once a second to see if it's back up.

-corey

----------------------------------------------------------------
Binbin Zhou (1):
      ipmi: Add Loongson-2K BMC support

Corey Minyard (12):
      ipmi:msghandler:Change seq_lock to a mutex
      Revert "ipmi: fix msg stack when IPMI is disconnected"
      ipmi: Rework user message limit handling
      ipmi: Differentiate between reset and firmware update in maintenance
      ipmi: Disable sysfs access and requests in maintenance mode
      ipmi: Add a maintenance mode sysfs file
      ipmi: Set a timer for maintenance mode
      ipmi:si: Merge some if statements
      ipmi:si: Move flags get start to its own function
      ipmi: Allow an SMI sender to return an error
      ipmi: Rename "user_data" to "recv_msg" in an SMI message
      ipmi:si: Gracefully handle if the BMC is non-functional

Rob Herring (Arm) (1):
      dt-bindings: ipmi: aspeed,ast2400-kcs-bmc: Add missing "clocks" property

 .../bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml      |   3 +
 drivers/char/ipmi/Kconfig                          |   7 +
 drivers/char/ipmi/Makefile                         |   1 +
 drivers/char/ipmi/ipmi_ipmb.c                      |   4 +-
 drivers/char/ipmi/ipmi_kcs_sm.c                    |  16 +-
 drivers/char/ipmi/ipmi_msghandler.c                | 605 +++++++++++----------
 drivers/char/ipmi/ipmi_powernv.c                   |  17 +-
 drivers/char/ipmi/ipmi_si.h                        |   7 +
 drivers/char/ipmi/ipmi_si_intf.c                   |  74 ++-
 drivers/char/ipmi/ipmi_si_ls2k.c                   | 189 +++++++
 drivers/char/ipmi/ipmi_ssif.c                      |   4 +-
 include/linux/ipmi_smi.h                           |  11 +-
 12 files changed, 600 insertions(+), 338 deletions(-)
 create mode 100644 drivers/char/ipmi/ipmi_si_ls2k.c


