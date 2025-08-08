Return-Path: <linux-kernel+bounces-760329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA95B1E99F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB660A06FD8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3C0148832;
	Fri,  8 Aug 2025 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="jXaZG3tH"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45EF12CDA5
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661261; cv=none; b=CXN66Hz3QPhvs5oXP0vre3LoJEuMHFbg4I8yZHYxkuFxUiprtLymefqn+D+pjOFf1gDI+LUmDiAHD3gxAB+/cJ8/dMWCkJniN98FaZnIiY2smh00dveViMfI93YrTzaNIwRx8q1pv1sERGYfxjELV9MQHFPyZ56Nbf3oCMLICGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661261; c=relaxed/simple;
	bh=jzUwRFYMwe0kkKb7Wpg8iUyhHURaS0YrhVvgitXw+xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mn/d0ZVK5+o9ATmaOI49fWhpVjqddeqSxFB9Fsuufl+kCge4SUt53/tzgZcVO+pHuw3RKxkMmCHU6R7CbGSiaCVKThnXYa+bVQV59WrPpHxDV8K4uA1iC6ebaYFSWwnAstnO6s97Ut1tLtEVNXOhizoPF2z2YWfJcygh1ZbvP2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=jXaZG3tH; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b0a13bb0b7so23950971cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754661258; x=1755266058; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jzUwRFYMwe0kkKb7Wpg8iUyhHURaS0YrhVvgitXw+xk=;
        b=jXaZG3tH1PMRB0OKnWtxvsHd1Rk10dwuOCEgRiZ5YbCBqxQQTw+Jz5KwUYNcNChoWY
         xf4WD9V/Y23gBJQiJEVrIPi03TQslgT5miGCO0uzvGNjvtW1WMcFKZt2vM+ip1npFZHS
         /7IqrN1uq38jyr+pHzz6F7KmXrCR7uYxwubanh4J6jGtp8ZBw4vJyUsbiEMcKnqocg4O
         18KlT40DuLg1Ls3E1ao8KTRLE2eyQAhs2Ug1pzUcsExdnM2/sloRo03ahg2PY6lKrGv1
         kvN898/zDWHpxKrb1Q4s38J4C2/MMk5prFbc22KsrleozyUhtwxKMRqLQEHRQy/mrOab
         uzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754661258; x=1755266058;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzUwRFYMwe0kkKb7Wpg8iUyhHURaS0YrhVvgitXw+xk=;
        b=PbPmtWtM+gLNCGxrDDKHtikfbEZFqLw9v3vya4AXLKK+Gz2ot+pPkkSnV0PRcR3ymD
         w5uwN/LVkaM54cY66WugW0MX+uznFO0mBd11QfoQOiRRgl9TOJEmi4JXe0pgyYvf+BaR
         2zMbh5TFdzjmRaktd6puZBFzdbJhnEa2l07MFkbs0wPrcfdXkhMcjVmLnCQW+phrp6zR
         z1QjpoihC7rUCNtLyC78KHNBgf4T7oadNDAvSpCFF5AtpX1gQk3yPv0LdyFVDg9AvmYE
         sAP0oQten8bb8cy7BHpXdIoheL3gR2JTkc1ULYrsSYnvbW3QGnVs08wjMlYXjPltnlc1
         xoIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBCZ52y3oWJcX6yee4O5s0HPyrKh+rEFFFhTL4JjZyAtMAUc133wpALTq4oIn7m50RM9vqdcgzXiMeQHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlZ8782LDeDLbZi5kjYXTLM/5MwqGz14xd1MT+EXitQ/GUBeYh
	MpgDyIHOUsFKdMheh9/7ll4fbP7lbKoyQTYbbPUpoLIeYAJLJyqo1KP0Ek6Boq5RiEH/9tWhaaR
	5Vx1scq3g/JNUCdv6UxN3ZX6YsVROKAI+heSCmk8PPw==
X-Gm-Gg: ASbGncu/LALO4UbhQfeVI0ygqakdXXwao5DW6JmSANDpUFk2MfitTfFbYQ+aCKBkDgl
	wp2t0vKgbMN0iIZfAPvyN5Y/KFWfTkkdp+Udj5dVLvCLcyesi68F3jpgz4m/srvl9IgAgDtPSCN
	aLHYft1plFRqdXZtV+OSeqNMq7mGlYZtwUbT24k7oo1L51OoaXM3XDf7SakVqaN8AqysSjsIoJ1
	tGq
X-Google-Smtp-Source: AGHT+IEJmYietSH5VpR6RMJMP415b7zyz18sRNUfhN29PGY7yEn2BPdHDpMV3lyr863RZFGEM9NfgFIb4ZTkLRTpI/s=
X-Received: by 2002:a05:622a:1181:b0:4b0:7620:7351 with SMTP id
 d75a77b69052e-4b0aed29dfemr44241331cf.13.1754661258448; Fri, 08 Aug 2025
 06:54:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <b227482a-31ec-4c92-a856-bd19f72217b7@redhat.com> <mafs07bzeatmf.fsf@kernel.org>
In-Reply-To: <mafs07bzeatmf.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 8 Aug 2025 13:53:41 +0000
X-Gm-Features: Ac12FXzC2ItcrNrnqIm-RSLWTwNqS2AX71-Cg7eUT1NgfRdHm0ajR1sU163K8_s
Message-ID: <CA+CK2bCd9x0KA=cO8EauJ=_GJ-GzO+0Z7HXN5=cObxuGzFDzCA@mail.gmail.com>
Subject: Re: [PATCH v3 00/30] Live Update Orchestrator
To: Pratyush Yadav <pratyush@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, joel.granados@kernel.org, 
	rostedt@goodmis.org, anna.schumaker@oracle.com, song@kernel.org, 
	zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

>
> And now that I think about it, I suppose patch 29 should also add
> memfd_luo.c under the SHMEM MAINTAINERS entry.

Right, let's update this in the next revision.

Thanks,
Pasha

