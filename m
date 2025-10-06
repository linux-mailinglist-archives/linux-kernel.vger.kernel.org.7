Return-Path: <linux-kernel+bounces-842782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1710CBBD921
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 12:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C6684EBCEF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 10:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D52321E08D;
	Mon,  6 Oct 2025 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NQ588+Dh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9C521D3CC
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744953; cv=none; b=O2+4J2dQ08KPLMxn3T11pDMHOO67SEG/rGOU3ult6CkLkS2VtFsQxpzTfmNz9gcqVoKw5mz1EoyCALpfvfWjfTF8x2yP+/OcRCRhejVcpBp1s0JbNbWoFPRKVMxAwYg+bYv4I4vRzPP+7W4Wjrz9GU+BBbm8hdjMWK3DeFaH1mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744953; c=relaxed/simple;
	bh=uYq2OzinCLJmg15zNuIyQ2jdLyLbjXj0vIOC4fbBaFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXhSvZuatiVfYI7dOqHii4JW8ht7xXsoKVT3OZ8I58v8MHoGynVrvYYUxLgkCvVlozrH4RUVMOwStdg2weML21UnfQakveNvsZPz+dnJJvUncqlT4QKSjHt4Q43avVjyMehul/+PTS1hIdAw/e6cMQJGc+TpbMC5K5ZPeL5hYEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NQ588+Dh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5962AH7Z002205
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 10:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=emQk5agLRXov7YwB97bnLlbt
	YdyYufIKmyT5dEhdxvU=; b=NQ588+DhRqmfTiF2po3K/IQCh5QcODgFSvxnOvBp
	4IISFD1OSztW8A4BXSxomjt6lKNuAuIrgETuEccYBJiGkLbBD/+vpXn3HnJBouq/
	11uOdZBU54oF+T2EkFKyXVB9KTyss/9HzypZL4NBO2yAC6KW1nHXuPVn2LXLfrRu
	QvZOqBF+jHfqS8kef/+h/M/4Bcpc+sk7YVPid2VHlvJ/lKd20BZPrlDFesXksqkg
	maU7rkwjWUEdd2bFJt7Qu06mOsw0TFZSUmT5AMwGtqq9Gwt6LBlpO9ef24MRkw0K
	ayPvSENTdF5Nv/QprYP4tUt+oRnrzvIztSA+5Ln2g/bgEA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jut1kfp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:02:31 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4dbd8484abbso58613721cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 03:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759744950; x=1760349750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emQk5agLRXov7YwB97bnLlbtYdyYufIKmyT5dEhdxvU=;
        b=Z94vxk9VHQYrqKY35lMB8s6Jkjy8wu4YYv8dkC+7AsjOIhdDZmRXEQ3KO2t460O1v9
         6wfGAqno2lHXME9nlUibb8bznDhmp0DQggOjgCRW1Oa/oWGh8AKzWvc0E/4fSOJ5NHAy
         n0PhuVKt8y5EMSB80K/nwmpCw3CPw4uey499R63B5KsZoIv3+yf0xaJrwxh/V5fLG2H+
         rQQVQEqiLP0sl/c7KqtpephE/XQO2B/NjNjThu5rHfv4hK0mg4njdW4+e+6RlzX8onze
         a1WtqbNMhSWBylEL6je/C2qhgjR4/LoRYhpRvcKMdeBGJiNDLEBLXf5Sv7aGC68hGGjb
         5LQg==
X-Forwarded-Encrypted: i=1; AJvYcCVO5DvTf6FGc4VamCTvQrNrwhTVPM7riNviut1nG/fbp7QcjpQ+5iR++daTjr8rp1IaMgW3UCI1hlSXYt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtbqOpHAgPuVPiyg4IDlFNKz+L1/Zl8cfrA4oE6wJ2oW2EvPUL
	/5fFXP7cXWcoxKdUg03/sbE1YsTCkdYFXwD/XCNM0du6OdLPIB8DMxHPNIs4MEfLNnowbz3h7uP
	CoLhi+Feo90edrhb2bWdnhhR1dbhN8P3NQ3jgl6ZZV2Fncq+Fy/vzW9tqX/huh/NgMd0=
X-Gm-Gg: ASbGnct9m119yDd2lQZz5oOqG4wfih4/EYUROJevxeG7W59CbhJd1dV1yKGlQ0JBxly
	tiKNhFMiuWGfR0xV3ItzC6DHs3oK/FRtA22M3t5CQAaNXIIp7oRFqO3nD3bl6ionT8jLqvassry
	8JuAxS86+CCB8uJHRadV/EmWXJY5O7YPPV3gNtN7o93x+gqUXoCJLXRxHXuK/us9XXIGfUKUa13
	ZqV3WHMCVwSP4OPAnkc9F0nR/4AJ/5E9TLMEexwZOijA0FRn+ozdO3qkswpMyzv8l8exTQy3zlh
	rZsxO7Vmy/uqw6GitM2KoIUI68ggsPMl5U/r43xZUt2+CXr2EwqWrBjNuvPf4y+pPvDqYdgnMxu
	bugOg00nn7cqrQU+aLLz6RifovxDS6ZdzFI/7bpSErd4HeZESCnYGNqM5qQ==
X-Received: by 2002:a05:622a:909:b0:4d2:a1a7:214a with SMTP id d75a77b69052e-4e576adad30mr157836391cf.45.1759744949593;
        Mon, 06 Oct 2025 03:02:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy/JDsMXdS7AYgrpeJ5Yyjg3ZDELYIlzxigHOiHIhaIjrnMXpioVVArym3UE6bvb/Dvdh7bQ==
X-Received: by 2002:a05:622a:909:b0:4d2:a1a7:214a with SMTP id d75a77b69052e-4e576adad30mr157835651cf.45.1759744949077;
        Mon, 06 Oct 2025 03:02:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0113490dsm4901255e87.32.2025.10.06.03.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 03:02:26 -0700 (PDT)
Date: Mon, 6 Oct 2025 13:02:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Junjie Cao <caojunjie650@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Antonino Maniscalco <antomani103@gmail.com>,
        Jonathan Marek <jonathan@marek.ca>, Eugene Lepshy <fekz115@gmail.com>,
        Jun Nie <jun.nie@linaro.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 3/3] drm/panel: Add Novatek NT36532 panel driver
Message-ID: <rxm67cbwkp2qyxdlgqb3fz7fhiskmnhidhjvl4mhqn67iq2x4n@wfueruiiq7kp>
References: <20251001135914.13754-1-caojunjie650@gmail.com>
 <20251001135914.13754-4-caojunjie650@gmail.com>
 <lfdhib6a7ct36nmj3of2setjft7ydrf6sfgtx7qued7qd56nhc@2xol3grm5re7>
 <e36572bf-4fb4-425e-8d10-c5efa5af97f3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e36572bf-4fb4-425e-8d10-c5efa5af97f3@oss.qualcomm.com>
X-Proofpoint-GUID: HDU4EH7Jxa1IN_oaJu5YoTTqt7Q5uK4Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyNyBTYWx0ZWRfXwsjUsRfsn+pT
 3Z/nIYsyzm1zXisZ2Z5Av8Hf0h3tCWHBVUQsxlaqUrlHyk/SXtU/9eyB8sP9lhVbJrCmM4hlQsj
 K5i33bwXpRLPdcgfvaJV7Iw65RbW/lHjznviygDyiCLNaxlvBm/TQho/z95J46PtIqsH0uiWztq
 +GZZyz7lxE+b/ylHmhtw4yV9gH0Y07xtIOFFlpWruwTyfMp8qQuSeb7U1NWS7Jh8uBqNPvx5s/0
 hbVLzIB6gI38PIsmcDAK0uyV5WT8l6gLFYQVyKZ/1zrC1kxBgpGA0LQWtXgbcCuGjCXnIRXRzjt
 kHh4jvIkYWkyzh6gBjixoWB+3grYomBgoJRf9/KsCVn2SnhBXGDikXQ0bvziE+wH3D4FOsPiKDb
 aSo00DRvkSxmq/oIR2vf+9eFvNMtew==
X-Authority-Analysis: v=2.4 cv=Vqcuwu2n c=1 sm=1 tr=0 ts=68e393b7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=8BRzra-YsWo1JaVNFEUA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: HDU4EH7Jxa1IN_oaJu5YoTTqt7Q5uK4Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040027

On Mon, Oct 06, 2025 at 11:24:35AM +0200, Konrad Dybcio wrote:
> On 10/2/25 4:04 AM, Dmitry Baryshkov wrote:
> > On Wed, Oct 01, 2025 at 09:59:14PM +0800, Junjie Cao wrote:
> >> Add a driver for panels using the Novatek NT36532 Display Driver IC,
> >> including support for the CSOT PPC100HB1-1, found in the OnePlus Pad 2
> >> tablets.
> >>
> >> Signed-off-by: Junjie Cao <caojunjie650@gmail.com>
> >> ---
> >>  MAINTAINERS                                   |   7 +
> >>  drivers/gpu/drm/panel/Kconfig                 |  10 +
> >>  drivers/gpu/drm/panel/Makefile                |   1 +
> >>  drivers/gpu/drm/panel/panel-novatek-nt36532.c | 437 ++++++++++++++++++
> >>  4 files changed, 455 insertions(+)
> >>  create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt36532.c
> >>
> >> +
> >> +static const struct panel_info csot_panel_info = {
> >> +	.width_mm = 250,
> >> +	.height_mm = 177,
> >> +	.lanes = 4,
> >> +	.format = MIPI_DSI_FMT_RGB888,
> >> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_CLOCK_NON_CONTINUOUS |
> >> +		      MIPI_DSI_MODE_LPM,
> >> +	.display_mode = csot_display_mode,
> >> +	.dsc_slice_per_pkt = 2,
> > 
> > As this is not a part of the standard, what if the DSI host doesn't
> > support this feature?
> 
> Shouldn't the core gracefully throw something like an -EINVAL?

There is no 'core' here. Each DSI DRM host manages DSC on their own.

-- 
With best wishes
Dmitry

