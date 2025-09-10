Return-Path: <linux-kernel+bounces-809182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B33E3B509C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CA3A7B9FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771F3154BE2;
	Wed, 10 Sep 2025 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VCVqCmA8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E3333F6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757463085; cv=none; b=SFEaM9ZEhTToH93GxGnhwR9/czKhk76XjeZyoaXRoh75EHQH3UqCU2l4YBtTm49g02sZl/KWVhVLseXpR49pY3x6myIMhv0GgoLgM2AJdi2diwHBYCW+BOtYQ/+uSw2YwVDOCwzkO9GxRcMzs8O+ntsQduY0RSKaIOIWfqnOBcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757463085; c=relaxed/simple;
	bh=Yh85rlS4nql62j6YKEnNgls3TAgynSOKcaoqO7FHo1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P2/M9JwlgDp2Mmzi/QpsgRMmDiI/LenbJ9egOZFyNLxqGNpk6ndZBvNYqAHLhqOkDLJ80Epi/FEGNnOiUX63Z9lmm34pJLG98K8n8Rb7p8lTLWkhfAJVJQKFBNQ/GZpJoGlJkCohh5ogrGH7l2jNFYSqyQg9UcD7MBc12i2Wxws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VCVqCmA8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589HbIsm009026
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:11:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2mg5AWjqaghC/mvjk6kLruWQ/snXAYnJwKVQhGg0+qs=; b=VCVqCmA8LvzaKotB
	Rx5VH0HyTtER9gxW8+rfTKV8Vhide5TTImYb2eJrVZybrk5g0Ab88G3L6VIbXb5p
	vE6byxfDUybcZSRxNzXYLBqqzwq0JSVTEA0+q/1hB2CGmrS4phl6XjLjKEoNOQBA
	wmkOeILxqY2ZEnYkqy25toXvVDEvOfRyAFynqSUGBzvrYUJkjHYL82IQfbgw361D
	A9f+UAImCIJE1ne1BTgRplOk8YvZ4TukxdNhW2yw7eUOLR/Ca3seStKo3TCEibkf
	xS+wvu6V5p7jMhewLGVEVmGXJuTxMiMny64/3+DdM+NI/9AghnOTPlc1eNZMiFqd
	nMhL3g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491qhdxtqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:11:22 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-329d88c126cso6110104a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 17:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757463081; x=1758067881;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mg5AWjqaghC/mvjk6kLruWQ/snXAYnJwKVQhGg0+qs=;
        b=KEfgt7FXg3PN0AkR3W212tCQAyJjAxcQ+cRFFL7K1kXWl8Z7sEwpEV2WXJMTmCKCr0
         DLWwl0qwjHos+pFnrJwThnV61c7IIXMMFjcKueJfOoUBv7J8Ap5kY8pJsHfmz8oZhNmr
         oFWVQb5v38VrOjXdyFyQspbj2gLbOHxnuYoBHHLFbTpZzqdMAd3iLfJY+mFDVXntMcg8
         nsdxzueLTXyKrVNxWbBUitsefLMmjEFF20lBs+jmCxPeCcyPT3l0kwqDmPqEtGW+MoFC
         BTYUc/xg+8tKQzuJA0sx53raA4tKu9DrTTDwBSBAGNrMDzq0y5Q/JLPYIzEdlBfLV+xz
         rYNA==
X-Forwarded-Encrypted: i=1; AJvYcCUB6T5qQrRmuzY7dPzxjq4eD+DDa5opva4c8gxUHQoLyHg/xj04yysoEeogZr5WNOQ/5Lhy28JtTUsYzjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHqa3rNI4bqN2L4pfWQEuncL3+L34RL60EYbEhhVDizKWzbIa+
	RI1o+qVVXEfcYzcuSkCLLz6YAeyqaRI3iI76Na+ZwwRvzVYtz8mfz1G23EjI8qSHZRZnassCcsP
	+dbwrX4pQgU9kA5N8aGmEVEIJpcUiZr9WuRcP+5yaKM1ixwYyeobN6Bor2czASG4Rmg==
X-Gm-Gg: ASbGncs5GDt4ieUWf8TwrZCmrcTT7hhFek2aYL70odC2eN8k8O70e4T+8LZMonxbOQF
	zT6bXZYc9n7UPWWLcmrsB9q/TtDiPBoetEJRqPyxPUaiVw7aWAG0SnyRBilpWWuftJ+b3UNszsl
	3mXs4wB98+N3mw1u3KlEkiCzWSBxh6PofodeX/k3xTltFT6lkEqSZHeOGesCO+DUyEPU24XVvAA
	4v1fzr36EjjLzT4JNNj8VPjUdKPDzw06mCchz3YgBnhuM1Bhz4nZRT15l5esozop5npWdz+oSGT
	VJhC3j9mcii2o6aFB6Ww59K0BGibQ/zY+aCSvYFjAPiGeEW+wYbtKaoeAevnJwnRfbQM6qRzjb1
	RcJhxlHwZS/MfxJvBKUzCpl0=
X-Received: by 2002:a17:90b:384a:b0:327:c417:fec with SMTP id 98e67ed59e1d1-32d43f1780amr21188046a91.15.1757463081484;
        Tue, 09 Sep 2025 17:11:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPpB0vwyPXFQbNkrO3QbiG84lkfE6zB7czKy4X83WNMEMJNSWAA5xUsqNEV9v/dfKVZkRwvw==
X-Received: by 2002:a17:90b:384a:b0:327:c417:fec with SMTP id 98e67ed59e1d1-32d43f1780amr21187999a91.15.1757463081017;
        Tue, 09 Sep 2025 17:11:21 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dab6bb655sm1285672a91.10.2025.09.09.17.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 17:11:20 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Tue, 09 Sep 2025 17:11:05 -0700
Subject: [PATCH v10 03/11] tee: allow a driver to allocate a tee_device
 without a pool
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-3-20b17855ef31@oss.qualcomm.com>
References: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-0-20b17855ef31@oss.qualcomm.com>
In-Reply-To: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-0-20b17855ef31@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Proofpoint-GUID: 1yXtMRMeD3p1jHGaAjAPCssJ8V9ndw6m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAzNCBTYWx0ZWRfX4drjJN99QjCj
 +/0S7emAHn/xf8vZu8RuaUhOHtTssIuh4sojDXYF48j7oxNSGTKRcNpVaNt5xeJRjjzYObZFRNF
 Lnpz+NZQHm7Qq1Lr9ayFlHbTIW18k6iNGdZkXpy0f0DQLwZNvkEruTNnQr5zPTpxxfrhwdDIq90
 qeedwIN1lS0QRGClqbFf0VFcTp+m6deSSa0HrO9xwmszdMTAxdqY6ZJHGOLqiO+2K0+bd92X2kP
 3C9xr/qd1fMPWz+mUQdG2u+LpFJAhNdP9Q4+BdX8LqoBghSEOopqfQpciUSqwjoyjifW/OL2BQz
 DvEjwsQcekrFjIqu4KMPQR9Uu9QkbiYr/q4J5AtariheViZIIrXmG+PjWHUnH8MLgNQDB3nZm/x
 hQZ3kco1
X-Authority-Analysis: v=2.4 cv=YOCfyQGx c=1 sm=1 tr=0 ts=68c0c22a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=1atmPuGhRQHGwWkYLZIA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 1yXtMRMeD3p1jHGaAjAPCssJ8V9ndw6m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080034

A TEE driver doesn't always need to provide a pool if it doesn't
support memory sharing ioctls and can allocate memory for TEE
messages in another way. Although this is mentioned in the
documentation for tee_device_alloc(), it is not handled correctly.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/tee_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index dcd40c26a538..33091aa21be0 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -852,7 +852,7 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
 
 	if (!teedesc || !teedesc->name || !teedesc->ops ||
 	    !teedesc->ops->get_version || !teedesc->ops->open ||
-	    !teedesc->ops->release || !pool)
+	    !teedesc->ops->release)
 		return ERR_PTR(-EINVAL);
 
 	teedev = kzalloc(sizeof(*teedev), GFP_KERNEL);

-- 
2.34.1


