Return-Path: <linux-kernel+bounces-695770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82E7AE1DB3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 16:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73766177802
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 14:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE432951CB;
	Fri, 20 Jun 2025 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b7ohHmMa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9943128ECFC
	for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750430607; cv=none; b=pm9CAEOeOGxaL+wQjYpwwaCGxvkN0DycTuZQ+eSybmB8qgd/Sq1cau5zizegpgoqqaPFar2xEyxwxgvta6Wlu6Y+mexjjJbYDr5WXLrAMOvSROq8wi9N1AhWgd6e+eJlB0SDllRvVJU8KRUZ770Tr3otVS1TW1747kdZVB9axvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750430607; c=relaxed/simple;
	bh=q3+mMLzi1XBJ7PohZjjpMPMhC+9PoRP0OfuNA0C+/hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5Rk7NyxMMbfM2WvdHQ7uxTXtsdMB9h3+Cx7ScxEXyMhaHkegUc5SA6OORPxFOq1hazmH92Itjt5eR0RuI38EBu3a1GtJNciATvHXnVDRXmOr/VOtIzeaqbkO4mkZFIp+bSHdOQ5rsUzCVENeBdU9pHZeCDUJml4oNDs0MX5CQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b7ohHmMa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KDCGKx023298
	for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 14:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HRDy2PkiT+b
	Jp3nZw0dqpJsJDfHdIbBg3CgFYYVmwzQ=; b=b7ohHmMaBH6/bo1E7YjTnSPn0Fj
	zfq2f76Z0Z9cQwczCpob8P6YxOjr/sHaH3u7t2kCC+kA4yGG95VBl3zzj1D3zcmu
	JE4xhuHntjJtYVVSgNCZF4UEjKGrHnKZHPwAFy0CG2j8f1aNkZMm3YegvMXFfmJi
	75utTkipnb0Qy4sNwIJUJQDCiU1SR7lQDTo004Sy1VUHYANcH4Twd/BGkxolm/cr
	TVbsTcsV/HuX+yTFZ30zMkjtnwzGskFt7Xqz5fFgXsh2+RtIrlSKtXE4B7u7rR4Z
	Q/9vUZjfNpgJZDW3f0rixW4t/GoJEm4IE5CPXUslC1Qmh/VhONdlmRMhD0w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791h9kk8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 14:43:24 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7425efba1a3so2159093b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 07:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750430603; x=1751035403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRDy2PkiT+bJp3nZw0dqpJsJDfHdIbBg3CgFYYVmwzQ=;
        b=Kl/YnljDCXe9n8M4tuKB4tbtvMkTLdEbIVpVmQgpSxSxBjGhsVtTvIV4FrWlPkxa/J
         k+I4ZUimQtbewqaDAbLuqWu+Obv1P2xlANpQPvs82LtEj1TFCFmeREaLfwQ2Kh12OYcB
         Nob1I4AgpDsSbnDlbZNFemuYbgVHwcwO0UTo0iV1XDV7NUtBxC8zPO9wjBSJF8tdkr5j
         ArAB+tsKnJe+lwW7hxpNQ32JemNEmWdKMMd9gqUviAu++MCW5Qc8flp2VyzIaymHr2gE
         B9MiXBuwYV266IbJdy6xw2RslM8BVH4LT2WP1Cbt3jejXGynr8DzUTGcqQA5xDpwwqDJ
         D7aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQLgquOwYxstCuDC/vb/tVLytUqr3DOUpArUbyiRkCmM5YM7B2ZtNVSK/+GfRMjZo6Db34KVZsQ3SCr5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG3JYi4ATwnsNqfNmUXm2yTSmoB7e3xG3eH2qIfhuk2KUkw8tg
	AMO58VQSKjXpBi0B6PxlWSEaTSNG6a3lOEZ7TA/La4LKjTRzm6p7JjFWca0S5ZQKria3Yrzcm8h
	T6vB1pOYne0Ogk+i6gx9qqtUHjsUmJygndcZnOEHQgY4GEO1rOuC0bTB0hqbF0/ZaMEI=
X-Gm-Gg: ASbGncsgKLob2HJa2B49F2CkJfH/POCNtM1C67VxuPQJMumXeciePIsWmP0wRttJ1R3
	WALfg+ncsaEP7t8V3P/ugtnKCeDnUveWUOTw1ttZgbSSqXOUcT+HLbEpy+/MDjksOmdCp2ZWDma
	HBNxwpBTz84OkS4mJs0ohTonqdO7zVkZVAguI/ZPn3vJzisD3ihPtsZ3uXFQfU2AjZVLWCJmk52
	OvBuQdktAPQ1uVBdw7iqxY/EjJk+0lof9yzboHcwPrTrH041mo8deEVzwskoRDlYpcnsEhE2KcE
	3Z8MrsWuD4Lre2xk7LBuShzvGZkqCuxP
X-Received: by 2002:a05:6a20:d48c:b0:220:247:29e5 with SMTP id adf61e73a8af0-2202915778dmr4964066637.4.1750430602932;
        Fri, 20 Jun 2025 07:43:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFngm+bBwxJRzLg91zDCmzRMd4IZHrpLNM6IeTMuAbWKdDIwmWciPiCOoEVycUeYJx8shFpnA==
X-Received: by 2002:a05:6a20:d48c:b0:220:247:29e5 with SMTP id adf61e73a8af0-2202915778dmr4964024637.4.1750430602499;
        Fri, 20 Jun 2025 07:43:22 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f12427d9sm1598224a12.48.2025.06.20.07.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 07:43:21 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Daniel Stone <daniels@collabora.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/fourcc: Add missing half-float formats
Date: Fri, 20 Jun 2025 07:43:08 -0700
Message-ID: <20250620144310.82590-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620144310.82590-1-robin.clark@oss.qualcomm.com>
References: <20250620144310.82590-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xapKiQ_Rcgx7UlrIbapl6Pq7tNB08xt7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDEwNCBTYWx0ZWRfX+bNqu6+hF5/U
 RFTfSHgfAiPgaGZ0MNxwXRaAgDgEO6Z/5s3WEd1obfiaTESpz68KZzFdvcDq1sm6dTQ05hzIJxv
 RCBiNC0bwogfV5+IkmabRNy+iwxbBUZctWwvGSzut/M1pjzATmv+nDx63h/Wp+TydyHIkRZGD8l
 JevKHj57tqbwi2XBDseUjS4ENouKLBiNlKma7c0vb8JNvs+u2rmNH9+07rUIuG7LCejM+ykhgv7
 6aW5hYODfKjM2IBpivhqPaqKdgrzADUtku+WqzqL3U967+JmRjdcOoo9gtJARbdpaCHXVYQiD6p
 QTg1g7DWLtqYs8SlLIwON4XLv7kh+sCCDZzdC2/gyeSa+A/lCFzbTjh20yg9XVW9IxBgeIS1pHq
 rehJZ9kRqd5U1KzlggHzXemlt/g+EYxONmSoEbhKpi2RRBdgSbGrK23U5NwqliQcizaw6xax
X-Authority-Analysis: v=2.4 cv=UL/dHDfy c=1 sm=1 tr=0 ts=6855738c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10
 a=EUspDBNiAAAA:8 a=M_I3Rqd0q2e7SYdxXhEA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: xapKiQ_Rcgx7UlrIbapl6Pq7tNB08xt7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_05,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200104

Not something that is likely to be scanned out, but GPUs usually support
half-float formats with 1, 2, or possibly 3 components, and it is useful
to be able to import/export them with a valid fourcc, and/or use gbm to
create them.

These correspond to PIPE_FORMAT_{R16,R16G16,R16G16B16}_FLOAT in mesa.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 include/uapi/drm/drm_fourcc.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index e41a3cec6a9e..3560ca1ffb8b 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -218,7 +218,7 @@ extern "C" {
 #define DRM_FORMAT_ABGR16161616	fourcc_code('A', 'B', '4', '8') /* [63:0] A:B:G:R 16:16:16:16 little endian */
 
 /*
- * Floating point 64bpp RGB
+ * Half-Floating point - 16b/component
  * IEEE 754-2008 binary16 half-precision float
  * [15:0] sign:exponent:mantissa 1:5:10
  */
@@ -228,6 +228,10 @@ extern "C" {
 #define DRM_FORMAT_ARGB16161616F fourcc_code('A', 'R', '4', 'H') /* [63:0] A:R:G:B 16:16:16:16 little endian */
 #define DRM_FORMAT_ABGR16161616F fourcc_code('A', 'B', '4', 'H') /* [63:0] A:B:G:R 16:16:16:16 little endian */
 
+#define DRM_FORMAT_R16F          fourcc_code('R', ' ', ' ', 'H') /* [15:0] R 16 little endian */
+#define DRM_FORMAT_GR1616F       fourcc_code('G', 'R', ' ', 'H') /* [31:0] G:R 16:16 little endian */
+#define DRM_FORMAT_BGR161616F    fourcc_code('B', 'G', 'R', 'H') /* [47:0] B:G:R 16:16:16 little endian */
+
 /*
  * RGBA format with 10-bit components packed in 64-bit per pixel, with 6 bits
  * of unused padding per component:
-- 
2.49.0


