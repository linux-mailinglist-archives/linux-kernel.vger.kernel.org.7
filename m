Return-Path: <linux-kernel+bounces-866771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD48C009B1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D267188CB08
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C082FE573;
	Thu, 23 Oct 2025 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMpFqx/u"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F842C0266
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217290; cv=none; b=QSEjkymZzo3+kA4zRa52xyZwwkYYD4M+bKWEyj944IbnD/NZN0lUA0QBG9Zl/3Sh4X6oItfHCXzMrWd79a4KAjFhzDuoGjHEU3LpspUUBJm3FzsrAP8a/ghY5rfYaTgJthjVHz05PINjwZxTi08syQsKMAefkkn24fYd/2sUOSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217290; c=relaxed/simple;
	bh=DFWDJk+24pNet0OJCXEpo9V/rxDdmMAnFVU1/Xh7xn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F8ougL+A5vf+KbEuL/+TfkKJFAx+Q7Y7oQs3mqrkIOE5vX1nTdaYIl9yG0MYLn0s6itYiOC4ofcwM5OOuJWVvS5CvA62ei15XFGeICeNvFajS0KuYzricw3ll9OPafLsM7NwbeqOauyHVbVwUy2eqSgGRB7CE8Acvnrs4JtxykI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMpFqx/u; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47495477241so5326575e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761217287; x=1761822087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O3zVGoM8Ba9ML7IhgEq3CN+S8ajIfauDGxxTBvQosUo=;
        b=cMpFqx/u1z7GvLTJV24fS57aztDG5MhX6IVawPCEQMAJuY4pjLjGVLnEqZEFWsdFin
         KvE2TsdNLmhU5Hg0jwq1SpomX1TUpMyX4MWzXzT8wJ7cF+rrUBPg2yTHzCEJVSLryCtV
         IHSyrQoLZfc9pTFLGbb6izU/jqy5mAB198WKuNtVwN3SjM4ofH5AcnqKRU0yGrMOdgrg
         JE2IlWOeu9pmdOd1iEXZMK5dGUVUfppqlady/UF48KxejaoG6stlfVc9pOQ8POks/117
         9zTOjH5LQzSOlVJs4pGSKgdp8IsKriNvlp/ygnJa14df17S21alGeahNxPnxEKpoCxXc
         XXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761217287; x=1761822087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3zVGoM8Ba9ML7IhgEq3CN+S8ajIfauDGxxTBvQosUo=;
        b=UBUfs8O2fnHbz1Uq07ky1pkZqKpBLHXroNWgxbSl05JAqCDjDkQJUNdAGneiLuVekF
         DVOFGKpoy/UUBorMrKN8Ym74VmcnS3/e5pIm5+WvE1Mb5EX+ABt8mdpe+JDHR6T2q29O
         ljfCm3z0RfqPe0O420fwvJv8vQChxvATjBal4WLk6izrEMwZyGGty9W6VrCTLJHHzU4R
         p+fW6EN1wa6NOQ890mecKcLiIxz9rKye0xh4naVFtqMj5bc+V1trJ/NWkV6/Do/bNTOM
         z8bdWUmLIaWfKceLN8/Ew0cjLV3yyinv0EHY1NA2VjzhEx8xOH4q27AGAKoKymMV2GKe
         9rBw==
X-Forwarded-Encrypted: i=1; AJvYcCX8OXEbU/28g5UTqect9+JGdLxQ2b73k8tjkEYDaoUmwdOFnT2DSQfE5MGLQ7snMfMqhmu3rYx9zQiBiEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHA50ZmswEy4SRaBCOTNBnEhSDP1oy/NqkuHpRpTD7QeutCXcu
	KZ5wBXIaImlznTm03P/wHXtycINupXQY+smsx1un0mdN0MS6Qyf35zt3
X-Gm-Gg: ASbGncsxnlrjx1tgGRkxwsXQ9fYSP4QW9ANyHaFVAaPU5ohVcLSCZVC1s6EseGSzq/T
	frTdhVoJ2VNcJuRpvHZFYKO9qPk6ClzuTFkks/VVLy7+cbHMztwomhmJkdl33SNUiVo86FYziXA
	Z1FWEhLIL+fhWA3RQKFYQc5FUn7wCaJUQ9x49bRAuwx9Oi6lN9P7dDVzhhMmCM0ZMIgpfstaT8U
	PfvEoQgYFgxXCsS/fMtCvBFrtWQwrAEdDySm2pSdV7IqD/ciJw57ylKTSpGWsLRqPVDok3+RClE
	n7BRwv0Li9OtOmx83MU5l7ZN0MpDIYwYTwf/ZGGM/PvPZjWnoU3zuXXilIhzbn/WSSZ1akWTrTk
	rH/gqIEOFo6u/MxJJdLjFtnNYr07KoO8Dd6VvtxHTL1EghwTXaL+db7eTW85IUcNlTPWLVhS3fP
	PllDlwieZ5hJfJOpU=
X-Google-Smtp-Source: AGHT+IGlmTs8m7q4shBnRaaAsE/Ntj7jFVQ6UYemZLCvrKk7CmzQZgK+t429WLi9WLsw960Agh6WUA==
X-Received: by 2002:a05:600c:45c7:b0:471:1337:7220 with SMTP id 5b1f17b1804b1-475caf9324fmr16345075e9.3.1761217286997;
        Thu, 23 Oct 2025 04:01:26 -0700 (PDT)
Received: from shift.. ([86.124.201.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898adf78sm3596420f8f.32.2025.10.23.04.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:01:26 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: andi.shyti@kernel.org,
	wsa+renesas@sang-engineering.com
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH v1 0/2] Improve usage of 'ret' variable and make pcf_doAdress() void
Date: Thu, 23 Oct 2025 14:01:15 +0300
Message-ID: <20251023110118.7940-1-chiru.cezar.89@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello maintainers,

This patch series is a response to Change Requests made by Andi Shyti on
[PATCH v7 0/3] i2c: pcf8584: Fix errors and warnings reported by checkpatch
and more specific on PATCH: i2c: pcf8584: Move 'ret' variable inside for
loop, break if ret < 0.
Also a comment from Andy Shevchenko about using goto instead of break
since the goto was used in other error path branches so it makes sense
to be consistent.

Patches are dependent on each other that's why the need for a new patch
series.

Change Requests:
 -remove initialization of 'ret' variable inside for loop of pcf_xfer() as
 it is not needed
 -change pcf_doAddress() function type from int to void as it always
 returns 0.

Testing:
 *built kernel and modules with I2C_ALGOPCF=m and my 2 patches applied on
 top of 6.18.0-rc1.
 *installed kernel and external modules generated by build on my laptop
 *rebooted and loaded i2c-algo-pcf.ko without i2c_debug parameter.
 *when loading the .ko with i2c_debug parameter an error is seen in dmesg
 and this is expected as the parameter was removed.
 *No success message related to i2c_algo_pcf was seen in dmesg but also
 no failures.
 *Module loading and unloading successful.
 *No PCF8584 Hardware was available


Cezar Chiru (2):
  i2c: pcf8584: Move 'ret' variable inside for loop, goto out if ret <
    0.
  i2c: pcf8584: Make pcf_doAddress() function void

 drivers/i2c/algos/i2c-algo-pcf.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--
2.43.0


