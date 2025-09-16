Return-Path: <linux-kernel+bounces-818207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 038C6B58E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C7787A1728
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8952848A8;
	Tue, 16 Sep 2025 06:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AltbzPJK"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B571191F91
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758002606; cv=none; b=eZLWKPeb0p6mS1RFCn5trMN6guBlKsNnIVRltB6exZvqNcq93mAkLFs/tH1j/JeRKfxXw0/hwZv9pjO9EWmhy8LHWjSLLSzigSUhKEttjMsIOyb8t85DU8QKaNRhS44HwJv4VqlAkNa62RhRP9K6pxrOA++qAw+wDLHRD/uf/Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758002606; c=relaxed/simple;
	bh=yLz9txVwcnZbWd4ywhxn8K7GFJpnpjcbZ8DpqsNG4Sw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZhGJKns8H7XnOZ/U33dw7fLJL0OOvYRGenpNCTjtEDOAjMggYJ4qHLwj7kBhOcWUciFoNoVfLo25iTsTpwMhBWZiCSZkiBoUIaQ5qtHJg2MidAfZo8VgLZ0hzSzg70J6pkd6eoay/LM5pa1OoJY0KxhkHicsfKTtedxeS7+o86E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AltbzPJK; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-261682fdfceso22869515ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758002604; x=1758607404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rOJIcs5drTzBTEY0tV1pMT9TX9JsWUffwaHGsiB/nGA=;
        b=AltbzPJKCoEREjS+s073KHZbO8NHhSxyNWNEKBQI4YZdtUm3a4UluaDNDwZSvOjwnZ
         RnNcd5WQDcGn8HpMSOUxMgew6PMMi1Ya0A/AvvQdNwPk2W+okh55kDBuWCSjpQAuZsNK
         lkLcHOxmGaqBarPgODIJrcYb8scOaASeZrsml1XQisiOe16CrxuCVd8nAMhch+nP3W+d
         OE2hjlzyvzOEzTIrY3uAU0khtOKnCq0Dwu0l5VVDJwzencH+ucNFxIfhrWUhcwpy3ToH
         IH7vOjQKwE6YjgD/Vpp/j9pVz3ES/XZ7o1d3l6NhYKvtzX6RZ+SzM4QiMU90VeEJ0U0h
         6Y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758002604; x=1758607404;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rOJIcs5drTzBTEY0tV1pMT9TX9JsWUffwaHGsiB/nGA=;
        b=rxBf84TgcN1d+Xlf2yZK13LhhBd46xn4LTJwICcrxOyrn5h21M/bSoluHWRqV/SIuR
         t6ZuUNzqPh59LHJ8MloOM3flgen41ZGUdehyx9yNau+uCOnpduO5FymnxtYA2tJ3H0HY
         0fMS2wlDiHKD5effuaZcrdEcSyCloHb1rTBfvP0zrVOf8LXF2T/JT9imQCFXs7fh+5ca
         aPrEU45B/oOfQPLrTGaYp56Y5Y//FfPOIKDXShPUA0XephU6tUfy6nte91sw4qdxAlA2
         Fd5rbBvYLEU8gu0H6nF/U9xnyGbl47xZzNZWgTHMocPHi6LgwHNB2/Nrq16Ba0bS6dib
         6M9w==
X-Gm-Message-State: AOJu0YylC4v7xldtx8AuGlSoKb/PSImhwa8QeZiXx69TchTe1Iy34JyI
	Xd5dWxSFIbwDkwc2Lj0/Ty7g8PyVF0kqMLGa1ilRajaJFn/YIYBVRUyNqzvqC5u1zyHXHpFMoyO
	42qqM/tQJ8Ju0Z2tLdLATeEU9FVVB3iR1j9qd3Plij2i+pWLPqoR3pS8=
X-Gm-Gg: ASbGncvGzdL79swS4XYQJQXgRIBr9EKnETG3MyD+WU6Zaem7i3DA8MuNEnt0/ZB8ESM
	+VckTvcJr5cPRX0y0xyxxg2ihcDKEUFiPMO3ZgajZwe+h5r9qJ7/C66GdVkdEzT0YghyVEqx/Xp
	86I+vwYjPTw6IoNPDwd4T55dz/C2RsvbZ3eruG5dWB1sOQaTISAy8gE1zpVCamIp3T5qQ39s8zp
	/CJZnhBsB2sRCim1hxo2Mk5Cq/hkMlMj3XN27v0PAbrw5qMYJfNhG4h2vOBGBd4H+Y6iZ2l
X-Google-Smtp-Source: AGHT+IFV325JIbcAfi1+4GJFDPX/Lf6OkNWpQhdHX1kwwf8lrDz1Wr7tESi3mLj2u4jharlYlnA+pRIIqSG0XyZXHl0=
X-Received: by 2002:a17:902:d2cd:b0:267:44e6:11d6 with SMTP id
 d9443c01a7336-267d1540ec7mr19417725ad.6.1758002603798; Mon, 15 Sep 2025
 23:03:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 16 Sep 2025 11:33:12 +0530
X-Gm-Features: AS18NWCGBnaNFEvWs2ru3e2aqzs-uznr7CWnwt9WJqflYhg3DElbi0V21AVd2FA
Message-ID: <CA+G9fYvH8d6pJRbHpOCMZFjgDCff3zcL_AsXL-nf5eB2smS8SA@mail.gmail.com>
Subject: next-20250915: powerpc: ERROR: modpost: "libie_fwlog_init"
 [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
To: open list <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
	intel-wired-lan@lists.osuosl.org, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Alok Tiwari <alok.a.tiwari@oracle.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, 
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Qiang Liu <liuqiang@kylinos.cn>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"

The following build warnings / errors are noticed on the powerpc
with ppc6xx_defconfig build on the Linux next-20250915 tag.

First seen on next-20250915
Good: next-20250912
Bad: next-20250915

Regression Analysis:
- New regression? yes
- Reproducibility? yes

* powerpc, build
  - gcc-13-ppc6xx_defconfig
  - gcc-8-ppc6xx_defconfig

Build regression: next-20250915: powerpc: ERROR: modpost:
"libie_fwlog_init" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko]
undefined!

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/swim3.o
WARNING: modpost: missing MODULE_DESCRIPTION() in
drivers/net/ethernet/freescale/fec_mpc52xx_phy.o
ERROR: modpost: "libie_fwlog_init"
[drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
ERROR: modpost: "libie_get_fwlog_data"
[drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
ERROR: modpost: "libie_fwlog_deinit"
[drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
make[3]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1

## Source
* Kernel version: 6.17.0-rc6
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: 6.17.0-rc6-next-20250915
* Git commit: c3067c2c38316c3ef013636c93daa285ee6aaa2e
* Architectures: powerpc
* Toolchains: gcc-13 and gcc-8
* Kconfigs: ppc6xx_defconfig

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29894450/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250915/build/gcc-13-ppc6xx_defconfig/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/32l4NthnSk7ehgpfv9NJaE6gjqk
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32l4NthnSk7ehgpfv9NJaE6gjqk/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/32l4NthnSk7ehgpfv9NJaE6gjqk/config

--
Linaro LKFT

