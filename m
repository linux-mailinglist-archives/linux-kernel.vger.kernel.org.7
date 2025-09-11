Return-Path: <linux-kernel+bounces-811638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79098B52BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3356F3AEEF8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB332E5405;
	Thu, 11 Sep 2025 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZll/icZ"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C9D2E2F04
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579838; cv=none; b=lJzvEIOn8BmASuCNFvTz2W2tL77XLA2pjG/OGc2iglbuM3+7HW9oMv+bfF11AE3Q//rJldJLLbxCf3bgvqlab12/V/G2fD3OeNECVoocJ12A2R7r3ot99UJzmJlKPmlMsevShDubZ4fl9Q5L16rRjr8XLlt7GwoU6ey9C/vAMFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579838; c=relaxed/simple;
	bh=dXdheL8JephKYsdZVZ5VzVXsD0ljrqlK8eaSDZXPjes=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CUxHpHisoL+IvKqphXbzU3jT/AIf0VNrYIWWKPzqimVclq/BzepTfrNNsRTRbuom+hyYVP5NIjw07yuJ0oMB+ZeuU/zlWOP1KUB+exFlnKFo2S2ivIVIdOZ4VgVocEw86qZolj0xi/JYrcOPD3Zif15H4xk7nUTFUq61AmCYq1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LZll/icZ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b523fb676efso396156a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757579836; x=1758184636; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XlHLF6IxLX265PKrXSfqim3Osu2zErg+VtcQhos8Amk=;
        b=LZll/icZ5VjvpnBEzb29UzebmcBqQssZq7pjCRL7oBISsR7v6SCCjNrrcYWA+N3nK9
         P//u/BClj+MY7Nl7OXFnRn+tq3j8jCH2z0sSaX70MCT7lYP/x8Z/wGgpg5f27iE/W+dq
         ujeEtLnToPnOP+ahq+FfrmbnFn2AsBAc5EugHySO1DTNOJdWO71hWIHARCzZkIPsGd2t
         P9viFuOWg2Qn7WveBB4VL24TccMzdmMwF3TgR45OsJW83dq2hMJtkzWOLVoqZEXyjEgd
         vrimvUYebj+cPkiJnIMMjiA7LdlExSzIvQh7ER+hG4JBBLF9m9DIbXTTxIzBiTHA3vZD
         9pvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757579836; x=1758184636;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XlHLF6IxLX265PKrXSfqim3Osu2zErg+VtcQhos8Amk=;
        b=cEUnJzdI9CxWysmiz5rkqROmglOVz1200nrCWGlEk7ICXub4+NgQaNHBHk3UPU1aOx
         PO+kCyRRzxmybWEXhMj4EF5X1+1/5DDSOqcrZQIbYjmfSKwxG+ogFyfOnoTJESdWySkp
         gvEyeyHJCqrqZIY29zrIqSmsa7DUPgCPXR8mgmSOflBLs+WdBqsTaV01OGahMb7ji5uw
         ssZo6a9dVZA7OQHAIhOAN4Yhle/Nj4MqSBLm2r8AfIQrXq/qaDQAJllu5L/rJbP09btL
         HZDAFvyep/MHTPtSMfa+v2h+t3EQN6gVtcp7I8HY8RpDxnhC5EUqxUu8rc8YEazqIM+6
         /I6g==
X-Gm-Message-State: AOJu0YwnTQelEiY+hA9H9h6JgwA7uXacnWze2PtYhjuCjNM63zHuLbl4
	+2VM2A8x+4PlgG2yR8S1QJldLQmNrbivEIK5qzcm8O3vSzZ/GwVQowDPa8jP7fxj41vO/8NkzHO
	qInFSNIqeaupcxp2kS4DHHw0XAxvOvL6S9ngo4MvTiKDJ/9tzUoFSBmw=
X-Gm-Gg: ASbGnctctenlzGiSRGJ2Ve1cGu/RkTYQ5Cwf3xr/TK39mp+leieQI7CwNKaSxPSgPdG
	QgNgRYBPnDA+HLRvp9/lwqwsLdcQykxgMjnkfdGDZbs7r2cRzikpkPCnNI39h+EZt2m6YU1Hmyf
	toVIA+C7jpgfI+WmFIdGYBgjbF3+85QZ4pmvOCvTB4toJGlzBouKopy9SL2oLJvTt5NgRIk6E6A
	/L6k2sE5ZnVt6hV4x59e890orvq8U3w+CBAoGbhcUSpLfOt/32D4pyZUIaJjzIQEl7blGfLkZ/I
	mKEmhDI=
X-Google-Smtp-Source: AGHT+IGR2+igFyrerQ3HlTU0fDr7FuwZJE+/EsvxJ0BM47OK3QyzESdHU/BATUPNXmekU8opkqkhhnxnT4KYCn47WJg=
X-Received: by 2002:a17:903:230a:b0:24f:30dc:d3fe with SMTP id
 d9443c01a7336-25170e428f3mr249071415ad.29.1757579835668; Thu, 11 Sep 2025
 01:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 11 Sep 2025 14:07:04 +0530
X-Gm-Features: AS18NWDVnn8cWFJt-IwGb3BydlPhAt8pRyLoCxHvXGT9gVTi8T47w_BuQztkQok
Message-ID: <CA+G9fYtUi3bnZ2zycCot6KGeZcn67JAvz=wZm=6f2w9ZnL=0Uw@mail.gmail.com>
Subject: next-20250911: mm/slub.c:3960:27: error: a function declaration
 without a prototype is deprecated in all versions of C void flush_all_rcu_sheaves()
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, clang-built-linux <llvm@lists.linux.dev>, 
	linux-mm <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following build warnings / errors noticed on aram arm64 defconfig
with clang-20 and clang-nightly toolchains on the Linux next-20250911 tag.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Build regression: next-20250911: mm/slub.c:3960:27: error: a function
declaration without a prototype is deprecated in all versions of C
void flush_all_rcu_sheaves()

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
mm/slub.c:3960:27: error: a function declaration without a prototype
is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
 3960 | void flush_all_rcu_sheaves()
      |                           ^
      |                            void
1 error generated.

## Source
* Kernel version: 6.17.0-rc5
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: 6.17.0-rc5-next-20250911
* Git commit: 8f21d9da46702c4d6951ba60ca8a05f42870fe8f
* Architectures: arm, arm64, i386,  mips, powerpc, riscv, s390
* Toolchains: clang-20 and clang-nightly
* clang: Debian clang version 20.1.8
(++20250809043815+87f0227cb601-1~exp1~20250809163919.3)
* Kconfigs: defconfig+lkftconfigs

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29853978/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250911/build/clang-20-defconfig/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/32XlFDtH7RdddaA6FHskupLDDSO
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32XlFDtH7RdddaA6FHskupLDDSO/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/32XlFDtH7RdddaA6FHskupLDDSO/config
* Build log details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250911/log-parser-build-clang/clang-compiler-mm_slub_c-error-a-function-declaration-without-a-prototype-is-deprecated-in-all-versions-of-c/

--
Linaro LKFT

