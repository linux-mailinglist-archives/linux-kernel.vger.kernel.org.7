Return-Path: <linux-kernel+bounces-874940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1B3C178F7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F1B44EB77E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B41F2C237F;
	Wed, 29 Oct 2025 00:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E3+F7DuD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RVVB5wK7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D818026A0F8
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698160; cv=none; b=leaXaFIg58yz082Sw629kvtNkMxdJ21MMKwrgG/MrQsfL++fxNfPeHI3VoaNP1wdWp1zn2IIkd6i7y2HlG5vw5e376zJdn8CT0V802CjkPh4Etmwy6d9gKDAio5RrhB/h44gY/IrR2noMyXgY+JNeYzCgKDI4pxFCY24C+0KTwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698160; c=relaxed/simple;
	bh=EoE8k0KBFJiVu+lUu/6ffmeuppX2gDDFdvUcYzSJ2Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYy2RyWfAI16rJKQEyrxBULRmAbEpgkl0TDXLkz3c7p96b9YslZtJT9ec03Jhb6dQZmROXoiiX7TEK6TVAYD8x9DEAur0lPOXd0XVfg5/l6+UNKHgwNmeScd2fRDv0oX5TRtLHn02TorEQOvaULdfBECIvIUuEYLD1vBeZlrR+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E3+F7DuD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RVVB5wK7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJlUG62525421
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5d++JhR83X1EkIgn5+hFamsAqFSB3yWcWtebHioBuH4=; b=E3+F7DuDzmsYWcMk
	EvBz9HHrOuqIhWRtyx5i68YDA57L77H05A2iHS8AmLmxTsYc2h2USz3mKFW+5+1P
	62bMGSVQH36yGH9DRz551AOwgCse2afKyGbeImDfEpmbvB2g+mCGijg1N/KxwtNa
	BH36h3xBoG6LyCs7BeM7eU2GJ/0elX6rlWbw6kN0RXpwv750b9Qf03dCRFbtsaCb
	EoWA/2zaQSy6Jj3EelTbthCyzj/041/nj0RZeaHVcgO6b+cwlr9tHa6yOpR44X2Y
	RgbeXib1hoG29zNqihwjn2nc3dCPQAKN9IidxUvT0a79A5pioNETLExxdfRFY81Y
	nh9xLg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a3rnds-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:35:57 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-26985173d8eso170853185ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761698157; x=1762302957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5d++JhR83X1EkIgn5+hFamsAqFSB3yWcWtebHioBuH4=;
        b=RVVB5wK7fTlNeHlWOXQ6APs02EN2FG6+lQkIyntzLwTRudCncrXq1g8c09HgVJPhXW
         1Xi/MxCwC+2bL59L3Z+vf60rzyJJFzx7eezxnfXUgKTqRjgbGN6QBkQ+5wBu0x3BaxGu
         l4GjA37DWdBOgJiSUUJjPhfHm4nGd6dW+gewKEEZL3FSoYP96azz3eN1mT+2zQs95C88
         +M2GWOYoSedWjQ2ggrJlJbjIL3Ak7dMEaUW2yEpFZk3Wn0s3uaqVJ917cxqDccedv6uq
         Rb/TVYQMhJt0m2/ilhfpZVY/KvgfOJFmgNIMpvB+Xp+dZvh1Kobv7PTF99ZQS0LeTnng
         XCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761698157; x=1762302957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5d++JhR83X1EkIgn5+hFamsAqFSB3yWcWtebHioBuH4=;
        b=qXrp/zDgfvDx1juyUUXb4Hj7AwXoibAidKDWBekVrDG8ydSaZbNLAJZqTRUVPFzUqr
         5gASbrbZRZWWACquas4AIBP9BKh47jo7WF4VQTzbpXg4u5OqncO13y1hPANHkYdzHXOI
         rLpIYODfGlZOyCk7gLJ4MPykQsQgb992VNTO7vzVUAZChKlscLaE101oOs3I/ow8OybO
         Vcoi5uRuIMQqW5cm3L/6I5OEXN1TuIAeBu3RR8eCtJlHLkLzsr+x1Maawvhq1aGcCVMP
         qA6s5PPbjt7skNjKf8s9S2oeE7rAIC4wBVHXMkb6PsLLmo6cj0abpRq8JR1nfgbhmpE1
         KJhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4p1BeViK1meEhimQd/ka3BnF+9Vwf6lyosuDxJdVgRxMIsfDkvpBbqhRISRz0SgGJz0fPRLawpEqJaKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzljA6uXyGJY+h17cf367ELl6j2b4ONKNXfsw3InEUktZPv7wxM
	kyN2pVYnra0cpY5NFiWdY+2dE3HTRkLryIkqQB9CT4LSMECmZlX7nL7j3o7gBYFr1OtvtM1cum2
	q6T/5oeg4M1q7PbVbNs5y4DczppdtrDJn8nf81WWSwRmhJkT9xtCPgTp3EeZOYQvCX0kRAbjjRO
	VOnf2keN7TxmwlCZgptsYNu25fTNjISysXoL7kfJl3lw==
X-Gm-Gg: ASbGncuR6FhpP7cjsKrV0O9zOQ5LNMdtBQ4Ov5t6o4C+QMHlhwjRAARhVA1HNUxSL3F
	GzEvSlj2/gXY+K4A/2k9Ei4s3jDnKUtBIcScsj/ovHUeLUl3klJeL3ef6RLTllP8Cf0D+fkNPn+
	On7m0IapgcEbl7YPt3meXInvBfVGXJ3dKmmo+sCZnpjLxK7qiv8f08tCoG
X-Received: by 2002:a17:902:e88a:b0:269:63ea:6d4e with SMTP id d9443c01a7336-294deec53e7mr14264715ad.37.1761698157218;
        Tue, 28 Oct 2025 17:35:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9OPHkH91X5aZoXnjzphjr5S5o2KvwNZWa5RxYObLofGJt/ji5FPIw8MHSQiXS9oyAy6iO/yF+aesYbSbF248=
X-Received: by 2002:a17:902:e88a:b0:269:63ea:6d4e with SMTP id
 d9443c01a7336-294deec53e7mr14264395ad.37.1761698156747; Tue, 28 Oct 2025
 17:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923-smp2p-v1-0-2c045af73dac@oss.qualcomm.com>
 <20250923-smp2p-v1-2-2c045af73dac@oss.qualcomm.com> <bb25208e-a6a6-4a81-9dd5-5c5eb1cf16b4@oss.qualcomm.com>
 <ff382661-4d05-4f9a-8b9e-55fa9932a22a@quicinc.com> <15617371-0b20-4326-8e08-2c20b3d3c767@oss.qualcomm.com>
In-Reply-To: <15617371-0b20-4326-8e08-2c20b3d3c767@oss.qualcomm.com>
From: Christopher Lew <christopher.lew@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 17:35:45 -0700
X-Gm-Features: AWmQ_blJ0XZJj57smLg3viz2rnoGszVfVoBpYuAGhEffTwa9-ivzie97R69q8yA
Message-ID: <CAOdFzchG34Eq-Px--ii3s+3yUf4ZNc=+0msr2bB86xMUExsanw@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: qcom: smp2p: Add support for smp2p v2
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Lew <chris.lew@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 1azTze4hkGK9gbIPjoQ9q5pXB4Y3Y0Gb
X-Authority-Analysis: v=2.4 cv=HM3O14tv c=1 sm=1 tr=0 ts=6901616e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=eY5W3OMkMx8GTqqscWgA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAwMiBTYWx0ZWRfX9u60TGOTcLYX
 QPzu8UgxUr1aqwXe2TAN48bBowtixbLQj2A5TSIhdyQ0O8LdNHzYm15SqS3rrTjTjJsYd9BwNM8
 LEtN0rYXQ34u+0i/DRbpQsMXKTN9WOmTHJi34uyHcPGBqMH10ibAQIDFF7ef6N6PhvNluwEYsXr
 4xAzIzb/3MZQZ/Ap8HIanGsF39onkUrB8Sniu9aGPB2+ixDgN0c8Ln5V2EwoftVFk2lsnKNq7lh
 9+GFRkZfWFG8Ow4iKL3qbSB5A/a2z9CD4SoFgw/xQg+C5g6EiOXMsA/pDbhp8OCbQeQevB/Ewcj
 BQbfu/0fbdJIdPVFnNsslbeEzGypkY/yrk1FwxPPs7/1eHnr6as8A6Lh3neJjh4/zCF9IaOdqCl
 CkK/2kRjbok4deqzgIXca/XfiBwLtw==
X-Proofpoint-GUID: 1azTze4hkGK9gbIPjoQ9q5pXB4Y3Y0Gb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290002

On Tue, Oct 21, 2025 at 2:39=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 10/21/25 10:23 AM, Deepak Kumar Singh wrote:
> >
> >
> > On 9/24/2025 8:27 PM, Konrad Dybcio wrote:
> >> On 9/24/25 6:18 AM, Jingyi Wang wrote:
> >>> From: Chris Lew <chris.lew@oss.qualcomm.com>
> >>>
> >>> Some remoteproc need smp2p v2 support, mirror the version written by =
the
> >>> remote if the remote supports v2. This is needed if the remote does n=
ot
> >>> have backwards compatibility with v1. And reset entry last value on S=
SR for
> >>> smp2p v2.
> >>>
> >>> Signed-off-by: Chris Lew <chris.lew@oss.qualcomm.com>
> >>> Co-developed-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> >>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> >>> ---
> >>
> >> [...]
> >>
> >>> +static int qcom_smp2p_in_version(struct qcom_smp2p *smp2p)
> >>> +{
> >>> +    unsigned int smem_id =3D smp2p->smem_items[SMP2P_INBOUND];
> >>> +    unsigned int pid =3D smp2p->remote_pid;
> >>> +    struct smp2p_smem_item *in;
> >>> +    size_t size;
> >>> +
> >>> +    in =3D qcom_smem_get(pid, smem_id, &size);
> >>> +    if (IS_ERR(in))
> >>> +        return 0;
> >>> +
> >>> +    return in->version;
> >>
> >> are in and out versions supposed to be out of sync in case of
> >> error?
> >>
> > I think that should be ok. If we return error smp2p connection will be =
completely broken. With default version 1 partial features can be supported=
 even if remote is using version 2. Some features like smp2p connection aft=
er subsystem restart may be affected by this.>> +}
>
> Perhaps a different question is in order.. do we ever expect smem_get to
> fail under normal conditions?
>

We would, this new flow gets executed for all the smp2p device probes.
For remoteprocs booted by HLOS, I would expect this call to
qcom_smem_get() to fail during smp2p probe time, so I have a silent
error. The in item will be found when we get the first ipcc interrupt
from the remote. I would only expect qcom_smem_get() to succeed here
on smp2p devices for early boot processors.

> [...]
>
> >>>       /*
> >>>        * Make sure the rest of the header is written before we valida=
te the
> >>>        * item by writing a valid version number.
> >>>        */
> >>>       wmb();
> >>> -    out->version =3D 1;
> >>> +    out->version =3D (in_version) ? in_version : 1;
> >>
> >> =3D in_version ?: 1
> >>
> >> Konrad
> >>
> > We want to assign in_version when value is 1/2 and 1 if value is 0 i.e.=
 error case.
>
> That's what this syntax does, with less characters
>
> Konrad

