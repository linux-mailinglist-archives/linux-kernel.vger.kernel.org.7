Return-Path: <linux-kernel+bounces-796951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58339B409EB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FBA3B335B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643A5334376;
	Tue,  2 Sep 2025 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="luJbMLL4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCBB2D73BD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828655; cv=none; b=aOQ8BTicicdIskBeLxRUyfavLnCxZMYXvtvnHC+sPzmrvt34BggW8ZAWJ/wDmBLPavVqnXBkGmmmHV8B9dqE+/Zninz2oEIYqoi6MUR2jMguZx+LqH6Rir1uiZ/DWnwjI5MgR4nb3aQt3TOM+sVF9pzpz71nyHQQuX4cTLs0A0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828655; c=relaxed/simple;
	bh=f8dB89FFFlQppC9iKhRxh/NQhmzMIkdFH6xcmmT4U3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLevV6LWXVTudC8/SqaAVDKknzufQzaxedWzV/Ucb9SFRyY7mlPmjRpyn8enrJxklM952RJUZyXaAFrLbigGo9xM/LFm/OGFpnYfMvNgNxe/4TYrSfiacfhwtVCLOiwbEmB1JG4eXjax+EQsu/Fwg53Nmbcb80gRZfC4coqYiYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=luJbMLL4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582EqGeQ012726
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 15:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=TREnSWpfAdWrhmOtMgkCSdJYlV1MbSdoxyYVKxg6HYw=; b=lu
	JbMLL47Ftx9g9Db4lqWD1qbEVabosqCPd+0Qr/JAi6TePDUU/GKbTLq894xe1JKX
	WOHsWP+nlfxuW3JHRyx6lbHkNeRejs7DbeZmIo4te8gF/spHIzDCCoH2biGydJnT
	CMjIbhLCbdCCu+j9H5VDPslhQ0AXdVx3AVVlRVwSv+DGX/UhTo4/+Rd9FnlNVAe2
	5XUo2komMoOHF3B6orvdFkAW0kDOc3pkTQnO32l0EvBc0WWjmEsC7wYYHmGRmnKq
	5OrDadHtvq05ukhB++lLHUr9wQuEsC5fHr3EwzAr5PFA4kqs84gy76CI8sQD9ghw
	5LLP0Lwf52ooGiIRulDA==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk9076d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 15:57:33 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-435de5ccae6so5405367b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 08:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756828652; x=1757433452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TREnSWpfAdWrhmOtMgkCSdJYlV1MbSdoxyYVKxg6HYw=;
        b=fWNRhhC+ExKDqpSWgdj5gCh6juQCZmbruw86yLOhMGY/tMjI8pCs1rmP2iH2iY1hbA
         a0Xj5Po5OLxMGvT+ldYyc1Be62CoKCQnhwHhVGSAGiqa2MQbdm60bB5aj54bRADlvcGI
         F21B9swPWDIecb8hHvVsAq69d8j3NF60/4MFwgBTb/8TP+clpThdQqYVHqTGR83BUGOq
         1vs+fktFHeNgGJfsjO45PFTQoEC4SPyLZNSDCZPFrrEplsw+jQSSNOf6/iHbXFzdNoPr
         dihIYwHwBuvaY7ztdlzcrJKy+pkpuAJpvVkZ/pDHcirRBiCzTDr3RLZpZd2u3cVIL4Tk
         gaeA==
X-Forwarded-Encrypted: i=1; AJvYcCWa2KNvBb7klqhJTXJnVHFLRmL0dD/bzqji2eJ4SoscEwFZ6Jc+AN9KrPHhknBhNfQj+g6Sze8fAvBREuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZhfP43X3Upo5e+WLqG7hsBWYIomKo2/o/XPvBgnpMkBAp/Pq1
	DwzGMK+ZInN7eKyAKep/WG1L8Wslrq5Irve+zapz+/PEV3RP8Wkd/Sm6tQm0jwsF9QIBSxRxnMp
	8k7cL5UbxiZYXKBrwrjVorh3ALSuolRtpcjA5Rcsd2K6j076yecIR9ajHUxbtPUOxKWRHuPgXYO
	GVMwXBz3BL01W9bvA15YKqfOkW8T8+MYGJMcAKmqcIIg==
X-Gm-Gg: ASbGnctdL1xjf9D7tAK3kyOB6J3k6m14J8eIB4q+7vkmiGobS1MZqbb1kVx8BRB1KJh
	H7up2mRy0ACs02GTrzA7DVzDTzMRhCNBdyeTyQ3aeKvNiHjyENeKf9c2dXKcBa8aAx3ScXUeDHT
	ilUDiGS8jeCit60o3Q+YILWc9qG6b8Cssa2bQeAhe79pBvdSzvynTL
X-Received: by 2002:a05:6808:152b:b0:437:b10d:3b46 with SMTP id 5614622812f47-437f7de1519mr5637674b6e.30.1756828650809;
        Tue, 02 Sep 2025 08:57:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYnnQDfuHV9n/jWre+x5H5L+i6EA8p0glanc4jK3wzaEOdW1w8zr1QPsTQkge73XmH1NyXNbBSBZwJ1vwOsTc=
X-Received: by 2002:a05:6808:152b:b0:437:b10d:3b46 with SMTP id
 5614622812f47-437f7de1519mr5637653b6e.30.1756828650361; Tue, 02 Sep 2025
 08:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-assorted-sept-1-v1-0-f3ec9baed513@oss.qualcomm.com>
 <20250902-assorted-sept-1-v1-4-f3ec9baed513@oss.qualcomm.com> <694f0989-64ea-4c3c-8613-863da1dd286a@oss.qualcomm.com>
In-Reply-To: <694f0989-64ea-4c3c-8613-863da1dd286a@oss.qualcomm.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 08:57:19 -0700
X-Gm-Features: Ac12FXzQPwDIUy_DiVh-kEO71EFonDrLLU22HZlou8nVFBUUUe2guiMPv6umOuA
Message-ID: <CACSVV037e-GquRk7P1_qT7T4HF=f-TF93FpJ16NiKShqicaCfw@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/msm/a6xx: Add a comment to acd_probe()
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 3R9oJYXNMP2u8q4cuK99CcJCrUp0ncDC
X-Proofpoint-ORIG-GUID: 3R9oJYXNMP2u8q4cuK99CcJCrUp0ncDC
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b713ed cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=EUspDBNiAAAA:8 a=ycJl_s5THFxdJBPSnQsA:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfXwClooAEQkfHO
 H91x2MSncCUo/uVKrqzPwIjeP3Q4fgXbJKsPg0vZYpENrpoNOpx3DisWOUST3j+JtDufu11gX8A
 T9vKL+p9tF0bqv5yT06Bf4Wa/ZzsTBnJ5yz+X3v5fjxwlkcAmdaEVCgatHME700qMYEisCFoFDV
 IOgV5TIu8rG8ZzXoIsl6lakko4QzWftSAqAKTFW8RJUYgCx1ZzC6JLYIi3C0VbV2nZBi/xSC8Ng
 wHaKHapzTOVYfAAnZFyTM5IsJqQ2BwFTF3la0zEKFDcY+n9t/zJKoJfRMdYYo1V8YNN5tbwYqj6
 cSRninK5O9MGq9SaEQZb0lEn+P41zENrCDcBwMX6o4bCwgWTo7pjuClJDPP5maDFhDztNm7UB8C
 VH8vhuQ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

On Tue, Sep 2, 2025 at 5:33=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 9/2/25 1:50 PM, Akhil P Oommen wrote:
> > It is not obvious why we can skip error checking of
> > dev_pm_opp_find_freq_exact() API. Add a comment explaining it.
> >
> > Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/ms=
m/adreno/a6xx_gmu.c
> > index ea52374c9fcd481d816ed9608e9f6eb1c2e3005a..de8f7051402bf0fd931fc06=
5b5c4c49e2bfd5dc7 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > @@ -1694,6 +1694,7 @@ static int a6xx_gmu_acd_probe(struct a6xx_gmu *gm=
u)
> >               u32 val;
> >
> >               freq =3D gmu->gpu_freqs[i];
> > +             /* This is unlikely to fail because we are passing back a=
 known freq */
>
> This could probably mention that known =3D=3D we just retrieved it a coup=
le
> function calls above, but I suppose the reader can come up with such
> conclusions

Also, I think s/unlikely/not expected/ ?  "Unlikely" implies that it
could still happen..

BR,
-R

>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Konrad

