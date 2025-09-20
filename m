Return-Path: <linux-kernel+bounces-825462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA9AB8BD9B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 04:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B3B567177
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 02:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B168E1F4617;
	Sat, 20 Sep 2025 02:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvNtd3HZ"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75521F463C
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 02:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758336229; cv=none; b=iZRjXVT6/7P3QFQF50fFSXy43TKTA1/01GeJHmWckNuBHFQRPxaoTKIF0IwutrYIUQ8Sut+USFXZKVikyAjB/kqWhFAwypqr9BcAuYmnkAh7AWnRIUlqd3XAVSPU8jCMQcw7lpSA4rkytLEG9CiJrSzuJn3Cp0jZfPaFGTRPjT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758336229; c=relaxed/simple;
	bh=hwVCE9+i5xHJDveOieuvIwdQhF/K5GneAcShYTULfbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QnlWJc9UKcaB8d+0VAe2YcoB/8r8cmqjz2KumF7n9eABTYhQRkrzcWY2Y5smzBT2EsFeT5k4+hX6wg7rmwVnxEoCG2GlhZlCkJrvpCuaoVfijyKHJ1rUI9dUxws3mz7O22oCp49KjjJqfleCaPd6TMewBud1ZH/TZ+DomexMjVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvNtd3HZ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b5241e51764so2083074a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 19:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758336226; x=1758941026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mfs3qvic1g+bWFqyjGJtWgWDzIe3JhdLgi/gRYsR0Io=;
        b=lvNtd3HZw1p98bfbFQRzbvtMRCXQQAHVbl64ZYVUA4BFvbIU1Q7rxk/IxFmzXZuj9v
         4d5YUeJr/QlbaoyG+XejOznve9RQm1TKQ1DaZq0t7DlzAwJaHUvqj47UXU35J4665TGK
         DqicZFedoAHNkjzo17JozXCQAgp+bLrXHrFHI7TtfLSv+z2oLLdpwfulZshq7pN75zqS
         8VjTsPS042HE0egRom1BAldVp7GmkWf4XKvH/xAJlQstTzyNonCSoqxag0d5U/iioGbj
         3JslhBVDlacYLp+sPNSafTVH7+x2VIJ4hsRmdmuOZAWCkLPEsySTSlLDUDhz45QfFeC1
         P1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758336226; x=1758941026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfs3qvic1g+bWFqyjGJtWgWDzIe3JhdLgi/gRYsR0Io=;
        b=ucjgdbhzD7OnHskWzxuPq3E2M7oor99D/B5JojNSutTzSwUjU7r+E762PHZzXGbsdV
         eSbYMaWlKQZOX06sHDRhb79DWP4C7NmUN++oS2eb1S0MJUcWzCMXHkRn2kyjBwR1yoWE
         jFOvU+aZRPoGOnyHkdPpt2OQCz49mwJsWQN5aX1LGxGd8Ui9vV7Q9zranRHSN+8t7H+B
         krsJMY6ayIMEzUmUq0EoGXYpShvf7K0CKfqqLL3UviwrWXjteC/FOJaSBf+Ymci9ffw7
         Ujzpnd9NhcFC9N+L2H+Bd7Yu2ce3/DgUf2Ayk+wMaE9uAqSHy2HPaaLjuqYRhPZ+Pk4S
         +p6w==
X-Gm-Message-State: AOJu0YxouHnToc9OTUsLWefDN4LHjuxs/N1DHJCdw9FGe4VGCGmd+ENR
	6b91DFwp0KTP7hs2ldshnc9OGZjqvXDKyp5Nct5qslA8Kw6s7XRLn9ph
X-Gm-Gg: ASbGncshHEyWrRdvaIDWjbJDxJp65RsRHL36Zt6KX6f/aEaTIaxaTffNUO+eHFlhrHH
	tP2oPsi1LgoAth4h8E6gRR5SXdfwRcpLP7Sjr1bmY32dJ7ECLk3u09Mp7naubKPbjQefeuIVvhg
	dfBgZj1TFI/ONAaCT0tBo1A5OJ8I26gP/5NMydfyJZ21C0PoZ+uh93Ue6qEmGYtjl2cS4vXCyS4
	5tBjQ+Q9DKmDsIuRZuYQ4SnWpSgLOSBF+uTIqX45Z02Oa5Pmsp3i3qjA1EjpdIodatojbIXpzwp
	mWe5+5GLH4FbFXgQQu1PNXJKA17NiSKZTsDqByirQTAiXvdxg4e5lZLrLT/ZdXDyNKiX9oKL45q
	BnNmi8ZCrFpG9BlCbdt4zug==
X-Google-Smtp-Source: AGHT+IGQOp23kxhYo2J45QPOq4PTg0tmHp2E/BM/idwJf7XB/3Gt7dyJ059XRLC30PQd88l2yZ+8fA==
X-Received: by 2002:a17:903:2ace:b0:26c:5c03:6781 with SMTP id d9443c01a7336-26c5c0368a9mr48404095ad.11.1758336226020;
        Fri, 19 Sep 2025 19:43:46 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053dc8sm68989145ad.13.2025.09.19.19.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 19:43:45 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 0FD74420A80B; Sat, 20 Sep 2025 09:43:07 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Will Deacon <will@kernel.org>,
	Markus Heiser <markus.heiser@darmarit.de>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Silvio Fricke <silvio.fricke@gmail.com>
Subject: [PATCH 0/2] Associative arrays documentation formatting cleanups
Date: Sat, 20 Sep 2025 09:42:26 +0700
Message-ID: <20250920024227.19474-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=559; i=bagasdotme@gmail.com; h=from:subject; bh=hwVCE9+i5xHJDveOieuvIwdQhF/K5GneAcShYTULfbk=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnnhJPV+m+cSXo1qd8/+9y79IIThbNvrKr2b2jsCa4xz lnMGB/cUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIk4ejL8D2ieabT2X/xj7w/Z E34uL395bSrD//BFa1+cu3zr8KXaB8GMDDNOXOOumz7FWPFnKGPk/VfZN+9lSPRumP/2ePct5s1 2JmwA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here's two-patch formatting cleanup series for generic associative array
implementation docs. The shortlog below should be self-explanatory.

Enjoy!

Bagas Sanjaya (2):
  Documentation: assoc_array: Indent function explanation text
  Documentation: assoc_array: Format internal tree layout tables

 Documentation/core-api/assoc_array.rst | 196 +++++++++++++------------
 1 file changed, 103 insertions(+), 93 deletions(-)


base-commit: 348011753d99b146c190aae262ee361d03cb0c5e
-- 
An old man doll... just what I always wanted! - Clara


