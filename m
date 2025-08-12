Return-Path: <linux-kernel+bounces-763909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71035B21B79
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8F83624954
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303812E543E;
	Tue, 12 Aug 2025 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RsTrpTfp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D458B1B4F0E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754968315; cv=none; b=DuUF8UBpTLe3RiGtL/3kqS8LXRJH1MVzdNntN7FX3+dvCyq/0Wa36RDwcygSzZuTsEHtA5d7SL7dRCa+QbaZCRVdF0it3oVApTLxwCNb9ZU10TK+uAAcPcWrcSegtGynd7R0ynS0pbsseR/HtCdZRwR2k/nCnr2c8l/CYEPFEN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754968315; c=relaxed/simple;
	bh=iWKr94l4C+wGOu32iC4kUTBBxAFqi2csewiI06tugUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Raa4fRwN4+9HzC+PbSJNGc9bFoLF5W4V35TLTZpbWhO+YBfG29ZJMV5a2UivCSP6WtWilSxOear8wt56JY6XHXHwJGtVw7F0xlGEXasYKqRaserO2nrrcep+8iU/WZJmRCbHLrKEJh6OiiSjpUDnAg5DkArMq/LR2J1JkcBWEI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RsTrpTfp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BGmmNF005328
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pBAbKSf3/PgS0PaQMsZaEkwPqrlvCqAgfpJXTwwvKk4=; b=RsTrpTfpSvC3eW2n
	/36qwnsRFpCyLjz9MIi++8n1oLmBxmTHlZt/gIaItVC24+qDu8MmiBOzXVX6+zyR
	C8hY4g8LwT+JVML3gQu+fPG4YYiF2V0WJrBVtbuM93AocV8tRHuVDsrbGL93dskC
	qWom8o295AAHgGc4vyBRg2JMnpQ07XRq+cN/Plgb8nSQagGfVyusnpJXfnIrQU4p
	E5a8r3y6k2WZQT6Eb/cXIcXVGuJLrRTt7PGNDk957BB9bdHtqJS2wvUy5N32jEuF
	rPWo7n6tDp1nS/qV29plKLi1ip8OvYON7/VGKB4Mg6B2/SjXTX6qB2fw1mBnGEPl
	TcTkLQ==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhx4t00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:11:52 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-30c347fce27so5579274fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 20:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754968312; x=1755573112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBAbKSf3/PgS0PaQMsZaEkwPqrlvCqAgfpJXTwwvKk4=;
        b=lxHWUQNXF3vdVmLvb+nn04am1AIW9EqLgHjA07R9N1/nkos2I7a6hNmyGsckCavrHf
         FqixfHxg+JV9AkuAHVx4O+A2YnRCyzNGbFcRNkP6eEMWFsXrkU5PyppBKvk9cyarl1hO
         y2ErBQbcAozM6H356h8dAnLFh3qyDckfAuhymY/FZ1LuIVdgMwaPCadjaCHzNxjcHriq
         H5kldg2t2S7O6upcNdR0dh1k8MnaIV8xMO3zK0L2mMlutApKN0tCUI/8smG6nJeq0RKN
         ppAJiIgjAf7WDfVHwZvXb227koxLfD1SWiRMGj1vC7ODEDdBY8PS4CM3sdyD0a8C3NI7
         G/hw==
X-Forwarded-Encrypted: i=1; AJvYcCXm33b8sA/+3wYho5MtrepcdMA1b9oLo1Rmk3ceb2ftEU5hjf7a0Rgo+MQytbm1mIjN2lPCJfk8shQoHiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfrE9BPNC2X/IagmtMUGJnp//RzSNFg0+x3W6Yk1WXAbhXMDnU
	Ry/d38BDyjZBllcsCW16IUUDG51Dr1D8gIsivkqnjvHIaUwvOcjgSZpv6rLlADQRMwC3mrMWNWU
	AOYooyLsXnTKtMLketwLozT9mcx9cZ97Y+RQ9ucxsviRWwCDhvpoEFz0HsV5nEeBHGbE=
X-Gm-Gg: ASbGncucP9kmEJUk67VbT6vcvEc+/DnB+7ic0dzlF+QBf2dpJnw0B5MjgMUa0iVwVvC
	1azNcmgOsa84BrxLVurWwgBANgshxTcngSyLHVhzhBf6qh1dY0OcEjuNIBqJ84fn1dj6goJ9WbT
	cKy799GsBR57Mqq/mgDPBy+pnpywTqs9+WvwgWoXj/cwoL/WnVIp+Aq7V7ZkSIXuCYN7J/Q4EmG
	KEtiZyV/uvR+RLRPFZUqRDcsxVmBX//hPE2mFu+JnDzobRfeENAZQju+FMVKD+odn7kIMC73ega
	ZsrWlh22afyQ6CjBdNmyrwUyIla+2wLKnubFmILxtF4aSv91ue+MFQNiT+eCE6xoAXZrbT4J65q
	5lRgTJmeS1mc3670ZyR9B54QKHOw+1Aqp6hf2pPU=
X-Received: by 2002:a05:6870:8e17:b0:301:fec8:fc5 with SMTP id 586e51a60fabf-30c9504838dmr1239427fac.23.1754968311926;
        Mon, 11 Aug 2025 20:11:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYeL6E0IFSZGXEtKtjBlJEPzBOueX+0t8ndofxKFQcOfrzO6R1WsxDwocxPN25RhkzaZVT+g==
X-Received: by 2002:a05:6870:8e17:b0:301:fec8:fc5 with SMTP id 586e51a60fabf-30c9504838dmr1239417fac.23.1754968311598;
        Mon, 11 Aug 2025 20:11:51 -0700 (PDT)
Received: from [192.168.86.68] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-307a717f0c9sm8174531fac.13.2025.08.11.20.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 20:11:51 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 22:11:35 -0500
Subject: [PATCH 3/3] arm64: dts: qcom: sc7280: Add MDSS_CORE reset to mdss
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-sc7280-mdss-reset-v1-3-83ceff1d48de@oss.qualcomm.com>
References: <20250811-sc7280-mdss-reset-v1-0-83ceff1d48de@oss.qualcomm.com>
In-Reply-To: <20250811-sc7280-mdss-reset-v1-0-83ceff1d48de@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=iWKr94l4C+wGOu32iC4kUTBBxAFqi2csewiI06tugUg=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBomrDzaYgQuecT1vAEY3V2vVAU4NXEVxfTC/6Rd
 umxP8mPc2yJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCaJqw8xUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcUNdQ//Wo+tahejLl4GZM4AoSOTHfuxsT5do+dilLRbHjj
 rdlqhoxNSr6ugRG+IFq3m+xUg/cL17pSIt2PQggpfaBznLV3VgtOZPGLvmsJZ/3KVPPwRL1DR/t
 ckdcgUOkAD25rsyP3bnXRXl3aqXY0CUhlClw8+at9jnhamIcJRI5Mc9wNgNL8uy7zCA91xNNULs
 BkqUL2MSm308aA8f1Wj+zDdYysdI2NejeHe+0UqP491ef0a+vUz2qRDNnDd0a8QXk9HucIKv4R4
 peWyzOYP92ejK3pShm/s6xOi22trMjqeo1s0Xu570z0bRwQ84E65WG1CH5xQ9CHNW/bAtN8GFsb
 ur68QWvSlkA96KJqIjDEFm8t8QxbhsO2qK+NIgnsWXYaU5IhxhjCZp/BS6SYHCO2CmYFlPwthIs
 ZlsKDh6RTr6WTnv+8NRn0AGNxSZeZ/t50RzToI83E4PgXCEolh28d+aUg7KV95VDq3pDM7dCWuS
 SvJ3KeG21pUC7uYkwNaG61r+ESsGdrBd7kJiMeiRLtAIRFKabW8CUabwu2RK5hWZBQjNa6p2m3p
 rsGp53CmSxmGIvsxNWFVA2r9q7mB4qD4g+ckKg2AobCz9aFfHF+B8WK2Q8PSBkO67laYa+TlPTj
 fRepVQHRPrPKQs62ZvsXEfXmAJCGHZzmlGcj9EDTk6zg=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfX2PxkbIwa2LHQ
 Z0LRfIld66erezxO8FqayA7AejgRqT0vGx2EojThVV2GsTZQEOtck0HMvRbQt3WcvpWymGBwyZf
 HX5dwXb5+uIIYF6nLCrdkrXijV4flVucaGF4D//Gf+92NmdYBAhS/vsSajvaMCilT4oZReAtkAa
 V6TdKU3YF7wVmzFJtxGm96Lzq+xlt5nDZYeiv3n4wQKCH6e4Y18fQHEHvNB3YSMYFeNbo+/Znqx
 28dBw7YEheVy00uW5lpjLhFw0JMpeSE5PFH/K3TG4jpkaD971fNUAiqQqLXMCxg7tIOnp/SF2eh
 waUClKNTEu13qJCH8dJ5+uTpeYkZ8k5dXQhJG1+fImzo0u8f56NmT+v1BBNDOeGl2cWcxBngxjT
 4RugfB4a
X-Proofpoint-GUID: ciVxV3LxSygS5OT0oFB1rvarW-3rvv0h
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689ab0f8 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=dOedmflVD102KoYFdoYA:9
 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-ORIG-GUID: ciVxV3LxSygS5OT0oFB1rvarW-3rvv0h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057

Like on other platforms, if the OS does not support recovering the state
left by the bootloader it needs access to MDSS_CORE, so that it can
clear the MDSS configuration.

Until now it seems no version of the bootloaders have done so, but e.g.
the Particle Tachyon ships with a bootloader that does leave the display
in a state that results in a series of iommu faults.

So let's provide the reset, to allow the OS to clear that state.

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 64a2abd3010018e94eb50c534a509d6b4cf2473b..5eafcb84cd452ecc758922b69774837e9f5a899a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -4724,6 +4724,8 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 
 			iommus = <&apps_smmu 0x900 0x402>;
 
+			resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
+
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;

-- 
2.49.0


