Return-Path: <linux-kernel+bounces-796112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D74B3FC12
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602852C19CA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D1B27F18B;
	Tue,  2 Sep 2025 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iJa1aZtN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED7227F75C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808361; cv=none; b=kiuGImcpqimbB2nLVC+U1fIeKKnY2rVcYOJMTNBb9bQAFRQP8yv+KQG5hLfrW6iuGXJHGaODJVHyZTfpb5e5mTHgmJCsvzQRVsOJZcNIF7/7UgCsQA8OiDD3/hzaed8EJ5LH2O1hG1DSlSL+SBizHc5ee9s5YjvPwtuSq9gUxII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808361; c=relaxed/simple;
	bh=FSegoTi0JyiRxfOzc/dPsCA4YdptcJJvDsAwo9nEghg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQGkCKNxWv1W2O8vYCtwmapc0VPMfvgkCvRfVYq/vNOQQGFprkAL8h8yhkuxhJIGrr4emA0ZIXUVKtTEpNXr0onlNhE1cD+xKPOFeIPPZ/YlaRqzYnumJzIItsY+KcIfX2gdjqHMlVh5oU1PEVZ8KNk77psMbuaNea7tsF5HlA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iJa1aZtN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RngB029949
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 10:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	br24zZfPUMh2y5hphW6eSZrx2KUZEQPgg53oVJYo2X8=; b=iJa1aZtNGpYUsLtH
	m1ASUdi9WGVZUi0Z49LkP+EvwspangHxNaWLIMdnNHvetGnlp4ED/YlZPhZRziSE
	ZwHP2SWGpvO5791IK5bvAGBDV2yr6OPvPIiFQ+mTOaBT7xDmhxLEryuErswaUDGr
	BcZ/QGtbAu8UnRYzUZqwJ71NT66l682265rzx9lPYlkC9aOUvX39Geexba7Z0l/L
	GhzZy02uYiaqenl8frn7LcCDeflWRQtQR602svxMh/JV1ASRE3rNaixMVqsDg4SR
	C6d0yZqMpy2R3wrQXQFyiCcxwYJMZDjP+4BjoTnAmtNhp6Vtye8PaAque6jQ63v3
	xVTv5A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush2yb5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:19:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24ab0409d3eso41724585ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756808358; x=1757413158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=br24zZfPUMh2y5hphW6eSZrx2KUZEQPgg53oVJYo2X8=;
        b=S440DIUYdxqDnLeHSCHQ9JWm7x7itoSmyOBaYyzP42VXDvGl5+z+vtxJeqemDPUuRt
         K+pKr7kJuVEpt4/jdhhQbXgphnaJbkgbHM5tpnNUbd5Fwo2Dic5iJXRqikFR7nAATkgl
         g+WK4DeEzDNcjvL89sxw3IZS3YzIYB4R4Q/Uipfj1zZ4LAsD+dxhV7tr3D1XBGWxQQpk
         EOMMXziiaZ2kBmOchbLKzui4f+U2OHddZ4a7YPhh++WaclgQRe9Bh5AFZd2yKKtj/Ks2
         T8DWTQWCsR2bxZKpxZMDOv0vE6U47mTe5RpUeSV95bn0QxbOblr4QL7xwm0hAKlTshnN
         OxrA==
X-Forwarded-Encrypted: i=1; AJvYcCU3ndwEullagqqsJSiioUj389mZpdfcLbgb6SSWfj77xju6dGCU2Kuxu4qj0oyPurTi+vTqwEo521gvKo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSek76hcO+JZPAN7NsDgzhh5nNezMIT5TQ74Y1YiR/ZO1RogTX
	dPNM94s9nfUiBBnWu67ZyYIGmodfJriH6XC5PBmG7PPXSATJqzqlcIqEYWTENcUsp8cjQv/AX4E
	V2x6VJ2J36lvnQFbMHDYs2ZF3njeSsVjo10Hs6qEVje1xI7c79AG7K3co3UWV7ntdiRE=
X-Gm-Gg: ASbGncvoIlrC1yyNmUCm+GS20q7hX/Lw9BMDV5MIpjulqek7edwIPU7r2K3ny9qLYII
	mTrLBaHUc0k4ijO2vaEOEPpVm63ZyHno/PKQFcipS1d7DVMRMjv7CN/v3cOUpvUi/eECHUlGn1u
	krOK77REWUgLW3Hg1/nXnZGVgwNwtIVTYMkE0QXtkDQ7fgSkW2enVm2Ne30tgx+KBe6056xrxeM
	cpkVnUMNTjKn2kFMFgGM0pqoASXDU9XJ++LgiWyovuMRv5F/YuLCd78M/tOqZIgh/+r2d/L4hXQ
	uyita2DwxO5d/u6vsuXx2Ydbh6NU0LsLFlwfiCGmfFqKRpC2TA2abRFRIoGnlWrGNZewhe1MuNM
	eUiMvtHFJUzAzQk3bEiF8HfpWTWxoeA==
X-Received: by 2002:a17:903:2ca:b0:246:2afa:4cc with SMTP id d9443c01a7336-24944accdccmr125619005ad.42.1756808357947;
        Tue, 02 Sep 2025 03:19:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExZaQpujI+DBeEgb+OY+oIAOGhyp2Ov4L53Do99REhENCXH8YvVx3wL9zFdzC8VQf9tej07A==
X-Received: by 2002:a17:903:2ca:b0:246:2afa:4cc with SMTP id d9443c01a7336-24944accdccmr125618675ad.42.1756808357534;
        Tue, 02 Sep 2025 03:19:17 -0700 (PDT)
Received: from [10.133.33.25] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249065899f3sm125975505ad.113.2025.09.02.03.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 03:19:17 -0700 (PDT)
Message-ID: <d7141b57-fa3c-49ce-9830-8310a58b9581@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 18:19:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/38] drm/msm/dp: remove cached drm_edid from panel
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-1-01faacfcdedd@oss.qualcomm.com>
 <otmy4kttxflsxkvacwdsqynck4nqeww7jsxaq2xwjtlooxnhvx@gmpezdliskck>
 <5b142910-81e7-462d-8933-70705334ef0a@oss.qualcomm.com>
 <yarnaujunszlfrbduakodv7n63wjgh6og3t4qowhu3n6tz6fmn@4kb4crd5rqq7>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <yarnaujunszlfrbduakodv7n63wjgh6og3t4qowhu3n6tz6fmn@4kb4crd5rqq7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX8aVC/9tpWHUf
 tju+W34as7ck2uWFzBlwuR3SxpXGRJSeQ1IiJRBIlfdquWd30IM8fKEtUts5dK7hLUlQwGqY/jd
 a5rPkrhLK332qYa/XYQ2CnaNLtWbBsIm0UfJVwaXibO7bpl11K4y/WHFQgN6PTC7Y4QdKgWVxbf
 IWNGWU8uJPl5QBQ7n0BJKfOKl2/tF04GAEwTQU4fsVLAz4vm3Kc2TgMMSAeShOtQZv6ZHGVqIU8
 RwKlnrWH9W/LJE6nbLck9Bgmxr6zjefNz3ySsh1952B/FZxwgVn2QBnguuXp99auawWXjj3/chk
 cNPDCNw1I+11KwWdKaak7mwPPx6IKGHiDVyLW8I8w1/VbQgn+VAva7KQ9LHZNU5nO3NE25a47R5
 BRXr7XSx
X-Proofpoint-ORIG-GUID: pDQb17qIwZefRDbyYWqMVVmlVKXMQNok
X-Proofpoint-GUID: pDQb17qIwZefRDbyYWqMVVmlVKXMQNok
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b6c4a7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=PD6ve5_SbK8zx8cgC-cA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032



On 9/2/2025 5:36 PM, Dmitry Baryshkov wrote:
> On Tue, Sep 02, 2025 at 04:42:18PM +0800, Yongxing Mou wrote:
>>
>>
>> On 8/26/2025 12:41 AM, Dmitry Baryshkov wrote:
>>> On Mon, Aug 25, 2025 at 10:15:47PM +0800, Yongxing Mou wrote:
>>>> The cached drm_edid in msm_dp_panel was redundant and led to unnecessary
>>>> state management complexity. This change removes the drm_edid member from
>>>
>>> Please see Documentation/process/submitting-patches.rst on how to write
>>> commit messages. Please use imperative language instead of describing
>>> the changes.
>>>
>>> THe patch LGTM.
>>>
>> Thanks, will update it in next version. Since the HPD refactor series are
>> unlikely to be merged soon. Can I separate out some patches from the MST
>> series that don't have dependencies and send them individually to make it
>> get applied? This would help reduce the number of the MST series.
> 
> Yes, of course. Please keep version number monothonic for those patches
> (e.g. by telling b4 that it should start from v4).
> 
Sure. Thanks,  I want to confirm whether the patches should be sent 
individually or grouped into a series? They seem to be logically 
unrelated. I was originally planning to send each one separately.>>
>>>> the panel structure and refactors related functions to use locally read
>>>> EDID data instead.
>>>>
>>>> - Replaces msm_dp_panel_read_sink_caps() with msm_dp_panel_read_link_caps()
>>>> - Updates msm_dp_panel_handle_sink_request() to accept drm_edid as input
>>>> - Removes msm_dp_panel_get_modes() and drm_edid caching logic
>>>> - Cleans up unused drm_edid_free() calls
>>>>
>>>> This simplifies EDID handling and avoids stale data issues.
>>>>
>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>> ---
>>>>    drivers/gpu/drm/msm/dp/dp_display.c | 28 +++++++++++++++-------
>>>>    drivers/gpu/drm/msm/dp/dp_panel.c   | 47 ++++---------------------------------
>>>>    drivers/gpu/drm/msm/dp/dp_panel.h   |  9 +++----
>>>>    3 files changed, 26 insertions(+), 58 deletions(-)
>>>>
>>>
>>
>>
> 


