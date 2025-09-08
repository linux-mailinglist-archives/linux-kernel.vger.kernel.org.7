Return-Path: <linux-kernel+bounces-806395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D448B49624
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDF61640F0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BFA30BF70;
	Mon,  8 Sep 2025 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T8Jo/J9r"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E2F30F7F5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350201; cv=none; b=hxFTnUnXBFyF+amFoYr+7PC1B99+gvOs9EjKy1q71Mt3jvw/QZtL75tWI6+/BGTwWjeJCKePcqo2VjJAvqbvTIk40qGxq8oT0RUQQD8NK8jpu8C+bbYdJ84w6+lyBCV6qkbVF/PR2UOf53/R0wvwz1RIZkqHJPWtl17f4hBf8eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350201; c=relaxed/simple;
	bh=JEtBp4nWlL/gSYH2z2WH6wFwIkvJdVFll98+dPenHAE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iiVS9uuz8GVycLFjxvloSr69tiufteObLGadvWPQJ8+Q9jBhyZSAYBu7yAkijfcXFb2Q+yZehFvf2hDzxqa+IX4369HbR5Il1zfj8CYSY3COzLFGumzCFkKsA7rBy4MQI/2HtSEgbx3HhtnVbMAbISTDVYQAILbypBprolHZt20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T8Jo/J9r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588GU10k027051
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 16:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tmc/KncJcDRAf/6Ym1h7RSvUJ/Yk8F28mp2Cw4+IbTI=; b=T8Jo/J9r57K9cxfO
	nOgTGtQUJ+cWzprP6LsL0tNFyir5S9zbfLkSbc9k5/EjGaqzyPFD5ktblUtkLIKR
	Za5k8ID1/wfiw0B9tS6dSJPzwl9xJhTIWzU2+KEyYnN9WdqqYiNAH2nizgE37/uU
	/hSqmdljTisOGrAP4rHFLjACiClYJ/nbSbt9oxaUGEKeV7eBbqNu8zh3ijNYqRol
	tsYT5/JE34gYW6XBznhJu8Yk70nocJKTINu9Z8NgPP5I4MJGZy2kEpgiGEwgtasq
	DoNHhr4hQ5d7fcR6Mx0BZTg8n2RKX+JxU/DNLpHqMdpsk9JfRVSKdvCTG4eDMHUt
	7HlGcA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aapdkhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 16:49:58 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-258b7567e8cso1227245ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757350197; x=1757954997;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmc/KncJcDRAf/6Ym1h7RSvUJ/Yk8F28mp2Cw4+IbTI=;
        b=eRqezjKnHiSvJVinxTMrx+1m30wSoD9ni2qkuZB9pJsg8ojQHIaKi9X6mT6+7YnCZL
         qePhvJzcWQOe3Udni/72VJ9qN17IDB1WEbeB29rEmKHGMj/cjnp0Q2O17TmnrQ0l2giE
         XtCHX0op6P9N5Yf0z8ySq1SEqe91yRbAunMvOx1k784MW5EyTKU4sxkaFKJ/ZHo1Om/w
         2JZ6omPhT6SrvW6i/J7P/HkE4xISXw7sddUngVsOQvsR/l0rYga/kMdKNsK+8ofjmV62
         lqLZkfPA9m7uv9zgIfs9Z8VlZrv0TOXRdHZwYTRHQwQsUoCJv8N1V9de5E2tzcBKNAlA
         POWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCdfsTIeqh6HPSivFMbb4VLUgqlBPuuFimliAyPA3qc/Hkns1xZ6+LVorsy52NQrmulOYSb2CYKiPZ2dI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy31lC/+r+sjZHnePykNlYDDjPlRef1l0u28npEcVxJ4lfEaRg7
	W0NjG4fbrpR2uQITb1VEr9QZ9rEAo9bAlu/OYyLajNd4lXy8L65oGC07dNMsW1vIZ6mk7Vx5Ivv
	87E2HK00L7u5J+2FFwlJxRX2fXIyVZArC7iCnQPtU1nrMyoP176zTeEwVe8B9F0CG7W4=
X-Gm-Gg: ASbGncvM/Qz1DjajArK/l93GEUHzO4lqn9cfdJFqS9H/RF48bY09xkYduVJoM6QrNpP
	KWMv/gOtLVNLY0YIBQ6a4Fy9qHX7RIt56JsjJxdJTdrWPEYrvZ7BPlr6Q6cD8r6F25mSFZLg8Eq
	7gRto826qR6ln/nOtI1CVYYQx2D8iQypk0HETaUGk7trWyhJ532+L0ffFUxLBDRl9gqrVPMDsvQ
	eQgxM2dMQcyh2/B5NKY/TnubtY75FHAiR/8Typ4ZpHtgAQBbrwZjd3mY+yHckJzuA8Mn1vZlQUt
	Xe3um7a6kNPXoHpQmAldP7v4R81kP/G8zmj/wLBsjKFDlui+0L8LUQpw0GMy+vgOUXKwLThmoHh
	y
X-Received: by 2002:a17:902:ce89:b0:24e:229e:204e with SMTP id d9443c01a7336-2516da05c43mr113562715ad.16.1757350197065;
        Mon, 08 Sep 2025 09:49:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHndtWQTiMWDQbMOMbDHp6W6wnK7I1e6M9IeM3dg7nGZndf9T4LlIhZ3ILQvi+OcSxqbgjV1w==
X-Received: by 2002:a17:902:ce89:b0:24e:229e:204e with SMTP id d9443c01a7336-2516da05c43mr113562335ad.16.1757350196566;
        Mon, 08 Sep 2025 09:49:56 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cb28c3147sm130460655ad.73.2025.09.08.09.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 09:49:56 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250908015139.1301437-1-miaoqing.pan@oss.qualcomm.com>
References: <20250908015139.1301437-1-miaoqing.pan@oss.qualcomm.com>
Subject: Re: [PATCH ath-current] wifi: ath12k: fix WMI TLV header
 misalignment
Message-Id: <175735019587.347840.16470768919118721674.b4-ty@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 09:49:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68bf0936 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=FHtBw0_P-ZgSNNpYaWgA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: L6a3oiQfoCn4LxbZ7W7JWybyaMZOAzeh
X-Proofpoint-ORIG-GUID: L6a3oiQfoCn4LxbZ7W7JWybyaMZOAzeh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfXzrL9TUssva9y
 DGtnqMTSYcE+1tBR8IJXgXXf1gHaRcNNap5ZPRqXuotDGQjHrqQIRzLPsuqoHlFq1HuygDKaBvY
 xqo5bAIfILeGKODmryBmX9hFblj2LlmTqF9NwHRKMJfv5P+keBSWwTiGJlNbDoVPYdheIXPpUPe
 GUE3g2Ir/49yaVwkQRo8MbrgAKCe35bvi/EqzKaH1DQGp9OlLKe6nYPR+Ex7a6Z7SCOPb+ijxHQ
 01ZYGcHDHWucBh7+s1eSWgEmDjALMsxWPAQ/k0cF8Lz1hEsCZyGLfV00bYVm90J6KnAMmPqVS8l
 /Pyv1gfiaYyDT3H/qDfhPUdROj91grhgXtV4rTQLugiCfqH3VQMa3jbIWs5nPyVOkn30lZV7dWR
 PR0lQIOx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000


On Mon, 08 Sep 2025 09:51:39 +0800, Miaoqing Pan wrote:
> When buf_len is not 4-byte aligned in ath12k_wmi_mgmt_send(), the
> firmware asserts and triggers a recovery. The following error
> messages are observed:
> 
> ath12k_pci 0004:01:00.0: failed to submit WMI_MGMT_TX_SEND_CMDID cmd
> ath12k_pci 0004:01:00.0: failed to send mgmt frame: -108
> ath12k_pci 0004:01:00.0: failed to tx mgmt frame, vdev_id 0 :-108
> ath12k_pci 0004:01:00.0: waiting recovery start...
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix WMI TLV header misalignment
      commit: 82e2be57d544ff9ad4696c85600827b39be8ce9e

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


