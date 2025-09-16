Return-Path: <linux-kernel+bounces-818658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D6DB594C5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CDE11BC3720
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E732C21FA;
	Tue, 16 Sep 2025 11:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dlMnqi8U"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87A52C0F7B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020759; cv=none; b=JSezAvQzZdZ7GMmdmNKuvph0mhMLOMKo+rpcJSpX/x2dJlB44jyv+KZXkl1Zo2Ra/AkQl1Z74XA+FA3SSaoCOolGOH5KVOIKTOWHALqAx1QdmSlCEe/SUJCgit0PB6Oowg3QP9W+09Evml8btK+pASJxJ4SJVJ139Max9CxaREM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020759; c=relaxed/simple;
	bh=Or3sS/huFAjjeAedfhopVNlc2SuDocesMGLsvA4ovd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4OLcV43e7SAd/7G4khdDA1nYMJPhob6Yb++pM3qbEKeXLQSvGFKQQ84eYzjOU2W60ljuIg4Phnou+P+0hNkIBsbB/p/vdO3bZCjAEMkOxUc/PJUYVjvxAYNiowQuIEoVwkPWFuKqq4RjYqKPdIkspFROoj/V02cATqoZB5szDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dlMnqi8U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9tHPf007954
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ViaUWXz7piwPDVzZe4GL/ffGnLLhDpYLwoddXmEXM0M=; b=dlMnqi8U2RnOWLuX
	aUoo0GYh4eO3jt2D79hq2zvH/s22QZ4in9+ugovXj7b8YuuCsexG8YKjLFdc9SHO
	3dmhpbPf7JzY92hJpDvqvOOhjThlIrGQjPJqJ1FVmzJK3fuGGwo/QmXm0Ojg9vPM
	H+t51KcT923S/64eW6v5izajWnen1tdA/1NWXt95CZifKbvu14UrOlRaVJRVbHUP
	iF7ePXDwHTyu5u3U7MfQLSmjlurJjO1XF5NB8I/M2cxz7DeHYanVxei9CsUhdLq3
	gjVsUtEMeI6knYUh5ShX0fuTR57RqRy4G3HoB/uOwhJy1sqvr+8bFLxoQAk7nUYU
	t8WfQg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496g5n49tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:05:57 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-77e3b8505a7so10601956d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758020756; x=1758625556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ViaUWXz7piwPDVzZe4GL/ffGnLLhDpYLwoddXmEXM0M=;
        b=cDJY3mNlkn0g/ePn34bYh8VO0fS13hTqqSHNog+EIajx4aBdPNKai8Y1SVcsWt9VF5
         42Kv3DaEz1mJb74Nh6bgafwm7AcQNtZ15m5k7PtW8Dc2euk+Iew6oQl32n08w0QAZZC7
         4/43xf8/F8hCkQkkiJuCZOH56daSTIXGUymITDMLYRGda1ZqRzQfVDimE4Y8JHJ4O0ew
         gwLQk+2CnVmNUz4WtdYibIfnOdwTHaUw/6b4HumMVrWLdYhf73X6ZDEha6HbFcDkkkYt
         a78AzEYiX6M0Uf/CFuVdeqpozBQ9YqdBpvEB3HMiq/O+5PMk1IlJPMLBVe5RAPsNOIU6
         k/2A==
X-Forwarded-Encrypted: i=1; AJvYcCUOKbMz6kTxyatpJAmB4HNuMQZY4V1mBypTwVixvZR5h/tJXN4VlGvJRpk8V0CQTKG8ruB+gFXofXePi8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlFimESH/U73BQdBg5x1IWTnLr3ibjBoKLq+Y758SmDNAmXuqE
	11fnPdWrDwHb42X0zhExAEfVPhe1Zlb2xwWiFRl6lcZUWam3LHGLQU1DvKjRYgQT2q5ZvXAFpcK
	00RAGbBvrHh/2Y0DikXhnO0KA5bGTWtAyu1S3zRYdtZBjyNCxgbqRZGGnyHiuCGTXpuA=
X-Gm-Gg: ASbGncv+YoxHIklDaQ4lvbzCdiapcewr4HC8pL0+JnljjN7pY4UtxEjcwXQgaHHDlLK
	V/hPR0hEUp+ZcGqHa9JUqMBI+5yrmIAsg5vqPc5U6y5E4jBPdS51VFlLSKWzlr0othKDubJWLAw
	EVT2hdJ0hwPUu++rCl0mc80NPwUQaj6eLRH8/9p+F1oJIwccKjWkTlQ8OHCDxvbsYmFETJSZr2+
	8epznKR3e0Mh4Xsib0CzDu8ayDCxXsCeO7rE7838MbhVIBo88NXHBLDg0DLflfWsrmV3kGk4QbI
	MI5sqBs2WdZKG/XndfEHWMTGJLGrpAuRnuED3VqYJjRkozatCmVcLYSGO6P1o+/oWtQ2xAVvh2x
	42XQEcMP3hRKnAZ9z2zqytg==
X-Received: by 2002:a05:622a:143:b0:4b5:f521:30f7 with SMTP id d75a77b69052e-4b77cfeb0a8mr138161801cf.4.1758020755561;
        Tue, 16 Sep 2025 04:05:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwsWlh/wMA1kgn62I3osn9yA6YaFnlN+94SeqOOqPpYtWKmcu0OzDbrZ+IaTwxiRXlalQ7pQ==
X-Received: by 2002:a05:622a:143:b0:4b5:f521:30f7 with SMTP id d75a77b69052e-4b77cfeb0a8mr138161411cf.4.1758020754944;
        Tue, 16 Sep 2025 04:05:54 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b31287cesm1146190666b.30.2025.09.16.04.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 04:05:54 -0700 (PDT)
Message-ID: <cd6d164e-a6bc-457b-97d3-503b897fbd62@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 13:05:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] arm64: dts: qcom: lemans-evk: Enable PCIe
 support
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v5-5-53d7d206669d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250916-lemans-evk-bu-v5-5-53d7d206669d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: C6E2IsIaThts3ZAxXjSE_6ow-0lNVsxA
X-Proofpoint-ORIG-GUID: C6E2IsIaThts3ZAxXjSE_6ow-0lNVsxA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NyBTYWx0ZWRfX+mf2jXAd5j1n
 LR53EVM9OGD+inZqyVS3VCFuMywpn8/QP3BO0f0wL68KkEYI8FheuPItApm0V9zR6G7TnhXP3g9
 kteTYHKDGHxNJTuN2kAdlaGTwiaLKe85lhm/ZUxNeYd4r3rPe+ss9r3g6PMNDddfQEkrpjnSR8l
 VGs282SL4EP8mN0tcHmQCgVOy2VhfEPusT5kkL/ulCm03W0WP7zKgod3ILa0ufUWMGv5gNE7KgO
 HBuRm/v+ZoyUygFxkowz9UUOflFH6YzyHxZY1IyiCVIhFkOt0FyOei2LQ4TcVgosn+ALCjhjjdH
 HvHz45He8uyxBT58PMIC/ig4yCkhA1N9Jeg2UBaDlBCZX7qxtwFHbm5WNlnjSCuyFXjGZLcW5T6
 jlpIAQNo
X-Authority-Analysis: v=2.4 cv=SaD3duRu c=1 sm=1 tr=0 ts=68c94495 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=lLTZtybaiap_q6JmIOoA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150087

On 9/16/25 12:46 PM, Wasim Nazir wrote:
> From: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> 
> Enable PCIe0 and PCIe1 along with the respective phy-nodes.
> 
> PCIe0 is routed to an m.2 E key connector on the mainboard for wifi
> attaches while PCIe1 routes to a standard PCIe x4 expansion slot.
> 
> Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

