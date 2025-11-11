Return-Path: <linux-kernel+bounces-895153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 256B1C4D0A2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E6118845ED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317AE34C81F;
	Tue, 11 Nov 2025 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kfu1Ayng";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I5QOmd02"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A340B346779
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857071; cv=none; b=SwHdLYdOggfoKpDgJvCyqkLEOrsjFVMtEFNzKBe4SufHnpxybNz+RFh6G6RNdoSYEIAWlYquaShsHwRoRBABkz5SNZYMJDhnNgwLYYf9+2mXOCjdLx+ydks5w8jT/K6flvd/x5HB1paQXlNqwWd1W39a86mjTMBlSfy3SqvtAUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857071; c=relaxed/simple;
	bh=D/ks/HjJ2UmBeeXdNzT0qyT2BCDFWFNaVq/rqrdOsjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RVWDba9GTQc5++bLtlTJouhPWil/01BR/S4Rd97n59X6qcuzNJ2GkR7JjuDRYCAoS0AnVrsm+3xr2r4lfZqMBK++8VN3OWOvKUS9brJum6pFCs+nx/Uy1FC+KZqjUat+VCng7654QDKH6vFkDmJGjdxLAEbzMDtj6CedbhrBhwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kfu1Ayng; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I5QOmd02; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AB4DF4O4073468
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HeIjk8zjDMvtq1Ei8/4B5m73Be/4tVAGo5hOoCO2INs=; b=kfu1AyngoTeYb9uT
	NJJ5mnNQ0m4jzxYcr2AcPYnq2RI2FyLVWi5uouZF48QzWX/XUZcpyozU2wYi5Lxk
	5qJQejfo5ntH1OkvSAvCSUTiwlwEpImmgnTY7/eaqEWeDy8m64H+W26OLLla9w+7
	x7HBGlQzgJqwhwI0ZOMnKznAiVZsrBNRiCeHINeZgrDOh2qIE8LXGw8GPeJZiuL9
	NJMwEojZ4GYZ0/0ZpcB3FUHkGlm+7w//Av7xL3k77Hd9i/enrlRBudxj+3tROWSh
	fB16r8+wf69n7cS9t5FfLsT0+XIPKh32/CqF/yN2HcaO8GUG+RWnlfqyf0L7wJbn
	//Z5Fw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abkwsan34-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:31:07 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b99763210e5so3691370a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762857066; x=1763461866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HeIjk8zjDMvtq1Ei8/4B5m73Be/4tVAGo5hOoCO2INs=;
        b=I5QOmd02ExPcOE3AWp9FptYCMvn7KB6WzSMDHLMaFkbND5J0b1VbaiZbMSVE/7rTkP
         FkWN4FzJ2t+lo3VIvyU5H7E5hDV0ZIe5FV3scWoLIWFtsIPnkENdtp5xrLYIDRhPyqny
         9gTLmDi08KsN1jP5ucryTZDU+EhnAyK4hmKjkhUtHDPi0rid21RrwpHeOq3LHg4EI0kd
         OJ08aRl5f1HS+HAcN/Odab4RT3fmyDFdhm2cBv7RpRidcwCCYnm+ukYYZWwh8T3AUXP2
         gEZ+rktTCbwtCqC7Bk+RMuW9CX4AJsf4zG5wNKO9tjzsV5IuhZibMyu/Hc+U+pKnrC0I
         RmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762857066; x=1763461866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HeIjk8zjDMvtq1Ei8/4B5m73Be/4tVAGo5hOoCO2INs=;
        b=JnMn9H1AlZTHz0YIJ2uwkX6i7BJ+NSiV7EhZnfTVCD23GNsJtH0QLAunYHiOVknJ1z
         UO3ovb/aLPmE3WMVhWbNdRKqfij72MxbC76WTZfdEK7d75K0yWKtlGLxszpL21gr+dSc
         9etOi7w2e/YeE/FHL6JXlXzFBWsOFTMJFvuB6EWxPkIqbRuy38T7eYQEE3xqC7E+LZVi
         cFcWzL71r4+AyINEPr8iaI7XtFhmf8nkACiMFDOtIGjWKFmTXC9rgL9GA0K0QigI6SCj
         WNkfVPk+A2hxElnXT7YHVZwj6kRyfaSXiVSjG5a35iVat5WCO9KzQtoBzf1L+2eU4OAS
         DGuA==
X-Forwarded-Encrypted: i=1; AJvYcCWFNkotBH0dPWch1w+L5XY4EOe18ZxvBnvT8RqlDYvYPYHybvRfFHVhYt4+gWZT3aToRcifKDg3BrzJOGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOx61w3HkIn7zuAAT9hOvqIBtH/cenYCJmKLmoR5TiobiRcEPg
	lyfXk4PaEnBbGrRVRqvBTD5jwxiG5202z3QWVPWFm7skeE5kRHGyF2W4YoRFVokXMw9j56XTi0m
	MtvNXBo2DR5Bd6gEROrBAnWQejb4H/dICSXVSk3cqEM5B73/Il1b+M2ncvq+31LgBU2A=
X-Gm-Gg: ASbGnctbCNzPNhRtUh8SnuCT2AzCqFSmNM76zGq2vIY2ITzD4XvkKtU3G5bsNGe3+oi
	1ZUaCUWnREqWUG3gMNSdGfsM5+xoc3SDyXeLC1UA1up8uOP4a2SLxPlOQAgcGZK/ZQHuZie7GJG
	l9WcEbgiEusrwTTiUrf4SfmZnu76zXqKkkF4A9Ak+T6ji27IpQjBCcmCdsb3eYZ71YvndtyWA4X
	4X8ITFTBfU0bhgS0+o6elSugO6k6c+byyD2jJKgZzdgMlBpn1DxXPH4Q/waWXQLvyoqkHEyYpog
	K8apJAmQGxlfnrQMc1doJm5c5hDywhTborE9Dh+Bi+TEw5cMn4s2OZvqYZJjvDjdGhB2q3K3WH/
	CWD0AX97PtZfhTl46rSzNldWSpbmJ
X-Received: by 2002:a17:903:40cf:b0:294:cc1d:e2b6 with SMTP id d9443c01a7336-297e56f995fmr165404205ad.59.1762857066526;
        Tue, 11 Nov 2025 02:31:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEewwTQbqnUSdI6gBxX6IS/CzZ1xkFA7zvK6fqr4+b+3SthTOX4KV5cdskV3QmORTNpTCngvQ==
X-Received: by 2002:a17:903:40cf:b0:294:cc1d:e2b6 with SMTP id d9443c01a7336-297e56f995fmr165403695ad.59.1762857065992;
        Tue, 11 Nov 2025 02:31:05 -0800 (PST)
Received: from [10.218.50.9] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5e5bdsm175441995ad.39.2025.11.11.02.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 02:31:05 -0800 (PST)
Message-ID: <e8cbc5e1-4159-4d22-b7d7-5b9b6887dae1@oss.qualcomm.com>
Date: Tue, 11 Nov 2025 16:00:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] clk: qcom: rpmh: Add support for Kaanapali rpmh
 clocks
To: Taniya Das <taniya.das@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, jingyi.wang@oss.qualcomm.com
Cc: aiqun.yu@oss.qualcomm.com, Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251030-gcc_kaanapali-v2-v2-0-a774a587af6f@oss.qualcomm.com>
 <20251030-gcc_kaanapali-v2-v2-4-a774a587af6f@oss.qualcomm.com>
Content-Language: en-US
From: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
In-Reply-To: <20251030-gcc_kaanapali-v2-v2-4-a774a587af6f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA4MiBTYWx0ZWRfX0G1L37VVUjwh
 yvlzMliS691WU4K/4t0diuGkJbvp2fiNdqb5t63N+7f6z69+0AlSU3vPo4HLolep8dyiBjhteYb
 s3VIkeeOQJQdV79ZnKQW8IP8jdwjDA/CCyp9pRmOIPjnydSr5yGKb/SMgt6QorCCNOkWK7emSVx
 5MPyOIicxq2ZmoXbaWUQLV2sABMnNOsjgTik5B8OVVYFOQE6Qlc5OBxcE+v3lkotkEbBvZFjYBf
 nRQHZFrx9LjEDxYhvxofpG6yyboz8MdXN9Gh3Fn94u5GVtWst7kQ8+9kOZeQkCnokHWo/Wssq1o
 +/fA4qYr3mEB7pnOqByeenZ4doJraGihAQMIZre5C9MhWxyrOzPvSfkgl2EW7MHw5qo5o7LNQZo
 zx481ibOTifh+CO7xl/3+cpJ6B/kpg==
X-Authority-Analysis: v=2.4 cv=Vosuwu2n c=1 sm=1 tr=0 ts=6913106b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=qUnW8hDDCxEGPathPCkA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: csspHucUg4Yha3snElPVmSGGMfKotP-d
X-Proofpoint-ORIG-GUID: csspHucUg4Yha3snElPVmSGGMfKotP-d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511110082



On 10/30/2025 4:39 PM, Taniya Das wrote:
> Add the RPMH clocks present in Kaanapali SoC.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clk-rpmh.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 

Reviewed-by: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>

Thanks,
Jagadeesh

