Return-Path: <linux-kernel+bounces-850504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E0BBD3001
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4986F3B79D1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF7C270EDE;
	Mon, 13 Oct 2025 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TXcT0qSB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9E418C03F
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358896; cv=none; b=PahQocgSs4qjXqKl4hKFqL+ZOPf21+1Noy5Cz+TzslctPF7aAQfEYTITdEaf1PDUXcxKChn8k0pDn9mO7lX9rts42Ex5s9/RpiYxjf5I1WPO0tS5m51ST1WVsR3A8qljQObsg2N+3D4buElX9Sx29ADxcRYE+Uf39aA2w/aJGG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358896; c=relaxed/simple;
	bh=ajB9cgC6bRzVciNEiJ5Rlu8UcrAcaygnA0NUSrk7i8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlCGWOBL03M7nxZef8xiyNrdxSKLYule/QIih8joSA0JOzeYWpMIAF1Dv4UPtcNUNvmnetlOtnqGBMrRe07cPgia/ajnWCgopFiguhBoFa6sn4TLPDcRHA5mdpfIQp8fd5pm6H/3tRbaLy61Wj6JkfCMAffCr9SPhEgHQcOp0bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TXcT0qSB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DAmJVn029616
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gObp1VGk4sT3wo0aNUTQnaxb
	hlPxOaJ9VK/6dcghZLQ=; b=TXcT0qSBuY5yfp/PNTnIrw7XNb+s9/QYCReqou30
	gtIGh5w1O98le1QLr/UGIlqf0FRAMWKyhoiDDhQq/h5jYDxRoxHhe6PFGxmTGO4+
	iKvu+DfCH4bBE45FfhsCs0Kr6YXrVVfvxA52xvansO5wQ7lI0sOFFKbBRHrR6CF0
	h8H2/uLaBv/6+Iq89Xp4/B79JK/GTDI0ThFUGtYMDBywKpLJu8svaMWw/lmLFzZu
	R+K8n4dJuanKaKDQH7sH9oCVV5sXmIT25qvxdKQhxYsCoq+ieJP5tDS+KCFNMaG+
	OCfDv0LxPObPXHhVyDS8uCiV5xNtoVyaJw4sHJ0TQhqPDw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff0mgmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:34:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8635d475556so1090909885a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760358893; x=1760963693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gObp1VGk4sT3wo0aNUTQnaxbhlPxOaJ9VK/6dcghZLQ=;
        b=Vo9U3yv80o52OO8cJnVsCTuCVFzQhDfCKkxbEiBhbyUp7jJzglmPRKFaP8un9Lj5qr
         gUpB0/2d5gjsXP9rQJWhJ5w8uo93RL5v7nZbujRygBWnei1x0Xbv3dutVqDOHNAKLsNA
         QnmJB6Xzpp3Aaoq/U7Oq5vMMCFX8v1H37OPR971+tVNAqyhVABjSEPznnucg7dHVDMzq
         OE8pjc3FQ60AtcFI6gbKZg5bk3PxQWT5c81PVsjj3+6D2xj9EF6MiZ8WOaGFtjaZUoBl
         +MahfDMOrrMvg9fbPbLwUpizRHyD/3LCCKkwguh/o73H65fS4EfgE/2qQu2tfwg+uz0j
         aKbw==
X-Forwarded-Encrypted: i=1; AJvYcCWCo9c46MdRCUKa/vUhQVU/b32dzmjDkBzxXbCgAAYxL8ASl13CtArMt8VQ6bwDHk7C2u04hh5xnmVVUpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaZrscA7f63xHsQ7MicGJOKOz99dgWWUo99LC9jMuu8WYhlX3x
	mjTjO5LTCcBGGz3LF7uEeYvcM2CjEcZOP+9XM4C8w2dMjr6F9ErWY13NgEP9i5DK6H88/+mQNZL
	dcRaRbiKZUlKZOlZjBU2Eve1gt7zTRTS5A61wabsefcBG6O7DuiCT3yMj4EfAFhK+mvs=
X-Gm-Gg: ASbGncusB02njhTVBHbj2LefNMY/K7rI0UvkWGqrewDHKwWvHQdT2uRiP/S8YlE8QHY
	5tx5KyL2zms7GdHx+DqelM6PXbCR0+jzfaNDV+nV1uxKzI5XS1Pyk1jrvnT6pLYQPHxuqgUsMh4
	zU2q5ptcaG+kQZPHRhbleJr3n/+JZXs78i8p990yF1TTifQqh0+Lem2Y6TRYq4YRqEONh+lYgOc
	nlE28z8cWum88byf5/aUFBf9Oeh6isfu2BhDqwqMkHgf0SS4qZ/y4KRKipjP25EcovLX/F4uW6H
	g+DIP3qjTzz0za6p8tEkU7MXkDHsPPqhzinXMYHVHEAWVJDAkauTFSJuAzlaBiNVS8Sinu7m9XZ
	cZ/aW08x7cFU2TMiyftov7xfM2gmvJRxaENERzI+1zeu0HB28MuTK
X-Received: by 2002:ac8:5885:0:b0:4b7:9581:a211 with SMTP id d75a77b69052e-4e6eace7e6cmr280428001cf.24.1760358893366;
        Mon, 13 Oct 2025 05:34:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5+lAIUbag3KQ/uyAYMUw2tzUdGLO9/5D5HdSvdyoQpY7sOU2YLiAsMhiWrQQX23CCsWeehA==
X-Received: by 2002:ac8:5885:0:b0:4b7:9581:a211 with SMTP id d75a77b69052e-4e6eace7e6cmr280427561cf.24.1760358892867;
        Mon, 13 Oct 2025 05:34:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088563b53sm4075703e87.84.2025.10.13.05.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 05:34:52 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:34:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ritesh Kumar <quic_riteshk@quicinc.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jessica.zhang@oss.qualcomm.com, sean@poorly.run,
        marijn.suijten@somainline.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mahap@quicinc.com, andersson@kernel.org,
        konradybcio@kernel.org, mani@kernel.org,
        James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        vkoul@kernel.org, kishon@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-phy@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        quic_vproddut@quicinc.com
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: qcom-edp: Add edp ref clk for
 sa8775p
Message-ID: <aifibm7pjva3rkb4gkzyxun46sraxyeh7jh6vgcirv5tsbf6ad@7f5bbs4ix7sa>
References: <20251013104806.6599-1-quic_riteshk@quicinc.com>
 <20251013104806.6599-2-quic_riteshk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013104806.6599-2-quic_riteshk@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXxj5UUGge97Ef
 64EsgaJutFUJMUrI0vxnzmaPiN4P6sM1V62eNKuPsdI9ZTE141MeRq8Qm60ule6sP8cdn26JrXA
 DWqrCRXEfDuzgKBUx4HJUHsJCgLSEMYzjByeRebhQnpElAUrx2UjdVPtDFjmjwnj4K9+F1uYueQ
 WkiRhH4ek3eyLqDmtmTiGT0rSSmejnIqYgJSSQuPI9m4roK+Gc++7AbpbugyUZiS2HiMbUDmBQ+
 ovexteDgVIu+GF3JA7QVvr5O+/eNC3LhxyponZ3DJRjmtaWtG6tzVRDbWfGvjqNn3vMjWcnbSO8
 /w6aB6onACDZ5aJ7LB4kk7eWg4bPjZckROD2DCaRuSU2osX/WJUidBHH/OPA0QB6FAG5zojrttn
 kVBsjW5Jd4iNNpkln3aua+8aMAmiBw==
X-Proofpoint-GUID: GkdIp6EMhLUlLo9wX6lTF158dsTCVal-
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68ecf1ee cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=yLsOkrEfH68IAt7CJG4A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: GkdIp6EMhLUlLo9wX6lTF158dsTCVal-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Mon, Oct 13, 2025 at 04:18:04PM +0530, Ritesh Kumar wrote:
> Add edp reference clock for sa8775p edp phy.
> 
> Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>
> ---
>  Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> index bfc4d75f50ff..b0e4015596de 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> @@ -73,6 +73,7 @@ allOf:
>          compatible:
>            enum:
>              - qcom,x1e80100-dp-phy
> +            - qcom,sa8775p-edp-phy

Usually such lists are sorted.

>      then:
>        properties:
>          clocks:
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

