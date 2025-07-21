Return-Path: <linux-kernel+bounces-739892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7B4B0CCB9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E01B7B042C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C9B241C89;
	Mon, 21 Jul 2025 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CkpBAkug"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6933241C8C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753133822; cv=none; b=Fd1lO36nvWNaLFMo595TnX3P1uMe5mGpDodlFLeFnTO2YMSg9KWB2SQRSng6ySuElFpS/O1hGYq5QActA/ESXYv5jsJT+Lxu2RWWjRv42gfY9/gSCOvx7YPqeoSP2i1Sn+jttS2VYOs+QTUpz0u63qB4n6PREm9zNZsJ9kusn0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753133822; c=relaxed/simple;
	bh=pVYM2yyID1q0xIkylfHgS2f4H9eBnukEG0m3CcSdyo4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QTTOZFKYZqQtkhQ7/B0uo3/fEdggUA8l8vaIlGZWjIMuU19uxemY7/wndhYKS6ZzICfVSYiMniiW2g06fWwapfoeg7+iJPeSNfQ7ekW3d6l9eU/8181zj1P5cCkmo4A91veAoW6zgzinuBV3Sl0/ZpRs1CSDqZMr8FayGyrvwLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CkpBAkug; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LIg5HZ013043
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r63NxAvu5OQlg+2S4aOi2Tv2QOJTatjH1p+X5yIH4Xk=; b=CkpBAkugkBWBtaMd
	JbN4yui3KjUwp9bZc+j08xEy11zB6Py4ClmKHcg6Vgk6UjIVJUGOgE5oFOmPHLBh
	KzYEmPzFSWXo56X2TfCchlM0lXvx615tbjCF4GYthe8+amK8IhUsI8Uv1+cP8VvX
	Z4PN0ocaIp4QAgwYKdxQZow3Mb8L3XMyRxot7dPzHOBQsDWbnenc+UNo1Ujjf3XC
	a4kJjSqXdDnyds65grAIalfVQhVeld/Th6LVQT85ZE14mmyL9Nt0RZAeHBEK0ctV
	c1QlgZofQ5HxsQohNPr8D/WzQ0HDqmvgZz2eQ02og8G9PDXLewcqmMie1DKPnNLF
	Y42Zaw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481g3ej1uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:36:59 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b39280167fdso3431634a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753133819; x=1753738619;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r63NxAvu5OQlg+2S4aOi2Tv2QOJTatjH1p+X5yIH4Xk=;
        b=RtWo5VxQu+bp6yXVhdzaJW9BKVn1UjRlZZlPc56iovO91wX06uSi3rDtSK2I8nZH6V
         fejWHrw/5cJU1BjsoL7LR59i83PMBE/UyPEvkNXRYmd7yrNteyCDyvoKhJh3wvxv2WYt
         WguMRR/UV9hS6y3CtPDvA2yZ04FiWW4IVSna+YLbis1mYM2rV0Zme1+aBof+kroRoRA8
         2CHOexPQa3cm0ljfkEjh//2XgZbzdONGSw0D1hTQG6PWM5IguhocAYZt86Hhm3Gt1LsA
         pp9wVNkaPqFNq/LpIbRP7bnJJnIF3u0vxaxfnuec7JdgZy+2OZPU1qL8gmc1634Yn4+y
         WxYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX22VkspTZsa6Mx2y80CpLn7e1GoT2fSxHk8SODFQNdMW8kaya+9gTlNO8UXCGwvtWrE9f909etJBFG3Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUV2XccFojOK/FbbxigVbDwyK6ub0Z6hk3JX/XXKmvBOzbOthN
	5TpGbqGZUAacMww/LZKd91ncCxj7zxq5k48hNay8X6OkWDgLCLD25hIBXoc91KBgm5brpOlwG4A
	43DHciwvjSIFoh99jVx17AhynCoCkPqpYiH5OTr6cpyVyKBnrAFHurjyoO3+B9NFsdGY=
X-Gm-Gg: ASbGncvNTX4w7kCDWMjxAJfIQaGka9F6Bw9A8g4nLux18Co/4oQ+Tk6Ry5ai6F+0cav
	NTDFcQaDxf44RVi/P3OPsq6O44ttpJMUdLViXsRz8Yck55s069meHu3oQWTI70mMS9wksLUWNHC
	6FnHwiGFhS6gouDIO8oSZ7wKl/v1HAjuU7iwS5oPF9t3oYp9DUV7JbBdDHIzklueCHO+uN3PTL0
	T9JefAxVVtyt2peX9NQR3jpGsUnlUbc6nCor/78MH7gD42+qKU94iRVjmqQR+ecE/s5c9w/ZyyC
	hoUt+HRlpRcfA6bQtjwNLl4Y/mE2PMNdAbwgfO1nN4o8xc/fdxTIOuy5Sv5z6yaipXPjXyUTSIr
	c
X-Received: by 2002:a05:6a20:914c:b0:239:f85:b885 with SMTP id adf61e73a8af0-2390f85bf1bmr24817652637.17.1753133818950;
        Mon, 21 Jul 2025 14:36:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXX5Z6w7xxmYlkuSGuDhtVuyY901rFA/aeyB2IgnGsJVaNpVrBJt7tGe9mzLX4Y3pJUc2T8A==
X-Received: by 2002:a05:6a20:914c:b0:239:f85:b885 with SMTP id adf61e73a8af0-2390f85bf1bmr24817630637.17.1753133818557;
        Mon, 21 Jul 2025 14:36:58 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbc68046sm6201934b3a.151.2025.07.21.14.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 14:36:58 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250720-ath10k-zero-brace-v1-1-c1ee818d6238@oss.qualcomm.com>
References: <20250720-ath10k-zero-brace-v1-1-c1ee818d6238@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath10k: Prefer {} to {0} in
 initializers
Message-Id: <175313381786.971667.1205072057690654219.b4-ty@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 14:36:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: Fb9ETLtKnKZE0BjQGOPOiAZitzZqAZvP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE5MiBTYWx0ZWRfX/v98fFNO7qgx
 oaPSjOer8refVphaMchvsPFXepEMmbAseQz8T1L+UAScFHtG7rEQA4aS18VN30UZ/adImldaM6b
 dMXAgSALubZo8dC6T+nDRefPDrZNP2zBFb1owfoEiAv0f5PKTYeBRmiV21V8WupXz56tVFDAEGP
 kuplChd8szwihpG5NgMqT+0uQ6zXGgoWRlatVfC1rg8ATRY1M7NJp0wD+7JybZJQel5QVkmy10D
 ASjfPzDWjM2/xZvkiT8vKXCE3mZbslkkTlfDtgG897pcoeXXkX4/EPOJa1k+mCDWr4jXUHMhFJx
 HkKlXXMO9CMvbV9yyZ7JHwCREo4CUYH6ZwULuVqVQtydkKZW2bz9FxBksygclaYDz1dpOG+kmQY
 PYwAQ207kx54dhecwJx9EPNgGCOSIncuQZg59GyhY1rPMrDUXdOzpNBfBcixYsEPgsM5hkDQ
X-Authority-Analysis: v=2.4 cv=Q+fS452a c=1 sm=1 tr=0 ts=687eb2fb cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=AJeZmiUk7byJ5J677osA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: Fb9ETLtKnKZE0BjQGOPOiAZitzZqAZvP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=656 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210192


On Sun, 20 Jul 2025 07:46:15 -0700, Jeff Johnson wrote:
> Prefer {} to {0} in initializers since {} works even when the first
> member is not a scalar.
> 
> Generated using:
> sed -i 's/{[[:space:]]*0[[:space:]]*}/{}/g' drivers/net/wireless/ath/ath10k/*
> 
> Compile tested only.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath10k: Prefer {} to {0} in initializers
      commit: f0b72d15265e877a02427e0062a72ade70ee6f86

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


