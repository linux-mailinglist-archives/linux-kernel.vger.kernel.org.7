Return-Path: <linux-kernel+bounces-891042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E5BC41ADA
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 22:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B905350C46
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 21:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9E130DD37;
	Fri,  7 Nov 2025 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="KlrOE5Ab"
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD577276058
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549543; cv=none; b=RtcawdNLG12VceZsgP9/AaLc9R9bP7EkyucK1teGMv7kKlBAga3qCl+QIqY+69vw2+MtTaU1Zs3kZ+JwMmot3jN1pwswVawvpz+uTS2suTzJbMxo0Ss6G5ySqbbKzWXhM+vATHKg9KkkgzPTTB9BKe01FISdsuKLv+PwvqHfqTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549543; c=relaxed/simple;
	bh=2AXBG/P4zHHPE991SiFKrlF/2yl4Orgmw9rox7i8sZA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzrRGYRuKRMS8ZAmna8LRbB3JSNIiz75oKkr2Ym5haT+vECqhDKN07zBwidYNgc7TpWQs4ib+4Xzkt7l5Lv9EXx3reFryKT1Obadac/G1Rxk3gClFuV4nFBcwKgnJB7lv0nqsoC03ZMgkADyzaKhBpxdr6tvevDBdVH2z4q78fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=KlrOE5Ab; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-640d43060d2so186983d50.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 13:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762549540; x=1763154340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eG3KZj/IJ+feH5LNOQCm1I/xQEDt38CQ/0swaPI9wVw=;
        b=KlrOE5AbYBpsv4e2mhXSJRLmPj6kQUoPp8bfWosYQg1KcuemMvi+VqHr20Gs6IG7Np
         tROfxZpQI8C+VW3/ojJiRzQyNKxTV/977xFgNnfJyA2MQk2dvdlDF+TsDsYh6V77UJEc
         9OClbSPa4kE5JnGEDErFu+/uMY1tr902iyYZbMbRH7aNvGHIyAtIrwFU+3T5aSrUJsMB
         NppOm/UVb8f35QJA/XMDdnOe2yxintuvRrqY6dNvJLbkL4wkXpNqLAb59ZQehESpSCaZ
         CbvGZi3IC0cBOuESBiMXnkUAnGXCPp9eRvXeMC9NLQGPwY+y/ecIm6uohrUxkLeacJPJ
         c07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762549540; x=1763154340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eG3KZj/IJ+feH5LNOQCm1I/xQEDt38CQ/0swaPI9wVw=;
        b=o27Ldjvor3fHhGKmYLl3nhyHlEEtSy37Ufh0lrtYC4pvmdP1Kv6aFnhrdFyoiJ/IGd
         sPPpne3cvmcsUDdPfwNraldB5JJf+jMkcFTLhp+UF73rDn7C4kQ6vhVXDK4XAQXf2MnT
         K+C0DwQfWAPK6/42XrrbWlzSIWflluPxScffhe4aQxEfwkS5OexEyh3FntYIEPm33B92
         G5pZD30HXm/H00xicqSaoyEJHXhno3ewQy/3kwtUPJKZjmHfeK1DwP+12i1y/qVnMRkM
         YLVIUayWIhfFhVfS6UAi7nqwAN4oRuIIrq2X3IIpk4CwbiOCXE1CAnh6fCIX3cjojh1I
         Sc2A==
X-Forwarded-Encrypted: i=1; AJvYcCUCyPPit7haO3t063OdqHKvNTnq92A7g50Ua07CWNhRHdD7rb9OlpmU9r/MO4lk1hK7w2pNUfss9hkWVYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhokNB+oYS4yd3SZiANdYROJFGgxoGT2SArVuiqnfOLcqgWabG
	NPBvi4531mAMfF6ZWqEcOTmGRvAKFkpq1LilbFiO9688uB2jG9Yq5Hj2FJd9y2OKXy8=
X-Gm-Gg: ASbGncs6khyXXCvKvxhzkLtMBcX2YRi5w6HWxta/fD+butXrUfnq6Ahfwgi5GbY/eGR
	pnn8jwfXGlcnzK+q4npRNHoAZQdjUiGYBOvsJfCr49RB8Scw4D0d+UBm5CbCWDUjscBlZZJs8Z6
	ohVb0PONn2BWCrdTMmlvftKpcFGZ6I+ftnBVvi7giIZXNWMRMQGd8hdmY6UYkYB2E85S4NcQOBL
	HCVzkRzzw3EHFrvAkfqWj+I4R4ANBThYdfPI7rxWvhypHlXwTM/pf0ULn8XGnW+JvXRR1k4lDNU
	K1ILjkbqzjmcci/C53tMo9bQ1afJnmQl75UQc/zeQIjUv5s3mTe6cUKt6Wo1Mq9VnQTyqTn8TQJ
	sk32/zYcIqt7ThUD7X+U3vjzVBnBo0q1a6kLzB3wXxmo8Q6pufS2OplywUZP4uMwy+7E7hO/VW9
	Eh3kPfze6rHmtUksoXQHgPDwjB4krIFf9Xq2U8v4Ra7bmF/Kh1k+BXdWWpMOGx2SQ=
X-Google-Smtp-Source: AGHT+IGgi833lso4oL9ECYqCcFQNiRqXoYUWKz1MoKHjJMaptGXdg+WJ5uxd88A3KFV7TB/Wv9G8Zg==
X-Received: by 2002:a05:690e:431b:b0:63f:a524:1f93 with SMTP id 956f58d0204a3-640d45ff3e1mr344048d50.68.1762549539784;
        Fri, 07 Nov 2025 13:05:39 -0800 (PST)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d68754d3sm990817b3.26.2025.11.07.13.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:05:39 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org
Subject: [PATCH v5 04/22] liveupdate: Kconfig: Make debugfs optional
Date: Fri,  7 Nov 2025 16:03:02 -0500
Message-ID: <20251107210526.257742-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251107210526.257742-1-pasha.tatashin@soleen.com>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, that LUO can drive KHO state internally, the debugfs API became
optional, so remove the default config.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index e1fdcf7f57f3..054f6375a7af 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -54,7 +54,6 @@ config KEXEC_HANDOVER_DEBUG
 
 config KEXEC_HANDOVER_DEBUGFS
 	bool "kexec handover debugfs interface"
-	default KEXEC_HANDOVER
 	depends on KEXEC_HANDOVER
 	select DEBUG_FS
 	help
-- 
2.51.2.1041.gc1ab5b90ca-goog


