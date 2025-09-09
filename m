Return-Path: <linux-kernel+bounces-807690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 568E8B4A814
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500AC1896851
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CAC2C0286;
	Tue,  9 Sep 2025 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsF2eeg3"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAA82BEFE4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409675; cv=none; b=c1IY/QZhawREgaIkG9NXBO1SXuHp+JIt4PpRtmaBxwgVc5HJXh1CxKeZn9MXBLZjEn2hIV4VBKEN/EJYXta6jET5czdn3AMYvDk0KECRn5AL9guCaclBmGDlWMy2GZkOH7DBe9vjoI+aSqz1M2cfVSkFuE01hR2WRiZyo33IBh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409675; c=relaxed/simple;
	bh=CG+0wRy1a928Oh0xqx0nnWkROOFbZ+qv2H3zhxvRO0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ckqKMymoKNy5kY0cHIESRY3jsqTtXeAnnTAY6K/1ecHGp0hvdydoenzPh6b0e3zqd+JPDCzIaSvD9ilC4bgoL40BhR3jwDKWvMTCi140OKheCoBorDJ5JsvhqMhJLGkRZBBvH5NiU5xENZqD0PokIQB/aer2ByPWL+CB3uV3tQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsF2eeg3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24458272c00so61031125ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409673; x=1758014473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgYXDmNS5TPYvh6DaUTaZYQ5qn88r6ADOa7zbs+TQrQ=;
        b=bsF2eeg3scYDOV+uXjBYGVowzHq0dU+DEt9O0twmiubTlpvWiF/YzcX2+B7ohkgDoA
         KE47LMpYGAUaPILrDYCZrr25kFWxbSXS66MdCBY/3xz1YfFAwvZg+AAZZ0AqfHHNVNAJ
         BcYF54kgh1V4RIg+OgExeLxMiDC3fsPMhtHmcwk8Ddq2NP2NOAAH/N38sXkVEL70/t+D
         Ixi3tOW1PWOTrIVN5T3b9g3Fct3f2GSduRt1x4MPK6Ty21SENvKz0kzmF8vkm7x0nZgJ
         P598RbTsG5gshJIWky0Gj59FCtTQ4o5IhXEXlVubBuVcQITxOcN3Fvg/Mwzrh+d9kFoq
         vArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409673; x=1758014473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgYXDmNS5TPYvh6DaUTaZYQ5qn88r6ADOa7zbs+TQrQ=;
        b=dAsdcw/hQg8rYrLWP/nCwfJRFb6mTEbJRdzKsZd8PTtOmwfkpxYTAbC0U8Mqi11/aH
         cZT7DoQFoi4ywAP6jmJoOmV7hqutc/c2h5JHPHNzpJtI5xcn6D7rzodo2zlHpnHiIeUV
         fhSXEjwyO13GRWJc8tqNw8k6oyEbhVyK8Z3KldYx1SQXODLwUcUZNB8PyNWkeA236jzA
         4xjuJHOQp9SxNVxBznNq5vzA4eGFHRZi0tZmEuYKMP1T7UzzqBtX32WrfAO6tukgBBcx
         XHlBOOe5YoMusN1qzZ9iCR2ezEqm6QkKVfL5JFC2xUSJHRuYYifU8VnzEhPeUzqNePvj
         kh7w==
X-Forwarded-Encrypted: i=1; AJvYcCWNmBmuNQ0Ben5VEjlJnlvafJpyE1psCNQ3E1c1QbbYR9RjNqeZNoq0W1R9KwqxYuG1ZDYvLuiCkA9ET0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws1NQvmbq4DDTkOhE4qaNjV+1QrypgTabmZEHptejuRH0bKtlR
	OykwPsid24S207DWROBGM1w7X5dsQwY2dXMNCKZkkco7R9aHpvCNNlnQ
X-Gm-Gg: ASbGncsQ97jEA+WREKBhQ9FM8ZOw+ARfZMgFbat/YKwUl6b7HvIGOPWTTUGcDpW0C5Q
	BnkinIfs0CwjnzotlixcB8BT+NONZpH9NnVrBzmlnDkcxWPVr/9ChVxe/LyMIZY8eduUg2n/9HS
	iznIPDPTJEgypJGIbb8+OkwQtHyCDmLRDA+XiJqy/LjzOaHRH75kaahPadxR5/wnOUgMHVqM3eI
	8bT2EaTCLnSz5aCPc1KAuDjCNCXIcT9t2bDefNkhEShCrSU2zgHedw90guFq29p5O6oVhSghsbS
	t4NFcDAIrwldsZG8j2tB5WA9Wzsz8DsfG6yEJ/QzhfsNd3XTnCyV5Ero3LJUY9xfdWBXHd2XJiY
	3sFnPCBVc3qynW7mW2RXpHgekKt6tOPXWJTmzPggk9xbyMBa8L3TolzhwKnhZTD10hHY9lYCf+h
	kf//lkD+uw
X-Google-Smtp-Source: AGHT+IFdcm+mr14A3IwT0n08p0oRz5nQAIr1eSpJ3PkFHX08AqwueO/aLVNQTRumMCN2+FK+josA3g==
X-Received: by 2002:a17:903:19ce:b0:249:147:95bb with SMTP id d9443c01a7336-2516dfcd7ddmr127430655ad.13.1757409673219;
        Tue, 09 Sep 2025 02:21:13 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25125d76218sm88522165ad.119.2025.09.09.02.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:21:12 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: austin.zheng@amd.com,
	jun.lei@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	siqueira@igalia.com,
	alex.hung@amd.com,
	aurabindo.pillai@amd.com
Cc: chiahsuan.chung@amd.com,
	nicholas.kazlauskas@amd.com,
	wenjing.liu@amd.com,
	jserv@ccns.ncku.edu.tw,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 2/2] drm/amd/display: Optimize remove_duplicates() from O(N^2) to O(N)
Date: Tue,  9 Sep 2025 17:20:57 +0800
Message-Id: <20250909092057.473907-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909092057.473907-1-visitorckw@gmail.com>
References: <20250909092057.473907-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the previous O(N^2) implementation of remove_duplicates() with
a O(N) version using a fast/slow pointer approach. The new version
keeps only the first occurrence of each element and compacts the array
in place, improving efficiency without changing functionality.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes from v1:
- Add early return when *list_a_size = 0 to fix a corner case.

double arr1[] = {1,1,2,2,3}; int size1=5;
remove_duplicates(arr1,&size1);
assert(size1==3 && arr1[0]==1 && arr1[1]==2 && arr1[2]==3);

double arr2[] = {1,2,3}; int size2=3;
remove_duplicates(arr2,&size2);
assert(size2==3 && arr2[0]==1 && arr2[1]==2 && arr2[2]==3);

double arr3[] = {5,5,5,5}; int size3=4;
remove_duplicates(arr3,&size3);
assert(size3==1 && arr3[0]==5);

double arr4[] = {}; int size4=0;
remove_duplicates(arr4,&size4);
assert(size4==0);

 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c   | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
index 2b13a5e88917..1068ddc97859 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
@@ -50,18 +50,19 @@ static void set_reserved_time_on_all_planes_with_stream_index(struct display_con
 
 static void remove_duplicates(double *list_a, int *list_a_size)
 {
-	int cur_element = 0;
-	// For all elements b[i] in list_b[]
-	while (cur_element < *list_a_size - 1) {
-		if (list_a[cur_element] == list_a[cur_element + 1]) {
-			for (int j = cur_element + 1; j < *list_a_size - 1; j++) {
-				list_a[j] = list_a[j + 1];
-			}
-			*list_a_size = *list_a_size - 1;
-		} else {
-			cur_element++;
+	int j = 0;
+
+	if (*list_a_size == 0)
+		return;
+
+	for (int i = 1; i < *list_a_size; i++) {
+		if (list_a[j] != list_a[i]) {
+			j++;
+			list_a[j] = list_a[i];
 		}
 	}
+
+	*list_a_size = j + 1;
 }
 
 static bool increase_mpc_combine_factor(unsigned int *mpc_combine_factor, unsigned int limit)
-- 
2.34.1


