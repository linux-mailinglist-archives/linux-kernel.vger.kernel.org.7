Return-Path: <linux-kernel+bounces-775370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3311BB2BE5B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EA307B7361
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BEB321452;
	Tue, 19 Aug 2025 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H2fpEWDz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29C3315774
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597728; cv=none; b=Qwy+FXxX1+ZXF+LWAAVIFwHQnnZf+mKY2vM6Ve7peZzH3zYHH1HGrAr3zKa+0m2NBxGjWDBux95pbC39L/gQUhKdi0luH8htcklkdTHTNm6DvRrUYKPj9LHUEQ2u58oCdacBPC0TSWXrKw72QlxqsXufY9ZpMNaC8y/xEb7yQys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597728; c=relaxed/simple;
	bh=mQUBUhTJIkEVd17LK62zreRv2cywfgL18mzSnA6eK8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYpVFOGN9zFSo7+NgT96/vp8ldeqrvCLP88HQMpiUR/hs4bp/hdozhErL2NvOupu/Fgp4jui1fX8ywm7TvTW2VG4oOWfP7CaLL7znUtIIlcOGKOkdTH8LwHHLt10Lf1eK6eGM6FKU0N46N8L7jzjpKh8vZDWF9XE6JnAhOy9plA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H2fpEWDz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90bOV032432
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CyLYEil3TgY
	GIEbJLbRwKXtE0JhM9xLvHblciK6/Lyo=; b=H2fpEWDzCMGPpdzHOA+QGz7T/Cl
	gujKUvvQjXE43GZnfZwqcEByV0fU0MQwmmrcBDjFKInUlI4DwFRCDKHFV5qEL8LR
	yDjzVlQXpC6YtIoahF9Y57Iy+WVGO2GAljNKF0yZ6QNM++X1MkrcymcYlsgvUio2
	BTvrb75ZIsX+Sexdu66Ak8tC3GZ1oa9rcWSnuVEr4ZFJgJWG5ox2qY1zbnmy4vdA
	sLPmFvQv1KSc7VfOfmey+qInSswYWE7e5/6qi5uZqd36rZhiEbKFrOCE3o731XdR
	+VX7nWQD6rsQqK67JEpedjuPFpux8ms6IhSPR+AJMw74iKHjzmMsaROsB7Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj2ug56x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:02:05 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a9f55eb56so118386556d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597725; x=1756202525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyLYEil3TgYGIEbJLbRwKXtE0JhM9xLvHblciK6/Lyo=;
        b=Y3IrhD8jNB9bYvRcGHKMsHKyK/q5s+Rwu+5mCAR0sD4qi44KHXG4oe4/TjHAGmK7jY
         LlYlmWkATN+/7XULJJcz2cdFddu+NWRwspYOJK8qMvT9ZyDEC44MkO3rAa5ze2LU+tFk
         h40W+5/MwfrGZo3+7v+v1XJuARZWecXGoYKO4u2CyMoycAea6zFD/EpoV7iS2c6k70jW
         89GTM6kaqi7L1EP3DqoQyLc9H7D+IpI0Nl0J7VDRcZesWJZSxrXracZByNmBRWj6OHV+
         WRF0mV2aPB14SUJcHvQ99y1epwYW8/qT6xC9/yixwR8i42IPzGe2hSJdtURLpXkuWJad
         CGTg==
X-Forwarded-Encrypted: i=1; AJvYcCXBJsKxfp79y4wDE54e7TRdYhliHsVO/oxy5QWUwxrDKZpyIAUBj6iSCjuAaxRYgkW6OkOK03y7EQDiqqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ4RW/jcFqvLHyHLvSxc+70IgH+Eru92bt4zZ2tdihqcHFpHZg
	TjwyEElQGaVrIQLodNNzdjFHCyH9ugp0wGhqvbD7GlxbGz2qLTAgEgH7FMHYK4tYZBPFLeqB1j7
	bTtmwnaYlMl7z+L8ar2JLh9WH46Wm+az9njtvT89g+Y4HlinDbbY6gMnEupaKp2LMWw8=
X-Gm-Gg: ASbGncvV/1RHI4drEh3QVcnXx0QXxjpCtRlRnomp/tl9f6Gv6tXb+oAY6dJnSfFhFWZ
	ppP7GBpZTSupwE9VAIZ+/QRMR9kq3nTcgOVL7xacBdi+AXCwEGMociDT2souKJx7nR9gFxNIWKu
	iOUpmgk97gs6RV/VaZsXSFJDuP0m3Ir4TMLEpIGjzGiZc29QAUB1tH1fnYMjcMIwagcGoRnB2HY
	b6D9PIbe4mYXoZujz0E6lqqej1315KAVKz/CWrEW8vewKSM9AY/czLVS3PgVK3hy3Xs/8yEnOfc
	9yTm9cDWqGvGNsOAcnfyANU4ylsvjKMUWiURdyqJc387yyMC1a7fZA==
X-Received: by 2002:a05:6214:2a4b:b0:709:e4bd:e3c7 with SMTP id 6a1803df08f44-70c35c7f293mr20655106d6.50.1755597725027;
        Tue, 19 Aug 2025 03:02:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlef5fvYHbEQw5uwMBXPbV5Fx40atId1n2DDJ0PYdtFl7HGNhvHUTYV91uOxgGjKr9W2eTfg==
X-Received: by 2002:a05:6214:2a4b:b0:709:e4bd:e3c7 with SMTP id 6a1803df08f44-70c35c7f293mr20654606d6.50.1755597724513;
        Tue, 19 Aug 2025 03:02:04 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c78b410sm216169635e9.24.2025.08.19.03.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:02:04 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [RESEND PATCH v4 4/6] ASoC: qcom: audioreach: fix typos in I2S_INTF_TYPE
Date: Tue, 19 Aug 2025 11:01:49 +0100
Message-ID: <20250819100151.1294047-5-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250819100151.1294047-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250819100151.1294047-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=MJ9gmNZl c=1 sm=1 tr=0 ts=68a44b9d cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=2ggkzc9sqBovd5WwaRoA:9
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: bHczXP6oasguYcgh7fhQ37wPEA3oNlMk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMSBTYWx0ZWRfX74zgycyZBgte
 H33Df3eAtjNnOnTH3LZW8vV4MyxcGej16xlhjgmqg2gyjDLQtsOFrjTUl5MSrkT44zRQLGKX2Zn
 lX4wyQcElT+bw4rGwQ772lwuQe3D2rADbbfwg0byuX0pQYYgGcQSptFXQulXl8lxKIUhNPFlSk2
 ZQfJDLJQw339KZ7EmRK8Sc08i0DSrRDKN74gJZxoO9GTa53Sr4nmmY9Yi02P1WAnSoUa8sx4RF6
 5n8vzopzbP6hUliVWSbjw04rjafRubC3nHVKJxxYCjPHxwz7T3rfGdabp/EQ+zS6R3VfvzVw+Xc
 Wxewobb+sQXET3psByHvYMV02HJLc9SINUiEOM2m9aJODTPgNQISx6RmtpFhHVTQ8IDUfdipVXh
 Z80N/cxt
X-Proofpoint-GUID: bHczXP6oasguYcgh7fhQ37wPEA3oNlMk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160031

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Fix spelling mistakes in I2S_INTF_TYPE defines.

Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/qdsp6/audioreach.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index 617bda051cf8..efc918452e2a 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -462,8 +462,8 @@ struct param_id_i2s_intf_cfg {
 } __packed;
 
 #define I2S_INTF_TYPE_PRIMARY		0
-#define I2S_INTF_TYPE_SECOINDARY	1
-#define I2S_INTF_TYPE_TERTINARY		2
+#define I2S_INTF_TYPE_SECONDARY		1
+#define I2S_INTF_TYPE_TERTIARY		2
 #define I2S_INTF_TYPE_QUATERNARY	3
 #define I2S_INTF_TYPE_QUINARY		4
 #define I2S_SD0				1
-- 
2.50.0


