Return-Path: <linux-kernel+bounces-873722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F4FC1483D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A384E35249D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D97329C41;
	Tue, 28 Oct 2025 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D+F+Uw9R"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002042D5957
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653110; cv=none; b=j2wFwHhNYduIvBJwgH1t8euRummhizoAgTae8YKF6F4E4Scfv6Q/khhRP+VqlI8M+Y4+24LAcAHHFS75hP+GUJmg3W4STcDbr+yHfqbc9aH9Rh7OeGNlunbosv0/7fbgxIUF/56RVf2xgYJdGlbmj1sp7jzOCsbOgckxE95CojM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653110; c=relaxed/simple;
	bh=rbCKjKedGn3lNL5DA8iywRojNwxcHHuGUb+g62HXVcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4mA1ltdIM4YrRuCOjGW/Spt4AKCWLaiqmkfcV/5xkAuO7F7zpf42avnLZOKvl4rmYSMIXJjwdOaZhIzSfU2P3zz5sWQG579il266OEHNzmJVDgU48Du/l+FGj+XcMrTg+R2IxA5y9zJPXh3G7TqrlHNTIAp6awvSByxkxJ9CE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D+F+Uw9R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SAEoYG353842
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AVeMj8aHmAOBLYyWb2kA3eC/uoHRmImo3B+A0gZx0OM=; b=D+F+Uw9RQtOpaPag
	SjSKLaGuMU9gWg4SymJiIdoqnj+A0TFfrU0nWxiHlbhNGoJPPXu53pulvzPAvf1o
	2zG+znbSIP4u1MINv9V89dFII+Ce0oEhf1yNJZy+bYwOgxqvKDHhxe1REvw9Lqm+
	FyEtL214nKq3YzoUnSMl1rHqvmfej/eydAs6W3heDXZ+lhZ8YEflk46L7rqTXnjd
	dxpAIH7kihgHDKfKk/S6sHalqS7w8Mx8A4YSYn+HWOCmITt6Ecej6k21qkHBRxPD
	9V5c67iltDqxn3Revod7BzHKEllQRhVy1+DjsLIdHJGXfQptBovbDJzRc91RE1UW
	SayCww==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2njrsh83-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:05:08 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7a28ccb4c8aso2715390b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761653108; x=1762257908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVeMj8aHmAOBLYyWb2kA3eC/uoHRmImo3B+A0gZx0OM=;
        b=oxhte0tBwYFyrWy7MmiAm/v9jfN+gwj+sX1826bfM16ntracU+zgl+Lljh6dOs4+Yx
         eCvK/pNcLkUo76EnyjUeYX76TwoLMZJZYjeItXGaA4ACdZzLJSD3asfW39vKIujbAE+i
         mYTiRgX82nOOixCaj1JOp5t24KGUaAjafGctOQSR2HXgZpMHklGbDL9eGsv8D0VGyn97
         0SVgeeOneFKP+WeOIe1DKynXP3/kZjLPLfGBbsrKKLGKgqzn3ppkNb4QbbHl0M+LVVIv
         IrxJvgD/lbjEsEJANIdda1lFyeWaWARww3UU4sft23z0+gp9pTTRxgIBKRMQ7fF4MZ0n
         HyTA==
X-Forwarded-Encrypted: i=1; AJvYcCVhN3H5l1VYb+EsR3p1Cq1LY/7G4k68Pb0uLfJDQvsZpuBxr6dIsm2ttToY1PI0GjsZ5Eq4yQrcKu54r+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzQU2yGaTf0qiGMBEBmnFwB/NEik2UUvz3qCOuP0CNiOs+MEza
	s8TdSihoR3+1XrXkT795U8pMeEUWZlo2UagrB+Nm+r66sX3iNFjIeRzExz7mD9awuI+XvDMVIhQ
	WUmJQ9oj1V3ThwafET0EwcdoGUMNo+XvyMilyZLCIzLJCXWRnVLvAg9gV2yukF0Equxw=
X-Gm-Gg: ASbGncv3Eu2ueqzV2XNjSc5Z0XgdBtoaoA0OS4ZdGN+dqDpn+ApoojTf5NYqG89pII/
	CEcHafwQZ0cr8A/OrePsuo+UbxOQwh7syE8eKMWnh9lrQ5vuCsbrdEDbo7ZAKUp1QqXLnIgFDtk
	iBrpP3iOUXv/WRJqr+CKvmoIhsp0cKN5eY+5UvmjFa7BKb50x7LOX80SPVJN+1XOJB1PmCHdrNv
	/1zNJZhnUayuA2niBQjPlf7mmQl0JWrAJaA1A2avoH3VC//VwmXKlZwbmfzKH/gm/1jgtijQDW2
	YucSfoj6uZKHDPGhAD2Ogt7uI177YAYDpL3J9cKOX0qXhnnE0dkz/82ukr2pynUbvOpcPXFh64I
	GuTsY1cLGuCI8YaZN9lcE6YgqKcuC58k=
X-Received: by 2002:a05:6a00:391a:b0:7a2:81fe:b748 with SMTP id d2e1a72fcca58-7a441a92cf9mr3968320b3a.0.1761653107353;
        Tue, 28 Oct 2025 05:05:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIeqxVp1SuLasX8Q2uSFeqD+JQjMYiarT/vEc4wmKhKICAmfDvlDsrfzm0Vj71rwWg7P7V7w==
X-Received: by 2002:a05:6a00:391a:b0:7a2:81fe:b748 with SMTP id d2e1a72fcca58-7a441a92cf9mr3968276b3a.0.1761653106869;
        Tue, 28 Oct 2025 05:05:06 -0700 (PDT)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41408757csm11411627b3a.59.2025.10.28.05.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 05:05:06 -0700 (PDT)
Message-ID: <d1e665bf-9e94-b078-c984-fa2fb1392a32@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 17:35:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 6/6] media: iris: enable support for SC7280 platform
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251028-iris-sc7280-v6-0-48b1ea9169f6@oss.qualcomm.com>
 <20251028-iris-sc7280-v6-6-48b1ea9169f6@oss.qualcomm.com>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20251028-iris-sc7280-v6-6-48b1ea9169f6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dqvWylg4 c=1 sm=1 tr=0 ts=6900b174 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=fr3eplbp6RILtt3BeFwA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: BoYkfA1DXZ-CHRD40h6e55ZUxOJMaH4z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDEwMiBTYWx0ZWRfX3CXewBHTS8S2
 1bLKel4hNLUyVt7d6P9IN0FVyppdRP2sEoD22bWHCm9798haAnmhla3B2GwtasBDKDOWX4sT6Iv
 rAKkU+n5uNsucGhBlY38QKA//BuU19hDSeJAtFpPHXW2glJZIx3jqWVHnqw+nvuYzHKrCg0VXdE
 NR15wM2QC68D0gBC7p2WaHiKr6l38Vtw6zq11HDtLgsWPmOMScyrrhxuna6aVxMjB3oqKdt15tu
 qBpBChuesbttBZrkcYmyrnfBmaYMQi81IFRIiAtsYwX+ubFiGET/19xbotaKkjz4WZ0HFyoHBLc
 hNuytu3NwQq0m4WYpo1GPLf92sO3hibx7Ic8AJ2mj8towq7Qo7sT2O01DtEO5JTIAu7ddbLJ7Vm
 NPrRgxCWH3JiseWxCW1keRGRwlU+OQ==
X-Proofpoint-ORIG-GUID: BoYkfA1DXZ-CHRD40h6e55ZUxOJMaH4z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510280102



On 10/28/2025 5:16 PM, Dmitry Baryshkov wrote:
> As a part of migrating code from the old Venus driver to the new Iris
> one, add support for the SC7280 platform. It is very similar to SM8250,
> but it (currently) uses no reset controls (there is an optional
> GCC-generated reset, it will be added later) and no AON registers
> region. Extend the VPU ops to support optional clocks and skip the AON
> shutdown for this platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

Thanks,
Dikshita

