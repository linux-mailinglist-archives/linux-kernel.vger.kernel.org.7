Return-Path: <linux-kernel+bounces-858121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8721BE90F6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4CF3627403
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196B03570DF;
	Fri, 17 Oct 2025 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EGgdHgrH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5BD3570CA
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760709008; cv=none; b=mmzkgoQWGpI4IT6UXDHq1yMs+t2DKXpL0PezaWR0H7G4yv73sLRdc+x1W4lswuUeQi5Jzzuzeg8yx/CBM9I+ihkZgrKnZlTmZ8fzS1RfnAVRK1QFmOQoxB+vVdTU3DHK+yx3USCMKmdjlJkQyE7mMQ8kk0vMvus7JRrerfW8YAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760709008; c=relaxed/simple;
	bh=jCBPLoxbTcXpoIwMI2KLBvHfzepQyipbiJBh3dpz68c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPCmjF2VYGI7ijU8zDLM30+YdI/cklG5PktNqEVI690PO8qmj3iCr0f/H4b+ii1jZA5P9s6b0Z9qBF++LO7KTcrrj06rRfKrs1nxRi8pcJ4Epz+tyFCruA4G6PePYx9bQvSMQB4cM0yzaTOadlnDA6nRDzZqr8CbE1C2Pq5Z8Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EGgdHgrH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H86ZZu020220
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZHoSt8IC5bzvZIWqy3/h7W7Z
	nm3mbkyJccsL7Jtnypg=; b=EGgdHgrHUeYOSzONZ1dvDgqvKZBzBXV5hNBuI4Rk
	PMWVOPYkR/Nh2baIuHd0phzSpHUdtMytajldPPvIN2RkAIyxbPbKI9rRDiy+fNLn
	Ig1A0QKZ/O16ppCMd6MAXE8MeSbZo5BxwGu9LVbbKER4UVYM5ZcnAB1Ow9+RezQq
	/IMAI9XcZlm4KelCMOqoE6J8cvsUKWgfsY6n0QXQEFHcEPgsLtBE5ac8i7ZrtagN
	PIQ2TuxHr8rfx/Zi3yxZYNLT8a71uk/QumF1Anew/duUbumGQTDYzDct41C5EiR/
	IPE/hocQLFWong6vYT9wtts9duqmoAdv8GCguTwm9AfG5g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49tqvpnt74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:50:05 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-818bf399f8aso93800996d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760709004; x=1761313804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHoSt8IC5bzvZIWqy3/h7W7Znm3mbkyJccsL7Jtnypg=;
        b=WXiN+KvidgfKNktprRdDIj3s+Ar5U88IiI9gZdG+TRDUbu9KLjKlMog4IS2EDGu3MG
         sSDWJaiGUZZ9ozYnvk7GOdzjnPdJBQRS2WCA65fQWiupp3w2psz2uwNtPvAdghzMqZzp
         MmrVHviR0tiXlWUISDtGGZ5iT8Mw0LGkrhp8hqAEMUB8j2mDI8X4qUoO/4E4etZhAlAM
         zJVjeadhOpVnH6klInyIaG71AnaiKO8YfaTlEnKo3/3VC+S6EETgpYBJg1wqiUU9lh/Q
         yeU3DhyErrHAd2ag0iAIVfrcFK5RQqILAdVJ06WG4fa2CTifiVfgvJPlNLkWNx76JI0N
         3q6g==
X-Forwarded-Encrypted: i=1; AJvYcCX1VCmPE7ND7BEMk82Atq8rGXrxyIeMxhfeHOJmN291qBl99u0SrwKm2XP+ZSulPbDRS43l76sDIGzDRpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5oB9787rBHAgs9vIDASEDAckZGP5mGxlvxzZP0wZhEc7xAIXx
	8wQ1VDPEkCRRRQX8hZX3d8n7s/dJgkI7Oz2VsBSmnbmgc62UdRy58Nbl11uTxIrk+qmBJvGmwBD
	X9TtlN/GU8HmWe7Rc4gx+vk+jrR9ZQxRQLGf23ZxpLiq2ErBrwX8zgMhKh7c0dJUByzU=
X-Gm-Gg: ASbGncuJwAhruyNvKim8Rl7i+tTDniyonH2imzYwnG/hOYv/RRuJ/KWd4IUBTjoWmn4
	WHqo5GS+9SL8Xd7EPZkw2jYX4cG2KG0GUXZkJN4Uh2ircwFjjvvxD8+/kBAhRd5cpqyjaXwThwk
	H7UvzKpP0+zI2oqT8d1/P0J4mpn64wGCAVMI/ae8rTuuFquI20NLp363Bn16is6KzcBhgoy8T0D
	4EJOr6WPSsX68D/3Ms7j7VDvvldQBeN8nPhKZvF53ByofWqXPRNEbTW+c6HyZRh+axM40oQiVBP
	MDeSz6pUOdWtAunThrXkPqwluWg2QHDvjYbX5aoOUYL+QQx0KRhBzUqEhJ3G4TOO7gG6SM+wG8s
	APoZK0YydYL+XXEhOzK1rxcfBWcslF46fo5/HNZAqIQocHEyxCYvbJoPSAfKYiIrTpUSd7a/lyr
	eYId3xMmHc0LI=
X-Received: by 2002:ac8:5a0d:0:b0:4e8:a8df:805b with SMTP id d75a77b69052e-4e8a8df895emr7962451cf.19.1760709004422;
        Fri, 17 Oct 2025 06:50:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqUsEYIEcVJGSkj8DFafEbyFH2GPX9JGyMRzPejQmO1qiuEIsTN6uOm85wuZR70D1tQtNygw==
X-Received: by 2002:ac8:5a0d:0:b0:4e8:a8df:805b with SMTP id d75a77b69052e-4e8a8df895emr7961881cf.19.1760709003805;
        Fri, 17 Oct 2025 06:50:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5908820d1f5sm7917522e87.55.2025.10.17.06.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 06:50:02 -0700 (PDT)
Date: Fri, 17 Oct 2025 16:50:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: Alexey Klimov <alexey.klimov@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: sound: qcom,sm8250: add QRB2210 and RB1
 soundcards
Message-ID: <kh54xgfvp6rypbvk7eyemg7zsvum2krhsyh6dqa5ck6zf3ph24@szxffcrzngd7>
References: <20251007-qrb2210-qcm2290-sndcard-v1-0-8222141bca79@linaro.org>
 <20251007-qrb2210-qcm2290-sndcard-v1-1-8222141bca79@linaro.org>
 <b0d9cec5-1162-476b-8438-8239e1458927@oss.qualcomm.com>
 <CAO9ioeVcqT_Yhvz-RMCucLtcpa4xCLrA+srM8Vy_ZZ-650ZQnw@mail.gmail.com>
 <DDKF9YV37ETZ.3DXIDZA4ZU6I3@linaro.org>
 <695ff482-ad53-45fc-9ab0-ad69d8bc89d5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <695ff482-ad53-45fc-9ab0-ad69d8bc89d5@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=aPD9aL9m c=1 sm=1 tr=0 ts=68f2498d cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=q5sTpNs5cBplgk-z1f0A:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDAxNyBTYWx0ZWRfX7398HjXYN1cj
 PTPoaJAkjkEXt2F3iCmdxCefp1RycmZK5DrC4VHFwucM93MsM8a5Jc06f+dmg/vEzu7wRkIeP8w
 qA/nU7ppW/nKa9MZ5eG7ySlTyIcqoKSVo4fbemZk0UsKM+Ftc0fJYoIPu1Ge7DFPvvVbFZjlrph
 gfDz2FLb+EWuUoKvtQVf48okc/ZWBQ+3nynlqqpLTBET8cjKI1k2OpkYt+n8iUUbh7g0Ix7264a
 ZJGQwGy/P2JlbHlYkHJygJcSDEIkTUOST4FnrI+hNXuKwhrHknhIwldpql16YJlz6cyVqB7ln4J
 ethySh0eNcgVhvjP8aa+UDz44Sw9PlNwXzO5ngeut1xASMHSra77jeHZkP3q0oMMu6HNe+Lxyru
 nJeXnzmrMxYaTmz637Nr+WGOoCQOEQ==
X-Proofpoint-ORIG-GUID: 7Zyort15e33nifpAGTU0dANfz-3eUJRE
X-Proofpoint-GUID: 7Zyort15e33nifpAGTU0dANfz-3eUJRE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510160017

On Fri, Oct 17, 2025 at 12:27:55PM +0100, Srinivas Kandagatla wrote:
> On 10/17/25 8:35 AM, Alexey Klimov wrote:
> > On Thu Oct 16, 2025 at 8:46 PM BST, Dmitry Baryshkov wrote:
> >> On Thu, 16 Oct 2025 at 18:08, Srinivas Kandagatla
> >> <srinivas.kandagatla@oss.qualcomm.com> wrote:
> >>>
> >>>
> >>>
> >>> On 10/7/25 2:26 AM, Alexey Klimov wrote:
> >>>> Add soundcard compatible for QRB2210 (QCM2290) platforms.
> >>>> While at this, also add QRB2210 RB1 entry which is set to be
> >>>> compatible with QRB2210 soundcard.
> >>>>
> >>>> Cc: Srinivas Kandagatla <srini@kernel.org>
> >>>> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> >>>> ---
> >>>>  Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 5 +++++
> >>>>  1 file changed, 5 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> >>>> index 8ac91625dce5ccba5c5f31748c36296b12fac1a6..c29e59d0e8043fe2617b969be216525b493458c4 100644
> >>>> --- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> >>>> +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> >>>> @@ -21,6 +21,10 @@ properties:
> >>>>                - lenovo,yoga-c630-sndcard
> >>>>                - qcom,db845c-sndcard
> >>>>            - const: qcom,sdm845-sndcard
> >>>> +      - items:
> >>>> +          - enum:
> >>>> +              - qcom,qrb2210-rb1-sndcard
> >>> I don't think you need rb1 specific compatible here, unless there this
> >>> is totally different to what the base compatible can provide.
> >>
> >> Why do we need to deviate from other platforms which declare
> >> board-specific compat too?
> > 
> > There seems to be now a few incompatible suggestions for rb1 sndcard:
> > - make it compatible/fallback to qcom,sm8250-sndcard (1);
> > - make it compatible/fallback to qcom,qrb4210-rb2-sndcard (2);
> > - add separate compatible/enum for rb1 sndcard as qcom,qrb2210-rb1-sndcard (3);
> > - add base compatible as qcom,qrb2210-sndcard and fallback
> > rb1 sndcard compatible to it.
> > 
> > The latter one is ruled out because base compatible should be used and
> > it is not going to.
> > 
> > As far as I can see the last addition went simply with (3).
> > Which one finally you all want?
> 
> Am fine with either "qcom,sm8250-sndcard" or "qcom,qrb4210-rb1-sndcard"
> as long as we reflect that correct driver name in machine driver.
> 
> traditionally we have SoC level compatible which works fine for 99% of
> the boards for that SoC, expectation was that if there is any deviation
> or board specific changes required, this can be accommodate using model
> information. am fine with board specific compatible too, however am not
> okay with both "qcom,sm8250-sndcard" and "qcom,qrb4210-rb1-sndcard"  or
> falling back to another board compatible for various reason one being ucm.
> 
> So 1 and 2 re *NOK*
> 
> I hope this provides some clarity here.

My preference would be to follow the established pattern, unless there
is a good reason to deviate from it. And... it seems we have several
trends there.

- qcom,SoC-sndcard (with possible fallback to earlier SoC). 35 usages
  out of 49, including the recent ones as X1E8, SM[4567]50, SC8280XP,
  QCS8300 and others

- Two users of qcom,SoC-qdsp6-sndcard, let's ignore them.

- 12 users of Board-specific compat string, which includes RB2, RB3,
  RB5, RB3 Gen2, FP4 and FP5 (and several other platforms). Some (3
  SDM845 devices) of these devices use an SoC compat as a fallback
  string, which adds weight to the first bucket.

The "winner" is obvious, but I couldn't help but notice the lack of
generic approach (and yes, before i grepped '-sndcard' I was under
assumption that the board-specific sndcard is a recommended approach,
looking at the boards and phones I cared most).

TL;DR. Alexey, I'm sorry for the possible misguidance earlier. It seems
this device should also use a generic name "qcom,qcm2290-sndcard" (or
"qcom,qrb2210-sndcard").

-- 
With best wishes
Dmitry

