Return-Path: <linux-kernel+bounces-813520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDCEB546A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D380A5675F0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E4125FA0A;
	Fri, 12 Sep 2025 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bi6vWzv9"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7812DC77C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668578; cv=none; b=L85DHWLedWySzyBVo339Fy2aTlkMRFGBXG6tkaKSI4pRMfLammWyxHiG27G7cW5BjYi2x2aGyA9s48CMEtewSnHP4cxWXLPEYijM7BRg53FcnjB36f8Tcx1Ll63/a8sz528P4q/V/0pqoTMMcQAfZ1bzNIp2kuH5P22wSp6NG98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668578; c=relaxed/simple;
	bh=HFeSznzv0BKvTF0ZWJ7i2VPmGG3984gaKtB2uNS9LUA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MnMPQa6gMO3zj7QJ4ny0Vq1FbFVAQ6w1TpkD1C9iMwfy9glmu8m4g1c53bWQPx6G8y+yCCG9NK4ZFh7LmoO24N240AUdt41cuZgLgM82yPD7g2NYBlx4ijmJAECldnQ8RAniuw1n1zvBCwLEqsKF6f7ezQjLEdSltZAL2F63ctM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bi6vWzv9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b078aabeb9fso263259766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757668574; x=1758273374; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZlgUHzzUxcsBtMaCAdoxtWQY7ynJqMN0gA8+gbW0228=;
        b=bi6vWzv9RyEL0LxTBwz0PFeJGVzJfI62YO6HwzmgYCx+5K1BvxEgdCUDT+1Zc8R87S
         Gvj9YB/CvCUJBQLyjai8PeJjTB5B9pQJ9P2/tky6+DNchFqF+stk0RbpFPL2aph6osyK
         MHNeYwnHqfBAfbt2rYjAdanHh+A+eMxBAqyq4zOGRxDWWHURioUmhyXAC5MMaNAk9Com
         vBqM9N9hjfJN1AMOsWkg1CNO76oPxnfOfEdQrAsDXv97iUga+Mb1IAFuUtNCdHmaOk09
         k+umpBrB+oHSa1IxnmoNa65nzqcniTqmAH5W/vZ+JuJ8P2Q/OaI0ocRbef0PKTwLPN9C
         NEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757668574; x=1758273374;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlgUHzzUxcsBtMaCAdoxtWQY7ynJqMN0gA8+gbW0228=;
        b=Vist5rDV5+n/Ncz7Yy4JOpdN36gPrZ50Fh2vTg1ubts9YPxO8FChvlL6DasBLS88yi
         6QkVZg5p0hM2IsemZbS2Hbfd2yF/OlxO0JZxYyE/lu4YEJWSeCaRLezxaRURs5EzTXO8
         l7DZq+iDPyg8hcMkZ6tdYOfFbMJoKYvn8dFjn2rS3OsDWWiVsHAYwn4m7SJkDWyFMrOe
         TUYD6SmK3aaquqV5uLi+WqTAKEcgFUs/gBQ/vm+Spk+ZYaO0eYym+JQVIo/fMZJ39NyF
         pkhcRCDeO7v8kPIDpfmBpKg3n2tKKPKureC/cOhreT1vS8BcLGHtXNPsp8zXGejSovk1
         ur5w==
X-Gm-Message-State: AOJu0Yy8nUDDldHmZAbrvQ7KegaXoaub1Ubkc47dhHoeJ2B5FZ1WfRjX
	qfym92oxKiPhyN8BqYX57QqfKmlJY5yRRPUdNWYJLNwLoPqpD1sMN5ZSikDhApp5AcMvcee9OEV
	h1sP1bGM=
X-Gm-Gg: ASbGnct+lW2iY6EZkASmg261T5tNpXF0fgtu+z/wySkb8bBYrSPJ38FSS423Du2UTy2
	ny1b+mfwtdKOQvn7r6SSxljONqmVV33XtVfmdhRoGGWMTyM6P0XrZ8Sta1066UNqzvwmVSO+aBp
	WdMF+koZSij5F1DR+H95LcCIvEgj1Vi6Trk5OZfTeCXDfU+R81ls0/Cm/mxmpC3XCJQaq1gNHrT
	6X/lbbkPDOzCNCeKOOy99DgdPjIGPvHhedQ6Wq3FlPYpbAtj6kZ7WWV80GnsCyppx4/0kIXqPTF
	s36zrBQuLZWEzAukJl9Ym2Ww9J9QBK83JIx3zSxnaLz4pdoGq3pp03P10/OGk/DHAKdHDnDolBu
	V54cIcJkGt/QPTFMLUVy59fMOMlX5VaxlCfd1A1DNOFf85W15OKnnXEU6BqqrgdrX0YQP4fey0N
	U=
X-Google-Smtp-Source: AGHT+IHW8XMyz6nqW7u3TYUw66sukf98+XYt67qdK2NQa7FJLPadrkYMrrqcrPARFvnU1xfgiv01KA==
X-Received: by 2002:a17:906:794c:b0:b04:302c:fe14 with SMTP id a640c23a62f3a-b07c35c2af1mr200439466b.21.1757668574166;
        Fri, 12 Sep 2025 02:16:14 -0700 (PDT)
Received: from rayden (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b334eb58sm319624566b.100.2025.09.12.02.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 02:16:13 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:16:11 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] TEE use SHA-1 library for v6.18
Message-ID: <20250912091611.GA1442659@rayden>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello arm-soc maintainers,

Please pull this small patch for the TEE subssytem. It simplifies the
code by using the SHA-1 library instead of crypto_shash.

Thanks,
Jens

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/tee-sha1-lib-for-v6.18

for you to fetch changes up to dfb2a4f76ff7f60d6e2a55b6a973dd42930adf50:

  tee: Use SHA-1 library instead of crypto_shash (2025-08-13 14:29:49 +0200)

----------------------------------------------------------------
Use SHA-1 library instead of crypto_shash

----------------------------------------------------------------
Eric Biggers (1):
      tee: Use SHA-1 library instead of crypto_shash

 drivers/tee/Kconfig    |  3 +--
 drivers/tee/tee_core.c | 55 +++++++++-----------------------------------------
 2 files changed, 10 insertions(+), 48 deletions(-)

