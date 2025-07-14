Return-Path: <linux-kernel+bounces-729823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE405B03C05
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A9B3A4C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4179F24502D;
	Mon, 14 Jul 2025 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iPJvzfiv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38233244669
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489510; cv=none; b=Ca4WW72EYl36h5aQrbhPKc8Z6t37gP2wMmyIJcA7gVHT/DLqNttdx/4AFfK6AY3UFv+wcKm3RE9ty+xzlLRkNoX/GVWnn33fJM9Yj7af5OGRsrOuOhKB3GxGgd0SvOo/UIH/txKEmkR+jRGLIZaiFk/tOcJPntEgUqKzw0sCpqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489510; c=relaxed/simple;
	bh=GZ2HGTWvnUJlQg65o+LqMmyqo5eSrqABc5KMQTX++6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n316r35jJTry17c7qR0KNP6t3/SYToYXXLZ8fxU6qK7JeGFNzTBuXHROW7G7DaGTYtJ55MUzUgCZDTmcBTJ3RP+XuZvfbOeKHJHAOFe6uU44zU+dyEoPoTojf4MQ5dTgL6xYaG6OKH6q4M3XK0mDUoKoDeDnXlhHeuhmWJ765og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iPJvzfiv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E7Qjjw008207
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L+pEamc9vV5xI2V2tpf5IYZyBkoyhwgtCvGmaF6cxpY=; b=iPJvzfivcslC8vxF
	9HUN3hO3mzFF0ee/o0RcLf+koZZ0vn4aaILSc8EtMtXNLduA35GhRDuQG8oi/7u5
	GtSqOK1iB5MHE3z/HSMtsqrake91ZwyYx94wK3F4DTY6hAt6E5IFQ7ACAmw9sb2X
	zKtdp8Vh9eh64wSe/qX4NBj4l/oUbjUFXcv3/RWi0d8Jb5xyUHGDwd7jmbB2XM+g
	BQ+ebwUaVSa4PxKGYxqTHqNRsII0irpgYgdYZ/b+9wuAsy+CSxYMBNzJKNiHNiBH
	LmxfDj+0nXQbN6NVfhjvjZfqMtT+rwOOY89Rogh/xlLVF405bVjl30MfjVRDrWSc
	9q3GbQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47vwghgq1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:38:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7df5870c8b1so44028785a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752489507; x=1753094307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+pEamc9vV5xI2V2tpf5IYZyBkoyhwgtCvGmaF6cxpY=;
        b=we69Q9LOg4X9snnxX6BJ+leFprsFyeY9vbD1ETwzurqZ/Yf5irDYNnsd/JSHDIEoUo
         bIdJbV19VZnl8e3WYe/8d4x3L4KPI7p4unftYB1jFyb3Lw0YcSh9mxQ1ZjxWdjDH2J83
         U03ljI/1NG2DrOGsKD6oi8RRztAqNvc8fHIXlJWy1N5r0zUvAT8AZecg6MlXUAJubwG5
         sv1G/Yprq8kD56XulmZZ3xMCA2enee5lxeOa7J+KzWoGxLJ2o4tz/fTqpIdsOsfjNV7k
         tDBH+3oLFemW0LIzY13c/2V/iSMtETcsIjEWsSTK2+yJjP+odl8oGZjgJqSoBRyy8i/Q
         4kKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNqfmhalXiwEajvEgcIcW7VFj69Q4myExuSJpcOaOYX0bs9OEq46NOJRxDVjWo3f0xiNNxjCqBwJISV+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YylSWUnJ19QZyEywcMtjIzQVW/KECvYjFU6sO1rj+O1SV3xFM6e
	1Bys2/23tjspClMyfhacJrIJm0PNt2U00s7NptleSim9ob8rmxRbF1btxqWH7Wu794j/MZePFRR
	PO6lJIoJuxt8bnYTnYMuNcjrEK8NDPwaIZrXddSBkqnITLMIdBWW0YTarao/xiEt4UQ1NCvnbcZ
	E=
X-Gm-Gg: ASbGncvgCbLS9GOevnToTEl0zd2qlGnNB52Y+3pGqhCdwA8EQbICShWDTw87N/6khz0
	icfAwNQwjywzUbFqS3k4xLZlYPL7RXTObUP+xvx+EJwO22aAjHTrLqV3ExKQh0mTDg1GNoDU4M/
	dfz2I1EVVr3CuDxQm97VNOLiZU3HdemlBsHIN09XqKBeUlj25zsZXCF7ZCfpL4evp+SNcHbxYwE
	rxB3BY7dFYEKtXV0ytSrLW/nm4gA2O9foDIOVeuB0PbiKoTrGrwBKhYV+h1SQM5MYuTNCUJkQrP
	+f/2VYFEtyvpK2AK4TgRpu+9bi3f5qn5cA3nPc0B7C4XCPBKHyMumSRDw5XUSblYrQdX9IuF0zW
	4YtjmQVFPdsQmcCE7Zxe6
X-Received: by 2002:a05:620a:890c:b0:7e1:5c99:28ff with SMTP id af79cd13be357-7e15c993e83mr330822585a.5.1752489506578;
        Mon, 14 Jul 2025 03:38:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdHimNvkqNJF3cWwL5W/XfGk57FmjaL47RCsELpgNXpxCvIvqKwTIbW2FY0d+dH8dVZxn3QA==
X-Received: by 2002:a05:620a:890c:b0:7e1:5c99:28ff with SMTP id af79cd13be357-7e15c993e83mr330819885a.5.1752489506030;
        Mon, 14 Jul 2025 03:38:26 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9542fe5sm5779560a12.35.2025.07.14.03.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 03:38:25 -0700 (PDT)
Message-ID: <75cab14e-e57d-4d1f-aaf2-ca75dd37154f@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 12:38:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] PCI: qcom: Add support for ECAM feature
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com
References: <20250712-ecam_v4-v6-0-d820f912e354@qti.qualcomm.com>
 <20250712-ecam_v4-v6-5-d820f912e354@qti.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250712-ecam_v4-v6-5-d820f912e354@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EbLIQOmC c=1 sm=1 tr=0 ts=6874de24 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=obKXXINtG9EwW41erPwA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 72fsDLMs0BsHLYXJ7wnhj1ufiNR4ko64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA2MSBTYWx0ZWRfX9ugOztYCyu5e
 3fEDY0ZaRCzfVu7AYfVekx+eJMT3GKv2CPrysDacLg0ssg9A1SUj8LZDVZkS4hVTfGVCwNlGJKV
 VlSnbSZ8AD/VECXaIV5nCHkVqQI68fIcUOAtR9Ay6b9cpIN+YkJnRyJKpcWF7syFM6xLLT0aku0
 e5qJr4Wkvonkpyuktrf3S3HxtJxlLyDb0E6obN8o6kGTj8tbXsGVI9nMJGCDJ/390cI30eH7HCB
 sSpp93Ur7r1nXXAVVmbeEEtIi9t05KzHlmjkHOPHIPxr2nt9Rs05SQILGac4d3sMFJsFgvmyeOC
 T8SmNO324Ji6pgTA7fkb6U9daSzyx2Xvy1K8G1if/vmHpkSydqOWfBnVhC+gLB8sT/eGtBjR9VB
 kkb6OUPmy7YPW5vMUGqskbMwcWPeYsnnCaMb0TiU2QBERDxvOllnTFSFwuyLurDVvblNApyp
X-Proofpoint-ORIG-GUID: 72fsDLMs0BsHLYXJ7wnhj1ufiNR4ko64
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 adultscore=0 phishscore=0 mlxlogscore=711 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140061

On 7/12/25 1:42 AM, Krishna Chaitanya Chundru wrote:
> The ELBI registers falls after the DBI space, PARF_SLV_DBI_ELBI register
> gives us the offset from which ELBI starts. So override ELBI with the
> offset from PARF_SLV_DBI_ELBI and cfg win to map these regions.
> 
> On root bus, we have only the root port. Any access other than that
> should not go out of the link and should return all F's. Since the iATU
> is configured for the buses which starts after root bus, block the
> transactions starting from function 1 of the root bus to the end of
> the root bus (i.e from dbi_base + 4kb to dbi_base + 1MB) from going
> outside the link through ECAM blocker through PARF registers.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

[...]

> +	if (pp->ecam_mode) {
> +		/*
> +		 * Override ELBI in ecam mode, as in ecam mode
> +		 * ELBI moves along with the dbi config space.
> +		 */
> +		offset = readl(pcie->parf + PARF_SLV_DBI_ELBI);

I see that the offset is supposed to take up 12 lower bits with the
remaining ones being reserved. Out of abundance of caution, please
add a #define SLV_DBI_ELBI_ADDR_BASE GENMASK(11, 0) and FIELD_GET it

no concerns apart from that, I think

Konrad

