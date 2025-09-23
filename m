Return-Path: <linux-kernel+bounces-828837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6BCB95963
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18F944E1A01
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C1A321426;
	Tue, 23 Sep 2025 11:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wssa56PB"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E334119D8BC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625988; cv=none; b=X8IXQy+sPvvm+a9sauPyPkkyRy4d46a7o7xFoOn2mHmp632hMQBZ7pOirdM7pLQ6IrdKlDwb551KAGjNM669CWSgOpKO3Agb0rkTOsTIDYyHCScdgvqlGY24xo3BCMQmL62QxFYZRXfjh4Id5pdAyG5JeIXEAcJS+LTHiej9rFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625988; c=relaxed/simple;
	bh=Xu3aFhrso3x/XEZB/pUFkQq50ed8XXakXxPeuUqgUyg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iB5DJ8ey0CQZUlcdmjxENlWt9PhcKPvfC9Fp+QHn8G8eaEuHytiJXC4obxrqrih9nViZAuP1gwmUbR6fLUN4LqFPgc8J22y+OB3zuEPpRRrS6ZBEMtVTRbmeVnjSGE9vYN2U5rn+v2KnAl7/ZfHnWPTO+vNgNebbe5bmgRF841E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wssa56PB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45cb5e5e71eso34326555e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758625985; x=1759230785; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kPfB6vZFAN1UWmkMopxYEPmOWLUUuC+tX7ts8FDpK5M=;
        b=wssa56PB25qRd4yA0y3AsSRitOAHTtIyTAqQoQ8NdRHDjov5CO9rTtzl5gAUKP/J+Y
         90IrEzZTGDXrVfM3ABzhnBt5Uj0rbAP8OKLlMjo7PAErA46zUblb0dK4jaBpzZhRM4Oc
         mV1mFiwyPL0Y+zSXRrPSkY9leP7nQivXgAEJJNYR7F8qjwAdfdMVuGEt3sI7Ahzotjn7
         fB4NSJX7NobcMe6cUs4kwrXTBV1PH2Y9UNu9zT+6NxkjYMD6XFqzLt414bZ3EG9GkPeW
         IIVhCkT1XdctQGnPBLBTghoACjRP4bISDUyJLLddwPbaBdczlpqeDMA8xSLIruGZJmzK
         RJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758625985; x=1759230785;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kPfB6vZFAN1UWmkMopxYEPmOWLUUuC+tX7ts8FDpK5M=;
        b=SlcPjAZMz5B2zJrq3ajsgI5BIQkldhyyC++dcDTZpi2+5m+QZgHeOjNbtFvrQo69A3
         vxNqEL/s3s6G2NLnqAFvqNCMdL+AM2ZDdU4Za2h6P5LlesMea4wTMk4XkP3pnDeLzBT2
         JCmft9hm6A0GgjDXbULW0pWrhGl0jb2ubORqxUQMcmSduhpnkxF5h/QpqyY3b7/Aa3RA
         E7/6W1k/H50dGOp1G8dbX+PBdwIkQxCw8nF5GK2aHWVkeWhP1Y1pqZokjIwkkHGWXOXC
         YO9jh+TDKnhcpbIWLbCqXiNBi7iVJg/BkoQsswYq8Fr961gEfxVINyDyNnmalbyC9q2j
         ftWw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ7xjhbHaCIW0PzYAZb0sr1sCESgP21mqzsfj7p8qkOKAtx0jeZPBDG2cfWJ2FFyDRRsjgjJzvtQwf/aY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd3/KzN4fLyJE9/8pL+f/g4QK5QLFs5fKHUzdo93OOsrONRmm6
	Jovcdm/iDgYKa2qYx1BuZM6s6ItAJk+NXVAT4/G2O73FnmN6SmaGru5JWqtCQUsBWXE=
X-Gm-Gg: ASbGncuQAIklhdJOE4QCmOKAq18rOCgWI/K7XbXC5wYcfUlqAW4lUcKgwITsMTQuZXQ
	TZTzdyyb9V8CWdhG4+r1rR2AuSNdu94KyvSzXMwPvxEbE4pFY2fUGt8j1LOxTao++8dU20VazHP
	V77ueCxNmD/nsv7CC/2LwpFCO6fECuxVChZNbDymZc0snWr0uYBuPgqee/Fg/IkuuFi95blDL2Z
	TMzdQqYgW5018LT4N5GE74lDxe1vlmqPaaQMa6jfvBHhFLn7B2pAhNZOPFnrHxz/A34YdtQKcjZ
	m7gmUIxqyuPf8MYPg7JC0h9vkERJITaRiTHbzBNLP/C8E7VacmaYf14uXBUxf9bKYxSIsu1JOxq
	EsDjv69m+Vp5faLv4EHNGoxtGURgPv/Ab91iBkSY=
X-Google-Smtp-Source: AGHT+IGkTADoNqcmQjP+QOFZr6eMBbrG7pkg/2yNv5pLWE/18q+4r2nqJqLF9iBKY05vapp9F1P7rw==
X-Received: by 2002:a05:600c:3103:b0:45d:d68c:2a36 with SMTP id 5b1f17b1804b1-46e1dac2d45mr21237175e9.27.1758625985079;
        Tue, 23 Sep 2025 04:13:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e1daa4a4fsm14991665e9.1.2025.09.23.04.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:13:04 -0700 (PDT)
Date: Tue, 23 Sep 2025 14:13:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] dpll: zl3073x: Fix double free in
 zl3073x_devlink_flash_update()
Message-ID: <aNKAvXzRqk_27k7E@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The zl3073x_devlink_flash_prepare() function calls zl3073x_fw_free()
and the caller also calls zl3073x_devlink_flash_update() so it leads
to a double free.  Delete the extra free.

Fixes: a1e891fe4ae8 ("dpll: zl3073x: Implement devlink flash callback")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/dpll/zl3073x/devlink.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dpll/zl3073x/devlink.c b/drivers/dpll/zl3073x/devlink.c
index f55d5309d4f9..ccc22332b346 100644
--- a/drivers/dpll/zl3073x/devlink.c
+++ b/drivers/dpll/zl3073x/devlink.c
@@ -167,7 +167,6 @@ zl3073x_devlink_flash_prepare(struct zl3073x_dev *zldev,
 		zl3073x_devlink_flash_notify(zldev,
 					     "Utility is missing in firmware",
 					     NULL, 0, 0);
-		zl3073x_fw_free(zlfw);
 		return -ENOEXEC;
 	}
 
-- 
2.51.0


