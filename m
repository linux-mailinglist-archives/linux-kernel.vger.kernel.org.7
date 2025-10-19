Return-Path: <linux-kernel+bounces-859792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC69ABEE9B2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 18:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 158E4349810
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CD32EC09C;
	Sun, 19 Oct 2025 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGjOPPP3"
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C98A1A00F0
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760890569; cv=none; b=R7mLjdo7O+Xmke1T1aAW8X+LTHVEybc6RkyuAV2xQK8hXnBfv0E7pJfBSIG7e8HdK7//kLohHfY4oG2momEnjl61PhwBIqhmFCN/J2928ALgDMpmj6Gai8kSottdaOz5WLs9HVMvukT/Na8C2gdcek8q3msubBMwn9loXAjNg28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760890569; c=relaxed/simple;
	bh=w65OdgmpV8I1cxj2sfq4rK12q9mD/l6u6jCluPLlwTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gb2l8bqc69rgy+L5alfQlvyV90O+iXxEq3KU5XKHS1DMoVBujg/1tIuniZVnSjdSzGNa5opql+eS2Op0t7Ak69RbMm4YRw1xA5bB1p9w02i5LQ9p/ojZarwx758lGJfds9xhYb3fgiFIELSEA2OBCCEPBWWGvlEsxJ76KGxVMEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGjOPPP3; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63e11347fd9so3329907d50.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 09:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760890566; x=1761495366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w65OdgmpV8I1cxj2sfq4rK12q9mD/l6u6jCluPLlwTY=;
        b=kGjOPPP3AV4B15oNWUCh7zjCvw1lMZxc8GWcUcYppse9Tmq0p9m5dEEqeOh4hDgt+6
         /U8YQXEAb+Oh4B3Iwycd2esArczN3zTEW8zGLdmFUdIiFHxQnfm6mFIk/rsnQaSRxm9V
         XyKIBb1EpGzuMX0m+VYww5SehqGqwf2L1zToNiBNNp0IMY+YJALiPgoSRjiXVsgiIRQ4
         5V+LdS1AupKh1LVlChSCR/RN+xxWQpiVAwfAnJ8LbaknNmuf0jGfp1sxSqTKpKzll3MI
         HQutE1Wcnaa2JEdO64lPH3Q/e4F3UMhL1wq0cou3TetKULGj0YaMuGNahwZJwTEmXHS/
         EyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760890566; x=1761495366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w65OdgmpV8I1cxj2sfq4rK12q9mD/l6u6jCluPLlwTY=;
        b=hpptVmVWUzPFgB3mQ71OO0ZUVOKae+RLfk8qCwby5365M8q3KKTpQ/IcOqjN/IywM/
         EKqFzFlysA9cDzdxeZuLSwldJ7zjOk/rcNBekslUlFPswzfuXNhDQ7e9K5AdTDXBUXbt
         L33OwVunscfOB5oyc7PjcdzUpUN/rbSRmdylq0ngZ03Qc79YBF2ZtP6r9AbtYZr846D8
         YUum1TEnvcLr8zLd3o5CU5huDnnJpNEpRyv/LxpUac8mEiRhEtnb76rVgNbBVBFz3rGD
         46jKTemw5GFVpIOTMJ/rP6I6zN18UxspuZQjf+x87q7VH5PADU+U/JBniomhcCGFwTt3
         PQwA==
X-Forwarded-Encrypted: i=1; AJvYcCU780nYQVqBE8B6Bul2V8sWiabPEV/gwJIEM27LhMK6GOmYG9jL7oRdNDcyLVAW9kWv8gCz7THI18LJK/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0+Zn6pr4qMNKvvHeBXaISh3vSorNDFveMCzrju0vKQFyi0uba
	Sko0xJ+Zn/lGSeTNyXXEN+36zZF8st03+vNhvn8oJ4cxAzPdS2fLook8oBwf+EbM
X-Gm-Gg: ASbGncuvAHj8FT0CK+wiVYZR4qGPOrF8KTroQJslR5Ilwex0BUeTKhVEyNM/j74GOyI
	EG5pVsQVHrBFvR4FqnkxExP7C1Zy849sxYppoIMay+wpwNdR9pi99R72pUPUlPbD4S9Kqr3zccT
	A8zwWo7wBleEd69KUvCJXYwduBXGYmhSgVoqN9gXI5hm6WC/+jPJr9ZGd1WZgT8sV8m5aLhcKDV
	g5Te9tvtwuh/JWKmD17k99DihNpY+ulxCTuIUb2Qvt/ve/W12kTUEZ+izZFJVMJgmDP4rGdgmTf
	EnZ/k5ARjMVj3i0pukr2B+QFDsE4rOxBEni+4hIe+b/7iec4WXp324djBerkRcdBcgmf2OwPYX5
	VkuNLHpgqvBhXf89080aJexLzk9m+SsFLx63DeWEGGD/v+2WVc/B2nenqtzD3ISL0NBeUbN1x9X
	PuoL2P3ParHX1EhsQsTIctyr7GBZVfEkY8zC7wiWNeVfWVW20WDwLCiSQYhNQ=
X-Google-Smtp-Source: AGHT+IElWfzAepNqK3LlpQymTFB+dnzq6dId0s4n8cc9tbggmQJHdM08XYTf6C3f7CI5MrGaIVI7tg==
X-Received: by 2002:a05:690e:168c:b0:63c:f5a6:f30f with SMTP id 956f58d0204a3-63e1626157bmr8254979d50.57.1760890566174;
        Sun, 19 Oct 2025 09:16:06 -0700 (PDT)
Received: from localhost (104-48-214-220.lightspeed.snantx.sbcglobal.net. [104.48.214.220])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-63e266bc09csm1738354d50.11.2025.10.19.09.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 09:16:05 -0700 (PDT)
From: Steev Klimaszewski <threeway@gmail.com>
To: devnull+federico.izzo.pro@kernel.org
Cc: abhinav.kumar@linux.dev,
	agx@sigxcpu.org,
	airlied@gmail.com,
	david@ixit.cz,
	dri-devel@lists.freedesktop.org,
	federico@izzo.pro,
	freedreno@lists.freedesktop.org,
	jesszhan0024@gmail.com,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lumag@kernel.org,
	marijn.suijten@somainline.org,
	nicola@corna.info,
	phone-devel@vger.kernel.org,
	robin.clark@oss.qualcomm.com,
	sean@poorly.run,
	simona@ffwll.ch,
	~postmarketos/upstreaming@lists.sr.ht,
	Steev Klimaszewski <threeway@gmail.com>
Subject: Re: [PATCH v3] drm/msm/dpu: Add DSPP GC driver to provide GAMMA_LUT DRM property
Date: Sun, 19 Oct 2025 11:15:59 -0500
Message-ID: <20251019161559.6731-1-threeway@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019-dpu-add-dspp-gc-driver-v3-1-840491934e56@izzo.pro>
References: <20251019-dpu-add-dspp-gc-driver-v3-1-840491934e56@izzo.pro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Federico,

With this patch applied this also works on the Thinkpad X13s (SC8280XP), thank
you for this, I know a lot of end users have been asking about this for quite a
long time, so nice to see that we might finally get it.

Tested-by: Steev Klimaszewski <threeway@gmail.com>

-- steev

