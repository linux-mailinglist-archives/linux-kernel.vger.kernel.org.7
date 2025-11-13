Return-Path: <linux-kernel+bounces-899206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B627C57172
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A06E7343937
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3583385AB;
	Thu, 13 Nov 2025 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JS29Apz5"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7D03385A3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031794; cv=none; b=Dl53CAAy5eHOWaGnlr8f3RvivomIhABuw0+BbGz4dwNHhRBjbxAYt4B8lhupsGrztTiOH4BCucOUgZL0wJgBwSofquHuH7Nnq4sDRM62z4wFNrK+fwlG1+jjSbRsSwezr/ObnkWjriRXpxGGR3FxLQEHHnn4HW4EnHULeDb83a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031794; c=relaxed/simple;
	bh=/cKN1EDDwxjht3NnFiE/uLPr7VcrNdhZ1SW6uQPT/kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/+UWp2wy3sqrcIBhmtTeAnPfZpGwLbUQaBc/aZ6+WbP7MDyEC12pAAdfrIKcGBQ1aca9oFDwNi6LAcmiyJ5IHRFgQySNbVFY2AUNlwLftmUISv9b/78WzNY00XucDnRJO3qJTv6f4ep6P/keKL8UwzmzT45brO6Wo+ctrIIFIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JS29Apz5; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-343774bd9b4so604550a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763031791; x=1763636591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cKN1EDDwxjht3NnFiE/uLPr7VcrNdhZ1SW6uQPT/kU=;
        b=JS29Apz5OCvbP9V/BsvGKkvw9kpU9gHQWHtZiMwRVPi9POlCYmXBaignkEAlwHEJz7
         56hqd5yaBfyeKZYkhhZPYgTLSQ/NWNde0ulfzwbNv/tpfeZQI2sCxKQXo2qg/63iMM/q
         OGtTPMRkwbr2Vn353EMJcGeIyaeZXQLX20D1SebmUk/UDsSqgQj2K9I+wEr/uCXrn4NS
         mNOkynCaI3dlOrMeveT4EF3wS4acTbRX9SB84LfUlpHChb+YG5pJ57YxiiNGTqb7M3sz
         dHL3Mf4GANl3rqY8/b725OUTPSv2x7Yr7kbrfnGZEX2IwcFoddY7HiRvpz1sAqqa7JX6
         ghhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763031791; x=1763636591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/cKN1EDDwxjht3NnFiE/uLPr7VcrNdhZ1SW6uQPT/kU=;
        b=c3ImCd4epR3xHXQ51AJTvSU+JNFdJ0DuRfjfnV/vvsYQELoz86XND93JbjWNGamUfH
         +Xn4IcfGz+RtNcx9JpO9GVOHLlQip3cDnFYQtkLgaKRAYMNTlY2CRXeOmXQ86LGKaVUz
         OiHk/ltWidjyR9mTWwYA5xB113gbyyDv8CnqfwGO9TDkTK9CVVzVqIM0IoDimGuYgsob
         s+omsk676X5gMoEnz4goC+zWz+pD5cDUaivWLHGDsxo7YzLQRZKbg96xs5oqHp5p54I7
         w5/mr4ZFaqitpRWLjzwH6x3coHkoEKvGGwaawuBxoDKkZrbUYcYIGFnbPKtIg/8MMrwr
         5Bag==
X-Forwarded-Encrypted: i=1; AJvYcCUU/UkthJXdSSucsS2HQaqPsv2aqTR+GawO3sHerz8BHH6XU1GNI1nykq5nQ7wuILXWWtzbP37g1IXdK9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJSBoFZFYEbOz5usYtEUnsU6j948e9Jn6vDmR13ZRlkoGZbBU4
	4Dq+8SKyPBQ2Ql3NEHhQ46AMn56w8rW5fhVwbuD2aCIC1QjAw3raHQvp
X-Gm-Gg: ASbGncvPLrjWhRur0XpSPlHPL7I3pkCX5UfRUDp7tAlj3aiEZ+R9luIDHEgaS89jV7e
	bsOie31fqgD6wybOtQBr+iRcS4AunKYjizv8tOxrMC0wx/Lc5XRmZjEvv/Ho4KO+nGr9SBCECNs
	gHMQpiZTlM1lzkMxSfgFmiXJfYj9d8hoczQX3R+Twgnl4f1VVIHmD9ZwJExJPkIJwAcLqTyybcK
	RSAYq50JwEoe1EJ4P1E6rPITeCck+DFJ4LEVvX+ICGpv/D6okxqlgsOCYqpjj69RkrTyKxjcWOg
	pJlApCa4Xc0REFe5FIaUcLny2+jMRgPY4DXdaf2nyYxVQhUjaLMGsjZ6W2LOpfxMUzy3pltBp83
	gX5uvnsGMNoO79xcsZ4+dM4F9ciDJqtTcVxqfFe9XeYIXwBOOwG6hnfRpn3+M74DvmTCgUy0s1n
	O3YmFfR1jJ8Mn/PpHzUzOJKImX
X-Google-Smtp-Source: AGHT+IGTrsN1hzBjRmhe38pf5EQcIYNA2LTSuiXM2QFdlDo95u5VGbYJOeAKPxxp1waIKqvLyyQ7Tg==
X-Received: by 2002:a17:903:8cc:b0:298:46a9:df01 with SMTP id d9443c01a7336-2984ed23fcemr89013665ad.3.1763031791060;
        Thu, 13 Nov 2025 03:03:11 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c242003sm21657015ad.24.2025.11.13.03.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 03:03:10 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: qq570070308@gmail.com,
	riel@surriel.com
Cc: aalbersh@redhat.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alex@ghiti.fr,
	alexander.shishkin@linux.intel.com,
	andreas@gaisler.com,
	andrii@kernel.org,
	anna-maria@linutronix.de,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	baolin.wang@linux.alibaba.com,
	borntraeger@linux.ibm.com,
	bp@alien8.de,
	brauner@kernel.org,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	david@kernel.org,
	david@redhat.com,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	hpa@zytor.com,
	irogers@google.com,
	james.clark@linaro.org,
	jlayton@kernel.org,
	jolsa@kernel.org,
	juri.lelli@redhat.com,
	justinstitt@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux@armlinux.org.uk,
	lkp@intel.com,
	llvm@lists.linux.dev,
	lorenzo.stoakes@oracle.com,
	luto@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	max.kellermann@ionos.com,
	mgorman@suse.de,
	mhiramat@kernel.org,
	mingo@redhat.com,
	morbo@google.com,
	namhyung@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	nysal@linux.ibm.com,
	oleg@redhat.com,
	osalvador@suse.de,
	palmer@dabbelt.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	pjw@kernel.org,
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	segher@kernel.crashing.org,
	sforshee@kernel.org,
	sparclinux@vger.kernel.org,
	svens@linux.ibm.com,
	tglx@linutronix.de,
	thuth@redhat.com,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	will@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v3 1/3] Make enter_lazy_tlb inline on x86
Date: Thu, 13 Nov 2025 19:02:46 +0800
Message-ID: <20251113110246.57703-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251113105227.57650-2-qq570070308@gmail.com>
References: <20251113105227.57650-2-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Rik van Riel!

I fixed a build error in this patch, could you please review it again?
Link: https://lore.kernel.org/20251113105227.57650-2-qq570070308@gmail.com
Thanks!

Xie Yuanbin

