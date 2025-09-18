Return-Path: <linux-kernel+bounces-822215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ECCB834FA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2693A48598B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76B22EA75A;
	Thu, 18 Sep 2025 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XongnQpY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67402248B0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180356; cv=none; b=nGSdQHK9TIW39moZQQFHxefaMgWjDZ9wotd0j09r6/qT/ybzOswc8OVCTseaxptLIkvGryrhA/SWwE0tKyC4mLbMDruQm9JWqDWaq/y/22IOj0Ogby1eH7vZoXFY70ZT5SvWEx/nMNHOUKAjvRfCjdoKalEiCVcsas6Osovr67A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180356; c=relaxed/simple;
	bh=45P+u1tAv3iIaIuLoskmjiVZLMeXMtR6uk2qfhZEw8g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYag5oRugtBMSqQNfH0SDGDACKas43XG7+GvfbcrCibwGto+R6nISVTyKK1pCTUlhqFNKlo4aDlhRfpf2kShVWfc+0EcbtiLf/WiPAvV6+Fg0HpZmTqgb0yH+iot/qCMlOqgEcvOQHYtbQeHnRXyAD1DmBY2GFo0GYGPkY2azRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XongnQpY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HMbIf5012608
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wgWSHIxJ74v4zLjsbadVyxzqod/mpaz3qAfwUznSiDQ=; b=XongnQpYkvgKvGVn
	VrnFIzKfWLlxMzav2ddn1gCVtt9Sm97uJ+egvupvTqanEq8wS7JR6IArYo6fR+eQ
	cVAb0pjcFDQfyKAhAnoy9ai0SA6KxCVB9jIvKm3tTtFeRJNOIMnng1jJlqPNybJW
	Blhi462XecdgtTCATGaNjAWHmFTnoZ+1fnfSbwDuUA7sI3Jh8521ycaOZs3P/by6
	/yZoKpRDd1tc4E5RI8eVomU0SX6jAxsqbPNlxsFd0H7YqCCcptDUP0MKeyjtC4me
	kzscr/EvrYgOpM2ywukseYup8MmBrwz1i2INr/5brPR/Rb1psu+jyabLcXrZT1yt
	/gkn8g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4985wx1a5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:25:52 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-78ea15d3583so10578676d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758180352; x=1758785152;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wgWSHIxJ74v4zLjsbadVyxzqod/mpaz3qAfwUznSiDQ=;
        b=Xo3IVU+1FGZ8qBvGc4ofD0gHDM8/IO1eGJCbfht5+wJxYdwvkaxM69nWxW/AfbRZ2z
         xdRMZgBilemH3dL7NZ8YJpr5qbIptmtGpB21ADGnigzGPBGrSKDEOaq4dnoLJdfgfhuU
         ow5BszM2bIXhrQfheHanMKrv6QwSII4tSlegO/Y1JCv2uBaLekEtsOfPbOvSWGSrGxAX
         kIcFausyq7l9fltFkn4r1gYi21AuhmlgThOWhWNKE0ek16nZwXan2QesLOkHfhctfmEK
         WS2oHoKADQyeY1bXfrU29H6fJAv5iBE2qpbWLK2uroJ02WhO23MXPcfVYYxiD1dJ9asC
         Gdvg==
X-Forwarded-Encrypted: i=1; AJvYcCUBtBc+mCGLZ1SKyVIkBRCKzIIqUh6P71U8tjS2XHCZRlJJDfmOHAk0zd+upqctVb4qxuq+dbkbZb4Bl1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYoMOs9UhIUUDKDnK86OGOsmSxZ96CApUNMSypGwS3SzsucAeG
	wRtrqttgDzkIdoTrexQNvwXHn0REjCd1fv34nroYqbNnZExz7EshEb+XStI4rnxi5DdpPOmQuMh
	QXongZvs3LwEgncJoix0POcrelelQZMFxxo2Ee26FzNXzEPtHKGbBsVg4NfPkytu2VS4=
X-Gm-Gg: ASbGnctcwFU0nM8LqJuMFewMH17KOczvJJ/N6Ubndi551tKC3BxBrdSjQ8vRHIIbaNk
	od1w2R5mDF2aPDQydfVeT+wRbHqfYwYNpatIpMuxDxdyUp1PtcWf4YBoqvPNafYVox3mq4CN1fY
	99OwFXJRYewjNHVtZYkjuwoMGyau0NQXts+WHidghvTRgQ9Wa1R0uUYeVpn/X6KLFQKGbEK4eds
	nV7Dhj8gKCUzjDpHxpkXK96Eb+mh6QkymUj/Ibi+2neVvcWxSDu8KxKjPAsXpFmBfmP8CT7tNUX
	DcjaeEfe0wRpkvQOpL1SqtWxA2y1EkzHFqNu9riEu5Caf2JaReTgBnhiSjqCRpxx+980zm1B7n0
	=
X-Received: by 2002:a05:6214:c22:b0:792:d0c5:7155 with SMTP id 6a1803df08f44-792d0c574efmr21812646d6.18.1758180351834;
        Thu, 18 Sep 2025 00:25:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNAnAVp347GePapB/xQ1YAYCNvzrXi3Zwnb7APYVakX2+Y/D3TUU0hrhQldlXBUl+I3q+K5A==
X-Received: by 2002:a05:6214:c22:b0:792:d0c5:7155 with SMTP id 6a1803df08f44-792d0c574efmr21812416d6.18.1758180351169;
        Thu, 18 Sep 2025 00:25:51 -0700 (PDT)
Received: from trex (152.red-79-144-196.dynamicip.rima-tde.net. [79.144.196.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f4f9f339sm30217505e9.14.2025.09.18.00.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:25:50 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Thu, 18 Sep 2025 09:25:48 +0200
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Praveen Talari <quic_ptalari@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, alexey.klimov@linaro.org,
        jorge.ramirez@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        andersson@kernel.org, psodagud@quicinc.com, djaggi@quicinc.com,
        quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_arandive@quicinc.com, quic_shazhuss@quicinc.com,
        quic_cchiluve@quicinc.com
Subject: Re: [PATCH v2] serial: qcom_geni: Fix pinctrl deadlock on runtime
 resume
Message-ID: <aMuz/C1iT8JtjXbQ@trex>
References: <20250917185102.3763398-1-praveen.talari@oss.qualcomm.com>
 <dab18f70-4017-4c06-92c1-91cfd2229540@kernel.org>
 <8e2781ae-34d2-4009-bf8c-56aa1bb6fe85@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e2781ae-34d2-4009-bf8c-56aa1bb6fe85@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 4TW2Kv4vO1I4VzGsOupBw1yiPqUVSpm-
X-Proofpoint-GUID: 4TW2Kv4vO1I4VzGsOupBw1yiPqUVSpm-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDIxOSBTYWx0ZWRfXwV3GW6QCFdsg
 pjlKXOOCmoALl1bfW2rYj/1ajiRfZBJJOgJAo0ugEPco4VlrHAXXKbLF6c7KtwUxeMzWffEDSIy
 Veahf4aemTPfst3ovuwWKGDQ8yYHtWzZkVXY/2btnboRDhuMm890ePDbgHCh9Ez2MXMQOu6sBZr
 JZRupk6TeKC3ODI62B2pODM5vDrvllDYt42w3oLlq6nQ4vnD6zGfbNRjP58GQ3tyXk3AUvj9IsB
 iW/OesAoGiwVL28LvskhDtqa9cVTz/PmuJy8Hzmv9DpaQ0lPwEilp0kVoC8pEG4nEtkJxx/xFFz
 Gvi+bk7n2J+Jr+ZV+z+w9k09Y0gxLJCGCAgquc0YMMrAh+M+6UB5HkN9K7j3i3GzIW2IQPxCzqG
 fTX691TG
X-Authority-Analysis: v=2.4 cv=Fq8F/3rq c=1 sm=1 tr=0 ts=68cbb400 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=UlsMzGb/nx+Jy78HFkoo8g==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=6bHfGmxriAW5vq4Uz9YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170219

On 18/09/25 09:25:53, Praveen Talari wrote:
> Hi Krzysztof,
> 
> On 9/18/2025 5:28 AM, Krzysztof Kozlowski wrote:
> > On 18/09/2025 03:51, Praveen Talari wrote:
> > > A stall was observed in disable_irq() during
> > > pinctrl_pm_select_default_state(), triggered by wakeup IRQ being active
> > > while the UART port was not yet active. This led to a hang in
> > > __synchronize_irq(), as shown in the following trace:
> > > 
> > > Call trace:
> > >      __switch_to+0xe0/0x120
> > >      __schedule+0x39c/0x978
> > >      schedule+0x5c/0xf8
> > >      __synchronize_irq+0x88/0xb4
> > >      disable_irq+0x3c/0x4c
> > >      msm_pinmux_set_mux+0x508/0x644
> > >      pinmux_enable_setting+0x190/0x2dc
> > >      pinctrl_commit_state+0x13c/0x208
> > >      pinctrl_pm_select_default_state+0x4c/0xa4
> > >      geni_se_resources_on+0xe8/0x154
> > >      qcom_geni_serial_runtime_resume+0x4c/0x88
> > >      pm_generic_runtime_resume+0x2c/0x44
> > >      __genpd_runtime_resume+0x30/0x80
> > >      genpd_runtime_resume+0x114/0x29c
> > >      __rpm_callback+0x48/0x1d8
> > >      rpm_callback+0x6c/0x78
> > >      rpm_resume+0x530/0x750
> > >      __pm_runtime_resume+0x50/0x94
> > >      handle_threaded_wake_irq+0x30/0x94
> > >      irq_thread_fn+0x2c/0xa8
> > >      irq_thread+0x160/0x248
> > >      kthread+0x110/0x114
> > >      ret_from_fork+0x10/0x20
> > > 
> > > To fix this, wakeup IRQ setup is moved from probe to UART startup,
> > > ensuring it is only configured when the port is active. Correspondingly,
> > > the wakeup IRQ is cleared during shutdown. This avoids premature IRQ
> > > disable during pinctrl setup and prevents the observed stall. The probe
> > > and remove pathsare simplified by removing redundant wakeup IRQ handling.
> > > 
> > > Fixes: 1afa70632c39 ("serial: qcom-geni: Enable PM runtime for serial driver")
> > > Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
> > > Closes: https://lore.kernel.org/all/DC0D53ZTNOBU.E8LSD5E5Z8TX@linaro.org/
> > > Tested-by: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
> > 
> > Where did you receive this tag for this patch exactly?
> 
> Since Jorge was involved in validating the change, I’ve added him under the
> Tested-by tag.
> 
> Please correct me if I’m not supposed to add this tag myself.

let's test a bit further Praveen - we need to validate/trace the wake
path on a real scenairo to make sure it is not cpu intensive (although I
suspect the 2% was due to the storm you described more than to the code
path itself)

I can then provide the tested-by on the list.


