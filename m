Return-Path: <linux-kernel+bounces-882982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84185C2C140
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2576D188E4B4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E41B26ED39;
	Mon,  3 Nov 2025 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUB7/teR"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2264126E6FE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176511; cv=none; b=Wke84RsAh2uQVaZgPVHD5ZxRUoB/QjP+etvD61QFY2616SQ36wBTOglB7CYsgq9RQEmsCYz7Z88nbtGB9UBoKVh9JTWnQwVeG9XbBIbeMtb/hVKuKrF9YIK8xWVMJWj20WI+FFDJariKfBya5DKHfMVUT7TD/coubyEdolUihnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176511; c=relaxed/simple;
	bh=a/0/o672HILvcrBC8UMnh0+jICqHg+2hF1l++OJBTvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljwOLpxT98iRWAxE1C4Deky87YWe64x0G6gFBH5S4c7rjY0qrNNv1vekzcZHtXpIrVNUIKgnkm8c6ZpkwzcRqJN96qf2wxtUiSSl89bjLKohl9ALh7DchLUcKLDIZzPas2orlNvj2L/oIThRNY6o9Ef5fK0Ct7tNwjDMpyNgp3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUB7/teR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-294fe7c2e69so39193765ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 05:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762176509; x=1762781309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/0/o672HILvcrBC8UMnh0+jICqHg+2hF1l++OJBTvs=;
        b=hUB7/teRwxPh77bUseJ+4DUX4N3n4/+PO35H2pWxevsj0txQrUTCa63BSMdqeM/Axg
         A3Kw93sP29Rq3m4QoE4VMmriioylQAoJH9IXTTKaJrbVufxlvKgfe9VfBEZRKLU8iLy7
         kslV1ynxgMMyyDwE/yY5qUi5WelbUt7c/rIBQCo0bliIGhgcTGspGrj0vqOZ6To6c0bq
         LSNVeR1Go7wkPDxKZWBosh0wsh8hzPQ1L4ercCJ/R7o1WItYWp/xxVjElrCL8/mWdglD
         3ETnZEH4axKJeVswN0aPZKZ6Xu/Yc8RMbHO5k+Tk/eqQajneg+rBH9FOrEdIZyFvZnKS
         3qNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762176509; x=1762781309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/0/o672HILvcrBC8UMnh0+jICqHg+2hF1l++OJBTvs=;
        b=trEQsmL3teK8gO8Ob2uUpGuHU/v2+Lf3s+y3TeXXowBFvOgMBciLuYUpgGNnfGVekW
         EBqdmoX6W0MDYLSwTvj9DxBcr0YIdWQkPLfl3WD9+AljxJ0Fp6gLgH2CjnzlYmXu+ogi
         JvcO4bgMdj/YTLwl4nUn0z1tn9lmmXCWh3vu6KL0mjzL1WZMAmDa/gn8EJb5gJYJgtob
         AS38MJ2/owgA+utXCja2wKb4dyo7DoNoiJZ+XeYoihvLH+KVTF14CDGjfOUQyE6Jrnwt
         ZgWjEsQAeFSga1dGKwZgOKKL0cbpXeYouCaz8nphKVFirT6AQlyhDvAYW0qXPI/Thnu+
         jS9g==
X-Forwarded-Encrypted: i=1; AJvYcCVVcEQLIm6vqo2khci9E4iU1BtqcCcx2xjyw5W+qXc4mICTBRyTtRqVoZQDMTxo/8KDN/8dX34GuFDVaas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/qEx9Z0QNY0B0G50pAuk8HsPgwh116mPTMhgFlTBI82CnHHrT
	GN/ep3lEvJFZzTFtM3PwroqRh7xFpVM5Y1nC0wcVFcOvT55LhrS+9u6j
X-Gm-Gg: ASbGncve4JfUiOIWTgQQJdIm1XA3NC6ab0yfPtPn42J1RCFBnfxpegxH3cC6yp8hIRV
	xtZegoz7j9zNaHIixdQQl2QjmQKMmbmszIMNx7IHpIknQTZu4h2gDFZC2P+vcOsR6wO0Ko75OAi
	RQs+wYGFeLdjslxz2PLWRPS2w6u0FUsdlJwJohcwM8hW/uZXrDBGIilTbhyctteAuzAWTu1Xndx
	WxoTNm5nz/dBbhkzG9wI74II08PkzYXIWQBG3OkwSDLSB3+Lavyvhb9DfuZTc8oWOT6/Vmtnw4e
	LKNb3/0nlm4YXr4ehit8CSrJ2XwpwC3pT/99JnRrnZ4DFrL+2fRBM0u1GG3YLLmAzyWjpi/wGPJ
	+QzAdb9QNzNKyTREdHnVggJ8p3ztJT9XBlJqw2WkH62Kiazfqt12771YffsRd+UpmVRlbLIFQWc
	l7wC6Uk1k8dMM=
X-Google-Smtp-Source: AGHT+IG3Bz413G7PruqflPWXNLKUnYycOv6TQ59T+lA4ajnSHeznVZHAUWlTBcJ7V7op9pRaVX6D/Q==
X-Received: by 2002:a17:902:c409:b0:276:d3e:6844 with SMTP id d9443c01a7336-2951a493552mr185358855ad.33.1762176509063;
        Mon, 03 Nov 2025 05:28:29 -0800 (PST)
Received: from server.. ([103.250.145.217])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b96078aee39sm8062786a12.1.2025.11.03.05.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 05:28:28 -0800 (PST)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: zhangchujun@cmss.chinamobile.com
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	reddybalavignesh9979@gmail.com
Subject: Re: [PATCH] selftest/alsa: correct grammar in conf_get_bool error string
Date: Mon,  3 Nov 2025 18:58:23 +0530
Message-ID: <20251103132824.126110-1-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103085147.2276-1-zhangchujun@cmss.chinamobile.com>
References: <20251103085147.2276-1-zhangchujun@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Zhang,

Patch is fine. However, I'm not a maintainer or reviewer responsible
for this part of kernel.

You can use the `scripts/get_maintainer.pl` in kernel source tree
to find the maintainers, reviewers and mailing list for your patch
and resend it to them.

Regards,
Bala Vignesh

