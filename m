Return-Path: <linux-kernel+bounces-842192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C895BB92E9
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 01:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18FF03BDAD3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 23:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB55D255E40;
	Sat,  4 Oct 2025 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPemoOJA"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6293E254B18
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759621836; cv=none; b=LMrqHK1kE2TB1w/Gjpv0Yq+n2M0tpKCmMHWNa+LP3y4+tzTihcXos3bQY5b+/R+OB5KblwryjU4j5VzBAnYd34JHUA6MZ1jOJQCWU33woNMaV7j3khGvGkED8+B9Cro8y2koI+nqo2+Myz+vvNh6ms9POtsueAgyqGJkZS+o0w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759621836; c=relaxed/simple;
	bh=z2ogZjxuTKMpoCR+MQb93w82gXJuW+Rka1YSqoLx4LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvYmesS04L5IVuUGF+y/j0GEcMb6aoGIz3wys/aAljd77yqwIXen8KGNnm5N68Z40fq7FfECk/gqGT08bG0vnVZwNz9zTRukv/EOsHNttUY3gE8CpTvbL5mW3zGeeKiTanMH1Vzjm4a5UaVYVDGrriR1nNnXtPmG3CdFDTv/rTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPemoOJA; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-796d68804a0so44737906d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 16:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759621833; x=1760226633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZrEnyLevXoIcXltBXj1n0pXN58lCz/lcC/iI5a2jGg=;
        b=FPemoOJAyHihAj7y/qFgGq20d3xX6mgGMln21Jd3Qp0yV+wgtHI4M2DR1/2AsAPLbm
         hFMsBpLNXg01/z5srVi2CFWrhu3lNOLPI54yGb0yUMqP10IqjFFPIMYfx4EX5suLrcRs
         YkUQpOWmrn9toPbYvwuIavPJVuXtXpMAAgjwtEAtivi3sS/xdLMZb9XBFxQ4pxEHtfhZ
         eU2tptPMhKoSg/G6UiZaM17FuKKd9VWisXtUHfqoVScn09R4hGqUIEw4RErCNV/x+4MT
         1QG72udVg+yUC27R2D+weDAE1tbSXbQigXpVOCHH1jIyUwoDTMb7S9TfAGaYiVk/SFhS
         uiog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759621833; x=1760226633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZrEnyLevXoIcXltBXj1n0pXN58lCz/lcC/iI5a2jGg=;
        b=QcZwfWFUcq0H/u4RG64ksmJUA6zTTOiIK+idyQzVh32da+k4kilR8UuxzsiOX3uHpJ
         Mh/Liz/Z6fW7g4mHTRp4wM9dVEYIbyhD1a0W0nCDtREKGEPiwOSHKs251lZozpWj9U4X
         VzqnxW1G+YigF0cz/BDzQcjVCVTM6c8gkDfwxdcJKRgxvftwYacnDyCdwqjFaNa6QER5
         3q51GYZ/m4VY7TA8nRqLW/zr1EnDaSs9H8qq755YKAbR9hgMvc94ZD5Tad7JgruXXNU5
         ixQrwKz6N6GqfwY4JeuHz8iFjQn4h3KmF25Mwwlqy6oOm6ttOT2H9S+oUCtkWnP/5J6r
         qaWw==
X-Forwarded-Encrypted: i=1; AJvYcCVD/Br52RD/c+qKvy4/Qqxu1nsqcYJwBDl37S4LeEusY3FPxAPOB3EjgVsA8SFLyVIxdJF2GpMxEEf6yag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMusYy2TWmCVv/20qUS4o4wtU1Tgqo3xUuDysbYMjCZg24gN0Z
	NR+GrFiADWadJPE59PWgJQyaRaxPdhq10oVH/RzHFrki9Y82GBFDV+7C
X-Gm-Gg: ASbGncu2xQBFGJ1IUxEINDJ+6OfV+ReTYb9thE92RcnU7nPbDu3vpoUaNHekwTuqkTF
	Egpc33TytCSfxjQJgEIgSCRIVtdlqqYjJfR/aoIvp7S6/KI4GQEEipObqsiPlSIcDp/AHx4Pmzu
	FYF0j11FZ9jIzW0F0mDDBxPHhshsoyfnrnXRICmeW+s/vy5CslgqHvhIoedMKQrs2kkXUvhXBDu
	jf8QbbXQaYG1QSvz7/a9uoouz+jAPdIn7Mv+Tl+MKFeOZWJEWIZEKAZkslDcZnHrqXP1tb83894
	EKRy04fNsEoUsDvW/CYtSx8KMOwygn0KIzH2rGYvoNly02jg/f8wzXj4uvsDQ24k2RHLVqkfclI
	4AFxbiHIlYT0X2/TiMXSSgRTLqz76seOFsehmjEen7FSfuwUhilNUskfH3MjzyuMwjbRRgXeKzx
	J/1C0mzUiO6BWkQy5nWKXVTgyKVA==
X-Google-Smtp-Source: AGHT+IEfRMsUaYJ/XAJjWbILMrV1deJg/SxAXLDq4HjDEvGxveOHDphSf6WABh59w/bzNL05Mif4ew==
X-Received: by 2002:ad4:5d69:0:b0:818:54be:2381 with SMTP id 6a1803df08f44-879dc8303d8mr89763246d6.42.1759621833194;
        Sat, 04 Oct 2025 16:50:33 -0700 (PDT)
Received: from seokw-960QHA.mynetworksettings.com ([2600:4041:4491:2000:dd54:e5ff:d4b7:cf43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bdf5383fsm76180216d6.56.2025.10.04.16.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 16:50:32 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	hca@linux.ibm.com,
	corbet@lwn.net,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	seokwoo.chung130@gmail.com
Subject: [PATCH v3 2/5] tracing: fprobe: require explicit [GROUP/]EVENT for list/wildcard
Date: Sun,  5 Oct 2025 08:46:56 +0900
Message-ID: <20251004235001.133111-3-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
References: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
---
 kernel/trace/trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b3c94fbaf002..ac0d3acc337e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5524,7 +5524,8 @@ static const char readme_msg[] =
 	"\t           r[maxactive][:[<group>/][<event>]] <place> [<args>]\n"
 #endif
 #ifdef CONFIG_FPROBE_EVENTS
-	"\t           f[:[<group>/][<event>]] <func-name>[%return] [<args>]\n"
+	"\t           f[:[<group>/][<event>]] <func-name>[:entry|:exit] [<args>]\n"
+	"\t                (single symbols still accept %return)\n"
 	"\t           t[:[<group>/][<event>]] <tracepoint> [<args>]\n"
 #endif
 #ifdef CONFIG_HIST_TRIGGERS
-- 
2.43.0


