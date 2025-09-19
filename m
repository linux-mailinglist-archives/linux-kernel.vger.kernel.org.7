Return-Path: <linux-kernel+bounces-824204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8BAB8860C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3631C1BC7DEE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2650D2EAD09;
	Fri, 19 Sep 2025 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cMibZPm2"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EB92E7162
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269889; cv=none; b=OhGXnxDUgiTMF4BIPOqskqCsVyGFkS1IVSbXXYQicgY62UOvjyHts6cyBKbEpbUZ/sEIPc9RNJoW2Zgt1hq1xaOudadn2QE25NCcGDD9BCDNPibE/7S2LfXrFVxRdNcU0tDKinnhNY65v+yJ77jDqDxSc9/PvSaBz/8qCRX/ET8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269889; c=relaxed/simple;
	bh=DyMqZzpbMkJgkEnGSTyBtxfZ+e/F+bKP3TSdsbcQBe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czbkcDpPX96thDfazwlUMhVdPK4ADj7n9iHtP36Cu6lcmwsRS7L39gddsJQNY0w0SQjjlXza44kzLQnPLzq5gXpzpbJu2rACDLV7UnsbvdGR0oanVByF5bFeKocVhaJshihZErbLZOoE/FvjHQSkdN0E8riIzUc4t8qq7yDL3F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cMibZPm2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so12251265e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758269886; x=1758874686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5o43K7Y0uvDLyzASUv52fl9L82q3PGfkNuSA+w+tp4k=;
        b=cMibZPm2CrHmhNmC3Rwd+2SdeLKp2fBzLJ1RSvd58XZ6JDdxbtd7Jl4ijVrFvRHROM
         wfS0R5BDcJ5bFaAJLSVr+EPUkDSagLgiaxzolMicHN7dP9Z+9TyKCcmkXg9v6dEOLHZP
         udD0+BSMZW7MFUQz1m/VsQjCn4hdlmHh7XOIbLraWXlUNWYZxq0VXb13S1TSjUJjCXyQ
         ZvZfnpwiym2tlPY2JKUbYcfG52uKGk+cOUVnkwfFjhDc/g7CZnc0jQu361m3eXBfHi/H
         +HTNZcjyBFivxCMNFnraon2nMzXueQrNeKS4Dv3wG22MRh282K3U+4Rsvt8dEe4qszDJ
         CpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758269886; x=1758874686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5o43K7Y0uvDLyzASUv52fl9L82q3PGfkNuSA+w+tp4k=;
        b=Ji7rXOMkhzCXv8C5A+849e0zNwY4m033b4b8WHUQ77w9N5KDqiNq1F8fs+F+s4bVWo
         DQKlnb4R3XYsI0PyCJ4d2lPmyanx1cy9gOGYjs1d9x0CpHXoHJ+kbH6j/FcOUfycrKKC
         QoZKYT2weQu5s1nIqJy05g4Leoocl2m65DWfVoQalzsG44K/G4iRhK4zgugwAmUcqrEc
         OHPh5k5308tpsRflN4u9h1MDFuN6FQStJvR4Tm6B6auHfJXiEZgEFMqAhu40j2E8WELP
         BNzXBUre6fpJT4D3Nlwd9PE5y2Ubzqi7VH60vhu0wijQOwJhmS2k1gUsPEx6mhVnknYk
         UTLw==
X-Forwarded-Encrypted: i=1; AJvYcCU1C8uD1MNLVq/h75elP3ZH5KOGHJEJt16hks4ADQEWbapf5xKISInv/Tp+rfYfxUVMJBUpeCrJorze40s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb8STIbQO1SSLio20DxK22nEbY/nm3sQWzXXdfdoa9bRpZ12u2
	ejBijOfcC5rmDMBMhjooeSWbyVUIMxxFJ1SSWTzafcNPX1qFv8LEnWNBjNsU3bbjNPrECfbQpgb
	XjiD2
X-Gm-Gg: ASbGnctMEV+aEjBG/qnlC5ffeIhBYcAc2qbuT3Le2mlYgav+lst8ep+y+cbFM9EhBFj
	mdpq6NVqQdqk6xXF2lZNzu9yBiErk/io7cNvPPS3B7mjct0VsIT8CSqWs5/EpAh6gE4kY0Mbo2w
	IjYasRCJDjgst2pXtRvyHlhuCTjpE24DSsHwskurzCqjb5QAbWOolydQDRzNaOwcmEG9tNH2FPN
	u9sWKC6INmt0egflNv0E7aqavgKugqhfDSQXGrcmu+LsVgKcO4hN/NO/AYn1aSafZYaKOtC9SQh
	cgc17nLjKNXssHNWpEoWsOEaJ6Iycy7n41Yz1+tcXna+scqWC8CU7lKZ8Ql6TlMpaa6C+jQuE/U
	zZQhzFboP8o/9Az3QazHxsM/yMeVXuzbuKnkW8zM9Ito=
X-Google-Smtp-Source: AGHT+IG9IXvO0ORWH5ghDWSBVfrFKgK8sq0GS7GYB45OO3lu5+7LJG+GncUqXyvk6ZUL/55POHIftg==
X-Received: by 2002:a05:600c:1c05:b0:459:e025:8c40 with SMTP id 5b1f17b1804b1-4684c13ec71mr17359215e9.10.1758269885811;
        Fri, 19 Sep 2025 01:18:05 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f4f9f4e4sm85674225e9.13.2025.09.19.01.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 01:18:05 -0700 (PDT)
Message-ID: <679c0f5a-bf19-45c6-b28f-b89fe9c44e66@suse.com>
Date: Fri, 19 Sep 2025 10:18:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] module: replace use of system_wq with
 system_dfl_wq
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
References: <20250918085525.122429-1-marco.crivellari@suse.com>
 <20250918085525.122429-2-marco.crivellari@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250918085525.122429-2-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 10:55 AM, Marco Crivellari wrote:
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistentcy cannot be addressed without refactoring the API.
> 
> This specific patch replace system_wq with system_dfl_wq, the new unbound
> workqueue, because the users does not benefit from a per-cpu wq.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr

