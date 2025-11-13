Return-Path: <linux-kernel+bounces-900044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E212BC59705
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6746F34EB0E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933A63431F2;
	Thu, 13 Nov 2025 18:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffvFJRfL"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388F6299AB5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763058274; cv=none; b=JLl6BNvrAGZpFzABP9C3EZzqCkvh/DsWCNIvKqe0MBexHsCw+llUUyFzLjX3/GiDH3nxz1MI6m0v+e0aP5zB0ccAScZ5uw4wcdKni2O60ZWugDdXAz0UZaP0mIkSNKyxnPiedFrNRsGNaH2Xm9mrn3mDBbJuLgDP6+O01mxpNVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763058274; c=relaxed/simple;
	bh=GxwZBK6XBYVtQFQee+RbRweae6ZoYM6xfAdJdB9bBnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aRv3Nu95YRJ9y0qH++ELIHmSWs36Ot0Vl4Iohc9Ke90Q3A3hxGM81/ZNS29BSv2Gry4YZJWo2klSV7TbMDcyUQ5CcDF8A/P+4+639ryDmSoZOtGdyQf7qzmaESnK0s1xRaSJFsyp3ngzlLyHahUxmAlCmYrnjAqOuQi1ETVqFLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffvFJRfL; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-882451b353fso7728496d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763058272; x=1763663072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qHcq97qEfbS69vhpABIO6rBUjZBY25lZ3caWXii+0Kc=;
        b=ffvFJRfLIsRFwIjrcTL7biAlEtY5+rimb7NrxC50eCzh8Y5NzoNY4FpUkxryaJTDMu
         7RilITAKeS6+jx/G9uj11IjtD/YimX514GfugRWGlixz2/Nqplr9wq0z0Tx9s7xX000f
         FosRyc36/qy07f3461aQ/BSTpMpEtUzoOocKbsSkwewDovMikYZlw+Q3Ujuo6yD7Okpj
         Z6SqTxvTwsQ/0wc5OPhrT56gcej13q7IUeIjlfqbIhuj2EMlHDXgTic4M9i4tiYT5LDe
         VHKaPdeked4Oc6PjwdFVRkzBUuSRyWwcaqckjxO70oRadgUANC4tz3dvCCpot0dbY4O6
         imbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763058272; x=1763663072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHcq97qEfbS69vhpABIO6rBUjZBY25lZ3caWXii+0Kc=;
        b=VoxQ74bIy32Wvaf09rltBSsFIsiTAFOagNhtVDuE+vk1nC4pd0dkxernggJN2T/1nM
         7SJqXq9AMxmuaKW1DzfVPh6l0a4MnwooUw9NoFfxcUhsbooiwkXme54MiMiVHdzLQC6z
         /eeJp1fGwvf8BmHyCLJAw8zC8DwnxDRPIK0mvDAcPIvA0JN3WUZGcPGuDcKsUP75Y0Gf
         zXHu/8Ke8tWmuOcFEconv6ihcP8ZMTE3Rb+p21A0kz8Jhngoxg764UP4Pk6DpgBKF+rH
         91AkwvAzg35Xts2zBef4WN31SBuONng92yDeUqvt9Cw9tkFvPHnNcXi7nA1febIhhIKA
         iKOw==
X-Forwarded-Encrypted: i=1; AJvYcCWCtFTgbZ2/WQO5ar8WmH9gzK8ZTwg1GgHHxt58DPqiusR5wY5whLj2qkcORAJs3SOg1gUdUb4rRetCYgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd0pHn/udUUoC4LY715eeSL8fVv1NnEsVmKE3Buk01q2E70S0F
	j3x4b7WQlxwH7uZFyzJkLZ+pOz6UKA9TG9jPBs7eC64dJP/BYn84WJVSDaFuwAHX
X-Gm-Gg: ASbGncvuzABhDRRp3HREQeZu0ydlaxoCxROP5xG/wiDaGtPzTN1FUjmD5wXxI1mZwGN
	HsNmElZ5E5FQMI2D2xtC2pdc0aCxwV/wM0AOZpCHdda2Oxtn8nLWjlAGxGlOUJHsau0z7STwhD4
	q00Zm/GRjXLaOEV4fxcroZ2UY+HpdUPb5vBoHEEE66+kl6YUJj2Hqpqoawz+nfu//AnHgKCq9tO
	c21Tye1zwuO+Q403g8Pi4QrYOCmrtuusrtWbKgMvMb0wagBllDATC4bpG4qCl2sP9u50q52VUC+
	P8lsgxHbIQ0DUnkoioy8ix/i5c2i/sntXBe07XfskgSzwF0cpUviEmw2udIwblZ4FyPIOtCt+uV
	MljC8ujyOgXYqzt0AdxDWgckwMcBMvJ6M8QCeYWmNBONKwXdaw6HnlBiwLbOkEmA=
X-Google-Smtp-Source: AGHT+IEuHrQi2xk2TIdF31ITi/sF5nfyhxNn2P51QkfCQzmkL70CjwgLYRdIcKFbAZIRym3kaBIpcg==
X-Received: by 2002:a05:6214:3012:b0:880:2a49:7047 with SMTP id 6a1803df08f44-88292686ab7mr1170126d6.35.1763058271931;
        Thu, 13 Nov 2025 10:24:31 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828652c882sm16941376d6.32.2025.11.13.10.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 10:24:31 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rteval-v3.10
Date: Thu, 13 Nov 2025 13:23:54 -0500
Message-ID: <20251113182354.43767-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I am pleased to announce v3.10 of rteval

This version has some changes to make the timerlat module work more
closely to the cyclictest module. In particular we set dma_latency to 0
by default. You can of course shut that off, or use a different number

It is also easier now to switch back and forth between cyclictest and
timerlat. Before you had to edit the rteval.conf file, and you can still
do this, but there is also a command-line switch to change this. If you
don't specify at the command-line or in the rteval.conf file, then
timerlat is the default.

The menu now displays the cyclictest and timerlat options
simultaneously.

--no-aa (no auto-analysis in timerlat) is a default now.

To fetch

Clone
git://git.kernel.org/pub/scm/utils/rteval/rteval.git

Branch: main
Tag: v3.10

Tarballs available here:
https://kernel.org/pub/linux/utils/rteval

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rteval/older

To accommodate distributions that require this, I have linked the last
version v3.9 from the older directory to the current directory

Bug reports, patches, etc are always welcome.

Enjoy!


John Kacur (22):
  rteval: Fix missing statistics for system with timerlat
  rteval: Change the default interval for timerlat to 1100us
  rteval: Change default measurement module to cyclictest
  rteval: services.py: Fix SyntaxWarning
  rteval: Make timerlat the default for rteval
  rteval: Fix spelling of 'occurrences' in measurement modules
  rteval: Fix typo in comment
  rteval: Remove unused function remove_offline
  rteval: timerlat: Fix typo in log message
  rteval: cyclictest: Fix typo in comment
  rteval: rtevalConfig: Remove redundant 'is True' comparison
  rteval: Clean up MANIFEST.in and fix newnet.py copyright header
  rteval: Add pyproject.toml for modern Python packaging
  rteval: Improve argparse implementation and remove manual sys.argv
    parsing
  rteval: timerlat: Add dma_latency option with default value of 0
  rteval: Add --measurement-module command-line argument
  rteval: Add unit tests for --measurement-module argument
  rteval: Remove outdated TODO file
  rteval: Show both cyclictest and timerlat options in help menu
  rteval: timerlat: Disable auto-analysis with --no-aa
  rteval: Upgrade kcompile kernel to linux-6.17.7
  Create rteval-3.10

Tomas Glozar (1):
  rteval: Introduce E2E tests with output checking

 Dockerfile                                 |   2 +-
 MANIFEST.in                                |   3 +-
 Makefile                                   |  15 +-
 README                                     |   5 +
 TODO                                       |  26 ---
 pyproject.toml                             |  58 ++++++
 rteval-cmd                                 | 156 ++++++++++-------
 rteval/modules/__init__.py                 |   7 +
 rteval/modules/loads/kcompile.py           |   4 +-
 rteval/modules/measurement/__init__.py     |   2 +-
 rteval/modules/measurement/cyclictest.py   |   8 +-
 rteval/modules/measurement/timerlat.py     |  33 +++-
 rteval/rteval.conf                         |   2 +-
 rteval/rtevalConfig.py                     |   2 +-
 rteval/rteval_text.xsl                     |   2 +-
 rteval/sysinfo/newnet.py                   |   3 +-
 rteval/sysinfo/services.py                 |   2 +-
 rteval/version.py                          |   2 +-
 run_tests.sh                               |  89 ++++++++++
 setup.py                                   |   6 +-
 tests/e2e/basic.t                          |  26 +++
 tests/e2e/engine.sh                        |  81 +++++++++
 tests/e2e/loads.t                          |  72 ++++++++
 tests/e2e/measurement.t                    | 101 +++++++++++
 tests/test_measurement_module_selection.py | 195 +++++++++++++++++++++
 25 files changed, 785 insertions(+), 117 deletions(-)
 delete mode 100644 TODO
 create mode 100644 pyproject.toml
 create mode 100755 run_tests.sh
 create mode 100644 tests/e2e/basic.t
 create mode 100644 tests/e2e/engine.sh
 create mode 100644 tests/e2e/loads.t
 create mode 100644 tests/e2e/measurement.t
 create mode 100755 tests/test_measurement_module_selection.py

-- 
2.51.1


