Return-Path: <linux-kernel+bounces-856217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18154BE384E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338824825C3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11810334390;
	Thu, 16 Oct 2025 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M1j8sX15"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039AF305E19
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619327; cv=none; b=P15YkQD0+7y0D1qcOhmlP+bKnD22jTtS8MIdRBXdFo3DE8xqM+/MCIqM4dE+xfPGea2SI4ol8FH92akre78ui0n3bfyKWklmhpSitYOxlYxuzwEx5z/JXEscS+uzv4bRdbJnGloZ/DwcNc64OF1nHL/HrNh/Fqq2AkuIytN/R0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619327; c=relaxed/simple;
	bh=clsrzR5Vf5s8LPOIJDRYghGThBzL1fUXD8xnKPLwPis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RCHpOCFKWaESGZO8eVl6KDF4GW8Slb5PCKiZUS8k1mxMlXe9E5eH+A5JJeAe2lVu3spuH/Fj1+QTNnwA6TZpCdRR3C7DMoA2cQKbNwN46tnDeE7lLhzxIOnP2cMFylny1+yDp8rGYUeKtkmJxfhwjFOJCB8nny3ZgSWWPa5DOoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M1j8sX15; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G758uP015270
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F3vY8/z/UqrVuq0K34arFvPC60E1Tg8WRiYrpR7jbwY=; b=M1j8sX15hr3KLCUV
	pZ/etIUDdMnsnc7bg4qjM345R/QghA8M4JC8/dMj3M71ZGyexF/2uklHL3KU6Iql
	QjmzLakdvN4LnzwxDlsFMgz1qmG4Ice6yYnIHZHwHwionGeKXbiU8Y+OISGzM000
	C6emcbGdG9UbplaE38WcdtSUUBkG0iUAUsADNn80qorfuCceDx6CEHL4pC6yi3Oh
	0rfI7oR1lLRzCysII7JP6I6fYT4s9tVIS3PKKeKmHKOkN2oWkCRxja8vMetLX0ju
	o+HUCFYU/qV8s36Vvr9m4EnvaFKuth69QYI3rlRW/UzTVSepUiGVwHTaHckRtL8N
	TA9qFw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5rexy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:55:24 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87c08308d26so25941256d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760619324; x=1761224124;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3vY8/z/UqrVuq0K34arFvPC60E1Tg8WRiYrpR7jbwY=;
        b=DYpKn9Hg3Y6/E3PTC5tuEkJOownB5Wdb2kI3CwCvh5StA5xxd9AeBMDAjYSZvf6uFc
         tZfdLgAan9rHQA9lHxC2l9DRUulmSA4zL2EStHxabT27jrGFsOT7JqnSrgjmfSIq/kVh
         MWYo/kQ9yYbUtAb0aQ5kprgzaL3Ze6nAQh5PiJ8GFWmTdZfzFgu2Dr2Db/yXzAFFXQMi
         Kbn+rotZDIccAL9aIwJYN+FgwTbx8WlF4mosQpNQsp8Aq23/DngwHFDoCyv/AurSNaAw
         8Ty3wJJwdL7fHuBkQEJxmwJ6MZ1EJE8qO4e3in3pR128GDNzc3sYaFH9/xMII1nIn5Pe
         x0zg==
X-Gm-Message-State: AOJu0Yz9fEeztxLdOtPah2lqrwnMCAYvq7wYBrPqU0y4o8s5VoJlzgq+
	OM8y5FNYRUKZQanaiaQA7NuDeDLkdZpVkRwqFpaCE1xS7/FbddBKNvmBrrk+vKi9mT+NrxBKIuP
	FOLLDEX7uLtIbNkgxMMQrj6iBYDMjecNWzR8RUA1cnhRRirp3H36z/Zz4fYT8hHAusJk=
X-Gm-Gg: ASbGncvTgKlRls0RdqRZ7+i3QvyOBczX+I+VWu0VQyel63hHSsm+H82tPYqCVBgowGP
	wkunZA0oAYODz972Vqo8EqEFn7hpWwJFSJOqQJduMcxnmoO8lrjbW7rlezUpgcmGNjQsoLoT//F
	grZWhl5si/BoaxQUU9JVh5d6yG1+9J6TOUuuzC58x5Q3vq6n78Xk1wkMgpU8DuAAGCae8tVOVBP
	CRHPqqhA86r3rcDDEfLYcSeLcp3yWk9CbDzo5Cz9HQBEaDS+kjKosBmtJeotGEVqaIG2/pPo310
	qiWg4v9G8QGSNWTbi7QAFZc/R+KlXymJg4Uf0ubXymKR61JmOJqn/QyuDXP4iOEtmT/qOiapDid
	2hXc+3iSdzGbX+aNsBfH0psxovfAXczbbMzXU4nFwderqRoFctTwm+Rd+SwLhymQ=
X-Received: by 2002:a05:6214:e6e:b0:792:51e1:b85d with SMTP id 6a1803df08f44-87c20579555mr105396d6.27.1760619323951;
        Thu, 16 Oct 2025 05:55:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCINHqSjdqPrtWSzz1lwFMNKgk5OolR0NkDAfI6x6QPEI6lX9MNTVCACPvGDsRcS/LfopbfA==
X-Received: by 2002:a05:6214:e6e:b0:792:51e1:b85d with SMTP id 6a1803df08f44-87c20579555mr104996d6.27.1760619323420;
        Thu, 16 Oct 2025 05:55:23 -0700 (PDT)
Received: from [10.111.161.126] (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c0120cc36sm39651696d6.2.2025.10.16.05.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 05:55:22 -0700 (PDT)
Message-ID: <1377934a-fb68-4c16-8f7e-ec9610883d93@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 20:55:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] media: qcom: camss: Add support for TPG common
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250925-camss_tpg-v4-0-d2eb099902c8@oss.qualcomm.com>
 <20250925-camss_tpg-v4-1-d2eb099902c8@oss.qualcomm.com>
 <0b7e71eb-1143-412e-a76e-b6f146cb60ed@oss.qualcomm.com>
Content-Language: en-US
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
In-Reply-To: <0b7e71eb-1143-412e-a76e-b6f146cb60ed@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: sAhGQ8Peh2PIX4pula-dBXUM8FumiH3M
X-Proofpoint-ORIG-GUID: sAhGQ8Peh2PIX4pula-dBXUM8FumiH3M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX77oYsRe0JlOI
 XubhcIBuAI080m3kaO0Y7IlE49LbGmz5cS+0dp4sXgViTKA82QmcVtH2BaAFPEGtRdZiLBfxDdd
 OPS6AXwPsJu1FaSPFYXjk2Clskgh85iIl2Q8L4JtGEtgGGQ7mJvpJILX2+hZWBrgwxiPqd6OIsC
 mwrLx65Iu9Ifkz3rxKdgyq7zDobhm2uefm5zAYpKvgJMoOqeYPTfFsO2WPewlAwlY97r0wybuQ2
 1N6pmdHmuUX7vJmDCNWYHnHjHKyz+Qba5Psh7nivRqP+7Lg6BQIENhBqFMHKbejNVa6wJoxzdHT
 HVG1VaOP/guh2Mtr7NTUZbGcQu/u2h1RnkAXnlIQ/hiyAXNDPEpj4ew4+TUfrg3CJR7eKE8Jgnq
 8L/8B+Fi0wUtxVpU6+WjmUcZFdBKaQ==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68f0eb3c cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7DvS_owX7E3HmoQsnjUA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020



On 10/7/2025 6:44 PM, Konrad Dybcio wrote:
> On 9/25/25 2:31 AM, Wenmeng Liu wrote:
>> Add support for TPG common, unlike CSID TPG, this TPG can
> 
> Is "TPG common" the actual name of the IP?
> 
> Konrad

No, it's just a description of the TPG universal code. The updated 
description will be included in the next version.

Thanks,
Wenmeng

