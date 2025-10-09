Return-Path: <linux-kernel+bounces-846311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0213BC78B2
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D081E4F335E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D06028D8D1;
	Thu,  9 Oct 2025 06:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mU8jNTDY"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF59221FB6
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759990868; cv=none; b=msy3YyvFegwZsbmMIKdk/Q5CMjAV04W7fNaljZJedOFlxQrEtuZZIo0TkGlAMg7lhm0C/Z8UDmxc9JSiqP0p4esZfDGkUu1ZKQ0DY4Ynf2qNr8mg+WmTp+HFwTZVov/qozY2jT4eYdTXPj4aovwUVlo869mU8r3XC1D5P1HIYgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759990868; c=relaxed/simple;
	bh=Fk+RjXbZJTL0DO9yjL2L7bGn62WUZdyrqJBrM5R3R5U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=f1hUpO/PUt+Xx+gDld8/enLKnnCpLjBgiXoY58tHVT1MtWoYdh/ihvcCQNdJnHgri67jEThufz3ks7IMt+fHU0FIKu5JMzq+8aB9r15RJ2LwDK0wtE1aOMjImfFI3eSMnRQpYy2SYC0kbI9UF3Wm1Lu9to7DHEK6Mv4ttX/nQYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mU8jNTDY; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-782bfd0a977so487223b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 23:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759990866; x=1760595666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BtcimQvrq503f7Hzsc/besUDu9Iss597RLpVH8L9bnw=;
        b=mU8jNTDYl32yrxYZFPUfgSRODVo/Pvuh8GaGcmSEdiuEAYt2dC5wvzjg5Hy5LOxq5m
         QerXW0pm8nZ7JCmQlqJa7ifLVyHocvucggeaGdd0/aGB77/oFr69vJYydZJ8jEZaYBEx
         PfP8KLHNCwaL/qcOG3Lvnd8EtOFyrKHP0+4m4spefOGYSkK4v6a9D9Zq7dotIUtKsMZF
         qX6SrAoPZu9pn7q3sNptpy0awX3TcKb/sUTbeAR+Lqi5iV17DBty0QaOWiLz4AvS0HAC
         Hg+wEy74ULNfQf1iN0SOE2KKVVMQDN3wWLm+VETNt+gAGAzlBhEsOwEHX3JLFuW/B3l9
         H0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759990866; x=1760595666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BtcimQvrq503f7Hzsc/besUDu9Iss597RLpVH8L9bnw=;
        b=i31kHaF8abh93QYMm477bnT7eV3y1eu/iaytPs6uDB2FxY+AnoBgyamSxMD7YDCNJg
         8zKsK5dT4bvLHaqzolSIUqF8S4DMOMiRiCLMGRPPXgi9qhX6EFkPRq/0LDUS1paDo7gJ
         5YmVEKS8nMLNxKZCj5w1eeyH29/JnpZfo0nV8k1lV5sPi+PbvbudzsKMbYvlXpMEPVbo
         kzpxa7PB1bdrTyIytJs3vX49WnZXmecqTUk+5YflGhV/tQnywB5KrCAds5c774g+NeT0
         cOqQfcSHLtBx6xWB5sIhfHGd7dgt+LGJFVEY24kDoeNSA3Ik5vTPLbM+As3vftqMSL5s
         xM+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXuSUSezgbdgOm4p9uN8XTCAOvIA0F5Uo4CGRMgSVFn+3P1o2LrQngZTAKv2uCCkuAvd4owobnHx1n+0/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGrlEbzm7nTjRt11kgnnRA6V/hweAbUUnFohcad/plgkj1n1Mq
	rV0QnUaWn8OUGvxht/tI4kA4ndNk5Jz/cT/Q912CsKOVAWadsiYh1Mw0aEHJDA==
X-Gm-Gg: ASbGncvMY1uTV7rFn6D/Y2EaYO6Vx/m3pq5gJzyj2gb/gaaOnxyqRqIx8Kq79fB4rof
	DYlvy4883t1iqVk//Pk5529vuE0yuQKEvDB672L2+io66emGyDgid0gSY2d+lIWP2jxzXCnu3xh
	rBA/ax423hiq+HFgHegXtq5M7Q2He7DvZ4/PIg6R0edTAUaAkhn2EKd2YkbwFteMbPlIbMyXPck
	KmIzponv0FKinjqaYj26GjrEY86hQwXAgVqZ08p53xpxMlErcukns/TqU8mdPuGPSb1A7ynYK6d
	Igi647llho2JNqWWmeiOzbG+uXmsofymMTk6gJoZ1MUi7XYO35wxOdeL/1QsOvWM+hQn//u6xYg
	vKYCZnB1h0ISrBcLpXWhl8z0FZxTgChMk1HAD2hC3/6XuC5RQFTfP
X-Google-Smtp-Source: AGHT+IHgL0/LrT4Tyn+uTKNxNi0hK/zZRK6Dw1o3C0PshSZmrcB1E5/oSohTBTx4rGelQXJ715r17A==
X-Received: by 2002:a05:6a00:a0a:b0:77d:13e3:cd08 with SMTP id d2e1a72fcca58-793859f64aemr7043025b3a.5.1759990866082;
        Wed, 08 Oct 2025 23:21:06 -0700 (PDT)
Received: from localhost ([46.232.121.212])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794dbc5a163sm1744192b3a.42.2025.10.08.23.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 23:21:05 -0700 (PDT)
From: Frank Cen <focksor@gmail.com>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Frank Cen <focksor@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] docs/zh_CN: Add trace debugging Chinese translation
Date: Thu,  9 Oct 2025 14:20:17 +0800
Message-ID: <cover.1759990204.git.focksor@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix RST title underline characters for proper formatting as noted in the v1 patch comment. 

Ignore the v2 patch please, as some changes were inadvertently omitted.

Frank Cen (1):
  docs/zh_CN: Add trace debugging Chinese translation

 .../translations/zh_CN/trace/debugging.rst    | 133 ++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/trace/debugging.rst

-- 
2.43.0


