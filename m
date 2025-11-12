Return-Path: <linux-kernel+bounces-897351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B28CC529B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB13E34CEB6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384F025BEE5;
	Wed, 12 Nov 2025 14:05:48 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623361ADC83
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956347; cv=none; b=doUi+X1KVp1E8fV/0nNYPF6s/pDiEVpUI8kchVCtLKW5cMPtwCzIkRF3VvYYLZ/fVIk0plCaaZekaP2FstocC4LiZhFPwGFgJfz5Zh70V4Ds1QLFnF+/OBZrndwWKoNAKh9bVe7ZucdhQKQndxtAh5KkUCX5SNAPdWuzjGqot+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956347; c=relaxed/simple;
	bh=NXXQBYMTzm3gLErILMueN+E6s1/7eXeyEb6HsfSTTZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c8YrzT/dIQJUf1OdMqreSYSt93sHsaLIzc2wxY2TeAtMCTTeeDfjMagZptmOISgERUsgB+xAt2azpxhElW/VwUUni9sNkALEaRVyW7P4MUfYUBRlOr9G/uL59nDEMyqmIBWth4bmNHRp9pInHue+Rnl6lH5xOKt8smyJMuYMFcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7c6d1ebb0c4so592347a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:05:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762956345; x=1763561145;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NXXQBYMTzm3gLErILMueN+E6s1/7eXeyEb6HsfSTTZ4=;
        b=hp/YBUuDnLaJzty5WqT3j9QVpy/kQmlX9/5g+V5VXMMiITbn+rJlEveeScwdvxOK1P
         wgfIr1q/s2AFikf3B0rd7+76t/4jgLT64Blo/0Z3cVo8aQiZpRzKIxceVC1TRLyHhkTI
         hppmJtxXSeGbEIHUML8jxaDgNOICyHcWWHfFOUhE4WxMOmyddMqFDd7ccksSg/oYloVL
         HaV8LeHqQNNgivPAALzgGeLlCY7Z2Pvt80ANSUHpQLjOSmNtmHOyt3ULgbTt6T4jwTlX
         DYcEVrVOFoqMfzYybJChJVbLCVSqkPMwrGBQ7YzzUrlhCE/uZiwc6FOwjddGn2TaCEF3
         ifyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPWphLpkNTxCJQhqC9AbdnGuQUK5DDBFLLjl+ZHbaP2LDpE8ADxjETutc6DUmy4hGztYMKsS0nnAWqHow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJdngxOE+2THqYL9moon6LyiKIP3fHMBVr6Qells8o+9rJNYlM
	fhfPCJV3ZJs8Se4VVSVbQDXtd0VX5d7JBrheuCbUQd/ZDWegRQPPRFAz
X-Gm-Gg: ASbGncsFQ5jwifP7wST3T0cdyldBqVA5U1sx99EX1RLtEhSdrEEImjOfdTf7EYP5hDZ
	qbhoiYZ9wHR0dlLD1jorImKvhnZtHEDxag6RuBqdNJMfDoR1vbXLXCuNVBtllCDXADyN24T1SKx
	08vfZUAKDo7n6/WyUQfultr4sii8JtAEvi6AaQzlvQ+nEno/jUrOgrc6jFQJd3pIg+epaPXURd7
	4Uc4QkBoACJ7nR5K+s+RaQsetMfdEkN4z8JwlosA9YNMSMvHPtMFSAKHT3sn2y/tfb4uffXU3wX
	hZ1D/XvU4dWPDFQTY2WVs9aIxCUUFpXV5TKhbZmu0a9q+IXbOvoG2kXEVYbTeSp+ERQsfRHMGKA
	g/qvj+b5M+H/Aj3vwv/vt+yqNSsnv9XWJmojxVRaIsjR7juAfEn4+IXk2prPwKF28hg0cBhi7Nz
	RRR8Y=
X-Google-Smtp-Source: AGHT+IH9uVCwmTm6OkyU88vI+odVy0Xu6AMckvPgZAxQBcY/7uShVAzXssPRx3eOQ5f7SoJW+dUiXA==
X-Received: by 2002:a05:6808:6f97:b0:450:7169:8108 with SMTP id 5614622812f47-450740fabc0mr1503640b6e.0.1762956345284;
        Wed, 12 Nov 2025 06:05:45 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:4b::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45031835261sm5175949b6e.16.2025.11.12.06.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:05:44 -0800 (PST)
Date: Wed, 12 Nov 2025 06:05:43 -0800
From: Breno Leitao <leitao@debian.org>
To: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com
Cc: paulmck@kernel.org, mhiramat@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: arm64: pseudo NMI bootconfig question
Message-ID: <rs4igmsjrm6r2aio4nbe5jos3vcqk2u4bjhltjwtj2pn3cquip@kv3grgec7qrb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

In most major Linux distributions, it’s common to have a separate debug kernel
build. This variant is compiled with additional debug configuration options to
provide deeper observability and easier debugging, typically at the expense of
some performance.

This approach is also used in several companies, including mine. The debug
flavor is usually a drop-in replacement deployed when investigating
issues, allowing quicker identification before more detailed manual
debugging.

I’m currently debugging some hung tasks using the debug kernel flavor and
noticed that backtraces weren’t printed correctly because PSEUDO NMI isn’t
enabled.

AFAIK, to enable PSEUDO NMI on ARM, the following are required:

 cmdline: irqchip.gicv3_pseudo_nmi=1
 config: CONFIG_ARM64_PSEUDO_NMI=y

I wanted to have pseudo NMI enabled by default in the debug kernel
(without relying on kernel command-line parameters), but this isn’t
possible today. The reason is that `irqchip.gicv3_pseudo_nmi` is an early
parameter, which can’t be set through bootconfig, so, independent of my
.config, I need to hack cmdline arguments to have the debuggability
I need.

Question:

Would it make sense to provide an option to enable pseudo NMI in certain
kernel configuration without requiring an extra command-line parameter?

