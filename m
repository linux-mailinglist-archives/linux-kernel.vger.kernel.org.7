Return-Path: <linux-kernel+bounces-862494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5632BF5754
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA9F3AC8DB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE76A2DC353;
	Tue, 21 Oct 2025 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ra0gkOzw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD363C2EA
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038146; cv=none; b=u41+qbbHkzDqI5SDQgwjxEaaowuuXyhNiCFOC+mE1oB6mY7wEx1iksh6I/DzLaeEpJHmO4daAyJs50TBGCiJOOijAtE6SPPbNpdGhymFOU7hfpWienNlInEDClDatuGlzo81REOS+o5DL12L7/iQYxEKIh4xZRMp7c74uyFrc0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038146; c=relaxed/simple;
	bh=GNrGy3kVOCb069qWWAb9qAl3F4zfrvvJBIsSErL0m9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efsIImaDacoOYo2vAj9B5cf9QMWEtHVwh0pRgfVhj09H2TBbj8XSVUb3UjqSoAzcKiDIcHnodEE3ZND2k7n25AJ2HBSHftlcnk8OHgXPomw5Sk4okEjRmEAlDN3KJcZpPTGfPq/Kibt6sxdQt9VAey2/fgWVv3GUu3oJMhJ9ymg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ra0gkOzw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8Bqq2032407
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	avNchYSSQ5C76WL9TdivX7otlmLMTH9erYuzeGDpuJU=; b=Ra0gkOzwzkGEMmWV
	HAWz1/Ail+Ta+Lr+rcEAfTpNe+UnkKBkMZXcEylYUnF8I1p1KdTs6WF4Ha6y/SG3
	PwO+idtwtAdS9qOmJ0ntW3glzURxBEXMWLkrHru+AehWVmBm1RisrExV4WqzpRq+
	9y43pkSbbDY54w3B+pJexaUnJ9Q3ECl/IXhvbf7uZbJuU7lynFJSk97ImiwAiDeQ
	jVJ/lPcgxVZsbUsg6rRqJ5QhTogcoZsigRda/Qrj8/mH/m4mwPZJ+9DU/Xfl0t8n
	4kIBSjBbaT1R675+wgJzYYP9Eph9Dgpxe1iTGi9AcqUGRlniEIGzOV4/REiYFXA7
	K+w5RQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42k80ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:15:43 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2904e9e0ef9so106917335ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038143; x=1761642943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=avNchYSSQ5C76WL9TdivX7otlmLMTH9erYuzeGDpuJU=;
        b=nIaWxXS26XXiIRSPEA1yGll2a6UkcmCvNYsP+ZbMLY4qeU0WI6wINgH36oQ0YjhQJX
         mBv1OE/kwoRaKI/4pJFGhZ7uoe0lDJz0q0ZWhxeIGwPKwZRROWQ0crfWpk5Bkzbyt2Ww
         GAFahH2ZVG+1d0oTF7Pxg/QBdp62Pwip+7W3fP3OxQRTFCNIpfonqvMgjeVSxVMbwgps
         xWZluFctlFJE0dpzbG1fR9TvsfP8UoVHfpJmtYwKXlXSI1ThzFAdd19j5Y4+/bhS7qHt
         lFG/BvAE5nzk/krrvDY4N1KQCNMoVujGu3ny2oFrlIqKvRRQVUv+o5gTmXvJ/sR79JG6
         mUQA==
X-Forwarded-Encrypted: i=1; AJvYcCUMjuQH62Qkm0nO6KXZIvgMf+JobLtD/9RCtaxS20gtAb8rEEHki4ReVyhYnzv5jb1Li0iSACgqzpcNlyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5XYXcLCOx2PCUHPVW7OZUsX8pMYHQs8nyRDPYAhbSiJBy8Bas
	fFmIfMUx5fI7M02TZ8V5U0sAde/OSx4psa7gPnmGX2zlRZ5BaEjbkYWMeUCHhpYuWYqOcrWwJcb
	Qak6t/78D3IrSvc/JSCf8/QDJSQEWiOkZYKmpkLukKn+WV+TCpoYsXQkRIyRuB986fio=
X-Gm-Gg: ASbGncvWZaYqT6algnZ+BWSZipF6bXqLnCk/d1/6C2pGIEt2dE7gQGzdJg4ck0jdZBU
	G+7xR6K3FyNkBS58r7v0YmVbkxkc6Os8sRZDLtEM3WcQEFXG+9p0H29auvRTUI4iMlYQNA06gYG
	Mn13YTl3sbt5+kDhZOrbS3rm8pfZSmf3Mcr/gyNX477H3kHqa6zB3tJ0Ou7b/8EBqurJb7bwced
	WaOf9h/ZChNMU0pSUcTF+FUVWuaPkhC4CEQQuO3KGlrYNfrLMhdU695ovZIpIQhMHI/4Y04EPjk
	Gi8WZzKK0mRapR/WPWEdloXQI0LB/10Sl1UZ0tHrELt5BaviWmRx0FpgYNWDD+eoXSSG9Bd9lhJ
	EoMZCnkTzwt7/PFYgi1Uocpc74z4=
X-Received: by 2002:a17:902:f54b:b0:290:55d5:41dd with SMTP id d9443c01a7336-290c9c89dafmr224968435ad.5.1761038142873;
        Tue, 21 Oct 2025 02:15:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl0wvQqiifAOiiVECG0+AnufRO4O9f7wGK/yit+8fGE8HpLP64lRTzQy6MtrZfs5AVKXRoVQ==
X-Received: by 2002:a17:902:f54b:b0:290:55d5:41dd with SMTP id d9443c01a7336-290c9c89dafmr224968105ad.5.1761038142409;
        Tue, 21 Oct 2025 02:15:42 -0700 (PDT)
Received: from [10.217.217.147] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fd8edfsm103090695ad.44.2025.10.21.02.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 02:15:42 -0700 (PDT)
Message-ID: <2eb77c1a-85ce-42e8-b77a-82b8e175d943@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 14:45:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Change CONFIG_SM_TCSRCC_8750 from m to
 y
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org
References: <20251017-update_defconfig_tcsrcc_sm8750-v1-1-34b1b47a0bda@oss.qualcomm.com>
 <30390038-0f90-48a4-befe-475cf88ba1fb@kernel.org>
 <37f54b76-a274-4ce2-aaa9-88ba0eb84199@oss.qualcomm.com>
 <s2u4wktoi26b5yjfl52j4y53r2bgtwsryacjd22smidl4kbtsj@ahiqbwgrcpif>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <s2u4wktoi26b5yjfl52j4y53r2bgtwsryacjd22smidl4kbtsj@ahiqbwgrcpif>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Mgo2HidfW5xD6cMVXN4yxHhRZiFnew3D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfX4z7NYEIqX1Yy
 i/UXTQHnldkDKEk3vJyq9t8wpVbDi4OFXcZbZcsnVU1ejKkJImR4nR3o5eJVjfOeJPxIyTuIeMe
 QPxRUFy4Bn/kIItgARKfLczz7lqJBzLyIO8sL3B6jDkdrKu3ek0RNIn9SHgCHxa0hjMsv1i8Ars
 Co0ibghA+0S5J79/rOmE/M/miwLxcZBKKh6DIj/DVcAT9gwLcIusQyPz+o03c+ZgnP17W1F6M6n
 9EeP2Ys5YPnpTBDkbd9OH34apf5/9D/dp2L05JUunitXliIhDEUzdISQLSbdZHSLKHx3mjqphvq
 CuxiGpGwqku6jXpaKVE6aK2NkV9AAoR0T72pK2bLcbMzjCPuDrqWQleg1F5mn4Hvtk9abz6Esey
 i7F/BGurEe7EwKXOmSQfTP5WEil9Dg==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68f74f3f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HPpIKNdv2fbYmD8Kn4IA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: Mgo2HidfW5xD6cMVXN4yxHhRZiFnew3D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031



On 10/19/2025 5:27 PM, Dmitry Baryshkov wrote:
> On Fri, Oct 17, 2025 at 10:46:43AM +0530, Taniya Das wrote:
>>
>>
>> On 10/17/2025 10:00 AM, Krzysztof Kozlowski wrote:
>>> On 16/10/2025 20:53, Taniya Das wrote:
>>>> The TCSR clock controller is required  during boot to provide the ref
>>>> clocks to the UFS controller. Setting CONFIG_SM_TCSRCC_8750 to y ensures
>>>> the UFS driver successfully probe and initialize the device.
>>>>
>>>> Without this change, the UFS subsystem fails to mount as a usable file
>>>> system during boot.
>>>
>>>
>>> That's not what I observed. UFS works fine, especially that it is a
>>> module, so no, this is not a desired change and explanation is not only
>>> insufficient but actually incorrect.
>>>
>>
>> Krzysztof, on Pakala MTP we are observing the below issue and it
>> requires the module of tscrcc to be loaded explicitly. This patch also
>> aligns to how it is on all other targets.
>>
>> /soc@0/phy@1d80000: Failed to get clk index: 2 ret: -517
>> [   10.496570] ufshcd-qcom 1d84000.ufs: freq-table-hz property not specified
>> [   10.503660] ufshcd-qcom 1d84000.ufs: ufshcd_populate_vreg: Unable to
>> find vdd-hba-supply regulator, assuming enabled
>> [   10.514548] ufshcd-qcom 1d84000.ufs: ufshcd_populate_vreg: Unable to
>> find vccq2-supply regulator, assuming enabled
>> [   10.565955] platform 1d80000.phy: deferred probe pending: (reason
>> unknown)
>> [   10.573078] platform 1d84000.ufs: deferred probe pending:
>> ufshcd-qcom: ufshcd_pltfrm_init() failed
> 
> This will also require you to set CONFIG_SCSI_UFS_QCOM=y (=m in
> defconfig), CONFIG_PHY_QCOM_QMP_UFS=y (also =m in defconfig), etc. So, I
> doubt that you are using defconfig as is. Please extend your
> configuration in order to pick this module.
> 
> Note, defconfig is supposed to be used by multiple platforms and
> multiple defice. As sych we can't enable all bootable devices. It is
> expected that the users either change their configuration or use
> initramfs. Only "working console" is expected to be working with the
> defconfig and that's only because systemd doesn't reopen /dev/console
> after probing modules. If it were, we could have moved all pinctrl,
> interconnect and other similar drivers to =m in order to make the
> footprint smaller for other platforms.
> 

I agree not all configs should be made y, but expected the required
configurations should be made available. I will share this feedback to
the team and also ensure this expectation is taken care.

-- 
Thanks,
Taniya Das


