Return-Path: <linux-kernel+bounces-783761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3317B3320C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 20:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB393BEBE0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 18:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44A022129B;
	Sun, 24 Aug 2025 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHLIcNC/"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A250922541C
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 18:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756059857; cv=none; b=CiWrcMLm/XJN2OW4lym/LZk63CTjPa0ubHeIQMQEVGjKHSpk/5drtEhsdXWaDryA8AKtX5L/7+iRptq45dVYerVc+IMsP/L08U4DBajdxAVjEBPMSrdlqXokQrZi1ihgypF8QMKIonAus9+zFEjSO9yuaP8g3KdUT5UlEu0lUng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756059857; c=relaxed/simple;
	bh=edteeakluFvE1/Gn0LPnNiLLwnm0Gp+YtbVV4il9WUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PN7nL8ZjzFO1CHrmF1USXtwsGx6ogW13AuP1lEw7ITS0mKxAN9lqKsK97itS3Gc8rOm5558IbFQlPq1rptQW7PX4XPSxquMZKC5sO0BmB31TtMa16TTDFSqgsPgXP9UbHAa8MU/umXYaI2GYbH2bERmls9U246JkM0XoaOBidrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHLIcNC/; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso3217762a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 11:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756059855; x=1756664655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdgoKxIG8/LQsHbKVpjz+drIjpSbT2c+ZQGF2CUmKYI=;
        b=kHLIcNC/pCAH64axvC6w1u4h7y4SxRvoj0iW8mLRQ+YNrP3hVfIvij0SSbwdVfhddC
         /le6Mgee4w2bph4X4V6s3/YMxPl9Y460RE9fS+DPSetKPgfjyWeUA+KLCw9ag9PZNcaL
         WowXDtp6K5ZMsODYahs2flup6lHu5mhFnjO3SsbN3UOiNPfsRUrPBCfM0piTJ0FuYILY
         hH4/CLkO/ZbPYZdzbCcJ17a+KYusNKETFaD7UI9kpzX5cNTR/FK8HKZ3f5N5F0QElaAB
         RJwz4V6tgXuJScSfbYDltEV/GM8I8HqO5+3W/ay1Y78/asJDF5+vJK1zqoepsME3hMCt
         Ntdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756059855; x=1756664655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdgoKxIG8/LQsHbKVpjz+drIjpSbT2c+ZQGF2CUmKYI=;
        b=gu+ExIE6LrLhNTfauyt2YWYns66I5pE/f8JPF9Bs4W6AtX3ghH1mVumnGOSlsG3XAE
         Brs30vdJOoM1t32b24Bj9bay1P08venPrjnuh6pJxbgH1b/KkP2SmrX92CMqa31jz0DU
         AVDTHGB9rvX2pWcRaPX8Ps15sRsrc4luXEwrvZHbYXOuBec/ox2WYqZYzzNk4/pswOiM
         1AzxNF9V3BTLOD+1TtEC7gdzNLDZ/T7fyWVbOPOeSc97DGfWO4iRCH6tVhEbsLLbgi8x
         r5TG66ggrtsdzMKEcaQjPadbmxWxtWWoMHo7ljJlGfnPk5SJ0r6b3H7GGh8jHQE+drHG
         HYwA==
X-Forwarded-Encrypted: i=1; AJvYcCUe7VEwNpO6i/QG79DGz0CMPU5KvsrWZ5DjJpA7IwCLHO7d1LOYLFkB6nQf9Taj7R4jkTUcQ93hAiFtzY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFtrALNEhaWhEp7fqDwU+rH9kmELVfHG1KZDdf5ca8l+mxU4In
	38uosczAenHXkQQdhuebDewwMlaTOo23mprAQTVDAUW6lMz1FMqYWZVg
X-Gm-Gg: ASbGncshFBXtmaK1DkuWbwXGcwALlGY013N0nvRfEQiafQl0hulI9WKj/6IYsbuWwoA
	xIL5t50DspXLkgf1fpipxZAI57fnlFLsfroTmPymzuYleVAVy++/WTqzfhIg6rj1iWywDhXYf0i
	gH3BJUsrk/vI4DnRpxm8laCEhZFjDuGDC037uZ07ufgzrE/6A9Sg5V5g5vEk7qVfglawNWYCM8N
	2n32dvGbqwHDIlXYKd3CCdJUQxgD5nM3tjlrcRBPM3DywZyMWQMIzRkBmX2Mis02Z/x506vELf8
	20VewWWPB4uFJndeRc8PraWEauxKYUDVLF9s+cFdBgOxQyUIQrlKY4aWnqX8PltRamGUGZ1rga8
	yczThsUbrdXt4//U+acGjCgRH9DabkQq9dXhcOfIqGcIuuqfmpn2hd/INMvsTmxA=
X-Google-Smtp-Source: AGHT+IFTU5oW4ymRV8/xPeqRq4/qqEYx3zIjjLkoyBxb1dFnjnFQtkKwEnEovKNUweZV2b84+zY2/Q==
X-Received: by 2002:a17:902:dad1:b0:240:8262:1a46 with SMTP id d9443c01a7336-2462ee54512mr127900995ad.25.1756059854831;
        Sun, 24 Aug 2025 11:24:14 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466889f11esm47903635ad.150.2025.08.24.11.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 11:24:14 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: austin.zheng@amd.com,
	jun.lei@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: zaeem.mohamed@amd.com,
	wenjing.liu@amd.com,
	chiahsuan.chung@amd.com,
	Natanel.Roizenman@amd.com,
	Daniel.Sa@amd.com,
	jserv@ccns.ncku.edu.tw,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 2/2] drm/amd/display: Optimize remove_duplicates() from O(N^2) to O(N)
Date: Mon, 25 Aug 2025 02:23:59 +0800
Message-Id: <20250824182359.142050-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250824182359.142050-1-visitorckw@gmail.com>
References: <20250824182359.142050-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the previous O(N^2) implementation of remove_duplicates() in
with a O(N) version using a fast/slow pointer approach. The new version
keeps only the first occurrence of each element and compacts the array
in place, improving efficiency without changing functionality.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Verified correctness using the following simple unit test:

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

 .../dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
index 2b13a5e88917..5100e0e7af42 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
@@ -50,18 +50,16 @@ static void set_reserved_time_on_all_planes_with_stream_index(struct display_con
 
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


