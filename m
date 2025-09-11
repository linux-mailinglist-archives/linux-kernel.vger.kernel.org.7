Return-Path: <linux-kernel+bounces-811859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFD6B52EB4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1082A188B3DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AA32D1F72;
	Thu, 11 Sep 2025 10:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E+2XIHN8"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A7A30DD15
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587118; cv=none; b=XhAfSE0Cg9H3wmjtC71mXzksKFQqoIPLc5vkO8UzEvIomTTwM7iaegVgsxCtMu8yo7RN0tTDGO2ZEuDueRP9YX4dsQXYEwDsAP4dnjzOsceBCZ3DfJT/bY5vVhW1j9RKb7PPcRsaG9geNaHilMBWpg1yt/5gj76PEMXtQAOR/8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587118; c=relaxed/simple;
	bh=PzZndjRhCyfeDaH3rPUOnP5JNre8OuaxnyLSwSi5YvI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZGj/tCqMWIx6EO5ovJXInz6Juk/kVpnOtFy2CmzGBX/qiVsMuMS0VaCmEzx/rNzCpmtGFJRmSO48m8HLwdjNsGscE+x3kiB7W+FLglabAsitXPCbXvQ0akhhawnbqJpr8kWXk9RpWQpbTjeMTwRU40ehtT+XdgxY8AYleiyjKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E+2XIHN8; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77269d19280so486724b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757587116; x=1758191916; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hwCf+x6+iQDwlYTBOswpM6ZU+Uqffi/8oPlDvFPRj5I=;
        b=E+2XIHN83JrkTtWtnfVArOW1stjba3GZAR+sxfXoWV66mivLCdXMcgQ57yN7ekyFFS
         7p7ApaaqcIBZXWmyZ++JbUWpjdEKBL+zymfwyT01WG4fCGNNNnonya+FCmQi/eGk0A9m
         jNC6Fn3X5IahwBItGtKB/mJ9JuEkYuqlOdeallFBCSUT26PQ6cDPXQewpO/5uRYYQrZb
         lbc4yOYb7b2UWTRDkz96vWVrIazJnIrfaHkJJhF8ZJz8x2tCWTWNvNVEBAbs76VDu3dV
         uxquICVsQumq1cSenFb0GkzgzVJHDNYspe0pRGapaI6C2ZhkszDDjid4op0RW7I/6U+H
         YC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757587116; x=1758191916;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hwCf+x6+iQDwlYTBOswpM6ZU+Uqffi/8oPlDvFPRj5I=;
        b=YxBS9mp+yYlCsTHsQt5G143M7Ef+47f4DMBBTvOaCPZj2MkFqsvYyGmbtRrFNS1MgT
         +EGhAlI869GnPqoa5SJO5wrHUB7L9mGWY2lcVIBs7X0fot/gRafnunaAZMpCrPRcauuw
         oXd77Sz3qU86CH+2oRAZs5kwRZNoMZmsPCwcBqIyHs0+MOF9NCZS6lqKddwkLQB/Lpqk
         fijNH8dU+5iMh/lUzadGiVqmDYvi+1VxvzOKn9xnJttV9fAKubVgGIlY4wAlqmADcW1Z
         7kVjJ5Iye2nGwXxndN2pOtbp6+dzBdM5kjE8y/oT9upO1IMyS34aXg4oprhKSKlCZz83
         Gurw==
X-Gm-Message-State: AOJu0YxMQDMAA/ZB5DlRT9nuJTUIC+RPNYeetXSRDHlPrX6VJhzXUHFe
	k5OroOw/RT1CNdut5g1hIj8LsTStcLzaDN+ijUTj2WhTVkTsJr42lJYlUZIjzA9exylS1J2S+4Y
	vXNB+erPVXG2yFh9kudlpb+v/1O20Rs1tplpOkIXuArKvXZqevjFBweU=
X-Gm-Gg: ASbGnctb8vwAUK6tlctdlASfWW82HXaIBt1UP5xLXACUR6Se99snmojWtZDS7yIM0tX
	JpB+VZVaJi7Ogd1C4ATLZ+fgGdpI8EjcI9z0jsxflmCXzBo5wLUPrtMUVgwN6HL7MyiE+oPMljT
	XegQx4m9kMufZPR/y4ohiOuaeNCVuy2xQ4uAWzrNAjxGkB2ZtKO705GUw22ZNIAtnsSVHQ8vgd/
	T3WSDju5cg4DyKc3/04TmrZWXAuhRak8sNOoG1uq+o/yO0e7EQaHmQPeWC0byozkImllie0zwNY
	eOeMIq4=
X-Google-Smtp-Source: AGHT+IFF9nLAlf5H5zTpQVUA1xDoSRqbppJFcEnC+SSt2NXKIJkElcllJglnQQoxzmnCvg9l74mXa81/q4BpW7N5QUs=
X-Received: by 2002:a05:6a20:1585:b0:24c:f8f:2b95 with SMTP id
 adf61e73a8af0-2534557a863mr28371984637.40.1757587115788; Thu, 11 Sep 2025
 03:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 11 Sep 2025 16:08:24 +0530
X-Gm-Features: AS18NWDU1yGbFPHd1Xuf1CRGujHNL9_s9RGs2SutoTfTFAoxI3RGpotdfxd9IuI
Message-ID: <CA+G9fYsenOs88SO8ZRYnuDXU8tk=o-kS1Q=fvLbV3=6WKSJR2g@mail.gmail.com>
Subject: next-20250911 acct01.c 123 TFAIL acct(.) expected EISDIR EACCES (13)
To: open list <linux-kernel@vger.kernel.org>, LTP List <ltp@lists.linux.it>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Jani Nikula <jani.nikula@intel.com>, 
	Jeff Layton <jlayton@kernel.org>, Arnd Bergmann <arnd@arndb.de>, chrubis <chrubis@suse.cz>, 
	Petr Vorel <pvorel@suse.cz>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following LTP syscalls acct01 test failed on qemu-arm64, qemu-x86_64,
x86-64 and rock-pi-4b running the Linux next-20250911 tag kernel.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Test regression: next-20250911 acct01.c 123 TFAIL acct(.) expected
EISDIR EACCES (13)

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Initial investigation pointing to this commit id, (Need to bisect)
$ git log --oneline next-20250910..next-20250911  -- kernel/acct.c
   ccc54b556054d kernel/acct.c: saner struct file treatment

## Test log
tst_test.c:1953: TINFO: LTP version: 20250530
tst_test.c:1956: TINFO: Tested kernel: 6.17.0-rc5-next-20250911 #1 SMP
PREEMPT @1757575072 aarch64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
which might slow the execution
tst_test.c:1774: TINFO: Overall timeout per run is 0h 21m 36s
acct01.c:123: TFAIL: acct(.) expected EISDIR: EACCES (13)
acct01.c:123: TPASS: acct(/dev/null) : EACCES (13)
acct01.c:123: TPASS: acct(/tmp/does/not/exist) : ENOENT (2)
acct01.c:123: TPASS: acct(./tmpfile/) : ENOTDIR (20)
acct01.c:123: TPASS: acct(./tmpfile) : EPERM (1)
acct01.c:123: TPASS: acct(NULL) : EPERM (1)
acct01.c:123: TPASS: acct(test_file_eloop1) : ELOOP (40)
acct01.c:123: TPASS: acct(aaaa...) : ENAMETOOLONG (36)
acct01.c:123: TPASS: acct(ro_mntpoint/file) : EROFS (30)
acct01.c:123: TPASS: acct(Invalid address) : EFAULT (14)
Summary:
passed   9
failed   1

## Source
* Kernel version: 6.17.0-rc5
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: 6.17.0-rc5-next-20250911
* Git commit: 8f21d9da46702c4d6951ba60ca8a05f42870fe8f
* Architectures:  qemu-arm64, qemu-x86_64, x86_64 and rock-pi-4b
* Toolchains: gcc-13
* Kconfigs: defconfig+lkftconfigs

## Build
* Test log: https://qa-reports.linaro.org/api/testruns/29854528/log_file/
* Test details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250911/ltp-syscalls/acct01/
* Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/32XlIYnaqlBd51NRfEjNdOSzoa9
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32XlFRJ0UBKszjvazzyFA2gCmdT/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/32XlFRJ0UBKszjvazzyFA2gCmdT/config

--
Linaro LKFT

