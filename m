Return-Path: <linux-kernel+bounces-721670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DDCAFCC4B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6623B3AB51A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CA52DD5EF;
	Tue,  8 Jul 2025 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lxpQsEDs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3372BF001
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981726; cv=none; b=r1wW8eZ133E/itBZn59UJ6qYj0X3vUy73zPhUqCH1GTTWRzdfMqRVx/d/zfjvSDE+YMjI9Cxe0zSVtFIKpNfb4F9vK8z+aud3tgtXJXcwNggMqZsQfvQBqOYE03xeY0bq8XWP0ARUA/fvvSqB91PH3LWvbhkuj+lubt/E0ubL/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981726; c=relaxed/simple;
	bh=sdwE2TVMETQv0lnaZK8FIqzkA22DNUIr0KqoTetmc4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HAJB3M6dQ0qqu8uoVPNDg0Ije19OmjNE4Do4Un3OB59aIXgwhYWhitaS9hv8QUGAU7md32XzesEr1tm2zMn9tNH2yyKoEIgo0YiaSYe/iNImT8HeezALTbMYhGkYbuSihOaKPBfRKPT/VzXZDOiwrwIfwtD8sEUnDTlgY/luZdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lxpQsEDs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAPFf003496
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 13:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	au7Gd+bh35WYq3bg+QnE4G6bdktpjK9eW4ZKsorDzos=; b=lxpQsEDsgkgHIcp2
	nBDQhPovOPOmc//dR3UxhpWsvKPQhJuAQps5rKJeX1W1c4e/Oe90WSJbR1IdSp3C
	Xi8G/9kuQtX/0kHYQhYiwGWDhwmysmqTc+cCLFJn0cPmCNCJtUf4qeoZyVfFxvEf
	LwyEVuf1aYw5XfBIpWgsNgSvTJuqPkHuYUMp2Tf/EpDG9xxfHPXeZiyHJt34rUbh
	AcbCB5hsuC7mg0CAP4OtdRfdL4lQ1w6lNvVY6ISP1MqoAEYP/2h6T0Fq7cZ8nZfA
	M6ta3Kj/X9YGhCWxjlQGU86jSPQXdrCAaM4qad4qvlyAHgSoxGCa6zrCXd2kSx1D
	1XSf1w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvefe6tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 13:35:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a804126ed6so14179951cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 06:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751981723; x=1752586523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=au7Gd+bh35WYq3bg+QnE4G6bdktpjK9eW4ZKsorDzos=;
        b=M+3Ae2jbquh7YRzKBu9XxOdmQswwhPNhZh0Lk1EVuHEIk6IKS+A4QQGlhc6qpqsKbB
         lNZk3DGH8z7n0HkpDDd0GrG/jW5f4SZGI40FGNJy2S9ljK+vD4X8OW3ZCj0lz7P/nox0
         dljiRfv6ngSlg1qNUHqrXHQwSxVncffyTyDiZiHjaJjxJKyHwrcHq1o8uJ4WZZv2Del9
         qJGMvB6pXlDZf9oCw50GdkHnu4lFiCsL3tOhuQJTluhJZIhCxVFzIqohRpq3bhHJpYEY
         4TWb1ylTb+bHs+lllI7kE0QIWiOl7gK2pv2XTvnau3VMVkeM7f/a4dsFR0dNnRp9RBXb
         Neqw==
X-Forwarded-Encrypted: i=1; AJvYcCV9Q5+E/Jd302+64x1kr3UuZkmNaPrBq3YbfR9xJDpTW2DsPNHwEWw2xQSeEj+5Y+JpI7GOdfyyk9gUbFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1OF9bw7H36DTCzCjXPUAXa09lvE1eKvX5uuuyCTZdrk0Fz17s
	TrT2jjXYTwhHbcYPHLtgxQrrgF2VqpjfdEwqLH/OgOb1BqeK2co5Stg3c604dxJMfKKAg1trWEt
	LY8dvUjn+KnywV7dgfpE/ohD2F8KKcWt5fTzLPWr3LqLOrH3F++ECytH5p+u1cRbfFoM=
X-Gm-Gg: ASbGncuXF2z0NQBX6yK3pUDKJdhdkwgVRZLG8jbtquWaLq+61RA0SX5NsBAlkfghQ8E
	Gctw9x6upspqjtfOjYGrctLLDp6p4FWXNH0S7wowxgU0yU9oQvkTkO5eFUDy9a1kmAmIFOFfjtm
	pjk1okVSd1QWA8/o9uAo8U+xFAB3x1w6Cg3fDTHINcfUYGlbTJknbH3po92Wv4faOLwscoz06QM
	mKp/1GRBBpDK1bho8Ijr5sAmjl36TKYhSUryfbPvsUZKTIM70EshEBM0j/wZDfpCBTudPRSIwFo
	O4eMnWhYfYDLkMH8MvDHApQ/o/bLxCNVjB1tBvkQtC4W94qwgNYq6/cp6brFp9p3hD/z4urKNNk
	257Q=
X-Received: by 2002:a05:622a:13cf:b0:4a9:7029:ac46 with SMTP id d75a77b69052e-4a99779aa26mr87767091cf.13.1751981722826;
        Tue, 08 Jul 2025 06:35:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX1XpFgWzBh5b3kelydKCB/xI5OEVjo9gU67wYMsPaB750Y8UR7hb8TdcGBNORBgDHXBEW1Q==
X-Received: by 2002:a05:622a:13cf:b0:4a9:7029:ac46 with SMTP id d75a77b69052e-4a99779aa26mr87766791cf.13.1751981722380;
        Tue, 08 Jul 2025 06:35:22 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6958586sm891855266b.72.2025.07.08.06.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 06:35:21 -0700 (PDT)
Message-ID: <048c4cdf-8942-4250-bbfb-3f6a255a5e30@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 15:35:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sc8180x: Add video clock
 controller node
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20250702-sc8180x-videocc-dt-v3-0-916d443d8a38@quicinc.com>
 <20250702-sc8180x-videocc-dt-v3-2-916d443d8a38@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250702-sc8180x-videocc-dt-v3-2-916d443d8a38@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDExMyBTYWx0ZWRfXyaDfJU5slYWn
 B9IfJus93NyUti81Sr+MbxH1FKxy+PjhSaTvuiFsG9o1Kuqr6cr6FSFWFF4x9hdbS47QRXpfhMq
 rKSVRlQWpPXggsQGRVwy7IVDKBW4il8sZJSirUWRD8r7B8k5qfvwVPlOOE086adi/lJY0d/CUJC
 v+1OK7kSw+HGl3ZwmmxjWTgnG/Ftto7El13hIZ9YdHMw5c1PjrDoHjYT5PNG4XI05OiF8Sbx4D0
 nlxWaVawTLyyzlEE1uEbV/lufAk4FQs7v/lrkxkgUx7meVyCo09oCCEL1aD21hUd9NsVIY9q/yb
 Yn5Ybaw44RbZlZ3t0lSrMSLrAluWZpoArxY4LKtFOzCnOG/YYS/T2DbWdoVNmwuGwkAQ4xXOASo
 5XGBWZ6Hp6j0OqTIQjmW45JI9zp0UCmifyIZqEdcL9vzCTimuUxAMIdhDV75inaaGKoX8q+8
X-Authority-Analysis: v=2.4 cv=dciA3WXe c=1 sm=1 tr=0 ts=686d1e9b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=gRvX9a0DaF5FQXGff3AA:9 a=QEXdDO2ut3YA:10 a=pgX1na8PQfsA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: byj3r-3m4y1KURof5dAsUHwkJ8eRKnx7
X-Proofpoint-ORIG-GUID: byj3r-3m4y1KURof5dAsUHwkJ8eRKnx7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=852 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080113

On 7/2/25 5:13 PM, Satya Priya Kakitapalli wrote:
> Add device node for video clock controller on Qualcomm
> sc8180x platform.
> 
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

