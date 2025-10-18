Return-Path: <linux-kernel+bounces-859092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C03BECC32
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 11:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 48EF63503C7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 09:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39592EC087;
	Sat, 18 Oct 2025 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjmuNPcb"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8D82EBDFB
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760778847; cv=none; b=SIlGRIo20z5NACMLBTh62QM+wgynjyxQacLFkdF1pbeelNVcFbIe9VQ8jOKNR+T9cR9GoFJxyMMoKHHsUYDEVaQUihzyAiIxpeBQQT+mRFdaTs1CiRdvEH/1LsD/+18bNVlEwSoBXrSu90D562JEwBLRwjd6W3GNCT+NhfM2R4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760778847; c=relaxed/simple;
	bh=h8vI1OluXSSJBLDiMPvfyfHYRqMJdQ8aWra4Wn19dbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxLrGlLJrUn9QyerkBmr87S105+6TQ5XdDC5wgdWHiKhDK0Jdg9IB0FXEC7SLGNrilbyA8Zy4GHyslSwzN9xmlhCZ0I0bHt24p5pGwrZJSj7sbuYKmrPPEj85dXFdZwPCOeCHTCwHk9OzwgzH6WMn6yA+wA399irlBgSE1RlqGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjmuNPcb; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-421851bcb25so1510318f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760778844; x=1761383644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOKCu0zkFmuT3TdzBpwieB/b/YLMRGqn8lOHXlUlsOM=;
        b=DjmuNPcbunkdFgS7KFhmX2Lx+WSR+oE0Wqe5ZhguvU1DHvXeItTe+i1lSuKzr4QL9I
         XXGiHbBaX4CphPqTEhPI8Jou755srennutK+9Qta+aMsn/dUPvMDE1PZCFeDUdgHXi5S
         kGqSEP/LjOUkQEhbxIChDLzaqmjIEjOZgRaNyNI+zBq5ryWNLQnwUsASPzExtKmTNydE
         4b2UjHS85EFnFjv0Q7mJLBgWswvOnOEvnlFy8ZmhMvEgeYQ434RWD59mn3rAsw+WnO96
         JqjMm4aMN9ej0jRlPuI/98aie4wQKfjvJUprW/Tk3+kefnKGYk8gZ9+yRSzxFl2Iyg98
         6qGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760778844; x=1761383644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOKCu0zkFmuT3TdzBpwieB/b/YLMRGqn8lOHXlUlsOM=;
        b=c0PESyTqMDjIekC+yD9uT0tWE3Y+Ij3kp0h+0MKxAdyUhviweArdnQuErbcZG4k+DL
         Kmjc/4PeEO0qC5D7ctyTnSMimi+SsBQ/UrauFjqX87v6ZiHHLFQSctAht0OBEAaXa/2c
         TWjy6HUEUI76lbmXw224O3hb/VNhfU+94+WAldatX34cXThohecL09Yfyrf5+tRoJ15e
         ynpUNFazquPMDehSrOot2BTFEiwLfxGbn8M88jY4aEuK7p6dgu/AKxEZW2tSTYJgvgnt
         I432jBQmig6HzL9f/OIV/mHTJCEQilaQPsNkNxigetYn1LNdFmc31IqsPyCP+whQVgkN
         +TSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkRwCEeAM7/bMYH0fUE4xyayAnodXfIM8jMTgnJF6YSouHqzTetjxAW8Oql/gbf007IT/ZZsIpPDjfvZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcHH6fGHQpOPQiGjOGEUnETuYp4Hv2uQmuRiO80sxCXEASmGqi
	MseB2v1XxnHfmYY1lqsLOWnNNC2+wuHj4PYVc8xfcJL5Zshxwq+fI/s+
X-Gm-Gg: ASbGnctR0n+p8FsdVYWjhxuyPq40IndBpO8kDmaJLJbmkXgEuo0AC10trZVA6a4D9al
	4FjJiOabUmB8nXl2zvqT6VrFC/xV5MIhKZ5FN+7BKi25vhTa/xlV1WIjdItby8l96lPMBCZRqHC
	5S7p9O39OkUyzpW6Xu9NJ1TEgRUW+TTUhaFaZuVUdtKZ9wafceL6PFajAMjt178fBdQjf81kiwK
	Mbvkh6hH57xRuUthAqx67za5DgSyQK66j8F7zv0pssZ0IQxZ9en5yQ2hDs8MD4Lw0flwVT6J1Pw
	x5tuhbPkItc40BW0weaBHfZJbfKp15I7JewG6QtdTNql0VcrzW8EK78SDmzMTMsbB26QsIbeSjH
	EN4wfIrDnyGNlLgxG5WxbQH/XZGxBkF0CT7izDonUaol4+wVbU+BmrNpeGhlIP5Bz5YcMu+X+Vi
	zfM/ahLVA1v40=
X-Google-Smtp-Source: AGHT+IEnUmucqP+clc1J7H8PyJUVBC91ey+7MbB47Yf97h5uYlKqoAo6/jmHTzo8phjYWgEIm4e9bg==
X-Received: by 2002:a05:6000:2f86:b0:426:fb28:7964 with SMTP id ffacd0b85a97d-42704dac9ddmr4901776f8f.61.1760778843896;
        Sat, 18 Oct 2025 02:14:03 -0700 (PDT)
Received: from shift.. ([86.124.201.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144d17cdsm121034215e9.18.2025.10.18.02.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 02:14:02 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: andi.shyti@kernel.org,
	wsa+renesas@sang-engineering.com
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH v7 3/3] i2c: pcf8584: Move 'ret' variable inside for loop, break if ret < 0.
Date: Sat, 18 Oct 2025 12:12:58 +0300
Message-ID: <20251018091258.5266-4-chiru.cezar.89@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251018091258.5266-1-chiru.cezar.89@gmail.com>
References: <20251018091258.5266-1-chiru.cezar.89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Require spaces around '=', '>' and '<'. Add space(s) around binary
operators.
Move 'ret' variable inside for loop. Then check if (ret < 0) break.
This improves usage of ret variable.
Enforce errors fixing based on checkpatch.pl output on file.

Signed-off-by: Cezar Chiru <chiru.cezar.89@gmail.com>
---
 drivers/i2c/algos/i2c-algo-pcf.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index 41a81d37e880..40c4d622e8c5 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -183,7 +183,7 @@ static int pcf_sendbytes(struct i2c_adapter *i2c_adap, const char *buf,
 	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
 	int wrcount, status, timeout;
 
-	for (wrcount=0; wrcount<count; ++wrcount) {
+	for (wrcount = 0; wrcount < count; ++wrcount) {
 		i2c_outb(adap, buf[wrcount]);
 		timeout = wait_for_pin(adap, &status);
 		if (timeout) {
@@ -272,7 +272,7 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
 	struct i2c_msg *pmsg;
 	int i;
-	int ret=0, timeout, status;
+	int timeout, status;
 
 	if (adap->xfer_begin)
 		adap->xfer_begin(adap->data);
@@ -284,9 +284,10 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 		goto out;
 	}
 
-	for (i = 0;ret >= 0 && i < num; i++) {
-		pmsg = &msgs[i];
+	for (i = 0; i < num; i++) {
+		int ret = 0;
 
+		pmsg = &msgs[i];
 		ret = pcf_doAddress(adap, pmsg);
 
 		/* Send START */
@@ -321,6 +322,9 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 			ret = pcf_sendbytes(i2c_adap, pmsg->buf, pmsg->len,
 					    (i + 1 == num));
 		}
+
+		if (ret < 0)
+			break;
 	}
 
 out:
-- 
2.43.0


