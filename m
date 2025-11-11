Return-Path: <linux-kernel+bounces-895033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312E7C4CC4F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D844209A7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07412F25E3;
	Tue, 11 Nov 2025 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuZSFiY5"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841CD21C9E5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854335; cv=none; b=IzxZtCaEBYDc7CGNL7hp9siOghEEfR4g50xOkDcSEj6vZf6chh0cQUT7G3lg74NlCSx4e9XR/CWYrWvyo+jxCZ+I2zA+37k4C89TSjQ8KOqVrMTQ+1+4AwV30yz92lJ2mmGxq7fZ4B4isvA8Z0U44rTcaTQX4aFUVNciR4ybNqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854335; c=relaxed/simple;
	bh=DgA+YQZ2PXtKWbfJH1XR71F2ykLEULNrwbgH40vjVnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhnMStXJ5A76/AaCgA6DlzomSCAb0mrEDT671SMH459XVV/xh/kgQD6C1ukc8kBgAfQsZzzjl8zKIxxD8HB2uBvVm+5faUy4X/ovh78bYIfrhq8nD+KFZ5ACcbqmiFJmAYcUh4Urdk1pkIiioNQfKGAVLrEZgu66C+A55ClVkZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuZSFiY5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477632b0621so27156355e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762854332; x=1763459132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Q6cLMd5HkJMSjJpe28rjQcWfQMB7GUBaFpYg6qXkBE=;
        b=iuZSFiY5Fbtqd6cktbgOQ3BZW4LRG4ijD6JKnCXY9Nk8Mcid0y9muglgw5LsKKdJ4Y
         QxCyXQ43n5ny9irTTuSFuih1JdjDVm/4W7zePwZxktXlFk3Ytz2ZImVczLf5qydvxbxA
         SmkOw8BkqSKLtqfyJV/g6yP29rClzsNOkIURah8jUK4RkGqU0Te8hk/fAxA2CfggJqJx
         r2fzeZWBSTrf56Ww+q9mh/bHP9e5JiMSC6rIQPIK9VTJADXpXcsP+lbYSSxABKZgkra6
         A0Ap2XrPPao7iG0maKNs9M+FeBvr5uMLp8dB3eNKqphOd0mkaosXyBCOWoeFCMfhaen9
         Q3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762854332; x=1763459132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Q6cLMd5HkJMSjJpe28rjQcWfQMB7GUBaFpYg6qXkBE=;
        b=ja9qCMXlYqBChzt1Kev76on2wKebSZXSGydQsr45+10zCIsf508/bQz1RnBbYZNFjU
         bpg53XJ58LLlAijd21+0YkLB7VG2qeFI1DDrWztJSRDvRTbc+cw13rQhNEMSGimO8GZc
         alAEuOFKNuDtr6VaTKPqNl+yr+hGW891w1PUGm2k+UMkggIOe27tVoUDwnvzja7BuR/z
         XqcZX0RM6xT53dGHzbG0Xt/vn8DYfVXXv6Q51go+REn2iHJ9TGhomhVzzpx1C1+X22VV
         W1bAMhbZb7cT5VrO9hqVZug8D6vG+fM4uhvfwgs6eizz2lqoldtcBHJtUxgvKNQGO8wQ
         d43Q==
X-Forwarded-Encrypted: i=1; AJvYcCVK52GUfu1WbCZRuF1RniMbCy6kd7Siw1xyUjvg6vj1MFnPSbbF8vvyaiK3MxjMDu4Kap0kKFJq+GZRiAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHopO+AxkrwRZ5n30NkarBPH6mlPJ2g1sKog/sy6LbQg++lblC
	0ruzkKcMiluwFTPQqWzLeeAbxIjehEwbFDz3N7Wqa5KGli1rfiMrg1T1
X-Gm-Gg: ASbGnctHRK8VOJlQSaAOYJ/YP0MsDMEdmkN3QPIgdNyE12abrvAQkYd1k8otb9w3vXn
	pTljYg2QDcLJUKes8/Ei5YMv8h0ZGtqaXk+JF0PN+sRdYuo/w37QKzhbl6TtUg3D+980qpgc83o
	1a1F02XcR489V/KqdKwG1d0Sp/q8MZT4frKTWhtxLu/FayRHZ2nobLzUcIIs/qFEj1uwnmANsE3
	UJcFehdxg9KAtwyby63Ck+HhVEAKWW3/z2p8rn3FmGHonq/9vAkW46isTb1PntkqBrajpayChKB
	K5Wy90QU1PsR+6C7Y6ehqY3do1w2ODNgFoPWVaJhOOC4bUnopq1auuacpK8f6OLiDYpf9JZ7ALy
	SzodRN+SCXscgs2b3EwqLY+oljHxRJeXK+feBN5hGeDn8SPuZGmX8NSpgSYdxKylhHotNyOntKW
	MrIS0k3TnkRrJh6/iUr9tXiIbD9w0gtGNEtbZszQ==
X-Google-Smtp-Source: AGHT+IFfazzHe5CL6AcUJ7owIgI9DCqe9HNl/2w37vTq4ZGQz48QlaaAWva5IFao6kLS9S+USHkJWQ==
X-Received: by 2002:a05:600c:c4ab:b0:46f:b42e:e3a0 with SMTP id 5b1f17b1804b1-47773298039mr89418525e9.41.1762854331642;
        Tue, 11 Nov 2025 01:45:31 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cd45466sm359537865e9.0.2025.11.11.01.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:45:31 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: johan@kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH V2 02/10] staging: gpib: Remove gpib/uapi from search path
Date: Tue, 11 Nov 2025 10:45:04 +0100
Message-ID: <20251111094512.6411-3-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111094512.6411-1-dpenkler@gmail.com>
References: <20251111094512.6411-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The gpib/uapi header files are being moved to include/uapi/linux
as part of the gpib destaging process. The latter directory is
automatically searched when building the drivers.

Remove gpib/uapi from the header file search path in subdir-ccflags

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/Makefile b/drivers/staging/gpib/Makefile
index d0e88f5c0844..2d44fed2a743 100644
--- a/drivers/staging/gpib/Makefile
+++ b/drivers/staging/gpib/Makefile
@@ -1,5 +1,5 @@
 
-subdir-ccflags-y += -I$(src)/include -I$(src)/uapi
+subdir-ccflags-y += -I$(src)/include
 
 obj-$(CONFIG_GPIB_AGILENT_82350B) += agilent_82350b/
 obj-$(CONFIG_GPIB_AGILENT_82357A) += agilent_82357a/
-- 
2.51.2


