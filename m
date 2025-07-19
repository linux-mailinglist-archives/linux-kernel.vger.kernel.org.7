Return-Path: <linux-kernel+bounces-737670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C944B0AF22
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 11:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5B9566C8F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 09:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0F1238C3C;
	Sat, 19 Jul 2025 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eIKe/XQW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F772235055
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752918221; cv=none; b=J8JNPLYzFK+tFH5pN6Qs91j7BfoHPoQ7aOAkAHwpEnKNfCdPZ1KffHKBIqF2nrHUqnehDCz2XflqEynHOcev6mD79TB6OwgjcM4I5W03I8VRfITj+stQX+OW9eQ7Urxu/zgshIIvKl5XRVkl0ZtQRHFvUxPRxcjJ5FWTwqEzRAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752918221; c=relaxed/simple;
	bh=P+Mk/P5ye+p9KUFqL+K46gO8goqLtuTv3VJtLHalKhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DX2KT1061fqVhruqW0h/LwpnL7DWVxL+mWOVXF6mH5bOZ7UUMFA3kjAOxxX8tOoUr0x5C8RTNISx+7MGspVwPnTTVy8HkTFYKf3vzbfVYA8iM1nj0/WnTB4VGi2M7O5lUP2dnlpwpt4Gosx2FmB0JLG6X7WyeyTFZRyQ7lIEctI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eIKe/XQW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56J6qcj1008991
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 09:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rhgfcFJFu0pycjGyM1cFEjZ0PRIhr6IT98FgwjCWEYk=; b=eIKe/XQW+VCrw6qy
	YDZuIu71jU6krVAEG2ro//VgSU2zD6oREy2R73F5f006S9h81k8XEGWAIURic6/s
	3C/z2ibBhsgp0kMODRuAAN+JBFcjgvxv/koBXdeEy39ebHbJAxNJqDY17Gwpojwq
	f/KI17OGkh0tUZ4fhv39qWLu7OlGVjfbVkD0m57Ao03Sn0UGqG6EhvTY1rU6Coce
	RoIwuwbAHtSCf3oPsN5jdsd1aMnjD/beax6buRrZfJimzhSvAS3+kcO7eCbWRKYN
	cXCct5kYpWcudSGRIiTgogUiLLa+1MOoQLpfnConsFxieo1+CKhVwXaferS3JKCf
	avz83w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804hmgcsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 09:43:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e2e237fb4eso497948085a.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 02:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752918217; x=1753523017;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhgfcFJFu0pycjGyM1cFEjZ0PRIhr6IT98FgwjCWEYk=;
        b=aBlBF7ylQSupv9AAuQyYzsvxVT8jOtuxUWwOn3s1nS/9aj/7qMuVuJW0wzXZJstXXT
         LE4O8kT/pdgu+h3PGaMKe9oqTE0jA56l6rSnzpNk+87S7/qvMR1lhwoVYVgHUbAJEFId
         8v/Z0ggbTOyyeA2vvbZrLmHCpGgTtIFKo/x/yIp0yfgd21hhdRhWO4AaqOWqJDlw3pjq
         J0aQTrtcRwY9c/X5ZElKnwnHXXzFsqydjdBjVaeIUMxe8oSxoRofUwAS2xhyTeV0DPgZ
         hMCx/YVjiam/cXTAMBDgKCBseVkFBLcMBxjrPjNzqRYdDylH4EycHDAcHo9cnNWyD+N0
         wLyw==
X-Forwarded-Encrypted: i=1; AJvYcCUDkEgt3GgJfynZo6CRMS4W2syrRPVipDf5927Mtk1CeE3vY4mHr+LD+IJhVvHLDolNXXT/1yGRTdE7yL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEvaBzbH38OUv1OCBtdymDaPKRNd+6r9GBPqx1xOts7oukjp83
	mzYXauZd8K0PO6g8JtXhmygFRe07nwCMzww5Qc0e4abWS7E0kQ6vtHGpFnbusoaYL9fqRSV9IgT
	nl1o/lDflKwfOHz0ll+HyFGty4jISqRwQb4O58ouF0Z1Emj1PQofWkXQCQ3gvNMt8Yh4=
X-Gm-Gg: ASbGnctNcSyZI7BQ63SP9jsdveOHHfNBT9fU+dZ/iBPSsBnSzTCFrEFCYFNfTFK/4W8
	xwuO4ZSnO8ySkAHXMO7/1wXRYZFHAZu7pQBf/K2Bz3jffJnHWPsQSjHAXMBxcL5zItL7Q+1Rq08
	Nr437u356F8r7I3X8OTelz347K/6KMWp3qbY6POtV7hGZzexd2CCB9cXhW9SG7zcrSh61uptsNE
	q3egfbTyVJQ2QIJx+7/mmv3RYJYh7ywifslkP6jHNlH3kQvTkMYY8lzYmjwHTCZlFZuRu61k7kv
	27MtyJjwMZSQwwb6v+503qx1eliUFoWKukyUyCR1WCNFhRueeWNteNFGbu8Yvy2eIt3mAjv7sxy
	3veV6sJNjKHy/7pUXE4w62WM1/rMvj8t49g1fyuBKpczy7pnVcdrj
X-Received: by 2002:a05:620a:8509:b0:7e3:35e3:3412 with SMTP id af79cd13be357-7e34d9ac2e5mr834614985a.34.1752918217023;
        Sat, 19 Jul 2025 02:43:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO4TN2m1HCMk2uK61roXdJAndfjxoSfPKSTjVyKPnhMXeMW5zR1fepHcMLF91nfBnN6lMC7g==
X-Received: by 2002:a05:620a:8509:b0:7e3:35e3:3412 with SMTP id af79cd13be357-7e34d9ac2e5mr834614885a.34.1752918216533;
        Sat, 19 Jul 2025 02:43:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31d7c7basm652746e87.94.2025.07.19.02.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 02:43:35 -0700 (PDT)
Date: Sat, 19 Jul 2025 12:43:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, quic_lliu6@quicinc.com,
        quic_fangez@quicinc.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-gpio@vger.kernel.org,
        quic_xiangxuy@quicinc.com
Subject: Re: [PATCH 7/8] drm/msm/dp: Retry Link Training 2 with lower pattern
Message-ID: <w66xyhu5w7ajpkennvj24cad4j6izvapsp3reyla7iui2jdgkx@d43b6z3qw5tj>
References: <20241129-add-displayport-support-for-qcs615-platform-v1-0-09a4338d93ef@quicinc.com>
 <20241129-add-displayport-support-for-qcs615-platform-v1-7-09a4338d93ef@quicinc.com>
 <CAA8EJpoN1qBHyZrQJT_=e_26+tcaKRnSrhtxrK6zBP4BwpL=Hg@mail.gmail.com>
 <b4345b9e-62c6-470d-b1b0-4758cef7f175@quicinc.com>
 <xlmgdysjah3ueypdrdu5b6botvidb2wn4rfm4qpeysclscmuwy@vpfv2ymprblj>
 <b4e1ea54-ff3c-408e-8716-f48001ec9113@oss.qualcomm.com>
 <d427de7d-76ac-4e5b-b79a-3b7638a8e7fc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d427de7d-76ac-4e5b-b79a-3b7638a8e7fc@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: jtCdv03udChlAUyAX6sFQTZCntKq09wF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDA5NSBTYWx0ZWRfX10kxkx8Lviup
 FIv854lX84U0olA2zObp2qb+W3XtqxoIC/SkIByAc7gPcpSit2MS32X2jbcZ6ZVJjHMPvAib1cB
 rL+J2OeVtigHdGrSP9PnmNnTXoosxtbY1x+9pAOqXdOgVbEJppDaxkqUveYVuLWFtKfvUW9x9To
 +juaKrLgRO9jmtDKVwu2DuvlegSXum3zaW+1HgRA7/hEFn+48Lz7W/YWlxLPQRuNQs2BOPqMx2+
 6J8B/adasJtmZfQ0dhkbY/Ggl4w7CK2++1j/2FLnQ3jL+3S/KCszQQtKayOkLBjTApjqaTi8jf6
 LZoKk4BEMw5b40e8nwZzPeG9pYtXPiocxZ2eySjVKM17FX5X/38RtNXQQ2hPWb9iw+PM9zQgA/5
 NvHNVy3JwbIlCMvHXd5vX+C/xFmmYZXivZ92h5vS9R39+E6MlNb8kzXKodPLxfK49QMYYYui
X-Authority-Analysis: v=2.4 cv=Navm13D4 c=1 sm=1 tr=0 ts=687b68ca cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=YZjHnbvoZT85EzRjquwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: jtCdv03udChlAUyAX6sFQTZCntKq09wF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507190095

On Wed, Jul 09, 2025 at 05:16:02PM +0800, Xiangxu Yin wrote:
> 
> 
> On 5/28/2025 4:49 AM, Konrad Dybcio wrote:
> > On 12/3/24 3:07 PM, Dmitry Baryshkov wrote:
> >> On Tue, Dec 03, 2024 at 04:13:22PM +0800, Xiangxu Yin wrote:
> >>>
> >>>
> >>> On 11/29/2024 9:53 PM, Dmitry Baryshkov wrote:
> >>>> On Fri, 29 Nov 2024 at 09:59, Xiangxu Yin <quic_xiangxuy@quicinc.com> wrote:
> >>>>>
> >>>>> Add a mechanism to retry Link Training 2 by lowering the pattern level
> >>>>> when the link training #2 first attempt fails. This approach enhances
> >>>>> compatibility, particularly addressing issues caused by certain hub
> >>>>> configurations.
> >>>>
> >>>> Please reference corresponding part of the standard, describing this lowering.
> >>>>
> >>> Per DisplayPort 1.4a specification Section 3.5.1.2 and Table 3-10, while the standard doesn't explicitly define a TPS downgrade mechanism, it does specify:
> >>
> >> Anything in DP 2.1?
> >>
> In the DP 2.1 spec, mainly on section '3.6.7.2 8b/10b DP Link Layer LTTPR Link Training Mandates', defined 'LTTPR shall support TPS4'.
> The other parts seems similar to the 1.4 spec.
> >>> - All devices shall support TPS1 and TPS2
> >>> - HDR2-capable devices shall support TPS3
> >>> - HDR3-capable devices shall support TPS4
> >>> While these capabilities are explicitly defined DPCD for sink devices, source device capabilities are less strictly defined, with the minimum requirement being support for TPS1 and TPS2.
> >>> In QCS615 DP phy is only supporting to HBR2, we observed a critical interoperability scenario with a DP->HDMI bridge. When link training at TPS4 consistently failed, downgrading to the next lower training pattern successfully established the link and display output successfully.
> >>
> >> Any other driver doing such TPS lowering? Or maybe we should be
> >> selecting TPS3 for HBR2-only devices?
> > 
> This logic is porting from qualcomm downstream, 

Hopefully a downstream has some sensible commit message which describes
the issue and the configuration to reproduce it?

> For other device, only found in some older Tx chips like i915（intel_dp_training_pattern) used the maximum hardware-supported patterns, but not lowering.
> 
> According to the description in DPCD table 2-232 003h, From the DP spec perspective, it appears that all supported cases should preferably adopt TPS4, as it is more robust.

If other drivers don't perform this kind of lowering, I'd prefer if we
don't perform it too.

> 'DPRXs should support TPS4 and set this bit, regardless of whether the DPRX supports HBR3 because TPS4 is more conducive to robust link establishment than TPS2 and TPS3.
> 0 = TPS4 is not supported.
> 1 = TPS4 is supported (shall be supported for downstream devices with DPCD r1.4, except for eDPRXs).'
> 
> Although maximum capability of QCS615 is HBR2, but the actual pattern supports TPS4. 
> From pure design perspective, it would be cleaner to drop this lowering in next patch. 
> > Bump, this patch looks interesting and I'd like to see it revisited if
> > it's correct
> > 
> > Konrad
> 
> 

-- 
With best wishes
Dmitry

