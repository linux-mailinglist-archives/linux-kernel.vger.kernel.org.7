Return-Path: <linux-kernel+bounces-802619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F540B454B6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6E51C87199
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C432D6E74;
	Fri,  5 Sep 2025 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m1cHIaZf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D5628E571
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757068072; cv=none; b=PogD/dhUTLAo6hdcD3sPZnA4M7H+ig4ve/oU7hurhvkfNjmNo9ipbOJ5VdBM/N5bjax8tYgtSGVLXtTWKbEup86V/qTRhNRccLEsy46JSG2ZpXqayCJhqNQJ4xy9xa8+94Lh8jNu8Ymx0Lgc4Sy9GrZgWIYLgyEOkmg6ClDAlXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757068072; c=relaxed/simple;
	bh=yUiO9OtTouNSxonVQA/ls4QKap5u9MAqS9M8Mby/+FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxXN8lxomD9QrNfz2VFZVLB8uGsZGHiynVeietXYAOQsyH9aWN05YakUEyk5BiAE7kGc2jKepB57ZyNpVmo3B7slKdgb8QOocIRPgkZI4xoDDeT2LWlSQcoIEOFzYiCE8an06WUX1vn93npbOggKlbAgRHGCgjqqVhwr8lhzzPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m1cHIaZf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5856lDeA003715
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 10:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bgImxnHNSMCS8SmNrQpt5YOQEEQ9nP5jX6sY4IjHL5o=; b=m1cHIaZfwvaH6fiS
	xR+PRke5kGQyucHUvFQa5UaLTKZ0i5ZC/6LLysETc+2cCSI730BRxRMERJq99z/Y
	R/bNGdQLAqHHqFR2a1G/jQ6fD4xDhU+kA2frrFJsJw5ajrgpsdlBeQTLkcxltpUe
	em62YSCdUAwazM5DjW9u/NJrEn9M5dQK5G4rdbua0rwKY3eQjhvHi0yqrwmfI1oA
	Ow5o+Unm3YyBa/AIU0m6Q8LHbSA7pQN0F8ivc/9vrj01pFryHQWvslqLy+SW+v7/
	HvJyBFzrphKMqa+T7uEC2iPYIYYRlg2cHGmVhC+uwch4rC5243tVLp7IxXjtgZgn
	Z2svZA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8saw8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:27:50 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b3ca5e94d3so4306901cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 03:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757068069; x=1757672869;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bgImxnHNSMCS8SmNrQpt5YOQEEQ9nP5jX6sY4IjHL5o=;
        b=w1d3DSuxbNbWYmvggy7LwVE5zmES7zu3vv2s1BYFDhzCUwJVEgPdmDP1UwtJIpzV7y
         yggVNuQiTQD7eGkskAWkLEzmBauwbuC4PRC8OQFTidjhaiXmv9rUiQ8yuRBP6tAU3S+f
         k/GFSnKr2omu3o8l0yBjR+dlPjDfeMYNq925RaDFlVVum/YZp1MIosylyu8KeDGuewK5
         XbPnU629IWyohb6bU2Pwv07foh3AoMz8oR+hGaJKPD+nX2JvJTYvaO9Yv2w9IhA0zHth
         3QkO52ezzq+GIu5CSEliS6Aa9J5tu1on40tFh0AVIhpWKuTIZT53to/01aYGlfkHdStb
         kvbg==
X-Forwarded-Encrypted: i=1; AJvYcCWFAdt/EhmhYtgk7T89lOhz473tYggs/EdV6xGG7KvSvsXtJz69WcSEiYDw3FduzDxEBZ52oFmZO4xpg20=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL3zRjOU3GVeacsjXgBJicUyKF+Uv7ptLRNWCWXgZBWK3qiY9/
	u1hjVPJgD+QR+4K/298ZklKUoRrirEkjjicKc0NXuLFODjFVF9znqAn7ffH0ce3HxdFbNp9zjJA
	J1dKWqhiMypuDzRJSFlY43mETpnxCYUEmABTi8kfRtQL7UOX+ZsnYvqwbYLWBycgpCYQ=
X-Gm-Gg: ASbGncsvVeiM+8J6hG8s9pIyZudzrSUlWfJA1pNM+eoPq5ZugZZtLRftC8RcWNj9iYC
	3doycPCTPYWNZiuoNDSzPZGowUWtb4vqDi/oywQyagTXDf2kHCSdpOHrQKXzFBwzD/yzBUYzwRa
	PmOnPqoAtK3QqyQ3Du3wJqQ9Fz4pFWCyGVgvQAv/zgS6tKvHFJKJXHljfohnuIXNonQ6n9PNEXj
	ZQSh8p6pzVPf/xqlgtQzY10L2CxUfn8781JnxYizwn5l4k80BKmfxSIt+2QcEFBCGdxEaClskqw
	Wd5KohAuE/Is/Wx35C0d+VQwkhos5gDTlxNCYqZJnk3YCwj4yGh2goa13CmwfSmtAhpkZvDsQXZ
	7cJxIKzEUEBtsMSra9LsItA==
X-Received: by 2002:a05:622a:308:b0:4b5:e4dc:1ee5 with SMTP id d75a77b69052e-4b5e4dc2165mr33624971cf.3.1757068068634;
        Fri, 05 Sep 2025 03:27:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7l66365MH+uv6p54/CjlP9TnYyiug2nO3aof3IGh+gEKom8YbhxPLhpaZ+ioowQDvGJzU5A==
X-Received: by 2002:a05:622a:308:b0:4b5:e4dc:1ee5 with SMTP id d75a77b69052e-4b5e4dc2165mr33624681cf.3.1757068068077;
        Fri, 05 Sep 2025 03:27:48 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0466a962c4sm669301366b.71.2025.09.05.03.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 03:27:47 -0700 (PDT)
Message-ID: <4ee738e1-8441-45f5-a026-fe60d4d2bb49@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 12:27:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: x1e80100-t14s: add EC
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Neil Armstrong <neil.armstrong@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250905-thinkpad-t14s-ec-v2-0-7da5d70aa423@collabora.com>
 <20250905-thinkpad-t14s-ec-v2-3-7da5d70aa423@collabora.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250905-thinkpad-t14s-ec-v2-3-7da5d70aa423@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX7JPZKod/UIMl
 wYZQDPjKYU/VCIf96g8dZOSrY+1d0RJJtQMsPgM7GwTh792zO8BdOBPppELs6bXMu1HMeRUzQC/
 oDWmtrkEXDsz1MMqn5IL8hhhqoxR0yBxkI3t+sypzB8Kn7/syajOkXsAoUW6wMNe4m8WNIP92tQ
 kjqvFT40gyOcjCJs7wnc0mjYkWybPxa5yYfd6Gbb2o2lZVWEYiAl9EnSYVnVC8Stv81UOqep/ba
 5h7QUV1QXYrYEismLlMvRu/l8pZMpCl2MdTfkt5YMFR4mURz5KrjCSHS+IVlSNRGfAGDdMEo9hF
 HbpO0Xq/HDnB0Sx21qRTOo/T1h3q54kPqRhPKOPI944dnKZfJVRIPyClStJsgkgj3Kqgeg52ff8
 94KLq6tm
X-Proofpoint-GUID: 0P9JzOSlx2VPl2x47QYoxO6aZBa_titg
X-Proofpoint-ORIG-GUID: 0P9JzOSlx2VPl2x47QYoxO6aZBa_titg
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68babb26 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=c_sDwiGIsPVnuUXXd_QA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On 9/5/25 3:09 AM, Sebastian Reichel wrote:
> Describe ThinkPad Embedded Controller in the T14s device tree,
> which adds LED and special key support.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S OLED
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

