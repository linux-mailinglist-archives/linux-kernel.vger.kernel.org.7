Return-Path: <linux-kernel+bounces-795993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93762B3FA69
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52F82C2A80
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE752765FB;
	Tue,  2 Sep 2025 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kziQq71v"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E71275872
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805433; cv=none; b=jDXGHfCIIRO+Mwcez26PqQMEu6O5TOC+CxBUuvW/OMDcFIQwGRhaD/D9fKVZn9GlOhSBxIsQWWQ68aAw3WIZgbXHfrl2vs3kvBb0IVq7HnNDXlI8yA7dfCK9W+DLWqpi3htjmi4DsMA9wAcFPz2mGy3PUl4sKUAvWp/yybUAD18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805433; c=relaxed/simple;
	bh=dM/J4EWSRWSIxbOj5OAlxBlqKOA6FNTaQsCA4gH91BM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ehVJ2HTUnZJyf9SI6vazLMxNfYXYRO3loBSqXJ23sN99AmLShneYZTzTW9AAdkg9i24aErPzu78vACk8A9dOnZ2+W9ssFduLtemY6DwdCJMdsNbxXVzxBOBFGd7098Q+DJbD/LoEEHj0eWPzTdf9LrJKlQgMImu6n9EGsD0T3eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kziQq71v; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7727313dd05so329920b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756805431; x=1757410231; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D7OKt9F9u3JGw8Hji9kO63gaBin4yVJprAEpigams7g=;
        b=kziQq71vyFdvPeTP7Na9ku3lbbMN3u1U8uMlg4yjjKa5SfBXh2uezSgF9Hr8aRflTC
         GAPS/Ah8xfigujbh8ndtL4wfMdDycu7hfW6YAsSV6qFqMkbh6dBZoWqQnJhO1zjrveNG
         tV/qBT6yKXroezc9w/JfHuYOC02lh3F5v8IF/RowbIyEonUJtDc74gUh3XFdv8YEoPdK
         SultCJ7ox/qi33BngZEkfzAO9YQUJrUTPH30LNZNCp4JJfhSHqMAJO2Xteu2i3fCZZJ1
         PcBhho+NCRuHkSIMzsrJmBmARDl4Q+7BZTyeWO3TfZDzYmWhKKw/wZrwFGz7DEsDJ52o
         SKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756805431; x=1757410231;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D7OKt9F9u3JGw8Hji9kO63gaBin4yVJprAEpigams7g=;
        b=kc6cld71Lv5nMa61iCeIsVUgc1hw3BZOT79rHzrNsU3Ks7ItfJMkDC3y3bnsLoed4+
         8e2xtnOn689UYq+4LKYSDj9ooMhgmge6FcPDJnei857fgK1FYF4XCdRVzl+C4UhKRKF7
         ZhJVpACjyRAmwPpKJonPcz/+P80fKDHGyR8m2svFg6qLYHmJcF2a6CjbujLQ1md21Z3G
         0TMoW+t5w/0YSSRGp1LM+SzEb5x2YGPe6jVlnjXH/a5UPDhFfKFP8hxFxPC/aozJVUk6
         Xmau9JWmc1ldQrqGY9338wSYdxiGtPmbH4aRr1+4tJU+GHvAAt1x8hSy0DwKniYdxL/M
         TrMw==
X-Forwarded-Encrypted: i=1; AJvYcCXG45H5hxl81JhdckieaQ4gtO4D64W2rT3VoCYsrk8DqIQkXGAx1SsU3mfqn7xOO/KNUIM/l5nQ6IiQPCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUVBQ5bHfutkYRlYCA0JI8ONQ2ojMXkWdTt34gfe5eOZF0oX9L
	0XzMLJCkea0yfAxR/YC0W04Egfm+W8yHxb3HasWI6AaRw9ZXuMWaVzmyZgxCCp+n9y8DNdT13ox
	Uar8mge2NZHZTi/4MJtt9wZ9fsIaYvWN3kkliBzwpUP2bKuRQYZhcU9A=
X-Gm-Gg: ASbGncv32xrfK6V+jP/i61LK4G+fOCeAP1PvLN909k5/vgwzPggjSOfNYpZWOiq2g6/
	KbpJohB4sDiiNGIfq4z30zkQ4PbOPNbETHyMgqbZWZb8bD9QbuqmLE6meCovL5vP5V2dvQxzCuB
	tcqj+VS9ymkAYWSmlGQtycw7Xv5ID0q6eOb/LhCEGUTAP/qkkPQoEPZ95UDpgCtztrjiKNJSMF8
	wtvJvHd03hMJE+3ywRrK0SFyQ87GtCYi1l0EDPL
X-Google-Smtp-Source: AGHT+IE8Yrx7PIEHWr7GBuT6CR6OOXizH5auPXW+y/+V0FBm3oCtap+/O+brH9ArwbKXJtHKdi5XLNVxxZpQhJ6oyCI=
X-Received: by 2002:a05:6a20:1595:b0:243:d26c:4802 with SMTP id
 adf61e73a8af0-243d6e00a3cmr14965979637.16.1756805430855; Tue, 02 Sep 2025
 02:30:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 2 Sep 2025 15:00:19 +0530
X-Gm-Features: Ac12FXx1zyo6Or4T4_OK4vkNL4SKnoNS4plyRwcQt4YbOf4Pp4VblMYRHeLcvTI
Message-ID: <CA+G9fYsgiqTo7t3e36P5cysc+jEX5Fub1quTj+fuKGM8jkxbFA@mail.gmail.com>
Subject: next-20250901 drivers bluetooth bpa10x.c:77:33: error: array type has
 incomplete element type 'struct h4_recv_pkt'
To: linux-bluetooth@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Calvin Owens <calvin@wbinvd.org>, pmenzel@molgen.mpg.de, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following build warnings / errors are noticed on powerpc ppc6xx_defconfig
with gcc-13 toolchain running on Linux next-20250901 and next-20250902.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

First seen on next-20250901
Bad: next-20250901 and next-20250902
Good: next-20250829

Build regression: next-20250901 drivers bluetooth bpa10x.c:77:33:
error: array type has incomplete element type 'struct h4_recv_pkt'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Powerpc:
  build:
    * gcc-13-ppc6xx_defconfig
    * gcc-8-ppc6xx_defconfig

Build error:
drivers/bluetooth/bpa10x.c:77:33: error: array type has incomplete
element type 'struct h4_recv_pkt'
   77 | static const struct h4_recv_pkt bpa10x_recv_pkts[] = {
      |                                 ^~~~~~~~~~~~~~~~
drivers/bluetooth/bpa10x.c:78:11: error: 'H4_RECV_ACL' undeclared here
(not in a function)
   78 |         { H4_RECV_ACL,     .recv = hci_recv_frame },
      |           ^~~~~~~~~~~
drivers/bluetooth/bpa10x.c:79:11: error: 'H4_RECV_SCO' undeclared here
(not in a function)
   79 |         { H4_RECV_SCO,     .recv = hci_recv_frame },
      |           ^~~~~~~~~~~
drivers/bluetooth/bpa10x.c:80:11: error: 'H4_RECV_EVENT' undeclared
here (not in a function)
   80 |         { H4_RECV_EVENT,   .recv = hci_recv_frame },
      |           ^~~~~~~~~~~~~
drivers/bluetooth/bpa10x.c: In function 'bpa10x_rx_complete':
drivers/bluetooth/bpa10x.c:99:37: error: implicit declaration of
function 'h4_recv_buf' [-Werror=implicit-function-declaration]
   99 |                 data->rx_skb[idx] = h4_recv_buf(hdev, data->rx_skb[idx],
      |                                     ^~~~~~~~~~~
In file included from include/linux/array_size.h:5,
                 from include/linux/kernel.h:16,
                 from drivers/bluetooth/bpa10x.c:9:
include/linux/compiler.h:197:82: error: expression in static assertion
is not an integer
  197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...)
((int)sizeof(struct {_Static_assert(!(e), msg);}))
      |
                  ^
include/linux/compiler.h:202:33: note: in expansion of macro
'__BUILD_BUG_ON_ZERO_MSG'
  202 | #define __must_be_array(a)
__BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~
include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
   11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) +
__must_be_array(arr))
      |
^~~~~~~~~~~~~~~
drivers/bluetooth/bpa10x.c:103:49: note: in expansion of macro 'ARRAY_SIZE'
  103 |
ARRAY_SIZE(bpa10x_recv_pkts));
      |                                                 ^~~~~~~~~~
drivers/bluetooth/bpa10x.c: At top level:
drivers/bluetooth/bpa10x.c:77:33: warning: 'bpa10x_recv_pkts' defined
but not used [-Wunused-variable]
   77 | static const struct h4_recv_pkt bpa10x_recv_pkts[] = {
      |                                 ^~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors


## Source
* Kernel version: 6.17.0-rc4
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: next-20250902
* Git commit: 3db46a82d467bd23d9ebc473d872a865785299d8
* Architectures: powerpc
* Toolchains: gcc-13
* Kconfigs: ppc6xx_defconfig

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250902/testrun/29725581/suite/build/test/gcc-13-ppc6xx_defconfig/log
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250901/log-parser-build-gcc/gcc-compiler-drivers_bluetooth_bpax_c-error-array-type-has-incomplete-element-type-struct-h_recv_pkt/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/328DwMMwNOpSAj0qnRpJavgtz9C
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/328DwMMwNOpSAj0qnRpJavgtz9C/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/328DwMMwNOpSAj0qnRpJavgtz9C/config

--
Linaro LKFT
https://lkft.linaro.org

