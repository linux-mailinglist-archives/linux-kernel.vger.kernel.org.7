Return-Path: <linux-kernel+bounces-820886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB18BB7F904
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA27485E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07D532E73C;
	Wed, 17 Sep 2025 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XH8q3UQG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1D41FC8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116565; cv=none; b=EZbAjjBFHwukPXgWXXOO7u+Jbra50y1tRRDxM7N2e8VLIP7snX8qKJwcoyD2/ke+iwHB5lD5Q10JUL2nG3LZW8RK1MNOQrGUEcZiTug0s3mYq8uXTz/4rPiRH32QW48C1J6WRjAEWs3oervZVUH1zCUPxDgSO+sSgO8V5eBdxqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116565; c=relaxed/simple;
	bh=P+9qcWp7nB0G0Mpnq9jRPgAMimjFqsKqmE3zBJHHxVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJWi3CvgfjHZJSIrd6X9Qr3qgL0MGJjP9ljzsscYbSdrFoUDlHe3LNxrpzw5EtgCD0+TvmA5YD+8SysPJ1LZUdU2xwh6R7+yxgJoT2/nXuzBfFjtqqGx26triGJkb75pamYYcxLxQ9CUHGktqNn7tINHbZ9rw8hDc5nE8EJgYRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XH8q3UQG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HD1MA1012210
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7Cx+H6Um1G2JkJ5lXuXrB3HDUnwL0tqqkEuYb++6Iqc=; b=XH8q3UQGN4npAmut
	Iry8oafb4OgpvTI/IgVcqFheSyrG1AIuEg7/bO3mRz8Lo2sqz/gYNodPwtSG7VHO
	eboGISUmrC6mWfGj5IHR/LCpvh8g/iI03vxlt94ee1xdTh9SSYXV+IgBeRAUicDw
	Telxd2JP3heNxSf35v3Lo5w0sOICXpE6q7PgvF7/z/A+C4ld5RrKovlFvOxhaJ5E
	60z/ojoG5HhlkLncfjaGws6My47vKeUsdj/Fga8zKjLojMSWCYxcYhBiRnMt/pNK
	nNrjbD1NU0yeLstflcr94xeLLpjF9JbLcA79XRTVVrIPFwLM+j3o4O2CJJcWXxN/
	+Zw/Gg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxyjhyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:42:42 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b79d4154c9so14433251cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116561; x=1758721361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Cx+H6Um1G2JkJ5lXuXrB3HDUnwL0tqqkEuYb++6Iqc=;
        b=jF+nlxIaJQN+Dkcrjat5UDKlxIbbdaHztg/0cKBjE/Y8WYKRBq+7C5JtFB6qWy72JU
         SzWbm3TPaAerFE6ipMGPiN1AAvoBbZrWgmgGz8fv2ZQ9s2uBwJpaRA0xQ2/O15fl1r+Q
         IkNF9RbRzZrv+oRAjfhw576+0O53TPofbKIeEZRezVkVXEJ4rQJBAS2z/0ndPcQtLrxn
         xIX3yEKwOJNG/YzLQcJ0eTQFoJLok+/UCOemg+EgbhYKwnwUWYXuRHaUnezKfSuKHHkd
         zMw3ZWTac9Pow/93Nvn1s+NEZurnTUMViE52KgK/3wtvfi7pReZXLFqaRx48yXLUYleP
         qVIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpq9HKXIGLOx73p+YuxhEjuydYkzhYhVgDfuqkl7Yn62Q3V7/DS1XhHgJ4WQSUT32zNY9/vB8yfTlg1Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQwVhZaob6B121UqZVvwFBR24ykiUuwctBrwifn5/GV0wCJWp1
	jvg59981RKK583PDHE/yml27OqW04hTmvNJkWuEz3zK8Z+XB6huiYO8PTsg8mrQsv9nnD8h4vRC
	6OZzNB3DvyhI3xLziHUu0I3dz4N56NP502cmy5/w96Gnju/YLhVJJ1qjDALHoL2LPzSk=
X-Gm-Gg: ASbGncuwUKhQvrqxY6WDKBhtKcTQlFT87Nw0hY6KCf6xOoLvv+ffNoKT94bCtLlSAgW
	Lsj8wrLi72kErQ4MZvtgkT5vPxF8r5thnl9Rn/FMZn0t51yKxjYcSQYzd5SWktQPTtCy7D6R6Ld
	yttkaEhOnFkn/60qqRBZwOcGCVkkgsm1byBIhY8Pnn5dg4/IP9ppjWN4Qbjzph23KvEaD2tzn8g
	bUx+WM01mTw367M0nv0jfVSrRBl2arNefjEeGP05+bqpxTcmw3eXMlm9EwRFsrcu9VFTc3C7Uxg
	EMqTmgPtqYRd1/HMRcPVlk1lzfBDvdYA2Ay7G+2eWp9Tj2xPBT96uoLo5UPF38UbKSXoJk2ZHzc
	3d4W/eMOhkS/kGqgy6T79Bw==
X-Received: by 2002:ac8:7dcf:0:b0:4b3:d90:7b6f with SMTP id d75a77b69052e-4ba67f67aa6mr13897811cf.6.1758116561182;
        Wed, 17 Sep 2025 06:42:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6it76BiV965uXbpKVk7JtT8JZF7WpBlguxShW0UZUk8ZurX542X6H7QXGdtmz2SFxYB8vLg==
X-Received: by 2002:ac8:7dcf:0:b0:4b3:d90:7b6f with SMTP id d75a77b69052e-4ba67f67aa6mr13897431cf.6.1758116560435;
        Wed, 17 Sep 2025 06:42:40 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd408sm1364974666b.59.2025.09.17.06.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:42:39 -0700 (PDT)
Message-ID: <7380300d-9642-43fc-96c7-a2a42bef5bf4@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 15:42:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] arm64: dts: qcom: sdm845-lg-common: Add leds
To: Paul Sajna <sajattack@postmarketos.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
References: <20250916-judyln-dts-v2-0-5e16e60263af@postmarketos.org>
 <20250916-judyln-dts-v2-4-5e16e60263af@postmarketos.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250916-judyln-dts-v2-4-5e16e60263af@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=e50GSbp/ c=1 sm=1 tr=0 ts=68cabad2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=sfOm8-O8AAAA:8 a=Aa-MDpYJ7-4v3bfwBlMA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-GUID: jN3D-z26GiaVjJpFZ4YhHBAqf2C_ZLni
X-Proofpoint-ORIG-GUID: jN3D-z26GiaVjJpFZ4YhHBAqf2C_ZLni
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXwEgk0fDnow3I
 dHBlhnsyBBT2zuPjJPQqgmwL7TVBol19yHay2k3KyUcTrUwp7BYWzqLob+MllN+3BM7toctnm++
 5HndcOwheQv4MWNjz66N9XaOUOzQf3oxmdXiEdMH+13/ZZymjNWb5XdAQCEeOys+2MPooxXrXCt
 AIjBI5aIDr5Qcj/JzpPJ7gEAUtK4jDksrPZyHIy/wRbSvE0Ciln9zkPtz7vG96it3CvGZW7Hm8N
 4Dcghv8NKxxPQvDQvjp5r7kzbbScF0xSVeMVp2Gl6J6fJ+W8HtmBBEDUyvqysF0yXmuBgc4exCa
 kBdUlhgI7i0jTpgm5zTYjR2x+fKf/01ZDHyM56esWaFOztoyFrHQ/Vgz1w+iv/0ohmxe8zTRW3d
 HmLlNRS5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

On 9/17/25 3:09 AM, Paul Sajna wrote:
> From: Amir Dahan <system64fumo@protonmail.com>
> 
> Add the multicolor status led in the phone's notch
> 
> Signed-off-by: Amir Dahan <system64fumo@protonmail.com>

Sending someone else's changes is fine, but Linux submission guidelines
require that you add your own sign-off at the end of the existing tag
chain (i.e. git commit --amend -s) to certify under your name that you
believe a patch doesn't e.g. break any licensing

Konrad

