Return-Path: <linux-kernel+bounces-889784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51403C3E82B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 06:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EFB03AD93F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 05:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7F527F754;
	Fri,  7 Nov 2025 05:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2fe+DTWa"
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015AE79DA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 05:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762493392; cv=none; b=NOFrRSsyv4/nA5r2ub8CCT4URsA8eECxqV+LqMl6DenRz1Bz32uEFHFCU/XCvScYX1mROl2iTjZBk0wBQvdVsdPpVkCaOIo0inmv2HsrKVHZ+FHTVw8srW5lmqrkt6ICJyHW5pHuqEGNtvVAejOwdKElGkxhTrdQQLFyaVhWnqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762493392; c=relaxed/simple;
	bh=RV9zvylkghKN55Hz0b0NOWqbwRthFQ9z21H6uAqwdwo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dZc2DCZFbdhf/n773o8ZSIu/M2bwmNO/lUbak/dN8lLVMd0brtqNAJVmfvVWrgMAa5dv93ZVOH8gcUDmxR4Lx+dYVAqzvw0J6o1dQ+qaorR7W7/EDdzjjOqW8Q8PnBjv9afzRKZZRe1faNjoBIwiESw4wxWwuDaT/ZRAFQWZ5V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2fe+DTWa; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-87bf4ed75beso9995336d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 21:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762493389; x=1763098189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=njV6Z7e8AHZ3jv7SEHiGiHSYJwXRJtYkycrQltatJm8=;
        b=2fe+DTWa4ByZxAPi4XredV038SRctmSxKdmDPjYS3uJ+yrEncknUPk0tZw8HGFGdnd
         OX080qcaIsim+s4xxUWhLN3HQFmxcT92SnSQcBhf9H+AY1tZ51h+Vcp3mrN5TVFuhpmD
         Qme00bpEvBVBgR1QDy+k2pa9U74T5aQ54Akk7CqyTlTNCEDtHZDKNggk1EtrwgxE4Y0G
         D/qSfiHwp2HcbuAECEyM2io00DBRQ+K9ZOtDB0ypNMjUCgJ4E26sU4+yq9gaic8Rx66q
         KU7ID8YNQRxQ2PS2pBMqGoiRRli9HGCPMdLFuh4YtSzEoMsX5DFsbwj5o99EAWr6FV3w
         M3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762493389; x=1763098189;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=njV6Z7e8AHZ3jv7SEHiGiHSYJwXRJtYkycrQltatJm8=;
        b=AWLK1OT2qVGDt34AxdwWRrcG52Ey4mMuUuB6ROTTO/i5rUY2gqeJJUFr0bU9xSljyk
         92GX13iwQC7bxkK3G19oNqLL2EK4ujxm0sPUvatXwATTwafXfAl6hdmk0xVVD0kQ6MC9
         /VwxVJnL7n5TKWXVFggQI1HWr65LYgQ53gKfJCKXI2QaV/uretIcmX7GBB4AcHV7uT+p
         r+4hPxbCpZixCgFoOzF3ifFuuS7Vm3qxPKSjv9G8AGiWnOwGQGDhGrQaJvjk0dYuzH2/
         IwR9yMYNDwKM82C+d3WLEJ5PCHz1MhNygIHnZHk4b6VSoEuGQPxp/76Cd7R7V6613/BY
         WkdA==
X-Forwarded-Encrypted: i=1; AJvYcCXpcfIHqjt7rC+1x9KTw1cyijlrcMVww+oTysY805k7bl6SMjXS5p9j2hQ9z5Bk+9Vi6POPqQiJ64nxsS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YymSN+SC0aTsaFt9IjXuUOpR2E0doIveUmZOM1edQnvVlKXPncp
	D9QbQZnd2XX8iZi86Ev/YtCkv8ugqlQeTSMaiXqzasb2BBXtjDGTI4pfTqIwP4xlddIh/TaiFeK
	h6Q==
X-Google-Smtp-Source: AGHT+IEcveD+OrmGuHXxDDibGvZt08sbWYuxuP0sLlsVz06qCZqoaz8Zfmbg2vG1rZ8pO+UwsxKrjpQ2Jg==
X-Received: from qvag28.prod.google.com ([2002:a0c:f09c:0:b0:880:65e3:ffd7])
 (user=rmoar job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6214:5009:b0:87c:2559:fa28
 with SMTP id 6a1803df08f44-881767567f2mr25885676d6.43.1762493388956; Thu, 06
 Nov 2025 21:29:48 -0800 (PST)
Date: Fri,  7 Nov 2025 05:29:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107052926.3403265-1-rmoar@google.com>
Subject: [PATCH RESEND 0/5] release of KTAP version 2
From: Rae Moar <rmoar@google.com>
To: frowand.list@gmail.com, davidgow@google.com, keescook@chromium.org, 
	raemoar63@gmail.com, Tim.Bird@sony.com, shuah@kernel.org
Cc: tytso@google.com, gustavo.padovan@collabora.com, 
	ricardo.canuelo@collabora.com, corbet@lwn.net, kernelci@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi all! I wanted to resend out this series to respark the discussion
on KTAP version 2. Many of the features proposed are already in use by
KUnit. This would add these features to the KTAP documentation. Note
that all the features of KTAP v2 are backwards compatible. Also, today
is my last day at Google so I will be responding with my personal
email afterwards.

--

This patch series represents the final release of KTAP version 2.

There have been open discussions on version 2 for just over 2
years. This patch series marks the end of KTAP version 2 development
and beginning of the KTAP version 3 development.

The largest component of KTAP version 2 release is the addition of test
metadata to the specification. KTAP metadata could include any test
information that is pertinent for user interaction before or after the
running of the test. For example, the test file path or the test speed.

Example of KTAP Metadata:

 KTAP version 2
 #:ktap_test: main
 #:ktap_arch: uml
 1..1
     KTAP version 2
     #:ktap_test: suite_1
     #:ktap_subsystem: example
     #:ktap_test_file: lib/test.c
     1..2
     ok 1 test_1
     #:ktap_test: test_2
     #:ktap_speed: very_slow
     # test_2 has begun
     #:custom_is_flaky: true
     ok 2 test_2
 # suite_1 has passed
 ok 1 suite_1

The release also includes some formatting fixes and changes to update
the specification to version 2.

Frank Rowand (2):
  ktap_v2: change version to 2-rc in KTAP specification
  ktap_v2: change "version 1" to "version 2" in examples

Rae Moar (3):
  ktap_v2: add test metadata
  ktap_v2: formatting fixes to ktap spec
  ktap_v2: change version to 2 in KTAP specification

 Documentation/dev-tools/ktap.rst | 273 +++++++++++++++++++++++++++++--
 1 file changed, 257 insertions(+), 16 deletions(-)


base-commit: 9de5f847ef8fa205f4fd704a381d32ecb5b66da9
-- 
2.51.2.1041.gc1ab5b90ca-goog


