Return-Path: <linux-kernel+bounces-800657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3F6B43A2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B731C2845C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFE72FC86F;
	Thu,  4 Sep 2025 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WHQKgyeT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A3A2D8DB5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985501; cv=none; b=Dh6UywaMVrjsh60BRPNfKjY2Fgjx/OYn/YaMKlEcwKrEkOYvGMMRAJ59pyYWtQzBQ7aB/43adpRx/qBIWIrVvdPHnC97cfpr7PIJ7DtbdG5rHXSGrJEQ2SqdRJv6DMeHXGKlXZndjEob4Ns+V+CSxzEaO23ITlBDlAgDflXKipU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985501; c=relaxed/simple;
	bh=rAALfnxHqaKhs2dQnETIE/DfrBgOvyDsTDw6hkeBqbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USJSYJZuPLfM986yiy3s1iPvDV62eusc7q4Tat97mD0ZsG+rKN67pKGZBu7rWSPBSz0mhbxQo7Yn/HAG50zDWMKtsjVgkbsL6lgDtiwXVJxkCqFq0v0wGsMSipOnleo2lfXU08B4V0AvKeFAHZvoGWigRI/K3nUlBWzZeel6RZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WHQKgyeT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849XCci023000
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 11:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2oM+3LmCQmXmSWcFdN4jFgLAQvHu68nnOGl7gbFhODY=; b=WHQKgyeTJA+t0hdF
	Y3HsIk40d6AMq7msZj7vQoxY/OX4XyA6gC26VqCWb3rNsaPIruX6D72AAyZqk/E0
	MZb1/e8MWYzTOoogj+JpZ8dnIE0la5OBW7GDq8hIhfuWQmo9SzbvlHCmCMmldEa7
	hcIKmat8z1/sKrSwL3EEcYsWDfRsL8ozoDCSicNeA2AkRM1jZiTJQ0VWNSa+xKW/
	5MfWP4coxyEUpK2C6NycMVV1u5nW1yzJ5wLYLR55g9LCtTu/pHGX55x2OoQKrnr+
	hZch4Z+KRBwMUxlaIaCgjW5y7tiGC0KyEK4xO5cKmtBbGhamjDbspWTAfyqOoalz
	Gdh/Eg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0eqeex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 11:31:39 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b10991e9c3so1641611cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 04:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756985498; x=1757590298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2oM+3LmCQmXmSWcFdN4jFgLAQvHu68nnOGl7gbFhODY=;
        b=WZNX2+qPTno9qH34oFzbSv9S2Te2ItEK0iRMjCE31Mk9TTFNnurAKkozsB6SM1M8E8
         dnKPCYaaUtRe1AS3fNo6wbix7bE8ABOHceOS+U9JvWx3uyAnrJ0++bhC4QcLXL9vMyhG
         /0LnovoW3rx4TPcMYOaW2rV1qhI+oSMR5ENjrrpctqAss1bNqpz/NQW6vfhzPN47NOmF
         rRuZA0IG99vkzly3KzlvxK/7bkrGI+JpbfhGaOfVPJ0Xr250frSbHWYf2aVy7kN2DQ0u
         shXMT06nxxUDiu++Ye41jqOP5s5X0omDXb0KE33bvYeN69FHBQDBV3o82ZBgkJmZpsje
         bIqg==
X-Forwarded-Encrypted: i=1; AJvYcCXckaxxm/Isqv//XBKX/G6A9eUjg9NYnH2tq9H9zlaRQruReV76EPwaym9MWNL7kG4pCBbfKESPhsvtIfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcvNoRntkVhm4bPqvgTFDixVN4+GM2aHmO9OhdE1nSoSpb8Bi5
	p4pxHQTjQixh8cWQxngzc2iDijRE3hadgKHkX4cXEKPxeqTgWjyLyEIddn6yuapO+ZQqDQkKEED
	53IJQKatE0j4ISfHUHplXtKGyYmuzKtDghBn0WgmxfCq678n8WPMNzparPYH0SZ+BFzk=
X-Gm-Gg: ASbGncv8yrQj9v5q4I8T581Tv1ZricFmM8vSgRE7bmBhCeNhE0X4DhdYzeQhBW6tWg3
	2z8KCuwnOsJM1zN6lwMTXIBKwFyGeVu818LRKuBavA0P+3YEJ3RZLUC1+BARaF4eVtZCypD5HMS
	zj+6HkhiHR+ScfAJJUmqiO7DZvQK+RDHEZPiRhOKR2ccfKBuAPHtTpjWffhhwV68pGjOg8gRY4A
	Xttm7GeJClZLVUQ/rSw1zXGbGg4CfrkObh//JTXd5FkABVC3xf+xAgNolam3jSFuBQTXtECPnkq
	7hX49f9yEHsx9mrjDwW0AB4Cg4Cu+fWW9Jki1sbt8SYuD6P7XRpYM7AYFUpxKOz8uRZHA7SyYqf
	3psabkxmMHC2vOjvmT+X3Xg==
X-Received: by 2002:a05:622a:189d:b0:4b5:d74e:d938 with SMTP id d75a77b69052e-4b5d74edfeemr19082151cf.7.1756985497901;
        Thu, 04 Sep 2025 04:31:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyimratG0v0rJZ9h4moU0EjyKA3wUxFmTeJvP/OBPnaKd0KPhuJvcfVyUHWIHJApnY48UUQA==
X-Received: by 2002:a05:622a:189d:b0:4b5:d74e:d938 with SMTP id d75a77b69052e-4b5d74edfeemr19081771cf.7.1756985497411;
        Thu, 04 Sep 2025 04:31:37 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b047909f504sm206421066b.22.2025.09.04.04.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 04:31:36 -0700 (PDT)
Message-ID: <a547ecce-31c7-4627-ac6f-aeeef81bd0ff@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 13:31:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add support for Gunyah Watchdog
To: Rob Herring <robh@kernel.org>,
        Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
 <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250903-gunyah_watchdog-v1-0-3ae690530e4b@oss.qualcomm.com>
 <20250904001014.GA3405605-robh@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904001014.GA3405605-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jlx90DY5QdbHRgrcOkExqQPuJP9jBYa0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX4BaVG/2pVlC/
 p+OHDYcRKUM860U+KhadSxOGDZsfPo0Fsv34lBCfUjz5DgDRka9jd81lUvXicCKIIKizWKlnR9F
 hayvh4DYaH38fe87d9bozPusc/m9ZiDwEs3ksI54os7R9eKOdX/Iu78stu71L56754FjrpBfkRR
 OKlpPsdVqZE1MqTWGDPz31E+bE4nus4VqcKxIOj+HRk7EWJbUzfpcefrfmfJzw7wCYbn3nk+T+r
 2xn9OdQK1EMOIVlzCDZKUS1l+zlusWhBrk9ogB/JFGbwe0mkNau1mpsVKBDgPlGA9joRKw4r4Ch
 dvWxafVDFSJxDyLkjsJmCDIJYYJsFiniMsBjZdw/qVG/0u/OVcn5DmQu0CQLP//GTp1jYJvWaHt
 ahVhFw7s
X-Proofpoint-ORIG-GUID: jlx90DY5QdbHRgrcOkExqQPuJP9jBYa0
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b9789b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=dyZUlkJkdh-3oYjz4Q4A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004

On 9/4/25 2:10 AM, Rob Herring wrote:
> On Wed, Sep 03, 2025 at 07:33:58PM +0000, Hrishabh Rajput wrote:
>> Gunyah is a Type-I hypervisor which was introduced in the patch series
>> [1]. It is an open source hypervisor. The source repo is available at
>> [2].
>>
>> The Gunyah Hypervisor doesn't allow its Virtual Machines to directly
>> access the MMIO watchdog. It either provides the fully emulated MMIO
>> based watchdog interface or the SMC-based watchdog interface depending
>> on the hypervisor configuration.
> 
> EFI provides a standard watchdog interface. Why can't you use that?

The use of UEFI at Qualcomm is not exactly what you would expect..

> 
>> The SMC-based watchdog follows ARM's SMC Calling Convention (SMCCC)
>> version 1.1 and uses Vendor Specific Hypervisor Service Calls space.
> 
> Is a watchdog really a hypervisor service? Couldn't a non-virtualized 
> OS want to call a watchdog (in secure mode) as well? But I don't know 
> how the SMCCC call space is divided up...

Gunyah traps SMC calls and acts on a subset of them, passing others
to TZ

>> This patch series adds support for the SMC-based watchdog interface
>> provided by the Gunyah Hypervisor. The driver supports start/stop
>> operations, timeout and pretimeout configuration, pretimeout interrupt
>> handling and system restart via watchdog.
> 
> Shouldn't system restart be handled by PSCI?

I believe the author is trying to say that the watchdog is not
configurable from Linux at present, and if the platform hangs, there
are some indeterminate default settings in place

> 
> Why can't you probe by trying to see if watchdog smc call succeeds to 
> see if there is a watchdog? Then you don't need DT for it.

There apparently isn't a good way to tell from a running system whether
Gunyah is present, unless you make a smc call (which could in theory be
parsed by something else, say a different hypervisor..), but then this
patch only introduces the watchdog interface, without all the cruft that
would actually let us identify the hypervisor, get its version ID and
perform sanity checks..

I would expect that Gunyah has the necessary provisions to inject its
nodes as necessary, at least I recall there was some talk of it in
early revisions of Elliot's aforementioned patches:

https://lore.kernel.org/all/20220811214107.1074343-4-quic_eberman@quicinc.com/

Konrad

