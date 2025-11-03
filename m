Return-Path: <linux-kernel+bounces-882851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C6DC2BA6E
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 529F0349B83
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E183F30E0D9;
	Mon,  3 Nov 2025 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxubiSl6"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DA330B502
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172655; cv=none; b=tmB+N036R+584dNdQL9OEOfICSQ/QKwaHuGIsDSv795ChdsogkPA3HB76uvM/mOO+iCGON6/dcKUvifO8T4ltO8I0EfQS4TLaNBwys7OnViRJKCLc9WRIJ2SmA9PNCn3xQVU3kMTN2InEYQ/J2tsjHpsI60PItR7mwCTXna2WMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172655; c=relaxed/simple;
	bh=ORdNUFW2zEJlWs19F6Wve3Y3tfAR17V4MJgrWtqk7Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkt1TpeJURNT48BBsziMm9T30nV8pKn9YJk/xwfgrxRF4/9aEBLAR9S60yPXtknSXWp8lYes7qIs2+PwUCYKnrUS1EsuyueOIOM8Cvvh9R14e9Bko2OugELrl409ckmbs6FQBkfWRbEJlu/ubMoUJR25+loROgtvZdnxCUHMETw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxubiSl6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33ba5d8f3bfso3709493a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762172651; x=1762777451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORdNUFW2zEJlWs19F6Wve3Y3tfAR17V4MJgrWtqk7Qo=;
        b=WxubiSl6aC1/hr2QZS8A/XlfeSHNAvdoknP45WE0Di9Mzvl+JVqk8ixCvSmV/lCFt3
         4zAg6ourZin6RO4+LMsDjJMOvaltHtp1rnyuwGMjQfixNw21SfdMi6Wub8YzcTlgj+Fy
         MEvrFXkp7RL/0QNC89JvHAwrrZLiWIsVPTwl/SeU95cnUTrbrdTo7JZkivWv9NhjK5IJ
         2mLnJsEVrkrJzYxh5htnio94RHP/Zt6F/OxgDCVlq0WfOCOV6UDHRutywoIViDqDdd/K
         vyoO45iiHqj0YrvNBblyjgfL2hHiMM2Uc9VyHCEPw1pQLNSO+MCcPr3XZI/0BASvJgq4
         bHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762172651; x=1762777451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORdNUFW2zEJlWs19F6Wve3Y3tfAR17V4MJgrWtqk7Qo=;
        b=oeTItBQp+P/TZCLL/hKQhozGXQvD0rJ9gqZ6qFMVcY41MT9nssHVHWk1ZAHNXXCPUC
         jICw04DM7Q1b+YfvlGQ+oxcGVCvxF9eoBD/nvJ2deqLZ6jfyQh/wXdiRTMDqwAI41/x/
         s+txnRXNv6FvZ5n73XjkAcrSJks2IatweKbjcGaVee1dhIgUmQhlFJY1FZ9YkuEc1FI+
         dyhkIFtNI4cjI6icpHC934RtrWUQsiDP7dUvj9qG45JJPVy1zwDQVmczWy9Zbra559ml
         QxtislykXq9Z1ra11NVaH5acWZPweQB+FjqE8VOyeFwHcLMIL/0KlToJ3xX0z7sSloQz
         +kqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWytFsUnhdROzrNr543fwvYrQk6upqBIFFmlfUX4W2BDzCrJf6S8CWT/2eRsWlUbSYmBWR8wGzTmoozt/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTaeiWRliC1/uvU+HKs9FNy69vTjYdjBvKny/5FSEKnGc1mm1U
	cZeATjE1oB87n2i2T/cTgPcmmcegbnPLZuPX8LcAAIHf2MdH1z9xv0Wy
X-Gm-Gg: ASbGncv2ILWg/ItgtYNCcVsJo0UujNX4O9pUda4fiPkbb3rXRB5HrVom5Ze7SIAycbG
	hcTLWQH8v8ZaW4AIuiV8Pp+dJMyLk1vlXRxPy9SXyAB/Ouq4WBFXcOEUZd+fxLPLWUlwynxG6YM
	rb6nDSamcJxZiftsMgfi2sRm97iIUdb2IsoYVoWnbRZ8PIS/jrvShInSfh2OY2c3STC8vaAZzGC
	LI98vACU57Zuq3Qurjc67S9bMt/7R81bDbajTey4E07ukZ76VJJ270jdt7D524SAqhuUT8YbDtS
	tr6yH05spp2PHpZtqio6I9yQXl6cc/uO2Q8UreS3K1BNEEkdk0wTetY/AJfZUbX7yhOn8oDimFm
	w35Ndfl0yQtoGWga++ZedRmu2RSMsv9NgnX/8XIAYpJfyfg3mBnk3ZSk03rIadru2lpPsTpPPej
	5f+tMk8g/K1omFhbYT7HPiMdxQmgGm59mJCwO/1CBumeqwAJWpNKdrk8S8YNTi1vk=
X-Google-Smtp-Source: AGHT+IESpNdOSIFJ0AvELFe2mn5VOX5nqvF9BWuKg9gD11/Sqoj1Pk/e1iUdylQepkg9PBFjDt6oNg==
X-Received: by 2002:a17:90b:2b48:b0:340:b572:3b7d with SMTP id 98e67ed59e1d1-340b5723c4fmr10683210a91.19.1762172651160;
        Mon, 03 Nov 2025 04:24:11 -0800 (PST)
Received: from DESKTOP-RD0GVCL.localdomain (124-218-195-161.cm.dynamic.apol.com.tw. [124.218.195.161])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c8b78f8sm842554a91.20.2025.11.03.04.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 04:24:10 -0800 (PST)
From: LiangCheng Wang <zaq14760@gmail.com>
To: nathan@kernel.org
Cc: jani.nikula@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] drm/tiny: pixpaper: Prevent inlining of send helpers to reduce stack usage
Date: Mon,  3 Nov 2025 20:24:04 +0800
Message-ID: <20251103122406.741-1-zaq14760@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031203446.GD2486902@ax162>
References: <20251031203446.GD2486902@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Nathan, Jani,

Thanks for the detailed explanation.

Understood — if this only happens when CONFIG_KASAN_STACK is enabled
with clang, it doesn’t look like something that needs to be addressed in
the driver itself.

Thanks everyone for helping clarify this!

Best regards,
LiangCheng

