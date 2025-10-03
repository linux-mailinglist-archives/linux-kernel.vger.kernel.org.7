Return-Path: <linux-kernel+bounces-841263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9825BB6AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 14:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA8134EB9A2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 12:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8A52EDD58;
	Fri,  3 Oct 2025 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OpkUxpn/"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3B82E8DE3
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759494776; cv=none; b=kicyRDdYdrTTWddmJhQQRr1MRsnesvUEDLseBnVrEfkQ2f/hy065OjA/MI/Yf+lJXX8QHbdbZFutl6tJx3qLUj2KNq6mBfw3AUNkp1CVIPIQsYNy1d19VeQE3e4m2lE71cYfGUwBIhO5B19q8aNxv9hInfikGOkW3DicYjA5VRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759494776; c=relaxed/simple;
	bh=NIwuK7WSwOp7xXgXvN6lArOB3a1rRAMQT3rIRTG4LWc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i8k4pyLrVSaOUBpxQIWBSVYcZu22Qb6G0tjvI6VkeRerSwgjk4r7lQCZ58cGQHWBChhpwZZ29qOh7djA98fnTKg7QheYtQuzNecB+/vJW73Db0YDk33cM88VIqrcEd288g8zo9rU0omHKMW5A86mTvvp6UEOUcBdovERbca3x0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OpkUxpn/; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so4346094a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 05:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759494772; x=1760099572; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=17gCoEjvIQcUQufFQtAKqNf5Qc0ovnSmzCsZHusGb9k=;
        b=OpkUxpn/XtwoPak9QI9RcoeXsyEmLzlvp3rcClaYgBlWWoGJV/yqhjQqr8+e4xRGwT
         4cDHtforjWTRdd3eNMJo8O/hMyVdJcrqflxlqU5gpS91AyYhtGWaf0JZzHr6eyyzMN0U
         0jZfDCbTpwl158IWbFqZfLwoUGbWtPeqMgoFEqZP+niQhcRDlVnMIgFiY8R6IcMrI/BS
         mHWmpRdXPE8z3AfBHcDI3wMAx7hNJDFimflxFXVbpNCYjZ2w4F89znmyIHAWcMX/rmyN
         Hl1PdlUPHwkPzEo4FfCTsaGKru+z10eeWHJalahiGg0VO52XGjXPhJ3luR2jKwXStHjx
         VaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759494772; x=1760099572;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17gCoEjvIQcUQufFQtAKqNf5Qc0ovnSmzCsZHusGb9k=;
        b=T3d+CCpWWPJlrOO6XxaNt4+mQdfu+qZFzRr2V/FgdZi4wdThMyI7ZowLOSrCGjr2sE
         uBBEyb4DBZ82s+XDrOfF9pdczpLdui5Yt92QFqcfIk2uo/sfc1FWlAq5xLEXLvGDYUz/
         mPx+4EmZzJvgKutWQe9QaV4IhJ9uiW3JrmRGZh/HmAlPSs0uGPQtC+K1g8wwzM9kIp0Z
         OStXmtOyo3x1b3DGDY29jNVBsd7NpWuiGqMMf0TBYjyN4nm5GxSeu1cQbPoeTgTW2k4p
         w2RQdE/6fQ4SCXzt7bYCvGIo9GnBDrdiJ9cwI34yGQYbfMlunNkahY8C7Vp4ehAEZCEW
         Pf0g==
X-Gm-Message-State: AOJu0YzRb5IMAB18bH036VBD/RxX06FuZS7MuERgkUzKA6mbIE+k5HMK
	t5O/D1fLb+OXQoNU5PSYDtymUDccdf3ZSuBIC/BVO9h2elBmIATtjVf+oJB4vGnmi7s=
X-Gm-Gg: ASbGncspJeV6Cb2x23X+laDD4mEM/iRXAOWZXatf0phM1ZymuVvOUIrMjru1g0XTnL7
	FYMR3zDdHnHDZf/LLOvSfGNDEFZx9goZ9kiatfapB8uYEMr8BgfSz/5WPBi04vaG8SauLPlAVZJ
	rEQV/0inGXw/6HV3/Bw1ntwq5YzwuIHiTcovsAIhSilYmkxj8ZuKpjMR08l3xb5Wk3U3iKAV0Xp
	XEi5e7OXsoPu3dWSFi4duY4mInnN1DEaJTWjame+pqBHJpU/4sqrUu0h70W8OBrY/MFbbS0tTMR
	Y9nwsxQdNU3aPXlIBOumSw4JoOoXTv5kT3bAY+pxLhfuv81l9WYLtRzpLqTiU5HnGoUzHO2P9wa
	PU3y4IQ5bh8MTxrux+v86cpVdpCsxQYApYmyWl8ChGDN0y0fa5eFNVjgfjy5yZofCN7+j1HCJyV
	La3N5S9xLDiHJ3JmCM6hbngiGvQas=
X-Google-Smtp-Source: AGHT+IEoFFTeRxLCKlCPFN/zmcwyyLcUjEt0wTRNto+jUB9IZ+gep75jgaZbEeIo6QfYakU8Sdy8iw==
X-Received: by 2002:a17:907:961e:b0:b48:730:dbaf with SMTP id a640c23a62f3a-b49c25514acmr373047366b.25.1759494772108;
        Fri, 03 Oct 2025 05:32:52 -0700 (PDT)
Received: from rayden (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa62csm427437866b.19.2025.10.03.05.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 05:32:51 -0700 (PDT)
Date: Fri, 3 Oct 2025 14:32:49 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] TEE QTEE fixes for v6.18
Message-ID: <20251003123249.GA1063437@rayden>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello arm-soc maintainers,

Please pull these small fixes for the TEE QTEE driver introduced in v6.18
merge window.

Thanks,
Jens

The following changes since commit dcc7a571a3665a16581b5b18ca6b113f60a9a41a:

  Documentation: tee: Add Qualcomm TEE driver (2025-09-15 17:34:06 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/tee-qcomtee-fixes-for-v6.18

for you to fetch changes up to 3b63efa21bc6acc1a0fadd1dd0f0e1988a4c0177:

  tee: QCOMTEE should depend on ARCH_QCOM (2025-10-02 08:31:10 +0200)

----------------------------------------------------------------
TEE QTEE fixes for v6.18

- Adds ARCH_QCOM dependency for the QTEE driver
- Fixing return values for copy_from_user() failures
- Guarding against potential off by one read

----------------------------------------------------------------
Dan Carpenter (2):
      tee: qcom: prevent potential off by one read
      tee: qcom: return -EFAULT instead of -EINVAL if copy_from_user() fails

Geert Uytterhoeven (1):
      tee: QCOMTEE should depend on ARCH_QCOM

 drivers/tee/qcomtee/Kconfig | 1 +
 drivers/tee/qcomtee/call.c  | 2 +-
 drivers/tee/qcomtee/core.c  | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

