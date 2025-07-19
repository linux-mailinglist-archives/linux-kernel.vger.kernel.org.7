Return-Path: <linux-kernel+bounces-737909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D995CB0B1D9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 22:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD9016F07A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 20:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F367322126C;
	Sat, 19 Jul 2025 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SR+tKySb"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D479476
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752958447; cv=none; b=uaYJSusLz0zjCCinzW+ti2g3lK7GRFe1m1THjYsQFAxptn0cCMn1CIXbtyN8kArlpmZIn1pAZkYPCgrkaKbk3/kvKfWopARryEuFlTxEjnImI0SM2KS4aUbBgSIGkfRxu+bXliLm2xn8l84lJrrNf4PXQyAUhSc02/1seDGowRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752958447; c=relaxed/simple;
	bh=vFKvQ702qHzejrHkKVXlDyqYDf6HiC1dNcaD+w/ij3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kA8eEqCuX6vEf7Wma7XL/VdNsMsvTHLAvhVciCOBnkxDNwSmCRMbICVn6SDJcsaQHdCUS0MdbCazwzY4DlDjTkGgv9klOGzEJO9amuvQTj0XKH+H6PupPr90DoR8irp0bvTvgo3FWTckfBACUwn7RIyXd/QPry90qOJmptNxT5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SR+tKySb; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b34a71d9208so2129146a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 13:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752958445; x=1753563245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ajt8uuh4Ladoyho13MFUz95+tuibvtrv/Wqpn8JgZA=;
        b=SR+tKySb47IGYp1D9/E8a0fPaQ5PCzhr5nBNNKFMWeuDVffoSMv2rx638zL7Ct+0P6
         uvMoEYe5K/zpYax7zq1u41vyNm4Bt2i6+FDtCWlXmPLDQOqBFjj163UvA9q3GqeR7FO9
         8HjUycmaoo72UlFX9Rxkmq0Cdl5iT9BCeXhmMLQqZmPXU3hehrJI3lzTYcjHTas0TSNz
         0Iga/4Lxgaf10cV1oEdvVLEDbaVgRMUu3AQv+g5kB8JQEudIAgk2OXS5QhnUUHHz0mGt
         X4uQmbuCOIJeSYf1o5LuY/gTYxKlLKowHxhCncovkiB9Rmvgi2pOD3Bq+TG2PT2KzEyD
         AVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752958445; x=1753563245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ajt8uuh4Ladoyho13MFUz95+tuibvtrv/Wqpn8JgZA=;
        b=AT3u+l+hZ1eAKzZEQSllLD+g0FZJx0iLD4V7aaFk/AXO2CK8F1w6mYCvWNGbrG5qhH
         LA4jJYdkRGn0pD95eBWkS+JNWOkNSHTt5ESoDkIfHElrrn3dTGkxcWSQbxEDA4ToI4XI
         UKmaA/ZZ3O80anROwCJzxwcygiKIW7S/aTB6x7QiILkK5kfiou5kKZrQarXuH4gCp1pw
         2ovQAgI0aOH6luKuOzyQpkkrCI1/y7hTFihqISynjo5UeHo/6z17oFhUjDcd1kq2mppP
         t+2RqMFpVxlwxVCXwW1IqU5H0C9zCKgq9wQaWNp/8ID03f/g65fufKJdNAIdG7++b6xy
         580w==
X-Forwarded-Encrypted: i=1; AJvYcCUXgmwVjukMTO4dhPYqqNTAXT6Zkw6Qzn4XiFuM72w/KPxjkjZXxE6DVRyxL7skArR5Gi+Po1oP0fATMzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQBsOQyrzYamYltMlvWGr4kpu1ALasevLu/8+oN5HfFR0h+5Us
	cV5DVM+8Xp8sdMuRVdJPUgoiFDu1lAoYue0NBGffFu3NjY53ZoUQO9XK
X-Gm-Gg: ASbGncug8Ds4tAJP7jpi/BlPKrGdjTBvocURMLTr+1khmtxp0t0i0696RkKpGN1UPZo
	0h0ucZ+NCMYb05P6W0C9/2IoRnPvcA/oZ9APu1HJe9kK9yMwVh2aHplf8vIamz3rmfayswe3qUA
	7kM3zRJVDxcHwT2kHUhrSXKZdnja46Cvdpde7ryle5wamL0Bi9scpBIzbaJgW8/uHbGw51K/PGm
	eGtN4blZtB4qUmeBm8/5ftP0dzlmofb3Mx5fnpxr5Dir/0H9iPYOR0Xz0GKPA0E3/IkGeIh4+9+
	zpzmsqCe7q/uzcAvX5y6Iy1Th1Zvo4gqtzgpaXoEFAf9erFPHInFkOo1hy+32i+TOMao7Iuo0ow
	wteiHIccsGtBQa6FCqhz/OQ==
X-Google-Smtp-Source: AGHT+IGMQy2yiHGsmGSGdWX8FRslVSX9AZPl07svsPz4HXePC2us2jiQ6Y83EYeGAS6InAFPkWC4ow==
X-Received: by 2002:a17:903:1a45:b0:234:c2e7:a102 with SMTP id d9443c01a7336-23e2576c1bfmr208453375ad.43.1752958445277;
        Sat, 19 Jul 2025 13:54:05 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3f162f8sm3444662a91.28.2025.07.19.13.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 13:54:04 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 0/2] mm/cma: ise for_each_clear_bitrange() where appropriate
Date: Sat, 19 Jul 2025 16:53:58 -0400
Message-ID: <20250719205401.399475-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Hi Andrew,

Pleas pull a couple of simplifications for mm/cma.

Thanks,
Yury

Yury Norov (NVIDIA) (2):
  mm: cma: simplify cma_debug_show_areas()
  mm: cma: simplify cma_maxchunk_get()

 mm/cma.c       | 19 ++++---------------
 mm/cma_debug.c | 10 +---------
 2 files changed, 5 insertions(+), 24 deletions(-)

-- 
2.43.0


