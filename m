Return-Path: <linux-kernel+bounces-893533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1E6C47D45
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815DF3BDF63
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C87C26FA77;
	Mon, 10 Nov 2025 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkRT/c49"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C72126AA94
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789421; cv=none; b=kEG/PVPzDE+YfJR1iPhMhmuAl6nf2FYWtijpMWTcEoo6XDxjlH5ceLBEae3rO6xu2upuny1re6vvqJ/rHEDNZ4iidZYDlxKALjLdrb3/UCbpzKtBfXpn4kg4YWNEoBYf+wKh6ra7MxgAK/9vN3i/H3izw83OJgIiSkc8okQlBLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789421; c=relaxed/simple;
	bh=lJGQMZvZZc4KMFQn1KPcnjNaqLnQgvkqHDsdmDw6EPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgjKKThP5qxbDB1kOiU8j6F7GrV3Vj145vwx1xAnNDY25KdltT7RdwYssD8orsb378DsMiaxtvsgOkCvSEYjFK5C8RgakhL9XxCgixh76KKl+yiawrwLXCONO4sUW6G5E3ZEoeHK4UjRmf9HX/Kc2ntOJ3Z9mLieA9/f/kB0Ohc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkRT/c49; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29808a9a96aso13112255ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762789419; x=1763394219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLAK+1utwDQJnW79jqnXsBU1gEdDxofO6NOCNqDBYAA=;
        b=mkRT/c49ATaJmYRGOCcdSx3Rr7VjO5+jPdDXtzpbvc9iY4QftAbWyBGfpLQPl5pIBX
         sJzAiuV0qbShW417k65mSybcc6F/0IXDieBkSkNBSdrhZh9gMQN1LdLhl3glO+pTUIht
         sg4wQMkRDFrE20VfmXUsqh2up7ZYEYWPu/CD8yPSQAaWQoHcPn5RN3Ay0C8ZdCTS1w7D
         5OIOVabfYLAVjeqmx9hsVGIQR13zqF9S8qOjvGlQfN4wiujfgZ4i85fvYEP/ipOZZZdL
         8x6pQxTkYFBgfnLIppUtxXOmxlIS6kfVe1xpoAHAwIQEShLDf9MFJhDCojb/hVO7zJTC
         dTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762789419; x=1763394219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gLAK+1utwDQJnW79jqnXsBU1gEdDxofO6NOCNqDBYAA=;
        b=Rj5+UXMtxNCSNtoEpLAANo2V7SjPfe7IY9Z5AiDVE+EGBmj5OmzJeJcwvpDONax7ab
         605HG/pp6Z7kgjmnuIqtU2mqM4XodujMPZn3SVztlnQ+ct4hSnoFBtlLHQLR+zS719U6
         SA0hlJ4zk1rgyRiXLzgPa0qPDDaZyBx5iJJQN5irAdlllTVaasF0Pba1AuowqAKygIGX
         xYaKQ5Fu43e10Yv0D2/ZibkIHG54td4ABJ2ZqdWo+i/hMVZDLtpqj3El5L0z7AJxTxJl
         5FjfPLQuxWyVfu6kOdZPTNBfQljIAtmWWAhLQUNrlYC93VkIoCh1TdwNpE08TIP8We2B
         lgbg==
X-Forwarded-Encrypted: i=1; AJvYcCXuhOfxWM4+8Qe6gBsbXib5Oc6pwLMpA+COipTjdRwbfruCCD/+KYu8KfTeuKaRpBqHYk1VApJR+YWVh3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy6zvN28U9jtLrAwM6U9iRFFDqisQO/T498wFqssZcPYuN6qfO
	CsJdPVsjUDB1MIPY4VJ0RMnpQ7h/QVfOQf/oWj4c9sv8pLlJ2ZPURbzM
X-Gm-Gg: ASbGncsYUW+mL+YtjmwSeN+2kt3Wp+EDk1GzsS0eaA1dP7oSW/NasyS8+wEr9o/Th9O
	+lStwns7v16R/3o7/M7j0oaDSwcuhE207+A6PYrWOQHT0tpuH9eLezjPFX+N/SLoqaI6fbVSZqX
	ZeLoyzuCfNQg4In54pfWenu81q1zULGKts1UIVzqrtqjmyp9mzFMeQkhpEd9u7fDMOKLiGJ1vK/
	TMbpxe5erjurWSMwyvuMhMBn790FjTsNylrlNA/IdPBdEwmkQm7Xg6pFZJ41n8pUhbU2c2UnOk5
	kEyhV6OTSkl/JqKtHKms6h2jvPMCTCtUFnKz/UomMhFx+P8RNZiR6sdpLgjpqd4ONGgoVp8eQt9
	X4anQfMlwW3xgW7DTrr65xXWgaciq3mxGpJtd8eg/FsO33lddmqKC4DVpIyCDJrsGcbiM9TcsKZ
	tfmdMgciVKcoy/AQeWCzxaz0OpYjNdau5D9eA=
X-Google-Smtp-Source: AGHT+IFhicyH9W7Mg5DiwE8MVpN4/er0oaakdgICmjAbGBgQnJD5pAHwQ51RtSmFFQvyQKJ0R4B9cg==
X-Received: by 2002:a17:902:ea09:b0:269:ed31:6c50 with SMTP id d9443c01a7336-297e5408bbdmr106752805ad.10.1762789419238;
        Mon, 10 Nov 2025 07:43:39 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297d6859a92sm101566725ad.88.2025.11.10.07.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:43:38 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: arnd@arndb.de,
	david@redhat.com,
	tglx@linutronix.de,
	segher@kernel.crashing.org,
	riel@surriel.com,
	peterz@infradead.org,
	linux@armlinux.org.uk,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	qq570070308@gmail.com,
	thuth@redhat.com,
	brauner@kernel.org,
	jlayton@kernel.org,
	aalbersh@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	max.kellermann@ionos.com,
	ryan.roberts@arm.com,
	nysal@linux.ibm.com,
	urezki@gmail.com
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev,
	will@kernel.org
Subject: Re: [PATCH v2 3/4] Provide the always inline version of some functions
Date: Mon, 10 Nov 2025 23:43:01 +0800
Message-ID: <20251110154301.1930-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <a034a57e-d9f1-4c56-87f0-e9126246849d@app.fastmail.com>
References: <a034a57e-d9f1-4c56-87f0-e9126246849d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 09 Nov 2025 18:35:23 +0100, Arnd Bergmann wrote:
> You can mark the caller as __attribute__((flatten)) to force all
> functions to be inlined into that one if possible. I don't know
> if that would be helpful or desired here though.
Thanks, you made me aware of this attribute for the first time, it is
really a great attribute, and it has been already added to the kernel
public header. However, it's rarely used in the kernel, which I really
think is a pity.

Perhaps, I can try adding this attribute to some hot functions in
another patch. For this patch, I think this is sufficient. There are some
cold if branches inside `__schedule`, __flatten will inline the function
calls in this part of the code, which may cause some unexpected
performance degradation.

>     Arnd

Xie Yuanbin

