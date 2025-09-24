Return-Path: <linux-kernel+bounces-830307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14B1B995E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8871C1629ED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB2B2DA775;
	Wed, 24 Sep 2025 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WBAbfrnd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276482DBF7C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708622; cv=none; b=apQuRKqX2HddRaalYh19n3PN4OdDACJg3JHlWcAi7gWxtwR6idDTcrLezRyCSjmXU3d0g7gnxBqPg9uiUW4GPsGk/t6Y8xTlJbs6f9tdFKFtXkCp5C02YNToe5sNK77WudjGAA3PwpeB13krhfeFKU90jUmeacNBUkou1kjzRTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708622; c=relaxed/simple;
	bh=LfLQnQz1iqoAKVGoTv2Sh/lnQ6ZI88pIge7XwgLEMFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SkPK9txjASg9WElNKEcj3vDUGzB+NOqXjNByzET1UbVhqxuwkBs5iDlzYlpdX82Jo3XRdzpIA31TT/W33I6qFd63WaKu7rr+gls9gWU27eUAVxNVE3/H3EDGDWsIGHHog4I13U8lwQ+bU7vhQl4acgzuthac3BrkJGkX9M0pi3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WBAbfrnd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O4iD1P002652
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YoIdzOROHIhVWzo1GAX0DgD5w+s+U15l/MAF+x1560I=; b=WBAbfrndT8Te4p6v
	l2Bk6k/oKlHq9CiJkOMQbqyYXBAByz5m268wZcdafO63LJXRod7OwJnIuK50Ix3p
	RoZKJ1whFLJh//H1s0X62p2kkPhVYUMBzheuDnKgivyELGGUZ6AwKINhCM8aqmij
	FTEG1e9EJ/EaZcqpOdRPkDVwUgy10kn6Qje1eBmX9TXBwVrqkhrMIpAd/Pn3H9t2
	PyfMOukzWuwsJVfat4g3lWWYVNNYw69//qznxgw5ps7CqkFHouTvLZ9b8EN3ugTr
	N0MvCuy2Hv+k9Vbo5pnAugRXi5uBwtnp0tUNv4k91EXQm5C03W/X1cDnBbguU1jy
	8IgMtA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajexfd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:10:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-85696c12803so29712385a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758708614; x=1759313414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YoIdzOROHIhVWzo1GAX0DgD5w+s+U15l/MAF+x1560I=;
        b=DkIuMDBCYXPAbOFENr8wMY6fDoZ/IF6fFwDgZxRU8ivqeFkrCXc3onbtMMxA5O3ZYk
         sZkDJyi5QHRgyv2tZN/hE7an1d+BNbAcb8lmOXEBeXm5AhhGwW6UvfQLQApMP7WHm+Lx
         WbHi+D1m5OPRuwxdOctqowBs4kQCCBd50NyNoqUN92VD2jF4Df4aQcMRlzm5pjZcRyOX
         AW6uYNWNJ4RLTCuyqnkbmQUa/r/ognT4F4BdcHN3QKxjmSkviMEncvgD1gLjQ+3hGg2d
         ezVaBr7tVskORhbsJyFGE2ZXWdVx0vcue82I0ub2iPxsDAEvlKy4MqioXoFxMCUEUeNT
         jr6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1txu4Ijq6CqicOCFqChG/QXVeDvvMM8+vcGLj1CN8aIz3tq9SxEPDs3yoMq9igAXneXR6mjfWE68fi70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO11e9uXLPV1vuHO6l98HNUwbC8DYHgrh68XwHv30Ad6O0R23x
	uZuSRqI0JvTJvAMz1qj3VVJe5g/nW47cphmj++/SCdGh+AxlwtXE0WomdnXxkXudugr+Xkih71C
	cOAEKl+v1tbKCfeNCXD1XpdEe8r/8SDOg9rYkhBEOpOJZ5XxqZJyUvaRjkfuSULTcqCo=
X-Gm-Gg: ASbGncvE1ict9kVKHUj8rw5OMqnB/XKEhQszhWc3bSd5ETrhA+8xVNqidCxIginjlyF
	7SJTb+b8IthM9EWWzB9ZWfbrCT1oPcpmPuuxK4lbiAFbmLIk3zr69t8hXjR6bAFcUg6xELZhwjz
	3oGmqU4Y9Z8hWYxW6Ka2MdwoqVIvoBMu6WvNn00QbIW92n4CDhF0MJiWe+xG4jbeZkqjaYvzTqJ
	uHjkwV4AIYyRjzvw/IVKUDi5k5kZLEllNDr5r6sJjoO9sOmz9etTiix91Yz/4YSGdhEqUzSPmXl
	3+njbUXQLRfJaU1N6vtVFn0MAa0smJ+RtKvv/lpRKhgQpfrKfgPObWjewzOdGYPHwXoRLVHhhiU
	sGRnuj5GQR7+PevKZIXIKkg==
X-Received: by 2002:ad4:5f0c:0:b0:794:3dd3:a98f with SMTP id 6a1803df08f44-7e6fe4d5873mr46466036d6.1.1758708614507;
        Wed, 24 Sep 2025 03:10:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEer+yy8B4QW1rxsSNv+lBdFXhQg8TVeqGVwOyikhVt6nHECKjEa80EcAHvybE3COIE+zeLA==
X-Received: by 2002:ad4:5f0c:0:b0:794:3dd3:a98f with SMTP id 6a1803df08f44-7e6fe4d5873mr46465836d6.1.1758708613930;
        Wed, 24 Sep 2025 03:10:13 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5f42d3csm12390185a12.51.2025.09.24.03.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 03:10:13 -0700 (PDT)
Message-ID: <b17e95af-0fd4-450a-85ce-5e3ba1e9891b@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 12:10:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: qcom: rename qcs8300 to monaco
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250923-rename-dts-v1-0-21888b68c781@oss.qualcomm.com>
 <20250923-rename-dts-v1-1-21888b68c781@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250923-rename-dts-v1-1-21888b68c781@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vxsi4lXUxj6hxkf6LJZMtKxaEHDHyFis
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d3c388 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=2a2SA1_c7obCbjsyrsMA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX76j5TJ4HwEvK
 kBOGLNSQHy4Qy98M18Y8vIu8DXR+IBkBnKdQk72mJcUqvBMtr4M1l+JZXeauJu6xqLmkfsTDnJH
 6AhIRtMrTkN/LOSZQYSsKj2PKFclEhdDmNYmnwOs2kaOjIeo727bDuUchCd/fxI84RiJjhw/R2y
 J8kGMvruP5lBplnCkVjtGepJcz94kIZNQMlpG8R33oFLheasp0eckmWTQ17RgTOwjz+Ac8kHAIE
 00CpAEmEdxyHk1SP+6ucpHP1jcR0b5I+q7pr1unlnLfokHhFVHP80ojhggQha8Ew7b3ySRFFH7k
 h0xZl2GeyNrYZ0moDq8mix4A7fhJe3jXAdwzdwYVW2FmWJX1YXHzILW7vccadjWtai5GnPZSABH
 yPFIy0CY
X-Proofpoint-ORIG-GUID: vxsi4lXUxj6hxkf6LJZMtKxaEHDHyFis
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

On 9/23/25 1:01 PM, Dmitry Baryshkov wrote:
> The QCS8300 and QCS8275 are two variants of the same die with no
> difference visible to the Linux kernel, which are collectively named as
> 'monaco'. Rather than trying to using the name, which is not always
> relevant, follow the example of 'lemans' and rename qcs8300.dtsi to
> monaco.dtsi (and qcs8300-pmics.dtsi to monaco-pmics.dtsi).
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

