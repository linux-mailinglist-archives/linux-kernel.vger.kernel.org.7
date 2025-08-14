Return-Path: <linux-kernel+bounces-768358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB48B2602C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDCE15C64B5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA8121D3CC;
	Thu, 14 Aug 2025 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o/yBAERG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454162EBBA7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162029; cv=none; b=I0QbOZRciINXvjsJ/QitskRacunSfWti5Tops1vC5/l7KzpoBxSpru9/yC2HwlJ4D3i2vpFwMCXHD5QABSnU8lV/zj9yzjHj8wlVMoi0b0+qO73mYifUcWd2m7yRe3VcSzasXyMKTNNX26ka0kq4xArhXVlLi+BbbWT55t27/P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162029; c=relaxed/simple;
	bh=cSYi3PG1kmS8EsKKSpfDh3ikLpsSAPIjPQtCcqeK2UQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ghx4aQUomIRu0ktr42n7maOGtu07+6lKxqQikcc7AwBkXbv/EIY0L138mLbDf9ON7hM6O/bKzomwNEqW3+UV3gnOkrOBpnhu4L6UlIAJWjWQ9biDv3Eua8TeR1icwNkWvz3bKfrmA6NuxgwzKMbpX0y7msq6ZgmAMxVbQ6eJCTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o/yBAERG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E8xFlg020600
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7PQL+hQ5oTZXy55XFweJgo
	guGD9rwse5jt8tj2j0INs=; b=o/yBAERGwhFsxJ9QtVLNymAbOSWBbIeGxnOjXa
	LjROrc3RJ6pU+4OzYRZZhhwgL5qrv3MqJirpAXWKJ9zlCEfHUGBxWOhQ6bsgkPEy
	hxnMeUYNID3qRP7xiV6Sigt5eI5wBrIgWR9wee8XYrcc+nAULjEV5ZWsHSTFxdQ4
	H8Pk8NUbEYClw/mcJfa1LQakGgreOXloDYwpZYW0EIhSi+Y5R+W1jJJPXfc+zp/W
	lsZiKthAd0mJIbpWPoa9abtANjWFbRBrWdAy+kuH77zUprfYfDLNmACfmFF3L/3r
	p7Bq6vB2yqLMmMq6ijJ5xkelQkis0aJjGsNA+naon3wmeotw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g5hmf0x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:00:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24458274406so15279065ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755162026; x=1755766826;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7PQL+hQ5oTZXy55XFweJgoguGD9rwse5jt8tj2j0INs=;
        b=KP8ylAxzujrCovbgylXMfyU93IRHpCFHC1qdjQkUXXqXUm0VwJUMJlq4tv44M1ami7
         Vg+dIEOe60ibHi5ZYv8vRvSyeVbhiQ3i2uoxwV6uhtEZ7Fk30HBmJZEhBlJmtJjnauyU
         NIMsazfo4C0ieii1Zpc57Bq4sM3cweFd836ue62sjrIMrUzZDYxCgT+or1+QyCXy8RBT
         6oxCsmzE/f0eozWWqmaBVM/3BLF2lQXCKv7tvhKxmgHM5PoYnMp0wPziz3iVCfbFUiHC
         Fr3nqNEbjQe4yyq9m5uMeO8OlAoJ9/dkl8BnAYvsDLBSSp4NiF+ini7fddcJokiaENcd
         UOog==
X-Forwarded-Encrypted: i=1; AJvYcCV+gdLIz0ENFwbhoJcWP68hmnoKF3Da/cYAdzrq7xmZKaxi/9ZpxFihh8MioMtWMOU6ctuurAprs33Ke3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqE8VJzG+G3mA2RSkhWWffbN/1Pf4clvzFb7NNB2oabSgFo/yz
	9CAEggJ3049KAFNJJSjTlyNug5oB53MNXZ0hUgS2ZvTytabBKVjpkv4TFZZotksqPT7Kxv7815Q
	7FUlAFFgZ95rGyrbqSTDRQFRrTYJGZ43yPvOVXD840j5eFRVEJgME6kfPMwAvL8jNl6s=
X-Gm-Gg: ASbGnctIwb+rhlH0DVNWU+nWmsR09YlafbCYyZUZTDsJMJMqHbxyKTJ5vcHynUAVuN5
	EDzE7FhcXaN7GsgCKsQy98kZRCMx/zpUCUY0WdAx+xS7EQSJHsZiRHtB2uCG+StN1LZui+QC5Nr
	fjJN4dTWejT+8wlsvvNmXbahBMTpUe+2cbK7R1SP/qsWzNoJswXDYLKofIzd8OkNfb+ur3/BJ1H
	xaF3q/FGEl098pA7c2agVa5EZyQy50RAH/4A8qrAbK4LVNQPBYFSm/SRdK/c+kl/P7DUcd9iWkL
	cikMCAgT5oVBQGctODIGNSa8kY+BnTMajh0nxgIVczXjfVqeGp+8+fdKlTqQsoDVvIhejwaUw1x
	GuavUNhaH02pxCfrPhTOgyw==
X-Received: by 2002:a17:903:984:b0:224:23be:c569 with SMTP id d9443c01a7336-2445853c0ecmr37034875ad.22.1755162025564;
        Thu, 14 Aug 2025 02:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCPIhhh+ffqme6GqAz5zor8kZgBnNJnCyuurrG1fH9jDZVLnI3y3Mm4ZKFoKE+VFW0fePhfw==
X-Received: by 2002:a17:903:984:b0:224:23be:c569 with SMTP id d9443c01a7336-2445853c0ecmr37034385ad.22.1755162025119;
        Thu, 14 Aug 2025 02:00:25 -0700 (PDT)
Received: from hu-yuanfang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24308b184d5sm54553785ad.51.2025.08.14.02.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:00:24 -0700 (PDT)
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 02:00:13 -0700
Subject: [PATCH] coresight: tnoc: add new AMBA ID to support Trace Noc V2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-tnoc_v2-v1-1-3285e37280c9@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJylnWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0MT3ZK8/OT4MiPd1GQLs9Sk1KQ0M6NUJaDqgqLUtMwKsEnRsbW1ACl
 mJERZAAAA
X-Change-ID: 20250814-tnoc_v2-ec86ebebf62e
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755162024; l=955;
 i=yuanfang.zhang@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=cSYi3PG1kmS8EsKKSpfDh3ikLpsSAPIjPQtCcqeK2UQ=;
 b=6VYz6XW4DASoJ2Bdk2MJld2ZcPHftrmeKhgON+JIS01U20il0rE/xsHRWDPiudmrxUOJACA1b
 WH/KlBBO4waAAKxNSASQVdXVe+dG8WfNq2icjcUnf+4kDPbxny0ec3i
X-Developer-Key: i=yuanfang.zhang@oss.qualcomm.com; a=ed25519;
 pk=9oS/FoPW5k0CsqSDDrPlnV+kVIOUaAe0O5pr4M1wHgY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOSBTYWx0ZWRfX1U5kUgODIsZU
 +DcoBhaeou1imdL/31K2AN4v2dKS7Z4ZlG8aUvynNjWMfSIOA3hSpKdMeQ66qhcU1P/wq8SytrO
 fI/3eH1XVTZRzZQLTXQrv4bHQMOaxuSE5ulameis0eLKbYBgsDRrSbXmKVGsMLcOZ4uAaIIP3er
 lFH1+yIjQwIzYGLL267d8UwJrJCiy16j69EA81Ej1H8jgiU77+MTLSiQmRJ9nonigpdNft1mu0r
 0guUHF+mPGSOixGvIF2mYak7o5DG5VNgqByjzph1jh1f7Me+Ff4+EFXLzeuj0gmAV2oNY//2czb
 GpXDwCQ60o/FGUskLvrh2bYRCz19Fqo3+OF2coewEBjaEYPZHsIyyggFxZai7IC2Ne07Wu5wwSl
 E1HwfSyt
X-Proofpoint-GUID: Y-RViFxSLAT3e52Ql17yEfgdGQE0folQ
X-Proofpoint-ORIG-GUID: Y-RViFxSLAT3e52Ql17yEfgdGQE0folQ
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=689da5ab cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=w0NzrND8Ag9NSurxa6IA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120119

Add the new AMBA ID 0x001f0c00 to support Trace Noc V2 instances.

Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-tnoc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tnoc.c b/drivers/hwtracing/coresight/coresight-tnoc.c
index d542df46ea39314605290311f683010337bfd4bd..ff9a0a9cfe96e5f5e3077c750ea2f890cdd50d94 100644
--- a/drivers/hwtracing/coresight/coresight-tnoc.c
+++ b/drivers/hwtracing/coresight/coresight-tnoc.c
@@ -222,6 +222,10 @@ static struct amba_id trace_noc_ids[] = {
 		.id     = 0x000f0c00,
 		.mask   = 0x00ffff00,
 	},
+	{
+		.id     = 0x001f0c00,
+		.mask   = 0x00ffff00,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(amba, trace_noc_ids);

---
base-commit: a80198ba650f50d266d7fc4a6c5262df9970f9f2
change-id: 20250814-tnoc_v2-ec86ebebf62e

Best regards,
-- 
Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>


