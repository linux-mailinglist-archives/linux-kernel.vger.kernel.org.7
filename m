Return-Path: <linux-kernel+bounces-862760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A96BF616F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5962B18C602A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1999932E6A8;
	Tue, 21 Oct 2025 11:37:41 +0000 (UTC)
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2172C0F7D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046660; cv=none; b=opvt0t5XdX51yGFYVDnUM+/F7iKWO8HXgOhaKDE1f3b7akIhBuoaLR5dyYxv4uNUK9RtOwEhlEsaMONvtHc0YNVo8SI1+3tHtGxVm/CsMveXl3SjFyYiDWSDNFz46Dj/yxI6t53f3Q6ILHaO+hKk3mhcu47iG9fOSvf9/BfFxmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046660; c=relaxed/simple;
	bh=Ijgb6iMq/DZ+DUhiylBadDDJTGa9uu0g2H5s/TyLZFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QowhTVXobt3Dhhd9WCH34hfhsD2FkG8wvm8WmEailSzQGacz5lw+XJWVocOKgY6z66/VX3WQI9EkxAiJPCv9SJvy7RPvAYFVuyk32c1hfD9llXHL6o2DWP3grV8e5DL+dcbw6afysBSxt3gNGWiUPcO8NxeSJh7tbYixMJSljic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-77f343231fcso3714069b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 04:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761046658; x=1761651458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CzDoe8AqtxQPez8ItP/+HDboB9VhrpktF3X/hsuGf0A=;
        b=hrwXZioh0q40RAHqfE0uSaxFA4kDve5CGrRyIJRWWDaluN42zeg07ehhcB0KSrXpRu
         1UxLYmhQvQMcyj3vAF7pSPdTLEHvdLXF9YAFoyVdM5lzK4YtfrDrQA4NagVfwyM7aBDN
         0k4ExO7RSTZ6XYLcq16171Tl7nxeB6dRhLUwZrndoYnBT+q4R6IGHisEaCI4P6aFnzJP
         DkdsBO8vpXTE0WANqHwxpI6KIq9wiH2/0ENKEBGMk4wI7q/hbFh4BrFFrToNZSkImoNl
         4YLncMconJxQNH08adui+uR++rJD2f+FZ1/159j68VRf7KBBaxKnW5Qrl9G0Yh4kGTS8
         y3IQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0EO31ygKWKNit/7nWlmqeHPuydtofv9VlcgPTt38Vd7EJF9Xpgj2knzyAsDcGQ2ke14psfY26LKgo/rU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDtv1SqREmy1lkVagdl3UDC5hRAXsuuC6DJLLUZysZhGS6+4il
	mGqYT5WIlz6m/fi9vwTWqkB0PJ4IpmGmG5xcS9KTBR91ECcCIQ0mC2qy
X-Gm-Gg: ASbGncsPHFyMiLjdJMwP6rgWV68Yx7dTpKGNXO3RN68ESNFXa6p30oTRJywfxl9KEKl
	fT+igZxzA8myuAeFSNcauav+xND9FviL/SFFSzF6Nn9O2jYXdPGLAQh70Njc4Bf2+h5VegGUD3W
	shwvM2nxtDSP3ME6iQO493xz/bD7CtZCpD2r1dGD5DyTQ7pufvd6vT5luWpacUPao4CU4ht57uC
	dSJ6mmNeUsWnEFQAKSc4iPd9FudKi44idOe1lFOaYhx1pQS2ywWLeaf60diwZiiZgKE3PL+XQbc
	BGLX2xm7QuR5DogVXXil9zbqqJPMBWEwvd0341zVj10ESKOiAWkKkAsFinFsp+xheNFHBFDne23
	HHRg+lkRF6oFi13u00nfznwLe/Q8y98yMQZjk/JBkcZnMZz8+exyJUryBqGiefPlqJcFtYuyhxM
	JD6wqsECsj5cXQha1JzcISU3w=
X-Google-Smtp-Source: AGHT+IFGSR+9yVfw+btCGauwEkmAa+SrLHe/0GkwK6TCZ+ywFx7tlUppzWqtd2QyHRtgHWrC3Efn2Q==
X-Received: by 2002:a17:903:46c7:b0:27c:56af:88ea with SMTP id d9443c01a7336-290cba50c27mr179773045ad.60.1761046658207;
        Tue, 21 Oct 2025 04:37:38 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5874sm107138825ad.54.2025.10.21.04.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 04:37:37 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v5 0/3] PM: hibernate: make compression threads configurable and support dynamic crc arrays 
Date: Tue, 21 Oct 2025 19:37:25 +0800
Message-ID: <cover.1761046167.git.luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is v5 of the series to make hibernate compression/decompression
threads configurable and improve scalability.

Following feedback from previous versions:

- Patch 2 (`PM: hibernate: make compression threads configurable`) has been updated
  to rename the GRUB/kernel command line parameter from `cmp_threads` to
  `hibernate_compression_threads`, making its purpose clearer and more
  self-explanatory.

- Patch 3 (`PM: hibernate: add sysfs interface for hibernate_compression_threads`)
  has been added to provide a runtime interface under
  `/sys/power/hibernate_compression_threads`. This allows users and
  system integrators to tune the number of compression/decompression
  threads dynamically without rebooting the system.

- Corresponding documentation updates have been added:
  - `Documentation/admin-guide/kernel-parameters.txt` now documents
    `hibernate_compression_threads=` GRUB parameter.
  - `Documentation/ABI/testing/sysfs-power` describes the new sysfs interface.

This series ensures that both boot-time and runtime configuration of
hibernate compression threads are supported, improving flexibility
and scalability on multi-core systems.

Xueqin Luo (3):
  PM: hibernate: dynamically allocate crc->unc_len/unc for configurable
    threads
  PM: hibernate: make compression threads configurable
  PM: hibernate: add sysfs interface for hibernate_compression_threads

 Documentation/ABI/testing/sysfs-power         |  16 +++
 .../admin-guide/kernel-parameters.txt         |  10 ++
 kernel/power/swap.c                           | 121 +++++++++++++++---
 3 files changed, 129 insertions(+), 18 deletions(-)

-- 
2.43.0


