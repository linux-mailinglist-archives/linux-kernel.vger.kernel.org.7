Return-Path: <linux-kernel+bounces-751161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A9CB165DE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F7177B6023
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BA42E11A5;
	Wed, 30 Jul 2025 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jqLfbPc5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0005E1E51FA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753898173; cv=none; b=Kf9gj907K6qZQ6KenZ/B6JTkYinqX/hKXdgNQ7/ImVdy9dFwHXNlkRsKzE/9YP0oS/ykj3nWFSzra1KmXvxQ3yF6QAD57C78bSf1QTQ6CpKk4lm45XfuGwVjWwfuhbbYKF3KQHuSJT7ZU+1RwiuHF2ehoDKITKJNNDLWE6Yrvso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753898173; c=relaxed/simple;
	bh=xM9bJrOLQvE/L4ROO/2dHRsVAafQFJCehHj4F1f40IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qK04xdMT34GOf+v7JM1MOxSz9R78/cb2ISAfbKXJ6jyG4gbc/iOziFSGMz71l2po3cOgkef2j9PRR0LYSFQQfSwENA/iFrbcb7ezUqF72gQcM9pMnha+G5ApzNBMxwLisj9nxt2mphuYop0H+pBQRP9kqEicBkcrG8xGNCNEwaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jqLfbPc5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCbBB5017657
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=S87jF1f1+5uAHGo0xR/Mg2me
	DzeGKpJ2QhooQERCTug=; b=jqLfbPc5Jdbvd0ahzLb9PnqL7ib6QKUUwdVhBhGP
	/CNmFu2JHm2dOlIZ1IZ4S/cLu+Z2gykpVl1FLR9CZ6Hu/LIxEPpYiElqdlNfOdZD
	QegiyiNIKOgABcRU6dePOiMkCLCoLEizPARg25HAQKg2lLBa8ZeU9ILhlkPtVOqk
	tG1oNT9hex1PIaiwtivffPrQ7HWLk+2aSim3WYjtek4NarXNG+/F7/zTij2/os+z
	2+y4TFbfOv3G/YEX2LkUGgywt4j8oGGu1U+Dzo/enTzWKS0UrbaYtNL7E25mSr0v
	KeBxymnQJDitx/YOnaiXA+Ovieby5lNCpIgmdawM5snn+g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484qda4q4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:56:10 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-707453b0307so745126d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753898170; x=1754502970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S87jF1f1+5uAHGo0xR/Mg2meDzeGKpJ2QhooQERCTug=;
        b=g4/D/Ct7ziNLt/Mnx37zK8bW5WwE9UROvND77cjg36mXWOmMSm7tZTdUnCg7xLnhwi
         XhInqfKqlRS+2lITA6Y9j+Cz+f0vYlegj84zfIi69xUeX5JU3LQTEKBoxnraMBpPN/Gm
         wGiVJ+QB3BYIf2z+BrXPeqm01S0p1h4wNAAlhrzkfWPpbC8sipRCjk77HaxGPijiOYSB
         xLzruZZARytQIS9lH54pHryNUuvU8Ynta/rHJkU3f6s7uJ2ILKCv5+1MFIChehGoLomc
         uO6TFB1q+eqypyE/SUkVYWutl1JJtVpAixYzJXz29xcEUbrLCp2cM+aUfem7Xc4adVxa
         ezdg==
X-Forwarded-Encrypted: i=1; AJvYcCUud0SG97lqamdQ1f+iQzGAPeOTHtCe4MI/qRZSGDvlrry2nVoxfZRxO7V7fMtqTGCrKTTdJnwlmM7+9EQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlfYQWQwD/4ArScrpoceD4ufCyK90YORVT5ZUUPTZMfODL+Em+
	Se2kzDxp3e3nhnYT98PaZQHHWuFV7FYk9p7sQpx5+SbDfvN19QK+XFqe1+w4U2KIeOfd2TtQka+
	v8R/TToOktSlX69U1Z9eE3UHpI7atkWpog7ZqknuaLxGUws9Ys9BRPLVaPwwTKsimU/o=
X-Gm-Gg: ASbGncu9sa7Fj2L+rh48Jyeu7G9XpL39lqXMwAfPOofSUv/yCEcBjTqLj87WMCyvvMl
	wHaCM4eVOSNXvgCmaJndFFEPOeN/sQi7iM3piBJsYS73yZ3rVToOv3r+B5blKXDNFnIe07u3ZYe
	ozw6ahdqk6gWwQFJkWYvMEr1++JF0MXlSwYkFFJdELVvjMIyZb5QR+N+ALQGBfJsdRILZy3qiZO
	FL6Q2PyTqAsPRgxlhLIOxteOYXEZQLmdeT/6QFSCEQZ+7RfQtu0mtvFor3GpJxTowmDu6Hk/gAa
	pucvf6h86us3z0PQ+z7LsPpqXGmoEmXhY+GxfOUFFIefkzT0IhdCQEEf7iV1tArRjaFQhR5py3i
	2sdIJvZ/kdFFIrHygal8x6mtNd/Daf2uwzdCwVeExUCrF5NH71QNW
X-Received: by 2002:ad4:5d47:0:b0:6fb:3579:8f07 with SMTP id 6a1803df08f44-7076710ffe2mr68106166d6.31.1753898169630;
        Wed, 30 Jul 2025 10:56:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9CzeNqHatgD28u+dXvkQErA1w/3LINj69dgtpdy+WyYUq56GDl0fM0fc8WawlBF/Ul4RQ9w==
X-Received: by 2002:ad4:5d47:0:b0:6fb:3579:8f07 with SMTP id 6a1803df08f44-7076710ffe2mr68105416d6.31.1753898169101;
        Wed, 30 Jul 2025 10:56:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f4235632sm19002881fa.60.2025.07.30.10.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 10:56:08 -0700 (PDT)
Date: Wed, 30 Jul 2025 20:56:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ram Prakash Gupta <quic_rampraka@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sachin Gupta <quic_sachgupt@quicinc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_mapa@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sartgarg@quicinc.com
Subject: Re: [PATCH V2 2/2] mmc: sdhci-msm: Rectify DLL programming sequence
 for SDCC
Message-ID: <p7o2ykmpghx5jqagpkhd2rfqgizcdagn366rltyn4gmbmnmpje@vcygaqcaowkn>
References: <20241218091057.15625-1-quic_sachgupt@quicinc.com>
 <20241218091057.15625-3-quic_sachgupt@quicinc.com>
 <a2mnkliubpdryxdwsd33kccvnlb4fnyzik5ywxw4xhnimwdwsm@oxe34zogzfot>
 <bb60a145-1e8f-4004-b266-9f26a11440b9@quicinc.com>
 <otfof56qvqxyjaq6onor2f3egrt57h2xazncias72qnn4xjgz5@2aj2pyj5xmyl>
 <a885b32c-c59f-4fb6-b2cb-7955d2d3ae69@quicinc.com>
 <mpuyg4ndd7xvfpwd6oubn7zmzkuienyrig5pmkrd4badlpebvf@h6weyimpcfv2>
 <769268c2-9a7f-4b6e-aabd-a6cf5a744d5b@quicinc.com>
 <d5ykzwuk3wrwycol3wpeontfp5t7h7vfrfcxnmxei3qs74xsp7@ihtzne5wbytf>
 <81323b02-a7be-847a-b973-ca0cdb906558@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81323b02-a7be-847a-b973-ca0cdb906558@quicinc.com>
X-Proofpoint-ORIG-GUID: BrqCwH1W1yrMIulH9Wt9jMYFlEXlq14n
X-Authority-Analysis: v=2.4 cv=Pfv/hjhd c=1 sm=1 tr=0 ts=688a5cba cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=X73hcK0hsF-LJh63foUA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: BrqCwH1W1yrMIulH9Wt9jMYFlEXlq14n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDEzMCBTYWx0ZWRfX3uoIfcnihsor
 ebqcWfrei6gbdwbaL+Jax13btAOGhuC2J1VEiLOvHLSq09MbXPJeSp7ALuXfiAuxX731gKgluh2
 lKnajbohHTj8kJlTkxOcI2Jz4+bICqWoJc3fL2ZE0HZUq3uYED83t+itakT2UEcDMjyGNhMZuln
 svuk5XcX+VE8jJRimIfNcu/GiiLHfy4JXg+YI0DIytNXoUY/98tCy4v0XpcqiD/EtaxrcdH9VfN
 6mEa4EfaRcpECfaaxJ/QFkQFS9wW62M2G/gh0VI8fNM8cKu0BFPjgmJ5ZwcIZKrx6LjiE5+c+7q
 oUv+nfHvpF0gWUCHOsxrdC3yUuIuXoptFerVZXuHRXw1noCDnjW6dsa8QEv/Pt1m/dMaFyUSD2A
 o7jtXzPhPrTQ0K6+17+YmFHYb0QmLxHoUNAriKpJULjcfmLoJSD5jQa1DXFUrbifwROXttdX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_05,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300130

On Wed, Jul 23, 2025 at 03:43:37PM +0530, Ram Prakash Gupta wrote:
> 
> On 1/22/2025 3:20 PM, Dmitry Baryshkov wrote:
> > On Wed, Jan 22, 2025 at 02:57:59PM +0530, Sachin Gupta wrote:
> >> On 1/7/2025 8:38 PM, Dmitry Baryshkov wrote:
> >>> On Tue, Jan 07, 2025 at 11:13:32AM +0530, Sachin Gupta wrote:
> >>>> On 12/27/2024 12:23 AM, Dmitry Baryshkov wrote:
> >>>>> On Thu, Dec 26, 2024 at 11:22:40AM +0530, Sachin Gupta wrote:
> >>>>>> On 12/19/2024 11:24 AM, Dmitry Baryshkov wrote:
> >>>>>>> On Wed, Dec 18, 2024 at 02:40:57PM +0530, Sachin Gupta wrote:
> >>>>>>>> +
> >>>>>>>> +static unsigned int sdhci_msm_get_clk_rate(struct sdhci_host *host, u32 req_clk)
> >>>>>>>> +{
> >>>>>>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >>>>>>>> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> >>>>>>>> +	struct clk *core_clk = msm_host->bulk_clks[0].clk;
> >>>>>>>> +	unsigned int sup_clk;
> >>>>>>>> +
> >>>>>>>> +	if (req_clk < sdhci_msm_get_min_clock(host))
> >>>>>>>> +		return sdhci_msm_get_min_clock(host);
> >>>>>>>> +
> >>>>>>>> +	sup_clk = clk_round_rate(core_clk, clk_get_rate(core_clk));
> >>>>>>>> +
> >>>>>>>> +	if (host->clock != msm_host->clk_rate)
> >>>>>>>> +		sup_clk = sup_clk / 2;
> >>>>>>>> +
> >>>>>>>> +	return sup_clk;
> >>>>>>> Why?
> >>>>>> Sorry, I did not understand your question. Can you please explain in detail.
> >>>>> Please explain the maths. You get the rate from the clock, then you
> >>>>> round it, but it is the rate that has just been returned, so there
> >>>>> should be no need to round it. And after that there a division by two
> >>>>> for some reason. So I've asked for an explanation for that code.
> >>>>>
> >>>> clk_round_rate is used in case of over clocking issue we can round it to the
> >>>> usable frequency.
> >>> If it is a frequency _returned_ by the clock driver, why do you need to
> >>> round it? It sounds like that freq should be usable anyway.
> >>>
> >> I agree, rounding will be taken care by clock driver. Will remove in my next
> >> patch.
> >>
> >>>> Divide by 2 is used as for HS400 the tuning happens in
> >>>> HS200 mode only so to update the frequency to 192 Mhz.
> >>> Again, is it really 192 MHz? Or 19.2 MHz?
> >>> Also if it is for HS400, then shouldn't /2 be limited to that mode?
> >>>
> >> Yes, It is 192 MHz.
> > Good, thanks for the confirmation.
> >
> >> As part of eMMC Init, driver will try to init with the best mode supported
> >> by controller and device. In this case it is HS400 mode, But as part of
> >> HS400 mode, we perform Tuning in HS200 mode only where we need to configure
> >> half of the clock.
> > This isn't an answer to the question. Let me rephrase it for you: if the
> > /2 is only used for HS400, why should it be attempted in all other
> > modes? Please limit the /2 just to HS400.
> 
> Hi Dmitry,
> 
> like updated earlier by Sachin, HS400 tuning happens in HS200 mode, so if
> we try to use "ios->timing == MMC_TIMING_MMC_HS400" that wont help, as at
> this stage timing can be MMC_TIMING_MMC_HS200/MMC_TIMING_MMC_HS400 for
> hs200 tuning and hs400 selection. In this case we must divide clk by 2
> to get 192MHz and we find this as host->clock wont be equal to 
> msm_host->clk_rate.

What are host->clock and msm_host->clk_rate at this point?
What is the host->flags value? See sdhci_msm_hc_select_mode().

> Now if we go for only HS200 mode supported card, there
> the supported clock value would be 192Mhz itself and we need to pass
> clk freq as 192MHz itself, hence division by 2 wont be needed, that is
> achieved there as host->clock would be equal to msm_host->clk_rate. Hence
> no other check is needed here.

Please think about the cause, not about the symptom. Clocks being
unequal is a result of some other checks being performed by the driver.
Please use those checks too.

> 
> sorry for it took time to update as I was gathering all this data.

6 months? Well, that's a nice time to "gather all this data".

> since Sachin have already pushed patchset #3, and if this explanation
> helps, let me know if we can continue on patchset #3.
> 
> Thanks,
> Ram
> 

-- 
With best wishes
Dmitry

