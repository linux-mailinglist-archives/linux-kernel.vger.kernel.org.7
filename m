Return-Path: <linux-kernel+bounces-835757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDCABA7FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4A03C1D52
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 05:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470EF283124;
	Mon, 29 Sep 2025 05:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD1ps6Vv"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AD027B35B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759123425; cv=none; b=n35aKiRUDFi0CcEw5nqDfuJquaLmONHddCKkRQZabyqDevhh08p91X+8Y2ttpry3ZNiGshGyxQRiqUhqL/f5ueEcoxQW7ADLnXyJe0ZMvChw1xUJI0FCu9DonGvZ08ggfS2uug4SMXzrBvvVdZge1ZSXv8HDimg+jAANP6VCBVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759123425; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UW8PHXP/dSCcADWnwH87IpmSan42jXq/zMjELKzTaHsFMvN75sXvMo+bIk/mSEb9t72uSQiB42nH3G23nnoNCgDgdQdmH4IrJW5o6HEs15PjYMufznNoR+UpHuNTSY1cwa3/lTxrrFO3sNkL/sU9Zo6b44qZ0ZhKRyz23RPsX+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kD1ps6Vv; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-330b0bb4507so3569448a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 22:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759123423; x=1759728223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=kD1ps6VvrakAp+vBCURQqPdfEpnc2zRzzw1Rio7BwIq8WEg7O3q0LngUS9jlDjAzyc
         Zq8fs1PtPMv6YRoPyXYK8sixgAukBaDj6YLaUFAjvVuC3P1D89tyMI6ZC1FN2HYlPGTu
         AeIjh63owrBImMws0VRiMZI9wpptymNMZ8LVxNmjpwWMvrQRParnqiF1gmtB9ROKB19V
         B9WpHERI5UhJyhJN6RmyM3x5dpnNqASeNkZCeGVx/fcjVuDpSdzDq62jOP/dx/6hipRo
         rHJ9wvXMOMncvyUZgE1Gqv9AetTpcNHmRcg4JAcMhqu36FoEHkpSD+l5UjCnDK5z5x3P
         qjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759123423; x=1759728223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=KbNqhhEyLJVbqrxbAhmmIZtJ3+nE/acQByzs9vHJngCAe5RqVsMJeErMebYmPtS49R
         b5ORhdXFPwBwPFaWWT/Ks4e8qvvdWX/NNXMg9mQTXvMPzGk+zcZg6ky1RWfzaYNuDbQ4
         4EpD3MQNYHKpNq1+/CefWTsHRamv59KPcF9XuuiRrOQfkPgV3ATcAN9rlusv6i677zdu
         Il9YRgiFHWUYdYq/VqrIi5uG9ktliUJE/LpEsyC3tbfjTt4/vmtupOxD+UC7CpQ1M5vJ
         YsMGmF7Q0yUNH+bvQANVy38/7x5FxrTcLGvIz2Z+YHa+K9800D4eSKswXFWYETH9PU5U
         +NpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO3QM1/VDjiEB+PySvUCMnJNsTofmHAifyoHCOCM/MUtvJkD74O7MSlJR9ETuVzrzl1iSwt1HKmwAKZeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdarBGbOKMN3346IcYXBKtKnbt/oWfzxyVq63PEcfQbRAc18LV
	1gCHevIToI2TGH6h0g51UgYZSBIdJgw0KujmR4yiCbhgYxBtcaVCES7H
X-Gm-Gg: ASbGnct+tsHVxrgpxst/RAZKUBLodRjtI1sb6b9eeQ7RCB/mp7vW1WmsstD7IPPVEXV
	r/rEj7jO7ygIZJZMOxRy4PN5QVsgPjfNQALbmDNNvQ7ULsA5wE36y3eFstcK2Q+evZRoFKaEFpa
	mzBdl+sRKXoHTbHgRmF3dLgzIEnL907W6Yrh804LePbqPC2b1AtUKaKbLVwXkdNsE6/+2KwIvll
	T9ZeBKAMyPTUadCBEOlK4HYs52lx5D89qjdE3FlQwnx1wHAmgfwZ9NdAFmSj7u7EF7GOOm4s2vg
	pKvGq98GrErrSOCs9OUx3RDewQ9ckRr6jbEEbfBsqf0ZRGlFJR+HBlOoWepUdtlW9hn+MJs85/h
	qaDWP9ljN3w3IB5HFKjVFEfzrSADk+w6ce1X6qKtBFFZ1OWLIBoRO4cQjylljbL7FQ5c9igFcva
	QU/qYqotIMmT/E1DKXYiioDtr8
X-Google-Smtp-Source: AGHT+IEJoqc66VUscfTw6//v5p1CW3/qMbORU0IbE3nlilbmsGWpSH6+G0Hj7neIrDJcRxEhMBbqYA==
X-Received: by 2002:a17:90b:380e:b0:32e:7270:94aa with SMTP id 98e67ed59e1d1-3342a2c7d99mr16864651a91.19.1759123423576;
        Sun, 28 Sep 2025 22:23:43 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:10a6:37a8:772f:4db1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33473f7bebasm12031483a91.13.2025.09.28.22.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 22:23:42 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: yi.zhang@huaweicloud.com
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: validate extent entries before caching in ext4_find_extent()
Date: Mon, 29 Sep 2025 10:53:37 +0530
Message-ID: <20250929052337.334807-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


