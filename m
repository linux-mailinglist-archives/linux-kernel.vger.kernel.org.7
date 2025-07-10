Return-Path: <linux-kernel+bounces-725130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DD3AFFB2B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FB5D7BA3A6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172CA241661;
	Thu, 10 Jul 2025 07:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X71MCt1m"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E8028983E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752133219; cv=none; b=gY9QzNTvDL2VxW5Uufcdi7CWDgqmabyeHtYmGbG+pIJnzx5QYsjsjJaj0sFI/ZBxgcb2D5dIGbvQQhZFO/O/wKaDn09qkR/snKg9kKIwkytoMFSK3Bgfjn6UEt4RHYPdwsgyGFaTNI9QKRFNXAxAbLhlUDA6aCtJMvHItsWFQjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752133219; c=relaxed/simple;
	bh=bVSinIxBeazkKEKfcVYcVjaoUaV4wjv1lfQNu+0RDdc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EEvicVNoLScTB81dDTVMk+Wy4vZsoBNXvlxOyymUE6DpbgjNpphGCIRKKmlopISJKCNv/gUJQa6+PP0iBdCzmkq76JTBX2UQsQBO5j+k5tHC2fm/fbo8cTZbbKdhJTpvCGQ0nIOHNcWafBJAp6B/Zn6yBwQOpnK8tuTi2eows4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X71MCt1m; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so3515505e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752133214; x=1752738014; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVSinIxBeazkKEKfcVYcVjaoUaV4wjv1lfQNu+0RDdc=;
        b=X71MCt1mpk6haB6Le5wYPXgVY5IuY62UveVgmBTg4Z1xUHkWVhqUxgVCAykNzH5sfv
         Qg9k9ds9qG9b891vVz59o5U4qS/Fm6xYrXwPQPAL2Lbv+VBVhtaWVLfIHG1MYAzpY6eU
         4qTxjJmgfw2QGXW6bKKOcY5pa6jcZnG6OGUtVSiG6Y7AYCsD9ysJ+mZlrtiZdK52R3Lq
         uPNk+bHsxZEVuN5IAENbdDMr/AnPo9/fFHa/lQ6BVwo7R8IVeu3BQ5U7cOHPOaojxuJA
         jZ4W3+sP/k6UTWnilVjpdV11zobnTM6Mdab0ruxgD5tA72K6yal1NXGqa17/lHKxLCiC
         bJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752133214; x=1752738014;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bVSinIxBeazkKEKfcVYcVjaoUaV4wjv1lfQNu+0RDdc=;
        b=mTWlROAgnRk/4Kn5oZClP+YblBkLWvLGOiyn5Sc4rDit1xYQ6Api7OjqOmam207FJh
         4Xwfr56getKtXr/lO67QgjpH3/6eLopNi8QFtX4F/yvqSEtNLvzuS6/KTUAmgjG8DIaA
         UsKcqMFR8a3Ba5R1aC2U9BPEdpt+vrGs5w2q91zRs5K/OwdOlIp1h7Pfbw4w2krvh2Ry
         qV08d1nY638sECDozTRfSyUKa3VduuPH9FfbBzA9QuTP+ylhaVezNbUjctfdIfgWjV4i
         wpji47AUnCf6LGeZNrO7Cgm7Kwu68KB8BNZFx6ozrzVvmWSiesdEbU4BaJh10VWORxfw
         n9dA==
X-Forwarded-Encrypted: i=1; AJvYcCXRphW9YeFagJGAiGpVFYFzh4qXbHyanqn1GEMyjFUEiYhoVRbck+P2xFq9aaCC9e7WchOQ9w4ihaG5TtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/9JPRKXtaSiJjdk1qt1vSeyPjqXyPTfA5Q544yYuxglIXzmlK
	r7Ve6T03PSVF2RIZXsMo50iagPFUj65uW08lKq+ZzXqnnXeXUk77eUxEKx8F9DyHpa0=
X-Gm-Gg: ASbGncvDZq63Ytx9jFPdRnI5IP4z8C3635aPWia0aGQf89VHPeIEGp6MuPksfXlqRnX
	+MoYzQxpDkwOvmQAG8Y1gu3e/KrE2YvZFtFtou1gLYOjx7QpG8syLfISQKbfjP1KnjH3iPpPyRe
	5HyPPuMVdRxnzcm+jHZ/c9YOmLQI7OnuJjLY25gSYs2SqmnECnBSzqtDWZ4zsmWmAIKHssY41U0
	a/DfMeGhxLA3d9f1mYGdOUlUrVGmiygQ9gDWqh/RLVlfieus8gYHtgXIyyHwmFuskB+xJ9gAx2H
	sz6vnDkjXV2T6kdMeZyaHUqx+0xYfzqMODAj0j/0D09us/uUCTIwW3aWs+6pLlvqIg==
X-Google-Smtp-Source: AGHT+IEw2BMJU0viDmTOvkyx/B/l0UKxFSMsiQvTqQWjzJquhhrpepUjy0pyReFZsMn1allOYgvtiw==
X-Received: by 2002:a05:600c:b85:b0:453:99f:b1b0 with SMTP id 5b1f17b1804b1-454d53a7430mr48773265e9.20.1752133214419;
        Thu, 10 Jul 2025 00:40:14 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd43915dsm11113575e9.7.2025.07.10.00.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 00:40:13 -0700 (PDT)
Message-ID: <965df42623d1a1c2bac49bd9420cfb5fad672048.camel@linaro.org>
Subject: Re: [PATCH 1/2] arm64: tesla/google: MAINTAINERS: Reference "SoC
 clean" maintainer profile
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Peter Griffin
	 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Alim
 Akhtar <alim.akhtar@samsung.com>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 10 Jul 2025 08:40:12 +0100
In-Reply-To: <20250710073443.13788-3-krzysztof.kozlowski@linaro.org>
References: <20250710073443.13788-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+build1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-07-10 at 09:34 +0200, Krzysztof Kozlowski wrote:
> Effectively all Tesla FSD and Google GS101 DTS patches go via Samsung
> SoC maintainer, who applies the same rules as for Samsung SoC: DTS must
> be fully DT bindings compliant (`dtbs_check W=3D1`).=C2=A0 Existing sourc=
es
> already are compliant, so just document that implicit rule by mentioning
> respective maintainer profile in their entries.
>=20
> Cc: Peter Griffin <peter.griffin@linaro.org>
> Cc: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> =C2=A0MAINTAINERS | 2 ++
> =C2=A01 file changed, 2 insertions(+)

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

