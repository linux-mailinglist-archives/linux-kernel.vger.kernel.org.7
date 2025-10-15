Return-Path: <linux-kernel+bounces-855374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B19BE10A9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 01:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AEF44E21E6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8FF317703;
	Wed, 15 Oct 2025 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="De7YSXzd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD9F2D47FD
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760571629; cv=none; b=RzbeSst+p0+xwMeo3PkxaH6UWONwyLMHkdB1ec443F6OEYZ4kpBEoF7hEWGB58SbFVX8QA1xJ3A4xzYP3jQ5IANPaoH3wLPr6qtu93sJ9gW11K9rxn/jZ26u5jVt2OY8pgnH6o0/bS3rIOxEZB1e9sMfc29vxhEFE9Eab4+KeZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760571629; c=relaxed/simple;
	bh=h3lPn4SHDuZ8B/SeJzvXAu0IybbNZk7/BVh6eg+ZpTg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LVDoDvMpB2I5N0sJlwukihTN4p14+SuBUzXGY7qTj5r1WSKoaBhTntOXNOkAyVzCPVStIUoW/uJIc5UbaeIRiTezIu5ZS7OMDIPuDac/DMavxwDbFbmUPLh1X4TAgh24F4GGPNfAI6Q0u3taRsWFcWjVLPZgvS3+gbvQP2vzjxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=De7YSXzd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FIOQCp016271
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7k/qdyCf6EY6/xTcquD7+nOtawASYKaJ9vAG7HtJsck=; b=De7YSXzdaieLnFDf
	jAAtQDQYcMJ/o6GYul1Etn/4LrB/zJqPdEf/uWN0/pWIfkUboXuPwujuP0aHd/j9
	PiS9AulMU2aO/+jAstFhKr3Vho61Fm9Ps5a38boqsABgugJoNfEG8ugl4vPuATYr
	susaUsiqRxpxK+vtKbqUW/AFpkLzk5AUgZpAw+K6I3Zk7Sme6wVABkfxmakvs8MZ
	xzSFEdopz1PEPnLlgF53D5boLcn7pqv9oDcO4aAivGZnju0rJ6jnO3uR7vMR+tRS
	b9Il5iLMxjGh/GUgzsDmqB5TEboHcBqBByAyFTee7WmsxkyrIUeX5/8mWyawKm1i
	Bphdxg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdke978-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:40:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-277f0ea6fc6so2899545ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760571625; x=1761176425;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7k/qdyCf6EY6/xTcquD7+nOtawASYKaJ9vAG7HtJsck=;
        b=Gfw7P9T8PeurWoM6q+TkocbvXsYmQBolxYrOT3ROCrrblINq5zRHKos4Gv8u2eu3t5
         uccvmTnHKMKVVN2qKLTohA6tkovOOQHJZ0kNLpwKf13XAOhom7ov1opFVsj8craM+6qQ
         +QR7I7ahrpOFu2ovKOy+YLb959o3V5MYayiQCbtc/eYIwyQcjbp2cGkW00BgNLUNw8Z6
         omevPbkJZXuYyt/q8E8QsF8R3CeeqJvRgpjS5gZwwaEyU+hFVFEn7yIzMNZ8z7A20tMS
         ncnEkzY88Ft2F0NXAtSyYzRfWmZQAmDFxC4ekvC2WMdvMe4v7itf2FoDoAm0dKGKsx5E
         BRiA==
X-Gm-Message-State: AOJu0Yxbyq4DW1izyKcURYU/9BBF++U4mcPMj1obe8HxJbsMejDZGR5z
	ynpSL/j3dd5xFYPUKNSv+Ml9CGfrHDK5lyxBW0AHwqGy/UasCMGk/bmWcC7voNrb+75TI3pyxJS
	g8y2sTJWfxzVweQfwHafmXxNVCKOGx37sMSIQSYyrr7E4x/2xhWZvAYj3oPnIqRhDnVXG4y0In4
	s=
X-Gm-Gg: ASbGncve4UaXd1qPOBgQQqclbHHpRSfuhStUGOEc/GTqt6mS4deU1k8W3GyfU34VFPi
	UuNPfmdLztKnXp0aU9POhMlxELuwmAv+fqotX05yhQ+e8uK/nh7/QKGTh9JGbotLH+7Ms4CA7Uo
	pCdFHN1RJpXQ0tokbtBJ7nJYOKq15P/S4QK9Osy/nFos9kgaVERuI4DdzmVkyAG9ogEWX7JoDEm
	TerJaxg6eFaYu5jqm+TfeBwKUXg92xgXArKfUq1gcvaEuyV1xQeXF8jotRTRj4vftnRk6ao8IgN
	c7B6UkfMt9cpByroziyO4X+VbpGiKEZ2IgBl+C1k75wXPzgcCWa7mwkO0LqSmH84zIjnM4ZiQJf
	QPIZ0+lL0VJN/47Fx2E/9wC7HXA1JtA76UzI=
X-Received: by 2002:a17:903:1a8f:b0:252:5220:46b4 with SMTP id d9443c01a7336-290273ef076mr338657975ad.37.1760571624943;
        Wed, 15 Oct 2025 16:40:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3b+nOIPoiIMU331nUi5wbIWwSLiE+vi75IqvlVP09Kz6KjMavAizG2yjkJgPkr30FRstaKw==
X-Received: by 2002:a17:903:1a8f:b0:252:5220:46b4 with SMTP id d9443c01a7336-290273ef076mr338657725ad.37.1760571624528;
        Wed, 15 Oct 2025 16:40:24 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7c255sm8055635ad.70.2025.10.15.16.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 16:40:24 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: loic.poulain@oss.qualcomm.com, linux@treblig.org
Cc: linux-kernel@vger.kernel.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
In-Reply-To: <20251011001038.352393-1-linux@treblig.org>
References: <20251011001038.352393-1-linux@treblig.org>
Subject: Re: [PATCH v2] wifi: wcn36xx: Remove unused
 wcn36xx_smd_update_scan_params
Message-Id: <176057162383.260563.8326792169066963528.b4-ty@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 16:40:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: TibkQVFB5XdygOdWYYIan4Ub5GLPWjxY
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68f030ea cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=3WJfbomfAAAA:8 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=1cNuO-ABBywtgFSQhe9S:22
X-Proofpoint-GUID: TibkQVFB5XdygOdWYYIan4Ub5GLPWjxY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX00Ub6yuqju67
 Mf/coxLPjl80GLgJsGZy6yujYoMGYZ+188rF28U1MlxrCJd+w49oh3z6eGeJMeEM/FPPM0MceKj
 xTxxr1TxNnkp7ymPOJ21n7T8FfPN7wmp1yGPA+CYqhsueGKc9zW2B6LPpPbGYmHDPCyyN0tgmsn
 NobfoQHVNuwQhTVtmQzAkUECaq5sDP6Z1fxu3PYqNalU5aBQvwggrPDhR7Cp8GDUqoneQWbLLo+
 MhELEZ2Vq9FpZrqTfYC4mbEcKoXAwvs+SpH5fnJJ5rcUAW6nrxNQ0F7ZnEcRETZtupZOL5ooQO7
 jtbEqxnJVllMEm9eI3p48Mwhp6EG9qrlX2b58sOCDsY+1tInXlfHEy7xrjWl6/cJjuZrA2JGSxU
 oNGCFP9zhdewLBbfNUGDr5BXEKmBQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018


On Sat, 11 Oct 2025 01:10:38 +0100, linux@treblig.org wrote:
> wcn36xx_smd_update_scan_params() last use was removed in 2020 by
> commit 5973a2947430 ("wcn36xx: Fix software-driven scan")
> 
> Remove it.
> 
> This leaves the wcn36xx_hal_update_scan_params_req_ex and
> wcn36xx_hal_update_scan_params_resp structs unused.
> 
> [...]

Applied, thanks!

[1/1] wifi: wcn36xx: Remove unused wcn36xx_smd_update_scan_params
      commit: 4077d7fb27be990a8ddcff9b49f7e1788a960f3a

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


