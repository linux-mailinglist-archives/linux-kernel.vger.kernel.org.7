Return-Path: <linux-kernel+bounces-891050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D712BC41B4F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 22:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01023B46A9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 21:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A59C343D75;
	Fri,  7 Nov 2025 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="PHmV1+0H"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06643101C9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549559; cv=none; b=GkMM0H8SjaZVtYQCA3tQedao3INYgkiThxK1euFedlx11MPTR+ycFcLaDhUgbarhsN3HSmB2OTg/0L0m8UusiWW5Y1XnmW7w+3pFjIxutoOnzP/YufKU2SVSaobM/D1AXFRoKAzA0/bPkE+X6Zv9j2TUzwgz2f0HJOGg3e+CkoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549559; c=relaxed/simple;
	bh=EhnYH4OG1yQcNdExdTlX8DtkF4c1hxEUjRTi3VHc5ZE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLIBNIcox4ldU6aUiLuCA1GfnRxPhLUXXbdtFYH8CSpeB7910Pjxbm3dodqLi9l4Km/yapPGBkUIRXuC4sAQuo0c+iSrXFBHkaRcGoWZPMa2LBEYj2Iiq5/OSzzBtTIyVhnlA0JIX6iWVpiRSUs1EKYDp05gU2hoeHDkDagVz0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=PHmV1+0H; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-787cc9de986so8596977b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 13:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762549555; x=1763154355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFdqd9exB0x0hPzLUkgD+8tlEyMvj6WmHDEVMBDy3B0=;
        b=PHmV1+0HTM4I2RRR9QcPLEkj+0X2mOIPFW/c/iVOIQ+G6lMV+NVL/RE7ppGcfIxdhW
         0U2jtlN5hjXIMoLjs9CR/aL6Qm7CtCEAOu1+ePqGvVA9m10YXnJ6rLK9gk/wqI9tLPwd
         nvoQsfv2n0I328Ox6vxQ665eJ1aVcMhdC+4Ui33ojb0dtauuJ+lg2sL6oLulnE1s6FQi
         xK+dsyDjzxu8D+irAcaw+oX7xa5M0NzXzQ/ZWqFxQ0Hm9P+3NCCwlTtmgvsxfYoYefqF
         PUwoxvORZLZcZM0CpAomnD8/VOQViGHv3LutaAjgIep/8BOrk7no4IInRZMBmqYBqC8C
         aNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762549555; x=1763154355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sFdqd9exB0x0hPzLUkgD+8tlEyMvj6WmHDEVMBDy3B0=;
        b=MC9/JUwx5HPyrT0kF9gcKyEiW4EHplGHkVYE84w75nPx18ZlM/8XkutOeENR3SfbZo
         tyi79eo/pwamYXnnZaoHKCwcWKgzjcckujQIMxBsoSzUrpxuIYXEpT/B2bYOTvTizN1m
         rmgpSWKYS0cIKpiOeOVWx6afHlNkTO/ivkYRg7tCc1SILDfxz6nFPn1QLOe5EqSKHRKN
         juqe8FRIcelJwwuGSR/oyAjvkbLDcMwv5OAYpJzb3LDJH0wGCB0Oh7oVXw4gIQqeEaQh
         aqK0nydlwsXlJXg+a85WFIkfOI+Zrk11q1RVmO/7Rm4f1o8AsMfvr6dIi5Lm4J/hJNpr
         6bOg==
X-Forwarded-Encrypted: i=1; AJvYcCUFiaXOhHJrJLbrAhgO4bavXQk2txY/N+3a3aOmzZDHzHUG4PLN17ljW+HMROQ2xOfW0yUm6S7dp3K92pk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx1pfKv/doD8aagdFFLLLYq/6JbCTrhadw186Z4h1yYekSh+AU
	ez6j/yPn4V7ASUW8krguH1YwmkPPdXTxZbhtz3w0zrgVY7WDkSBwKSTToZQmKjLOaPU=
X-Gm-Gg: ASbGncvauEdPaenmTjmNYylok4yeThyhV7piazU3SrUXwFRdMAVAEyGr9+jmHoqEXYa
	7yuGY9T1KuqjRvXh0irAAlbxPiOMMjhijFWZAem2xkR+DUGjkIGwX3akM0aiTNfWowei9RMy4mY
	rGTry2dXyxPDnECPGfGB9zZf6jM0Of4ZCyBRVtYgzKuP+hy3sJLZI8AYF2KR3rbq5klJ2XtpqJE
	+mGilL3K0gIUiLz+mqDfKzmbItiPqK4xgKvPEbu5QW0k/J0/1gUkW/JUwbgKOahKl64by/rHuwa
	Raq7eb1yVbENrTjh+8hi6CJrR7W8sfbl7IHocqXPmFiiPD+mltyypbAQqMcDR2Co4L3ODJn1r6M
	KjOpIeb5CANN/A24f2PsxqPzdh/p21c48aLDH6P9hGN9AKzRPCboUWxWAbIV25FhrbFmORO8szt
	59xAqlluQSJHLesluWzvHZYNuvD5Dloc1Cu8brumqa114QvID1L7fsu70SDyO6buCLAy9qDFL7f
	Q==
X-Google-Smtp-Source: AGHT+IF010PbDrS6Jp4mBjzKbhPzLzB8jkjc+eSVHmds1J2sDdVJ/oNxdwOHlro9GSCJe4RgFsfJuA==
X-Received: by 2002:a05:690c:c004:b0:786:4860:2226 with SMTP id 00721157ae682-787d5400978mr6003887b3.32.1762549555336;
        Fri, 07 Nov 2025 13:05:55 -0800 (PST)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d68754d3sm990817b3.26.2025.11.07.13.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:05:54 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org
Subject: [PATCH v5 12/22] MAINTAINERS: add liveupdate entry
Date: Fri,  7 Nov 2025 16:03:10 -0500
Message-ID: <20251107210526.257742-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251107210526.257742-1-pasha.tatashin@soleen.com>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a MAINTAINERS file entry for the new Live Update Orchestrator
introduced in previous patches.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 58c7e3f678d8..11b546168fb1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14512,6 +14512,17 @@ F:	samples/livepatch/
 F:	scripts/livepatch/
 F:	tools/testing/selftests/livepatch/
 
+LIVE UPDATE
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/core-api/liveupdate.rst
+F:	Documentation/userspace-api/liveupdate.rst
+F:	include/linux/liveupdate.h
+F:	include/linux/liveupdate/
+F:	include/uapi/linux/liveupdate.h
+F:	kernel/liveupdate/
+
 LLC (802.2)
 L:	netdev@vger.kernel.org
 S:	Odd fixes
-- 
2.51.2.1041.gc1ab5b90ca-goog


