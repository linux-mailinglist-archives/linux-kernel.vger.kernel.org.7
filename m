Return-Path: <linux-kernel+bounces-841962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FDBBB8A17
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 08:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C55774E3093
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 06:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD0A188734;
	Sat,  4 Oct 2025 06:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nEJ/mhuL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0032512B94
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 06:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759560364; cv=none; b=XuM+pL51kUsAFKUSXoEzJQF3Qro0xlZRay6bRDophOJWfZIKhkD9gYmv1IJYogVjVxsRI6IW/r3xjPvJyOk17PLEwue+vLMD4PEhZvvsM2D0RlXyLKPntMKGdf+WmFQeHb29f5a2rDOrx8XkcecS6QFpb3U3HsnI1EE8pahwA7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759560364; c=relaxed/simple;
	bh=Tr6GBYqy+IzLd8uqM33CAtRY3paCCFvnoi/vQfjzRKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYrVEn4JlZoUfs76xltv4pDUCC3dPutdI1h2RN4k5pTOFyA83FlAGe1LIVguqk6NY6AfDGIK83bfwc3WAJYQP1eL908T3sEQtjB17V2L5BqczVV2RGKlqAuv7nn31Gif8AsowiDMun7HHy1luGw32H8mQFEn0kvRASwPsSgQgNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nEJ/mhuL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5942phV0003905
	for <linux-kernel@vger.kernel.org>; Sat, 4 Oct 2025 06:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=T/5jf8viW1Ms0TYa2j+4TJfG
	uZOdpLLk19JW7AHS0TE=; b=nEJ/mhuLLXgISTtPjE5OngC5ziHVqscmEFKPBtJ6
	EeQKlhY88+L+pxPR/XFVAQRSQRG4ZVPTfpuRrzEtbZ2FMXaTlycOjthLDUUISWC8
	S1dmkdKp6cvzX+Oamu8eChprnIG+Wr3lJQry7WTXL1N/gJKba/IzGY3z/Y0/VQbb
	fr8SyagsLV4so9uMM17qtA2GY54fP6Zyppv3YBTGoBbQ6orwUAvc8Ak6dpRlBBfA
	dV1X8yhRqpgVlRpe1ZedCSZXhbGQLvtGkYUx54BPQlsRfjQoY4S37YUuxhS53vFL
	H3DZEy93TbhBJ7hcFrXgcVgJxJplhHSfFiOx+6gI5cU1mw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49ju5x8ab9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 06:46:01 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8635d47553dso535243585a.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 23:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759560361; x=1760165161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/5jf8viW1Ms0TYa2j+4TJfGuZOdpLLk19JW7AHS0TE=;
        b=XDwAj08soASYEXQmPgTXBZuLlaKRh/70n4nQ24bTBYscNC/tPF5EgTdbu3rmEutC4e
         0WXtdDMze+ZhINBiTVG6b+MF6IDtkPmn0mhkTJ7uf1iEanFeU+xaG1NNTJAOEbtKc3x9
         CBUTrrhFtLbqWVGmiUALNwJ7MkETnPsWnn4nEoFt4SDOP/ErXjwhNiNsgy8VOhpUNGqQ
         uGRU89eVP4Pr+dHsrtsA03RUFP9WuxFE5YlwS6xkQW6f+ilEHnbW7KrDFn3r5AGyhcmH
         n8/e/gM62IVBWsM06aVUhJhHR7nWM3paxofu4Iv3ATMo8s7SvoHUskzUJRi6dK1pybDO
         ro7g==
X-Forwarded-Encrypted: i=1; AJvYcCU/wzTAeb/DU71hlLslhd/9raLW/mjutTj0TyKlx4y+mURIr/N/szduDRPbX9+ciEh956h45SEjJ2YyHXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr195o+nG/DYxq8QQHfzLwlvjNfGwa0DT1CAV2JgQvLBbR8Pfq
	H/Lwy2+Fq/dSxqDF/6D0SHCfJl1eOD8RxQe1a+j75kBRwTZLVUBRAxtxGAA9rNHQD0UmggY9tjg
	VtqzXpYTE0DjvQslh9ixDvvwnWQA+KS7ff3ebijkaaCRJ3W5fAtuafj6aMwNEvkFudO8=
X-Gm-Gg: ASbGncvuxCYAUVeAcSN2BV52+yzl5PkDfo0YP7yUGz9PTJSpCJOGsix2V7r0pKbijFY
	dIqXB5vlFspHew/ID04obw5TkTLp3QF3L3ZwiFOE+74Ah2EAe2V5vgkLZ+Uz03zOuTRnnes6R5k
	VT8DGUqtYXUKJjV/ys/QMvJhzgyMaJy/slE9KR+8e3xMLnuisEIn1i50HF9Qh+UBWzeWll4fExl
	curlcipZQBCuD9A+TIzn8ESZGO+9DRZrxCi7DphCt8lIF6eZyicpMwi5u3aSRqZrz7p+hCsqmdP
	sl+6M9ZaCMBLBXJ80FK5TZfeF5NoscHdRbaXVOhUi4rNbCYZ38zCXbdDDU1iGkRqYhkE9FK8OiH
	0KURviK4VmYeikhQzD5LZpL2yJIOAmL5kM6neQ7a5egOf19TjArG0JHAzjA==
X-Received: by 2002:a05:620a:2a0d:b0:83b:5f20:41a6 with SMTP id af79cd13be357-87a33f1f29dmr848489585a.2.1759560361052;
        Fri, 03 Oct 2025 23:46:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUMkJm/6OV7cxicvapSEjp5hlA70/rYB9hv2U/Vt5pJr1Bht3HvfH+Ym3gM8TNKn9utq0DZQ==
X-Received: by 2002:a05:620a:2a0d:b0:83b:5f20:41a6 with SMTP id af79cd13be357-87a33f1f29dmr848487685a.2.1759560360579;
        Fri, 03 Oct 2025 23:46:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-374fc0787a2sm3101491fa.61.2025.10.03.23.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 23:45:58 -0700 (PDT)
Date: Sat, 4 Oct 2025 09:45:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sa8775p: Add reg and clocks for
 QoS configuration
Message-ID: <ezlm452ti4lrrkjkriz4yasbbsma4vw5grsxhg4ggetvku7r42@aqhdjeyc7elb>
References: <20251001073344.6599-1-odelu.kukatla@oss.qualcomm.com>
 <20251001073344.6599-4-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001073344.6599-4-odelu.kukatla@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=FooIPmrq c=1 sm=1 tr=0 ts=68e0c2a9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=M9tGKf1UEhd6l-wMVe4A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: qDBDiavmvoZ4s0ewIYZ9JktuQVY0PWUd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMiBTYWx0ZWRfXyExwwP+b//hO
 1M+oGD7T/6VTjB7tJusNCe0dg8ZW/Z/ctn+577POrpq6MnUnR+OKVySxWbSbRQN+HIOk+TdwQ2j
 VCJ5SdnNOcARelSpI4ov2sBOprWBOmVx0qPj608IdYr9K9Qt58eh9PgByjUOX7tir80H5BmN2WW
 7/msRURAYvXgQHPWIxOPGpGEZufcwEAy8tvqo0WqSNSRM0cldCxz6350wsBwtUrMj/EA1Hy5IFp
 gBQRj+aSr8brKSA24LMYuTzyytcPlrLdG1mTiZd0JG34EBJB4ulgKT4GFk7TE67AKmoTY9GNQ/0
 W/JEwC2+YCfGyW3nc0hiRYmizoM+xFkZNtN0vm7TwouehuhGUOSEvJTlwN5GIFRmUxqc8s4SE8a
 h9qUPpMebWIjDhdkJuwDq30WLtU1JA==
X-Proofpoint-GUID: qDBDiavmvoZ4s0ewIYZ9JktuQVY0PWUd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040022

On Wed, Oct 01, 2025 at 01:03:44PM +0530, Odelu Kukatla wrote:
> Add register addresses and clocks which need to be enabled for
> configuring QoS on sa8775p SoC.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans.dtsi | 163 +++++++++++++++------------
>  1 file changed, 91 insertions(+), 72 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

