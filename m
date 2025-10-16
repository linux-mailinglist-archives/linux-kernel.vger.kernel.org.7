Return-Path: <linux-kernel+bounces-856182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3361BE356E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371B454251F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA6932D431;
	Thu, 16 Oct 2025 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pqSGRYDU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0237B30648D
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760617365; cv=none; b=XQ1j0PCkHHoCi8HGa7nLEQoHtcFE8ZF5fxzeqr6jWJ4u1wC6xAUnw9EPX81ynrKh9HU9XR8va7ke/NWMC4C3yeK/MAvL2Q7NVplghDrkUP3Ftfa5RHWBT92PDGz16WA49d//PUtxbk2pOEmmbxnA0eVQSt0lrFG23NRKsKWFKwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760617365; c=relaxed/simple;
	bh=mL3AkCdFjfUQDFlySMvWUslbbK6AefBEqeQD4tfNbNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTRVV+wdxkBDM7r0l/ktcXxOpDo7S0lfu97DlgdesXPI+7JRnEGtw1MZXvhsV6hpVukVkQFe4AbH3oN1xjauSWzoKR9L5y9K2lfsKJCt0EdsdFmSEI0gU5S/zA8IHYWtlZuQVV+lvkbxWdmNUY7PqKGAgYjE+kD1P/fJAjxd/ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pqSGRYDU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G758qR015270
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R9yQUnMu2HxE11HdeoAr8BU2ZwERrUip4hDHAbjMAn4=; b=pqSGRYDURFh5ETLu
	QxCj9Wj4Oj78wq12XoZq1sFMnC+NS0OROrZjGVGckFJd3k/60Zpi950reha6JZOd
	qWBYVZoD1lWOjW5GDkfCKi0P3Jk1GvNhWqk0mmH5XyjRwClsT3sF/OrzWn0GK4xv
	GUN6vmTBiLZ+qyCiUnhc4v6JLS9l+Uk1LIQI/T3NIK5F0XEwoXkh31GAyMeLsVG2
	jmPb5MduYt5pqujQzb7k83aoEgK0W2BcFX5ZI5j1wIinyBN7imPjw4SLKSNlopc+
	mwD/QMLg2W+Ip86t9vYkX7J5mWUrTZ7h/jKQvWGdo2HC/T0rYd6CufsEkiJSIpkM
	9hprBA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5rc5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:22:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8635d475527so301392885a.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760617362; x=1761222162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9yQUnMu2HxE11HdeoAr8BU2ZwERrUip4hDHAbjMAn4=;
        b=gl+nuh5ybv9RRUKonquFbSR4l9mb/Bhg8jIo9U/2PNh+LFfVrgderMmPb7BZIZ3gzT
         OztwHL4GH2jZLTYq2CxWxqrbr/rJpV21k7v91T7ngwDfN1rWBzZGvc47wVrf6l9v6/6G
         Gg7wyGoIZut74h8Qac3ogN+Wq0cbdtHPvkHMtMuNB33djWdtZ6Vv2xGBOPcgCOtnDscX
         cMZ7bVXcy0NHm802uITgUdJSkd+S8pI+u2jvYP7+XW0jrhcZL9HkW2zB2Zw3+FR/GE9c
         Mo7hBzvOiWkEs89SBIux7OCynWircVHvE0L9PvuSdgu4RqW3HppV5PRjC0ZeboM5rUqP
         Dq8A==
X-Forwarded-Encrypted: i=1; AJvYcCUJMzckBbUFRp+mShXiD75kv8RJPP5w3RVhH1yXRTUJaLjYuwujXABCmNrTqXHygmjzrK0UaP8nW/USMJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyai4F6I6BO3c//da/TleNxPjt9hPfG7E419CtjVGICe7a87WHb
	NiFGjOTseJ4Z4yJmOeiNxvC3VisBNs6ZXllT3QTMjbqT/dNFetNKgJRKIyo2KW+rnv/I8tJaBCK
	khQw7GAqZGnE+14CWf1FL2548qU3bGohanJDKzONw5fQIjggARtqz5RTAKaR5Ai79GpWV3QWOal
	i7hIYqcYACXw1Kl5zSfjhdKpW683z2GZSgtxnZS2k9Mw==
X-Gm-Gg: ASbGnctgYPQpUKDIAv+Jw6ULTvlv6aFXmlURr4UCgyDD/E2bD9fplb8aBLLfq1HUCvL
	7auANmZ/bV6Q+BEoB5IuF1MK1O73YRZwtWNV3BLZ/oV0/g/osCjUiJJ4xupP0e7Ts1X3n2a84WU
	hAg9m8DXnP8eVx0B/I/tYdosR51eHgxn5oenqLl3D13/QhNKV/4KW7QDY2x0/RLw1Zu9QkfoDr0
	Y+Y3cTFNYbiAiHa
X-Received: by 2002:a05:620a:4502:b0:890:28c7:f669 with SMTP id af79cd13be357-89028c80073mr58576785a.30.1760617361804;
        Thu, 16 Oct 2025 05:22:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnZMb/cYhHwHiWYZwoXQy2OINpsvIKqNRNCU3Ket2voCC7bfHOUUrKU4B139SqJ5kxiGE/2fuG+XnMoA4Crq4=
X-Received: by 2002:a05:620a:4502:b0:890:28c7:f669 with SMTP id
 af79cd13be357-89028c80073mr58573185a.30.1760617361345; Thu, 16 Oct 2025
 05:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014-add-new-clock-in-vfe-matching-list-v1-1-0d965ccc8a3a@oss.qualcomm.com>
 <9984bc23-05ef-4d46-aeb8-feb0a18e5762@kernel.org> <bc0caeb8-c99b-4bef-a69e-5ce433e6b890@oss.qualcomm.com>
 <c4fd6bfc-cc9a-4f37-99b3-f36466691a1e@linaro.org>
In-Reply-To: <c4fd6bfc-cc9a-4f37-99b3-f36466691a1e@linaro.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 14:22:30 +0200
X-Gm-Features: AS18NWDp6vazgiHxY7kgFcW2LE3xKj8UU2r34EGJpIgpnAkFsDnwm-UZKPSoRe4
Message-ID: <CAFEp6-2=GJL-gc+PSyAL4=prp_sXdZJS=Ewg5nP2kcp_Gu85Fw@mail.gmail.com>
Subject: Re: [PATCH] media: qcom: camss: Enable setting the rate to
 camnoc_rt_axi clock
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: AtgStfj7Vnpua7TIxoKVUsZQK-IDFVj4
X-Proofpoint-ORIG-GUID: AtgStfj7Vnpua7TIxoKVUsZQK-IDFVj4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX9Yv/dSoYRdLz
 HYro8VJVZ6YB44QJjpiFZoTqK5YJ5fuQ7GrWQgF3wA8mKQnD6OQIPgeDdlkx1LXWf9vToJRrpdk
 +5iaEUXHhxfiWF0XhLH8FeZPPWbLosKXTy5Mpa5SWX2ER8cIxjKyHZrSradMPQfVwW8vAjjW0/j
 oe2tz4sU9/FNScTCm6NEQczEtRSZsAMD6K9jIsMGUYh7bU8dyhWShY39jEpkVhWM29UuLXcuq9j
 pgODFNovY+HAUGSWutD1YI3ddVGovbX0EybyoH6tfTls6DlFG6iCSwEFakQjdaNYAAWCjDfnp0p
 8p9/Ar9eqGr9j7ZW/H1CqbdCq8cG6NMDRrVccjJIWfDOz839S/zQn2AzVCd07PF/x8QrBnPZ7xE
 I/Kwf93YNSwfZr1zTYeK6VB4FIumsQ==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68f0e392 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=p_FccyrFFb65Td8MQdgA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020

On Thu, Oct 16, 2025 at 1:50=E2=80=AFPM Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
> >>>
> >>> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/=
media/platform/qcom/camss/camss-vfe.c
> >>> index ee08dbbddf88..09b29ba383f1 100644
> >>> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
> >>> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
> >>> @@ -914,7 +914,8 @@ static int vfe_match_clock_names(struct vfe_devic=
e *vfe,
> >>>     return (!strcmp(clock->name, vfe_name) ||
> >>>             !strcmp(clock->name, vfe_lite_name) ||
> >>>             !strcmp(clock->name, "vfe_lite") ||
> >>> -           !strcmp(clock->name, "camnoc_axi"));
> >>> +           !strcmp(clock->name, "camnoc_axi") ||
> >>> +           !strcmp(clock->name, "camnoc_rt_axi"));
> >>
> >> Just use camnoc_axi for both. Look at your bindings - why do you keep
> >> different names for same signal?
> >
> > I think the correct question to ask is:
> >
> > Is camnoc_axi going to represent the other (NRT) clock in this
> > setting?
> >
> > Konrad
>
> I'm - perhaps naively - assuming this clock really is required ... and
> that both will be needed concurrently.

AFAIU, the NRT clock is not in use for the capture part, and only
required for the offline processing engine (IPE, OPE), which will
likely be described as a separated node.

Regards,
Loic

