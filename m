Return-Path: <linux-kernel+bounces-741927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FBFB0EAD0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0E6188A0E0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA1926FA60;
	Wed, 23 Jul 2025 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e6p8O1ca"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2C526E71D
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253063; cv=none; b=Gy8zqAl4qvk1SNZlASwH+FNM+rf4Oc4tBerd9l6F0pMOc8JElCIYXkO5EtoTCd1CmoGVUiOaWPfKcYtHUbmVq5SUpfzLYHZ3HgIgJzNNgUPkL97fdiLa75/lOemC8N6UisVskq94OYD4Qxnj0HYsgi7S+Toe+hJrvL00THlgr+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253063; c=relaxed/simple;
	bh=ucEy6fLRjgf0oRmbifVYNVYN0IvdlBC98Fcz1R8viJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYgZVNXosgat/YeuM2hMNXYPDVnJImC+7QVPPWvqEw/UXigHbt+3iUCT3SFoBTUKRB55HZKMBYjiIWwFc9+/IjGMUWOhFPW+7Tb+mJP6F4IaEJy4lDaYBbjYHGexJhiTM+KXtWDg+5ay3DwqUtpZGQegecSBNE0345pmdtypkTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e6p8O1ca; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MMONn1015991
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6JRtXfXWNAwsFUIN8mSiqpepSISde2xx5Vvzm/Pm6/w=; b=e6p8O1ca/CMYTbYb
	8V9N/8eFOrn5IAr/t/LDhmq4XF9NBku76JQYh0D0VzJG1qalhcJh1bi102A9KqIs
	GrxkdIXOxIgun6dnKL87bCKC1xIbr7rep9e+Gz/ZxOwqBOnRe5EElXqtJ099iM+1
	h9Ll0VVuY9c2rAazMjPCY9DI0fmfAm4W9/vXWwSjgjqOzmdPu8OgUG9XfuVFhV8n
	qnjJtihOCUuPW6gKDxPVWvtL9cqK031OHwa6vPXyTja2tAIk4GJlU0W436hBoYFH
	T8O7/oWUXoLbDwJ8a0mZ24nKWbz8V7BAMKFmHhM+NqcDmPovtiBVpNMPskxYZJsT
	2EPD7w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048vaeej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:44:20 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b31ca4b6a8eso4481670a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 23:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753253060; x=1753857860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6JRtXfXWNAwsFUIN8mSiqpepSISde2xx5Vvzm/Pm6/w=;
        b=YMozK022//D3yo/i89RpbvTiEmwxNnFlNIUoZfg41x7sV2SU7QptIkr3UxZJbYt6B1
         bhcDvXLpLBOLQsGZ5fxv+8Zj2WqVNs7vqXN72XjM2M+Ugqa6prFvcRY+ijmzml1RJz6B
         ErQPzmiqipdiT2WjOwR67Vy0zh31L4ry0nsTOEiSokrw6hfzObQ7yiMRn6WzY+ywvbSM
         NIM9o9ApWvVkr6Fd77bbJ9uXTUGln16RhdUqTH9lBH/qEfPonlhgT7FRNnYp1Dfzfd5t
         aeOdgJltyD3H36flDh8rgwA/26+7Eum8o/R7hl2RTetgUm0M+fhLwkZgsXCnezF9gMhQ
         POQw==
X-Forwarded-Encrypted: i=1; AJvYcCX6dDKyUIdnj1Pbax5hn9LLfpDx+EmyIliM2FQxtChxXVnrltViRfTqrtnnOs7QrbMkM3qYzlnIMfI6+tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDXm4u7HZ3scK7jPlqIukWd8pW75UySe3NMbvtzaQLuQImTnVc
	nwJ76tgsCBiKgca1BsxdlxSfIrDwjU6OWeGEPr3IAqslW/f3vZSDPRlZW1z1xJKkQvJ39k9N8cq
	ipyz9uf8u/qaZWaff9zvROGn0OjozN5DwahkMgbQG8zRH/mFEx6Srv8Av3A1LTRDo4vw=
X-Gm-Gg: ASbGncufhrt7mELRqP1aS1Xakd9swKmteWcrQSEqhwN8nGx4DXgRcjJW5Vk3KDC5kNV
	B/llA0N2Sn9ePCfzUpyCip/7UkSMeqFJbitIUqEXLXVEINAkD8Ir0a18irta7a1xxbzwUQsHPrv
	QFfG/5ai2sNlU8Dp64tUC0Z9Z+DafxDMfNPmAeZi9fhqEWsWSIi3hyEtuWizXyRjhc3TCfQfI9H
	/aRO1bt1xlQNVlulGIHSqMDX+mYlgXFPqvoeEjZUeSSojSrHQD6DaEaDOYSn/5mxAKA6ZG7+sOg
	eeNdxv9f0IYo6THqAC0S/C8jtq4iY8wD8ID6O+iwiGSe73eJSk8XlajpS2gxp1blJjL5gf/Xuhf
	8L8fbbGFAP9n2UYJcPtN/hHza5+s=
X-Received: by 2002:a17:903:1a87:b0:234:ef42:5d75 with SMTP id d9443c01a7336-23f98172251mr31235615ad.20.1753253059828;
        Tue, 22 Jul 2025 23:44:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFVH+w80Ld1jep2IXncJykzXgw95JBuzB7zrCNRM6xwTzer0RyGCP4PzDfAs0mSYUYgo7b2A==
X-Received: by 2002:a17:903:1a87:b0:234:ef42:5d75 with SMTP id d9443c01a7336-23f98172251mr31235365ad.20.1753253059416;
        Tue, 22 Jul 2025 23:44:19 -0700 (PDT)
Received: from [10.133.33.46] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3bdfe68csm88659925ad.183.2025.07.22.23.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 23:44:19 -0700 (PDT)
Message-ID: <67ca3b6f-3cd3-430e-886a-0443f6d630dc@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 14:44:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: Add HAMOA-IOT-SOM platform
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250716-hamoa_initial-v1-0-f6f5d0f9a163@oss.qualcomm.com>
 <20250716-hamoa_initial-v1-3-f6f5d0f9a163@oss.qualcomm.com>
 <0f9eebfe-21f8-48b8-9b49-a35126aa6dd1@kernel.org>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <0f9eebfe-21f8-48b8-9b49-a35126aa6dd1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: C7_YrEbYUhFSwEAMvBsPcNJ8LF6CUViV
X-Authority-Analysis: v=2.4 cv=SYL3duRu c=1 sm=1 tr=0 ts=688084c4 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=DGOirDVRF9kFrzJQLnUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA1NiBTYWx0ZWRfX6SAcFQPaMxel
 A+qqVIAMwaXqgEev/QJ+MGsQY60jKa5074zcGn3otcGGjX6yPxno9zk7OUyq0afB/yKNN5V7zJJ
 n3WohvSdYE16A6VWKFGvo3kcliHaC7KyDDj2SUDtcgfecq3XhmeKLvs/4AZEMevfawAKFeYdY5m
 8gYH6lgNcm60bQuAWCN5ekNAQrHtmBb6ZBOBJtcwhDBOMp3gdLDY6gZa0xaTM411yOoMg9yc6CW
 ZlgPo9rxn2cvtJDek9IDawrfq9UZmQJOnTPg7QdSFONrcsyPS1GmOUIdLzeWql1Xe03073vKubR
 CjT6+tmgz1np3W+AJPbcyrSrXydBXFYpmkJJPyccN/f84frNQ1+UGecR55L5Lq9kpNPEkOk6uPU
 G90Kx9zZbBfWQhifI4Hl8KVDPJOQic6VXUygH0OMh1d2Dva++FWYbJ+/Nm9rpVvizWJCARo9
X-Proofpoint-ORIG-GUID: C7_YrEbYUhFSwEAMvBsPcNJ8LF6CUViV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230056



On 2025-07-23 14:28, Krzysztof Kozlowski wrote:
> On 16/07/2025 11:08, Yijie Yang wrote:
>> The HAMOA-IOT-SOM is a compact computing module that integrates a System
>> on Chip (SoC) — specifically the x1e80100 — along with essential
>> components optimized for IoT applications. It is designed to be mounted on
>> carrier boards, enabling the development of complete embedded systems.
>>
>> This change enables and overlays the following components:
>> - Regulators on the SOM
>> - Reserved memory regions
>> - PCIe6a and its PHY
>> - PCIe4 and its PHY
>> - USB0 through USB6 and their PHYs
>> - ADSP, CDSP
>> - WLAN, Bluetooth (M.2 interface)
>>
>> Written with contributions from Yingying Tang (added PCIe4 and its PHY to
>> enable WLAN).
>>
>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>> ---
> 
> As pointed out by "arm64: dts: qcom: hamoa-iot-evk: Enable display
> support" this is incomplete. Adding new SoM or board is one commit. Not
> two. Don't split board DTS, which is already prepared/ready, into
> multiple fake commits. This is not a release early approach. This is
> opposite!

The inclusion of display support was not intended in the initial patch, 
and it was not ready at the time this series was submitted. Since the 
display patch set was not submitted by me, its timing could not be 
controlled. If preferred, the display-related changes can be merged into 
this patch in the next revision to maintain consistency.

> 
> Best regards,
> Krzysztof

-- 
Best Regards,
Yijie


