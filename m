Return-Path: <linux-kernel+bounces-880245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA13C2530F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECBE63AD273
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A961634B671;
	Fri, 31 Oct 2025 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUUtjtw5"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2E034A797
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916129; cv=none; b=IAOc7CsezkNTyrX7id9uSVV+MoRVI4zT/tfBvQvC1MPwBnPg0IUdS7ojtijiI+W2/rPcjn2mZfA5Dpduv1zWY6t6ljN/FJXwK/DLRwX+SpCGuJhMAM08n441dNQne+EUUxE+BqZhBgOI8Ufvfs7nu6okBkYccMO3EqcG6TFcCdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916129; c=relaxed/simple;
	bh=EosaKghg3U4iEB4VNfXlrr7R7XRj9cKNCldq2SnVuGE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wn1gEZBahIP6GMu1gY98SVDsdoxlLYACZC3lxGdeC2TxP99sxD6U9Hr9I4Ph7AGkta6UB0yZzr2Uxejw1ap6+5NXpfM5MQyntBje5SYDgvBqB2zGgU8+b9nF1iuiqUnH8/XWoUiUPJ7FNq6/BQPRRLozmjqOleZwRInxCeRDsj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUUtjtw5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-475dbb524e4so13471845e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761916125; x=1762520925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqRNM8UJyFRHPSXkcGPHCYH6LJDeMorOhD5X06t/AfM=;
        b=QUUtjtw5Bec6TU6z6eMOw6xB/T/fzPCeGN83/L2GqjzbyYPbbc81gytTCP0UeHUCFc
         q1YTUM4MlAQSnRDq5HRH3GO/suyhruk7cAuGS7ZnbrhSlGBUk780+PrBO4H59GW/GnH3
         P9FtsLuOBeWm6BFagci/EaunN6LkzbXdZSXtVkUbTuxG3xUfjX1K/ORlMZTm7Bqlb9ue
         lvtJeP5LACp8/pHJELgey4lkd9LtR2wFDQ/JC1G9GCCsr0e6iiy3hgtIZi4orPKuYHtW
         JPSKj0zOV4NkE4ANQU36pP1aPlESoHuHKGzErU/nSv1YhWpDVJGFEzZwSocCzuNsHi0p
         bQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761916125; x=1762520925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqRNM8UJyFRHPSXkcGPHCYH6LJDeMorOhD5X06t/AfM=;
        b=bQuvIncDTNtB4D4Fv6kqEdAvN9S5WKVErs3yTI0TUV97f/PKHDudTRloNMS/l3r4om
         pBz/PBedeS8zb5AuCWSfJodKTQVMebnCC6UlmlhvrddZ+uUOH42FJg07ROuNytPY1ZOK
         AxqC3j0beLxSZxqptmUZw8cIiOtSBYbd9lM7TvFRRDxiJCpQmldhGUyVYwtjQYFEmWdt
         ybZl62atm31rczIvK+DyHB24lXIAd27DmRuX7ackbm5mciviPH/qKVn5rPxKb/+prVBp
         nq8tcQ2HGibaLM3tAah2Ss7Q/K/giVAkUCeoAYiXnwncxCqu1s/Bd7AOG2EnIBnvDTRk
         jK4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYzZquCYyr57XFKMA7PP5jw2Y6Haxplwm3M7yGRXtzpwzQQK87Fp4KyAqVKUs1vWlgR9ydUACDIG9smWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5qne9H83L4peh1jx8wOnUpC7f8cfYlUOwXH9s2h8W65f7uPfX
	NDCQfAbm4/+l5ec9dJRu4+zviFbltNmZULwmuBVSgQiQajBKivBwIXLv
X-Gm-Gg: ASbGncvT644lJ90jiVoBKBu+mNFwFPj79o3W9j+tvZrc7MC6Rvmpm5wIg8GTELe3+Gr
	IGFgsVts3TN3OTgfGAnSn3cVJOH7kR6LQ5hP3fyKJ4KHd/r5o1tBaBk1VUqrkxP01LBMHR7bGKX
	yB9ELXymj3yF59B7dAcGE2eYvHLGA3aQtMHLuIMfwLWULuCNtOltbOB1ot4Zuql2eO6hxYXMAD5
	/0GN+xc+9sDEFoIFwkvJlwWpsrGdv+saFpVNyznZ0q9i31X1/NE2XTjh4D2UA15YkEqozGWHXGX
	CGh2oUBaoue2BqVMwqnmDMl+4/0H6+6uh0Gb+OA5nDilo3+dDvzUfupntlNZK03MYCJW7pNXrlO
	q0p7kRJ3i0UtYAlnJNYB0Zul2Olz6YdpqR/d99rgUU9B1SWu7Jm9gdA5RaElvGDiueIbsUIJE+R
	9PrlIM20R7TbAeGjgIwaBTReo7TqbiD1KqQRfgStWn
X-Google-Smtp-Source: AGHT+IEoNfiwO1WHuUv2jGPlp9HRKqmIwSQeCnw3J3BsUZNvSFpBuq37GRGL35QSzOpJZZmZcOGadg==
X-Received: by 2002:a05:600c:6304:b0:477:be4:7a52 with SMTP id 5b1f17b1804b1-477308e11bfmr29796555e9.39.1761916125271;
        Fri, 31 Oct 2025 06:08:45 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-477289adc18sm98339815e9.6.2025.10.31.06.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:08:44 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Raag Jadav <raag.jadav@intel.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] err.h: add INIT_ERR_PTR macro
Date: Fri, 31 Oct 2025 14:08:32 +0100
Message-ID: <20251031130835.7953-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031130835.7953-1-ansuelsmth@gmail.com>
References: <20251031130835.7953-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add INIT_ERR_PTR macro to initialize static variables with error
pointers. This might be useful for specific case where there is a static
variable initialized to an error condition and then later set to the
real handle once probe finish/completes.

This is to handle compilation problems like:

error: initializer element is not constant

where ERR_PTR can't be used.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/linux/err.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/err.h b/include/linux/err.h
index 1d60aa86db53..8c37be0620ab 100644
--- a/include/linux/err.h
+++ b/include/linux/err.h
@@ -41,6 +41,14 @@ static inline void * __must_check ERR_PTR(long error)
 	return (void *) error;
 }
 
+/**
+ * INIT_ERR_PTR - Init a const error pointer.
+ * @error: A negative error code.
+ *
+ * Like ERR_PTR(), but usable to initialize static variables.
+ */
+#define INIT_ERR_PTR(error) ((void *)(error))
+
 /* Return the pointer in the percpu address space. */
 #define ERR_PTR_PCPU(error) ((void __percpu *)(unsigned long)ERR_PTR(error))
 
-- 
2.51.0


