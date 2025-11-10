Return-Path: <linux-kernel+bounces-892841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789A0C45EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF1C3B4A70
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A5C30E0F1;
	Mon, 10 Nov 2025 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXInIRE3"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174D430DED7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770340; cv=none; b=MLTtAC4zrOmxh7qUQ0zipBDRlI+1nZm4coaQtdku+dZLcJYSfQNyqRPewwY9ffg5M5B4ISsSX9Cvb+SODz9IYwC7xDP9LgQNqEDEfXJqGFUnwlT2gkXDQXhdYX9n7utsn9TrNiLiQevaIF2wPWEerl8d2PoJnv4AtBitOOwZYeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770340; c=relaxed/simple;
	bh=QM7JQ4r+KVKXdlBt8ePVLl+ChlxycOGtsLSETCGPfw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KE57WUa0QppaCwcvileSvswP6owCTN6dP+TJhFiKa0QQ/nhIYv1kuh3H14zncjMnrc2GWZX+u+PxIX2nBJCmFGlkz+claHM1yCb44/0Zs/kajdD5DQx2yh7oW7o0gnHJTQXLM7peAxBPzdS2PwSYasPeC1sMgnA1nd6ZuViTuO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXInIRE3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4775895d69cso14350705e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762770337; x=1763375137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKcbMV8I+97Kq7vbT6kb85upBfX0KBVPEKxg6nSihFs=;
        b=ZXInIRE3uLBbZFlFbFxEznaonyS3zevQqcDR2QGmfjOnmpzZtzP3ifTGvx60CQsRFX
         USnXbbBWFEhmlupICjx0Y0kvLzqAvb5QYWpSvKb/KWYhDwzl5p9FyuwhBS1weMA7hf06
         j2WH3WoaZVTOdzBsHfkvba/0Am4Qoeiv7uRXYDCsG0nwRVaHT97t5UQTd7ghEQOh0qSd
         hb4X9UhyAlQvoJ3o/QDMnXUNBVTbQgASxGY0QqzLzX1LmhQhVoviEVIKQYIJ/fzaomzI
         +eSo7m9mn6p4/EvbiVHfZ+ora6EYprkHW3c60nl+R3qj7sZ4kBl4yNitNefe38HwnbXA
         VTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762770337; x=1763375137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MKcbMV8I+97Kq7vbT6kb85upBfX0KBVPEKxg6nSihFs=;
        b=e0mCq/nxb4pK7EPTsqHyACYTPpf5wZmc5DvzRXsvlMEuKetmZCrlwIUusUAWWh9xQB
         Wyagsh0AXp3zMaMTAM9NWI2CrZO99+dnWmhjd7Njiwe/cxzYxD5z94mkGhfz8EN5Vvzp
         CECA6xQR2F/cVsfZlpwGtn0tZkmLtebPiK7QfLCEim8xhy21pmQ43e8VqXVV5bMMmdEh
         zXmowhEG/Tzachpex5XQW0hKtr26gCZU4IPVCKx3Bq49+0i9rBvUvZ9HNgDOenifwB33
         2jeEP5N6DGe+lwE+Q3Pt2/jxAg9ToIef0KVUQ4LiBdPklRqcxmDOsaewCZ3vNcOd0u7c
         MEhg==
X-Forwarded-Encrypted: i=1; AJvYcCULh4WkEzOCykOAVSeiZ7ielSFr2a8QpTAuxwv0B3HpgLNO0lCCp3H/5XviAza8cTaWtwZ6FKaMGgBbfXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt5mJ02RxmFLwnXwfzewc+uB10tqblkK4TCAg64/Y8Ifv9C/vq
	hPIc1JtRFth/G1ZQApbDHvMcdy/Ecj3boLKAmL1CREcKPw9+xEQCiXsyyFH20ffQ
X-Gm-Gg: ASbGncudFZBKe7VXBCCEx3686lQMj6iWisG2hBnVp3SAJfZz/QK2i1NNsws6eQVUEcg
	WHp4z9rV/hHiGfJpwts0Bmm5g7YFkFyuU/dd42QDfMaLdaQQuYiVE6VfWFJgMnQpiB3bMCOlcXI
	QdA2EZREBGJ0TFPssLeXHg2icSDLTiU/YqKPlk4eEKiNHFRn6TxNDOFMS9PZQglezM4RHMzVS1D
	kFtYrDCauCxLKiGQbnkNNUM2PtZYU+sW6oxK82nYTqIhvcnSI6fbNUB+J4kzONJpqH5LFpWgsKE
	Tk2gPMmfSUJlUidIj95tdr5pXcd+sg/+/j0MaFXqDLbQJ8sEmMB0O4GfnHoiBovpVInpVgMcfJr
	6cDJzMXJUzq+30KPLHkpPeqcTyo2JmMO4+gwrIqb2wyC1mXtPaoYrQK6ZknsIapEF1C1bEZkBEQ
	xhijnpk7xAxwg+GBjk6OSdykBoFZE=
X-Google-Smtp-Source: AGHT+IH+MISqoRxpIDcPU6EuXvAZX+QLnLFanB9BywEGc4BZ8+o4mmL1QjM0lxQTquh4+sLSRzlb9g==
X-Received: by 2002:a05:600c:350b:b0:46e:5100:326e with SMTP id 5b1f17b1804b1-4777327e71bmr63409645e9.23.1762770337470;
        Mon, 10 Nov 2025 02:25:37 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4777a96e7f8sm67326715e9.13.2025.11.10.02.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:25:37 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 10/11] gpib: Add gpib Kconfig option
Date: Mon, 10 Nov 2025 11:25:06 +0100
Message-ID: <20251110102507.1445-11-dpenkler@gmail.com>
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

As part of destaging the gpib drivers we need to add the sourcing
of the gpib Kconfig file to the main drivers Kconfig file. It has
been added just after the Kconfig for the comedi drivers as they
are most related to the gpib drivers.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 4915a63866b0..01602581b880 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -161,6 +161,8 @@ source "drivers/greybus/Kconfig"
 
 source "drivers/comedi/Kconfig"
 
+source "drivers/gpib/Kconfig"
+
 source "drivers/staging/Kconfig"
 
 source "drivers/platform/Kconfig"
-- 
2.51.2


