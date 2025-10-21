Return-Path: <linux-kernel+bounces-862963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3598BF6A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F84F19A4A3C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AAE2ED165;
	Tue, 21 Oct 2025 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m7fzZPoX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65A73321DB
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051837; cv=none; b=FX8LvyBI5V9ygCNbjRlYU8MFg6igbbLsrBXH1yGJHIvJF2JhasIAd0XG2uZZUX+LxSzmcunB5HUZoUIan+sOvZ9+G4/G6Ac62C7cYXw0RfDHa97zHmQfiDfAlvqnYr2PNWUOospMl7FuoGG0PUeeoZwDhAd/4qiULzvvbb0R098=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051837; c=relaxed/simple;
	bh=FDyI0ELaP+8G6K2J87c4ou8IZSaFgqHpQeJVkW91Fp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkNW5f7vDxG6ukCu9xWOZzn7mAH39sZ8I2RhIsgjl1yuDXEods8BgG4ztBzgue4WldKoEYayBZdwKvN42apDlt2u0LbJmKCVtU0lC6CovJQ72QRWcLffNNlH8EGiWiKkuXzyBB2u5PorplzhmWMsRgjLhGuhP8ZjNe8YLVSwVYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m7fzZPoX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8Lud3004415
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EDrIqOlDWabTc3vmLbQ0DUei
	ZyiWzCtrffXjD0fQBds=; b=m7fzZPoXJUiRKy7jLR+DFiwS7U+89rFly7j6qaNC
	lb4tBdMK5NlFYgFtlni3rijyRfYScjrcTHuhM6Gb3nWZSFqVXW6cTWd0wbrFOY6B
	gfd/38XNwiIWfiIExxLgt3R8GI0tYsK2mimtozWw4L73c4M+lihPKOdxY6N2Jk5/
	OxNKaav5mGAexhkyjyz7tq2WLubclB134renYtfBKuFY6a3OoohZiArLkG4xiHWI
	dT5jQRyUgulhx8keK2ItyrJaT2T1cmY0Mx8hTAMmpMh5AGSW/7lBHWug5v9r+ct6
	ZUnEB3XKH+Kqg025nkhBvyIoOg6PQXa6keu1zuzhvIjnbg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfgpk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:03:53 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-932ee98bb3dso907812241.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051832; x=1761656632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDrIqOlDWabTc3vmLbQ0DUeiZyiWzCtrffXjD0fQBds=;
        b=t5KrDT5zjvTMgXo4URd0K7Xy37+KbueATV5FEWhB+LDr9stqDxPr8jHsmd+edr8/pC
         Lh4ZLaEdkZpPd4ge+TfvZz0Q2y2uod4WwfZ7PwA8iKp2RrAR5yjm7SRjprSncxget7S2
         zgQ60Unz26gKypGd0U6mdGc09/QVk/jXUFYyiGe3HPhGPkamoEIn3yXQTsWWAocZvQdt
         g83qJO+XMJGOCVEKI5uxSzPl8/I3LD6swXXNIDGfusx428E5QP6JC9paQxAOcwMfm/Tm
         iiBEq/zpU7Hg7HLorR0wkdtC1NKXfTmJbI1v02RnIOfI/AKgjnIsHeYHqRTHLRH+R53K
         ncOA==
X-Forwarded-Encrypted: i=1; AJvYcCU/N3kO0uU9f6c+p8gq/5SseM2do/IhYRJOEvF3BJLXfXpIky78ItNCugqgFNpNPMLZsyolq8cNwT+4OBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywse0p7Myq9v10zaMweg0m8yhRxWjIYzWKtv3U+fG7WoCuuK/rK
	qGM36guul1vvzWuMipCY0EFD+59B7/QiCW8xqE5hweyI6TOPiULsJQfVJfl3QRmi3qI0nwT24iP
	+L6jpGDEQwBY57ZHC1ZYzpxsgDXabIRkS7jHQ9KS2sOun4ySRlWITm+uU0In1POBMueI=
X-Gm-Gg: ASbGncubQwoSGvPeCHVaK+se/NMgJAIXkE/l5Ihu2LXCp4icT/YwXg8Y4L0Mh4lxqA3
	pE7fwlRI1QElnJqmUrF2bH/9Rj32BFsPjhyCyQDrr80ZXTPEcuOVrp8F1GtzgQylO5EVkmi6rzg
	P+045wWQH3iCgbrM5/nGpAwogd0+klff5xntxiu2KteBN22233/VZK4TkSUkX6pSJ99eeQnllte
	Muh76oMeWqLlDBWWET952Pi0KdA7Sv/FXC2ISWV9pa842ioRbFa9lLj1TD4vT0O1prdJoRbg7nn
	8EzsYVjbesRxAtGqGF11JXryioYgfK3x1+rn17ITUM2+HNNzta0pNRtvMs/tMzE0O/9TKZceWtj
	uK6amarkZwINHJxi2It8nH6rJdeKUhyaK0HQKhZMbu8p6vkezn+n7jZTeUqSx/ufoJSuXBEF3HU
	fTJYRxXjOrGOw=
X-Received: by 2002:a05:6122:1346:b0:54c:3fe6:6281 with SMTP id 71dfb90a1353d-5564ee23106mr5038771e0c.6.1761051832343;
        Tue, 21 Oct 2025 06:03:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhkuO0rTjc/ZeeWLixgVS1Ew/7JMs0TEHaib+DIHO5ztf4dvMOXWkt92zh6Povn11NoZSU3w==
X-Received: by 2002:a05:6122:1346:b0:54c:3fe6:6281 with SMTP id 71dfb90a1353d-5564ee23106mr5038728e0c.6.1761051831810;
        Tue, 21 Oct 2025 06:03:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a950cb2bsm29151841fa.27.2025.10.21.06.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:03:50 -0700 (PDT)
Date: Tue, 21 Oct 2025 16:03:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: qcm2290: add LPASS LPI pin
 controller
Message-ID: <56vmqgrjy3je7omzirxnfxtuocebbj356iaew5thgkagi35464@hh34y7efssow>
References: <20251007-rb1_hdmi_audio-v2-0-821b6a705e4c@linaro.org>
 <20251007-rb1_hdmi_audio-v2-3-821b6a705e4c@linaro.org>
 <b6223af9-2d9e-4ccd-b297-79f63167242b@oss.qualcomm.com>
 <DDEN5NSLDIHD.C1IELQW0VOG3@linaro.org>
 <zmi5grjg2znxddqzfsdsr35ad5olj3xgwwt6hvkiaynxzm5z33@gsgrdguj563n>
 <DDO0LYS7UTEW.3A9WGTAA5DKVO@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDO0LYS7UTEW.3A9WGTAA5DKVO@linaro.org>
X-Proofpoint-ORIG-GUID: RB3aylgalCl1dcqEZQL80XVSpyskJUrF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfX9jtlEbZakoXs
 lKNHPgUf64Pupynark1+e9hN9EPrkL/N6ZOwz96qNXuWyCfQn0WZi14hgJZlBaTCYtZt7wQZHOu
 vm9SX+wGq2+ITeyZgEJXlgLnNug3JlL/bYZrUOj7Kg8Gm50NTGneDKw2R6yFvt3z7gPp9DTtnnF
 qrZG9vru+w9c4oyfh/aSYcS1ByhvEjyI7zQFy6lbdh6n+I/jwO8oUDfOFP2CrWFJvc+Y5eD05st
 iuA87xdBGUVofxWo9Ncc333D97GqZNqLb7KdajKmv0sMAOcyskrvnzD9DPUEfFsGOcaoB7InFhw
 XIQ10gtLgmqsIJ29KnbS8OUdMtg2gxxnoAgZ/UVLhUP7PjLaWbT5JU6OWFEerY7cCfYDfmEvAHK
 U8X1XWt+1s1RhDirlcPXhzkdiB1Sdg==
X-Proofpoint-GUID: RB3aylgalCl1dcqEZQL80XVSpyskJUrF
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f784b9 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=SizNog2SKWkDgIwviPAA:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027

On Tue, Oct 21, 2025 at 01:56:09PM +0100, Alexey Klimov wrote:
> On Fri Oct 17, 2025 at 11:42 PM BST, Bjorn Andersson wrote:
> > On Fri, Oct 10, 2025 at 01:29:38PM +0100, Alexey Klimov wrote:
> >> On Tue Oct 7, 2025 at 1:39 PM BST, Konrad Dybcio wrote:
> >> > On 10/7/25 4:03 AM, Alexey Klimov wrote:
> >> >> Add the Low Power Audio SubSystem Low Power Island (LPASS LPI) pin
> >> >> controller device node required for audio subsystem on Qualcomm
> >> >> QRB2210 RB1. QRB2210 is based on qcm2290 which is based on sm6115.
> >> >> 
> >> >> While at this, also add description of lpi_i2s2 pins (active state)
> >> >> required for audio playback via HDMI/I2S.
> >> >> 
> >> >> Cc: Srinivas Kandagatla <srini@kernel.org>
> >> >> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> >> >> ---
> >> >
> >> > [...]
> >> >
> >> >> +			lpi_i2s2_active: lpi-i2s2-active-state {
> >> >> +				data-pins {
> >> >> +					pins = "gpio12";
> >> >> +					function = "i2s2_data";
> >> >> +					bias-disable;
> >> >> +					drive-strength = <8>;
> >> >> +					output-high;
> >> >
> >> > I.. doubt output-high is what you want?
> >> 
> >> Why? Or is it because of some in-kernel gpiod?
> >> 
> >
> > What does "output-high" mean for a non-gpio function?
> 
> This is not efficient. It will be more useful to go straight to
> the point.

It is efficient. It makes everybody think about it (and ask the same
question in future) instead of just depending on maintainers words.

> This description of pins was taken from Qualcomm downstream code
> and the similar patch was applied (see provided URL in the prev email).

And we all know that downstream can be buggy, incomplete, etc.

> Back to your question -- does it matter here if it is gpio or non-gpio
> function?

It does. The I2S data pin is supposed to be toggled in some way by a
certain IP core. What would it mean if we program output-high? Will the
pin still be toggled (by the function) or stay pulled up (because of the
output being programmed)?

-- 
With best wishes
Dmitry

