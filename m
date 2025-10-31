Return-Path: <linux-kernel+bounces-880243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02D2C25306
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317C73BBBD8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1E234B189;
	Fri, 31 Oct 2025 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMahgjMA"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9EF343D72
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916127; cv=none; b=NiNfBirRTzJRuwLiEZSWNXY03vvaAJg+jCHKHbYlc1FRzj0FThrvhbI8EqU2/8dLIrszW9SUYGd6PnnbtYS3doHbhkbyseitMUGEzo18jUFtJVSi9GG8GY41tSeATA3JY0xll13thlO8PLs3Wc0Tp3I/16kEcdggyy32gqEVgo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916127; c=relaxed/simple;
	bh=VKF4CjxT3D21EN3VSlqJfkySRW64w1cVy7ISImqnQBU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OzG62bNsjC6/7OsgWOR/jHSVgmpcG9nedRs4AjYs7VRrhu0QYh4TIIEfN/YRhe+OSTpgj9st4Dcu9/kipv1LZR2T/UgNgSRa1m+w87DHdwZixI3czZ9Ru7CLNPGzC+pZKUoHn+z0TQwvpSxKv2EO1kDrAvwWzgSFFDUQdv3z8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMahgjMA; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429b7ba208eso1254867f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761916124; x=1762520924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OPUu5NpdCJ07IrysgoLFXtCrzD3ygpbZMzDguuvidnA=;
        b=BMahgjMAuroEMeLCcHA5eXhCB26spjmGosG9khKhQiOElaSD4eNT8qeC8Wb0XzHSfs
         E/14p3NKM4F2vL64dPh2QLFCFVztqrPGV+uXKIlP1IugBl4Dkoj0DyKXRcaL/1NXOdBa
         4h+YJNj85BnzrrZ+mb0uw7PaqSRb0qusqWuvYgtaZvmjqkawjPTDlZex417sSXww5gxf
         CKKfJFHPP3UyekqqOH1fMz2XdHIqCPFIeFLUdQAvolYwvlu4tPebmnl9KcwvDj6cv96E
         DVEl2m6z7qYiRBq0ZAXVUb8+rJ3Omu+ik17lIDU4LQvJQpgiTt/b5cIe4JZG6/DpND+d
         Kpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761916124; x=1762520924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPUu5NpdCJ07IrysgoLFXtCrzD3ygpbZMzDguuvidnA=;
        b=TlA5QSzEj8obhNlaJHr3gKp0QCIXL2Wc3dsemODvrNuedv7h7g/JDHhdmOarDhCfS5
         /5zJyI6NoN95puvK3swuuZcVE2UgM0WdEJH/L2R+m81X3cDCdIaARyE/2/hV+c0/jYUq
         rcdB88v6i3AtYGLywdbVimAgS+jBTzwXkOzWrFz4eXncLrP0hNdlSFtaYF9V1HlRGRdv
         Xs9mxc0Y7IVCROe9mm/dhZ5BgVJj9kQEtP/MFcr/rbYl3royP2RLgfe3EQ+WKv7/hoCf
         C5KEykDlLWetQMBnl+GJ03eksV9FehSFa6OVIDVyufd1QhJXnErmcoCTFT7qnkvpaIQx
         t1Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXm8JTAAaYPqur1IQKaEJL9LO2lsOCWXzkDiF0Fo8C5MnHslar7hrGDtx3h6oki6ixvdYZeJW2jUF2Ht7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9sWoG0zfpkr001SkEv5oBMzqW3Bjje1kfmw7zbCFzjA/FBQK+
	FdemX6UuBybkZIZ5/du6IVojMbDdkD+W777R5EKwEZVv2KSHr0IiHdgd
X-Gm-Gg: ASbGncvMrsXN0lYCgKbRdrMB20b6/QwNfpMOGIaNs+fvZyBniho8Ie9YViF4kotMP1E
	UosdjfoqUr1efObWqKBTh7LLkHmJoKZ7fJ+F9jSGiyUJXZ0PME+NdT9HdKGoaztQlGefjRngqTf
	1uj5EcQB5YJ/MnDknyaIyaKNAyH1tAizxSzma0unAvzXn4kiRUpHl6QUMkSui3K7xNMGMmVurti
	nEwz4ZMLbp2soqvwchzioNiMfbM0hOzH3MuNBoq2kPicRbxiFR4BPPE9zks/UEiuuSryOvkTTxB
	5EwV2KYnkvC0RQ8KitIXXCsr44qKNpFDPseGh9j8h2m55WSxRPuAXqr9sEWLBc8fEvHyg8Cb/tZ
	r45QuWyJfcU0OaH0z/kh+P4FhpbkCi4IkZe/fuTSFLreiMsI13KupLODC5pZYlFT+ql31LRYlk7
	5FyD8ylUZN0gqrT3YyMEDmid/tVFEkwQ==
X-Google-Smtp-Source: AGHT+IGkGev1IicHjK1ZUoYz2sTIloWKiWF3+MyirZCbZtLOurgaln1xWR/FBmE2aNtFKjbB1J9+jA==
X-Received: by 2002:a5d:5d0d:0:b0:3f2:1cd:3d00 with SMTP id ffacd0b85a97d-429bd5f50f4mr2736107f8f.0.1761916124018;
        Fri, 31 Oct 2025 06:08:44 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-477289adc18sm98339815e9.6.2025.10.31.06.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:08:43 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Raag Jadav <raag.jadav@intel.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] cpufreq: qcom: handle ipq806x with no SMEM
Date: Fri, 31 Oct 2025 14:08:31 +0100
Message-ID: <20251031130835.7953-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series handle a small device family of ipq806x
devices (Google OnHub) that doesn't have SMEM init.

We improve the SMEM driver and apply a workaround in
the cpufreq driver.

Changes v2:
- Rename error macro to INIT_ERR_PTR
- Return -ENODEV from smem probe
- Restructure if condition in cpufreq driver

Christian Marangi (3):
  err.h: add INIT_ERR_PTR macro
  soc: qcom: smem: better track SMEM uninitialized state
  cpufreq: qcom-nvmem: add compatible fallback for ipq806x for no SMEM

 drivers/cpufreq/qcom-cpufreq-nvmem.c | 17 +++++++++++++++--
 drivers/soc/qcom/smem.c              | 26 +++++++++++++++-----------
 include/linux/err.h                  |  8 ++++++++
 3 files changed, 38 insertions(+), 13 deletions(-)

-- 
2.51.0


