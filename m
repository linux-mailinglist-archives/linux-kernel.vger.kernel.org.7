Return-Path: <linux-kernel+bounces-884984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FAFC31A91
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B399461E8D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEB0330331;
	Tue,  4 Nov 2025 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Be0pWcoA"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E0732E73A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268083; cv=none; b=rtL5m1cD3/vP2VJqrE3d/lof6wSfDmGBxDvX0y4NpdWwK8M7+3TtJDRjN1LI4wke8WqY2BfPHBGGBFC0N5R6qifE2Pstxb19v3dVIRbJ+01WhBRwtoLKYZjG0bL+CQQ4qpsFi2wvtFYDS1g83OforGHiId3KEDyFsee/xExiVEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268083; c=relaxed/simple;
	bh=SoHtZGOkpwN5ZSgnbeU8DhJb1ETpZRQWa1wSF/osbfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6Nfo4AdENG0I1jE/Xnm6SDLLOsEX+3GrGx7vRAB+pRf2DdMWtlltE4FFxxCCRx7pnX7aJWmi4cNRdP4wamVfGutQ4Jc6mYqDPjaaEsWsqIViMCvag2mj5Jeopum/NhGYxysik01yZ+0Tdalc6kKnDNi09as8RLUYX9fi8CzAYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Be0pWcoA; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso9636035a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268080; x=1762872880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtBjBlbxbG5P+AxPedmUChhqbCDi46Di3hP9tiOhxEw=;
        b=Be0pWcoAWwCPLT3bfOkZ3fujqHjLLaGVZEpyv3Ea+3Wp3rvYQ953vD5PVYAhN5grn4
         I6HIFBdNqlkJwcOtED1LujNtbX64OtI539E336xiLBRa1pqZVtq4CEMPPcAMXjIbxNat
         6ZN6YDAoaixMpih2Ku+6apXRJ1uHrCVshTAD2H6JzuZ1yWIDBsCRdVDQd/Ac/NgG6duv
         1E1bER2Wgml1JXzfidylFjWsPuObrY0PIAf8eAFrxuntu3+fBdHtY17E2puaEFRkBUpJ
         KTK7sSuaE1yPuMN2xoIfk3Qa8RXri544zKKPoI7b04sKljqvApgwyARrPrl1dYFZISnK
         QC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268080; x=1762872880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtBjBlbxbG5P+AxPedmUChhqbCDi46Di3hP9tiOhxEw=;
        b=enMJ6LfM1/jCsOTBxdpWc/HXh3zw4NN1fJuHaznv4SqeZkdjHL7tF2YhhCAbnDnMSH
         Kq9XMYsyjfJQ6RNmN0AcfeR4UhKMCO2lQCX7KFpILmJ8zQ7CumOB0GDZVGKIioq7r9oQ
         FHCcvG7CHdYjGAGpNLK4U4Si6lX8jF0+NSy7GiiQEDDr5vW/ZWWGt5jpha/88eHAIxec
         4Suneeo1NdqB4BYuNSRTvDSmPmozrVbp0Ic0RwBd5EUGJzrZ4DxQ2awvKhIMgEfy1p/h
         qXEtKt1xmZqmRT3co/pOCMg8+2rBDZb28QovMqgmEfHqKZY9cj2GdMqu9pUDE5mxYGLX
         sh+A==
X-Forwarded-Encrypted: i=1; AJvYcCXGAnqAvnuIBtHu/AX5jhqmkdgPV66JoNBuXaY5Q0MraobXWl5k4sHs8eEO6U6hq6FmrQiCFrgLEhC/qac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOgPilyjhKld4jT3DkY5LSWSHjDlrzW5D/C1q7ET+JKjfppQBH
	gEb2jE4qO+XBwS1HGHONYORWyjzevCE6hkGTT1ZL4bqYauoS8w2YWR8w
X-Gm-Gg: ASbGncvj0em/C1n8JwhkG7uXU6NoMZhXoALDVooDYLL8ei9g4zEGzrgucKky2PiSvTD
	2qpGfSffL5fwyZnEQJNZRrXwJ+Ps9tqQMsA5UkAr4ty3cYc1boH4qrv6HsQuJvUCZa7suVev6PD
	Ocs3/wba8pU0NWi14qpfsO538XeXOybprAmbGVG1/KvKQCD21VdFsBkKz+9xZ0YGKKz9IMnFdrT
	YP6rWNa+c8Ls/2YsYF1UTw1wylrj6zH4i9qFQQlpdHtktKlvnV+9Mp1HTTSA7jDYm9oRhqEeJ7n
	GmS2LcBKrO/hqLkB70akUIJvjEVJsKlD0G+a1anRT5HfJje10Eb/C5ow7Z54RvyOJ0bODC2lbSW
	ijOIXvfFWKLSE9E8QnHugkH5TTMetbRQirh29vPTCX9DWN702MPZjClZN4k1D9NGzopkG0IWQqU
	TK
X-Google-Smtp-Source: AGHT+IEimrOHYKCn1i8ge4asMD7MxgDWkgnwVngHkgx5pY5obj+4FYjBvrDj4wPa0I6px9iIE31nQQ==
X-Received: by 2002:a05:6402:13c8:b0:640:93b2:fd0a with SMTP id 4fb4d7f45d1cf-64093b2fee5mr12182414a12.20.1762268079444;
        Tue, 04 Nov 2025 06:54:39 -0800 (PST)
Received: from NB-6746.. ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a70b50sm2235016a12.25.2025.11.04.06.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:54:39 -0800 (PST)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: ilpo.jarvinen@linux.intel.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v2 1/2] serial: 8250_dw: handle clock enable errors in runtime_resume
Date: Tue,  4 Nov 2025 17:54:25 +0300
Message-ID: <20251104145433.2316165-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104145433.2316165-1-a.shimko.dev@gmail.com>
References: <20251104145433.2316165-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add error checking for clk_prepare_enable() calls in
dw8250_runtime_resume(). Currently if either clock fails to enable,
the function returns success while leaving clocks in inconsistent state.

This change implements comprehensive error handling by checking the return
values of both clk_prepare_enable() calls. If the second clock enable
operation fails after the first clock has already been successfully
enabled, the code now properly cleans up by disabling and unpreparing
the first clock before returning. The error code is then propagated to
the caller, ensuring that clock enable failures are properly reported
rather than being silently ignored.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 710ae4d40aec..0ff500965c10 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -741,11 +741,18 @@ static int dw8250_runtime_suspend(struct device *dev)
 
 static int dw8250_runtime_resume(struct device *dev)
 {
+	int ret;
 	struct dw8250_data *data = dev_get_drvdata(dev);
 
-	clk_prepare_enable(data->pclk);
+	ret = clk_prepare_enable(data->pclk);
+	if (ret)
+		return ret;
 
-	clk_prepare_enable(data->clk);
+	ret = clk_prepare_enable(data->clk);
+	if (ret) {
+		clk_disable_unprepare(data->pclk);
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.43.0


