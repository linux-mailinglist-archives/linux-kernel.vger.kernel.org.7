Return-Path: <linux-kernel+bounces-893333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65107C47197
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E41F3B5E46
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4638E3126C5;
	Mon, 10 Nov 2025 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gr/BdksQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G2wfs4g0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F933126B7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783577; cv=none; b=CXMxxZoS4qSHF6GU2rn9uHZyiXuDVgEIsxszw+4UoL3WfRb5ZRHah7xtOJWTskAdsugIb/w6HGzJ/dzHSZRNKjAEgPMDKUvqk88X2msDJ/h1MoAwmGC5gpPdomklJmz6dhnz5dIwbvxlkAQeXJILwWHm8lDmWwrns8LZQoKtuNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783577; c=relaxed/simple;
	bh=L/CmvJYCyYfrJvD22vpA92Xdgu8gpWQ82QXdZUA9Vz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cd8zdZr4VOwkv/ef6GOgZWCvYfGwWoHL+ex3TImtzAWdxkDhjXDzaN7EeQgaBRAT36/L2Q7LQ9D9e7zHdZOAh9XpmE6gHjPdhKw0hwp8PT/zPmG8ezcWhNzSCExlJ3Fk7Z4BQSwtJS0zsePi5zIZj8bxK8K2inv7xEY8MfwML/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gr/BdksQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G2wfs4g0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AABZpWl3271842
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PUXRgMzr0O6XUgHM9OyGr8SqbOOjNjkdqNOeZDXnadI=; b=gr/BdksQK+r5Br+N
	S4urR3GLlEvoohCwwxlyiz1AVcTHVzu20BTfThsupKInBX1hT+Vri03YGUz5z+BH
	X9k+wlHlRSPZFtLb7VvzcKQDXbEuSy7QsySywxs06qVdui7PYfmtbE8Khq90afVg
	fwgfSRIYCrrG/jI1DyYlfVbE2zNcxrDoT6A4A49O0aXGt5RYbguaHKKuvKDadKB7
	DpWRd9IGQgS4AnwvPbF4vI4+K7uCrWCj6NFdrRgfpAR/uU6GnR5gzdJZTNomvs9L
	wwrZq8JxP1W2NNpGocNfbQFhBulX8DFEmyfBzKwYDopDkqfLB7qTXfOtkacs0L4Q
	Wkx9HQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abfafrcyx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:06:14 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-bb1875e1416so1269718a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762783574; x=1763388374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUXRgMzr0O6XUgHM9OyGr8SqbOOjNjkdqNOeZDXnadI=;
        b=G2wfs4g0QnmH+BgKnZlEjVrT7JIW1UDCXs3ZjFz5okHuY+G0vYw7IhsJ8mf5RHQdYM
         kYDE1rp6tPi5IirrqN9UfllIOKSURW03uaSCPG/aIsLRnLgIxy/8zCnH+HCXqSCEHFrt
         moO0ADHPYh5FyyGXeb8Q+ZFwA0onjVsrZAR0EPI7bDrNZefE5JJg3xW0kE37ZNEDJdw1
         mR2IYLjcpQgM25Pk/fYobRriPTnvT4qYZQ0bdePlLBYB3P3gdPQFwzCqAy05bofzydgT
         0aXQ3Crx82/YYlJe1CenvVxOSTyy7GYrmru3Uu5izNfwePAWGyoskibfgIqVV+OQK9kp
         7Lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762783574; x=1763388374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PUXRgMzr0O6XUgHM9OyGr8SqbOOjNjkdqNOeZDXnadI=;
        b=xBc28HV9BWJy/IxPbolMemJF1RXkbXBjyUlfQtpVM1U8G013FahScNhQHO5w1Kdmgz
         JDjW+Fb/tAzt88U0c50RM6YjrqjcKqtmm2V653AMrmS41d6slUos5KcR2KPu2oCkYMVQ
         F+n1wPkXXctAut+z0aLzWjH5QLCCTlm8cazUjxrZBrcmFo/rxcAJmAzAt/zxegPWps4V
         3vt8KVjuH0K1oWGo3hH5Q2/dBr1s1knLvyyFXH1xNgwl6kTwqq0oDs/WX3/uwiZiFZ2a
         oNIrRn4q73/0ELhgurMqhPhysHBXkUEwKZV4oeEnXDZ1gGDsaaNZX/lc6iCLigVLy2Z/
         VxDA==
X-Forwarded-Encrypted: i=1; AJvYcCUoovS0egBudtrEQa7x5II8PZG4tBzpa6q/186wCkGGOux1SQX5oewKjCVwEqlaUS8Ovdm/ryQhmrtkflk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQiCEb6gxcoK89O6j8tIm8fOuNjCOA1esdclj5pkmO+Or0xkNq
	vXSh7LvJHhKSeULBRLCjXrNK5CkuFbu3v7DrdQANqekm2pyY8C6ysVJVquBc5AKgQs7PqQTpRD/
	b5D1G//MT4kpRQ9L27Zp6yZoDs/WgJIXkD/zfubv8FQfp4+8TBDOHQDWKa2/saouGIHkRCdxxYw
	CGF+wfy9kF1DLJwxrzagVXtvg9TERG0V5ppouyqdMYTQ==
X-Gm-Gg: ASbGncutdzKk617TUtJ7KHOf9oNA8YEanxo2FLIH1EulMTk4X2DlMZx5z/zLo4iOvt8
	BtCMaxK6vW2lHEwzre/NSz/5t2fA/u2FgNehJtqHiwaE20LuZIfQAjoM+tMldyUgPIFyVjpcdIy
	6d/5NwVYADCOILChBhDx2cE9A0GmF6N5FNVgJ32HjEN/Qa/Rl7M7orauFV4N0Xo5ngTR/vFdGiw
	+l2dsU9X2RBGHy5
X-Received: by 2002:a17:90a:e7ca:b0:340:f05a:3ebd with SMTP id 98e67ed59e1d1-3436ccfe431mr8790505a91.28.1762783573508;
        Mon, 10 Nov 2025 06:06:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcZK/I+Oqj7cXYIYbymAdZsmrBRsLxABQMipK9Bn1Ts4Upxyiuw930Gmr6hZFgRBDHnDCcsb3fu4H6bnas7ys=
X-Received: by 2002:a17:90a:e7ca:b0:340:f05a:3ebd with SMTP id
 98e67ed59e1d1-3436ccfe431mr8790452a91.28.1762783573001; Mon, 10 Nov 2025
 06:06:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-18-24b601bbecc0@oss.qualcomm.com>
 <09b2ee28-ee2b-46a8-b273-110fb0b4d8a7@oss.qualcomm.com> <064d2a33-22e7-446e-9831-a390510698cc@oss.qualcomm.com>
 <20251103102651.ywxi7lqljsmjg7an@hu-kamalw-hyd.qualcomm.com>
In-Reply-To: <20251103102651.ywxi7lqljsmjg7an@hu-kamalw-hyd.qualcomm.com>
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 19:36:01 +0530
X-Gm-Features: AWmQ_bnH5-5jNfhWCOUYTXVu7I9tmNhczMz2vx19inA6uDgAVRKJo8Gomv4g6H4
Message-ID: <CADhhZXaD=ut7MCQD_uEvY1ew7o=rqUUtviaXwQSkE-nmvCxMhg@mail.gmail.com>
Subject: Re: [PATCH 18/24] arm64: dts: qcom: glymur: Add PMIC glink node
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: vU1wTs3iTVMYNI1P0tq5Aq31VJjuXZ6r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEyMiBTYWx0ZWRfX3K3ZcASNzTLO
 mQ7VfK0Dm4VkY/fNOcpGDYSmpA0i2/CCNv43CwNw1mdlc/Qmf+UQXe01HP3obXiTHLq3LR7iOha
 MUtkckUm2OHRDzYQ8CjlmBdCDQjh5cEEUtNeEHcUgiFDUUeuH+hCdLZyaFn2NEJixZvR4F5R3u/
 EBVfoea0Rjnuj3wJH+ZOUBR0bP1uNNxXdckyBuFyBDg91o8UTbbSydiabAxmXlyht7qThTiJ0M/
 L5Co2ldlrzoD873voHo+/qQ5QonbrKJAQ9n4BL7i9TmpbCbclNJn8zXqlH8g+/MYbZd5qFJ1xJh
 4A/bKPFPe1TzUM9K48aZzKulQRvRLETilQ+P5Pk4io8ZwRie5q0ZKxXaMVr5MAxe0Zx0K5Z1Vze
 B1PmuP4cb4ArkGLfFjRumsaOyK5KVQ==
X-Authority-Analysis: v=2.4 cv=UZJciaSN c=1 sm=1 tr=0 ts=6911f156 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=_wFouAXmutvAtFiYnf4A:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: vU1wTs3iTVMYNI1P0tq5Aq31VJjuXZ6r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100122

Hi Konrad,

On Mon, Nov 3, 2025 at 3:56=E2=80=AFPM Kamal Wadhwa
<kamal.wadhwa@oss.qualcomm.com> wrote:
>
> On Wed, Oct 08, 2025 at 05:25:39PM +0530, Pankaj Patil wrote:
> > On 9/25/2025 4:02 PM, Konrad Dybcio wrote:
> > > On 9/25/25 8:32 AM, Pankaj Patil wrote:
> > >> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> > >>
> > >> Add the pmic glink node with connectors.
> > >>
> > >> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> > >> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> > >> ---
> > >>  arch/arm64/boot/dts/qcom/glymur-crd.dts | 28 ++++++++++++++++++++++=
++++++
> > >>  1 file changed, 28 insertions(+)
> > >>
> > >> diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/bo=
ot/dts/qcom/glymur-crd.dts
> > >> index b04c0ed28468620673237fffb4013adacc7ef7ba..3f94bdf8b3ccfdff1820=
05d67b8b3f84f956a430 100644
> > >> --- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
> > >> +++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> > >> @@ -79,6 +79,34 @@ key-volume-up {
> > >>                    wakeup-source;
> > >>            };
> > >>    };
> > >> +
> > >> +  pmic-glink {
> > >> +          compatible =3D "qcom,sm8550-pmic-glink",
> > > You *must* include a glymur compatible
> > >
> > >> +                       "qcom,pmic-glink";
> > > Are you sure this is still compatible with 8550 after this
> > > series landed?
> > >
> > > https://lore.kernel.org/linux-arm-msm/20250917-qcom_battmgr_update-v5=
-0-270ade9ffe13@oss.qualcomm.com/
>
> Sorry for late reply, earlier when we were sending this series our unders=
tanding
> was that we only need to support for usb shell, and anyway the device was=
 on the
> debug board so this feature(battery/charging) was not tested.
>
> However, after testing i found that the power supplies are getting regist=
ered
> properly however the data is not coming as expected. we are working to fi=
x this
> internally from the firmware guys.

As you had asked,  i was able to check with this patch (and firmware fixes)
https://lore.kernel.org/linux-arm-msm/20250917-qcom_battmgr_update-v5-0-270=
ade9ffe13@oss.qualcomm.com/

The qcom_battmngr driver is working fine with this patch included as well.
(though i faced some conflicts which i had to manually fix when
pulling this patch on latest linux-next tag)

