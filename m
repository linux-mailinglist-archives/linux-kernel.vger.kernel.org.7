Return-Path: <linux-kernel+bounces-832591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC289B9FD67
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1184164392
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FBA286D73;
	Thu, 25 Sep 2025 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="StYkfYyi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BB328505C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808830; cv=none; b=hFiCfYWVJ69gf76yyrN0dIbPXRmun5w5H/TtOTfle9rp4WlWE5oX5Xhfk/1q+QhpOaWrZonzxBtNFYitFK2mm6ehoiQ5IiSAqwHUBegsuu3HhF/fcR+6w1jBCsSFPXcAlwBLKCGMEbWtyL3SNiauD5fuQ9Iqfj3TkemM1CXoglE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808830; c=relaxed/simple;
	bh=h99PfcktUZ1KhQzpW3fuP7Ha9igucV/siOOOoJWcSD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5hRSAozS7vDuWJqqL3IC/djwnyhUebzGquOgpM+TYj1xD5zYXu30yPWpiaXjwmyHEZelpWPhAIm7HXQNLfl6ISwoImTssooyEAnfjzsTfW4tXifEfexxcxP+rmANkjBLxLpdVPFRTJ3SevM8FIf9KqovORqifdFI19RchLU31s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=StYkfYyi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9xfQH029565
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XUsWf7bqs2eSLAnjUL1U9rWsVFHxuSv71mbiVdSxlpI=; b=StYkfYyiiWvlWfg3
	Lvok7NmPvGhVDzCtlxPU7PMwnZrjxC5v1akAP39GebZDnuuWWraZhLlm5tgb7ns5
	n1bfqtOhDFhRjuRJKytYXNlRUiSSI7J5PA+MhPVmzLB6pNVKXtFmGlFnUHH47HV/
	7SYM864Dl7v4WbP+4gwT3Fn0pEZI/HLUCaPJZiXjI2EBL2py+BmUeSoIrkVKDq0F
	eVg3Bs6kVdnm4QY6XMQbShg6c8hgKDdKmBsz5q55vH/Rx5g90xZSiAl4X0sGeJKA
	mJKBpPdm/BS3O0Qdgz7MtBWHs2HQK7+3X9SkkfcAp05kxlt/P8WmMkClmZSLQgcB
	rlRwFQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fr6wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:00:27 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4c39b8cb20fso3529411cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808825; x=1759413625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XUsWf7bqs2eSLAnjUL1U9rWsVFHxuSv71mbiVdSxlpI=;
        b=TH/ngczBmbZ2/pVgcFtOgHk7GsZRIGZcRJdGyXJmFCbpDNvolSaVBZpp2Q/jrT00jq
         LxxIifSJCzYFjujnrviH5tVSfMtn01L2eoJjoyxrLaPAOsERyP/l8tYniACcqmuzhr/2
         BgppmQE8cMWwLJvPmB89+HiA/aLxIIuJcAhl+D/2kQiyEjJkfFSd4opaJ9eOzVOoVorv
         APa3Gb8rbu5BtkSEoCbKArWmpSa4tIeGyz1fL3d9+pZC8iinYC2+X7q4pmAH8JA5ks/Y
         ulrzjMM/7vPhun7VCMxxahEFQvRZUeNBv6IkZEeKalcC0P2SqcaDVewhPzKjHJzj4t9L
         ZUtw==
X-Forwarded-Encrypted: i=1; AJvYcCWid8VzSObjDoysmHTxMR0AiE01nRuqxOSmSzJBhS9DtLzQ0q0nadJPShQBsgN33Gdh2ChmGwGlQFFKMmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkhVxKDGvZUzNmwb3USFjAziFeXymFczg0oEeILEgz/Mhp6ijE
	KCY+a2GXDju8LdOXLfH3IFuRfM1JrRi+Y/PsRD24VBg6Pae47C21RGzESzfnuCHVer604swtjpS
	hMEUktxYQ3n2TX83QItVxmv5EqDAG1rWpUzOSuoHCsQ2By2BCHf3SuEso71jVGQZfCXqKbE8bQP
	A=
X-Gm-Gg: ASbGncv306YnAJAMm0gkegcuFy9lBy2NofiOwO4WgD25YIhHnVmckA2ITq/9LIvH1yb
	PbU377Uw5suUdmx9jSYapmS0gMhrS1jOy5wjXp0/yvOKFNdBvEprSuyaogdfKe8l23+Iu1vEuc+
	GdESj+IHoDgKOft9XQtaY60kPLxWdGg4EKzdvG7YHeJTguDgAOlMPjvTegedatzWpitpe32m918
	lpUOGjYlNnBXETad/6eBHu4XtqFJ74JU1sgqzfbciIe9uMKwjjkAy0knz3etJfcMcJc7pVd6sb8
	CIw8Wzmc9+J0IMD3gOnbS5kMrnhziSvZlZiwmnjMTqjPHfgxvBUGrMnaSTv0vMEVlADLBp64gbd
	VepL0XuedNz8HVpSUTzy8wA==
X-Received: by 2002:ac8:5d88:0:b0:4d4:ad40:fb0b with SMTP id d75a77b69052e-4da489a10e3mr31332591cf.5.1758808824163;
        Thu, 25 Sep 2025 07:00:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFX+I1iprsRH6SvaH+LsSyd3jhUP5sSOxeDSBSeH8H9xBMZUc+poCVqQXxwlYniTKKdMngEDA==
X-Received: by 2002:ac8:5d88:0:b0:4d4:ad40:fb0b with SMTP id d75a77b69052e-4da489a10e3mr31331691cf.5.1758808823362;
        Thu, 25 Sep 2025 07:00:23 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3629878sm1264034a12.5.2025.09.25.07.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 07:00:22 -0700 (PDT)
Message-ID: <9d2ae733-6df5-4796-98c5-89e953c35f4b@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 16:00:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/24] arm64: dts: qcom: Update the pmh0110.dtsi for
 Glymur
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-14-24b601bbecc0@oss.qualcomm.com>
 <CAJKOXPdQH2jXcEY6ZpkmixvUt26SqdzYgDAiJ3RHMG7xkPyi_A@mail.gmail.com>
 <lcbcjpoazpwbltedkiqlw4l3aomwvi3qsfwvmwghb6uf5wvnme@kh7qdpunfuwr>
 <CAJKOXPcyhDdFW_u4YQLiHYj8gM7wYB-LOmB_PJs+5OOgn8WZFw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAJKOXPcyhDdFW_u4YQLiHYj8gM7wYB-LOmB_PJs+5OOgn8WZFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: DD2wZr9p36xUl8m8PlQdNT5Of7kWLzRw
X-Proofpoint-GUID: DD2wZr9p36xUl8m8PlQdNT5Of7kWLzRw
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d54afc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=SWti5kBmd2enZMrbPjAA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX3/JwohcJ6AfD
 6EwLQ0QzP/wr0Fe9xpmtSrnjnjx+ko0kb8Hy5JDNxykK8rAMGuRd7TdVWpfjHpa6d/w/5rx7M42
 9caIyQsfIboqYgIu6+SNDYwhx/SoGo1X4xQgruvsuIzHi07TQfQtoI7Gxfo1kd2speabTD/49Ps
 JrQ4ff8rWVscBIUjjHgBELBWfNRaU+ThBsmx8p5fgEl6+NUyMGPhcky5F34z1uqv4MQRMaOTR3d
 I8XiiWKEnSkeB5+ETByp2M5Dgl5/o3FXxcexQhaOXdw6HEhchKRBqtYKNpOiWjlf1cLR50gyD0i
 80Zq47oDXptYLAx6FHchOBGR/5f1k1/k2dDCeJoOVmP4gNtbcWYGxL++TpTigp4KXBTa9tKYu01
 fyRB2oC8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

On 9/25/25 3:34 PM, Krzysztof Kozlowski wrote:
> On Thu, 25 Sept 2025 at 22:14, Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>>
>> On Thu, Sep 25, 2025 at 05:08:54PM +0900, Krzysztof Kozlowski wrote:
>>> On Thu, 25 Sept 2025 at 15:34, Pankaj Patil
>>> <pankaj.patil@oss.qualcomm.com> wrote:

[...]

>>> NAK
>>>
>>> I already explained on IRC in great details why.
>>
>> A short summary or a link to a channel / date would be nice in order to
>> include other people into the discussion.
>>
> 
> Of course but:
> 1. You were there so maybe you remember the arguments, and:
> 2. I'm offline, using phone, not having laptop, replying during my
> personal time off just before merge window so any emergency time
> should be spent on important matters instead these two huge patch
> bombs adding such usage I already said: NO, don't do this.

Thanks for being dedicated to the cause - however since we're right
around the merge window, it's safe to assume these larger changes will
not be picked up, and we don't really expect you to reply immediately

There's a lot of code, so we'll definitely want you to take another
look at it after you're back (and before it gets merged)

Enjoy your time off!

Konrad

