Return-Path: <linux-kernel+bounces-864885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71102BFBC4B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDDEE5E0D86
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9E4342CBC;
	Wed, 22 Oct 2025 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dBF4TwfF"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E75341661
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761134642; cv=none; b=uWuOPNQ5oGqg1mp65TtpzzYdYwtIBkCl474nIZkwgKqfvvYPyeaBZ3sBkLtLUrRt9wwGqZVPne1b+MUjslZAxmH/cUoMduyfwavGeHWpKxYnp8p2BhDC224/+xr8GxhNtQB1+MZZkvpyKJ7lNMeS5ZmmiTDkd0xk4oTJeI6woqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761134642; c=relaxed/simple;
	bh=M0R/PwVK/S2JynNC9isNcWEnu3MHAOkI+7d2xOVY6jo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jegyDo0nkV4A9fVO9edBIX8Pd3Wqvtz9afV1EeIQbsCidMh7kQ1AKx4mi0V6U2Hco9ERQas6gVhavU+LKbBCuCT4RM8p2EGXKrDCfNjH36V/ss7g7y/ZJpEEs4ccoV22uhIMhjBVTfFxPuVm+S9VHfIh746QD9QBZuDYp6+lbuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dBF4TwfF; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4270a0127e1so3367781f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761134639; x=1761739439; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EBT8mdGkZMhubx3+PF0HBbvtvo57PUFO+I9TYpkyhbw=;
        b=dBF4TwfFy23l9nZJSovKohhu+yBasyGsSjW/F8VmLBFWwzhYMJVdMNISX6tZnfrK4n
         dVdrgt3YMqiD2BWtXbUeoiYpwB3lsPF8RTet7SeXsqoVVyRZp2VOLD6/InP4x3xWjcbL
         9VaFFnW5EfEg0vsuUxo1gVJE8hgpnPQtK8kK2IuGfcxBzAAH+UoeCUUZzCDwZcP78mSJ
         uHIEugLcC8Hv4E9n9hae9N3A17zVcOEiASuXtzSrjc+2iu5R2GdAbcqWzNUbWWGD+rF/
         een+NC1A5LjcdDMCSj1BHzGCLO/roTHbWP6qR4+VaiEq+n1VB/91ezwYuGxo5gyCV27F
         la6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761134639; x=1761739439;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EBT8mdGkZMhubx3+PF0HBbvtvo57PUFO+I9TYpkyhbw=;
        b=uRRQlc/Ld5YwH7CC9RlUQHId053IIHmcHkxlWljZZCWeZpg1TwqgpLq7vvO+HizDkV
         bb2pRMAV3dPlaLSttWIyKxOBSpUK4AmIB5zDUn5XTP7Br8u4iejnhttBmIsF2ELpUnUi
         VhleAK4bhjKCPhX38hDaLoCDndKoOZ1ARnSV2HtrU3kkPwyz1EeqJICbMrJEbM18dKPB
         DB1D2+pAGRzTuMLYDs91UwPeFZ6y2OWgp8eU/cFxZt3hkFPwzqxfmFPiy6obraEy3QYh
         QzX6OaCk4U8YVdbSkde/U70SyxE3NkVhOoVzIeIR66f51Z8zowEF18/0DRN3FvvBqsR8
         3OmA==
X-Forwarded-Encrypted: i=1; AJvYcCX3fhmp7zeAGPd9prTPVoVNTXV76BFFB6GGIn0AMTFMqpemWYoMOYAcQi7rKDWpg5Gjo8EJKEaLQa5+u8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL+OvraWem5QrlIIxBsv+UMSx+tMyPy8006w9EwYxM3oWZeqA/
	GxR8T14q7kJwz3ZGVKELC4588w2eOusVOMBVKhTRz3rOwEgKU5AQ92n6Yyj38fbBDlU=
X-Gm-Gg: ASbGncun7DjpmJ9jddma2d/xJY50HdslR/FHvChYm+6KmTi1b10TNgdob1rW9ANBSRK
	E4Edcj4W+QJnH5ID2rWuZ7Xg6XqLBNBvFxo129y1UFJZ6pJZxzH5eSg+/c4zTCUgTkayNpUNfiP
	QM40uqxhLBZlhulUhlvalQNM1v9b63iepj9u82VE49HjiqTwz4eLRGo+ups+Mo4QJ8VqPu6ij17
	BC6VUXnNv/VAw22p3ymH/yTBaVftp/xI/IhEqt970o8IPQbw2kPRBr67uY2rXFUvb/wZqN8Yiof
	3WYMMziCe+1X+Un2jh28R6VdTDCmN8ryfJ1VrG6+3vWR+xrA/MorAavgwr0/lOLlcWEoEcCV3NK
	QYyq6P3q9ixPw9b5z5W9jRz2xkXiR03QALscz8FDAbayuLAFedy6tudioQZcIeMtdr/9WArES7C
	UJk7Gcfg==
X-Google-Smtp-Source: AGHT+IGK45Cu7R7RqMblJ0H20sOThyXTHE0mGsTieR9rpgEJC68Mu7KEhV/qc0jaopljgaHcbYAevQ==
X-Received: by 2002:a05:6000:428a:b0:428:3cd7:a336 with SMTP id ffacd0b85a97d-4283cd7a3a7mr11330553f8f.63.1761134639094;
        Wed, 22 Oct 2025 05:03:59 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f009a78csm25019851f8f.26.2025.10.22.05.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 05:03:58 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:05:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] remoteproc: mtk_scp:  remove unnecessary checking
Message-ID: <aPi6eBlFLH43A4C0@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The kernel implementation of snprintf() cannot return negative error
codes.  Also these particular calls to snprintf() can't return zero
and the code to handle a zero return is sort of questionable.  Just
delete this impossible code.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/remoteproc/mtk_scp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 10e3f9eb8cd2..9b624948a572 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -1127,11 +1127,9 @@ static const char *scp_get_default_fw_path(struct device *dev, int core_id)
 		return ERR_PTR(-EINVAL);
 
 	if (core_id >= 0)
-		ret = snprintf(scp_fw_file, ARRAY_SIZE(scp_fw_file), "scp_c%1d", core_id);
+		snprintf(scp_fw_file, ARRAY_SIZE(scp_fw_file), "scp_c%1d", core_id);
 	else
-		ret = snprintf(scp_fw_file, ARRAY_SIZE(scp_fw_file), "scp");
-	if (ret <= 0)
-		return ERR_PTR(ret);
+		snprintf(scp_fw_file, ARRAY_SIZE(scp_fw_file), "scp");
 
 	/* Not using strchr here, as strlen of a const gets optimized by compiler */
 	soc = &compatible[strlen("mediatek,")];
-- 
2.51.0


