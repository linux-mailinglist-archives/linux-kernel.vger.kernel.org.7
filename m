Return-Path: <linux-kernel+bounces-724895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 440D5AFF83C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784351C48783
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 04:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D385621D3C0;
	Thu, 10 Jul 2025 04:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4cvzIMb"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C765422331C;
	Thu, 10 Jul 2025 04:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752123043; cv=none; b=fhjIgy6Du6WE1lyFtQOUGC8yYCf2bCoyl++IMYL8rUUe0lCPHkxlbrPU+Mqt3E5FTQ5Yqt2C1DBRIY2I0Z4PiZvvA7/7gP7ROMO/7ufcwhAJMAiByH+BgZbXv3R0Zyp5wYl5FG3/799OeXbjw9wR/rTLjxb8xw8vZXOi9SBRmgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752123043; c=relaxed/simple;
	bh=nc4vZNDG2OHE21Q6Lxczi2c87J1YLsWFb2OwvQ+iHIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TciLH8/wuN+TJTAL6HkZ67jmhZ80Byg9w1c5wuuilZVYA2gk1Sq5fez7QLq99bW+ZIMFUCsB31zQ+x9GYDrPRwzip8/WaU5O83URLNzoWONe0FKdmT+1nA4Lgjk2NvXRR69XWMHPwWBtx3F2u4/1f3oRbAQKPF8GdHLPOkeWNpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4cvzIMb; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-747fba9f962so594988b3a.0;
        Wed, 09 Jul 2025 21:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752123041; x=1752727841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtylixEBzO6jEVKuJIA6FfcGiADPfp9pum3boqegUFg=;
        b=d4cvzIMbiDJU/iHOm2MJQfeIG+zFUI31f+IIcdH9FD8zk9g8uQnsEmxrMqq/zqjOb8
         uUfWFunVOZMRqMVCw2J77efZSvpe98AIT34iaw+YhNtLifpOKLZeVyrA5tQ6SUIHEX54
         DEWwzJVeO1hstP/nQbFFn5AURLf3R+HZo3QJYdsZ+tAves5KtDf4PBIWpHtvu++/AsPx
         CG74vDZQiHpufaJDboy48r60c/2ndUsHuP/xcL46WkWiUfFAzIiHwHV61hrgkuqJLCGN
         lqx8IyGmaQeGpF5ao+Tii/N6qk1GkicfZiyYXDL84M9b2iMwt1rTfHdtMm3P0bOXhFPw
         /x5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752123041; x=1752727841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtylixEBzO6jEVKuJIA6FfcGiADPfp9pum3boqegUFg=;
        b=jtyQunaDUg/n0O2uxBrM94v3r4tm6xT3FehBajwVblmIe1d2IOquD+BGhM8gOGsZjQ
         TOjQ8S5dlv9bA4iNs2TbTLfJWF9g7i8RfO56lgC38Z/2HEIivzZ2Nj+LdjPK5pAW3V8Z
         oF+Y45VQZvRpusiHEBIC4RlsD9kKSPoNo3TkDUP02HDzS4NBG4Dp7D7qIrm0gGfQrIvA
         L1FK+x3+U4Du5nI4mrNGCnghWGeq067oihs5oyEr8Zotz7j2hVU54Pyjzl0A4AhuLM3p
         vk/h8m+COBqZGFJko+Z/PlKIwI7A9kHe6ZGHX/vTwdmilsX2+iahMcyBWuYYvbFHLt69
         pbzA==
X-Forwarded-Encrypted: i=1; AJvYcCVewkYgJ9ugI42ikGlt1bNe+FWxHMF7+kJfOu7nfOo83G9yDfwaMqjlQ4Vhp4d1JFZEckzu6zcUOSpzVeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0IY8Cavplqttf0eiETpbX7Wlmv3oqklKXcj315NeL6TdEVFab
	zLU9qRTf+d1zkjfNpPzMP/mIfesIEnJYGt0mQkNkQpfapvxvjpBIbU0zoNC+STnryN4=
X-Gm-Gg: ASbGncuxVaZT++lotKLhF9XXdQPVrSooFb6dkvpntFNH2psuT6JrW6Ny95V/jiAjGxe
	AVR4/vacVsJqBPWnkVdrKNXYYbhxFO+ZoOw6be6oVUNGcE407UpJnnt2QBEEYiU3/3WRUkoh9hf
	TNcGBXhCyamRvm6fQ158knUQVW/N4kXiOMYEWvKNH2hmBh6r1wEXSNTGpYAF5IeBOPlxt/2YSdG
	ibFb5bBEQqSgevKApSRC8Swl387nGrWwGTFp7OE0vE8NpzTUf4cHvg9E8aTC8c8DZW3zPJvE3sj
	GmkRtQEB6rtEwZEgcFXresUV/xacktcfElDQaHuQ/NyOHcF6U682XmZiSIjXqg==
X-Google-Smtp-Source: AGHT+IHfDnnUa2iA/+iDRVSfbCQKkD4uhYVOacst5Po2qnE6YZro0V7CebitFaQ5OUOy24k6W92kxA==
X-Received: by 2002:a05:6a00:7595:b0:74a:cd4d:c0a6 with SMTP id d2e1a72fcca58-74eb593d16emr2726286b3a.5.1752123040554;
        Wed, 09 Jul 2025 21:50:40 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74eb9dd7341sm854848b3a.15.2025.07.09.21.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 21:50:40 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: devicetree@vger.kernel.org,
	Han Gao <rabenda.cn@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] riscv: dts: sophgo: add more sg2042 isa extension support
Date: Thu, 10 Jul 2025 12:49:47 +0800
Message-ID: <175212292372.416883.14744071473341461158.b4-ty@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1751698574.git.rabenda.cn@gmail.com>
References: <cover.1751698574.git.rabenda.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 05 Jul 2025 15:00:11 +0800, Han Gao wrote:
> Add xtheadvector & ziccrse & zfh for sg2042
> 
> Thanks,
> Han
> 

Applied to for-next, thanks!

[1/3] riscv: dts: sophgo: Add xtheadvector to the sg2042 devicetree
      https://github.com/sophgo/linux/commit/d82362d92328c5391312df3a948077f5d651b598
[2/3] riscv: dts: sophgo: add ziccrse for sg2042
      https://github.com/sophgo/linux/commit/df5b30b7feef4a643e36fac74fa0e45c1b9f105a
[3/3] riscv: dts: sophgo: add zfh for sg2042
      https://github.com/sophgo/linux/commit/3eefd8e961cea639370df96b6553a52f638e02e8

Thanks,
Inochi


