Return-Path: <linux-kernel+bounces-830146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C96ECB98E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0F21884F80
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B1528135B;
	Wed, 24 Sep 2025 08:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hpNCmf9d"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAA027CB38
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702850; cv=none; b=ArVPs4kfd/9oMg3OctsKTh9WE7ok7phjeCnfwNrd21bqe6/90IX3CSQnL1ZqOKKX8j2zw0C5vDvyYL17TDiZ+AYc0YNjlvviM08yc42TA4SAqfpH42/x4FcCCTWbKzZUzzJz1hWZrz1Z0kacfQkmPMy5UMIzGT42CddJeklbUXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702850; c=relaxed/simple;
	bh=OrATnpZDnlXdQH9ZHMeh5Yq3DhbnbcVfeDmwbff5INc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eY4bLWUzYf5amFaaxOx2dsLiSpbsRmzBCvjXnaH7m9op9Ba72g97/fksGvLm3kFwtYXfH0dCmda+Px0Fa7ZNjMq4ZToUpHWdgAGrJ06iGHpha/bsFlDiyFk2/RtYS0o3Caz73nBL242eOk08/0gX5ppkAxB3d4XTWQ6P5uIO+g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hpNCmf9d; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b2d92b52149so526927366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758702847; x=1759307647; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T2GuLi6XyMMBKMY8TiQINu19CGtecqHLNQuiswEu7fo=;
        b=hpNCmf9d4Pp/9eN5nue3g/dp6EQb4+Lh46VqpYOANYItMY/Ytm79PdECY6s+/vpJoz
         06c/l693kzOuJZhCEbnJIsmH+lCB7C8sj812mKkj0EpwC3eGqOjcyxh/G6DHFxfdcfYA
         J+Rsn5pJ1uvYysMDsyRwjjqx53K/4Hd2embuVraRQA7Uz0md/Bc5oPWdd9lDEnNw6o7R
         hRhBvtrY49gYVykiMwj2/3LSQmGwYfyncvAv5ahdrKxQ3YorJmIIHk5K+lstlYgYZUFy
         awV2QhdngNMfz6BTMyUPDVb0wrl46sQnbE+DLj7HiA/5PNsF83K00MQ93INPcTj6f5Vv
         2/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758702847; x=1759307647;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T2GuLi6XyMMBKMY8TiQINu19CGtecqHLNQuiswEu7fo=;
        b=j4Usdh2RGvQivZ84WgW7tnNBaTNK9+LZRaoZ0UttHprEXEWIcagbHUOJXTXr/kWCtK
         J1FAEeItodtKeNXCnG/6QfxMC3OZqjQiQSGKIckBrupeiK+Y1ke3U6bkroNvHAczR/a8
         fh+WHEmcD9q69UBSTPNyM6ysH+aWtnjOSptN7Qp52FjXPaPXNcAAnLob0Vqz3UNSwDZL
         J6V+6YPjUaapk/WkLM9L081HIpn+VHOKHo4pkBqzsY5ZXFEpqGWLCosqatWjzo/lg0W5
         RUWYIPMs5u+f9C5eFPYUoeaMR7uD525Xo3nQkOxtTT4+UCyp5bmQsPEROVN4w6prYfHo
         HoJA==
X-Gm-Message-State: AOJu0YzRiKZ5k9tPyDvvhqzlm+CYFI7RgydG66lt0CtA/ko20C6iEfaR
	qym5Cx7gFAOATemr8OdN6uKh7KgBiuXGZJoSdLaI847m/t/LE96/uoqBppbqH56NUsmrh+fwluM
	8LGTELek=
X-Gm-Gg: ASbGncsRyF0XVkqTWtd+QThv0hKxX7/GJQ4MvZs2qZoj7jfqhAc4yiamjKStdC5K4ki
	78WAb0AlWgd9+5pwqihUdN+BDaJq5GNVVlQHtZ+8Kv+y9BFRIfJUDX+4+M+g9dB3oVVMqyobybS
	ZYqxjX5l0UnDIE0OLsSafcwyo9MdTx9kpJ26W8FJ/gbeGe8iS2ek0eH0xAIqS9CTcran7HZMkFC
	tIDdeta2+Fu6wHPmoUgCRLb70Ge0LSdBeMrs9cKm3Mk0+7Lm4SmK9nw96//2A/oOW6tnKYlt2vS
	HKuD5irnnjAFwr2FBhSFOmeb+HIJoGeNgat0BURzp0rmjVQ9JSYKrmfrIDzIq8nuLjl+WpkKWCB
	9xLJN0VGZfcJ/62Zar9RrRw4SXJSbPZAIGBILdGiDwyMMSnFJFCJFYCq4OdipR0eX
X-Google-Smtp-Source: AGHT+IH1aDoALWFRsO0oVLqVi+ToUZna4cdMnC32Rm3fsJgeudeKUR1iGh2aJbkhuYEWll04azdH2g==
X-Received: by 2002:a17:907:7e88:b0:b2f:5c41:49c with SMTP id a640c23a62f3a-b30267964c0mr565741666b.3.1758702847411;
        Wed, 24 Sep 2025 01:34:07 -0700 (PDT)
Received: from rayden (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b338b404a3dsm46227966b.11.2025.09.24.01.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 01:34:06 -0700 (PDT)
Date: Wed, 24 Sep 2025 10:34:04 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] TEE fix2 for v6.17
Message-ID: <20250924083404.GA3747732@rayden>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello arm-soc maintainers,

Please pull this fix in the TEE subsystem.

Thanks,
Jens

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/tee-shm-register-fix-for-v6.17

for you to fetch changes up to d5cf5b37064b1699d946e8b7ab4ac7d7d101814c:

  tee: fix register_shm_helper() (2025-09-22 08:47:00 +0200)

----------------------------------------------------------------
TEE fix2 for v6.17

Fixing incorrect error handling for a call to iov_iter_extract_pages().

----------------------------------------------------------------
Jens Wiklander (1):
      tee: fix register_shm_helper()

 drivers/tee/tee_shm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

