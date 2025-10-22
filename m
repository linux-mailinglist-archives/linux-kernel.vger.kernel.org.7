Return-Path: <linux-kernel+bounces-865487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6553DBFD3E0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DDA5834FCA3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CC825782D;
	Wed, 22 Oct 2025 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RU6FnU3d"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FDE272E6E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149846; cv=none; b=jM700rq2Ia3SFEyLQVz1OJnvpSx0bgxrVyELUujUcUnTeIwENh6XBo+sz5QcAL5wokHkLsGS/qiOx9DqUNHgYraCy/Qu4V1LDGMiAYPCaPHZTFWPoQd4Eq/Nv5VopFH7Sjeunm3InrrG6wDp/OgJnHjOurrVA9tkHCuYK6IDZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149846; c=relaxed/simple;
	bh=7909EFCZVzxjPNQLeS9dieFc1IzT7p+ZR9mSr68+ju8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1Fg127Nc5rc95h2xTCE1q+HyZqAAeEZd0TYI9Bp4233M3YBpfGfA5KItnTovUVVDduvMJb8/zPYGKvqH4BZO6dvTUY3/SyZ214Fjnragu8GeVQAxU7CO6SpxvYTSaYl4CKNfHZKR2TjEKnq45ZeW07kHnYEaocGG+RMh9zhtkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RU6FnU3d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M8gJPP006339
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CwhMpbCUhSUmGYknZGW4l46K5hlan/s+wby4exYafxA=; b=RU6FnU3d59ZvzKpY
	4DWnKXkh60vGriy933P5bbDd3t5oawKxsINkKmYu1sGtQNbnW0PYqEHtST31r0fK
	gUM7LyrhC6GvzM6wLzysjviDIUZlMgVe9yfjfzDiPSQpuYuhpIPpKRwG9tSanioJ
	oGQ0QA3LLVrtM6Gq+xmRAW3i1sZyhH1IAt4H0esXqGeA5bOlQoeyHotT6a1o/JRm
	jdZ9K/xVyUq7Bmpf5nwyuuXJN1aGi/oqNLW/rnJ/g5noDpGw4LDhPBZxDoqqz3dc
	liTXYzRAXOHbjIGiVP1UifLkHk6a0+N7pP+2XT7Kj1gjxakM0reQocmXPcUfBwp9
	L9DiFw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xkpsawd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:17:24 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-932bc3a83a1so41180241.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761149843; x=1761754643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CwhMpbCUhSUmGYknZGW4l46K5hlan/s+wby4exYafxA=;
        b=xFaeu6IySZUZby4usQiyS4Ugq7Yxw4Pr4w4tqUthMQboBBorWd4tn3cUeBDKPOE+6N
         lVCvxIJ/SsvXApwEIw5q/veQLzEhtZc2ttf1+mYUsn9NVL8ruMZu02rufdjlSCz8xBDd
         3xJu6bUmCu3kmjgdDoFD9270e7lBM1xliyKJ4wUKmkgfw0E3pXV43rT6Sk2Vp2CNlOFy
         MZXqehUYX5N5nh0rBO0IqaqhJUPVC5MNI8czlHFpwOHMakVP1yUi0TzZvHsaoBPQnKJS
         +6SYNaVoFRjXybshUXQDIZJHddGXfHACd0eOL5x9T+E3VcuhXWdmzyk5YxFRDbD47Y+p
         wCDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOb2kLmhLpn03kJztBlnUGfbLD/C23HfFOL86yZmuztQOkqANA12rrD3UxSOcP9KB8pC60d+1s6LaZoqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzArhUzjZW5LoYoYQHfEaKv3o3hQH9HKq6UOrvLg/aw6czhGzE
	NMYbtITQYg0P/l6gGHspU7/ox7zqUYOWJqdAleS2DtsKlJnT7KRnhBuNF7xn95Zr/nFzN8ETaWa
	pUTqrR5MKU/p7nxSRzrS63dhel4N7SmzDZvIjYENi6gj6Hm4AP6zvSoMC75Eop0XnNSo=
X-Gm-Gg: ASbGnctZUBUsmj69c/2zJbLBunHk0O43HMnBERWh94LfCZyztuaj2ZoawfnGYkviv/C
	KhMTD+Z80g/0QEg2OKIrfIai0dbXEBRrZ7vIi1rl19Ar71LhOHWyu9d8XhGbX2p0UZrcpHq1M6n
	sTpHR7ShQjIzCOSboawsDD0hMJqyk+qAJ1WEZ05E+V+gGXyrj1Vg2OsrQ4TSNlcqyatc19fk3To
	O6vi0x0MBiEfO4NdEkw5SLgW9CRVRZJH0sHMS4dTLSRi5wbA0u28nyg/wPbHasgUBatrvEW70/d
	yn4AnJh2V/RuXMfqEz66Dr/dF0owChAb11kfy4db4kY5c6bTCGROxsEFt+0mNjn/++/JHnF0JV3
	oOVgOFH5I40UzWhOeVAWgg7+2h/KjoOk6aZZ73hobBHddbufOQJ0qPRr1
X-Received: by 2002:a05:6122:5215:b0:556:9d50:7ea5 with SMTP id 71dfb90a1353d-5569d508084mr349217e0c.2.1761149843257;
        Wed, 22 Oct 2025 09:17:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXH8CkUOfdOZ/99j8RNVUBwBPGkhStJMi1yxgoQoY7YZCYd2Y1gb89wBcUB1rlBjWLIa0mGg==
X-Received: by 2002:a05:6122:5215:b0:556:9d50:7ea5 with SMTP id 71dfb90a1353d-5569d508084mr349212e0c.2.1761149842804;
        Wed, 22 Oct 2025 09:17:22 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d40790b88sm33202866b.25.2025.10.22.09.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 09:17:21 -0700 (PDT)
Message-ID: <13b8651d-c59f-4d3c-bdc6-9ce2b088cf48@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 18:17:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Fix shifted GPI DMA channels
To: Pengyu Luo <mitltlatltl@gmail.com>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251013115506.103649-1-mitltlatltl@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251013115506.103649-1-mitltlatltl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE5MCBTYWx0ZWRfXyC6T8G7As/k4
 jawOJoQyNqbuj4HctVwPa1wRMMd5x1dmPUs7C9bKdDMc4AmRJzhSaK5TXGp28JkxW3smNWaV7vg
 6wO2Wql5nIx1rpYmobhQyx0hD0cnQtR4FQT8dapVpK9CK8ks/X8H6BmMPJyovrqzmieh8FZ5iHP
 IcHaFBxJ+1yklcVV81nP6eoGAuyn/EljYRwBUccE+JKC/AcGGsmBulZGfh40OT6AKosiLGYtXnQ
 s2D1or+BPwZL3spKxucM2SsDEOwXvxtN0mv4ZoTcq4Jfwf0+gzSGKetnTDT0u6IzDO4Jhvgdclj
 bpj33veaQI8acGiOasZLLvHbxv/yEMlVxTFVWMJ5lmz36VG60oEq7TBAsMGLkQ1T49zXSZ43K+V
 6GF+DEDHcNZZyjpUUzKYPeckqo14BQ==
X-Authority-Analysis: v=2.4 cv=FbM6BZ+6 c=1 sm=1 tr=0 ts=68f90394 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=inrnm_oqOa-xIY2ww0YA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: wif6IhZibmSbxS6YkZJ7FFH0-RThZCve
X-Proofpoint-ORIG-GUID: wif6IhZibmSbxS6YkZJ7FFH0-RThZCve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510210190

On 10/13/25 1:55 PM, Pengyu Luo wrote:
> The GPI DMA channels in sc8280xp.dtsi are wrong. Let's fix it.
> 
> Origianl patch was rebased to the linux-next and formated to a new
> patch again later, then it got the GPI DMA channels in the new patch
> shifted.
> 
> Fixes: 71b12166a2be ("arm64: dts: qcom: sc8280xp: Describe GPI DMA controller nodes")
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---

Thanks for fixing it up

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

