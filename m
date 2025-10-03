Return-Path: <linux-kernel+bounces-841505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E46E2BB78B7
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180EF19E8541
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213A82C21F5;
	Fri,  3 Oct 2025 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isZ7v06G"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9AE2C0293
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759508844; cv=none; b=nwj6lO1iPjoz/1Ncd2jDGsbjGt+uL1U+czr9OkpJZxYa2nx0jCV0z0eHv3O5Y8dpbkZC/IXbvDxnq14Msz6laWiZ5T5eSlJ8WKugVYLiEXOaBPFCXHhrKtT3zk7s5XigB5/U+mskJZnfYmo44CNRo/bzO7RubTSihlJVgZrVJoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759508844; c=relaxed/simple;
	bh=jdDLR5zSZaMeP6Z0Smw6SGxBy/T6QQ6s+tHgLG/YIuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rmvp8uli7PkK/Be4VIdreApqwDOcphvNRP7kXdtOaoBmlBJP+ioOSOglY5WrWJZITco5Foe9uATqo8wnDg5Prke0ckeG6tAneiCRG4K6UPdzzlE6svDc5MA2N5q3RDw57g0Mo3yoea14TJi38xSqg8JSA2YH2kmdvIyqznAQ2+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isZ7v06G; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3324fdfd54cso3000582a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759508842; x=1760113642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EqyC5t2SrD/bODU9RpzzMMs5DHytzZzsB47Ks78jSw=;
        b=isZ7v06GV3IAapqB4JuCfP/O6ID8r4cGyOPCIbdoAbtFA541BonkAusnvoVprm8U1K
         e6tQMKF7dTsZ7aP/lVubunVjT3R1Br7fw97smYENFT6Iv4gTsy1WX/Y5a2wx+Ep0kicv
         2aSgMPXjim1/Ls9fl+ZgVqqk+IjztFpxRh2iDnH+enMi5RY0jxI6WKXy0KZ0U2WU1kDb
         NC/+WpvKqBG+nB37vtQVRrvNYlTUisM7JTYXFAxEUh6iCXsbAPz3IAMu5UdR5OjbZpVU
         z9it6SocWwgA5XkSRkd2cHSI4ClTAaKiZedGSVvUUjKCKMQACfYWEnDo5I7vr6iA+9v+
         N8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759508842; x=1760113642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EqyC5t2SrD/bODU9RpzzMMs5DHytzZzsB47Ks78jSw=;
        b=txMYh+C+lT5FI8yx+E8g+RUqZN52A/xbgjYTte7I3DLIJTuunuq5D6Wyv/y6RDeb/S
         bNS824TVjHOg9onYh97GU9NObON221guaS8TR3mKsuOL8JbbPQCitIhCRV+VRR7hqt17
         TJoDeSs5XtZ+b6rHYHbjr1VaDEatVPsNK8FQJ04i8TR0nKonuNVSqNc3XwqWEWm/X0nd
         ceRi2i+0Ylwr9Vk/zbkqnnqV8aJlgqzxVFi/YjvXksKJheXCFyi+glN00pAcanjtuW6c
         8ZPlFH5SPjQBL58Q2knQFM/zpWsgEejMl3U37Y2QD6flRQYAuCExx3CGrXGyXvKYtW7V
         9Gdg==
X-Forwarded-Encrypted: i=1; AJvYcCWAGP4vvWzAVYqoZEK9AK6BHFWRtssz6hbZGO3Sq+gRwe04HEnDfzdp2xbgVIwPgypwAsyHZ8q3nlLIbDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YygE40n53aUhMTLb347R99aZnCRYGCOPgewxMzv/QNas1LUpxxF
	4R9CYFBU66jQWVxVacO0aiHN4cKHdk9NNAO9oTNDXtDTfjy3+mpxlUYd
X-Gm-Gg: ASbGncsdsR31dbzwj0ZagJsY1nJBkbdfBtGz8vtMfE2avzgLGuaccT3XKTNK3/LCBHH
	fGkSBzKJrRk6hBY5I/RD+Gs8mf2y0UTU09zBDgqRDdl4w8abY7pv+SpPDiUvLKDWlJrJH1cfQw1
	39Ls2GMLKGILmjjWvz4oAKDsBUPlty5M0EzetO6Lg3H2c/j340uUI116swtFEY8Eb600fDSwUbE
	BF8nhJRIGjxQHS8GMcp+ZIb1NPOnowMrziNBXePz/6e91/4CBYPSuP7TFPpz9sY2chzTBWveAK2
	mmzIAl6qdfP8pbDR8WNaGKYC2/Q6z2Vi9kNQJhHCP1qjl98kLSfZzFTI0RhUPM0a8rf3iykhKqI
	+SCVodnIX6CrMzSP5xJNXodjJURstaduqLDscxIf180+wUQk7XG9k7P8+R3lnFvfb1A==
X-Google-Smtp-Source: AGHT+IG2rNSUruY8DM1klEXzzCzW/OV+wycqjmFkUs0EoVxuzcjtow/eEbQKdm/Kq0yZONOSJQEGTQ==
X-Received: by 2002:a17:90b:1802:b0:32e:7270:94a4 with SMTP id 98e67ed59e1d1-339c271ebd5mr4418563a91.14.1759508842185;
        Fri, 03 Oct 2025 09:27:22 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ff0dddsm8416787a91.18.2025.10.03.09.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 09:27:21 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: 2023002089@link.tyut.edu.cn,
	corbet@lwn.net,
	rafael.j.wysocki@intel.com,
	superm1@kernel.org,
	viresh.kumar@linaro.org,
	qyousef@layalina.io,
	zhanjie9@hisilicon.com
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org
Subject: [PATCH 2/2] docs/zh_TW: Fix malformed table
Date: Fri,  3 Oct 2025 21:56:11 +0530
Message-ID: <20251003162626.6737-3-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003162626.6737-1-krishnagopi487@gmail.com>
References: <20251003162626.6737-1-krishnagopi487@gmail.com>
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


