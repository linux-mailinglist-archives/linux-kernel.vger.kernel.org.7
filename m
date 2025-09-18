Return-Path: <linux-kernel+bounces-816350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0B1B572B7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE25F3A42DD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A7C2ECEA3;
	Mon, 15 Sep 2025 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyTQuT9I"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D5A2EA73C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757924396; cv=none; b=PGB4AZ3YbnGRvLjHuvFHp7k9NaDB6TtBZCf1/y2R/pHtfbv0bXdawVopavAWhh9bueyWwDLneQwuYukCML62/G/RETo+u/vQY8RYwf3XrZuF8W+T2DuwK30Yw07tMkyjRvK30l9y+ZJC+fVW/fysBzaDWAIJQmwl0zv1S9d7/Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757924396; c=relaxed/simple;
	bh=Dz8aa4kS7lSfCPjfsAQ272A7eZDZqhkqJwixqtO8eVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2ML/wICGkttlHZElWzf95gSabv14Mzqp89RjbXMF+2Pql5GsVNiyvy45miQ/I/QESGWQULDTlodYcXpdrSnRlQB5hufp6aFtz1/ugAdf31SnaAmezkiOO8KjgJEwzVD7czY9qNWyreU6R7F4h7qp3Os9tmSh1PpmDKzJ29BUC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyTQuT9I; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7723cf6e4b6so3042756b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757924394; x=1758529194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCYYREeHHqW+dHHJ3sW/tx0z/7PT7VOYKqF3xiPJ7aY=;
        b=XyTQuT9IH8rO6Ltz36QRLWLVEfJxo6n5zj9emUAOcYeipZ5DA8R6vi7ouwn/m7jBkO
         Agynq9YoFRyuYjMo7bJ3qlg5AdHlfM1TAMT/57DNY0bmWmqdlSN+q8noREz3ai7gROyb
         pHXOOyEFp/VP3Hb7JmuFtmgovsHULub3Onhl3+RyVD1IqKKC52UHc2zBwxl4s3CwG9i5
         0hD/sSBW6IiyFpL6YG7PuwRQGMhCXH/RX5l0shyWc5Txd0CpVQX4bn29DpUMK4sNTxyg
         TYHmGcKwzu3PfEJdnMxPcxGZFhj4iG+bmS/hvzu9rXtbOcRUBgCXQ38tKSxXfoLgbvFL
         E9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757924394; x=1758529194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCYYREeHHqW+dHHJ3sW/tx0z/7PT7VOYKqF3xiPJ7aY=;
        b=dylRgHbIkpqEXcEGrfqsgKe8ab/v7/Kud5ifHnpOlkpKQWqmwngWSQ5iRckjmzQmx6
         CfsmGgtS77nd9OERu0K7jsU8mZ9246kqUfOXyW3C0oJyLqQnsQbaJ2cKGtGopFtn6tI1
         WwaCYOMOeCKiABx00ahKSMSKoyBjItSB+afOAKz2WhPuIfD6isi3FuXy5Ty1X/R1Fcz+
         pJg9eY187nSZSDlwJEF+r18NF7A3d4lHSsBDOKMMH17iYxPPa9+lEJdtFv3Q64d84RaS
         8VlvCBxMOkyukF7A6ULqPwBwJWPvYQvAIFjZs+5tfmDDhmYQ07uxiWvY8Hs/L/daeCLY
         oiXw==
X-Gm-Message-State: AOJu0YxDt2JKQ0xrmwrPHaFYaUDg7jZeTPov5aFxXY9wqD7k1WQbbdGt
	2lJM5QZzRF+lgANW2UtQ0XgpivgHa2KzOFM3JP/GkRVoGIvmK6Ss0/HH
X-Gm-Gg: ASbGncui0e7xUGp6eC/SxC2G6PkivaFeljSpiHJBY5rRLEQJDnyFoeqh4cJo1927HB+
	DUZJD9kRHD/eh6Tlf6BvNWK5jKGYR9BjhUrnYV8R8yg1GgESfoqy/JqrSNdB270zbyYUZYESsur
	eUhMBTnOHd4m8PHmnb5eP0OJJvPwD/S+xfcwFmmq1zsP5Ls5BKqAAVXlm5LkWX2O97viHr/MTIf
	DQHHjSK7urM5k2O2xFUTGrHwvvtulF4fiLnFMDi/PHEUtj4gK+eKy8Qx7zaooNTxuStDw20PkYj
	D7xjepp6frw5XpcjYsPXWVu/Tjn0vCsYj+8PYfM9mmu0fYWwL5fhGp+7YEXF3JaW9IVzeEv77Op
	wdombZd4VHzYdiQ6zOrmReoZXBA==
X-Google-Smtp-Source: AGHT+IFBi6gISS0cUFo8fw2LEFLyNg67s8phKuzRYUMqcuMHblwEHM8uZZ8DTf1CeFNCn5jrnCBDzQ==
X-Received: by 2002:a17:902:f64f:b0:250:999f:31c6 with SMTP id d9443c01a7336-25d26d4d96emr124838495ad.32.1757924394240;
        Mon, 15 Sep 2025 01:19:54 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-263bb2ef614sm42899955ad.150.2025.09.15.01.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:19:52 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 47EE841F3D7C; Mon, 15 Sep 2025 15:19:48 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux cgroups <cgroups@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	"Bagas Sanjaya" <bagasdotme@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrea Righi <arighi@nvidia.com>,
	Johannes Bechberger <me@mostlynerdless.de>,
	Changwoo Min <changwoo@igalia.com>,
	Shashank Balaji <shashank.mahadasyam@sony.com>,
	Ingo Molnar <mingo@kernel.org>,
	Jake Rice <jake@jakerice.dev>,
	Cengiz Can <cengiz@kernel.wtf>,
	"Mauro Carvalho Chehab" <mchehab@kernel.org>
Subject: [PATCH v2 3/4] Documentation: cgroup-v2: Automatically-generate toctree
Date: Mon, 15 Sep 2025 15:19:26 +0700
Message-ID: <20250915081942.25077-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915081942.25077-1-bagasdotme@gmail.com>
References: <20250915081942.25077-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=833; i=bagasdotme@gmail.com; h=from:subject; bh=Dz8aa4kS7lSfCPjfsAQ272A7eZDZqhkqJwixqtO8eVY=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnHT+c9PbFiSrDwqXnb/q1dumP7k4Q9bnvYpjw96HXp6 PRYI003n45SFgYxLgZZMUWWSYl8Tad3GYlcaF/rCDOHlQlkCAMXpwBMJFmMkeHvg4unUry5H3vb vNa5VOz34Nq38gtS2fIau1dU7lCYPvMSwz+9A2c2T+tre24rUPZHmPGfh0vdDr2t1nvUmqT9JNh du3gA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Add automatically-generated toctree for htmldocs readers using
contents:: directive.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index fe8ac5aa0f1ec9..4bad0a18c243f3 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -13,6 +13,8 @@ of cgroup including core and specific controller behaviors.  All
 future changes must be reflected in this document.  Documentation for
 v1 is available under :ref:`Documentation/admin-guide/cgroup-v1/index.rst <cgroup-v1>`.
 
+.. contents::
+
 .. CONTENTS
 
    1. Introduction
-- 
An old man doll... just what I always wanted! - Clara


