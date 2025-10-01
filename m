Return-Path: <linux-kernel+bounces-838297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A769BAEE51
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 02:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383373C7674
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 00:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4341E9919;
	Wed,  1 Oct 2025 00:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="v384MpAY"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8339B1E1A05;
	Wed,  1 Oct 2025 00:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759279090; cv=none; b=izi3ABriZrabjTaJ9CZnk5NUcQvvyOLKLvKy4QsxLtezJJVxcW0iBfhteyXkTYKG7EgFhRYYl//kjnKA1d8RlOLlKUSzS40oUT+rXdyEilFZqJEzlEwGLd/DGMiVf1IFujhQrD5kJlNRzKMarD+rRYiQXcPc0LYd6xr3fZ9ki0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759279090; c=relaxed/simple;
	bh=+dnN7bdax/EdnBE89RWLNmvWrpRve9dgbh0iOydFs7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Yws39Cp0E1+AU5VtNgrdlvF437h+paLAI3oNmQD1up0CuEHlznvTctY4Lk3QRv7tX1gEOGHuHY/vRcfEcnbOZPDyU2ajUekYbIfjItjfAq+4VNozIMQzEaDTNJ9Rph1bpi5uCUD9euHtUfqlPq84kY4hxbfjNcjQOzXHUHI0k8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=v384MpAY; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ULN7AN026965;
	Tue, 30 Sep 2025 20:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FYQAf
	F7uxweCwW72khlsQ7BRJXC24ILwfPgmRl1iJwE=; b=v384MpAYQeiXakY/EBnmr
	oOFKH2ke7F5fXm8EL9Y4KTwVFhjnSVgA6a236ojVWB6BsDKhLj7hir8qYHWquaeB
	19PsBEmWC9f3zr9jqzxnaZAC33g7l4LYbTXQ2JtmyJb2qcPIkfLtiaR3dyrNVXG8
	Fy9GdLrmI0P0fBy9sLKYPPpDhlDXAdx3LXSLJAQUlR9/o3MGqfXB6pCe0sBuxAFb
	AHlL06BBFGIJJTlvyskNQ1QWaukPdyNoK4NBzRYGV6jHAEwsOAvEYLjW4Y9kW8I8
	CpIE3JTd1jZWQYcvCqWAbra8AzV+I0Y8q+kBAijxAJgwDwumHOSG8jPF8+nAjGts
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49fpd43qy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 20:37:55 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5910bsxe061065
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Sep 2025 20:37:54 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 30 Sep
 2025 20:37:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 30 Sep 2025 20:37:54 -0400
Received: from ATORRENO-L02.ad.analog.com (CAV-GBS-L25.ad.analog.com [10.118.9.50] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5910bcY2015453;
	Tue, 30 Sep 2025 20:37:45 -0400
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Date: Wed, 1 Oct 2025 08:37:07 +0800
Subject: [PATCH 1/2] hwmon: (pmbus/max34440): Update adpm12160 coeff due to
 latest FW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251001-hwmon-next-v1-1-f8ca6a648203@analog.com>
References: <20251001-hwmon-next-v1-0-f8ca6a648203@analog.com>
In-Reply-To: <20251001-hwmon-next-v1-0-f8ca6a648203@analog.com>
To: Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        Alexis Czezar Torreno
	<alexisczezar.torreno@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759279058; l=1489;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=+dnN7bdax/EdnBE89RWLNmvWrpRve9dgbh0iOydFs7c=;
 b=O6zJwwIpfpI4jdR3GodpEb8EKFkpDp6rNVxMTdb+rRPLN6//tVe8YnWxgYnaRBOgBuBTMeU9b
 Gg7k/nscMj+B6hdPeoSNpIzprUAMTQX8QeiAxwWT1cAuq9NAM3vdWWX
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=RZqdyltv c=1 sm=1 tr=0 ts=68dc77e3 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=KyYa-aBjXRLsE6yk1RUA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: hMw_egSLO1knrsEp2GMjgCtUiGk_6dj1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDA3OCBTYWx0ZWRfX8JIOkFYZLcXq
 yGzlhcf8DX36EbbR0HKkZtJXIl1NnzI0F6DGvuHL4RlpHarwsDdp/HHZ4GfhV13k+/uZkqXlhiE
 6JKEKy/n/isbmI1aKteKCZgdfBCFksq4ddeDqZ2v2DVCBAOLE8nDJyvBku6sJRAhtaKfw4SDp1q
 Ymm8nToG2+0zSSRgOfEcXd0wmntnClpoaRdAg3Aep+FkkoIH1HoeeknkUwRBoPa4F/BjCfW6qg6
 tCnpVmEZ5SXOqJ/+krundzhzeev4o9KQBUwKjHsflRLTwWxY4FC9bUg2Tvb3oPZegmx5m02N+ZO
 bq66Tog9nSyTRPcr4aZZI0miErAWZeYSCYgu5yWOBQUBh7GugshHYWTZiiOA7/VI2P6NK3SB4V3
 1m0zeZAzazdpCCvwbGm82kJHpCTE7A==
X-Proofpoint-GUID: hMw_egSLO1knrsEp2GMjgCtUiGk_6dj1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 impostorscore=0 priorityscore=1501 spamscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509290078

adpm12160 is a dc-dc power module. The firmware was updated and the
coeeficients in the pmbus_driver_info needs to be updated. Since the
part has not yet released with older FW, this permanent change to
reflect the latest should be ok.

Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
---
 drivers/hwmon/pmbus/max34440.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pmbus/max34440.c b/drivers/hwmon/pmbus/max34440.c
index 56834d26f8ef3bb5e1d7b84e57f922e01141c8c8..ef981ed97da8def9bf37d67839c8d6d04083e1d4 100644
--- a/drivers/hwmon/pmbus/max34440.c
+++ b/drivers/hwmon/pmbus/max34440.c
@@ -336,18 +336,18 @@ static struct pmbus_driver_info max34440_info[] = {
 		.format[PSC_CURRENT_IN] = direct,
 		.format[PSC_CURRENT_OUT] = direct,
 		.format[PSC_TEMPERATURE] = direct,
-		.m[PSC_VOLTAGE_IN] = 1,
+		.m[PSC_VOLTAGE_IN] = 125,
 		.b[PSC_VOLTAGE_IN] = 0,
 		.R[PSC_VOLTAGE_IN] = 0,
-		.m[PSC_VOLTAGE_OUT] = 1,
+		.m[PSC_VOLTAGE_OUT] = 125,
 		.b[PSC_VOLTAGE_OUT] = 0,
 		.R[PSC_VOLTAGE_OUT] = 0,
-		.m[PSC_CURRENT_IN] = 1,
+		.m[PSC_CURRENT_IN] = 250,
 		.b[PSC_CURRENT_IN] = 0,
-		.R[PSC_CURRENT_IN] = 2,
-		.m[PSC_CURRENT_OUT] = 1,
+		.R[PSC_CURRENT_IN] = -1,
+		.m[PSC_CURRENT_OUT] = 250,
 		.b[PSC_CURRENT_OUT] = 0,
-		.R[PSC_CURRENT_OUT] = 2,
+		.R[PSC_CURRENT_OUT] = -1,
 		.m[PSC_TEMPERATURE] = 1,
 		.b[PSC_TEMPERATURE] = 0,
 		.R[PSC_TEMPERATURE] = 2,

-- 
2.34.1


