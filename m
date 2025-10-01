Return-Path: <linux-kernel+bounces-838869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3942BB050F
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B55184E06CA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836AA2C1589;
	Wed,  1 Oct 2025 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="STCRlEs3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C63D27E048
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759321409; cv=none; b=E4jNcay6/GHeRhJovMBOPl0tUz3tikwrfmqoU1+mAaYdSMIXtnXvngR2pNLR7cpXyUQpp/KvXt5hgsGgj2mSA0GvQZUBHoJwDPhC0nHZWAVF69aBartqQN/SqR6zB9Dz5QY4Xvngk6Jv7rwtWtI7+x6KJYEP36NgP9evH4V7CK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759321409; c=relaxed/simple;
	bh=cAzm1k/LFtYsfMoz1fPTwsIertg3SJX77LxBl5CAl0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z71Ccur5z7/cEH31UmgS1pj3gIuZjUPWd2abXgBj/dhzTgppbZx0RzcifSD3aKbgF5itdCrLVLmUV4/OPRVblDL7tOokBuYMn/LtGeZD3xxLFHMy0oFDwTiON+OL7NcJHNOzMv/oIYrzvRTiNVz2LpiQQEj6r+GLkFWbXtDNW6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=STCRlEs3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59199smF014983
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 12:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cAzm1k/LFtYsfMoz1fPTwsIertg3SJX77LxBl5CAl0Q=; b=STCRlEs3uozSjQv3
	G8jluY9INTujJvjmpmz5oUhPEaVCUvBXho4TPh5XFMzW5+NxWIB4YY3uBc4LmQLx
	8R3qK2nYaqeLrc9scFGUJqeY/dc+kpYetzdttljj97vvnVkxASRGtpFLZRIV0WEV
	FLDbrWR3siDlC0J5bavIvgQ1Y3+Ac1tbHY4wymg3nmApbJCSmA9WdYmKBN29DjDY
	QRO617j3bsqaff8SW/NxFe1sG8o07D9iXGzR5Bb65wYGNjlblHRI5g1Ve7CP0Q4X
	sVt1gif7vosCSrK1G82pYqkQVUK9vNJ9/MAcjxDJu7tw45NN+wBZyYNsGdWoZMeT
	4tCzzg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vr4j0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:23:27 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eaa47c7c8so6394541a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 05:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759321406; x=1759926206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAzm1k/LFtYsfMoz1fPTwsIertg3SJX77LxBl5CAl0Q=;
        b=IwWEJvDXH0c3zZRC5f/jiMbkl/h1bgyjhkl9a3nBW4aufzjAf2o5QgYiE0T4xXZDKm
         EeoJdcWM8grb5742P2XEReoeYlBHSoyDkGeDoP9S8LEtfSVSG39oVDqoBswhVKBz8oDz
         MT2ort56BuwauSFd7yXN2hsNi0TunUayitX5eRMiAm4nO3T6KDdbCtGaSDQyJ+xCXc+d
         +ijINkrR3kZRSNE7dvkPfXpqeyfL1t9i/8czQCcM/0MAplYofomXWty1hiTz1xZsGRr/
         c48LRVJKZ06+Ue/Oijq+kL7MVBZsySrGTxV2hZWjJ11TbZdmTGbaqFeGB39jkWZhbFtK
         7zlw==
X-Forwarded-Encrypted: i=1; AJvYcCXDtSuPytNjzBvs4wsjTfb0Oa3llE56f+ss+6cuNS45YRZ7PyapHuc1LAIjvqFfvSlB9suSM2G3TxnLhK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9TsSAAm+WHHt9Ae4fJiFgx5XFmK1yhfgf0NeZinEEpTgG3M1Q
	Q8KLH3bZCqkG3/tC3ajfczkAgMN34HU5EiyapDRXb6G/r6z2D0eseXa2xCy1HkHX0LG4SeHp2Zj
	3m4eEnPfebyAV+opGcc1yhSBMbm7jmDr34SXFAik1k0jUjkO08/LfFWkbZPb0oc+NTAovfPoSTe
	Ti5b3OyDBrI1BsgoZ3KuBuSN9xy8vnCN3pDg9ZM9L8yg==
X-Gm-Gg: ASbGnctet6MetCY0EuJdS2/2msRnFjRL2PiGUoFA6oWCLifOuzznADQ+0++Ko+hWjoU
	dZDKruOxacOrovrB9UfRM30r1ZC5rt8Ybk/Yky9cgxCwoTjZlqkYTq58f+6vsuAV1Ok4lGKvz12
	P6SEzDvJqGBaaO4IDBUW8om8k9fLBbSPn0VHDBphsho1iZvIOdWab/gz0g7EU=
X-Received: by 2002:a17:90b:38ce:b0:32e:8c14:5d09 with SMTP id 98e67ed59e1d1-339a6e83db9mr3743328a91.7.1759321406543;
        Wed, 01 Oct 2025 05:23:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgIgEmCWOZbOFHuIFYRCg/Km734jZV+7WJCamZI2sYC7RYyp47h5Plxy1o+W40foeNndZscq3o/Jh91cGo7nc=
X-Received: by 2002:a17:90b:38ce:b0:32e:8c14:5d09 with SMTP id
 98e67ed59e1d1-339a6e83db9mr3743293a91.7.1759321406092; Wed, 01 Oct 2025
 05:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-17-24b601bbecc0@oss.qualcomm.com> <CAJKOXPdi0+c_FqinVA0gzoyqG6FVFp0jq5WSLsWWKiT12VVs3Q@mail.gmail.com>
In-Reply-To: <CAJKOXPdi0+c_FqinVA0gzoyqG6FVFp0jq5WSLsWWKiT12VVs3Q@mail.gmail.com>
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 17:53:15 +0530
X-Gm-Features: AS18NWB4geW4hLTPYgmoVnPDMvTYBeUM3eY3cJp_CGVJlhX_7-fckOoruJv-GaQ
Message-ID: <CADhhZXaB310hVo_w8_CoJLQ3j9dy1eeTwbmk0q=vUV2ga1PAYA@mail.gmail.com>
Subject: Re: [PATCH 17/24] arm64: dts: qcom: glymur-crd: Avoid RTC probe failure
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: dqTkspkZdm5BI2XHkLceeaqE-R59cvLo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfX6W+22o49T7RR
 w3XSq+YVt3y9n3hFeeU9wUmACWz/VE1GQDnktAGWa1unVUG9/M/s/jxmMbkI0v2liSWonHDiExn
 hWZlZwwVEcIByfZOs5pfXBLPFOsmH7okoezpBT+A3MfORoRC1wBtna+u5WlhOXOQfMIlwPp8mwG
 LHnKotx1vTRulclcSny0OEzEKOoxJdG8SGNwF1mSfLAcFEZNfYq6rNDszY+zvZsX6KAeQ9dkZew
 RNsfdHbcM23ymNRYkhdy8CwzG+zz0uBDVvOmLtX1gW7wBrEcASErKBgEYGKJU05cyfw66yU2ESz
 jyhh5sjjMc+2xp4ND0DQUmBvZO8nEVxEJlan0VYfxlRw30DkHEY7lFSlcC/iWbedNTSG9SdVFxz
 R1rhMZHxgyCsLnt7rv9qzzZFIevt/w==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68dd1d3f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=AfoGAnNRudiV65anGGMA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: dqTkspkZdm5BI2XHkLceeaqE-R59cvLo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017

Hi Krzysztof,

On Thu, Sep 25, 2025 at 1:41=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Thu, 25 Sept 2025 at 15:34, Pankaj Patil
> <pankaj.patil@oss.qualcomm.com> wrote:
> >
> > From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> >
> > On Glymur boards, the RTC alarm interrupts are routed to SOCCP
> > subsystems and are not available to APPS. This can cause the
> > RTC probe failure as the RTC IRQ registration will fail in
> > probe.
> >
> > Fix this issue by adding `no-alarm` property in the RTC DT
> > node. This will skip the RTC alarm irq registration and
> > the RTC probe will return success.
>
>
> This is ridiculous. You just added glymur CRD and you claim now that
> it's broken and you need to fix it. So just fix that commit!

I'm afraid, but this is an actual limitation we have for Glymur
(compared to Kaanapali).
The RTC is part of the pmk8850.dtsi that is common between Kaanapali and
Glymur. On Glymur (unlike Kaanapali) the APPS processor does *not* have the=
 RTC
IRQ permission for the RTC peripheral.

So we need this extra change in Glymur explicitly as a workaround to
make RTC register
properly.

But sure, we can squash this into the main DT patch, if you think this
is not a limitation
that needs to be highlighted in a separate patch.

>
> This is a gross misinterpretation of splitting patchset, some twisted
> LWN stats work.

Sorry for this. It was not intentional (definitely not for LWN stats),
mainly this happened
because this is how individual driver owners/teams internally added
their patches. So
this is how they ended up being sent out. But we understand it is an
inconvenience for
reviewers to go over multiple patches and squash it all one patch.

Will take care of this in the next version (and in future).
Again, sorry for the trouble.

>
> NAK

Regards,
Kamal

