Return-Path: <linux-kernel+bounces-841596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 249C8BB7C92
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6905119E801A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636A82DC357;
	Fri,  3 Oct 2025 17:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lU0irur5"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630752DC349
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759513203; cv=none; b=iQK5b3XjepwLfUkNnNIoNHhLe1r9Hx600+tLl06QZpOmg0BdaZ7Sd3U0rdoh1Nnbq2Pj1aGazJ4GGawM+YzvZKZTZOy6RizAP+WtEpoe4bpyR1IBWAj71BWNznKlwViAD2Jf+i7ELkIoDkDqS6xLpfN5XZrZ0w6cAqHsnzWEkhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759513203; c=relaxed/simple;
	bh=MNsJwzWoBFNGIPNp9zuEOLvCY9eIgUfAuWeZoycIM+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQMER8O5GLbZoVvMIXdP74Vu6XkIArNhWWOoaAQQdL3F3yC4FKyeMM/krGVuqwiPB1CIab16Rki+EWTCrvLDGcVMcREBmWGoQFYGZ+RkKDqQwN0hoqfUusQ3ZSgirjAirs3nam/ebBdyIPe/zQVP/JIrxJrN3+gJaUyp7rbVmVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lU0irur5; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b55517e74e3so3052200a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759513202; x=1760118002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0C9k4xvKVCB2PiIDViG3AgdtqSvFkeUkq+FpVkkyBOY=;
        b=lU0irur5JaQgavbwFaytZVRjXU19VZvBa1QRtE/mj4CX864aA4R/p6FB4/Csoahr6Q
         Kwd8wxlnxaDMs3CdZ2bvZGjbCqRTcS8AgcKwFEKDzJMeL0Fef5paEtPqK6apnHCEjkwT
         SEftg9d3K5Yrp5fXJg/9v/oBt9CdaHiJalR3Z8kCycdw46buPe4jO7CRLt2EWGTZx8q2
         YCyZ1ImwcO/2IMw3h1sIGvtOahsW1pYLocEpUl1bOhsnItbQW1fE75rq4o21PF5Uvc2X
         GdwDai1AUSt48Ew3a11YPvEQFyY1YdLQaoJGqYlgz83v9O8JwfCmmEpADrQyz1GbdHqs
         DPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759513202; x=1760118002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0C9k4xvKVCB2PiIDViG3AgdtqSvFkeUkq+FpVkkyBOY=;
        b=SgjgpBNO5PIgb2U3aNrfp5Fw+HybD8XMdQ9FAzWjQAxsUWiTbcqqOpaWX1dKldrxf8
         +QuqIMeer1B0LhUeB0xSPm8Y5UTul2MbHvFDFieAdWsVgo93/VsR+FXXgAKU8uEJsIyB
         qZQK2P+n4zfP3WhQpjXcHNWTf2rctHK5Uvac7wXOGWLcxZ3VlExNvXae9KGBoVDTj9Cs
         btVLsJrP5VzQe+WacC5p8op5mNfk6LFOPAONX/SkgMTKK150h9/vH8SZ+WVvyMEwSwmQ
         x8ZM6E/0RRdY0KPj1G2Lbf9FY9RPDJzvzaqNwOfzkQ2gfbJr+zhwgWqDIf8/CxO3WT3P
         fVOw==
X-Forwarded-Encrypted: i=1; AJvYcCUW1Aj+KS796GPUAD+KMAbVSdH6TmR0PkoP4EWxkrf7X+FP4FoG1B7J2L4Iwz0XtkTS0/5Y+uGN7WnBDgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8cpPL0W8++piykRRtC450PaWIaAqCvOI/Vqfn1Jd9yo7pLfTf
	8wD0yryv02qhVVR4x8lKMkSSs1KUi4Ve3rpMjZN4BZHygX5Gy9dILOIi
X-Gm-Gg: ASbGncvtTdkb7nbX5qBBKodOKLdILuvcr57fkijFM+K2P5URfSS6r66GE0ApWXN3Ejn
	H+I4lPya3/Duj3mhAngJ/DHfXhc6BoOxxwbTJqUGX4abNePnSpU6oWdD52ZEMnNLSQxYOUuzPa4
	u06vyb/W5fdEt6KZoZ3YQipYoFqaAPHbFpBlpVlMj5WbS4htT5SvH7Low05825E2XVcZ46DDuQi
	HED0l4eNIFB960vJ71VWsrK3wk24egdoRaEw0phT+/DDHKzmHehytMbz4QLXnAxi6sWIFESASTT
	yfW/VXvFRIEtOt7GtIXhSRzUGZO8plB28rjFK9GU0mfFtBEH4mVVdlrOGcT+A2+7e0n2Z2J9vek
	1cIVv6aI8V/HZRSGuzMp1Fif1pLCEkqGMzCYLJ8gX+MXCzkT2xMlYetbYLFfk2Z0s9Q==
X-Google-Smtp-Source: AGHT+IEu0QHNMiTMz+jkJAI/HHluAhQfPRVspjKoNVy8iLjTYJPba/8/tyVedWu6dgRBe5gPMr0YDg==
X-Received: by 2002:a17:902:d484:b0:269:8404:9a6b with SMTP id d9443c01a7336-28e9a6e4d0bmr47120545ad.57.1759513201655;
        Fri, 03 Oct 2025 10:40:01 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1261edsm56267635ad.34.2025.10.03.10.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 10:40:01 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: corbet@lwn.net,
	zhanjie9@hisilicon.com,
	rafael.j.wysocki@intel.com,
	superm1@kernel.org,
	2023002089@link.tyut.edu.cn,
	qyousef@layalina.io
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org
Subject: [PATCH v2 2/2] docs/zh_TW: Fix malformed table
Date: Fri,  3 Oct 2025 23:06:00 +0530
Message-ID: <20251003173926.10048-3-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003173926.10048-1-krishnagopi487@gmail.com>
References: <20251003162626.6737-3-krishnagopi487@gmail.com>
 <20251003173926.10048-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Running "make htmldocs" generate the following build error
in zh_TW/cpu-freq/cpu-drivers.rst:

Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst:109: ERROR: Malformed table.

Fix the table formatting to resolve the error.

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
Changelog:
- Adding missing TOs to the relevant maintainers.

 Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst b/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
index 5435c3928d4b..7f751a7add56 100644
--- a/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
+++ b/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
@@ -112,7 +112,7 @@ CPUfreq核心層註冊一個cpufreq_driver結構體。
 |                                   |                                      |
 +-----------------------------------+--------------------------------------+
 |policy->cpuinfo.transition_latency | CPU在兩個頻率之間切換所需的時間，以  |
-|                                   | 納秒爲單位                    |
+|                                   | 納秒爲單位                           |
 |                                   |                                      |
 +-----------------------------------+--------------------------------------+
 |policy->cur                        | 該CPU當前的工作頻率(如適用)          |
-- 
2.43.0


