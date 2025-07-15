Return-Path: <linux-kernel+bounces-731536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7BBB055DD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DCD13AEB3F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5452D5424;
	Tue, 15 Jul 2025 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPWAEyub"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A444F2D4B65
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570440; cv=none; b=CXivGRtZ531WzY+R32zitChb+NESkuXFgaxqT82XGMx3lPekaIbmdBqeA0i/CgIhA39qYrZjFIANL3LiTNHBUbeS9oS65iqVeJAWFQT78dZ0HNAsmmLtAsa++FzfyWxeqIeh1k52vGDZFYhPVh60IfIGhMB/qTcXwoKPzZQn6gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570440; c=relaxed/simple;
	bh=u4cIZFO83VljSE2CK6puYeLZeKZBQrk64PpIwLyG+3s=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Wtv3QCylI1FMwlmVPTI3yBRJ4v484Du1C0xi9ZEHdn/i6ijW8RTZU9pRXcb8G0NWcGGZJ2P+kmY7JlAWmY80jiqJiqmpJvRQ1ah+QkMhvcRR+9ZNTP36NhBErXikHW9jB3u3aFi7rkSl4IHaBGK3DVmiAqCHG6hUp3xOGuC6di0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mPWAEyub; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6089c0d376eso925100a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752570436; x=1753175236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdjGXEPbwx9d8dagmoP3TN3Sha6+88f/yNQTLVRWULs=;
        b=mPWAEyubegUeZxpl7HoJXWyzgE11N9wJ3DcattfGEmW5fqIvNWOriBfWPQDIjqgK2x
         NJGkcf+AXHM5w914sfELEoWd+R6Tft1aYmGdUaIn+hEPC8BbsiB70lTuytgoMKFK1GUd
         te4+16y+D08vhjArRdbXPSv12TTVriST2wKCs1UYVJ47g6sCXtxnrnLrDIi+5PRPNmtA
         IDKECc9cJr0g3yHN7+wylPjf9rm1rxJUoMOxKopaBbXEWCz6EunKVkMUvMUqdYI3IcvO
         YuRAkECcVL35nAbd658V8D6c8tr2No72j2mJQd9MaWZLpYwNqb14pXnuJBrwD+BUvmJ4
         Hd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752570436; x=1753175236;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdjGXEPbwx9d8dagmoP3TN3Sha6+88f/yNQTLVRWULs=;
        b=EyRkPybt3kSPHp/EUrPz7Vrph8Zu1wAOwimfGO+5bJV1I3EZXZ0Oit1D2yWBnefLHg
         0WAniHoo87nbtIlqDIPLnaya6g+X8ISO7ZceIRNwY9IStX+OzdpVORbctUbUT329vhuq
         /18/ji2ZwnOGk2YYSVi67sjifMdyEle+MKF7LcnErDKoYdhLVO5I1jMHjEwcN8bl2FoC
         LwrCxODsCpYJH+U4rsTYXOsXUbXgQumhDhhaU+47c8ZOjzU3/wTkEscGm1LIYRgGWwxP
         aBs2fHo1EaMm9Lag3nqz9xyZK/jFla/KR62NPMF/7s3dz+BDscjDNPWFsH+swt76yZJB
         5dWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4FWxMhO90bFEK7Ho6cl8XU90iMV+uoGLdGLgvKp0wtoVgicA0RuJbyMgUC/ZHsWdBzkPAGMoHfkwC+xU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2gP53KFT/bMphD1MEuob9M85sUXGrVpshCOKcLpcZ3pNfV4UL
	8cw0byJ0o6i+8RrzY/k4A6JFZTXrpmyGeomY9JYn6SULRExHylXRGggJqHDzumYUk0SSK0cdV0l
	yncYB
X-Gm-Gg: ASbGncs22ghLGFiBRJ/O6tB3b0VmgjCYW1DgK9pYtdqcw9PWVB8m7krQSm4sSvZrCi0
	WgCZMUu3VX+VDT8Tk43/u18FwEg7+jwPEjtdLjQypBWHCMXDhaoyn+E6ZakNEBUQGvodZtrZ/Rg
	AJXzAhXbA+8N6MYLOhVbiRRDODbJkeedghIpLC+2yaN3hXEepewpNPVt6mlnA8PdER5c+XWNWYS
	zzby6QtBswKGdzhAgOlnYDJKE3GTLgSZEg3QbRQ7bT91Fj1pWGrr+opx9SJGA6k5jMwA6dEN0p4
	rV19wc//9JDQlvk3j3jcnWjliwnGTNHCgDlGl2dAB8wqCV+jrYaesoX22Ui/QQ1wvT69PzIjU7Z
	PFPsvT+yWoS0IbumafayaBxEgzYXtm29/BQok
X-Google-Smtp-Source: AGHT+IG7sF7KS0pmEBtE7CyUxnRi/W3VS/BOjQxGcy53ccUO5o7hMkUXG853x5EsNRJefAyaqN5s2A==
X-Received: by 2002:a17:907:84a:b0:adb:2d38:4479 with SMTP id a640c23a62f3a-ae9be9f6375mr34796166b.10.1752570436431;
        Tue, 15 Jul 2025 02:07:16 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee459asm988001966b.52.2025.07.15.02.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:07:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250710073443.13788-3-krzysztof.kozlowski@linaro.org>
References: <20250710073443.13788-3-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] arm64: tesla/google: MAINTAINERS: Reference "SoC
 clean" maintainer profile
Message-Id: <175257043504.32608.13454383152371102716.b4-ty@linaro.org>
Date: Tue, 15 Jul 2025 11:07:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 10 Jul 2025 09:34:44 +0200, Krzysztof Kozlowski wrote:
> Effectively all Tesla FSD and Google GS101 DTS patches go via Samsung
> SoC maintainer, who applies the same rules as for Samsung SoC: DTS must
> be fully DT bindings compliant (`dtbs_check W=1`).  Existing sources
> already are compliant, so just document that implicit rule by mentioning
> respective maintainer profile in their entries.
> 
> 
> [...]

Applied, thanks!

[1/2] arm64: tesla/google: MAINTAINERS: Reference "SoC clean" maintainer profile
      https://git.kernel.org/krzk/linux/c/7f311e5ac36b6cf9cc0734d89546e643f33b684a
[2/2] arm64: samsung: MAINTAINERS: Add Tesla FSD DTS to Exynos entry
      https://git.kernel.org/krzk/linux/c/8e5bf103b3ada972ea890ae6aa2118ff9b8c321c

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


