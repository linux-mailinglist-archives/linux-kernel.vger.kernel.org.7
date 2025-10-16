Return-Path: <linux-kernel+bounces-856860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689EABE5463
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230E3544BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310562253EC;
	Thu, 16 Oct 2025 19:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SLNsYwwc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCEF1A9F83
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760644022; cv=none; b=d6J67516OZZzpZoFRQV665091hEMQArEY2HTkQ3NAJEvqdoKWgHMFnrII+ygbIRwoR1+UZGsGH8VAYYKDOYsV8vAjilkg2pzCRVzlgzZoL2pn+JJT52AmnYRY0SEyihCASJlGgtJQi/cPLSSGYTdGzpD3DN1z2x/As2gi033FyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760644022; c=relaxed/simple;
	bh=jvlhrPfLoaKE+znZnAg6r8knLdLXlgFcqxHMO0uJA10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOP/gckIHA/ofyBGPA2ERJwbXEpUN4oNFxW9G65HlOHPC058BnT3H5rlMVdMcMCioVfxwczhBZgh4vHTGvEIDhx3gY7o0QtWjvA1JvsUMfgQ1ytpArY6GDtV5BvEnRXKSogpQxogyLe+rH5oQHlhD80rsuWxSEmCMMbOAuVoxnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SLNsYwwc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GEQuGM024854
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FQdOp4yRQVIe5mJRI1HmxzqE
	p3FgqjRI7/wz4aB2n3E=; b=SLNsYwwciUb4CPDEmwwkxK3V2+EMXcPwbbRYAt7C
	9kwVHqkfGv78RLnlLs0ADHupW1lFhQxftN6i8RPPPfXW6/F72v0JjeC7UWRqMwfW
	4qSuFg0NWlZqbUyejdiYPeqkullZuW1RWlJuj7HS3cYTFJ2s8GP3DutUZQBLz/Cb
	PC24Dnpf83tYLYjwBb1tVSTXABMqTPIzGR3jHRq4Quu1ht8C+82si+2kGgY95Nw8
	bEJMsdSsGYVnzK54xJHJt6ioTGH0J3EEHXwhhqRR/79d5fTGrHV8c8aOozFurxIN
	cpO+xt6h0pU2d9I8ZPnnWLWzb+aU8gbsoY2pfCnPzKFZJg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff11ju0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:47:00 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33bcb779733so416621a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760644019; x=1761248819;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQdOp4yRQVIe5mJRI1HmxzqEp3FgqjRI7/wz4aB2n3E=;
        b=f3ucSxdgep5o9RsEcz5FTGV73HTpZCyTWzVNF9SZg/iPTRA9J8vMwsmohdFAiynbmZ
         EgDtivtFZ3yha/EspG1lwy7RgvXC3b7hOK6blERAwfh/Dk6t57ueIv8dzlGKCw+I2jpi
         m0TlCGnVYYwNRhzeO9L62YURo3v/VgjPXpz6+2+Yyj4X27w07SBIfzuUkgnkZk/+oyRZ
         ROqw87M5djT8CU07WfXRUtpDOVZc1i4nZ0f3iOTxIUS4cwPqqCRrQpJaTR0VVzYR6A1S
         x3nE7stGz6DXKVTnJOJ/S6dFECNkblOv5cfKgWoM/S21ATmcMPUSNCP35pZBkAwtULqz
         vvYA==
X-Forwarded-Encrypted: i=1; AJvYcCW5MYsRSpmzXomLNg4PH3mIOlOuPK95jBmYeRhgYCxh86tfMqyKDE0Ppgb/pN5bsMxdZDXeLpbNKjNmOSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsbWG3j4U6ebHAuIhKEpvPrq7rnj0gLf51JpBR9qblzpu454Tx
	swK61gVWpINMv62MYminut9S0btDqyyXa2pR1B29mMg91+Um+ys3C0/5sB5Zeti0ah19P/7ZHh4
	sgLBPuqHE44wvXsWyuv0a2rxXbLWRoKFh9olytI+GtVu+KuZxLgEMAHrawNLtit+X+qfOsztzsC
	ueCOkTD2FzAmiVtaUtqY0RXgrEdYwu9IXKkEraEXWN5Q==
X-Gm-Gg: ASbGncvFuBjqinbE+NDvN/aP7jolEsPWw+4HNdYgGCL8xhV61TDZK2r+JmTRD0fmWnz
	56BahTmARNfXYmyz/Eoc5HlQMNvDMTB4sGT652a/qW7JAdZ1C4DVKDEJGnOYcNdAijumdIkH1xm
	sSO2PYwz6PbCPnDoKzUA+nWFFR+XwFRmvxdDFOAAba3Swm0oFVGK9DypBr
X-Received: by 2002:a17:90a:ec8b:b0:32e:d011:ea0f with SMTP id 98e67ed59e1d1-33bcf8f7280mr1059341a91.25.1760644019432;
        Thu, 16 Oct 2025 12:46:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC4rtVaiUiGDeFxR64+47ex7+DNGbOtDuTWAbWJtoo82PY848HLitx3BoRsLxEASeMxNul/mWzFeugUy1bWx8=
X-Received: by 2002:a17:90a:ec8b:b0:32e:d011:ea0f with SMTP id
 98e67ed59e1d1-33bcf8f7280mr1059315a91.25.1760644018924; Thu, 16 Oct 2025
 12:46:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-qrb2210-qcm2290-sndcard-v1-0-8222141bca79@linaro.org>
 <20251007-qrb2210-qcm2290-sndcard-v1-1-8222141bca79@linaro.org> <b0d9cec5-1162-476b-8438-8239e1458927@oss.qualcomm.com>
In-Reply-To: <b0d9cec5-1162-476b-8438-8239e1458927@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 22:46:47 +0300
X-Gm-Features: AS18NWCyJN1GPmN84_CNi0rIoG2E5eLZy2zgaxscoNNGFNo_QUpMlqJ9UvpzP-s
Message-ID: <CAO9ioeVcqT_Yhvz-RMCucLtcpa4xCLrA+srM8Vy_ZZ-650ZQnw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: sound: qcom,sm8250: add QRB2210 and RB1 soundcards
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: Alexey Klimov <alexey.klimov@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX42oG3AZ7hyOH
 SJ9uHG73UWAReKxUOUPi88vMGuPVIvneks/IMsSmHh5cy96iObRoaGupNQDelHZgfB9OWFVjeRX
 Sy0b3u02p3WHc+nO48xYvG1UVJO9Hu9TnrOf2JxE4WKrDPaAU/GK0U9gjyzT4e2hxt5rqmkABkn
 stV0jHEK+ygd34Me6w7JL8BfzImG+3IkT5yeuh9QS7NdkZv1+UDH1CHiVQy4rcxLocbVXeQT6/u
 P7KaXDOeUwW7alEf6yk3mXwNYcCeex9Gx9BEV3MkfT48EobrJI0KxgZONiywKU7Fqg2tWN4FvCl
 koEuonooEPXzZfXirbiKFUzg2jIQHdgB2keitwmTA==
X-Proofpoint-GUID: ooLt44rlpasFKx93zhPfkCFl3q9ABXIq
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68f14bb4 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=HGThU_-lZqIAk3PbLksA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ooLt44rlpasFKx93zhPfkCFl3q9ABXIq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Thu, 16 Oct 2025 at 18:08, Srinivas Kandagatla
<srinivas.kandagatla@oss.qualcomm.com> wrote:
>
>
>
> On 10/7/25 2:26 AM, Alexey Klimov wrote:
> > Add soundcard compatible for QRB2210 (QCM2290) platforms.
> > While at this, also add QRB2210 RB1 entry which is set to be
> > compatible with QRB2210 soundcard.
> >
> > Cc: Srinivas Kandagatla <srini@kernel.org>
> > Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> > index 8ac91625dce5ccba5c5f31748c36296b12fac1a6..c29e59d0e8043fe2617b969be216525b493458c4 100644
> > --- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> > +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> > @@ -21,6 +21,10 @@ properties:
> >                - lenovo,yoga-c630-sndcard
> >                - qcom,db845c-sndcard
> >            - const: qcom,sdm845-sndcard
> > +      - items:
> > +          - enum:
> > +              - qcom,qrb2210-rb1-sndcard
> I don't think you need rb1 specific compatible here, unless there this
> is totally different to what the base compatible can provide.

Why do we need to deviate from other platforms which declare
board-specific compat too?

>
> --srini> +          - const: qcom,qrb2210-sndcard

Broken quoting

> >        - items:
> >            - enum:
> >                - qcom,sm8550-sndcard
> > @@ -37,6 +41,7 @@ properties:
> >            - qcom,qcs8275-sndcard
> >            - qcom,qcs9075-sndcard
> >            - qcom,qcs9100-sndcard
> > +          - qcom,qrb2210-sndcard
> >            - qcom,qrb4210-rb2-sndcard
> >            - qcom,qrb5165-rb5-sndcard
> >            - qcom,sc7180-qdsp6-sndcard
> >
>


-- 
With best wishes
Dmitry

