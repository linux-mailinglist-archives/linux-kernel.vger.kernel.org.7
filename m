Return-Path: <linux-kernel+bounces-740731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA17B0D85C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C5E1C27055
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D6E28CF67;
	Tue, 22 Jul 2025 11:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/9rQlJD"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ABA2E4256
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184236; cv=none; b=MLaEXNUQkt+A5cxQmqRAWEB2gKK5pcGmKrPfa2Q/DXU+sstKrFoJN0j++oiePsdm2z7agyX1TbcT37bPpcrON1lsYE5q6hUbP3891eUnYrNfWNQoeaHh9ustcxS6SfO/ZmR0T0PJ6tI7DaboDXr5jGkRrKJ6zZ/hdEPLfmIt4yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184236; c=relaxed/simple;
	bh=QKWrUkuo7grbcgzxlJkh2XQ7nAEZsfaefnrsMDssak0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PttcDchO5fCqwBwexzoq2Px9D4akKqQID0jvD/8H/kOk3DePWXxyOiyroZTJWiX71JT77VlfNgb1tc9SWWRZqXOziZ00um64SetjeZPCjtsyBvvQ3356oK3gm4JFEhOHFzyX7uRKs5sH9H2GGN/56zhcffrBqK/fm24OI/k5VLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/9rQlJD; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ab61ecc1e8so40024591cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753184233; x=1753789033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKWrUkuo7grbcgzxlJkh2XQ7nAEZsfaefnrsMDssak0=;
        b=S/9rQlJD80++FNoNDq4cTbY4KaUfqQAVU0ks+j80R3Qw/VmiE0ZtLFJhWMYm9kuVsA
         kTJC50snYAJbFb4guE2waX4hja94hFriextQ5Qndb2twsVGRYKj80BgEWnpSVvBg3+J1
         X+9g3T4mj8zYSKC6TzZ5agFM5IUbIVmK9RyaPw8K0UBZPnulIcxv3xaOKkjBht6F2Kbv
         eoo1eaw/GF4y2Gg3JC0b5ZLwhXFci2x7MWjRFV/FKyI3Bbu0Ui83TGEuNU7A5yK0igkf
         p5cdaJUCpVaJQaQ9il4LxP6NtQd5zxY6/YLNcwntTzend6XflzOmO5JK8PbNIbLy7rtT
         qyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753184233; x=1753789033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKWrUkuo7grbcgzxlJkh2XQ7nAEZsfaefnrsMDssak0=;
        b=oklnwEyyDVF9MvJAxbbpxX2qJnqPouqfhyKyHWh6649gwXBtdaIfYqx+hWtUKoAZuK
         sDTQOEkqg6qXKbbAcW9FW7C9/DaNfEZ7xMKOdqk3U2dVJxPZIPOMQ4sXTPA6hO0r5bT+
         L6dUBXWjzZq01VUo28O0ghcYdJJFB0AsJE5lYWiVqL4Jd/z0cCfp32yOm32nQEhNeSqw
         xKd1QT7oWtg5F3D5d6akGJOhqmUngu5beqphbflK2MLxrnSin5Wj0BOzwxIxjB69HhUJ
         xrAcTnKh6vJzpkQQYlOUZKN9mUAUtyyh25zmONCA7ngXma3LDXzceN4s/ZKhG+Pbtvhx
         3ObQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7kINdRrepzJ93wYmM3DainyQSPdCD9DA9vXdayfc7v6eLRdKBkupZkiIwWHoL+FQZTi0JI1ET/n3W/Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCuWyNkxX5eomo1DqSJjZZmq/JXjHH8/Hc6W1x4dTNJqhiWGpn
	GINvEv2J124RGsH5CuY77Z8noBYgcpa6fj4S+NrZ2dCTBYj9J6fFQyG7QbNZ3q3OdUQ=
X-Gm-Gg: ASbGncv+9XEPsPAv9rywJvu5U7vn9ghBqEctt9F8zasDLTw+xZT3BHWEja3amayEuIb
	vsCIpTQjkMsrhFnWX8ewhuYTVJDQbqmmrwVU4xQ6iRQvINgYg0CDrfw6dZqKigle6X2yfWzhPrH
	ts6Fu01hgbRQma/b1DkB+jp1JjtSSOtSaRHXn3a/0AH0DgsKxyJmzzaCjoxurod20+8TERp5SQq
	WyNSe7n6VIvN4yQX3ayEr2qJGKhJA+IL5Z3+qdEGpP8KesodX3lqSDDFNEPSpWFF0WjZS28yTzf
	MsEspPG0rCUKlq5eid5A9Xht2VbP1KFyAu8CR3aW0lIis5soIfkUy9glpoGdcufNTy2B36WVYfB
	qhPUm3xXuoEDsIXWh64bOoY6LqKxKYChZmU+U7akKM6XI
X-Google-Smtp-Source: AGHT+IEOTqLK99GirCdv3vi9ClA7MDVNxlDOTzMFF9A4U7qJlk2iPd71UOCrRTZJzKWCDoMfMCpiNw==
X-Received: by 2002:a05:622a:8e:b0:4a9:96b8:750e with SMTP id d75a77b69052e-4ab93c50c48mr372926291cf.10.1753184233415;
        Tue, 22 Jul 2025 04:37:13 -0700 (PDT)
Received: from Gentoo.localdomain ([191.96.227.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b25a18sm52457651cf.59.2025.07.22.04.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 04:37:12 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: rdunlap@infradead.org,
	linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 08/11] Shebang line was missing,fixed
Date: Tue, 22 Jul 2025 16:47:04 +0530
Message-ID: <de993a86a24cedf6a451cfb873031330f7d17458.1753182971.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1753182971.git.unixbhaskar@gmail.com>
References: <cover.1753182971.git.unixbhaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added the shebang line at the top of file.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 tools/bootconfig/scripts/ftrace.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bootconfig/scripts/ftrace.sh b/tools/bootconfig/scripts/ftrace.sh
index 186eed923041..cc5250c64699 100644
--- a/tools/bootconfig/scripts/ftrace.sh
+++ b/tools/bootconfig/scripts/ftrace.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-only

 clear_trace() { # reset trace output
--
2.49.1


