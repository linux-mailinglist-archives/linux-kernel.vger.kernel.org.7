Return-Path: <linux-kernel+bounces-848649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DA7BCE41B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E5B54EF2B6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56A2301038;
	Fri, 10 Oct 2025 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D++fSYIq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963A4301002
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760121179; cv=none; b=C145P9OPRJdTRGPZf4p9FqxHWHZDamZvw9/Ac0RExHtLxee4xOD75OIjOallAT9AEuqyfZ1Q5Mx2zVlrInBljRhW+CYDLDnF9NvgKOaA3XXI83wo8RnZA9gEkzsqzaKjzfIg1yTDF0IgGkCnL9qLV/WeGM1uReuiKgh9v/s/Qp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760121179; c=relaxed/simple;
	bh=DeSZCmy8qKaf/hrkCJzbO4T+6mmq6tERS/lKYAuCof4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MVOgVqWYBwt/pMMwnJ2WonVeYrheMa+Z+ns589uaKGa+xLZ6RmR2PfW1iS2fqUc4UJoDdiqQY8Trep6FNJSNRxufPBHYvu8YhR64JSRK5cHdOjHvpLVNiDkUooAuALOcmk4cTHenqnEOvXttEB0B6SOMlEzpSSUKwVtctQ2YVdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D++fSYIq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59ABQ4cN014218
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZYWMxOVH5PMb6N4KYuAsgb0talNOaEWcWrXu6nfbXTQ=; b=D++fSYIqPfAG9o7p
	XNaX3X0R0NDeawmwiQ7621wPBgF+Jw9yb0owM6epKEj6xxqUnqPa3VOmiZLTmTUO
	XAVLul6LM5PGyLR7Yy3eXWGzjvWp9FkOpXb17FqLOE9ODopBEB2oRNYZaX+WPnUy
	74Y81ijrx8Jw2SkloO0iNxFZvwDl4Yy0t/iQEjvk6ryVCXYZEIlSkLDZG/XtUv8f
	+xHm9DJEGGGDL93Nis33yeNcQvyKVCr0j1NNXPXYYmlu5VfbGXL4x6Vfw7ZWD17h
	+eG0hu3tx0MI3XU6M3fxi3kctBRqSpzZeQa8q1njIZpj2FieB8mMGzDmsjiEmy3H
	qmvH1w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49q18y966w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:32:56 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-850553dfef2so9950366d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760121176; x=1760725976;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYWMxOVH5PMb6N4KYuAsgb0talNOaEWcWrXu6nfbXTQ=;
        b=vcImevaKIh5f9dvhUFT1vz0y68eo+inNgwjf+bVA5/nyVJu4VUjw3wZEZ9sq7hpUD7
         AobsiWsdNxVzZMNJCRVol29q9T8pwv7AOCoSP3+uQ7UHnuIq80ffm01coMzHuJyfkT4R
         6RBv6E7IRUSsPGpAc3Mr0oeZkyLirEQx+iciVAwWB45q5B2+VWk0+6sjWS0h2Tj6FPPO
         fOL4so+YXSxV+x9mh58virisMwbXrLkDaLc/V81Ogd6oaPbsXV95LPrL/uyftRnyot+m
         z4aTV1+8aAJmVA/CwPjJIIaft7cXEgQXfSmtUmKnUFxS2F5jpfDBtJn6r7xNwHo6S2ef
         hM7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8UVl+g1g1vltlK44BzOQke5UH6/FgptuotjWG6VtsLjQDmnNFQ7VFidLzqNxmBDggzh4tlCYeVQbhD2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+jKbV3Jk5JXU3h9J/jLhdrNx7dyk7vOZ8+lVDADVQlW5Iw9tv
	wvEdUcPd34Tt5mSwBsdFXWIPTBafdFbxK/R/ZCKM4VL85YuKLno/Siv4Y6AmE7VEQx94qimDrOz
	OtQGIphFn7uId3IyGkO7XRMxHdgxIDz/mLIMHJl4Xd9P3uQLjBfRdY1WzdCZ/ooBrWz8=
X-Gm-Gg: ASbGncv2NKF1cOMJ0zOUwf6IRGD/LT0DijBMV14YKAEOi0y5OwzpLo09hJqQN0/p0cq
	upyMtyPhkw8PPFPSU1XQN2d5fc3PHOd8W23XubCI8EM17QSuEk7eFhN82JAPmxMW7PP2yu+IrWy
	7M4c/7hXU9wPWzvkhgUCE/xOGuUFbJuDt72tqyc7BtPbSRq5MK03fJDyMnhj2s2PJ5DqcQVb1Ea
	chnRHjdPECH4irznXiTZPWZqZ3WOwmrKWzSbVzrtOgMNQPkDg971Col5ZQtaZMCpA0VIzJkoIHq
	Ny1rUJx9YGwBx1xmLigweXMDYmk8l3/Tl7Nr/6Q5t3wvJdIsYMOhRcRhcU7a34E17i4AMPv2aa3
	Yvw8hOSjHzoUW4wBhfMeRfQ==
X-Received: by 2002:a05:6214:f25:b0:7c8:8c3b:99fc with SMTP id 6a1803df08f44-87b2ef4ed5dmr112076166d6.4.1760121175627;
        Fri, 10 Oct 2025 11:32:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhQfGBPvvej/Bb5PYt709FHH1mmSHi9GsC/188HhZgdbWAkPACwLdz6IVQIlQc1SwCKcIL/w==
X-Received: by 2002:a05:6214:f25:b0:7c8:8c3b:99fc with SMTP id 6a1803df08f44-87b2ef4ed5dmr112075716d6.4.1760121175001;
        Fri, 10 Oct 2025 11:32:55 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b0f860sm2817329a12.15.2025.10.10.11.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 11:32:54 -0700 (PDT)
Message-ID: <4532e2e6-51bd-4443-ad51-41fc02065a7d@oss.qualcomm.com>
Date: Fri, 10 Oct 2025 20:32:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] PCI: qcom: Treat PHY and PERST# as optional for the
 new binding
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251010-pci-binding-v1-0-947c004b5699@oss.qualcomm.com>
 <20251010-pci-binding-v1-3-947c004b5699@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251010-pci-binding-v1-3-947c004b5699@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nEY-AlRCrscKP5YvzW0oufVuJLjAbbGa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDA2NSBTYWx0ZWRfXwRLjueBbqslh
 Y5yuJchYbOz/WKQgvprZGxtLzpy237z0l1oL6QpT8owAfl+PDQIb2sXCkDTZo8hfKez1Q06XHBo
 eqV9Z3UEr+PgQS+1sNjZYMtu8aqqsczA74lt61ZQFm52QKb9suQlKqIHFOMA9++9fhT71+aGGFI
 1TFgZV+Oayp8h85HRgAMfExssHf14F/L0gRT2mGgmqxi4gZ0+vneoMU6infoPW5epgsUMwH7aKU
 Rpu4ULn+4KJu4EFmGEog1HH0sZ6qpcnBOnlEJyXFutPRUBaV/aiMvsCU0rjBhYfaTTRoqxv4Bsp
 tdijdhHKxBjgMrTU2G+7U7fwlUiOJW0kyiT/X5w/jn9wq6/XYd1dBDlrAW7KrGB8Ra18KU8PjNz
 lc+WLdY0fXko/QKLCHvevEUR2WnO4Q==
X-Proofpoint-ORIG-GUID: nEY-AlRCrscKP5YvzW0oufVuJLjAbbGa
X-Authority-Analysis: v=2.4 cv=LJZrgZW9 c=1 sm=1 tr=0 ts=68e95158 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=f56zXKZffaiFsfKDMp4A:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510100065

On 10/10/25 8:25 PM, Manivannan Sadhasivam wrote:
> Even for the new DT binding where the PHY and PERST# properties are
> specified in the Root Port, both are optional. Hence, treat them as
> optional in the driver too.

I suppose this makes sense if the PHY is transparent to the OS
or otherwise pre-programmed and PERST# is hardwired or otherwise
unnecessary.. both of which I suppose aren't totally impossible..

> 
> If both properties are not specified, then fall back to parsing the legacy
> binding for backwards compatibility.
> 
> Fixes: a2fbecdbbb9d ("PCI: qcom: Add support for parsing the new Root Port binding")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 805edbbfe7eba496bc99ca82051dee43d240f359..d380981cf3ad78f549de3dc06bd2f626f8f53920 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1720,13 +1720,20 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
>  
>  	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
>  				      "reset", GPIOD_OUT_HIGH, "PERST#");
> -	if (IS_ERR(reset))
> +	if (IS_ERR(reset) && PTR_ERR(reset) != -ENOENT)
>  		return PTR_ERR(reset);

Please introduce an _optional variant instead

Konrad

