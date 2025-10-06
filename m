Return-Path: <linux-kernel+bounces-842876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A507BBDDAE
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 13:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D703B5203
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 11:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC3926C399;
	Mon,  6 Oct 2025 11:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="viYMhk68"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B356E26B973
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759749972; cv=none; b=QaNrzhU1AC7vOy6omIqtWok2exzua8R9RqzGuWC/lwupi1PuYnem84T2Um3JbjAmRIwupcfPrT1WjJnF2IOOyJWHX5YVbUan6UFQvcK9EZ85vmLeWSwURERQOy6/SPYG98LulsDIM3/bvHpMd0PwYNWUU+Y4RSb5mOXaKSARznQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759749972; c=relaxed/simple;
	bh=GeecThNQ93ggam84Jge/WQIwJ0tpZbNxDJpSZaYQFg0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nyFgM9Jc1yOpOSiRqt8LV3z4L+7QidPN9dXauCzrd0a81tTVYP0Be54UneUO0mFFZ7z50r8rvR+n9H2wlzuNxiy6fvMC0zAKK6G9NHCUD1kRnpKzGUmWSnbA7wzdYKatp1hrQKvp5cjQa2jutcRfm2Q0gG9d3WgzvCMb/dReioU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=viYMhk68; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b54a74f9150so4092930a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 04:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759749969; x=1760354769; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fDtmvvD2FXzwZvAyeoxJfV+MQOeVHERP3mbNxwWBmas=;
        b=viYMhk68jUzpcaVtAX5sdQTjSWRhaRkkFWA61qpsyK2YLP5q/QIIhvoqaoo+JC2oik
         IFfDlyDRXN65CsWpJMiWYiZEi81lIq1hs9I3fqjBRANgMC1c9mChr6Us7O03H2zoEhBF
         LebCz2VzNQh6sjWIVzHs3Fl/5rG40nb5FO+t98PO7yMHjIvhtR6eagWqSPqCb7lSH1Bh
         JNYp5fI9yDSZzScwP5nFjr+DZ80TjY/vWGp7mNLtmKrUTtkVpKLOeA0qpj7HpK0bUmaM
         iMDdkwDz53bcue3xj9vxWMvVbOd9bIkRk/86FbDfJYxMOctKwsrabGWoqXdvss2JlLVg
         AWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759749969; x=1760354769;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fDtmvvD2FXzwZvAyeoxJfV+MQOeVHERP3mbNxwWBmas=;
        b=o68WeIvWOkCP0wpUsDYninheqaWO7Pxwzjj4WA5n4xLErWQdaD2rbWPF5FUQk56Dta
         +iHKxi5xi5QGjSiODlTAhiquwE0NgkB0FB86uA1URnZhCcJqrYARBOa4MEjWBxvJl1Aj
         KaLxGq9ULaeW0NZMcesVf9IxpgPqoQuDCGLmwysYsEaIgZ1J29jjppBNNIKiEnyRpY6G
         kwCo2XX8WrKoGM/kybJvDm9Loyuwy+Uo1teig1/aS4ovPixSAJ3/NYQWZ2Ob30s1eSZ7
         9U4n/aIEpRHiqYsYp3nSZ5NFyNack34YwePElpcLWIr9JRIdfJlzq3tGT004bdvDFGAL
         vGSw==
X-Forwarded-Encrypted: i=1; AJvYcCVBA9An47518hYoEPyJYM/DqSxug3fM1N6F8wlfhGGzD9bOrrKEFELTmMIgkUgW2n5uc8edT7tJEjWertg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3kRSCSvKU7RtLZOq3RsoiyChHLbOfeKvJ/f24koRqEyRE5Sgb
	HK++9G4jRuW0apUm/ZaumXKRHedY1qFpB6bbsJ+YO64HeBX+EX5+6v2Vpd/vOpPuomqOSDXa7Qy
	RcSSbnjtFtzxpHfD0PkDnQ2cUUWWdo/9VU3V7w7yvMA==
X-Gm-Gg: ASbGncvVhgaEQfpXvCDEe1Ye844sqBMbMNga3ObYK/FWjVpaaNa0K9JYQuZRu84/z8r
	1W54jAiUgc07nGmiduHoFilh3kQNqfPLut8hvAPEjybg/ko0gqIuINC/Nuf/mw60iISlODCHyM8
	4iOyar7PifAnxIqoZTAGj8Rg4u1BmCfb/Fvj7NVeThAGeZAj1iYOMQni+znla1CVkfCSwkd0vCV
	yw+bE0dL90OTE3+65KxV/SNlJuw4vlvQvLPXhMo9gu08/IRs9R2AufZr6gf8ePIbrYZU5qmNHU8
	spp21Z/1tF2fd5x/R90TJlVlC+UrAK5k5g==
X-Google-Smtp-Source: AGHT+IGTQs8jxKC++oU6C7/YISQ0AZ0FYt8ko5S/A8BiDUATldLpn8X/+jXVOkZW/HIc7ypJ3iFUxkMCCjEPr5Zxmk0=
X-Received: by 2002:a17:903:15c7:b0:25c:4b44:1f30 with SMTP id
 d9443c01a7336-28e9a6568dbmr128417825ad.45.1759749968905; Mon, 06 Oct 2025
 04:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 6 Oct 2025 16:55:56 +0530
X-Gm-Features: AS18NWBff_p2Nu8Juw5fKubeZaQNxL-VRN3bmyXdcvgFsaNarPe272yd7yfV4Co
Message-ID: <CA+G9fYvVktRhFtZXdNgVOL8j+ArsJDpvMLgCitaQvQmCx=hwOQ@mail.gmail.com>
Subject: next-20251002: S390: gcc-8-defconfig: symbol `.modinfo' required but
 not present - no symbols
To: linux-s390@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

The S390 defconfig builds failed on the Linux next-20251002 tag build due
to following build warnings / errors with gcc-8 toolchain.

* S390, build
  - gcc-8-defconfig

First seen on next-20251002
Good: next-20250929
Bad: next-20251002..next-20251003

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Test regression: next-20251002: S390: gcc-8-defconfig: symbol
`.modinfo' required but not present - no symbols

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

### Build error log
s390x-linux-gnu-ld: .tmp_vmlinux1: warning: allocated section
`.got.plt' not in segment
s390x-linux-gnu-ld: .tmp_vmlinux2: warning: allocated section
`.got.plt' not in segment
s390x-linux-gnu-ld: vmlinux.unstripped: warning: allocated section
`.got.plt' not in segment
s390x-linux-gnu-objcopy: vmlinux: warning: allocated section
`.got.plt' not in segment
s390x-linux-gnu-objcopy: stM7JmYX: warning: allocated section
`.got.plt' not in segment
s390x-linux-gnu-objcopy: stM7JmYX: symbol `.modinfo' required but not present
s390x-linux-gnu-objcopy:stM7JmYX: no symbols
make[3]: *** [scripts/Makefile.vmlinux:97: vmlinux] Error 1


## Source
* Kernel version: 6.17.0
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git commit: 47a8d4b89844f5974f634b4189a39d5ccbacd81c
* Architectures: S390
* Toolchains: gcc-8
* Kconfigs: defconfig

## Build
* Build log: https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHdDpSLSMJfU4MFvRyEUQuDn/build.log
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20251003/build/gcc-8-defconfig/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/33YUHdDpSLSMJfU4MFvRyEUQuDn
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHdDpSLSMJfU4MFvRyEUQuDn/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHdDpSLSMJfU4MFvRyEUQuDn/config


## Steps to reproduce
  tuxmake --runtime podman --target-arch s390 --toolchain gcc-8
--kconfig defconfig --kconfig-add CONFIG_DEBUG_INFO_BTF=n

--
Linaro LKFT

