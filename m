Return-Path: <linux-kernel+bounces-876925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8046C1CC9F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D928234C5DE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C172320A0F;
	Wed, 29 Oct 2025 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoorhfRj"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECBB2F744B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761762867; cv=none; b=Ky5tdbPTTbE8jzRXIZmYUg2ekGeHHF6mvzN5gqH64PWE3vRLLL8T2QBkaKXtT03gCfXZHbLxUV8VHPpECkCfWQlRdodu/IRRLeLRCdOjZ2XeEygvM0Al5JsFsCZGxmT0CjS/XlzNDYSVUuC20YdBcU6/ozJ8MTLo8+Hs2QETd1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761762867; c=relaxed/simple;
	bh=CTWegixHFEa5eJOgjs271DCyYwGiTYFeBEQBky5Cs5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyWXta5wL5qNs2F+dbBVmMHgINvOchhInRREdvjKi/Dv7W/6XdGJhYqqlVazcRIUrhuZ6r1hNFOYBt9TKJquA9U9qMO505QOEQDQcb/6mUk0fM0i+ungz7fFTfFujOKvvnXQ/HXoqhglrRheoIBfdgjRgphYUJ9tmWJ+5+BomrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoorhfRj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2907948c1d2so1434105ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761762865; x=1762367665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ogeoHQ0O1BVIxTR+8ZrFN7NDholX1XeAgqEssh3smo=;
        b=aoorhfRjrfo2xVbmWP4+R92Lxv95ViIUjXT3CnDE5dyVRwihzvRpHjnIcrgIbrd25k
         0T7TRRZI1C2anRVGtQlWcjw5R2ejT5ZlzUd0VsPfIMA6bsIx3p10o9j3JuSLPuW3dIKJ
         zUTVWKt49kLDmLvB8ria0EZ96iBe0e6UJMGchL+pUVs4tWY8RWUIowRxv+W7v5+h/2NC
         JnCVBfkqDr6WGpJ1m1bfCzsD+fqvf+yWsUwCst9FL2jGZhONCTi/0qIIOaMys9vgS3fa
         wBZNwbl8HM2m5GNeVoimc14BwmmUiqsgTXfeGfG4xaptRUXLHvbXRLCMjU2EqezrfmXa
         crDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761762865; x=1762367665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ogeoHQ0O1BVIxTR+8ZrFN7NDholX1XeAgqEssh3smo=;
        b=VZaOLaNdhpxtrXzgaXnykBtaD2FV9PyhwovMtNdknOwRwTPzUDkU9qdnUMY5iO6+Ul
         88ddwHpDQh4dww2+KB27Kzay7+ZaHvVZUotv2WQru9BKWib7TM856cKR99VmPBrPB1pN
         fO2EAQnDRTgDJA60oSG6izXPi8SSjJiMZB1aFPjVjDWXjfgznZha9qqTwzX/8w94V3Z9
         E5t8TwcLbiLAriyvL4E3rytb+UAOPbS/cufMP9jpNoVf4gUruFDtg7nkGfxjjYUfneBr
         JYWXpkZszK39pX18mq1gG8hUMl/uGfBRD75T0sjgXh8rt972uXkHq4ijxANCon2R5yzP
         bxSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQvh0IXfH8zCZwCAI0kmxvfLB0emy18cX8/zRhYWzjNlrlm5zyR9adLCSRcVp2ecoh7WAYZdythnGrKec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmHK6DjmuOooCNZOA1dLNMB5A2ZRkHJn5dHDvM7l7K4MUb/FEz
	voXG+u9LcJeMeQUpgHGnemZugVAbjTLNwWhfI+QYFxGSXBsJrVigipg/
X-Gm-Gg: ASbGncuEWD/UahYs2oyMfTkCgJIEDSlVgcySRz+jw8dxl28/EJ80TZmkUxH8RZLGfEZ
	rxC+P9/CXujl8RdUqTfdm0Oo+nyKxDJ/fUV0+GEg1Ru+ALFaADP725CRSz99R6vWzLeftjfHsxN
	jcbcLu5hc0SX1inbx/7obLQBfEOE5q42uVQy/A4Zin31sQoh7CYf6BFFAkUl+nSU6IbKX+neCi8
	Pe+6mHg5dRecjR/cnbYUEP59QMlF6kYFcUm0xp0JR6UT8MnCMMWYiCIXGb7bBZEOTd4643IVs5M
	OIdLNReKWYVOzBLPkl80Kuoi6xXaq05qS99HcVPdQbhXgI9V3izfPxl1UDMiiP5qJpSHKbpcZZ6
	CVDB34qPibTvGGhSFxGjHEJydSsMvV97pDWSnzTnOYkVZ6QkWrU5y7R4w4rCul99cZHsiq4LP76
	B/wGS1jvE=
X-Google-Smtp-Source: AGHT+IEEht2FlqLLG0Ynfa5FSTjLG86LfIAz4K2RirDJOlW5Gbt1L9iZ3dBFembId9gkTaOOHsrmdA==
X-Received: by 2002:a17:902:d512:b0:294:ccc6:cd2c with SMTP id d9443c01a7336-294dee491f3mr44845335ad.22.1761762865379;
        Wed, 29 Oct 2025 11:34:25 -0700 (PDT)
Received: from LilGuy ([2409:40c2:1057:4837:724a:2122:38a7:2755])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498e42afdsm156921855ad.99.2025.10.29.11.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 11:34:24 -0700 (PDT)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: bagasdotme@gmail.com
Cc: corbet@lwn.net,
	david.hunter.linux@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org,
	skhan@linuxfoundation.org,
	swarajgaikwad1925@gmail.com,
	viresh.kumar@linaro.org
Subject: Re: [PATCH] Documentation: pm: fix duplicate hyperlink target errors
Date: Thu, 30 Oct 2025 00:04:08 +0000
Message-ID: <20251030000408.44745-1-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <aQHyhU78m-9RPQ8q@archie.me>
References: <aQHyhU78m-9RPQ8q@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Bagas,

Thanks for reviewing!

Here are the versions from my environment where the warnings appear:

  sphinx-build 8.2.3
  Docutils 0.22.2, Python 3.13.7, on linux)

So it seems the issue shows up with docutils 0.22.2 but not with 0.21.2.

Thanks again for confirming the diff looks good!

Best regards,
Swaraj


