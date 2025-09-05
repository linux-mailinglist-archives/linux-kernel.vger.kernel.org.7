Return-Path: <linux-kernel+bounces-803267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FCBB45CCD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03CD3A5F51
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A54302150;
	Fri,  5 Sep 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="klSrKRYG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CA7302143
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087082; cv=none; b=RzSUXAOKDIWWcgTcUOMu0OfKu0hO/ld5KM9j9/eS4svxqDUVL79eFI3rwFrEWRMU1k7mrIy3EVrNmX9I+7VuOQBZcsItpEKJVsA0/vxfchWrWbvp2r517sf6LcoE/zi+26GnNnRUiPcfbZBYKZDRnPDxU4DFOeOxF794DKxXm8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087082; c=relaxed/simple;
	bh=vmg0oYOxevk5nWCek+pJEZ1daibBK7o4kDXZ315AyTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2skp9AeYObOHS/deeX+KET6caIGYog51/CuNb5QKIo1atsV2o/aGSThyxn+Vmd/iUS0Bmmw3lYdak8OxcOWiW/OL6GK08NUXFeinJPJawSRVmHkHzSDLooxp9bxzzpjtrAUH2eXtUCnPExYkYeKdDP7lJFKTpfuvrPDGHBUYns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=klSrKRYG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857MgeK008250
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 15:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qv++HabcA9y
	4aEMaW0PNus8L2anA3PVptVFL6UgEzvw=; b=klSrKRYG2iH4+3b6N+L/zW0QrBu
	a5Rb8y6dAsWe2kBgFh7MCsjfzBTHzR1PL6QSHWkxgL6XhNsfUG8y41FWyziC/hry
	J9TukefpVzc+ntMKUo/cGr1aWH6EQi3/5V3qEN3MA7SY32B750umUAcmOMdwko0w
	moCP7QjEr1Rvn2KZLGIE1hJuyL6nOsNhLk+FW4yXvCNwW71eT6iFp5aDfudCEaT5
	gMHuuKmQjwc9HXTvIXwSkS1i48FkzuIuATRT7oyFnzqHpix0medqYtAgrMVnMAI7
	aAgOmyQqxOoarPGEkM/riUkquU/i6n+v+BeAudTC84D5igMU3qDJQFdeubQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjujau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 15:44:38 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5d58d226cso49637791cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757087078; x=1757691878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qv++HabcA9y4aEMaW0PNus8L2anA3PVptVFL6UgEzvw=;
        b=EjaYWGBLkOLjF70IeamLCdBY2IOdkaq7gQ5Hmg2HO2fJKcGResR4U3FbSxpPYgDCq5
         ZYh9fRbmwuz3MjYseUf4nZOqGz4TfcZK7TR0RvvGvsQs24yHQhsoyiYLexdvFtjJxrKR
         BkoM7pb6HwZya6YwvzcnTXGGFySVr39ymYpZAiYeO4aAMElJCRSIRLusYZ3hZ5EtfaMk
         jWHjGIKS8Cd/vpYJCe5YINWjMUz0ewiKf8+OXLluCWFqm+7LdRJBjff4tHCYmK22NWew
         2H+rja8R2duq7zqEKCxJMBMgKhrfqzGwzdt8LnOkG1m2COHflT7Fme8qvs4k/Z5VYpZR
         otcw==
X-Forwarded-Encrypted: i=1; AJvYcCUcuGkL7sawKnT6ULMuJnH5RrQTA63IddXmcjF3yoLBY6x8KB3KM/wDxBXf//q62NYM7LitT7miVQu7/k0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYiXqPIEG9KZAS+cYD7rgaBDAqga5FV3oyxRbbwaSbUar49+7P
	n8vKFBpvencMIdP8dWkz1ClwGwJgwoIaTjFGda4sGw7xeQhvgc0J9dmKNeP27XZlUt320t13Tlg
	1W5be+qXIFWkC61y01BXmbOl692jVyrZ2M/H3rCocSt7Fz9dqf9Yh5ISFY5rN8Gqfuow=
X-Gm-Gg: ASbGncuvMEn+x13sCy6eUCDHxgN0WxAN+WbiQYpf/2PyNBUiSlduwAhUnAzHcD4KbBl
	kd2wmJ2V52UPkh3oiWyW8Y/H+7H6naH2C/zqWgzh4ATbVMe3zMnJuHHQdIJFzBUMIf3yTs3s2Xo
	UC+S/DKG95S/ENjXJf8CZUdtEgEnQN72CdcDJntP316LgzlEXWT9XZSBMzQb8cje32T994Dtlmt
	iUU80hJPBsjyW7sVRUpF0kt/l3sL1RVpSfhd1WJGnLWBuYQ6sX+s0vQq2eoMm+dDqYc2r5zCDoH
	D7RYXgxW0URp+1PCn3M/OhvqPtzmrJS0CDeGniOKZWQre1c66rUi+A==
X-Received: by 2002:ac8:5c91:0:b0:4b5:da71:ce7f with SMTP id d75a77b69052e-4b5da71d400mr53788591cf.44.1757087077916;
        Fri, 05 Sep 2025 08:44:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfPWdh54JtUPfB1le9155RfINKV1xe4VJp0Xip0ilNblDszr9jrIP5rzVTnhlLQvIFuLirlg==
X-Received: by 2002:ac8:5c91:0:b0:4b5:da71:ce7f with SMTP id d75a77b69052e-4b5da71d400mr53788271cf.44.1757087077420;
        Fri, 05 Sep 2025 08:44:37 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9bcda91dsm165716585e9.6.2025.09.05.08.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 08:44:37 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org, srini@kernel.org,
        yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        neil.armstrong@linaro.org, krzysztof.kozlowski@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, linux-sound@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH v3 01/12] ASoC: codecs: wcd937x: set the comp soundwire port correctly
Date: Fri,  5 Sep 2025 16:44:19 +0100
Message-ID: <20250905154430.12268-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250905154430.12268-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250905154430.12268-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68bb0566 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0i9YUgi2cL8IzqKwLzsA:9
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: VVTp8fKjJiSjc0syx2CqGr5ESNV4PMm-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfXwVhqfhaENuvl
 kDLyNih1UbE4atL/4zfy+Rylf0trquEmVSH3uvlC2atgmiSj1LLQ810tWQrmWKGFN+sn4hhdRfY
 F/IfbRLSEkULVxJDJKCYw5xO5qZzwYOLtH5PXTZGamEEMg5D0AfqguMH8DOJCkLOyX9mgYKb/pI
 VpTxNq7vFyqg0D2QXlUL+8MhbRjXBMvNCtepWtdx4+tTnCb71g/SBHkHuPfJy3aHkuEVt3fzNT4
 67nqj1OPt5xD3mb9SnzDc750SF53JeoEuVPZSUbi0mGc1e1klVHNPJ8kphVEXHgXxiTab50aOiS
 LehG0t5lyn/bmjH79TWvDQdWoS7xlRPS+JCEMixLALfQNuGSTMaoHLwXYRizwyfvaBXyS87BobM
 /m0gZX6p
X-Proofpoint-ORIG-GUID: VVTp8fKjJiSjc0syx2CqGr5ESNV4PMm-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

For some reason we endup with setting soundwire port for
HPHL_COMP and HPHR_COMP as zero, this can potentially result
in a memory corruption due to accessing and setting -1 th element of
port_map array.

Fixes: 82be8c62a38c ("ASoC: codecs: wcd937x: add basic controls")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/wcd937x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index 3b0a8cc314e0..de2dff3c56d3 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -2046,9 +2046,9 @@ static const struct snd_kcontrol_new wcd937x_snd_controls[] = {
 	SOC_ENUM_EXT("RX HPH Mode", rx_hph_mode_mux_enum,
 		     wcd937x_rx_hph_mode_get, wcd937x_rx_hph_mode_put),
 
-	SOC_SINGLE_EXT("HPHL_COMP Switch", SND_SOC_NOPM, 0, 1, 0,
+	SOC_SINGLE_EXT("HPHL_COMP Switch", WCD937X_COMP_L, 0, 1, 0,
 		       wcd937x_get_compander, wcd937x_set_compander),
-	SOC_SINGLE_EXT("HPHR_COMP Switch", SND_SOC_NOPM, 1, 1, 0,
+	SOC_SINGLE_EXT("HPHR_COMP Switch", WCD937X_COMP_R, 1, 1, 0,
 		       wcd937x_get_compander, wcd937x_set_compander),
 
 	SOC_SINGLE_TLV("HPHL Volume", WCD937X_HPH_L_EN, 0, 20, 1, line_gain),
-- 
2.50.0


