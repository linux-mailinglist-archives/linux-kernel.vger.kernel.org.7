Return-Path: <linux-kernel+bounces-802880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C591DB457DD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985521C26FBF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF5D286898;
	Fri,  5 Sep 2025 12:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ouZjKHTT"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C44D34AAE8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757075341; cv=none; b=YjkPk57K6ydIP634HC9LXIrSZdL4EiTmvitVAJJ9eHfmrZSNuFpfpECKltVEOXt9Wx/ny66UiFwYfD3XbxxyUmIhFVMU89aAq2Au0zJW1R5ROZhqyea9fvUkwgyIPjy+SAa9lApSPZ/Q8vTuazvi3/Y3tBl+hlThacrak+tRRRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757075341; c=relaxed/simple;
	bh=1e+7pVVhym3gaMFer/Sr7WBp0M9KyyXCLvjyMZeZThc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=H6ipUvNDYFNG57HH+e9CXXXJ0y2lVPQHoekdZby1ms/ISH5WQC603RyfAHd0e3t2LJWz9kjC6BxiQwOuZlxFlHPlRnt46ktArxERe1MT74AsBda337qSRe1JodRVDJdHkbRfdTjRKNcQutlTgqG5iOaKnCMHSLR7lBzYBeElYO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ouZjKHTT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24622df0d95so16155515ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 05:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757075339; x=1757680139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vt2kS9Ofun09w/F1kEUInf1+goE6RJwp8Jq2yr6GTno=;
        b=ouZjKHTTy4SZK1s9/WQPXVsZn+P4TSdZTkU3uib6YAF+IRml+lbdOoRiZaUxykhVom
         SMl1VUFz42ytLbJxkqhVv/UKu7TG796KbuUSGNfyS6hBDc9u9LC2eEXklWiljwF0zjYv
         IscMwcLaPImW0aWToXqV0lVNRE5wXDFAdLjLnK8gx/Y+mMShNJP7CM/XHyZkH5FxJIEc
         /5W4vRQIkyskvsGMJh2M0NYU1II5TqYepbijb265xGMxJckj4ltqDiaSEVpxrtBy5V4j
         9Y/bnHayTkIoJPH4TdKzYOG4gvBF1wPPDTCTA8wxfRRb31oYx8oWuD1s4Fyp6TiUXvAl
         X+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757075339; x=1757680139;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vt2kS9Ofun09w/F1kEUInf1+goE6RJwp8Jq2yr6GTno=;
        b=HMEOiJxeSXa//WLrP2I87gCMRyb2vbQTfiwljp9AiwLSGw4/bKvjcaFn664RmDca0k
         V39BBpABnZI2ZGkiaDUrDMhjyBsDZPWjPvsL3eBwbRdH3SIC2QWMRnuLrlKan8WRCGbp
         dgH8w78e/93mgG8g4N7VoGON47RK8Kx6iJ1rQk+Q+JMszinMvG4A1k0Ej9swEfCkBYuZ
         sNWO+wY6120X7utAM70Wth8iGP27G1P52ANCP3aawfkO84y+vgmQTiZ/2pRoVG6PLpEz
         75ovnRaaxcPgXaW+370kZCJNAxYvUmGMQHP6IlLZMqgwnfoK5BwacthH2lzUZvpYJPrB
         M4pg==
X-Forwarded-Encrypted: i=1; AJvYcCX9Se5g42OUiNaC45B/i9dygYC5mc3Kbvx/hla389d6mo13CjkIOsY1/DXAu8UfYDvTLKefp8R0pSep6Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YylgduYfEgFOOZOYx463wsDbFieHsxNit/dPVfBfnETVu55jZIb
	YtfNe1nslTL0KfNkO4t7VKuoAgR7iIX/S+qV9CgfYqqjDM0GBr4LfG11im7QGp7g2UV1LVc5OmM
	N3J0mY/lwLYLkWt4qEi5F3s2z2wrDuNzx+oWal2mxyw==
X-Gm-Gg: ASbGncs4udSXGc40h+beyf6oatOs+UayEYUjL2kOlttXCP8pn4GRxc39j5s7IWqmn0a
	KwxhZwfyop9/bOlrphHp3VA1z/N2z1v8LLIyFDcHEiHeotSCnHg3R7Zd5ZiRhoHHdl+s8YImsDS
	/DT375sna6R3YWVp6l5bvEYjfXIjE0zkV2t/0rQNXyPje4AIK82Dk0JBZY4403SYcprg2MbLrF2
	SKiimZ1LLTTPgJK4qEtuP/pVQEqvYQOgIGOg+z8
X-Google-Smtp-Source: AGHT+IF2VyihlpYLlMLSpcAIk2s/i+EE+s5Gnsq5S4v8IDPjr3MF6OBdBjnQtI+Tuw5M38cyKFUCV97IWUQkg/iXocw=
X-Received: by 2002:a17:903:2385:b0:246:80ef:87fc with SMTP id
 d9443c01a7336-24944af38c7mr260768135ad.45.1757075339192; Fri, 05 Sep 2025
 05:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 5 Sep 2025 17:58:45 +0530
X-Gm-Features: Ac12FXw7Gdb40oCU__VJhJHzl8UybprNIkBlFrRCtJMXzI7n6pFfMa6roDMYZnY
Message-ID: <CA+G9fYsT3b3Qd-m6tSDOgAXpgLPWz0QD_Z6a+_ff4oTecA85PQ@mail.gmail.com>
Subject: kvm-unit-tests hang on Arm FVP with protected mode
To: kvmarm@lists.linux.dev, Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Fuad Tabba <tabba@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Mark Brown <broonie@kernel.org>, 
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Content-Type: text/plain; charset="UTF-8"

kvm-unit-tests consistently hang on Arm FVP when booted with
kvm-arm.mode=protected across both 4K and 64K page-size kernel builds.

Running the same tests with kvm-arm.mode=vhe completes successfully.

Anders, bisected and identified the first bad commit as:

  066daa8d3bc2694c392e14091978043aed7b1f23
  KVM: arm64: Initialize HCRX_EL2 traps in pKVM

Regression Analysis:
- Reproducibility? yes

Test regression: kvm-unit-tests hang on Arm FVP with kvm-arm.mode=protected

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Environment:
Platform: Arm FVP base-revc
Kernel: arm64 (tested with 4K and 64K page sizes)
Mode: kvm-arm.mode=protected (hangs) vs kvm-arm.mode=vhe (passes)
Test suite: kvm-unit-tests (./run_tests.sh -a -t -v)
Cmdline args : kvm-arm.mode=protected
Kernel: Mainline master and Linux next master

Test run log:
INFO: running kvm unit tests ...
+ [ True = false ]
+ ./run_tests.sh -a -t -v
+ tee -a /lava-1/0/tests/0_kvm-unit-tests/automated/linux/kvm-unit-tests/output/result_log.txt
TAP version 13

Links:
https://regressions.linaro.org/lkft/linux-mainline-master/v6.17-rc4/lava/kvm-unit-tests/history/?page=1
https://qa-reports.linaro.org/api/testruns/29720932/log_file/

--
Linaro LKFT
https://lkft.linaro.org

