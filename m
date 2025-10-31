Return-Path: <linux-kernel+bounces-880924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 364F6C26E14
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D5B54E64DE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E970A328620;
	Fri, 31 Oct 2025 20:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTX52QtH"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF4F218AAF
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761941938; cv=none; b=apwO/tr07BC9NsI3Us2O+UubUJSzgALHJlFpkE+nZ8a5BQ1LHxmFwoiUWpV1f+nnZhUb0jTUnuNd18SBR21yRukUgw53QBb52WkyiH05uC+By7y/8a/477I5cun4yILJv75HEwmJMy9HRN+4Mmm6qh5YIik0cdAZrlzV9MxQVeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761941938; c=relaxed/simple;
	bh=EEcao/OdWrXIjMLda+Iv+NRypafBtS9SOmFKm62yuaY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q7EX/gCWZBwLSoL1LQ3CdqVtkyNoqkJ45AnCwQ/tG1pf4fsiz2t1zkKvuvu9yfH4PYnbqyKSMff4/IDBB2QITTWbznMFEk4nQsxSQx5m+HuwKenA8rFmVh5CPsVlfLqqYSwqkTR1QWwiHNoMsoBHcr7OMWRNcdp9/Iap1rj8or8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTX52QtH; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429c2f6a580so776122f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761941935; x=1762546735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6dGKudV1APcuHRNBlFTcVX5gOCMz3Arr3oxQu93hExk=;
        b=WTX52QtHqvC+R7r+2gFjP9F+J7bkiHZn7uign0QQUtw0cocX+/3JDSQcDeUnJSQMGU
         CTc6L1xUon+m3O4kLop27HPoLwW5PJvb5C6kqdFiBCbqFNM5uGvoXbxEGwVASt+OMLGP
         RlPdmcPhmSSEcvdc1WJEybMLJr2G4nRNtHigTCEagyC0Hj3iv98gxyeqSbxwphcCqeVJ
         lGLBX1ziHZuCxe6027qRNynXaxkxtdvHqK8T/WKqclEQeW/GCX9tdbMxNhmFhxl+hyiC
         SSj4XLR00dOwRHhsybGS+2zxbsQMPVYBwB/ukMQ+25IpssSKn37rwg/7+YAChQVi5Izu
         AmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761941935; x=1762546735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6dGKudV1APcuHRNBlFTcVX5gOCMz3Arr3oxQu93hExk=;
        b=QC3HUb/r9Z02t52I8r3E4akD3Xa4kqTe8QpcQY2+yKByqZ2rvIn/JA0cBy8JCpwo5H
         rn6vGdlVq9JYso9mj8lnsRrfjTGogj2k3wSZz0T6/TuxqyB2ecTVPgLfPYRwjMuSB22p
         OHvYF92Y0NsTjPXIKlZWBLeqPL4i5OvfMAtMmrNBqRl/aNIajUG9lQAcE9oj/CFKdu0Y
         9eY8spYFrr30GVDfMRIYUARNu7AwzP4v1PlyyjcPb5fjAHXV0UFfk8ZdRuzUGMbt9Sdi
         uiWsMHLHu6Rx8PSvcuZ59/r6LTu8RbcCuSEeJl++4RzhWaem1DzOi5g5wEk03bqVsCK4
         Wjog==
X-Forwarded-Encrypted: i=1; AJvYcCXpi1cGLnF3rqFG9Te+rjsl4iOun9QRnI6iD8S5KgBlJCQSh+6fLh93V1+5fACTQTQ1z5tr4sLiG3kX1+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIB4wWoSyOthmTpbs1wA9Ngy00EI30bJ3hK38+DDKxScxNvq4W
	7/XxpvWq9lfxPjfi/fXVKxPlMM+03cyCq10i4k0ebyhGuuzIPyMhz8fN
X-Gm-Gg: ASbGncvwnIwOhxJcyTOiCW9QkEPOkBbHLgssqniAiNE3rnJFhQc/0Yzo1SX8QOAf6ap
	RELsmJYGdTMQ4P6K+sxtWdq9RQGbeJZD8jbjMNVT2cWXQ4FDbpDVdr/NoRhaC5pXvMKPN3/7Hdp
	Zyy8yYYbrGh2a7pJubh5f+7HifZrL7nzpL5z18upKtQx8id18EfyTVqNfyYSW0asi4+qDBfawJs
	+jMPgCh088hlR2wZEoCfFnEsvJ/vAxddNUnrcZvYgUgGbks89hVtaUuYiuqYDwAKBE6m+f2j+yl
	SU0cckgT+CqLaRP63wMUHcg2kIVB10wjw9HxC3Y3ckGj4eFwRkyqY2kWTaSIak3ICMIhba3DlJj
	ncS3oJeStGQXJhw9s4QCcv8QcKYmFW12Hoa6Rg01Pq7pbyHWhUwhcJtrBt4o1yCOsKpMWupJ89t
	hI2q+mOZSFs+PYZkoLdoL2BFzH35FExb95Y0Dp
X-Google-Smtp-Source: AGHT+IE4FKu0ijCN9tQ6rhN9cFZ0bcy6DAWWQE3HV+Zsvla1klttTnrxaVDbk/QOoKKwRhgxcG6EWQ==
X-Received: by 2002:a5d:5d89:0:b0:429:8a71:d57 with SMTP id ffacd0b85a97d-429bd688474mr4422224f8f.27.1761941934577;
        Fri, 31 Oct 2025 13:18:54 -0700 (PDT)
Received: from localhost.localdomain ([78.212.20.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c54efcbasm1800360f8f.8.2025.10.31.13.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 13:18:54 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 0/2] iio: mpl3115: support for events
Date: Fri, 31 Oct 2025 21:18:20 +0100
Message-Id: <20251031201821.88374-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
The mpl3115 device can raise interrupts when a pressure or temperature
threshold is crossed, this patchset adds support for them using IIO's
events interface.

The two previous patches were squashed, I also
added a small patch documenting the new pressure-event attributes.

Kind regards,
Antoni Pokusinski

---
Changes since v1:
(general)
* squashed the cleanup patch
* added the patch with the documentation update
(patch 1/2 "add threshold event support")
* patch description: explained changes in locking
* read_event_config: replaced switch with ifs
* read_event_config: return as early as possible, got rid of int_en_mask
* read/write_thresh: pressure: calculation changes to comply with raw ABI
* interrupt_handler: reordered the INT_SRC_* bits in if condition
* read/write_thresh: used sizeof() and values from limits.h
* write_thresh: replaced `u8 tmp[2]` with `__be16 tmp`
* dropped the space between casting `(u8 *) &tmp`


Antoni Pokusinski (2):
  iio: mpl3115: add threshold events support
  iio: ABI: document pressure event attributes

 Documentation/ABI/testing/sysfs-bus-iio |   2 +
 drivers/iio/pressure/mpl3115.c          | 219 ++++++++++++++++++++++--
 2 files changed, 211 insertions(+), 10 deletions(-)


base-commit: 1d09cf18cc91d29f650ad9811ed4868d9304d6c7
-- 
2.25.1


