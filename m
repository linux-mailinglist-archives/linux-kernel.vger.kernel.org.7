Return-Path: <linux-kernel+bounces-892837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E62A4C45ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7AB3B65A8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6E130BF4F;
	Mon, 10 Nov 2025 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYdoZyls"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEFB3093A5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770330; cv=none; b=fN34Zc5+VhlB9YrRuBIoERi+7/7hVd3aM5ZCLsO9IQH4C0MJm08dPDreJC+ZwNBQLOdMkWCH3XF6Q6luBfsS9wmdI6yEwyw1jKci/+gvrc/QsypCQZr2N+Lhb7ehMlB+vmQ05BAh3bTwqaqpLLLClbfv9jpCB/jshmPgfRFkPUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770330; c=relaxed/simple;
	bh=lf7WAmXXlNMNByc6t4LTsXWtP5fFo0VO8PLMA4FvwHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8Q7SXLoy6OfsMlWF17toZyBYJVEaQx6IEBCsaInTKhT+NbkQYnor2J4CUaiFHbh4EiK86ZmivNTmemKNATwkFs7Bd+chLykq9nnFTnAcKC8xF4+khVd0FezSIW3j5A0RIzd2QDoIoCRnCBwJxr55bHDwbHYapVbc/G0DC+McpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYdoZyls; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477770019e4so17699215e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762770327; x=1763375127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyTFCidwYxLdrRo0mrPJg5BpG+UQKkEfi+EP0wnzqpI=;
        b=MYdoZylsVVpQN3bkXSuN5bdFzSJ2+SSpRNxvmJEsHV+APqogwtWAeLVFpA4HD4YUuQ
         xosYlzIASQ6ryVPDhEP0OWQruIKeCU87DDLwhGE/RXqcYOReCsIyoKvlQwkvOIOJH3PF
         s6rQRIQK3MYtTMEEZMqIWwp9HF98sXvp07ESGe5nqm5urK+MIGUIsK3ycrZgV6NUaQSP
         A8o6ETHo2NiHsojybRxfqpqNqB2HQTTLHSeDchJmCcJchDaMyYtIx8yoZ6N2LboGAkvp
         72Z8KOBAHv6xzr+xsm6l3IjLMQmfgkTuWEsqJNK2QzWWdr5XuLBEgo3YJy7xPsO+UaqX
         XoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762770327; x=1763375127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyTFCidwYxLdrRo0mrPJg5BpG+UQKkEfi+EP0wnzqpI=;
        b=S9RbeGaBD9AJJQrj2nuqx6fByYUj4FkeJJiWU6CaqbqbqrGnetx3pdv71XnRdzKOX0
         s4I58oAdfxQ4tf1Z8YuxFLJAWIbZLXeXWHIaa9B5Wl5Arm7YgSXXZTE8bPCDoP+t2E0m
         i1jiidKRzFoXNIjATZZm0HshUzh5VEDBfYrAc/nR3HdA9N3VqZCBw4ERrUV3FADQHOoC
         dtgQ6MdtQFQt+qyFcTllvS4vClnIhzG6y9qHwPFsE44A3KF0W3dsB8TQziD3tgLiJhww
         PSt4aapcp5zisNnlrbBM8eapTgCf7jGn3bu5y2i7Ew/5CuODv7FScslbLwq9q4YGjY/4
         y18g==
X-Forwarded-Encrypted: i=1; AJvYcCUezSUyBHBnVeuR6QFO4ilpva+gtCAnSnYZPJ6dBgAj1nSbITnpiSlw+3hoz8x3FQ1GrpOIYjasmB5miIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzekm769FQkKCv6yn0jErBqsPUaXuH0XpLZJStduBrbs8Y/bT+
	rAcllw41qdStCck3KYqy1ubvPe5NJ4QgP7J7Wmrm9zyf0Fd4p61UKrR5
X-Gm-Gg: ASbGncs8ISoCNnJvgj7tBtMsOg4ESh2dmf1uKxtfqpttPrt8BUT1txr3Lc0FkLdkwlk
	xcjHJWosaGVszMJGJByhEpDwu+CwTiNKWb549Fab1mWg8ZxLlAKkbT5Yt7kxxXxTzT/ATHq4pSW
	xG2Pg8Q/1NuMxUIx21SIv35UciLBkf7qz+ImoDqU8E4pyFKkJNXgWvRiIat7bFL1Z7FLytdMnvc
	FSin2Vou3AoCckCdrf9nrtbyUsossc+TqPJjgUVQhg0fjKJdt1F++UUwRdA4S9WJNvkMI1e+H4e
	GucFuLxWr9CrhBMjiGmtq+nqzLWVsM0vVs2zUm4GBUoJOvjA73rtRQyH2ysoS0N3KbmV99IXZY8
	zx/0iFQGvlU0/9zoGRfkd+GTtcVtu7QAKBi4F9dihcni2pTsP4fM4W98s/nZYvM5RBRblvRO0AF
	7dMd7O4Wvjl8TbIvv1
X-Google-Smtp-Source: AGHT+IEWrxNPg0t0pWU7KElrVQT6/O72wqDN+enIu6RrYho/Apw+M1RPPrkl99dAqKyGSliKeno5PQ==
X-Received: by 2002:a05:600c:3b0a:b0:477:6363:d3f0 with SMTP id 5b1f17b1804b1-477732250bfmr58815635e9.3.1762770325506;
        Mon, 10 Nov 2025 02:25:25 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4777a96e7f8sm67326715e9.13.2025.11.10.02.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:25:25 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 06/11] staging: gpib: Change gpib Kconfig option title
Date: Mon, 10 Nov 2025 11:25:02 +0100
Message-ID: <20251110102507.1445-7-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251110102507.1445-1-dpenkler@gmail.com>
References: <20251110102507.1445-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the word "Linux" from the gpib Kconfig option title as
it adds no information - it is redundant.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/Kconfig b/drivers/staging/gpib/Kconfig
index aa01538d5beb..2f42aa2d55fd 100644
--- a/drivers/staging/gpib/Kconfig
+++ b/drivers/staging/gpib/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 menuconfig GPIB
-	tristate "Linux GPIB drivers"
+	tristate "GPIB drivers"
 	help
 	  Enable support for GPIB cards and dongles for Linux.  GPIB
 	  is the General Purpose Interface Bus which conforms to the
-- 
2.51.2


