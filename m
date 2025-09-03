Return-Path: <linux-kernel+bounces-798505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A30B41EF7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D906B681ACB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005DE2FDC57;
	Wed,  3 Sep 2025 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ktaQ4/hw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D832FD1DA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902559; cv=none; b=EPYYHsZxM4lttUMbgKMFeqk/oyDq24Yqq9EHWjSj61VMHGUzlEsJvyV9TEtX0XTgyN1Xqu9hkiTmWMDJ4eyhSHPO86scDfwQsWWnANTw0J1/YSaiVlFFTIocw1QFXXba18CnPoQrOBzPvPbwCYW7hf23CV27IKYFUz5eveZB8EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902559; c=relaxed/simple;
	bh=A9dV9MzzRS7f7sUmnjGGXBEY4rJvJ9sPSX+m6Kb3Hy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zkc+S+/d1cZ9tFlO6t4zIN/HR6eev5sLSZ2jb4H1LLn/50yGK3gkO3H68VaTZH3CxiprFYbtxvYwI0hYgqJEP/aLfQn1jBV93iab7exHl4tMp70pP75aVS4jbzUed94kcMQS4VFoM9kR0lmFiWsChqQTzZjvN03fI/HQXIE+E1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ktaQ4/hw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BF4xu004543
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 12:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iJkiE1eASptH+38OuzSM8e8j/YvwckD1P++seiOH/6E=; b=ktaQ4/hw0RXqJQcW
	orKU/NIKtA4oz1uuQ/u9nH7pzROaaeOEWbG+RGzd+5H73sRS7NP9Gqn3I2n8OYnl
	Kb5bq7DQgsB8nihYtM2dfpuRxu1f4O2hcjzBqWkMKin+h6LjZgQQghKP7CuMY3jo
	RUr/HTRWT9TRs2Wu8Jbxl0Oz8ZDiPtFV2nhUEMSYDbgsJMP81Ob4MvNqRWfR63Uu
	CGkyhNi02mDwa12V/cCT93voqHAzt6Asi6Lu3Ss/fwfn3d2b/I/Vyk9rAi8ytaGS
	GWCHOpOnrW4jPCWboawHPqL7rrnxUlIUgRPd4+spMEk7JxFBxAgKPVeheE+2flm+
	zVPlEg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpbsqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 12:29:15 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b3387c826eso12203501cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 05:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756902555; x=1757507355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJkiE1eASptH+38OuzSM8e8j/YvwckD1P++seiOH/6E=;
        b=XGn0KM+y7oMQoLW/vrH4BwtulAecMoHQjZOF0YK6N8WZbaOzsFgyoJTisQ2HWXICwT
         /acv6pHIl1jN0OOqvMqVJlNE2l3kGpsI+Z/RL33+rWOjJ08AwCncstjQGAKa7AoGpY/G
         7vKFRUh0EFRLLmz/10rGiIHEOeuI0qTFOQYm5S/N7aS9mk5yUmWPgalpAQ2I4SsRw1sy
         K/WGraY/2hpRfRCxqnlVv9DzRq/fDXWfrR+NxZmj6xMz1m5bjg5IRcAWBl6yIQP9Fqin
         iaZzLJzJgbVZOx+bPW8aUSVv/GMHB1GIOrDX80Hp8HlQg+ig1ogjU6SnDyJKImTSeSfn
         ozVg==
X-Forwarded-Encrypted: i=1; AJvYcCXVgWP1nqj9YVDu9JNpItydJjM5tTtc3yKfMYyQyDuVlxsbRADUxdJhBC2YaACvQcNELoScna7blUXun60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdLrxQicwupWkCSHy3LD4H/wrdgOEW2c9as40DdQcgje63l5SC
	9xWLG16nXsboLYITy26zWjhXeXwfJOcgQD435vbhdDXpa96eAb3DBI8hbNkCMwoyFD5Gc7LiDfo
	BjbdXDsBYJtBHVzRN3c3E7YzW6icI1N92u3zQxciIvk1HJbgmi4fWvqHz3W9G10+px0c=
X-Gm-Gg: ASbGncsn7jLLfD5qA9m/ETUjEZluiRwp3A/NP3J9BDY57HQTPcLo68iRe1XV/EOdMwL
	RC3j+ocaIqs+3Hyb26KGrCnBNFU7nBIYleDJT3Q5RAlG4/64WeV4i07aSscFX+OZan7B85PbYHV
	+bwwdQrd60ZG2uYNw7AtTpDShtltR+aj6PCOUNeyyWDs8f3TpsYTHXmT/86ED9sS82KGNuKoAgp
	M65JkhYvzvFCV+NLXX9whyjzE3jvLR55LLdy3Coo0TKJ+TWcDb9DOKpGrbk+RH785HJkejh2PnH
	LSj7tGP7bSF+nBUpU+pohgRnefF0s7tWIVUjxUk6U+U139xiw97hGpO8MlLJbQ0UeguLpsif8q+
	6L8M8nflYfO2VlYEzyQ0uhg==
X-Received: by 2002:ac8:5d87:0:b0:4ab:5c58:bb25 with SMTP id d75a77b69052e-4b313dd02a0mr130173961cf.1.1756902555218;
        Wed, 03 Sep 2025 05:29:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ1Zwf24euReXChwxJjl+rksidozMJsPEhiBEXPVc2h9t0ygR1jUfMZwAeRpN+DG+rD3vmEw==
X-Received: by 2002:ac8:5d87:0:b0:4ab:5c58:bb25 with SMTP id d75a77b69052e-4b313dd02a0mr130173701cf.1.1756902554729;
        Wed, 03 Sep 2025 05:29:14 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046cd5c274sm117531466b.98.2025.09.03.05.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 05:29:14 -0700 (PDT)
Message-ID: <39c258b4-cd1f-4fc7-a871-7d2298389bf8@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 14:29:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] arm64: dts: qcom: lemans-evk: Add nvmem-layout
 for EEPROM
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Monish Chunara <quic_mchunara@quicinc.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-4-bfa381bf8ba2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-4-bfa381bf8ba2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lvm75WX9HH77DDmROAG-Kjz2KL1cz4fz
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b8349c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=UjL6BNg2kQWBM-km_-QA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=kacYvNCVWA4VmyqE58fU:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: lvm75WX9HH77DDmROAG-Kjz2KL1cz4fz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX6aPL1lbb3Uv7
 nLljm5BWbD11C9xrwCLWr2X8Y2wP054hD3EgebgAFdeN86D0R9uHvNBYKN2TtH2un/Uu76m+fhz
 yMSVbGvJlmJ+/XIVL0oc7GEmbDwJa2suNcgD7B4lBWtJK2bGMD9Oojq3vN/ZCtTMFtWJn0n0rv3
 41DIGZRyCe15b+zoKSeAfgNfopnzQm0RbWksfVdmm/QrhQeFCDnhHmZcgYS/bGi1oL4gGJEa0aL
 opeg6XvQk2p8eRJ4TDlZxZfX110w6hSNeNmBb1eWu0QTCPZw5sdIG6S+3/CIshD00u7Lrpyr433
 pmjQQ4dCYMc0Md25n4p0kYmWz9msXykgJ5q+9WvLLB+Cm7c06WVtLtJkBZrJIxcoRbXS1LJJ+Jt
 gZWLAZqB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On 9/3/25 1:47 PM, Wasim Nazir wrote:
> From: Monish Chunara <quic_mchunara@quicinc.com>
> 
> Define the nvmem layout on the EEPROM connected via I2C to enable
> structured storage and access to board-specific configuration data,
> such as MAC addresses for Ethernet.

The commit subject should emphasize the introduction of the EEPROM
itself, with the layout being a minor detail, yet the description of
its use which you provided is important and welcome

Konrad

