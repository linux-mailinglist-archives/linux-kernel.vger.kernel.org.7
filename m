Return-Path: <linux-kernel+bounces-895731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FE1C4EC9D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E0244EECAB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70E8307ACF;
	Tue, 11 Nov 2025 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NAPnnkBW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DqgTjRT1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A7334028B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874876; cv=none; b=QC1vHNR1U411tqUhQsckx+fcJXs21g5pbPN9N+eParO2qSoIxnuFOpWMclelE225uoL0uxFiJMq3e0EVQ4/0K7yOzCEvaNSMJzNm+lts4qDXrq7jWbj75h8sQMVPfgVJd57yR6EIszyVmaxq9+EAd5Wp9lELZBRSzuiON4HbAZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874876; c=relaxed/simple;
	bh=bU5zpPHPsVJu3Zi2/jYd6pKlJGiH3hqZ+v3AqPgSrdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLIJdeGOL+o9whYOYMzFTSvoCQo9b69FZFOWkDhHtMBNLWu70tN2gnVBYRAEw8kw4XfzurQgnoB2eugyO4IGlyQ+Ajjhi8Fv/ts05ewNbcTDxTdfdDIwcbXsQMdE7Pm4/Q0sjvutMwMicuP7Jghu3FzxFONp9BDDvyEnn5nUXIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NAPnnkBW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DqgTjRT1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGY4g1937371
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XyMhRazRo/qwa+YX4Uby/IyavwjBYRDEhF1Ft8RepQs=; b=NAPnnkBWq50DLqDh
	SwYOAx1NTr+g3xYlCXKnJNW6bYRdqp91/IdksQdsRspRhVHxJb077yDf3TmIgDdJ
	bpkbg4QuAURRbm69tKb8uUL3V+DF69o9cne5gdQuqrDlOoxBWgl30UfLq3PeHncF
	0RhEbvnPDiVQQNl1VP2dKMD2ePbxwFqqEMOXA/PzqBodlaepSZCriSh9PKt/7pl/
	THWOTPa+TeC18y+CaTvaGE5tiQMtks4s5cIOQkVtgSW3DSquXGJswOpC3i3u2y1x
	ENxNFM+23MArsj3IeaG2iK+gBuKo6jWzWeJTvY6JVftZPv/yWGDXBOx8cwAumnRN
	/7O9tA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abwtj9vun-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:27:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b234bae2a7so494839585a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762874872; x=1763479672; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XyMhRazRo/qwa+YX4Uby/IyavwjBYRDEhF1Ft8RepQs=;
        b=DqgTjRT1yzNmM2YzhjXqAGqWildSVNAA+otrjiXlqXE+3EdmsO0/VfUfPmP9cQFyBy
         Y+84xYvblqAxL2RiNTqxlYLk/iZO4q/YUbR0BkqDf39fbQEkt64vfZ7j+P0jPtGi96tL
         zhzy3K0l033HlcUT4TDuiDGTpCekaZI98C/mOEVHsv3/tbvvZbP24XGuifdR63RyikYs
         kWJZPpy/5KteCqbnDjr/Kjm2uVPNzBysrvIdfzXmqEJUQmLDFuF5g89y6/Wtzg0RaEr4
         UDNKdDgWXiVV62fdcCe+C4KMm1J9jGMdE6LObTuZhXI2AOQdHZkScH7YO3DHVjHkevqF
         n46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762874872; x=1763479672;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XyMhRazRo/qwa+YX4Uby/IyavwjBYRDEhF1Ft8RepQs=;
        b=fsHbNaJY7Pvl+ietnp1j/0TW+soh67W3imQ6INZOD09kQQ8LXlFWDFSg5UYunF0GY8
         JctZgYGXClWJJMRI+2kmIuRzZ5fyNYD20bbRsxq3pUdY3PddqD0j04QGxLGR5UITSdbD
         fGbbSVq/eyM3rmpuOJ7oxJkWN+yr7rd6URrm0284aM4nckDEZ9RR58s2M29gEntWGTDy
         fai6FD7YrhfD8D+fbkyrB0SY6wZVrxq0Wm9lZ5pW1Rb60XV12mcK2DYThOIunXRq2+H/
         HLSX6RHaX714BiZ+7OPKUWPgt4OynfStd2Ifc2tlWnWtkQckbX9wTMghGdyus89h8siv
         JcSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjIc5tOhj6xpe8UuPzCCyL5vwxS0jmy9Q3Az9cgYOiJvKjFNZiY9hAlXCE8hZxuTb1b9FDJCoxr48YWjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztd8GnCj6QYryhzt5RfIbdRW252b85png/IgaznYVymENxFLZr
	MvFqU4DJTXYiTq/1VO3w7M6z6xu6fyUllwHqGBUnpawtgB0g7IzMvdvsG75zEswmfcOrHm+ULF1
	cFrTvXPBGwLKN4TEPKU/aNX31y+BRGhAPSv5SHvPMAKQW1j+KW8oDCgIARydeD2YEzP4=
X-Gm-Gg: ASbGncs9w0Fj9rKnMhSIJMosujey2f7g5kbMRZkj2Q4UkX8pI/tmYx+bOskiZmxHliW
	R+s5k268lORLeK+qpQ4RNalwZvS0GaA6N0dJNlJWt9WmvPyKRSt4SSV4aKW99gKAqxNLSBBojwO
	C82NhPFJ84eBq5g1xOd/06dk9uiLug3i4BgQ7yZteiEZpOCa7njswbvM9vFUU4J319lXVrwpMWS
	GIOigMEaYmnbimF2/FXZyzYsI+bX4DxnI0zlJXVk8zytdoo0kuRrTtBZL/M5L5S+BZqbJkqxSKW
	/Hb2MgEA4eKiIFHVir5DXNGyRGyOazhWa4zLPHOlHiSo693E1r56Wjk3rvVXMQEiYmpiXpioDhC
	4mu9andimoo18LfD2V70rM11rBGP91OCXjnTn97k157BRfi8GT3ucrQ1WIcuDo2FSTumJ2KsA4s
	Ks1a/IBrL61iQA
X-Received: by 2002:a05:6102:945:b0:5d6:155c:33aa with SMTP id ada2fe7eead31-5ddc466ad31mr3702296137.16.1762874097542;
        Tue, 11 Nov 2025 07:14:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdJkveTEY1J/ukmmCrn3GGvD4NI1L7VolRvROA7q3wFctCerZvbwGp+UbnlPjyJfLWbnGFHg==
X-Received: by 2002:a05:6102:945:b0:5d6:155c:33aa with SMTP id ada2fe7eead31-5ddc466ad31mr3702274137.16.1762874096968;
        Tue, 11 Nov 2025 07:14:56 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a014348sm5114344e87.7.2025.11.11.07.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:14:56 -0800 (PST)
Date: Tue, 11 Nov 2025 17:14:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Amit Singh <quic_amitsi@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, konradybcio@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_riteshk@quicinc.com,
        quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Use 'edp_hot'
 function for hpd gpio
Message-ID: <rqufdgme5cmtbvharugka2zc6c4g4am4j6enrkanc6uaxdbr77@dlptsjv7u7lr>
References: <20251031085739.440153-1-quic_amitsi@quicinc.com>
 <nzg7auudxocxnpnjsc2emot7sgh5azvucl72jqzgqsp4jhzint@hykb2xyx66uh>
 <c6ef0324-c932-4c80-8252-97dd3ee255d3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6ef0324-c932-4c80-8252-97dd3ee255d3@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDEyNSBTYWx0ZWRfXzSb6m6w0DGb4
 dSuNVsa0Dgxm5c3m06faiKTCUKqaqNJeN4rHxlBaTwiMG5nKqzQD18BfHGc64EkxT+zyMfAEWxa
 Tyba4AsP1oIJIoMKel7G+Po5CbzB7AmWKbPzeRZqaT+ZFVzVy5l4bO4L4hPoVMycWqgIWVi2QSo
 bLCuYYNz+fTmVtllxImGPSlOHeVm9zw7/M1S6RzpXj3Fm1w8uGsZkfY228VqxEYDjm73vy1hb9Q
 31LfaUo/NLPxGWyHy+NJeBBVAZ92OaVLGuSVtZnExYGqrp6prbJoresPWXIQD1PJ0A894ZR+rE5
 iOsf9P0symNcL4UebthnhotZKbccF7EaB3sREi88gQ6uGQLWFAhFtZ09OL6c22q5JOmwMWZbPkM
 CYIME8G4+hi9HKLk3T/O666UURaiBw==
X-Proofpoint-GUID: DWnowf-IPFvwcZk1RqoFJVG9h2PZrxaB
X-Proofpoint-ORIG-GUID: DWnowf-IPFvwcZk1RqoFJVG9h2PZrxaB
X-Authority-Analysis: v=2.4 cv=UI3Q3Sfy c=1 sm=1 tr=0 ts=691355f8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Nr2CiOlU1OI7hOkqFEcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110125

On Thu, Nov 06, 2025 at 03:01:07PM +0530, Amit Singh wrote:
> 
> 
> On 11/2/2025 12:29 AM, Bjorn Andersson wrote:
> > On Fri, Oct 31, 2025 at 02:27:39PM +0530, Amit Singh wrote:
> >> Currently, hpd gpio is configured as a general-purpose gpio, which does
> >> not support interrupt generation. This change removes the generic
> >> hpd-gpios property and assigns the edp_hot function to the pin,
> >> enabling proper irq support.
> >>
> > 
> > No, it replaces the use of display-connector for hotplug detect with the
> > DP-controller's internal HPD logic.
> > 
> > There might be good reasons to do so, but you need to describe them.
> > 
> > I'm guessing that there are still some issues in the DP driver's logic
> > for handling of external HPD? This should be addressed by fixing that
> > logic in the DP driver, to ensure that this (display-connector +
> > hpd-gpios) works, and then you should send this patch again explaining
> > why the internal HPD hardware does a better job.
> > 
> > Regards,
> > Bjorn
> 
> Thanks for the feedback and clarification.
> 
> We observed a specific use case where using the GPIO-based external HPD
> handling via display-connector leads to a functional issue.

You are describing driver behaviour. It is known that this part of the
DP driver is broken. There is nothing wrong with using HPD pin as a GPIO
in the DP connector.

> When the DisplayPort cable is already connected and the display is active,
> and we perform a system reboot, the display does not come up automatically
> after boot with the current configuration (using hpd-gpios).
> This happens because we do not receive a connect event post boot —
> the GPIO-based HPD path does not generate an interrupt in this scenario,
> as the line remains high and no edge event is triggered.
> 
> However, when we configure the pin with the edp_hot function and use the
> internal HPD logic of the DP controller, the controller correctly detects
> the HPD state after reboot. The internal HPD block generates the necessary
> interrupt, and the display comes up automatically without requiring a
> replug event.
> 
> This behavior aligns with other Qualcomm reference platforms where,
> if the controller’s internal HPD is available, it is preferred over
> the external GPIO path. Using the internal HPD provides more reliable
> detection and keeps the configuration consistent across platforms.
> So, this change ensures:
> 1. The display recovers correctly after reboot when the cable
> remains connected.
> 2. We leverage the controller’s native HPD interrupt capability for
> better reliability.
> 3. We maintain consistency with other DP-enabled Qualcomm boards that
> use internal HPD.

I think, this DT might have been purposedly written in order to show how
the HPD signals can be coming from the GPIO pin through the external
bridge. As such I'm really reluctant to ack this change.

> 4. edp_hot follows the Source device behavior upon HPD pulse
> Detection [VESA DP standard v1.4 section 5.1.4].
> 
> I’ll add these details to the commit message in the next revision.
> 
> Thanks,
> Amit

-- 
With best wishes
Dmitry

