Return-Path: <linux-kernel+bounces-842756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EE4BBD79F
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 11:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CFBC4E26A0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 09:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A826E1F09AD;
	Mon,  6 Oct 2025 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZLeQpAO5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862E91F462D
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759743815; cv=none; b=HljvJ1M1di2hpLl7nR7AbCZTLltHQxF8ZGCD5E9X94WMJanOYxWFVyhoAXDGDoZOBBf3zOaQ97XXTzzBcveQxVnB/1L/8DSnDyZmJd+IkZ8Z12ma7zkY0W//CdbfXYGqrPNEvDPmclp3vIlnOYq0wYtsNO3BaPdmSc6s8h43PmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759743815; c=relaxed/simple;
	bh=3VAOb8Nrbi79Vo18vNteD/+ZcNN4/z5L/Addy7FvvvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzqvU7MBgF40YuG8KGlQWS4ylqXF/To6+8eByw5sEgJpqf3iVzyycIyvqMJ+VThvrf25XVW1VTowZP6p20ITr2uzuy0G7fsYrkO7m/7taphtjowiWa2zxQjUqZzjVcB5eX5E0jOiJqSpUhi5J32oUHMRfYr5fMvno26zIEhYDpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZLeQpAO5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5960uqgI020328
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 09:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tQIe8mny8lpWTJQXbYK8gsz6F004+u+gJgZcpGlIaik=; b=ZLeQpAO5b+eJvPfu
	nRZcQ7gtc8UaS62u93vdXEq/zYhKi5uqAlek/nu9ZviSzqjhXjRlZsXzeBS4Xy7y
	vdJesuzGXEpPekQg4PcStE/kVbOtOAwYQO9DdnC90Pz2IJltQ3t7o4qWQc/kg97c
	DZsQn6f0IYXoU5Pdg1tZv+x4xbAlICP18cbGN0TVhqqTjuO533qo1A5yZa44Rt+N
	8PWZIfEddATyRP6oX+oN46G1lpoaBgfGJqC5g+07T8sZPojR/QVfwQnqjBT6/lQJ
	Zupuvu0KaS8hBx121Al0AOgerijBOZ0SsJ3oGP5rJ/Hru6R4Bh01M3G/EPTkrbHF
	1rM9CQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49js9dup6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:43:32 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e6d173e2a2so2497451cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 02:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759743811; x=1760348611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQIe8mny8lpWTJQXbYK8gsz6F004+u+gJgZcpGlIaik=;
        b=Ao3knqVF2bdGKDQtf6GutYDkzZPpAltQIwIjmAVBuPWMprkOS2iupQeSxVuxPffMMv
         KqlN+FUTw1OQKrNmiLokKnyuSOzNc5FlJx8Pcsl+bTS+PX7p+QYLEQt3eVI2xbbWseCK
         icEpHdAtv7I1RZ+eXTHHT5Yf8B78uG678+9w5DgMSI19oyy5TfZikMR9frlMelodZPUA
         ChK2tLqkogJBe+dD11Dldib3p+UDYNRAhuyzfGqEJunsZfeuS5jmml8C9DCOXXLeYRTJ
         HJvBd+c6gaI4XyZJAgfJqYnKdRNKouFuE1u3DEIAfv3a1SOL1oMAXgPo3/h5QBEhBx7i
         +dIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO2Q7RxHG5O9bgyJ+orG3vP9ElE71YKAf6o8k4YptoHlmdAI6aA7HyQWNrhsgxz45sgLbBaU4tWy0KV9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxulYSL5FS6rN1AmIW2xIF6o9kSygUuj7uLFCnVn7txryodp2PX
	n69shWtHyJYFtkVf81qhVdN/q5SktZi0ISirCWhVLfHyW7FjNiI3E90jbqmWA0PT4xNiN+VLZ7y
	EKKdfgCxPClsvROwvjqiTBGE07Hv5qXIuRrbef0gumSlNdRUXtXYNHJM/XIZB/bIkQW0=
X-Gm-Gg: ASbGncvkIjG1iyb2XBgGelOAi7k4qICWjnG9JikA5WTuRSw9RZawVMqxTL3SEIyI+yA
	r4aXo4Mnj4lWxn+Gd8RjO4TTIV2Vy7pf1MzAu/g4Dnh1xA9DgZ10oeXxc7BaLBQwI0brxOAGb11
	2J4R9EOMkja0Hc6AAVLOa18arqTzdHloAHRaPi1WOqYyKZVhA2IXkLkVJHRJtnSc+eobda3IUGK
	wKSmQtGmt6ac3deSOZDYXz5WlStNmRH8y+0PHI5an4epmcQUFx8aKude5eY+cL6UWrNHRvXh6O4
	6rdP4G2R5Yn7lZozi1OAMuSnaGe7UOev8dbsWtMjd7IVB178Sie8urbE2n1zSRpl10LhsD9OwtR
	pnOF3KfNl5WYCGtpXj0yYf91qhuE=
X-Received: by 2002:a05:622a:258a:b0:4e5:7716:53f2 with SMTP id d75a77b69052e-4e5771655famr95826161cf.8.1759743811159;
        Mon, 06 Oct 2025 02:43:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUXXbxMxFQqe0X0SjTWriB86v6b78P31OuJJMWbMygO3fbIGEmAAsmk5wn/CxtoooibO/WIA==
X-Received: by 2002:a05:622a:258a:b0:4e5:7716:53f2 with SMTP id d75a77b69052e-4e5771655famr95825931cf.8.1759743810661;
        Mon, 06 Oct 2025 02:43:30 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-639773d4d8esm4041553a12.30.2025.10.06.02.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 02:43:30 -0700 (PDT)
Message-ID: <c8dca827-b089-48e0-9dc2-a5b6e3c5b88d@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 11:43:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy:
 Document lanes mapping when not using in USB-C complex
To: Neil Armstrong <neil.armstrong@linaro.org>, Vinod Koul
 <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250930-topic-x1e80100-hdmi-v4-0-86a14e8a34ac@linaro.org>
 <20250930-topic-x1e80100-hdmi-v4-1-86a14e8a34ac@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250930-topic-x1e80100-hdmi-v4-1-86a14e8a34ac@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Hrl72kTS c=1 sm=1 tr=0 ts=68e38f44 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=eg4Xx4S7Erm8exKiWv8A:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: DWWZsLFzrW45ZUStGQXtkbZ7FtdEx3kL
X-Proofpoint-ORIG-GUID: DWWZsLFzrW45ZUStGQXtkbZ7FtdEx3kL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwNCBTYWx0ZWRfXyEUsPzfaLP5P
 KIWrxlGIBl1QUwoKBNrPDuHVYGUiLYgGiBJflPrxWKavXkmhEmtzYjrp+KueP/xpmThb2D3KrIZ
 S0qh972IAxnrOhATlCOjHdQz9DPE85tdm/WurKzDP8gxHXr/BV+MGAn0aUjBMKq54oJgaCaNxty
 5d4u2Owg7CXUfgleeOMNSxU2gPi+Ei9xQfWKxJvqDHx1++EUaLFvEZNjQ50G/87xwD56jI7iIk6
 9esx0La3NQ0SDad0b9KnYY/sAXkIPCHmfP0lM62wcA3YEOFIY5Ctmju0oyUHJLrcwlnwsdPIiCS
 +pJM6wfo32PwFGo7otcye4H3PW82PG9hQ6ZFJ556FKNBuX0oi2ClCe3+sns6Z5INhbiTyIXD6ER
 D2/RSaTGYDcl9M6f8gryf31hjdSMYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040004

On 9/30/25 9:39 AM, Neil Armstrong wrote:
> The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
> of a combo glue to route either lanes to the 4 shared physical lanes.
> 
> The routing of the lanes can be:
> - 2 DP + 2 USB3
> - 4 DP
> - 2 USB3
> 
> The layout of the lanes was designed to be mapped and swapped
> related to the USB-C Power Delivery negociation, so it supports
> a finite set of mappings inherited by the USB-C Altmode layouts.
> 
> Nevertheless those QMP Comby PHY can be used to drive a DisplayPort
> connector, DP->HDMI bridge, USB3 A Connector, etc... without
> an USB-C connector and no PD events.
> 
> Document the data-lanes on numbered port@0 out endpoints,
> allowing us to document the lanes mapping to DisplayPort
> and/or USB3 connectors/peripherals.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

[...]

> +          endpoint@1:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            description: USB Output lanes of the PHY when used with static mapping.
> +			 The entry index is the USB3 lane in the order TX then RX, and the
> +			 number is the PHY signal in the order RX0, TX0, TX1, RX1.> +            unevaluatedProperties: false
> +
> +            properties:
> +              data-lanes:

Can this be described in a somewhat reasonable way to be non-compatible
with Type-C properties for more validation?

If not, let's just maybe add a comment like

# Static lane mappings are mutually exclusive with typec-mux/orientation-mux

Konrad

