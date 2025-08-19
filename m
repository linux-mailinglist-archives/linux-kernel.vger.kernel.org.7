Return-Path: <linux-kernel+bounces-775296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0934B2BD93
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6DD624BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ADB31AF15;
	Tue, 19 Aug 2025 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQ5OpnBC"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCED3115AE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596290; cv=none; b=rA/ymkhpR7GUuE4u4D8r/0hsIL2ums+BEXJkPAai5Qd2eY0fFGmotebnPsQn/GtehjfwnCFKXlD/CA9PQ0rncL9dWy/1UKUOqLCDF+pJmdBzB7cBaQlzE1bgzcQpCaf0J7N5sAApNE+b8/sBck64G0Ud+EF34M8Hh+ZOpngyQpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596290; c=relaxed/simple;
	bh=2V8M7LV7ljgsDumKXBHQhC4o9NF1oxLIPIk0ANfKKUU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KTTJrNkF8/Vt1FNS89dQu3/8CL6TygaoGBzIVv6Kp5dFii+snQtSQ5UmNS6TRA566yRPlbOCya/6O371GQ3RH14Pi6ugvL6gW8A0PP/IZwc/WWB8qF7TQardarFtBI++9KA3QGM8lY8+7Qvjhzuy7DDJoW+C8nw95DkofAjXqU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LQ5OpnBC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2445818eb6eso38019845ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755596288; x=1756201088; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T6K8gy0h4bXhy9f6BhVNVyKHxXc0oXpO4f2ZuZ3PvLY=;
        b=LQ5OpnBCqQCKxXO/BF0ocGcd07zuzSpdERlx5BAAYfsIUJbNr4b+NLz7C7wJI2WgpX
         u67emYC99RAlPV5S3PGvW4UYt1CiwjREE26o7hAvOvQNLevMuE4wVPXTDdElq0a7C3hs
         pHvS361abm+QDVAMcLuFirUoh+DbPrmgF62TPA57w0y2reH8RWarvrHOnRr2x3g8C8Xq
         lfSZjFx1wc0Avh0zs/dp672aWFd9aKq91MV/FCKW/r6Plr2oASvuk3K+8JLFEeEol2Xq
         H3zdowBzOBHJc/XRWXWlYu4xm0lmkH6J7YBdRARcralsemxJP05KmVKT18ge52T/l5yV
         4IBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596288; x=1756201088;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6K8gy0h4bXhy9f6BhVNVyKHxXc0oXpO4f2ZuZ3PvLY=;
        b=G52NuGRqDb5uW7UVDwKjdX7K0jNglBuu4g7H9JkGohTBmVQ/gYD2aCWfbVI8ev6ww0
         F3RUh/xGLY1zjO4RtEKSfJt+AKU2B3kuXQmPMZrmcclNGOLD6xxj3Pi22awvoRR0IsX2
         X7dox65UNEDC2CS7NvwcHZHCnwPepIMO5j328K/+9O3fFWyfSZ1TDdWKX44MkGHS+oM1
         tGZrukqsTnQOo9V3eY5qXRObq+4jI6VQt/WmsZ10rj8Q3nyS3lBFMSzO/MJHIZDoTSgx
         QZpeb7Jg3XN1+Z4JU4w9kSwdJdGcMsjt0vfs5OFsO1wa5oqRc5uElquwHy/u6P6SEN+c
         t2SQ==
X-Gm-Message-State: AOJu0YyxZHb6RPiFmZHp1JnpFmtFABUkb1DVuakhxSYbUdzDbbG2lg+y
	qMfbsRqruw0GCcKtFH+JfdcXhkdIlCtfoITGl1N1/Kq1B45J9shK71s3+A6lqUkZ6jg0SDUyvg/
	Y1fr3MWpP9IFmqTkri6BfbKjoplVi2KlVcNI5PFsn5pjiRgePdlwfYHc=
X-Gm-Gg: ASbGncvjwPbYYB3Kfif3KliRCg9U21UOuZl1cDGaJA9JvO9Sk75JOlrp2K6ZkUppXJp
	BPLI+i0wpxAvlb8fj+NIlrUXwQM/zUKkzLgiBl7fKLTB2hASAhtYFgTl8apFLbtlQikP1RtmfT+
	82ohJvN42f50qGGfxjFPSaBdSz6Zq3arZQbw6OCiG5FRGqbNIFztHb4FDmu04lFS/o4+P1b34Jq
	RGiGBE3i9bU/kP6G0JPLIz5M3Lj21dynt89L6kmRcwqDKk25+k=
X-Google-Smtp-Source: AGHT+IFIxdv+Gumf/6w+v7ffwNzZJemUXI7WRTzzUiAmKNSzZs75iWdEANwcTsNoYtnMKamFklfbi/D3t+vz0EWJMZw=
X-Received: by 2002:a17:902:f609:b0:234:ba37:879e with SMTP id
 d9443c01a7336-245e049e36cmr28797065ad.38.1755596287861; Tue, 19 Aug 2025
 02:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 19 Aug 2025 15:07:56 +0530
X-Gm-Features: Ac12FXzSzL7CxVGEj_WaufEFOr4fMyspvQA0mI9KFbrlZz1H1yL9N-ZCIEodprQ
Message-ID: <CA+G9fYuY=O9EU6yY_QzVdqYyvWVFMcUSM9f9rFg-+1sRVFS6zQ@mail.gmail.com>
Subject: next-20250813 s390 allyesconfig undefined reference to `stmmac_simple_pm_ops'
To: open list <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	linux-s390@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Jakub Kicinski <kuba@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Ben Copeland <benjamin.copeland@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Build regressions were detected on the s390 architecture with the
Linux next-20250813 tag when building with the allyesconfig configuration.

The failure is caused by unresolved symbol references to stmmac_simple_pm_ops
in multiple STMMAC driver object files, resulting in a link error during
vmlinux generation.

First seen on next-20250813
Good: next-20250812
Bad: next-20250813 and next-20250819

Regression Analysis:
- New regression? yes
- Reproducibility? yes

* s390, build
  - gcc-13-allyesconfig

Boot regression: next-20250813 s390 allyesconfig undefined reference
to `stmmac_simple_pm_ops'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
s390x-linux-gnu-ld:
drivers/net/ethernet/stmicro/stmmac/dwmac-rk.o:(.data.rel+0xa0):
undefined reference to `stmmac_simple_pm_ops'
s390x-linux-gnu-ld:
drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.o:(.data.rel+0xa0):
undefined reference to `stmmac_simple_pm_ops'
s390x-linux-gnu-ld:
drivers/net/ethernet/stmicro/stmmac/stmmac_pci.o:(.data.rel+0xe0):
undefined reference to `stmmac_simple_pm_ops'
s390x-linux-gnu-ld:
drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.o:(.data.rel+0xe0):
undefined reference to `stmmac_simple_pm_ops'
make[3]: *** [/scripts/Makefile.vmlinux:91: vmlinux.unstripped] Error 1

## Source
* Kernel version: 6.17.0-rc2
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: next-20250818
* Git commit: 3ac864c2d9bb8608ee236e89bf561811613abfce
* Architectures: s390
* Toolchains: gcc-13
* Kconfigs: allyesconfig

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29579401/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250818/build/gcc-13-allyesconfig/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/31RcVYdjsdhroYxXs4TJYixUCaE
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/31RcVYdjsdhroYxXs4TJYixUCaE/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/31RcVYdjsdhroYxXs4TJYixUCaE/config

--
Linaro LKFT
https://lkft.linaro.org

