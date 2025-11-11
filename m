Return-Path: <linux-kernel+bounces-895036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAECC4CC5B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4991C4FA674
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E5926B75C;
	Tue, 11 Nov 2025 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKx7WDh5"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52292F39A4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854338; cv=none; b=RJEqJr4UI8pz/ENsSJwjYF7k+acsyrHew6l6jJeW+0o728q0JHWBzdHn5Hq78CfdmZO8Y+94qKnMIpjN4/G9MfwsFqNxI45dWX9JnBrQ1kKeqXkzK1D8DvJqf3jjfIJqJFY/BJGk30DJQrhSIB+UpoStojKsWgYUVtpio3MvA04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854338; c=relaxed/simple;
	bh=lf7WAmXXlNMNByc6t4LTsXWtP5fFo0VO8PLMA4FvwHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLSA4ENB3rPh5+glS5mzPCy34qdQZBu5YqlREUrNYlEXJr3pgQmdocv/ICbyDR4P3V6j+L0bYHmxh3a21dxuQqRdHVcrVR71fmyZGOmDF8uwGu2h+qw5v5+hX0Z2wtSZvexuiQIDDPlKJIzTvMgg2EEu8ZiSTseb6ORyCxFWX80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKx7WDh5; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so21700615e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762854335; x=1763459135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyTFCidwYxLdrRo0mrPJg5BpG+UQKkEfi+EP0wnzqpI=;
        b=nKx7WDh5pE4FMdp/SGss34+W1+VCRBLoX5YTJ9WOm9z91xHfRUxyt/LybjE/3WSn1N
         optoHTIP9OZag08ZoMFH0s0ou1SVOV77VzJJpLd/2ZrbNukKmoBZ+iE02RKFWEIE351v
         n1XGOKwjjmLsTn8i/uEEs/fXKXv5mw+ulQtNxwSI9vf40ciBPJMAK04FYowHD9FWmeF8
         O1jhvH1awKezLTaUNzVriesglftq4CE9eZxzcCxVJ9yti9QOt1/+a08wLktZZbcWLb/Y
         NPI7BMDDM0vIJLcsbKA121d5RqnKS2MkJQpTcqB1D1Gk99gT4E/hcFyWIeCwVmsHWulS
         jA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762854335; x=1763459135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyTFCidwYxLdrRo0mrPJg5BpG+UQKkEfi+EP0wnzqpI=;
        b=j/JEUs9AyapqeCbZRRw+R3lrK94qltn5AL/vZd04Q9V5LMCZ2djB/+h2JXL8AnH1k4
         Eqz2gA1lm2D9aKjidBGOAfdcY3otxAe46QZkN7x+fzv190RLuheszKLVgyil6yJTWKAI
         ESjmKr/5cs+ZL7hkI1EkBhVu6gQTfd/beOTjT6bb+Y1vWjANHQZilLBat7tpM1PwDULA
         D/0PepWrD/gWYfKWgfvecBdKX4CBBl5ucoo5M5NG50goBgHJw1aRuHVJCPUCHTsZqm6J
         cfjpfAct0iCs9jgQ2cR7f+gMJGpzgQPdfaOpnFW7QoTEjDjWE2ey6sIsGa44lbDGByDj
         WLpA==
X-Forwarded-Encrypted: i=1; AJvYcCXjA86uDMAIQQ43uZjnDDPwabohlT/CROl04xdWU2X7XKQm1EIY5lLirc8+M5kAQXeoXqyoVK1vzywFTl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5lRO0aFJ6P/k5usxTGWybjNRCD6JrmBNU6DrbdaucsAMh+CzZ
	HCzD9X4ckWCNUt/yzKms3rkjsPz/QavK1IE32bt2wIBaBg9TjhMf06x1+z5SqA==
X-Gm-Gg: ASbGncu2AnegVblcdIIgKAzNbdJy8Kdy2d8WzQHlg4cU09ciBrlWNkWJLuTMl4dTrl0
	XTAbZSFMBmhoXfBug8TFnTykkaMU9WlJvI+OCigpygb8ebUvPQNa94VPe8NuaKj39sQg7B6cCM6
	qaH+WI4BJIglsPmJHU341aPr+T1J6U3ua/Rb9F8WMYHZSSTQ31R46litIRCYOyDfViV86sy7IV9
	A9ovvRE8fgks+rcQwYUXdJoBlhn6mpltUAMQ954dDkz7A5QwGKv+kw2SR+3VT5qCIaJnsUIoMGX
	MQyY1MXUtgM/Wtn//7//tIidOfbw3SF25jLPCZ74ceKyAiJdmvGxVSJ3bqV6+BTxuncsE011LYg
	K1YYamxkWyiIZvvqMHhEWX6MLPrjGQHRnsGtD2B+IX2iCkeRRQXTfS3Q81ni+CdiATtWHzyNltG
	cbFGM1NE+kLoZJuuBA2/XmgsWY9Ec=
X-Google-Smtp-Source: AGHT+IE+ZuARGiz3jx6grGJFiduhQHFRxZsDGWAZ3QmBErVlqeABMe7Zfmohvg0NcUOhdBFLbPcwEw==
X-Received: by 2002:a05:600c:4f8f:b0:477:cb6:805e with SMTP id 5b1f17b1804b1-4777323f091mr102982615e9.18.1762854335069;
        Tue, 11 Nov 2025 01:45:35 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cd45466sm359537865e9.0.2025.11.11.01.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:45:34 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: johan@kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH V2 05/10] staging: gpib: Change gpib Kconfig option title
Date: Tue, 11 Nov 2025 10:45:07 +0100
Message-ID: <20251111094512.6411-6-dpenkler@gmail.com>
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

Remove the word "Linux" from the gpib Kconfig option title as
it adds no information - it is redundant.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/Kconfig b/drivers/staging/gpib/Kconfig
index aa01538d5beb..2f42aa2d55fd 100644
--- a/drivers/staging/gpib/Kconfig
+++ b/drivers/staging/gpib/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 menuconfig GPIB
-	tristate "Linux GPIB drivers"
+	tristate "GPIB drivers"
 	help
 	  Enable support for GPIB cards and dongles for Linux.  GPIB
 	  is the General Purpose Interface Bus which conforms to the
-- 
2.51.2


