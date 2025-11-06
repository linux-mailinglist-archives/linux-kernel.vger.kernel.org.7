Return-Path: <linux-kernel+bounces-888317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD85EC3A780
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421621A47954
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920AA30C621;
	Thu,  6 Nov 2025 11:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5bujq0V"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C97F22D4E9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427382; cv=none; b=ixqvK23QC/Ll5s+NLjh3Z7aXuTQZwIyzDvExmGjP1+vAqv4z2OxvYV7M7DFq75FpQ3mzorT6p2zFWfntplDPaKxw6zmn127/k49xd8pDvKFKtE93QuxClYDlEBXCpoPZqnWvLONWcHEIWLPw9d42mDQ4eqQYrXRVml75bX6I4is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427382; c=relaxed/simple;
	bh=D6MUO7W6K4aiFoZK+kBGR+3MGc+5N522t4xFoo/2dgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjFusZL8uGBzkv/sYjykmxYjDoFCkUlWEtYmzfc1J7AE/wYTa1/EUBsZ7eoSbshx1ncsYqNOhJ3hKHiwaLFewHI+47Ftxl6FuE/XxhmjGWB8KTykhrh0nUDR7NtEeMGZWS8sjUPIGrgKy22DIZXt88RefOtfeKDz2fZ9dybvS48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5bujq0V; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5943b7bdc37so1825236e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762427378; x=1763032178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6MUO7W6K4aiFoZK+kBGR+3MGc+5N522t4xFoo/2dgM=;
        b=X5bujq0VbSS63g4UR43z9HjbkT8AmzFQmZunVdcRMJwxGma1Kke+hNH6pK6JGiqQx3
         2836isB7DQNwQ0sjzpoyZd4RHbrpuJJYnlf0XyPAhig9ZgsbKk9XVdoTVUK98ZxyulA7
         lojuT9FVw9QU88pu45dSuEZFBBCvmiji1nC+Of/+7bIgDpTR/debR4r5PKSeKSxWQfFq
         mhmqVpwCnW8I/Kz8pCjuyuTj3d/u9owbPbxECMN5aWL+1P7xWroMLy8Mh3f0QRlzfHTf
         A0IFbAcSLFG2XqLmBEWvnca/N0Ugj6yW+erZUxtiXAEGz+US4W+Cb8ICPNhbV61opybh
         bRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427378; x=1763032178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6MUO7W6K4aiFoZK+kBGR+3MGc+5N522t4xFoo/2dgM=;
        b=jx1nAjLGRMJDx7gziwxU0OdxJUjlDeUCpkNfAwVZkONbY8bns9HXc3oGYcISSkm9TR
         s5k7n6tRhc1HhfJRH7UDCIWQ13Z2oAt8HjFPa8/S2Ab8uePZEl3SxOecLIFMtMHop+i8
         pBrHJTyYtRQSfIgtV1wbeRaJpvdedcdFQIc0gGyJrNs7ovcwSS8js80IdriDAaI70mai
         baJ7gOsM0aCVj27+kzTM7eYSSQ42AUtnbRbkE95fhMqF9Ce9waocOet9eyA1NURfx5Ja
         JvR3sY65Yg9ZW34hJo0fNgFUOMlHFE38YO3pDNXiFggi43bHX7iVnG11pA5VWwUSwT9q
         BqHg==
X-Forwarded-Encrypted: i=1; AJvYcCXkqyTuavNKG5CsrT/zG5ExmwmofdZOe1XbW9W731pGHleNXmg2xa5hE/s/fR7q/N97gqWM/y4JPLIfbo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8aG68I+hMIDKd4Q6lg2LGYl6+UtuholBS498JhKIstOLSqLAY
	0+m3JDgjHRXBPMvOsjuLNBZOJ3RJ5HX3HC4gDvQEcFlNK5YWkwk8Z1wY
X-Gm-Gg: ASbGncskT1il4moYSMf00SR3NVlfdsCz5SC1BW2BA+Sgy9oo8Vid9wynGwYsuIXICVl
	3CXQ9HMfwCbpMeHtOmjFiCbS3IM2htX8Q2r53AEnUoRLZ3fnzUEQPZFp2BIJeXVNPUaVw3hZ4bi
	xh47EjozpO8rV37dsHbKujVjugqMbmtb112+IFqLuEArHNRJ8f1Zpyjxe4jOd5dFkcN7Z2JY8x1
	mMQeVYc4hSqaM0y649PI7S9d2qgRMVc1AKoyw9ZAS2O0iDjj0ma4EZPNfxtp7ytOKhh15bNgo5y
	yaP1+FnPwZj5X/fFeiWCr0bdPTPUH7VHcYoAodLygtazKAwNwGJCgD9lBkLV6SztwoSV/2soJqh
	OVXz7oOtUTWuRAYWz+F7dGMIKGtCoajaaiATgNA23sVIW7su2oX+PpcWB8YMBjviyOsXjQfwTAg
	ESPjM2q5Fn/4DLMiVFrA==
X-Google-Smtp-Source: AGHT+IHg7YfzZvEtN6mCngPjh3XRjwH5HKG3Rq+sq1Iz6laR/FfiXWjxHYGZW5Q1gopMiO+TIMUcVw==
X-Received: by 2002:a05:6512:118d:b0:594:2c42:abd4 with SMTP id 2adb3069b0e04-594493090d3mr889484e87.5.1762427378302;
        Thu, 06 Nov 2025 03:09:38 -0800 (PST)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a013af4sm664510e87.3.2025.11.06.03.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:09:37 -0800 (PST)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: andriy.shevchenko@linux.intel.com
Cc: andi.shyti@kernel.org,
	jsd@semihalf.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mika.westerberg@linux.intel.com,
	Artem Shimko <a.shimko.dev@gmail.com>
Subject: Re: [PATCH] i2c: designware: Replace magic numbers with named constants
Date: Thu,  6 Nov 2025 14:09:35 +0300
Message-ID: <20251106110935.2563071-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aQx-BlL9PjHeR7Dy@smile.fi.intel.com>
References: <aQx-BlL9PjHeR7Dy@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mika, Andy,

Thank you both for the reviews! I'll prepare v2 that addresses all feedback.

Best regards,
Artem

