Return-Path: <linux-kernel+bounces-813571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37CEB547AC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F86B189846C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74A22D9481;
	Fri, 12 Sep 2025 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S99D42A7"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48FA2D879E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669277; cv=none; b=pl+vT7qm/eMRN+dy4aqdlKYxEC0bVBnQCA3bB+GpTEleFS4pa399S6Orl39S5BlKpEz4RpXARh0ICJ4IUW5WpqWxNNVtktVUiCQiQfNkj9GZ29idy/4/u0gvny7/gyoPmhzw6oSFCxFQ9QQY9V1kiDRxoO/ZGASo3VZ/39mF8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669277; c=relaxed/simple;
	bh=3tSH5UPTW11Y9XuzBfniGHAKTRbqqxgrANUoPyfLX9A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kr2DNkpUdoLXn2hE7LBVh4vE0cE8ghcF7cFJHK2q1oMA2Ej8i1bEarzDmwhN0YiGx/+yXeNHE1eTr9U0zXP7JpXbzgpZ2LxsMnOFhmD53Kw27DAvZ60c+2jNX5kvuZnltywEOq8CI1CM1lvAdsG6w5scm5Wn9k11PyKt2kZbwb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S99D42A7; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24456ce0b96so19837005ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757669271; x=1758274071; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3tSH5UPTW11Y9XuzBfniGHAKTRbqqxgrANUoPyfLX9A=;
        b=S99D42A7T0nrNsHpFhPhe+ly2iDBO5C4Rw4pqonjYSH8715QNB6TZasAmTfo9UivV3
         zTikZiZY9CtMA4BqdlcuwvYpm+RwNtaXtqE4pnaIUANW6mqR873Ua/9Zyn56j09C729X
         NctCgaP8tnrjPBtkHzvZVapVf2+u+McDoqNSvS8FH5Dcx/orqYbq1UpZXpezHZb4hOO+
         oP1GS4mBav9QGjQuOqces6l0hPrRLfRxIloYwPR8MlAVLFapiVeN7kV7/gKdF41LEl7x
         hW3YjvsztxMellSab6OQpxMp4pr9hv4oF1NV9fmALC1Iauh742y286iifoh37o1wATaF
         7dVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757669271; x=1758274071;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3tSH5UPTW11Y9XuzBfniGHAKTRbqqxgrANUoPyfLX9A=;
        b=C9dgvD07d4uM0uKQB49GwalQvp03zxCjsh+SWg20mtNczskRfMKk3wfbeSpZ+bLhmo
         kxBQunQD1lZyf6LgUgmfNm1QD/eLIE0ZyBtUU/gu4LRiY8yHUlZ6fYSYQ2/ANJKNqF/p
         v7CCHm5Jt7HK7BRtJlWydXrsgNocsgUqV3u/TjE3pQW0biBpl8waliKyPaWJiBwBvyP3
         qcMvZeailZvHQ39ZZ4BrWSGIsi2215ZCmDIxrAJDuhhI9uAS178v0FKfQhn66SUvH1hT
         VsrsZTtUE1sgweQmu/qamKrFU8bkNGwkHXOmAOl8RPWsqtArMVwZEh93R3N3O7VcdJq4
         I4yQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3LBOfZUp2KMDXelocx47y+ICOJViuZ8Orubcld0IMtG8mTJkQT3jaL+eZz+oOKfLdgxyIYId1pkLdvBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOxyI8YjdFBIsYSDwhNKX8DoQdwNFMM/WcNQlt2jwPx7qWAnPb
	0HPc8By7SwBmgvLEntit7jegl+ExbYC3+4H1JrtLhcKBQ1zJyHuPhEL7sa0V2gcWrXpXxCrnMoX
	PtJk88mOlDxVqoIw5u9J9+zScw85BvsVR3R/DA8fuQg==
X-Gm-Gg: ASbGncuRqkYgoEtsqZA3TqJ/glOkvoL/Ja8QKNyI3UxLMtJUSbN+Ve4ckxphKiDR8gU
	X9g4giK3xF+W3Qwfu240BiQb4dKR2yoj6B02fhKS9LJY2q948Dgwv9KuZ6Yrxn5CtAK4PZmvUgv
	IqyRmKJOdXRb6vZtXezD1o3AIUGKTft8Wq/DI549LNTCNDiWPfcQAC/W6JHup43QHqptj2Y2WDP
	gpPW0Da5imKSWq27hglEYvXmgxID0cW5gfa/wxJPx2F2QwLrlF5/ScxxacxCD7Qod3nvRPa
X-Google-Smtp-Source: AGHT+IGZ9/J/gRux6Yk+W24Z34To2Mx5yS/AKLrFXbt6lRuuYYcUiQ9kDBNt6XBpcfyt0QsI4mIodpEyYI0UUJ58oww=
X-Received: by 2002:a17:902:a718:b0:25c:4d67:4deb with SMTP id
 d9443c01a7336-25d2ab3e054mr18239165ad.8.1757669271042; Fri, 12 Sep 2025
 02:27:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 12 Sep 2025 14:57:39 +0530
X-Gm-Features: AS18NWC_BexFmwLhPfYunrkIwo54ALG6qwusgzRfQHujBXuhNkTXAN-rFLSveGY
Message-ID: <CA+G9fYv0rvRLMM+20vNSdzVWoT4skpoJ9EjD0LyY6dD1TqjTzg@mail.gmail.com>
Subject: next-20250912: rustgcc: x86_64-linux-gnu-ld: error: unplaced orphan
 section `.sframe' from `vmlinux.o'
To: rust-for-linux@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following build warnings / errors noticed on x86_64 rust config
with rustgcc toolchains on the Linux next-20250912 tag.

The change in the build environment noticed as rustgcc version upgrade
gcc (Debian 14.3.0-5) 14.3.0 to gcc (Debian 15.2.0-3) 15.2.0

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Test regression: next-20250912: x86_64-linux-gnu-ld: error: unplaced
orphan section `.sframe' from `vmlinux.o'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test log
x86_64-linux-gnu-ld: error: unplaced orphan section `.sframe' from `vmlinux.o'

## Source
* Kernel version: 6.17.0-rc5
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: 6.17.0-rc5-next-20250912
* Git commit: 590b221ed4256fd6c34d3dea77aa5bd6e741bbc1
* Architectures: x86_64
* Toolchains: gcc (Debian 15.2.0-3) 15.2.0
* Kconfigs: rustgcc-lkftconfig-kselftest

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29861691/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250912/build/rustgcc-lkftconfig-kselftest/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/32aTGwi7jsx5icm9sDcpfJLbJQB
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32aTGwi7jsx5icm9sDcpfJLbJQB/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/32aTGwi7jsx5icm9sDcpfJLbJQB/config

--
Linaro LKFT

