Return-Path: <linux-kernel+bounces-766515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 684F5B24771
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4DB31881586
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B282F5460;
	Wed, 13 Aug 2025 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dzqowq6t"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9DF2F5306
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081406; cv=none; b=BPKJp0vLLwSUMPhpm/QMfC9TkfGnyGk1gUwIg6QvB39krLGPx1B0g0qQx1GE+8+bETvdbNMfv+GtQoXateAFIuk4QG/7ea7IsAl+WlQrma8PxYouLrL3XYSlUuLEmx6ojEcehQn63MdyDmdIXRLx68oiTOcY2/RH8HKJ1Nb2MvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081406; c=relaxed/simple;
	bh=Q1NhbFtp2McdwP1oX5NSBNJM1rtYXPpcXrqt1U91T0k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NQIS45g/MD5dcRvrQEurtcHbPX0HiIEuIGLywQGFlHNHBp53tK+YKTrK3rHaGjV5gOL1H/qvQfcZmdwwZD7g0SwoUXdYIDR9XmDJrqzaoCxXFSidqvdGp5ZWYfJgE65VAXfwLFgyiDOp1p5FhRC1O707EsyssV9Y5EVynxHnxUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dzqowq6t; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af95a5989a2so85282666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 03:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755081402; x=1755686202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4F86Ss5ZDMwE+bMtUpttaC71xy+/6MJqMSZw67R4Rmc=;
        b=Dzqowq6tm6k3VCdEkX2dE2Wd86TvSaNTyZ7UN+AaDziYmisppYm+C+mVURFnYNOnOy
         ZZPsaZr2ZbI5Z6inqjIcZxgeqp6mMmJvvyAazOoSUDYZNb+Bq4pcB2Z+n4irh+5A47tZ
         xaCk8vMtzqtPX69ukPvY+bt/HYpkQDmOoJsCvebftxiUGhdzUx2YHlnbF7Qeh/Xy1gUF
         2/8+MtZtEmUewkeUKGPhjAkG7ATHKRd1AHcqCtDpNV08x+HSr79Tx08uF1mUhmNeMQmn
         v3wzswax7TQQLoEsD4ZJebkzFvoo7M6Hi8aZtj5z29zUKynz6ZLLZKPIGSZS5+ZCGwqq
         6ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755081402; x=1755686202;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4F86Ss5ZDMwE+bMtUpttaC71xy+/6MJqMSZw67R4Rmc=;
        b=HtuHJxhugVKK9ux9Q6YfRkbo1eQZYuvM89EIVm+ehW2MUiVusr615/+SswmuSdKENU
         /Za2CN0Tiu7seweG+20RWOnPlgzLnucJKJxbg49j1Mb0wdeiky4x59ViBr042vUJLuNg
         DlPJg9K4VT3j0sOFEt34Hf6rXhYRHDERVYNWMa5ABCjS4xN3aGf7wFSC2uvWGgCw/1xR
         Pfa1MXUG2JvZy8YaPKhxJrZilfPQmgwuRiJoeuL7XMasN3mIOLpX6bqRUdjGL9hgzCzw
         ALCx/U1viURQ5xoZeOiTDuGGMH920UbH7vDAuMsyzrSQmWyac9jnriItQUD8cd+3oYgh
         wovA==
X-Forwarded-Encrypted: i=1; AJvYcCWWWsfW+QjwpxEQ/Dd4K4O3wZJqacTxnYfS8hKPpOmoM3lGk9SiEO69dbnUdiqm8LW3+ddn7i8FaYvMk+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YymIfyHVnOTfvd2f4yJC5sVryVi51qKOv0ebY60quHtowThM3wS
	YApQN6ymhL8CUg5PycpVAbxaBidt2O3MkwQUNRm+ydwEbTywknkHlcvMrqhuhAVMwnY=
X-Gm-Gg: ASbGncs5PNtBw9Yje/LwgAJ95vHC8bQx6+3Bw7yva6MfXkjE3AqjlHexSWp/CEiBLcu
	uu5N82VsV2NAaXpBaNyrlkhLeiK42sdHRr0ysaxtHnZBP9bnc48Fe0lXOM0sP53JPWI2cApomK6
	Jkv8Z0edvYl7BoYfttp8tUCUQGzsWVIL3GQzy8hfF6ekDSJnECiYWlmkype6jsfGcvzwKrr4Bn+
	itd8X+DjIfdIvxnyPbNu6QDud7nbqxxKztYlFrJEBFropboGvNiB5NQDL3H8jJrh+tBqK6GtpZj
	SyP9qY/IlKofnsKJmIlx7RtY90WkCPqZmvUUxXbN1TrPxbUU24VUklkWcvu62y7e82r9XPD215m
	aKguDwSAPWJwbTYDqVhtb6O2XYx7BVYbpE6R1iwczkw1aLwY/Zg==
X-Google-Smtp-Source: AGHT+IEt6eCGHIHdgJ5Hbdvmi361TPvwrKg2DTzTL0d0QkRcJbr+DkoNmxRzQ+Jj9IKe7RsN66mllQ==
X-Received: by 2002:a17:907:1c0a:b0:ae3:63fd:c3b4 with SMTP id a640c23a62f3a-afca4cff92dmr105537666b.5.1755081402373;
        Wed, 13 Aug 2025 03:36:42 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c0e7sm2367644366b.114.2025.08.13.03.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 03:36:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: linux-mips@vger.kernel.org, 
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250729205213.3392481-2-florian.fainelli@broadcom.com>
References: <20250729205213.3392481-1-florian.fainelli@broadcom.com>
 <20250729205213.3392481-2-florian.fainelli@broadcom.com>
Subject: Re: (subset) [PATCH 1/2] dt-bindings: memory: Update
 brcmstb-memc-ddr binding with older chips
Message-Id: <175508140104.40429.8279921018476182386.b4-ty@linaro.org>
Date: Wed, 13 Aug 2025 12:36:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 29 Jul 2025 13:52:12 -0700, Florian Fainelli wrote:
> The older MIPS-based chips incorporated a memory controller with the
> revision A.0.0, update the binding to list that compatible.
> 
> 

Applied, thanks!

[1/2] dt-bindings: memory: Update brcmstb-memc-ddr binding with older chips
      https://git.kernel.org/krzk/linux-mem-ctrl/c/1aba1eab0bd896928ae20dbf1f60a175a6e1ad0f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


