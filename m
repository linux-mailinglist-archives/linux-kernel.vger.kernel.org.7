Return-Path: <linux-kernel+bounces-809855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1934AB512D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870AC1649CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA879314A77;
	Wed, 10 Sep 2025 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lHSKzCSZ"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D603019CB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497278; cv=none; b=riS3TSYqaADn7EIW9y/N4NJIQmYLLYsQZO7Ys5jnpPk63wbXW/Fz3JXjW6Xnk2DqqZfUUKriOcTQjuI5ZDSOQZGH+4rkxwqRKPCMmha3xg8MrPKlQWcPaLlZF224BMRGjEqMHTwHNlcoOm+v5FUWJKlAlmRpCxvaKbBw+GAIXiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497278; c=relaxed/simple;
	bh=iT6a/zPgyBzTF0XoggB8KlW7bpDBsu9wFGAHxlhXv7U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Pjdc2mQw/ngr1xGUMP+t09z1Sptg9QAQK0B5rPULceYq2LslUQCe18vhzqT7b49QVVnQpIHFM71EKFDnaPoTJXu9yJ1MCe1YVzUfHd1zNA6WVNfQY7vQsSEnhAFmsy20hpDQ4dbUTqV3yO3RqU+AQMxSQJT4ymSoUcqY4bKB+2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lHSKzCSZ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6217798e8acso983017a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757497273; x=1758102073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SOuA/g/nVXdKYjh7EclBkYe4s8OIpHOm/5rpv34JIc=;
        b=lHSKzCSZoBSfplgHs2b1zbxD7ew72xpOmcWdm0omUOP7VhOk6JD8xrSK4504pKtvQK
         7BFHNwxgoN3uPVLYlJBh9TuwojPstdzFMS+Mlv8zSHSNZmtTUM+8R1z9jdE/xmJNuH0t
         JjIFlWQzwUKvqjA6e3w0l9FuNahuo33I8GpCedoU8odUAK36CQYI/pa5lNEFXUKHkb9K
         J2Gx9jr+eAY9AG/8aJbmDWM/+k0TnkBLKi8hIh7XjvibM130HrsSlmJ0riHH0pkSyqT1
         FPLMOp0M7JppOPy/x+HogbbghPr/6fyVnUeXHuyBL7ifVRnQn7MVacBEq9rgsHIuflLY
         NjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497273; x=1758102073;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SOuA/g/nVXdKYjh7EclBkYe4s8OIpHOm/5rpv34JIc=;
        b=ocG+NBlqms+BsL3fpr1ufe0xN3K7lMpBnDVUWcfCGW2upaogyhL3lDq/FlgVkEun+i
         DUZVybqIkbyMai4GOAAtn33nvq74k+S0scZqpAJPV3slZAAeAXgAFQ/RF987TV1DyIbv
         eAzGxiQBdz1bAaHx8Uz6ZwUQhLYlYam5wmHXxxymM3XJf83IaQ1Wauxlh0VK6s7gWmF3
         8ECfEL37Wro2bcCcaMhVwNY3jpLbqyNZtIJWJ0eQk+LILARzvGiyeR6rBqowMVK+JLlx
         veemeDMn5X0SSFN+gSx1jkg6IprTw8JuZEbvjAH0/vSUa/LNT0KbRIYPMGxoreUJPHHn
         p0Og==
X-Gm-Message-State: AOJu0Yx5quy4ksR0P/3SoyG1AkWRPQCL67ja0aNWBUUp0EMHX0nNC0+G
	60fIdtcIxzdhjCpxrYDbSqVPtOcHOCMFRBQw6DOgngJIh0wD+45xZu1cdr9/RZG4qm8=
X-Gm-Gg: ASbGncvGHXq2SGFsh8hioZHIXjCkO+Vd8eDEsloTPUyKpeJxdctyz6zvoy0iXHs2juW
	+qy0OzR6jLOF5tHIpOr7lLEXlk3hBo6ElpvtQaEcNtEBiuT42B0nOAwdd/KOcyIewK68w1Gppd2
	E3g81ANL+P/RauSMKiHOtADkGzzXq8JniurH45Q9OowzqzepzHCJQZUmS2jP9GzQWhs0hgxdjpa
	ECG+QOJIs6/jEJJDjLygQNrUTFJvo2zLJxLvJX3KKgdsbgD6XZmF34p1bD7V97PwNK4Ep3DD+/z
	hMxmyAqhk6MH9fGQJ8L3b0zMzpDrkVXUUvQmlqLUZUSv6sRhlwKNeO2X68QUWlviJa5MjvX/ba0
	MBhfgDOPgQ6eLBL29B4/OhNdOlZOipTezBiV0pFE=
X-Google-Smtp-Source: AGHT+IFFimeDDYyh9wXdVWxN7z2S4of6Ed5oLlealg+J5WJbf9k2XtQ+Zl7cp5trMu0jBLQkBELkhw==
X-Received: by 2002:a05:6402:325b:b0:62d:c7b9:b149 with SMTP id 4fb4d7f45d1cf-62dc7b9b348mr387259a12.2.1757497273537;
        Wed, 10 Sep 2025 02:41:13 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c01bdb7e9sm3021590a12.48.2025.09.10.02.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:41:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Osipenko <digetx@gmail.com>, 
 Aaron Kling <webgeek1234@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20250906-t210-actmon-v3-2-1403365d571e@gmail.com>
References: <20250906-t210-actmon-v3-0-1403365d571e@gmail.com>
 <20250906-t210-actmon-v3-2-1403365d571e@gmail.com>
Subject: Re: (subset) [PATCH v3 2/9] dt-bindings: memory: tegra210: emc:
 Document OPP table and interconnect
Message-Id: <175749727162.29308.12636309161261093675.b4-ty@linaro.org>
Date: Wed, 10 Sep 2025 11:41:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 06 Sep 2025 15:16:52 -0500, Aaron Kling wrote:
> These are needed for dynamic frequency scaling of the EMC controller.
> 
> 

Applied, thanks!

[2/9] dt-bindings: memory: tegra210: emc: Document OPP table and interconnect
      https://git.kernel.org/krzk/linux-mem-ctrl/c/550faad18505aac40a1551a5b467e0a63bf2d639

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


