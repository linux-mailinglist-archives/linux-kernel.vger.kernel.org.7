Return-Path: <linux-kernel+bounces-831089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A740B9B83E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308AA4C53E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234FE31A06C;
	Wed, 24 Sep 2025 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j/88b+Cc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162023168E3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739081; cv=none; b=P6TkqdNXXMFix/ahHA3Pozax9+70l4OsRiAJwKpomWXXHCmpO/eCZmftP3rTT+Rko4ugl+wek2UQoOXmIEtxrqW3dV/0c/m7T2A6wcyT9U5dcnkX2YBBMoIA9Y23QjUqfMiPffiMN4Eae2J9CjDyDyxjuhktmOHnrD7MSoQdnwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739081; c=relaxed/simple;
	bh=T97FcqFinqlzYxgH+rSC8Mhx5RHcO1oPAjZVAZ06tiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YyT5Kud1BsSyy1DiPsDYTzHBAYY+Xpocm7Dcyx/OQhAcyla4Tyftqam6OT7jcSBsbmm8pDE7aEzGh6MTjNcKQGcTVTeGrd3cTqBONUpMOtFCrHuhP0GkvZD3yla4wxmuwuAFdTY64jmpXqz8h1CEkOLq4y8PIu1GF1MZsWrBc3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j/88b+Cc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCiXBm002657
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=B3CY2hC1i6M
	iUSuv87D5Jm3r0035lg4EZdY8cNWgc48=; b=j/88b+CcFbQf5LdLKyp9gg/yCNq
	hucTkUaIzxSy8kKOePLODXXyHnun/YbaWXGPyiQNp/SeLyZ+I6LLxKWNjKV1GTC8
	LEFgFeqC5tDKZUzFsBFCfgPnSwyGdwFbFgLkj2Q+Tn2vBSfRvnGjKyN/9O0Ol/Z5
	wgNV1J89pGG1yepsEq1mrv+yadbEBG/JLStWvOtxvjZ15OIg7HFKq+cG6Ugejy7A
	xFjqB2LXuFUlD4TcZPdcurXZ8qa64svPhkf0a0b2WFMlGEvYqzo1/r0N8VeGl1Qf
	ZiXl3GrxQ0/MVNGCr612FoF+wOXjvcO6+Nbctf7VPMQKUan7RtI3WVGwyGA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajf006m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:37:59 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b54d0ffd172so55690a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758739078; x=1759343878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3CY2hC1i6MiUSuv87D5Jm3r0035lg4EZdY8cNWgc48=;
        b=jXh33DIItW6rlVtKgqIVJS38U+AaLpmH/+3yNRnPDLU6gfTU+t6bf7aen0A07sQEmE
         4jeOVd8zgdkAhwIs60Dgac29DOo56ggIgKWUdJ1tl6bozM7Yz22ykn3mb+jAQKHrlx9C
         vwp1GO/vD4rB/sAuqbrh4e7+n+Upaoxa6holiXqsu7X7WJL8f1xAvXVd9vvSPiTBD1FZ
         UjtvLuNVLDKJZx9/Wt5pVj2eoPp+wPZl5CsbY7xCBKIp5apGunekiWmCCdeKm7K6i2XJ
         TMYMg4sRrO0P1ttWb9aPiHJR02HEbeDOxx3CZa3usstBp/xaEkbsIsJG0lhMovK/kxOL
         DCPg==
X-Gm-Message-State: AOJu0YzY5vzfNhIi87WUjfzYjgRBSPdMItzQ9tb1rnes7LjtC0dJKfvX
	VK7XiLr624rZFHFx9p0eeeJQkPKfQ5ZnbyrHzal7hAvaUYPnjPdSLkAEWSbT74ugukfhAWS+zN0
	zJfo/LtU19OS+t4zxVr9PLI/ZQKg3aqlmgLbo60gWE7fvrC5YskY+uIvsNheEoWAZnCEXnIbGKP
	g=
X-Gm-Gg: ASbGnctytQmkulxi4O2cdsvS69rd+XQh4RMMBMWWwIJ3EOmE5NlqyNRtxWWs1IeXqHn
	SUsbzo4m5rRFk85zWSJbW3KfK/gihYBJqmJpZXoSKz1pD1n6GUdIiyeVDXCfT7IP10WVUmhfLiq
	TAj3GHyakAhQ7ci9DkggOASpvffmwTIo1kkaKO8+7MMtcltXtTzMKfNS3X9C2ZtmqD9q9dyR4UH
	y6la9aFy+XU5nTHr+pM950nZ38nDwVpHQL4UwiBym4hxrizMULcOJJdvBTamUNBlfxL7vFuKlEW
	yjLvyDJrqtR0RjLKWcKD13L4ySjCPNm1QDL65wdxJQUlRUnsNoupzAAGFQX/NNcCPeJ3vck8mzC
	6OSA1gpe06wF+ml1XZKjpvzkMkhvkpCWmQpIx8nBHFcnYzoFARyZ7iz4=
X-Received: by 2002:a05:6a20:3d1a:b0:249:18e4:52a9 with SMTP id adf61e73a8af0-2e7ccc59ea8mr699687637.9.1758739077911;
        Wed, 24 Sep 2025 11:37:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYFL5L9wefd1CvJSJ4agMNAcdiizATbs8L/gXpjLu4lLw/H9iBQnCCFdWLJ/wMVOfQL8qzWQ==
X-Received: by 2002:a05:6a20:3d1a:b0:249:18e4:52a9 with SMTP id adf61e73a8af0-2e7ccc59ea8mr699655637.9.1758739077477;
        Wed, 24 Sep 2025 11:37:57 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b555adca754sm6523412a12.16.2025.09.24.11.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 11:37:57 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, mani@kernel.org, andersson@kernel.org,
        mathieu.poirier@linaro.org, konradybcio@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: mailbox: qcom-ipcc: Document the Glymur IPCC
Date: Thu, 25 Sep 2025 00:07:22 +0530
Message-Id: <20250924183726.509202-2-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924183726.509202-1-sibi.sankar@oss.qualcomm.com>
References: <20250924183726.509202-1-sibi.sankar@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Bf1wVmHJYRfKcEloJ6fCqJks25iFWlmS
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d43a87 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=5H-Rh-Mn9-agE4ZKsUcA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX5PHkWKKTFFns
 xdg4iKmmPfY+BHCwFmjvJ/R7XvwOVi0ZJiCoLJsI1DzDhfMELLthfiWcKtQUHpZHfDckcVZPsov
 JtCMzq9/hx0eqFh6jxWqUqJg1prH+Pc7OFLvVWRIyS+bVl0MnJNf8o18UjFQwd9kI7h6MV3+DwK
 GTXeJOsmrdCtiWcQrnnDBSkozKJEJgcQNB1Fo747c/H+DjzrzYiPNBgi1WfjPVM1wEB1J2xt5D9
 4AhGQdA8jFSNqYdgUtGOogNiBbJMZhcdgQOiL29gm4VpJxOutL+pePNGRbcYG3hZ5WDM0GFyJaG
 lpnQO4TeM+ZpTWRFvuf/xEWALVXmMm1PGd7ggI2N5SNL7iWd18BdiqeiXE7dP0om2rDZd/wTFMD
 gGWEMM5K
X-Proofpoint-ORIG-GUID: Bf1wVmHJYRfKcEloJ6fCqJks25iFWlmS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

Document the Inter-Processor Communication Controller on the Glymur SoCs.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
index e5c423130db6..129870185884 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
@@ -24,6 +24,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,glymur-ipcc
           - qcom,milos-ipcc
           - qcom,qcs8300-ipcc
           - qcom,qdu1000-ipcc
-- 
2.34.1


