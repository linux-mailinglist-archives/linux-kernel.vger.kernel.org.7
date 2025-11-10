Return-Path: <linux-kernel+bounces-892482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6126C452ED
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4420C3B1CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA6A2E92C3;
	Mon, 10 Nov 2025 07:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ds3Biz6W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="elWKW6wq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8E72E9EC7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762758829; cv=none; b=RPyQJN/2/AaglHMX5bfVpkTemFNPkv55g+EbFi0o6XJ11Pqge76fx0o6I+EuWrRDrasiVGS+NpTuAaJpD3lnnKpW1LLqhRH0KHwtqqw22jLJGEWeYpC6MVabHglOHy9yz6dx+rTZHx8x8g5qKNYaM02Ex9tZnPxJvu7igpKtxDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762758829; c=relaxed/simple;
	bh=aP90UFdql0oDm4M3IKd3hjBXMgT+QNuJeGXRkHBd7uM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E2xLA2SEg1f3KGJb0S5CpT6IGU0ngTomSQJq8/ME0xonk7OAaQDDjaxewQebVwvlSNyz6LHzcAhOIIx6mZTe0TwK16adMvbQAUaYpkhrX7dA+uJeo1kI796e7e26KAvNLNTiA0DOegZjnm8EoWqmL8Wj62JMZFwjrOFksFnlp1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ds3Biz6W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=elWKW6wq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9LQfmW1635317
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0u2kfrzFgA2dlZWSM638OT3Edc5mlVUf7StctKj94Qg=; b=Ds3Biz6WpGS6TTVj
	ZPtsXLMuRP/tFyCJ3GWZkDztudelWLciRKkb6as/+fk5J7auLMJmyRiV67nxflxh
	wqLabZjpWz0WeDwpDSVOpYMq/YNb06LsXZsfryUnkbRwNzNF6pszhk71p9L71Eyk
	d8VCCceQO0cvJ0hCsKsIeBNqnfXQsFu8QUhkz7llChyGFjs147hUXfJbTuTKZ6IM
	jvPxaaSn6hnydst5Bc0KMp6Uu5qxleRLrknvIdlJg36zNKXWH5Sjnqd8M5CFHbMK
	y6GVc0nr9S+0ymrN0zdWpDVI6jX5No2P75dDnzqPo0ZxzCI9TSaaKJmaXF7B9ian
	iOFqCQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aaue0hju0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:13:46 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b522037281bso1937863a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 23:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762758826; x=1763363626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0u2kfrzFgA2dlZWSM638OT3Edc5mlVUf7StctKj94Qg=;
        b=elWKW6wqgY66h1OGKiZf/p+durcqHwOxWzO+CfMhHS8XZiZlZrJLI7+33pMn5AMYMR
         OzPCTT8f3FjzV35tN+2uZbkmxXYUwTt4VDLzDWpNtnUZ55Zobae6rUa8ZIbpCaVoJd64
         687bHS3fQm8A68cZQrFRZ/J1v6imHYO/Abh6BCvUdrVezMAzAFoveFCVBio7N6xwA4Ce
         zMdR3dSpvtalGnoO0cqgF4JZ8maYNdWfCoDi9V0gddqjKiyGlhRG7+nqPCDd9+PqHrlv
         wH3bTYRMEpO3V/ybcADHngC7RSgeMiVW3LxAor8dSyZpgX2Ag73nog6owFcd6+10SppG
         LNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762758826; x=1763363626;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0u2kfrzFgA2dlZWSM638OT3Edc5mlVUf7StctKj94Qg=;
        b=wIAeZM1faNp31AkX8P++t43XQWLG1aK96877OGPmNkoCx0pMmovOYN5T10spFHOslg
         m7a/HJjxSrSFUMjWwanSTa/bgJgzPnjzjseUgPrXadzU71rMryvdtgB10H0F2W/GhUSX
         WaXA/MXZCAbzu00eU5SBW6w6hwlMAjtkELO1N/SKJaveSr42lCLXKLy/5LtkyCBU87vD
         wQwgwqONsGe9+DFKhZhhT0tyFOU4G++1L5FZxN3jUUm4AcKIa6LYgR5GbrKfFWOCA/k3
         7uMLm6sGSnOpY41xwiRrsvd2Gc/zDXJvzEcZ3jlfHRGgLKEa4N0Xv60nAe7rDpQNOYTl
         HoIA==
X-Gm-Message-State: AOJu0YxXWWpm9pmP5GtC6PSGoaFStZchYtEkoTKAsaMan/F14c3I++kK
	VEs5H1j7CuusH+ys5soCyRaeQD5HgJXqhvkwjxx/C3d2Eq/M2sqiqdA6+zXNqrrS8JlnFHllJ1h
	QwsRzUGVtVIt3puUmSIL70TgWSGcSHFGdh4Wi/ihHzC07iCcjY3+QxACfwdUDiORscj4=
X-Gm-Gg: ASbGncsF2g+pn67oSSV6qNorR4qQQmD9ND3QJdfE4sGXeYXJCbb0u1EEcsSAj7oFboT
	XFJa3K/euccQarjvhCRy1aLxM92zIDT3FJQOhCmR9ZAINyuONP8LIuIZ3anyXdJYIO5p1vazgLU
	EDrSW1GHy2Je4bJwecOpuMsoH1qi1giBUiGblHnwHithF9DZ/cDp22qFjsGfbGeARNzDLBV88ng
	8hohiaFxdmzSPk3aJe99WQYh4jC3ZMqbpyvBrNxhmEghjiCqGoC17ozIgob+AjGhxnRbl4WUYUZ
	lwD2sUfM2MnHiqgMwdoq4NELgNXxx01zfLHGPe5m/HfMKotyaf6MrH1e+v2kRMGYW7XzLImuDtz
	DCxojd0zDzeYEhlEFxVBqM1Bi/ICHHi0=
X-Received: by 2002:a05:6a20:3d84:b0:342:6c97:3693 with SMTP id adf61e73a8af0-353a3963648mr8974962637.47.1762758825664;
        Sun, 09 Nov 2025 23:13:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1C5fouoELxALLyfIlIbLBUhu4F78OELcJ64xUUUD4/zEp1jk85tJkItOENf41QpFQz1AJhw==
X-Received: by 2002:a05:6a20:3d84:b0:342:6c97:3693 with SMTP id adf61e73a8af0-353a3963648mr8974937637.47.1762758825119;
        Sun, 09 Nov 2025 23:13:45 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:884c:92ad:3fef:1d6a:49a7:308b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f8d7eedcsm11924004a12.2.2025.11.09.23.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 23:13:44 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Manivannan Sadhasivam <mani@kernel.org>
In-Reply-To: <20251106162430.328701-1-marco.crivellari@suse.com>
References: <20251106162430.328701-1-marco.crivellari@suse.com>
Subject: Re: [PATCH] bus: mhi: ep: add WQ_PERCPU to alloc_workqueue users
Message-Id: <176275881845.11063.4284661115624687.b4-ty@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 12:43:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: -O2dBwFTzIIH5Jtfp_VpbTfv7rHui7D7
X-Authority-Analysis: v=2.4 cv=BfDVE7t2 c=1 sm=1 tr=0 ts=691190aa cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=DXX0947HJyerphLxgaYA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: -O2dBwFTzIIH5Jtfp_VpbTfv7rHui7D7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA2MiBTYWx0ZWRfX/YsRPIKl8PNo
 W2sPnHXMSK1xAzF6EZtzg5BGc+vZA0XZXGfGBREU5XYT9oEdguuAdjIqr+1TP1grCbPmw+RoVRv
 HiOThDrate6NBJ5S8KOX/yOuYwNuDJdOhbjU8XTtKND/L2xJ4gupMMxXgc8C47b4MuWU52TnI02
 KPPkx63Qx0wWk2hl1lH0XDGdYZBLOsAh4Fpk2MYHAnD1LRFClE6bBMZKF5RBCL3plhSoNVScKeu
 gIkA38QdGK7kUzhg8LN5BLX0g/VSi5zyNpZwfzRyLpZgYQjHO7az5PjsVnJPeQZRYpaCIK8NoMM
 ryxhr2EHsGBj2E/BbkJhqAtStTU6KRdtohg5KmE76b1D6ytuu2SDErf6RDBhS6Gw94++8YWh86Y
 QdPItFs7HH4ZXrTiEnmzI8mwQSxTuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100062


On Thu, 06 Nov 2025 17:24:30 +0100, Marco Crivellari wrote:
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistency cannot be addressed without refactoring the API.
> 
> [...]

Applied, thanks!

[1/1] bus: mhi: ep: add WQ_PERCPU to alloc_workqueue users
      commit: 9e24bdfecdb071a3a42fb74be1ab503c958e2740

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


