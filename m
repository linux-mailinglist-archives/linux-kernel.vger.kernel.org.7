Return-Path: <linux-kernel+bounces-837546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5643ABAC895
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8531320E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B782F8BEE;
	Tue, 30 Sep 2025 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="becxFsRj"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AD6238C15
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759228804; cv=none; b=Nbzr3pAO06LLJn121wMRNTQRg28VPgbppMlwjpDTVUFaG2byoPZdRx5UpwXHvW/uXzvDQK8R9yKoYVzZwUBGZSm+qXcRKY91b5DqzgCjfZMpdPutUeBDs5sJE28GGRLexIkTTYUZYQQlhaTTUzgfZcTGpDXvtUPsTmPTY77Zf7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759228804; c=relaxed/simple;
	bh=madMCCpXf9roOD5eZkqbrUzSQr5guKNIA3QTRpCiy38=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GijcNXRLL39kfxhfJC0a0YkNaRPNN7VeL2xosHDxTOCxwTJJGSQUQRI6+RIybsFLnp2OmAPZNSVGCfOJenHdb+k1bZBLGlYyXOfAejIKdUAYuouAfBZS+vmKABTuaxUwbsFKCHYZyrO5d1roB6fzRA7NEly4vcocOXyhZRu3+/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=becxFsRj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2698e4795ebso60627815ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759228801; x=1759833601; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tc0zQApF0WO4ZgUj5cHoP64Ut3mPNC7SB7c0om1scqU=;
        b=becxFsRjwyOhsz8RDaOcFpACDyK/o4Clssr4oaTyq8ifEOwKF9weACXHovlG1JaSkR
         EeJVZRX1BAFjNXUxIyVI8AjKG146cIjGhRyp0qNOb3g+R69X8fofWTwfptPqQOec3nOK
         SufuW4FnRZXf01+4vNJ8YqloXcxXAreX5Y4AalvSugKUfT73ipViTx3uTnkvclzGGi/V
         SKLLmy8BVTOeuvFJ6ZpV2VBkVHbydX4Z5HyE85G1m+OT9sB54Bsc954zdNR3vZGJsR1J
         tdX3eK0QR9SPheUKG8OBx7AbuVg1h8MK9FzW+OekNL0ZSZ18yOqBnToFbB49mK96a1GO
         UThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759228801; x=1759833601;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tc0zQApF0WO4ZgUj5cHoP64Ut3mPNC7SB7c0om1scqU=;
        b=g/JD8OZ6kERd0K69XDuLkfM7k7SVTC5YX0mb0gb+fKUFqeNPOqXrJtg0bgD/w6FBDm
         vHHnpxF0V2qjz06B70gSjTcUhUWCzqOmFGUFpnrvbHjPV5f9cXLQYSuV7ICwoY6tbGLy
         EA+nHRmYMTurkwq1rC5ac5aVpzrUjK0XJcGk5biOE+FCChqpM5zh8A8Efb24dIuanZ7V
         YFRVoFGeFuQBLAbg5tWyvkt8j8ICa/0tsrDauVx+4fEAj+fsbwf91yKj9K5RnhWLWxl3
         XWF9qhDthsPgWq3C/Ys+OPehjEVohtmYvG+5fgjN3RBRo14q98Cd6NROogGrbzvCypV0
         DoKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsjwyW5WQzgXlysA6anGnTcTj4AnthweFx9vHKzhuyW5eUH4IXtbjTf/Xc0fcznotGd7eyZ3/Rgpb+8MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmKg7BdbZDsuTXYYZ3jy4MPNyyJ6IQIMIUW2kiIZS8VWsyFXUz
	hS0VZCMfyZe7YLSYtHYzO+ig3soVtsTEVhW9B1EeptaczK65MXpdTroVNVVqlL9vfuneV5HpS5w
	L+o/dOSL4xmP/EY8R4nTwDurVmXhWVEdSjsoA/gcFKaf8UEvWogwjOq2Z6g==
X-Gm-Gg: ASbGnctKHFYDaUMdrbJoJkPG3g7jC5LnvtIm3M7gar/W2YEStz+/aX1TUSGDxGQcd6W
	dbHU41n0e4fcM7uowrUlBSuElq2ICmjWKPdX882kspvVlHQBcZxclAPWzxPMPvt9ouSfexSBYLA
	IPK60Iu9d4FDD+Kuy5ntrPbngwa1Vxx8wDtfYTYqpyxx4Vx+J/CoO949EMF/iTuf3EjFn/GrYJB
	o4u1e9r2QsKMVqeFwFafdJdf8TOQxwjtLVxQXWQ77FhD9mvSsh5gRAO9+ToSRqS50jZ3pBpkvrX
	CezRsN08G37O7ezxv0SVLpH0YnzWOw==
X-Google-Smtp-Source: AGHT+IHPY6eK3MHywKJURzS/I0UrL9t8viPGr6htqx4ToAI+8mmTLnKAaeTRI9hZkLb5EMHh5z7FlYyTqvUNFKADuYQ=
X-Received: by 2002:a17:902:d58d:b0:24e:593b:d107 with SMTP id
 d9443c01a7336-27ed4a5a856mr224706895ad.32.1759228801555; Tue, 30 Sep 2025
 03:40:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 30 Sep 2025 16:09:50 +0530
X-Gm-Features: AS18NWBzICskyp2rABk9ODkH4ArO_EhP6FnFBEP1dKyBVps0whfUGZOR_aFNgW8
Message-ID: <CA+G9fYtnXeG6oVrq+5v70sE2W7Wws_zcc63VaXZjy1b1O1S-FQ@mail.gmail.com>
Subject: LTP: swapon/off: 16K and 64K page size libswap.c:230: TFAIL: swapon()
 on fuse failed: EINVAL (22)
To: linux-fsdevel@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Joanne Koong <joannelkoong@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

LTP syscalls swapon01, swapon02, swapon03, swapoff01 and swapoff02 test failing
on 16K and 64K page arm64 devices and passed with default 4K page size.

These failures are noticed on Linux next and mainline master (v6.17).

This test failed on 16K page size builds and 64K page size builds.
 * CONFIG_ARM64_64K_PAGES=y
 * CONFIG_ARM64_16K_PAGES=y

First seen on next-20250821
Good: next-20250820
Bad: next-20250821 ..next-20250929

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Test regression: LTP swapon/off 16K and 64K page size LTP
libswap.c:230: TFAIL: swapon() on fuse failed: EINVAL (22)

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Anders, bisected this on the Linux next and found the,
# first bad commit:
  [bd24d2108e9c8459d2c9f3d6d910b0053887df57]
  fuse: fix fuseblk i_blkbits for iomap partial writes

## Test logs
### swapon01

libswap.c:230: TFAIL: swapon() on fuse failed: EINVAL (22)
swapon01.c:39: TINFO: create a swapfile size of 128 megabytes (MB)
swapon01.c:25: TFAIL: tst_syscall(__NR_swapon, SWAP_FILE, 0) failed: EINVAL (22)

### swapon02

Windows will not be able to boot from this device.
tst_test.c:1229: TINFO: Mounting /dev/loop0 to
/tmp/LTP_swaybkEDa/mntpoint fstyp=ntfs flags=0
tst_test.c:1229: TINFO: Trying FUSE...
libswap.c:198: TINFO: create a swapfile size of 1 megabytes (MB)
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
libswap.c:230: TFAIL: swapon() on fuse failed: EINVAL (22)
swapon02.c:52: TINFO: create a swapfile size of 1 megabytes (MB)
swapon02.c:53: TINFO: create a swapfile size of 1 megabytes (MB)
swapon02.c:56: TWARN: swapon(alreadyused) failed: EINVAL (22)
swapon02.c:73: TPASS: swapon(2) fail with Path does not exist : ENOENT (2)
swapon02.c:73: TPASS: swapon(2) fail with Invalid path : EINVAL (22)
swapon02.c:73: TPASS: swapon(2) fail with Permission denied : EPERM (1)
swapon02.c:73: TFAIL: swapon(2) fail with File already used expected
EBUSY: EINVAL (22)

### swapon03

tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
libswap.c:230: TFAIL: swapon() on fuse failed: EINVAL (22)
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:54: TFAIL: swapon(filename, 0) failed: EINVAL (22)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:54: TFAIL: swapon(filename, 0) failed: EINVAL (22)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:54: TFAIL: swapon(filename, 0) failed: EINVAL (22)

### swapoff01

libswap.c:230: TFAIL: swapon() on fuse failed: EINVAL (22)
swapoff01.c:44: TINFO: create a swapfile with 65536 block numbers
swapoff01.c:44: TCONF: Insufficient disk space to create swap file
tst_test.c:1888: TINFO: === Testing on tmpfs ===
tst_test.c:1217: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:1193: TINFO: Limiting tmpfs size to 350MB
tst_test.c:1229: TINFO: Mounting ltp-tmpfs to
/tmp/LTP_swahnekXb/mntpoint fstyp=tmpfs flags=0
libswap.c:198: TINFO: create a swapfile size of 1 megabytes (MB)
tst_ioctl.c:21: TINFO: FIBMAP ioctl is NOT supported: EINVAL (22)
libswap.c:228: TCONF: Swapfile on tmpfs not implemented
Summary:
passed   0
failed   1
broken   0
skipped  7

### swapoff02

st_ioctl.c:26: TINFO: FIBMAP ioctl is supported
libswap.c:230: TFAIL: swapon() on fuse failed: EINVAL (22)
swapoff02.c:88: TINFO: create a swapfile size of 1 megabytes (MB)
swapoff02.c:53: TPASS: swapoff(2) expected failure; Got errno - ENOENT
: path does not exist
swapoff02.c:53: TPASS: swapoff(2) expected failure; Got errno - EINVAL
: Invalid file
swapoff02.c:53: TPASS: swapoff(2) expected failure; Got errno - EPERM
: Permission denied
tst_test.c:1888: TINFO: === Testing on tmpfs ===
tst_test.c:1217: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:1193: TINFO: Limiting tmpfs size to 32MB
tst_test.c:1229: TINFO: Mounting ltp-tmpfs to
/tmp/LTP_swaXbUs2F/mntpoint fstyp=tmpfs flags=0
libswap.c:198: TINFO: create a swapfile size of 1 megabytes (MB)
tst_ioctl.c:21: TINFO: FIBMAP ioctl is NOT supported: EINVAL (22)
libswap.c:228: TCONF: Swapfile on tmpfs not implemented
Summary:
passed   18
failed   1
broken   0
skipped  1

Here I am sharing mainline tree and logs.

## Source
* Kernel version: 6.17.0
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
* Git describe: v6.17
* Git commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
* Architectures: arm64
* Toolchains: gcc-13
* Kconfigs: lkftconfig+CONFIG_ARM64_64K_PAGES=y
* Kconfigs: lkftconfig+CONFIG_ARM64_16K_PAGES=y

## Build
* Test log arm64: https://qa-reports.linaro.org/api/testruns/30048876/log_file/
* Test log LAVA: https://lkft.validation.linaro.org/scheduler/job/8468115#L28598
* Test details:
https://regressions.linaro.org/lkft/linux-mainline-master/v6.17/ltp-syscalls/swapon03/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/33LezR2rctMs0EwZpyIDqRhU7s4
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/33Ley5LZz1crQhBtb1KXJMuS2GB/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/33Ley5LZz1crQhBtb1KXJMuS2GB/config

--
Linaro LKFT

