Return-Path: <linux-kernel+bounces-813712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDF4B549D4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D51DAA43F7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05892EA479;
	Fri, 12 Sep 2025 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BNxdJ9SH"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6222EA146
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672913; cv=none; b=iWyGwIpg119HhyT2IPET06HT94hPTYZmB2WVF30UlsKzLGgDmBO2wozXgOLuVpa7VcCtFgXBLW8a2mG6dPh3/xtnMGufk/G/xJ0RW1YUFYJhonCJA3/Jp1v7od+t90hNdpcgGYarkhAPz6Vl7bh7gPkYcKtXmo6SWVM62HUQbos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672913; c=relaxed/simple;
	bh=9Xnub+aG1PV1dQTR+IUOLBKey7HQBEotF3KU/JN9EVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjfJWii0M3vR4QRzVRLCTXs+aKT/kEq6vBHAQDjp+WpfZGsjWP8Di8dbyqPCUnxz6Ddbw7UFiDwueq958PyGo9qXpO757ArRxg8018mTALX/CpsMeHtmQAwWNQe4kfzq7j+okMIllvm3Envl45bK+cwbLym/9w3JbpLbF7R7cZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BNxdJ9SH; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b0785be64f5so473090366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757672909; x=1758277709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=un/dh3o1OQzm/YZ9VD0JDeVLvel28w+/U8FyUou4MB8=;
        b=BNxdJ9SHJ9peZihV+vkpVVPX9G8bxWDabnaJpKW0QURrAangYFSahZU8S+F3iqXNPN
         ejV8J0uf+UNmHgDB/Q8ccA1KflBF1JJnNtt4CGazrbqsr2c/CXOUqX8bVhF9MvX1JRTH
         ZYutLFLBCfNs7QNRzBVRhnW9czahkDsm/DRxZcom2nzvwdF3lgHvk4v/PuZjanP3UUba
         dG8mp8Uj6dBzBYcjNb1IzOWYzbzQgF3gzcKRvLQ0+C2ZB6mftUT5LGC1/jsIXqdC4/9x
         3j2c1Q9DKLGPZIcVbdVROICSjYjcmk2xLTeMsRaj/9n+tvYTUV1DAAdTg8qZMMjA7nuC
         athQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672909; x=1758277709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=un/dh3o1OQzm/YZ9VD0JDeVLvel28w+/U8FyUou4MB8=;
        b=i/bC2FbkbzkzphDUif4auhn15rYS8sSSEgIVp4wKE3BE+6yE36As81SHq9fD33wvS5
         KK+AUpSTft/mAO5+YxsvS9BN+dHsKSfrbzvj7w9RFbldDLM61PZeXbj6apJ0FzRbQ0gA
         cO5gcF4jQHhUS8GsKHQdtVuyrdmWBrcldeqW6GZ5Dv247gbJPeLJ8Ov9r/oxJKnTjj5f
         9y5xEEwH9RaUFj5Tx0SMF++BGvRCWoSJHsB+v0fYNR5mJXZyNmoqxsPwsHafyFHrxBvT
         R0HF+jrh+rNciQCx4xBn6TVZV+05VIk0u0v+PEItBvYfB6/MKovlfgAHSi+AaRCab0az
         3+/A==
X-Gm-Message-State: AOJu0Yx0LsY6jGadcEHIJLOTPAVvP6QI2yiQNWJI857sTTkO3XPcCFRB
	4C0DzkdObzj040Watx28n8PAYyJS6eD6Wpm1Oty10xj3QyHZbX1HNnMov+22hAlVoXc=
X-Gm-Gg: ASbGnct5fc6wmJtonSFvIm84Q8JuXcg5oCxvGsHsizsbpsfuJK7OcxJuLqLkPvJ8wML
	KF4AykaRkPjqsTXOCtViJOFpF84IQwlWjRLfYGJAMQIj0KLci3Y0gFIqHpSto3iR8UgQz4qOUcW
	Tp0YdPVFVYRvqMvPbNetQ1M04o0vTrF/XKQ8WwWk+FCE83hSeihtwyz2WXZLMtOWMhArPGlQ9OU
	P/Ubc1gbc9eFRdVNx1h5Fp4Huvsq3LHWcexICQSIXmthQMcKNrKNkqMvUKQcVkj5I07OhbrNZdz
	3P/MZWYz4FRfmGz9YHlaQjNFovsd4O2iEutOJylnTDkz/vYnIgIFgIOrOHwOcDpK5YuywKkGFjr
	+fZgio14mEpacl5l+do+S7jXzYWsimOv6OPndWW58AXeLpjDpu9nPgS5PjfHiZSKCj54+XBfXFx
	Q=
X-Google-Smtp-Source: AGHT+IFweYvN1wxjI896uLQMMJJ88jAZxGqvjXG9fLl4ZG0UyoJ6ymo4BS7akasm311u/qz3Za1W8w==
X-Received: by 2002:a17:907:3c95:b0:aff:1586:14c2 with SMTP id a640c23a62f3a-b07c22b205dmr314552266b.4.1757672909621;
        Fri, 12 Sep 2025 03:28:29 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32dd5b4sm347565466b.70.2025.09.12.03.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:28:29 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] stddef: Add a comment about why TRAILING_OVERLAP() exists
Date: Fri, 12 Sep 2025 12:28:01 +0200
Message-ID:  <7ac4049bf1b8fc31490e2f54a93abeb198112d3b.1757672423.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1757672423.git.u.kleine-koenig@baylibre.com>
References: <cover.1757672423.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1239; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=9Xnub+aG1PV1dQTR+IUOLBKey7HQBEotF3KU/JN9EVw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBow/W2ELITONGMuzaFC4EJO2DnPA5qVa68m3Nl5 kqY3AKXa+mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaMP1tgAKCRCPgPtYfRL+ Tp8GB/4/sMRSQgh4BfA0M2RYgTXPTE7B5thNmgb8DR12n+iHp52ttoXM2IjPj6u+nIjSo8eTgeq Y+1lXT1xdAd9MrCXoPSWE+M1R8CBVp1MmUuZW6pxI+nRIYGesqBPSJTkmd7Tk4d+pfv0iHliC3i do8jeFVKMABbRzVOSZ3qq9FcZ+10SYn7XLKTnpHZJ5YpCSh5QPhGvGxz4H/SzMlZD5NTI+0YZy0 8QguiF8BO+xu/RkOON82gTBznVFU25sbjh94DDwoIgjke3ZvE6Av5YccGa/CiCMPPCV3Oq4jPgD rb3xYYuzehtmpudKXImGAXRdwyhmnmN+HcXpc6VT7D/M+klx
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Just from reading the definition it's not obvious what the macro does
and why it's needed and sensible to be used.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 include/linux/stddef.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index dab49e2ec8c0..a748efcd626f 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -97,7 +97,17 @@ enum {
  * TRAILING_OVERLAP() - Overlap a flexible-array member with trailing members.
  *
  * Creates a union between a flexible-array member (FAM) in a struct and a set
- * of additional members that would otherwise follow it.
+ * of additional members that would otherwise follow it. This is needed because
+ * the traditional
+ *
+ * 	struct {
+ * 		struct some_struct_with_FAM mystruct;
+ * 		struct some_other_struct fill_FAM;
+ * 	}
+ *
+ * with the purpose that fill_FAM overlaps the flexible-array in mystruct
+ * triggers a compiler warning about the flexible array member not being at the
+ * end of the structure.
  *
  * @TYPE: Flexible structure type name, including "struct" keyword.
  * @NAME: Name for a variable to define.
-- 
2.50.1


