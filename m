Return-Path: <linux-kernel+bounces-745877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579DAB11FF2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862463A6858
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099952EBB97;
	Fri, 25 Jul 2025 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pBebP9rA"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714101DF72C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452983; cv=none; b=IrrRD9BgQ2xX7f1glAyBRlDQ4SJCEFt5MJH8woTSXQfD8XYRgyFvUJCGYhXEVbQ/oPWb4cfn91wgmf5Zi4NNAbh79v0OmKz/l9HwN8sRK005AsxoRIlhsB1O8XqDxvbaRxIPA52l3rvRqX7xa+Y6Zcsxtlumys/0/u37Zyh84CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452983; c=relaxed/simple;
	bh=8AW0wZtIdMTOecI8zEy7or/xRHq/+HDNB4Msky+fi4A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r/XSR3I/DUkjr0AF1bbovmyEawbx1c+QjGzfev+59dyKqqiGMAyp3Ay/a+uiWOlbD287rf91AlT2qtI41H5mC6etxBn9bUNb1a5L156lTUHa80oHbOGGyOI84bypi/LcISfD353zBqsaL7flgizkte1z9AEKuFfjDEMKbgZDVBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pBebP9rA; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6148e399effso3602479a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753452978; x=1754057778; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0GYrZkLXVXcOZgbWnPr9ONxYHIczwht5gJlvJdmNzQk=;
        b=pBebP9rALtTAJKnpPJpllQiQY9VyHBqULO3QVOWmJ5tHTNwIFaXLluiQHWXyiL6Xy0
         PhL6Ido0qCPelByNCaLUEzqA3kJel/6i8NBKeOVLVA6tfG6fWetUM75BBKojyvH3CemT
         2aD6LpUKdXpATcx9W+fWh9va6Rdfrk+2QKO7HDcLplrwT+N4Eh6Ncv3b6qJyPOeKCoa+
         3aXEpODFl5Y5Vt/SowT0DixTR1wlN/snGgxQ5cIYPuGCXYMlUqdnjTMObT//AVbIJjNa
         ngCDvW/QKYOCyittTgnCCR7/Od/oT4wO9oTXE/PejAjzg7k/7gtTB8rV4kPMUUnkgjoj
         /zEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753452978; x=1754057778;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GYrZkLXVXcOZgbWnPr9ONxYHIczwht5gJlvJdmNzQk=;
        b=NYkVd+K5tEkGDoYN5UhM/9JkFunALA7TdiWoEqdeV6sJn2QAzx15rFhw9mJAUFlCIa
         C4T5KcHMyOEBILZLnmZxwfvAGdBuKjtfysaEtTTIUPisqB248aQWac0/1v+ljALYG6r+
         O/+vVUnCpe9UEv9SPLAH8RzbvmLrTIA8D/at7Zg1UpqeXLE4N4jrPw3WZE2efgRxfdrJ
         RxAKoF/NA/IgBtBz4E7OXB0fqUTuTkfl+sb9ORDmyZ2uGpPa6f/ojuaPq76usFOi/IlP
         L/4VoDqUfObw1EwA69DA2LDOIgkBrohN3OT8uFh43IrtlIoFH15FT6v0nfPtqAn12o0n
         AdEg==
X-Forwarded-Encrypted: i=1; AJvYcCWthnyjG3MKq5vQWTrfJdfwBVmDq9IhmgbJrSE0kqR0pZhLjvClv/cn7XKaqGcm3qWvS3fQMLFqbkEMvu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuYj8G7SrWWBOA5Buku0KXcF54ycv98+eEpIG8vQSS4TEqCq37
	sbmu/Cz85KALklB48nms1rt2a6bk1awMc4YzYW3a1yvu1l25lDHC8V2hSfdz7AecphQ=
X-Gm-Gg: ASbGnct0CdXNkMD/CFzup6m+eofWVWV12mI+vBXJ+Xma61nCEcU0MVDm9wPOL+nlBEE
	nox9pGksDVCKijEWgxn0A2aNeO61gLGYnn3tBeD3rTmVSEgkivKF2wK15qc0jwT5FacETHPL68T
	EGRErM/2BCODHLW5geqqc2qhzfTr5tmb9iV0pYzuPvgxsuHK/0oPRGn9P1eNWvwINBBMPV9wvrx
	FifosXMTfYoVJQM8sHum+O1OtzYMOBBRCCWTz0fB10hCmo2EH5mbgHciAGDgU03npVTEf/kpDQx
	LVClbyXxFjWda+w7cwPo8HoQcmUIqCaMoORhb4xazWsM+nosDEfucVgCHUPqvDUKhZWYJyqaEY0
	T2GDon1C7tq0jxnGpEMnzrvI/wTRqJJ2Ur40PII7qDbdlaZX3NGap3NoIgy4xZdTnR9rDiAVm/7
	qaeZ8UPA==
X-Google-Smtp-Source: AGHT+IESxxtSVuTR7JcpPvCin5sJRXnxskX5QKzVI4SQNZf89ZEV5qKL5Ev6pflyXfFUSgm5m/ZQVA==
X-Received: by 2002:a17:907:7205:b0:ae3:bb4a:91fb with SMTP id a640c23a62f3a-af61ef2e6demr228089066b.59.1753452977655;
        Fri, 25 Jul 2025 07:16:17 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47f85e60bsm278398966b.96.2025.07.25.07.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 07:16:17 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v2 0/2] scsi: ufs: core: interrupt handling optimisations
Date: Fri, 25 Jul 2025 15:16:14 +0100
Message-Id: <20250725-ufshcd-hardirq-v2-0-884c11e0b0df@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAK6Rg2gC/13MQQrCMBCF4auUWRtpJ01aXXkP6SI0STMgjZ1oU
 Ervbiy4cfk/eN8KyTG5BOdqBXaZEsW5BB4qGIOZJyfIlgasUdUdSvH0KYxWBMOWeBFjJ1F73aJ
 TGsrpzs7TawevQ+lA6RH5vfu5+a4/qv2nciMaoeWpNwp972u83Gg2HI+RJxi2bfsAJzI6Da0AA
 AA=
X-Change-ID: 20250723-ufshcd-hardirq-c7326f642e56
To: Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, kernel-team@android.com, 
 linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

UFS performance for < v4 controllers has reduced quite a bit in 6.16.
This series addresses this regression and brings numbers more or less
back to the previous level.

See patch 2 for some benchmark (fio) results.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v2:
- patch 1: new patch as suggested by Bart during v1 review
- patch 2: update commit message and some inline & kerneldoc comments
- patch 2: add missing jiffies.h include
- Link to v1: https://lore.kernel.org/r/20250724-ufshcd-hardirq-v1-1-6398a52f8f02@linaro.org

---
André Draszik (2):
      scsi: ufs: core: complete polled requests also from interrupt context
      scsi: ufs: core: move some irq handling back to hardirq (with time limit)

 drivers/ufs/core/ufshcd.c | 211 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 152 insertions(+), 59 deletions(-)
---
base-commit: 58ba80c4740212c29a1cf9b48f588e60a7612209
change-id: 20250723-ufshcd-hardirq-c7326f642e56

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


