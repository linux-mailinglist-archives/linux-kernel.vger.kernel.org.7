Return-Path: <linux-kernel+bounces-833670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2661EBA29A7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33ADD1894539
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206392853E9;
	Fri, 26 Sep 2025 07:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k01Eqm0A"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D75270EAB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758870065; cv=none; b=IL4eWJit2rJGIPOK6ecAHpnj4LSgvlOLi24PvqglV7K4gbhA3nhxJZ1nmub/tleAFtO5XgX1PWJkwn+9d6g3Pfxyty9QKg0LKugKhYMbWIMY1KmGozhNRE4l2fUgbAao6ZmYi2KyXW6nn8oaq0Qwz3DudqdTLBSu+aeUpQcC+KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758870065; c=relaxed/simple;
	bh=zsJxTlGg0VsEk089WKJG1Xw2vubU3qkBIxZbfdEBIzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4b7nT1LyInvpWoXk7IYWqXYDZCXchdDrPcnGs2mh/6cx2IfOlgcetf9zsRp8reG9MaFlCPbKcos7g98Dtc7UiwawC64nfxNdjAwOTeONpBe2t5/m68Pm/gTJxa2/KChe3oNrs9IaB04AbHUOw+7OXRhLYyhN8YlwxoPY8S7fQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k01Eqm0A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q6u26s014845
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	twtmZmjdwxx4BdHpzYanIR/C135T5cqJSpQWsUGZmOM=; b=k01Eqm0AiGl13L1i
	wR2ZJoA2DrOM270U76AKYPoGYgS133g83QovHr7PO3cw2OVz0lePaALQZD3fwOuw
	yOFIaQ6RGmDnWjNm7Bup38ZqQr7sd1TQmTUSoOjydAzCrpktsMF40WiuDcUf+MZQ
	Ipnipgvtj9uU16lOQFJJEmqSalOGEM9RaiDC+zWxpywKhOG3186xdmDF+S5N6jd8
	fFvCr8SXwMNbqAyrSPZ0na+Fbam3T39AdnUMj2lgIWLEdFvVnzd2ioHX4cTXc+Vz
	CVTRtQhzvN/8IaEWjwL4ATANBhuXtrvguZ/dygqO7GKuEvtnL0WjZwC2V1d1QtlZ
	qe8Ghw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0t9sfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:01:02 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b55118e2d01so1331196a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758870061; x=1759474861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=twtmZmjdwxx4BdHpzYanIR/C135T5cqJSpQWsUGZmOM=;
        b=PQ83NZFpf10e2Sj3/rT1+XfRd4MzlcpDUGkbkDqri678wqOH+1iFp2iyWbcsO9wKb4
         7MdbltKqUbYR0IyvaVeDUYIjofWw0Zfur2tqlH9dFWRhTjkMtu/iWV7yRm9l/qP0wPFD
         HTwukX2agRjioYEBZJrT6MP2Jurazucqdxl7GRDVvTjeCuO+mrC/AljvvXaz7H5VpIOV
         ryBvUaAuRCzmm5wdfj146sOded1dKRdlOn8jbg1GNZtC5WxObNsU/HpKLTld5VneSKxJ
         dttfnZJPNJcW1Vgk03kujCvwfNbYQC7KVxdUlduBXodvd2u+OlOETvuzFf9IsvLIRNvi
         Lcpw==
X-Forwarded-Encrypted: i=1; AJvYcCXwQNKH1wUz3yzMIU+6XOGRPzd/atGIavxO52BuI4ff6SV1O4C5FqxX9xfX8Ihn6kyTFVrIwUMv52mBvx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoUsxvcub0FryDwPq6+I4iLnspBOytlE6w47BUu/CtUdP2SPNy
	aXX0HlCsdcKNl63ko/SGCt0N4/pmghJbGHXLv6S1Jn7SNODv0iLG/QNq0VkqAWn1yYkF6EOWpjl
	/1oR423YNKlWv6uIVVB/QPWHLYs5P+9+K0NGDisNJtRGpELx/p2odWXCjz9v0yaZoYCc=
X-Gm-Gg: ASbGncuU0Q7O9M+hXOwfvQB+5BYCP9c2xAViL6e4UJaIVdiNQY+Fhc36VDRaO016WxL
	qVfy4GUAyTFDgxyIGn1NhkNdn0LJj8Kj0B0uSChOS8z/m91uf2zgJ+bPdcdQFVwlrNs6vhGRugX
	xnCgnj/OkMTgINuQIGaqmv/Vj7AqbO1Jqpp72pIfiCyHpHs6AmHZ1yuAYwyS6lrKpnoIsNXhzU8
	zPzVwzsNuhie17ngwB9ytC4g5lnzREcO6tu9dC6Hnx6TnRDvcFvaRcwP49ukUvqlaC/7LCxitwR
	+b4azgwNpzv1xOPKAagimhFZXmXmkrn3ko7rezEHqz+v1DQRmqwZBBXSgPCr+gRRavtH
X-Received: by 2002:a05:6a21:32a0:b0:24a:c995:e145 with SMTP id adf61e73a8af0-2e7c1bc5581mr7549223637.19.1758870061259;
        Fri, 26 Sep 2025 00:01:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyGIYWGRSEBYWR6xeL2JzwaVPSoeKg7XU8yQih9Mk5p8UafMojYVIFSGDBg9nHJ2JRg49gZg==
X-Received: by 2002:a05:6a21:32a0:b0:24a:c995:e145 with SMTP id adf61e73a8af0-2e7c1bc5581mr7549175637.19.1758870060728;
        Fri, 26 Sep 2025 00:01:00 -0700 (PDT)
Received: from [10.92.172.127] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53db8e3sm3891514a12.23.2025.09.26.00.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 00:01:00 -0700 (PDT)
Message-ID: <44c224d3-d5d3-4a88-bf88-34b9ab5239b3@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 12:30:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: qcom: gcc-glymur: Update the halt check flags for
 pipe clocks
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Taniya Das <taniya.das@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250925-glymur_gcc_usb_fixes-v2-1-ee4619571efe@oss.qualcomm.com>
 <9066c8b1-bf25-4ce1-a0ee-16e9ab44dcad@oss.qualcomm.com>
 <gprk7uhwqnj37cyl5iae64qrevkts3z266y2e5k6z72bcujhml@n5yaik3jtm2a>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <gprk7uhwqnj37cyl5iae64qrevkts3z266y2e5k6z72bcujhml@n5yaik3jtm2a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: hFnxq89LbPMAyuZ7khdBNqkvI5hxLtGl
X-Proofpoint-GUID: hFnxq89LbPMAyuZ7khdBNqkvI5hxLtGl
X-Authority-Analysis: v=2.4 cv=Jvz8bc4C c=1 sm=1 tr=0 ts=68d63a2e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=eUHWfAKrTrtQ6IGICcAA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX+8uSCUq+2wev
 jKuXNDvZ5TVGlgTbG2Bp2aINWSuUrawADTGYdt6emMxPjKYAGJ2AUVIDSZ/jTz0bxXYmX2BKGzu
 9oQva2xxUEKNWh92h4LsDWmxVvnYPbgCx5CQwoCCICYTE9nOCqxqjg9TAwPyilu3rR1D8ThGuGe
 980eX+KV0jkywNnOnevPCOT2FHAXvcAIyPCnkfSpevDOs5XqAgtdz+xPkCqK58Nb/hWozxe9TbM
 7dOmEauBWLGqhYWArK5D3WUJ9K7NfT+L253fNTEHB1GwX3uKX413+qiuE4neqkOZgihltGuOaYX
 1/iSVL4sajdBqCSJUy8yHFC07x7TxTR4PJRCRW4vOAXfhqnDmJDasGM0kEwAGhELHkI4JumuDDH
 HhRDcvKsgUh/49VOmprUYlgMGegWDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171



On 9/26/2025 2:48 AM, Dmitry Baryshkov wrote:
> On Thu, Sep 25, 2025 at 07:10:47PM +0530, Imran Shaik wrote:
>>
>>
>> On 9/25/2025 3:49 PM, Taniya Das wrote:
>>> The pipe clocks for PCIE and USB are externally sourced and they should
>>> not be polled by the clock driver. Update the halt_check flags to 'SKIP'
>>> to disable polling for these clocks.
>>>
>>> This helps avoid the clock status stuck at 'off' warnings, which are
>>> benign, since all consumers of the PHYs must initialize a given instance
>>> before performing any operations.
>>>
>>> Fixes: efe504300a17 ("clk: qcom: gcc: Add support for Global Clock Controller")
>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>>> ---
>>> Changes in v2:
>>> - Update the commit text to add the SoC name "glymur" [Konrad]
>>> - Update the commit subject to add more details [Konrad]
>>> - Add RB [Konrad]
>>> - Fix a typo [Markus Elfring]
>>> - Link to v1: https://lore.kernel.org/r/20250924-glymur_gcc_usb_fixes-v1-1-a90568723e64@oss.qualcomm.com
>>> ---
>>>  drivers/clk/qcom/gcc-glymur.c | 24 ++++++++++++------------
>>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>> Reviewed-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> 
> Note how you've responded. It will be ignored by all the tools. Please
> send it correctly.
> 

My bad. Thanks for pointing it.

Reviewed-by: Imran Shaik <imran.shaik@oss.qualcomm.com>

> Anyway:
> 
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> 
> 
>>
>> Thanks,
>> Imran
> 


