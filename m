Return-Path: <linux-kernel+bounces-727631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 683EBB01D51
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBFF1CA52BB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CB02D322D;
	Fri, 11 Jul 2025 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fwVu9VcN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC05270810
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240258; cv=none; b=adTy+zJ4joea9KXEDkuEhPgbm/W66QsrfYVlNjRQCzjb3loIvgNIBT4GO5GyUdGFAC6DUN3+oKXtFD97jYGfb3+L3JGrU/6OV3thhOo2ZBJOhW1chzuSTkVbTDyKy+8Enph1FPx0lV/MfNN3tD63TLnpsu5lFK9C/MgxRYCMqwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240258; c=relaxed/simple;
	bh=NgtS1EmWVgbZ5BD/qpQ9GcI7+8k3FMMexwP5SwX2F2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddD1g92mWVLCjube/n1aEiZdP/JIUxiKwQOCwRUIK5sMWTs+rTfKmffJs/Lhujdp4WtDD1LccABabUtjE332j3m+vfh49uX2YmneaLyDRXkDmrh4BzN9wB4u1zoyxZrHpvk6+340s1Zv9LWfZ3TqrHFqTf2WBe3Zhs3x2He02Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fwVu9VcN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAbrtK021754
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	odFc9lek1J9Ea4hIgZEE1rZ395qIdHOs4WawutfpGlg=; b=fwVu9VcNOoPddaFO
	oel4zOwEZewdvJXRr/UfBToAgDfYZeD+ADRyC82AurPs09ysjx5JcQKgaT4zueuZ
	IJQN0/ZUYso6TnSnbV42Hbb20C7+7hIDFz5BSagUwDo/ANjQETz8heqVGcdmkjZ9
	xzNReJ0OUPvPjyuNC+K1w2iQrW6vl46ePnT8hffZZrnIXPkzu4KBOrglePeOecy9
	/zKCiBrViajQSY8fD7rAU5BDptKWA3eDhcFXFwgbjj0CWsZ7KRwy4suc5LgispS/
	BZrC0VhOYYO/QIX/AHGwacIdDQssWvoq1g3H/tBZs06CNzDEKpMGstIKFrm5nlda
	WsmHyA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b19pv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:24:15 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b391a561225so1711244a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752240255; x=1752845055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odFc9lek1J9Ea4hIgZEE1rZ395qIdHOs4WawutfpGlg=;
        b=Bq7Ecz9Ctw9cqRKX6ovd4OVcIjzXhCVv8dQd5b2FIQLGbaPcxlGhsqjGK9W2/XYVD0
         fvLm51nlk4ritLxEtGt9gv+warVGUWf7rhWkafYU604I2kZ+I5noZEa4YOwgGlZin3Vz
         93veFSmdPu8W0COBNQ82AjjTT+JnzjcLRm4R4So1JjheZoAUUtl+IgUBZXlSOPTXMJN/
         1+0wLup7w5bWhwNTfy6ApyW2yHz2mMjWxBAlMwIvGSpbo6qqbxTeYc7r6oY8izqDZfyA
         zhtbf1UMk+21erd2BSowT98OACZIc3Lg/Z6/Me8EJVCBjYVWs4vhZP8Vemx4UoeOvROR
         kxhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxXe4NJDqvI/aFH2p3O+A++9p/9nwB8DeXMFoW8jK3qq73TSyA4BN7mQ0PYK6NW31K69biKng9usCwqN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEtUS1NLZ7zA5bBmAuMNJykrGjQ275ud3kfr6SDtGZf4vVXdbl
	hMijiYVLJ1cKL5qq9UjZ3rZOlncQS92Ug2Zbws0IpGmZA51RsmGwNuMHfbvgotENaAn5M2aG0Tv
	IovkgMwBGiWxSOix6M/sMuinEjbTn2B4dI9bMBVhsnKOp06WIL0bvAmhWogoir15t2h4=
X-Gm-Gg: ASbGnctzli4O5+TP8ayt2GDf3C5HY6gS7PwUo4GqiVPKQhUPtvt+xutWl7ASPfxm6FH
	ed3dWD3ey5t1yJFCOupURcWo+UR5gDQAFFRikQHMSdxXbKN+mZTF9x/WB/mINj62MlJHUxc1Si5
	blrxLScaRr+VYVjwfq8gng5qHu/e/Z+V7/FMaG+RoZxUvA41/cHPzNtujfcpba7Ehs97G0+i/7U
	An9Y2apZTu7LoRyxYFD3moMgoTf1qh1BCDttiszt1Ts2BVI2Jrzr3M00tSrWe8Snj2wvrO61JuE
	eKe43gejMXnWbCRU0gjRa7DF0gX+tKWSFFChI5LoEmzxzeuuPNkmjK+4XVYFkueTv2ld3EbO1+u
	Rf82uog==
X-Received: by 2002:a05:6a20:a108:b0:220:3ab2:b50e with SMTP id adf61e73a8af0-23134a6a353mr5181480637.6.1752240254886;
        Fri, 11 Jul 2025 06:24:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKWYvrPzPxNDVVUSkRUApsGUonmJeg+FJ5IoG2w0UGMLPWCkqP60kgeEq4SU/Otujs4RF0Ug==
X-Received: by 2002:a05:6a20:a108:b0:220:3ab2:b50e with SMTP id adf61e73a8af0-23134a6a353mr5181426637.6.1752240254306;
        Fri, 11 Jul 2025 06:24:14 -0700 (PDT)
Received: from [192.168.80.70] ([106.195.45.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe731effsm4594339a12.77.2025.07.11.06.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 06:24:13 -0700 (PDT)
Message-ID: <e5bb0197-70e4-4b4e-922f-baaaa2e514c7@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 18:54:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: socinfo: Add support to retrieve APPSBL build
 details
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250711-appsbl_crm_version-v1-1-48b49b1dfdcf@oss.qualcomm.com>
 <3cd5864e-e6cf-404f-94b5-b85866086d76@oss.qualcomm.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <3cd5864e-e6cf-404f-94b5-b85866086d76@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=6871107f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=0mVmtUiqVJf9Qam8E1VsLw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=oWeigVbhGAZlHacc1VQA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA5NCBTYWx0ZWRfXx1s4Ctgz6yvb
 tRU2vMAmFqEPdVv4ayaugkipysSSvgm6fsOx3Ldqr6dvO608yP23/3F7XmrTslPTYScjzWOCVIV
 TPZq9JHlNIbnINMblzbIHhT/+dRWoJKK7013wGSmCwDq5/nW8LyBVw1/TPABwprxmvK5GLwwAdZ
 vfUs5uygMAVDTo4coLsCTQTUz44Jb0eC7+WHsGUSheMybPSK9uja8kCtHG+sp8ryGaXQ1Mdxmte
 4q9fAReot6Ba4NTNOlBymObncGa0c8WCv60vml1FEHrcUZl+22ZjA54aCbWQbfyoabm9BqEWG1z
 PFNKNGdoEV7z+ZP4WjeAjVIer2OrFmnqRfonb7UXkET1UYbX86gPfpj2nTnWtDvB+ANR17rDswq
 yPIHnFIKt/UJl/2Y6eXpAyATI9sH5j2IQ9MtzASGjPomJGiYE0XX3tzFehDrqbw80D1xorOk
X-Proofpoint-GUID: vzd8f2YT6ICZFhYNw04L5VfPKXVPJmcc
X-Proofpoint-ORIG-GUID: vzd8f2YT6ICZFhYNw04L5VfPKXVPJmcc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=530 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110094


On 7/11/2025 5:41 PM, Konrad Dybcio wrote:
> On 7/11/25 1:03 PM, Kathiravan Thirumoorthy wrote:
>> Add support to retrieve APPS (Application Processor Subsystem) Bootloader
>> image details from SMEM.
>>
>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>> ---
> Can we expand the driver with all the known IDs at once instead?

With respect to the IPQ SoCs only APPSBL image detail is missing, which 
this change address it

I can expand the list, but unfortunately don't have ways to validate 
them. I can check internally with folks to test it or even send an RTF. 
Till then, can this patch go independently?

>
> Konrad

