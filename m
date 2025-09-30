Return-Path: <linux-kernel+bounces-836956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A930BAAF85
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD681899100
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07C8217F55;
	Tue, 30 Sep 2025 02:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RGqRDeQo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D791A0BE0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759198614; cv=none; b=BiiRrwZuZdjnS5KIZqIY0T75N2+MwDZNvfGt26wLZCbP7NKspvJhqzPkCDiTKx+jfsZXyBzGO/sXohCeWsFgyoYSmwAtjCy+adXxl+SZl4aowccgP+rPp7mb0z79W+kkQdQIqrzf6O/6xczzinDBDai5z8yUPzEcOl7Zc2cOGdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759198614; c=relaxed/simple;
	bh=21SaBppvhoYm3MnCn96Cnpw2B6ZqkLsNbRgMbfmBctY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6TJdsdLc1TsamALT6pNCCY8N5JbwmyMRuzUb6zy/FQ+iknQlt5T4JeMnJ/cn2iaHB305nY0AtoOgB20sajZc/1v1X+39GgzxqimB5/KRpbWr6f6msoVa2FI/UK+99dQdKd+f6/Apel/+hvUf2MMlgD2Q4Uxx8a3vWJl59aztRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RGqRDeQo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TKJfv8007833
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EpRYE8JB5wOHIWCplP2YYkrL
	MLI6jF9QH0JCFW4aHJQ=; b=RGqRDeQoYoRDXSy+tuFQPQo0sRI8wcwPFAH59X2h
	QpKbXlGc4ESEEy+CGIGqUDzFbTknXYWs+w1hiEQc75sLTjd99OExVsHfc/qv/0QO
	56WKcudPQS7jxgAmi+8usXLpVgN5LsHCd86ZmEmTinuZBlajEnzkCswglcye1Yyd
	KV2tmDEkANwzQ6wkk2zRMkQODkNYjTt5cvqfm3qYwW5eMZiDLjrMZC+iZLgybcV/
	ZiJb+rrgROlg8XGha2rkEOqHv71a9t42l+dIRZ5SBWyXom/sgjnTE21Kq52Olvlp
	hr5mPC/KgSyFTZs38sUuaS1xwpZpOP9XMLNyfC/NkzN8gg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8pdf3vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:16:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4df22892603so69937221cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759198609; x=1759803409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpRYE8JB5wOHIWCplP2YYkrLMLI6jF9QH0JCFW4aHJQ=;
        b=GcBn8RJ72YYbLmtsKfmltZ8pTbOBLTCmKnaToI58ZS+b2WcO+3yJeDGquHhedeEoqn
         JmH6soK1VFsvxYcZi+Z9j8k7TX2hkyfyGGhf3/Ja0yD6+WgsTT2pu/BVS0Y9Wip1gLgR
         RBxMsT0rleFof8kR+uOp6MZw7RdN9gs9xTEJKfauh29cXV5JEzjdAURMEaZBBV0iy5N4
         WMXNWTCQdIyLdEf2UipEMwAPszTvNbOAOyvjKtOFSD7JA1eRMopwqvi6m4ANo3rEYv9V
         bx/2yn5EFuZhAoeuV75v8EvQPFa/aSByc+Iivti8z7cKShJnPK9UMsmX/aoZjDqTCoRv
         +xEw==
X-Forwarded-Encrypted: i=1; AJvYcCVRpVZnGmB6fuB40VNjk+uB4s5Un1z5NToF+0v5N3WG2oN8njSD5xy/P3gBJkgqDpsC2GcCnyH4ttACWu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLVBixP5n5rLcTY+bbg/CBP+ptk+sFleFU5s4QZNRz+3pnmNbc
	gvZ/dzNxTRAvYzajlPRR6PUSRysVN3X/gWPZ7ontlQvaQMAyL244MhUCZZEUtSXFyOFEEjRR0MB
	NpsmCJ9cCFuB0qiZklYTkcuqeNIFG3uO/EBABqmUH/LSTH7XyluoqPV7DpvKczkLRLI0=
X-Gm-Gg: ASbGnctSJz3BNQszfzVLBvBPZVoVqrxQpk1+7+RR0MOcbLfwTyVP7diLV416fxsQUJo
	W/JbrzTShGrynHy7ea2m1u8kNKqQVM7PUy0cRKSAFUFDTogvSu08JQhkOnaabVgQtrhULkvQbx1
	IBBevXUUcJKDWMdBaXuQxMvVHy1Dp6IqFRuRFvMXImyz3MnaoXD99voo7e/zO5KSGDnyrMj5GxA
	MDOBD6cpmQ37LS4OdZKmWkxY4zj0Gkrxz35Eed0kNZihh0QEONMwzMeVbo9R/yreQFuXGrE88qu
	DL+14H/L3SFFOk4rOhgmG8Fd73GEEiRNCzCoMfZKbf+87tTU+cCBFbEbmDdU9SE7WTy0sxsDjNV
	mahkmyDGokyv6oQlTgzy0tDjYu0NuGJISD59SVdVusgf/waqhRQbrKjCCWA==
X-Received: by 2002:ac8:4797:0:b0:4e0:af0c:3bb3 with SMTP id d75a77b69052e-4e0af0c403dmr58036831cf.34.1759198609375;
        Mon, 29 Sep 2025 19:16:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGterR6y0O+00+8Kq4SBKiwHf5nookl/f2koW62Wj72rv8Zfqao07AOMZ/USSyZrS8CxJu0HA==
X-Received: by 2002:ac8:4797:0:b0:4e0:af0c:3bb3 with SMTP id d75a77b69052e-4e0af0c403dmr58036591cf.34.1759198608931;
        Mon, 29 Sep 2025 19:16:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5831665791esm4579711e87.82.2025.09.29.19.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:16:48 -0700 (PDT)
Date: Tue, 30 Sep 2025 05:16:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
Subject: Re: [PATCH 1/6] dt-bindings: remoteproc: qcom,sm8550-pas: Add
 Kaanapali ADSP
Message-ID: <lu5lwd75lfs463co5v2ynhjvmircqowchad4s6sboj3valgteb@6mg5vqgukdep>
References: <20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com>
 <20250924-knp-remoteproc-v1-1-611bf7be8329@oss.qualcomm.com>
 <h4lk5psnwx3ma3um2sozhcdccwhmgmbje2lgjks2czcrzn4mre@svtnbyzvrivw>
 <d374036c-1263-42f4-b9ae-13b21427b01d@oss.qualcomm.com>
 <maeobo6qukgzn3acwtvhfrvwrfwo4q5pzspem6htbybr5xuwlm@opagojsav6ey>
 <4a25e085-39f8-49dc-85c6-7a4267689dd1@oss.qualcomm.com>
 <go2koxtabrktc2noyrgehgeddavvsdz6qu6bnwkzqtnb2k4du5@3m5le25bfmpv>
 <0209a062-2763-4e50-adfa-3cbdbb35eaef@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0209a062-2763-4e50-adfa-3cbdbb35eaef@oss.qualcomm.com>
X-Proofpoint-GUID: KKA_nGdQOc5w80DFjyGXG22QjUPcLjea
X-Authority-Analysis: v=2.4 cv=MYZhep/f c=1 sm=1 tr=0 ts=68db3d92 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=LzvSPlCvynhhbaACvNEA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: KKA_nGdQOc5w80DFjyGXG22QjUPcLjea
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzNiBTYWx0ZWRfXxF34IGKIGRtv
 2eoCvqhgksCtHDev/D0NncDoZ65bB/lXGhwbWKtbcy5VwjkjcP3Ujj+nmHmE0GtELXyhD/+fOnl
 llVvV7eQLB7dY8JHvmckYi1FyxqfqIvVRS1onxarizV0voiAHw66G7TBEeQW9PbVT1KpboanixO
 YexiDRlf0+j6sw2xvkgerQIpEvxKLaeamKUagpTWoOA3IrfKSU01YMpjjwmApZ3z84eKUmtZn2B
 pOtPYFNg4d60xYMRqFxNnM2O/sZXCORmRSEjlqu9K+quM4nkkmALOgcFzXFJNGndShw/itDDPcD
 VXNXHNLrTVK4q4So4OG76bJFsOgqXbTjGvL6UId0fue205vcKlVhL575/HYXav48EDrBKyJnEgK
 984D7ot/NZLSOGGdoS0E9i9PHcY3NA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270036

On Tue, Sep 30, 2025 at 10:12:27AM +0800, Jingyi Wang wrote:
> 
> 
> On 9/29/2025 8:22 PM, Dmitry Baryshkov wrote:
> > On Mon, Sep 29, 2025 at 06:11:23PM +0800, Jingyi Wang wrote:
> >>
> >>
> >> On 9/29/2025 5:39 PM, Dmitry Baryshkov wrote:
> >>> On Mon, Sep 29, 2025 at 02:06:11PM +0800, Jingyi Wang wrote:
> >>>>
> >>>>
> >>>> On 9/25/2025 10:19 AM, Dmitry Baryshkov wrote:
> >>>>> On Wed, Sep 24, 2025 at 04:37:22PM -0700, Jingyi Wang wrote:
> >>>>>> Document compatible for Qualcomm Kaanapali SoC ADSP PAS which looks fully
> >>>>>> compatible with SM8750, which can fallback to SM8550 except for one more
> >>>>>> interrupt ("shutdown-ack").
> >>>>>>
> >>>>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> >>>>>> ---
> >>>>>>  Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml | 6 +++++-
> >>>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
> >>>>>> index 2dd479cf4821..be9e2a0bc060 100644
> >>>>>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
> >>>>>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
> >>>>>> @@ -28,7 +28,9 @@ properties:
> >>>>>>            - qcom,x1e80100-adsp-pas
> >>>>>>            - qcom,x1e80100-cdsp-pas
> >>>>>>        - items:
> >>>>>> -          - const: qcom,sm8750-adsp-pas
> >>>>>> +          - enum:
> >>>>>> +              - qcom,kaanapali-adsp-pas
> >>>>>> +              - qcom,sm8750-adsp-pas
> >>>>>>            - const: qcom,sm8550-adsp-pas
> >>>>>>        - items:
> >>>>>>            - const: qcom,sm8750-cdsp-pas
> >>>>>> @@ -95,6 +97,7 @@ allOf:
> >>>>>>          compatible:
> >>>>>>            contains:
> >>>>>>              enum:
> >>>>>> +              - qcom,kaanapali-adsp-pas
> >>>>>
> >>>>> This one and the next entry are redundant. Do you see why?
> >>>>>
> >>>>
> >>>> This one describe the interrupt:
> >>>>
> >>>>   - if:
> >>>>       properties:
> >>>>         compatible:
> >>>>           contains:
> >>>
> >>>>             enum:
> >>>>               - qcom,kaanapali-adsp-pas
> >>>>               - qcom,sm8750-adsp-pas
> >>>
> >>> It's still redundant. Don't you see it?
> >>>
> >>
> >> sorry I didn't get your point here, could you explain more?
> > 
> > For you device you have two compat strings, kaanapali and sm8750. This
> > schema block is covered by 'if compat contains sm8750', so you don't
> > need to add kaanapali to the if-case. You already hit this check thanks
> > to the fallback compat.
> > 
> 
> Hi Dimitry,
> 
> our device contains sm8550, not sm8750.

I should be reading the patches more carefully. I beg your pardon,
indeed, you were right.

-- 
With best wishes
Dmitry

