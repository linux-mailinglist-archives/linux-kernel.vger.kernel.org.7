Return-Path: <linux-kernel+bounces-725648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B94B0020F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307AE1AA0325
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8CC2571CF;
	Thu, 10 Jul 2025 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YymyfFoH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12022243367
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150702; cv=none; b=tbul7OOgqNOQsCrn9e0OQeOa/BCvjm7GK4jfkh3hqO9W1R4S54vpgrRFA1FVEBZoRrP0Cyq0WzwRdsb7nPVFG8bI6mF1YLVIfGuZQQj2QVD73h0i73PZINOcjqE3wKhoT7gdh3/fhiHrT4Ho03Vc1GCM6Waw6Rk2OArmg+IbOQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150702; c=relaxed/simple;
	bh=4UremFvQNIY6SzFGgvRQlyRj37Xoe27g/8jhdCjJf74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZMCzmva2ZfrVHQZLl57adQ6R2JMKjhDqOcKR49LA+brAXIOTIkx1DhupMeCE4DcRg++Axox6/aripzZ5Yn97QbrHh6mnbE3tqQi+LDL60DqBkZB1wf6yRggcm6qp368ql6InQvwWxsEK3oi4P2h+NgZzmuqTzUANrir6sXQdFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YymyfFoH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A8JEOH023036
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iHPrDPbQBwwhRT62Gz3CAaiC6cJUX/A2VM2D2Eb46XU=; b=YymyfFoHa80NNStI
	Ok2AN6SGR0CYy/e4XN8Wq/bgrbE6JjZXYTyhqp2JSRWeinD9ixEIJ44YhYXLD1qi
	ukOhGgWuC/wlqHBgoPnDp9QHCdzd6xmqzloDsrsfJHeGWBN4jUxiCgfsWs5E2emJ
	/ax0bRcpU1I7CxHwUnH1fLbAJp179x24kObDlj97y3hs5IiM6eUNPeqwnXZKqYIO
	G0CvtMA+zwXMufX8G5bpBwXRvGckZCBnIe3kUBoMTZddyG7x/4anNmcKIGDdiRjl
	Ln4dfQlOO/dQegO1uZqWa5NFXGOFvtkWUi/jqFqp2vqUhb53HaosTze4cohD6Moy
	+zU0IQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smap4y33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:31:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d097083cc3so24035885a.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752150699; x=1752755499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHPrDPbQBwwhRT62Gz3CAaiC6cJUX/A2VM2D2Eb46XU=;
        b=AveSnEsZC8OdSzdxKo5C3oJFe/NmCtcoNZJcenSgqLlA3gZEstMIDKUg9QyjnndLhB
         lYutxLvsz9nOEe+CUJz60LsMjqKPoZFgr4ESnKAlNzFiAcPsjItCDo4R7fHS2UXgQsPp
         ovvCQPK2fe7gXRd/r8ojvPsC+W6GwuTowmTv1DYZj+qHAeZTkRki6Mho1FvO8YnA6caA
         LUJHVM7+jroCBw8caqxPJxiyqBb7n1Xxwejlt4GdkvUhWC8OrPqWNvDz9SnCQaN3Is7X
         dlcwzOH4U8ft11Dp7c7d1OS6TFtVvAz6eXQG1UOodIBOCt8+8t1NmozVBoGC17RMJI5U
         hgoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgOli2Ra8wPoViEufhgeE3ONh8NhZ0Eyp7VcHqDm4hFYIzZE/sn6zQ1Wln12tB/5h34RlV8+2gH76b0fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZKDtsJBLEgWJlETsaZMNXznX+bjHYjjfNfXCjsgQ/6NVGNBIE
	/M57OV4u/tlvRJbocBBU5kEkaBxBwxO+eY8mRwDC+xNv+Ffa5xu2VqBqqSWIyZdWMXWR7SAEGOw
	Rix/O+U9WKkSOGoiM2f6Neg42SMYN8/nH1dejPTpGOF57SGkCNxtXBwm2oDfc/tK6QbI=
X-Gm-Gg: ASbGnctXBlRXbWDFckbQ/M7tXYa0kPCqr1E3EQkwIA9Nss1X5M+xVMjSo+7wj6ZGUiA
	7KoXZSLAri4K5d35bZZIWlLZBH8G8l01rYEp6868VHHB4akngBrm3LvTA5IVXt4LmrBbadnNyun
	Ppdwaabet6u96qQuIBlAgT1nKmx2mJgREWshpisgDL+Ci0yOM3l27gp51JmHozeuh08xK4gbAPY
	C1wohO8VF1iwKna21z/zLRB/q5jf8ePRf9t/vXnfSISo8frhhijgWOkBKLSUfsCNfpPGsEEdo9G
	9et59pOPUEvurDD2nvGRMvj4AMQxKG+zPs0Vb0lF1KlLx0PwipZRCuEtDasSJrMI6uklgqR+99m
	6zV0=
X-Received: by 2002:a05:620a:f0b:b0:7c5:8f36:fbeb with SMTP id af79cd13be357-7db9035290dmr268994885a.12.1752150698920;
        Thu, 10 Jul 2025 05:31:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/0cQF10VQQBOW78DH3CzzkILAw56kd007Ppv4uFsJOvZmGIFgtlf9j9Oq5orSKWanbpLv4A==
X-Received: by 2002:a05:620a:f0b:b0:7c5:8f36:fbeb with SMTP id af79cd13be357-7db9035290dmr268993385a.12.1752150698546;
        Thu, 10 Jul 2025 05:31:38 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294013sm123843566b.118.2025.07.10.05.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 05:31:38 -0700 (PDT)
Message-ID: <87bd50f1-e4e5-4da4-be68-38badd691d93@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 14:31:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] arm64: dts: qcom: x1-hp-x14: Unify HP Omnibook X14
 device tree structure
To: jens.glathe@oldschoolsolutions.biz,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250710-hp-x14-x1p-v7-0-19c10c81713a@oldschoolsolutions.biz>
 <20250710-hp-x14-x1p-v7-2-19c10c81713a@oldschoolsolutions.biz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250710-hp-x14-x1p-v7-2-19c10c81713a@oldschoolsolutions.biz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ar7u3P9P c=1 sm=1 tr=0 ts=686fb2ab cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=gxl3bz0cAAAA:8 a=EUspDBNiAAAA:8
 a=l6tG3xHbnDtuU65x7AgA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=kiRiLd-pWN9FGgpmzFdl:22
X-Proofpoint-ORIG-GUID: yJzw245VWAcZNvV3GBnUOx5MAcmwM3hj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwNyBTYWx0ZWRfX5MeXMF2ulB09
 6q8/7JCgkKzqrguSD/j0TB/6sl7GDz6xBIhqZ0Kppf95X2t3hm4z1WhcsKqgi8+lKdUtjOe+XOe
 OHtyRyGZcAodqkq8Os1z6pVvyXWEKjhdD9WLH5JkvwYvMwh/4sk0vIyvkBAranbCFukJCZiBeI8
 326e3s8+SGr4i23CVJcn+2Fee4ruK4QWowCqzg6d0b5NoOrvs7+PYqtzwW5Iu7j1xCd3sXCcPb9
 L49POVj3NPXZN0xd5tljF0jk1I/kRdg2jwVcHx9MKFgTJn93OSiJoN83/ZVAAky9yltRWaT2gg6
 iEuaQtzcVvuxgrbwxuUHP1Dr4J4m4C3E7S3VqOcl3Qt+GTT3aYww5m0U7O9q3vQknP71JXljX+b
 UThc+73mvADvB8kZs/YQe3APoSlQsc9YJMNzwmMIV0uooc62CBX0Fbz0XoWEiazR8emIlcyL
X-Proofpoint-GUID: yJzw245VWAcZNvV3GBnUOx5MAcmwM3hj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=840 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100107

On 7/10/25 12:50 PM, Jens Glathe via B4 Relay wrote:
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 
> Extract common elements into a shared .dtsi file for HP Omnibook X14 to
> support both Hamoa (x1e*/x1p6*) and Purwa (x1p4*/x1*) variants.
> Required because the device trees are not compatible.
> 
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


