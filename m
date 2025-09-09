Return-Path: <linux-kernel+bounces-807751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C969B4A8DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40DE1885598
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2B1241695;
	Tue,  9 Sep 2025 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="in3hK42E"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C092D192B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411349; cv=none; b=BNFSyP99T8vXJZsJD2amzKZ+qKrFSvb4HwAjQ2jkEKH8C5YQtP/C77x3KBfPfeq3k7h0kezCurqg7NCc5JJuP8FIz/vM3a2xnUGTWcHKOpt08Dfv8OmORzCCN3ZNR6rP01oxXMOhjFdng8P6ZgKisDPPZA/Enycpx5x/J2HDqow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411349; c=relaxed/simple;
	bh=AjIJNpNuIYSwMPaWgpWk8j1HyqC7OeaYozK9weYOVqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nbUQ/aArjfgFgXNqXd0+fTsHdF3lIOF0qXjKOlEiIPgUsFe3hpgGMrdFQ1UMONptarOeoN1r0WJnzpr5lgKWeEJcZmAo/vM4ofTa2+PuwqJ1DnyQK5nOfTrb+lnDLU03LKTN4Ef0KSAnpCSkT30MtaO+owFuN5n9mz9ijgG0NB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=in3hK42E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LpQp004616
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 09:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tk2wsNUfzGcgRNL4wnI8L9
	jtFRsDbUn8qphZ3Qi+y18=; b=in3hK42EBbKItXY3B+7PDBML2gGT+4BH/6VNLI
	etCnRrC2TUg9eKmmk/97TfS4/r9sbzIOszq7EExCpVbSYfmgnMIIuqxK8hmnX9xG
	23cz9Z2cIzdhyhCyYxNO9oBu/zxsKEqZ7wGjCk7Sn0T637WqUq5w8Ixl0mcbmSAa
	Dj/+pKCclRrBLM4rFugA8wrACEYJu7S8MTEVsKJDwLPJiQWOOljaf24i9WB2ZMqu
	KqF4LEKB+ciG9Jq0DNbvdWVjhRMD3lOh9gJCrbIukvTKBzB72zu65YPO302Hg62S
	JSAd9J7SlqZABaPjoctQJ3LAeL62DGmBDO3EVoK0VnO3Anvg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aapg2ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 09:49:06 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77253535b2cso5309969b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757411345; x=1758016145;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tk2wsNUfzGcgRNL4wnI8L9jtFRsDbUn8qphZ3Qi+y18=;
        b=jLXLK+aeAzdGW5OasDt53igz+CJpeKc2HQumdpaC20FMfvesXoVLlw9q1L5ESUd/oE
         ogrM4kpGHe7lVEa4M3YB5STb3iDQHa11ZtySniChyMBjdTMzvus9MWqh1gQJrVGUv58f
         jw1ESP34EpqAmiQp8TWmvWAP3OsDrCGGU+8SKrViuJz8oy6t/IWiuXarrQ7G4pwYHhzK
         tCzUWI4LaLdQDQ/HzEbt0UfKgNZDbxfU4RErXMF/sEr8HMpIsOclRds/Zkb//biGAqMb
         PsKBvC+9fFMJCXhsmriPYPkzl+M3n5RnhKjCLUmZIyD6WYC+NV2vIyQ6kYpLUVNq3KP3
         3xeg==
X-Forwarded-Encrypted: i=1; AJvYcCVULPZxR2REEMmoG487BAVM5W4Vah4kcI8GEaSL0noskQB8c636naGNNNKG7Y/Vh256frT9gvct2Ri9iZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQJcZLbxMCbZ9xzz5fRJ79Ewgc2t8SsuR/+bTIHDYz6sZ81jzd
	pAsDakr/tDZ7UFdlxjOv9nebQ2iWaLzzNxi9k/c8aX4IQa+mbg+SQoyO6CPqnU6FYANVwI6dre6
	ZNgt1xdJHPINAEVXUw3ekfZsL8kHTxoA8L3BQEIUYXL386ir3hmJkBs9eRtzIEhkjuEU=
X-Gm-Gg: ASbGnct6X+2XBRW7RvAhLkUiOMRlubbuKEWVZPjfuLVb2QMMOkDF7t9g/1nbHcfMUDc
	xRPB2XONrgzGOR0UG3CewZzXZS0WyCWnGsWoQv1SZ+2C/Be+pdi4AaAOK3z0vdzavVQPdpD/uCm
	BG61tZALuQj84ySlHTuQOc0OzxwnXISVAZR+0IUw9vCAag4XPBHYt4B9NfuS28DHfPRHdglENl1
	5g4LsKMfy6jD6QHEhqkBP0cNSasTcn5vGViQgH7wpnN8x/xz2p2hYFdM4o0jj/k3FNjWcg0y6pQ
	lUYmbhvvhf3TZMn50x/8Mw4NClykvepKV7j6lNdFxIBimyBVSEAQkqQD413CB4xCr+S1cnA=
X-Received: by 2002:a05:6a00:2d23:b0:774:1fd4:1010 with SMTP id d2e1a72fcca58-7742dd50a40mr14032390b3a.9.1757411344766;
        Tue, 09 Sep 2025 02:49:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHi5iBwBJA93nYQepdGPa6C3DS34cVTOIUFas1WAo4ztjqAQAV6qQOz5U2c1xk5tTzuHEPx9w==
X-Received: by 2002:a05:6a00:2d23:b0:774:1fd4:1010 with SMTP id d2e1a72fcca58-7742dd50a40mr14032354b3a.9.1757411344304;
        Tue, 09 Sep 2025 02:49:04 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662f990esm1533558b3a.102.2025.09.09.02.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:49:03 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Tue, 09 Sep 2025 15:17:59 +0530
Subject: [PATCH] clk: qcom: dispcc-glymur: Constify 'struct qcom_cc_desc'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-constify-dispcc-glymur-desc-fix-v1-1-6cb59730863f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAM73v2gC/x2NQQ5EQBAAvyJ91skMS5aviAM9jU7WkGmEiL/vx
 LHqUHWDchBWqJMbAh+isvgINk2Aps6PjOIiQ2aywlSmQlq8bjJc6ERXIhx/17wHdKyEg5zY5X1
 pC/qy/ZQQK2vgqN9D0z7PH8aBzjZxAAAA
X-Change-ID: 20250909-constify-dispcc-glymur-desc-fix-a3b615c8e146
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68bff812 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=csJZpMO3bG6WjO6BR9QA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: o0vUbDCQdJqafZ3RudN1sKCes5dUuP8m
X-Proofpoint-ORIG-GUID: o0vUbDCQdJqafZ3RudN1sKCes5dUuP8m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX+h7GPqppULPx
 7kUj00eP3lrXFi7FwHclwhXfu6wRj8YlYqCNXS8ZTmvcHek6AwsgJrRnFK7D0RhGJh/PZ6sNpvS
 IVJwN1NRCUn5k7SYU4wgq/0ZD6yEI1IH3z9KOciFVpfWWOHTPV9a7SkE2lsQqcyPpBKCdiSNOjl
 zKw1ISND4MT2S6c0Z0HmVTk8mOi0s1SaFdHrCWLt6J5xV5T/8RvUNDx9uMlnKboKaUBL+961GF4
 MgnUOoSq8eeu+pqWsQ6xuNkI2j6e1MWBPXQETvxbVdvhsCAl9uUyADhXZkpgi3A8pQLY43e7pbK
 FQBhGbrJpxd4QyE6H9NDzQybgzimKNZilTycVSIN7mgXyoq04NOWc0IqmSV5924Mv37qqK2w3s/
 mT9wBcts
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000

'struct qcom_cc_desc' is passed to qcom_cc_map() and
qcom_cc_really_probe() only as pointer to const, so make the memory
const for safety.

Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
This commit is similar to [1].

[1] https://lore.kernel.org/r/20250820124821.149141-2-krzysztof.kozlowski@linaro.org
---
 drivers/clk/qcom/dispcc-glymur.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/dispcc-glymur.c b/drivers/clk/qcom/dispcc-glymur.c
index d755b41cf458a7cb9c22f510a16a414562432dab..5203fa6383f6ac7fb49e888887ee9105101a9b56 100644
--- a/drivers/clk/qcom/dispcc-glymur.c
+++ b/drivers/clk/qcom/dispcc-glymur.c
@@ -1945,7 +1945,7 @@ static struct qcom_cc_driver_data disp_cc_glymur_driver_data = {
 	.num_clk_cbcrs = ARRAY_SIZE(disp_cc_glymur_critical_cbcrs),
 };
 
-static struct qcom_cc_desc disp_cc_glymur_desc = {
+static const struct qcom_cc_desc disp_cc_glymur_desc = {
 	.config = &disp_cc_glymur_regmap_config,
 	.clks = disp_cc_glymur_clocks,
 	.num_clks = ARRAY_SIZE(disp_cc_glymur_clocks),

---
base-commit: 65dd046ef55861190ecde44c6d9fcde54b9fb77d
change-id: 20250909-constify-dispcc-glymur-desc-fix-a3b615c8e146

Best regards,
-- 
Imran Shaik <imran.shaik@oss.qualcomm.com>


