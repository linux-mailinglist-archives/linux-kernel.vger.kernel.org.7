Return-Path: <linux-kernel+bounces-842358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB025BB9927
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 18:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51CFC3B8C6C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 16:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C8B28853A;
	Sun,  5 Oct 2025 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuzcgHgY"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ABF19D093
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759680041; cv=none; b=AW2/mnj3dHBTvvJx1LrxCiuzQsulXifG0mmGl2epWk9oGpxHAxpI1MIKZdBOkhnXIPN2dikVMj7ftrxIyQlmTbXZTyXzER39iN5mp5qOMJnqjcBzDPVgyAHPydsGBIn9bOUH7QwoOpGn1Sw943DrevVjZGRSWThITWR/5wOHsqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759680041; c=relaxed/simple;
	bh=7BRb6CSK0kHsfrRjcYu7qFOHp/n6tLKeA+N2JV4fpU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=He2zGmTS+6tRhj6DQlLE0I5Q23E4VDXeKL3qp/pdEBWBj7LGkFNi9c6AECj0Lo82ykcje/d+cbHTbq9ZOu125SU2WFAFuZeXFMzKqtdNNDWcXH9MWP8ogq/d0Vl/pxaQFXvGRswD0YokL9mOjt3sQyQPkauBIgCDmMnVlLuHFr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuzcgHgY; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7811fa91774so3012749b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 09:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759680039; x=1760284839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qz4lR5kbOnskyYsmRn8uXD2AKGP9XR4BeNV5R+i8u/U=;
        b=AuzcgHgYKPIEPYp2riIvfIAAMzBaud+ZPxX6kZOllVS/shiC6w79n4pLhBtu46TDTw
         iOI75VQjT2hy23xiopCtAL0OxybbP7SfzeDRdlRp82huDRYAQ2GNWw409Fn5JsbmGyx/
         gYPTrIL7LTp+vAPA33pgDbLZb3pvUPolacBh2pNydHpdYjgRWZ7RRzum0kvpRv7NpsGf
         93jUPEAxFNTKJCBLoFy5jbQVqQlJjnU/otvjGTfgreD4py89VHLy7Pv6Y+iG2RHrsh86
         lDf3UAYH4Hhx/yNgbqE/q9usYOHD0OXw8ZKW6zshZjZCYniWyo9CB0IiqlAuqZCJ87gW
         GNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759680039; x=1760284839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qz4lR5kbOnskyYsmRn8uXD2AKGP9XR4BeNV5R+i8u/U=;
        b=kIay6eAhVpmDx8jUyE7EHf9BqsC+kF6DVDCdchzI7k9WwgbxT0raDRDS2OZTxkSwZp
         ZXsolpZhn7OUt6UkuG4SvRCE3/Ek3PhjtpcVf1Aqv1EyLgGDwNzPWH9nYfbxwUVDencZ
         vrYEEG1/dL6OSg/nKVx3HcCTiTMES4RHfdGNNHaLpp3bothKjVajLXaYBYjb4jt5KoPS
         vlHRHyxayYvoKWNzMya3iJkPOyxuiqCpLSxM9NW4tJlQIqKzwu6Lp5EAJxk58lkEa6pV
         6I81fJbIgB4GDiwpL1YYUwS4uIHNI6QUaF7Do1ZRHamkXBwkL9emHA3/X9/roumhRgTG
         EUYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl2GV/eTu/JtFZxbtsy8yuAMQthcSopA9JLdo7up7zsZ0mRkOkd4ZYw7vHjuHIQdmgNiwjht7AtneZ9Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxStyRAEQ26eti8WNx8ObsRbrjeLxgoFJPBhiUi1aeHBPydmsPd
	yhhXiZTBHmEsQw0KsDJbXF3Ug8ngSIxJUbvLSb0MUOL6NgEHrO/f7GnG
X-Gm-Gg: ASbGncuAe607nl4jjAH4FfHDTkT5BwfDrec1FL3fmHfdoH5G26P0e5Lz+hcjjOMAJp7
	yShbqhOAowOeiBQ1we5pvRiULT9SmnVNkSW9WQ9P9eiakWYtZmhtoDKrVJ+Q4zeVBjYg6jHyhFB
	mCf+CzKRFXvbRWr/7JZdUX0l6HpwyWV7bktiU7Fh7hNENp1oD/syqzUyBntGtm2/94rbnc9Krxn
	8ldl8x1pzq+s+irjnjX9lwcXqRVrZcYajmTAw0r+rysMZkWI9h0nGWZcqZjStVgx2Tm119Ocgs8
	N32M1xcOJ91z56hHeC50nLNRPM563ZH03ntU6Ts5u0OsoESP7v/pQGLr1DNmTuZfsUjcI7p5GFo
	RML2YEYolZk9bvnre7DA1grh46t9Py2qIPK1vCVpVP994QFS3F97B3EQFHgjT/HOy1lYL2v+IXP
	a/VCqH9g==
X-Google-Smtp-Source: AGHT+IHewuFi17KrFS7X0t8DS6EyPzjrL5dATHWslXjMNmCmJ6tcyhcCvWNdOUfcbZvUZETwG2aRBA==
X-Received: by 2002:a05:6a20:3ca7:b0:318:a8ae:289f with SMTP id adf61e73a8af0-32b6212bf4dmr13538197637.56.1759680038933;
        Sun, 05 Oct 2025 09:00:38 -0700 (PDT)
Received: from Deathstar.anonymous ([172.56.42.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb3d95sm10145241b3a.32.2025.10.05.09.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 09:00:38 -0700 (PDT)
From: Rohan Tripathi <trohan2000@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Rohan Tripathi <trohan2000@gmail.com>
Subject: [PATCH 4/4] staging: rtl8723bs: fix operator spacing in rtw_ap.c
Date: Sun,  5 Oct 2025 11:59:20 -0400
Message-ID: <20251005155920.381334-5-trohan2000@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251005155920.381334-1-trohan2000@gmail.com>
References: <20251005155920.381334-1-trohan2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adjusts spacing around operators (such as '+', '-', '=')
to follow kernel coding style guidelines and improve readability.

This is a coding style cleanup only. No functional changes.

Signed-off-by: Rohan Tripathi <trohan2000@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index dddb02c0f683..4d11e7a84abe 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -1471,7 +1471,7 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	wps_ielen = (uint)pwps_ie_src[1];/* to get ie data len */
 	if ((wps_offset + wps_ielen + 2 + remainder_ielen) <= MAX_IE_SZ) {
 		memcpy(pwps_ie, pwps_ie_src, wps_ielen + 2);
-		pwps_ie += (wps_ielen+2);
+		pwps_ie += (wps_ielen + 2);
 
 		if (pbackup_remainder_ie)
 			memcpy(pwps_ie, pbackup_remainder_ie, remainder_ielen);
-- 
2.50.1


