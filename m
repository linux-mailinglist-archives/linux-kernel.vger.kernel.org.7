Return-Path: <linux-kernel+bounces-818550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A03B5933A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2563B98D0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A160A298CA5;
	Tue, 16 Sep 2025 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CIKH2PUe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBBB29E114
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758017875; cv=none; b=qpTRH6Ae+EAg8LBteSSLn9j2rZeAuP3WBW5ZfBu1ezLa0AI9QGuAJg5COUbCgPJ1Z6EoznagVCqfEzAejMdLYgvPgg7fqrgmWnKbfZhOTXwCn8DD4dh1ZePU+GQacCbR88WKi7U2fwZpFKLnz7gjBkTVMuxddsYTvO/ry4v7y3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758017875; c=relaxed/simple;
	bh=/cvaAE2HoDQnjzYGy471yA14D/oJLdLlepOzXO6YJTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBrOq2eYYmcCSgjP1F7YZxPFtHIMsSrNm4W1+IYi0CXz2//PbDzaAEXWhcO1plDn8SazSJjvNeY1aoN/iZ6ERWVEPhdKnXgAFIw/rImUSEigG51R+/InBGCBsGMZPlOnmNECbTVDPj/YnguL1NO6W/WG156l974NIjgBF2q0kvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CIKH2PUe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9sFW2014169
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2Er1pNum/WmhMsDVwFK5vpTl
	0bY+Xaqs3dc/o+OSOUw=; b=CIKH2PUeyqmm4yHUnP0Kod6NjJwBKmeJCzMVunQ9
	ukcYme1sv6tyUgnK0nE0u0OMV5O2J2JJSVJ70Bz9KNKmYT54hQlIfnN1g7coe+Ph
	bOzmveFKp6mqhPqPZttgo9XLwoKAfcYIrXdkbhKWvUWSjuajFCTNhva2CJZ6J0m5
	3jHsG0/vf88kLi9wbCBrOAGn440ViPnLuhrxA+KH03faI7jE35Fgry5emKhxfm+8
	VzwIgVD9HVXqMZM8rhtSGoBsMjEFgN3KHxaP+NLvxkjvaHjINiKeR7daN60R5MmX
	pnEGAZli1y4uEdV8OduZHz7QulKGFv7KZPxs+xwzTBT9cQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496x5asm5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:17:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b7ad72bc9dso32772501cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758017872; x=1758622672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Er1pNum/WmhMsDVwFK5vpTl0bY+Xaqs3dc/o+OSOUw=;
        b=gfV5gfGowtUzHORNNm/OhFsk7x9bqgUYowBKJYBsL7x53fKYMF8pNUTgcA/fvB/o20
         QDFD482VkmnIwoFTYwXpzeSfrmQ/ey+/PecUgtIQANWf2nCMuVdGjWqOuU/KYFSjOuyZ
         5MyuEoHXCcKqvM+Q8QzvqvZjquSOJPNH/G59L0r27YXfaIj96p+F/IVTlawWJWXq2gOk
         MuXWwfOoIfezaInaroPb0GHqgcp1S76gBigL88l494KibmX9mhlS1MbeJK0wMBD1Uk3m
         jMVJnUKwSZGGVdFVpyACv6OhX7TMAAf5Nl/1HvyHsUjdcwCZ1YnpEKp6Xnb5cU0uPN/Y
         6ChA==
X-Forwarded-Encrypted: i=1; AJvYcCUZZE/Z03AVLn1wxOPB4B58g/PD5pv8KNaPyNafrC+dB6gmyB0MVVq/wjfFxlto1B3cOUECSapA5C2hLzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIwzqRU9IhAgJ62sArz3Z3YDWWYDUzPfqbDxTKOHHCeXKX8RqY
	U6ZsnmuksNfXz7MqXfBxt9/1DXGzVvRSI9TUpHP9Nmf/dsg0VkcVPYk/E9z3EzQRGRxL1+HisU4
	+PCg9MIT4MBRRbPVX4xbz/pDxNfPlfld/8Mg0vPPuW++kxCKmMSav17S4plsuUgphQ54=
X-Gm-Gg: ASbGncs52P/1lXI4eHqgUfPmyN2l6x39Z3TM/Bp4J0TMrn90ytj6AeHWnUFe6DmoiuV
	tPjGfdQUUmxstksKJUBOWQ/HM3m6xfwL/vO/AVB1CUOV0x6K8UdBfQ2XVmf9yy5qDqhVWwnWUfL
	agFJ+UnPw5MhEuZzg0KCh0bbrzpNwIrlstdvj2JuOltmd0PGLao547tTswUUHmSfwnSWsBsDrNW
	uOX94P4xWqNbuPeNm7kpWHxVujaMpfjtus2wM4ePeTQhGcsNOGJ3Deyo82/G0MoVYcF9RhBkJOB
	KQkhx74r4qFaWwlbdPDX+nbVdih5zIVqAri4kV6/fJ0dcAkta/eAswABug58LswuoVXg89J9LXH
	J9AwGVXDgwgIwQYqkY7tjibF/7i6pT6tIjOgOg9oLqt6DIBkG2F+D
X-Received: by 2002:a05:622a:1f16:b0:4b1:247f:4e0f with SMTP id d75a77b69052e-4b77d0e8accmr201211381cf.57.1758017872325;
        Tue, 16 Sep 2025 03:17:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG3/RyuWQfRZW1mY1j1shvOvp1blH44FZkzAOAV9d+81uzHG2LCJYhHB+EHzub9I/8NxYxnA==
X-Received: by 2002:a05:622a:1f16:b0:4b1:247f:4e0f with SMTP id d75a77b69052e-4b77d0e8accmr201210971cf.57.1758017871659;
        Tue, 16 Sep 2025 03:17:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5d5e70c8sm4310701e87.52.2025.09.16.03.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:17:50 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:17:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: rpmh-regulator: Update pmic-id property
 info
Message-ID: <le4fsudu7fh6q5sstz5zndizfssgiycswzhmzuoioccxvth5mo@weyftlxiohlz>
References: <20250916-glymur-rpmh-regulator-driver-v1-0-bb9b00e93a61@oss.qualcomm.com>
 <20250916-glymur-rpmh-regulator-driver-v1-2-bb9b00e93a61@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-glymur-rpmh-regulator-driver-v1-2-bb9b00e93a61@oss.qualcomm.com>
X-Proofpoint-GUID: ShCEn1s3lCI6_wvkalDxFpSv_hH_akvr
X-Proofpoint-ORIG-GUID: ShCEn1s3lCI6_wvkalDxFpSv_hH_akvr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDAxMCBTYWx0ZWRfX/iC3Jz3aGk1g
 V4tS12CAOX2eKmGC92+jUgwv/cefbdjKzhX369X7HIqzxfY8Ire7nO5buri1li0GynoHikhNSP5
 tSr4ZpsLsvRVcXDQ/IyXMGXEQ84kc0k02TasMjQqRaOoUXIzqIFP/2k1eAnQ+pDU4I1pgaC5Fd8
 rU6CTeZ1sA5MvjEtKK0JW0jldP3Zdq0a3qpofXamUVTtp0aeHkmyChQ2pyJTjPsGxcTvnpKkRrK
 c7c11rU1E2qL0KykFnqez1T6cSTM211H/pdbMhF985+5KuzfSuL7inb5rNTbcT0K/yecsxMVUk8
 fK7nIbhJfNopK2oCrGBaTJY5Jm5+JmWhe2SaX6aEmOpMjuU1hzJ7+YtkAPm6rO/QUFJhPEgqmZ2
 HnwCg3GO
X-Authority-Analysis: v=2.4 cv=WpQrMcfv c=1 sm=1 tr=0 ts=68c93951 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=8Yl64O_mmtZwUmTP7D0A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160010

On Tue, Sep 16, 2025 at 01:28:16PM +0530, Kamal Wadhwa wrote:
> On new targets like Glymur, `pmic-id` will have this new
> format `[A-N]_E[0-3]`.

This is a statement regarding the patch. Please desribe why you have to
perform the change.

> Update the property description to
> reflect this information.
> 
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
> index 40e57b10ebbebeff130871b6d978df64111b6f29..40ddc64577e78b5c0dbb7b4e8893a08e8b37c92e 100644
> --- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
> @@ -108,7 +108,7 @@ properties:
>          RPMh resource name suffix used for the regulators found
>          on this PMIC.
>      $ref: /schemas/types.yaml#/definitions/string
> -    enum: [a, b, c, d, e, f, g, h, i, j, k, l, m, n]
> +    pattern: "^[a-n]|[A-N]_E[0-3]+$"
>  
>    qcom,always-wait-for-ack:
>      description: |
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

