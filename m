Return-Path: <linux-kernel+bounces-831376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FF5B9C7F8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D073417D703
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8718F28A1ED;
	Wed, 24 Sep 2025 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xeu+lEEX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036381EBFFF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755838; cv=none; b=NWSww0Aiy8Dv5mdM9SXpSad4HGN87aolXDP0c7mIlNTLT6k74wWF9ZQ0LVCHmEZcoflpHW9z1nbr/QrFzKOkSxGHpYr1+UvQdgSN58KpxqstxYxzq8fArf0D2V5mV1WJwrKS2pFVojbq77njwDP7jOYKq7H7OYWZobVUTQWq85g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755838; c=relaxed/simple;
	bh=NDqSa0uXUcMg8nDk+VWW/r81O87p/6EtZwi1Ub6qOys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D7WBhd1qwtJuytl+s1SdN3wIGQtUMGy4RR/6N48brxE2uyYSf/iN772HlYe8K8YhDFmRNU6iuZTQT4LN1ptjP1HUUNm+tSbiKmu9QtYgtkXz5FrR+6ZufUoJrFtF8DDhL0rqPRtJTD6dLTYJlIg2HczITGZ2ZLNiWvspNBBqbT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xeu+lEEX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCgS8M027848
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jFE1K+StjtZuaU3kr0iFGCxDv2nXJ/zhJydE+MCjc/Q=; b=Xeu+lEEX+YSBb5yb
	RAXRU+x2o/HM4BPg4yFpZaZYqgA0/1mw56aLxJYijfXcyLZyeREwcoKAe+G5tftH
	+WNPcd9NGWM6W4FCOGEcxe4LkhhPHC4IXUeS7CWC/njLy2tDZsOOfPmkGXs/ktsr
	1064ZIg57k0Xt1NSkAJZHh1LX8fN+uGulfGizw+/lTGXhxHk/1unUjLfJcsEql8Z
	kzGu9VUKTjPBMPbHmFAzPnCFuRrRscpAjWQm3f0zKjPjbiFgWLVWtn/APQq+noXO
	wgSQtQU5G4R2+CAVIu9AD1lK7QJw+9QQDnMdAmydIWIcd86SdbX0i61XV76jCqml
	WAWd7Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnxbnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:17:15 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-267fa90a2fbso14028555ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758755835; x=1759360635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFE1K+StjtZuaU3kr0iFGCxDv2nXJ/zhJydE+MCjc/Q=;
        b=ETi8IKNMEiO5GYzu1colpIZ7ZLtYlUmoXH5lmSvGrIcGwxDDfhXhjdwPspHvF+0Ayn
         hyf71duK2MgcmXgePhnFAc2GLLDWLFM3Bsl0tqvWSPG4wMFnwXl9Ld6x92IDKht5RAC/
         sF2maI5voKkUNtW2rT8C0zdAFo8FhFKsNVQAMAM87+8eCRTSo0amjUYEeYpLNnzXJ8CS
         D0aI4nAra/dvjlEYj3ccE8o3Mq1aVm3MkqwlObb33Tyi47DJxoAVJ/OcQo8YMFd0R4f8
         WYTR8+PXqHlnANH3Sch99Kw901QjmNrWnIJzKjjZbItPsVmWYw+/JS1UrknX5HHtqKAH
         MZOw==
X-Forwarded-Encrypted: i=1; AJvYcCVauFFq8JK2p7o9n48TzOtkpu/RIUflJgF5LlVSZPZXyoyKhyqy9zTnXzRBjgI2hg764bVdtOIA0hQGiQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ4Aw9nmiNSEsEpnlpSt/Xb+99AJCD2s3TU3hxKDcIK1ys6NFJ
	tF08VnrjBrj+ussG/PE1QA7CDRpGFqABYOSp5FUG5GxX3acntZys2SXzYwPAyrWcIWsObt+HzDO
	KzomxL5hsKZhh1N1TFWTbj+1XdtrWUv93bk9UDo4NGtwti7ghEeYQqINnFhbKoBbcqYU=
X-Gm-Gg: ASbGncuGj9SvJx8rMLWLnaywPzKj/ZVJEtMgQJO61jmfHKQrpOf50wSWWzNdUEQJwtl
	aYmOUa9X9lsEogyCbE4UnBhhJ5oozdBziXIoDiOyxPctgoFrPfoaiCWmhCk9BHa7mJTGTP7hH81
	ngGxCf+os8gBZJ2w3SVS2rsZsEG2Kk4zkixub2HdtmkZMxxftwWaVfy8XrkeIIMTwuQORIjjYWZ
	86fWU5guuSKEOEhEbRFNQW5CtuTI8eQrXFKsn1Pr+svbClHC+nFr2DqX8qRdKFe1itpmvNXP5zA
	O/m/vaYRq7IqgF6YFSK5rJSi3NZw8WlLCYxS5dTWsUj12KLTltV6pcCMOrpdfUXYcBIJZtQjH6W
	3dynrjww83YO0lys=
X-Received: by 2002:a17:902:f60d:b0:267:fa8d:29a6 with SMTP id d9443c01a7336-27ed710a48dmr5412355ad.25.1758755834725;
        Wed, 24 Sep 2025 16:17:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMlgdGUr/ZjZzWyrhYuIgs/J1eNkrBFx3tTLh5d32nm0isAajEsQqljF2fCZZEsbjYF9SNTA==
X-Received: by 2002:a17:902:f60d:b0:267:fa8d:29a6 with SMTP id d9443c01a7336-27ed710a48dmr5412065ad.25.1758755834290;
        Wed, 24 Sep 2025 16:17:14 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed699cbfesm3892125ad.108.2025.09.24.16.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:17:13 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:17:06 -0700
Subject: [PATCH 1/3] dt-bindings: power: qcom,rpmpd: document the Kaanapali
 RPMh Power Domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-pd-v1-1-b78444125c91@oss.qualcomm.com>
References: <20250924-knp-pd-v1-0-b78444125c91@oss.qualcomm.com>
In-Reply-To: <20250924-knp-pd-v1-0-b78444125c91@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758755831; l=827;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=4qbu+a2M6+r0wYZDajhJwhrLqY8WqPugFl0GB06oldo=;
 b=+/FwS27n6/duMm1JCxEclW5CXGkYV+JJxwphU71pknluHoVMix3RRe9CulBDqK2xIxQWOPTn0
 mWccJk1Cky4ALCw//Qd3l6vT93BsmOLMXflwP+xwCs9CgsAAT6/Jhqy
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d47bfc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=0Z_xqJqdlRmHXTOusawA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: tTIOvj8AUCIUrwWGpUjfw-bpXKxS5DhP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfXwU72uHdAQV92
 w7e5+7LufN0kycYEGp5/iexiyn8imCMH6KGU2Cf6H41ypdBidpS0eIKZD7Ulk7ggvt1QPAW6WSU
 TH5vFkl3gFE4wj3uw+f8Cjy19WecxWubd7Uo3bm5w1bMbzWteZrhwZW17blFWlXQxKae8zEjgid
 24Ueh1sdWCvxlGfOjJEIW4HYoIJFoO8prObVOxjtjsWE6boBlS7NS4FECvT0m9WpeN9Gm1jY634
 MclpA71/fHrqRlhhSBd6DS9mMaqI1lD8TGu3M0y1XbFG/hAPlMqgnje2dJo8VwbVyVzkTDiamTu
 x27FX5/q+eDu9a/SwACiir9qift3fkN+3dLtLOvbH8e9njgTCQlnlnRICHI1mfntVGknWpO9N3u
 oBE5exXN
X-Proofpoint-GUID: tTIOvj8AUCIUrwWGpUjfw-bpXKxS5DhP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

Document the RPMh Power Domains on the Kaanapali Platform.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index af5fef872529..27af5b8aa134 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -18,6 +18,7 @@ properties:
     oneOf:
       - enum:
           - qcom,glymur-rpmhpd
+          - qcom,kaanapali-rpmhpd
           - qcom,mdm9607-rpmpd
           - qcom,milos-rpmhpd
           - qcom,msm8226-rpmpd

-- 
2.25.1


