Return-Path: <linux-kernel+bounces-744223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E24B109C2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593501CE3333
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042F62BE7A7;
	Thu, 24 Jul 2025 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fe+jvu3V"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BAB2BE63A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358308; cv=none; b=gFUILLvlY2r/H8+1z/Ha0NzYXMAasQpl0hsyOgIY1gqCa5E9ROglybJuxrROe2dgQ8bVbczTotlXJ6mOI6nuqdoX52msTsjMmy+MTIO9DJKZU6cS7X3cILYxv+1nfYfs/IPsqJxViIr7OkT0ErGRI7/xzQha9pLakOsaSNBR6AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358308; c=relaxed/simple;
	bh=LcF+au34T4Y4uoe+PJqyTSxZzQVvy7bMrGLNCMr5qRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3xScZeMwbUiQOuwYrlnmB1mM9KH7iAuQyCJyJNHTLIte9PJNZbDFOx2CRyMZORs201QYZJ9WZW119ZzTKOvdb+A5nrdcmX0prfB8P1TRhvpkg5jz0zaJ9m379uvF9wOktSRNO+pP1SD/CdgISW9l9P4CZDlur5b4BMIwp5saYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fe+jvu3V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9oLrg018072
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gtE+xlUh+PW7f4cFnhCSMOHE
	EmQN3efVJt3XSMrZRmU=; b=Fe+jvu3VqvRd7J7SqbeutFSAdml9qjHB50Mc3pJN
	ORfudJcfCVs2ru4o66MyfPW4apR8LiZrg3KRYm2dhsdbRvyuuh9w6/EZLxai7e4o
	qyNq93YhiffTmKfryUgeDk1+QDkf95nIhqNRzY0LDQKUavY8r6QFqUYBLXJ0wjVK
	fQyrjWeKOSgDwIQw9n4C/M1XOTF5QwVJySprvSDqckw7Kp/ksq67CpQWpP42ycr5
	X/ngMgfx43ZIeTtZcXEFd7mmi00TpMmTjHY3J5MAMMg5cHL0ePc0oxNgNjfATWW9
	tgJ+RG3UilQJR5weIZeC5m5I1zUNGz9W9D9XNE77QnjeRQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6tr97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:58:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e2e8a90a90so149588685a.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 04:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753358304; x=1753963104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtE+xlUh+PW7f4cFnhCSMOHEEmQN3efVJt3XSMrZRmU=;
        b=nxxidGAdfDkoQfFCAIXfk139GLah7KQKlszLSoe9cmBvgEt5kx4ATnCyqSiyANEYRu
         bdDj6WyNru/F6JZa+xilRqg8SbZqYM3Ap2sADh8vpNXPqvn6OQlAs6lQVL0AKR/rn0EE
         H6/p+c8o+TCHTkns/yB3smV1S6QfhmiFjgl8yK3v2VOOsmiS/sU/1z3DX/1UBJFJG4kQ
         KjkwZWxDbadzveKvjLKUgL8wnVP7t50TVxfDduTnWOww5F2S5By4eqsbOWYnG2++Gh7L
         Ls0xu9acqyn/USg8Da+Ul2dQZ6Xaejasnjwj9+qMu/snqHKNy0iJa1PvS+7l65uL49kD
         txgw==
X-Forwarded-Encrypted: i=1; AJvYcCXmkimzCkqdaPdqDdE+NyHhZa+yCW+Bm/c9cZNTnqtrrBk3tPuZjWh/4b4kvT2QkZVUzB/dKgfRkO+KD5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpWxMtjJAeQHw+iuW/jEgyZz+GRIVQGGsB1prxz9LuBnvnz5V4
	xjJcCLbvxozPl8HU2X5CX1R7vE7g8wDS1gajZ7eGQDGiglMzte5ynlc3+eRATnM9eJr2zOSWqEY
	5L7sMt2BSPWc76t/2U9f5jTD1PfCNlQ9qfmGTltCULu+uNMLbDSNq6+fJ/bnExYRORB8D8PgUUD
	4=
X-Gm-Gg: ASbGncsIRB7HCAgSDNq0aAW0TqubW2LYREBEGZ4iTQXCvUqP0CTzbd+MdOocOo0kBsi
	k8BJwF4dCTtypBlTnfbvGzTFAbWAMNexqWIIqGofX34kW869jLTVrg2QAc4BIE1PpVwL8RPbwQW
	YvIYVx4rCNk6qRiOoD3Zkav0OEBJc5bS87HmIVvA79mnHQAC8Y391PW/Hu5u8UbJxJ/S/byt3Re
	jWP1qa0KwerG+tPGFEvkp3ntMCggETfutDD3ZbPlQbAJg4CTEU74RKk5c9Zf0uuEvtz2CJzLfIg
	xQFyctKZ69F6G8uQ6Bmdz5kY4VLSdtBpgW1RHA03xSdh0IXQ6uXkWR7qeY8dDh6+g+Z0wXUkHlX
	M9mir7Ye0fDKlntA2E/qYHS3pVYQEEeLxIo+d/+9VlMGEzy9SV1Dd
X-Received: by 2002:a05:620a:a914:b0:7e6:2782:34cb with SMTP id af79cd13be357-7e62a1803d6mr873602585a.30.1753358303719;
        Thu, 24 Jul 2025 04:58:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQqSXoopFmxXR9ck1aAjPPx2gGTxSyeulvBYt/V6+sgf9uKacatczHtr7h6WkHRPWjTu8avw==
X-Received: by 2002:a05:620a:a914:b0:7e6:2782:34cb with SMTP id af79cd13be357-7e62a1803d6mr873600085a.30.1753358303278;
        Thu, 24 Jul 2025 04:58:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331e074d9b9sm2667531fa.3.2025.07.24.04.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 04:58:22 -0700 (PDT)
Date: Thu, 24 Jul 2025 14:58:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sarthak Garg <quic_sartgarg@quicinc.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_bhaskarv@quicinc.com, kernel@quicinc.com
Subject: Re: [PATCH V1] mmc: sdhci-msm: Enable MMC_CAP_AGGRESSIVE_PM for
 qualcomm controllers
Message-ID: <z3lucllumwco5xcvphnzwaqjvdhmbraofhww4i427exqfhxrot@rsrvalmulhup>
References: <10c90fee-ce7f-4034-9028-4252f19cb67f@quicinc.com>
 <CAA8EJpoLLDXFQk-ViuaioKrECzMV0aUrcOj4v+Ufs4oHY53mrw@mail.gmail.com>
 <064d3eed-c2ea-4b41-85b2-d2a5a922f8c7@quicinc.com>
 <ehgjdszjr34xppmkrkicb4pnq326nor26tqu2ekop6ew2j3y3h@pm45aiipzuc5>
 <48c73675-a73f-46f1-81a9-f701a2cf00a5@quicinc.com>
 <c1ebdaf1-92bb-4f73-bca9-35246d7c10e1@oss.qualcomm.com>
 <ca83b841-aea0-4233-93fe-02a7b5985af4@quicinc.com>
 <1a0a5178-fcf0-49b6-8e4c-1393c0f4f229@oss.qualcomm.com>
 <CAPDyKFo9gUOB0VhQn=zD0RDM0=8wO08=VmA6XkHv0EN7M89bjg@mail.gmail.com>
 <9d4b5382-1536-471b-8f4a-a0ccbbcf1489@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d4b5382-1536-471b-8f4a-a0ccbbcf1489@quicinc.com>
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=68821fe1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=fzXwuMWa66Y-jPmIjq8A:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: lmuwaLz5sPSxvq4TXR_KZgCjiy34DOz3
X-Proofpoint-GUID: lmuwaLz5sPSxvq4TXR_KZgCjiy34DOz3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA5MCBTYWx0ZWRfXzDFIs+a6KY1V
 mzU3olQKi5TARVJLfiSTe0NpmyxU5PU7gETr13h0SyE4TUUrOCvwfQrmFoNob+bZUBrTv/2232w
 B+zcjZ2wxsCu0hdbfHroO2BxrfzrIQG3b2HgdqufxUg775arvxp0Xzed0M55A6yC0w+huKf6fIP
 9FeRdAjC8dk9aFLbUauJVCLX6wurqpkA4/x4ddFdGeCUZFLVjJ3kLEkuxnx9RnYpoGE3Xy/HYjy
 l7tesyumoD+4SJrnmSKTGQbxXOc0RlcdPnJIbg7FXDV5fl2aKeKD6CUGjghfZLb5HbVR384t8kE
 6hZq+DxWgPHLVRuqrLD2YQTb1jxwQKMl2x9rcTRWTcwKSXYLTkdLzTszOlILnfeicmq3TMZ15Hn
 gkRNhUeD6+WAIksJViqYKrdWv1vq76D7dxOYpC51pC05dvb3d3Lo/YK76eVHV40XZK9zkRL9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240090

On Thu, Jul 24, 2025 at 05:12:56PM +0530, Sarthak Garg wrote:
> 
> 
> On 5/27/2025 8:50 PM, Ulf Hansson wrote:
> > On Wed, 21 May 2025 at 17:41, Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > 
> > > On 21/05/2025 18:36, Sarthak Garg wrote:
> > > > 
> > > > 
> > > > On 5/21/2025 8:19 PM, Dmitry Baryshkov wrote:
> > > > > On 21/05/2025 17:35, Sarthak Garg wrote:
> > > > > > 
> > > > > > 
> > > > > > On 5/21/2025 6:25 PM, Dmitry Baryshkov wrote:
> > > > > > > On Wed, May 21, 2025 at 12:46:49PM +0530, Sarthak Garg wrote:
> > > > > > > > 
> > > > > > > > 
> > > > > > > > On 11/15/2024 6:53 PM, Dmitry Baryshkov wrote:
> > > > > > > > > On Fri, 15 Nov 2024 at 12:23, Sarthak Garg
> > > > > > > > > <quic_sartgarg@quicinc.com> wrote:
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > On 11/4/2024 4:19 PM, Dmitry Baryshkov wrote:
> > > > > > > > > > > On Mon, Nov 04, 2024 at 11:37:22AM +0530, Sarthak Garg wrote:
> > > > > > > > > > > > Enable MMC_CAP_AGGRESSIVE_PM for qualcomm controllers.
> > > > > > > > > > > > This enables runtime PM for eMMC/SD card.
> > > > > > > > > > > 
> > > > > > > > > > > Could you please mention, which platforms were tested with this
> > > > > > > > > > > patch?
> > > > > > > > > > > Note, upstream kernel supports a lot of platforms, including
> > > > > > > > > > > MSM8974, I
> > > > > > > > > > > think the oldest one, which uses SDHCI.
> > > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > This was tested with qdu1000 platform.
> > > > > > > > > 
> > > > > > > > > Are you sure that it won't break other platforms?
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > Thanks for your valuable comment.
> > > > > > > > I am not sure about the older platforms so to avoid issues on older
> > > > > > > > platforms we can enable this for all SDCC version 5.0 targets ?
> > > > > > > 
> > > > > > > No, there are still a lot of platforms. Either explain why this is
> > > > > > > required for all v5 platforms (and won't break those) or find some
> > > > > > > other
> > > > > > > way, e.g. limit the change to QDU1000, explaining why it is _not_
> > > > > > > applicable to other platforms.
> > > > > > > 
> > > > > > 
> > > > > > Thanks for your comment.
> > > > > 
> > > > > No need to.
> > > > >   >> I agree with your concern but for me also its not possible to test on
> > > > > > all the platforms.
> > > > > 
> > > > > Sure.
> > > > > > > Lets say if I want to enable this caps for QDU1000 for which it has
> > > > > > been tested and on any other upcoming target after testing, then how
> > > > > > can I proceed to enable?
> > > > > 
> > > > > Let's start from the beginning: why do you want to enable it on QDU1000?
> > > > > 
> > > > 
> > > > QDU1000 is one latest available target where we have enabled this and
> > > > tested. This has been enabled to save power.
> > > 
> > > Isn't it a powered device? How much power is the save? Is it worth it?
> > 
> > Just wanted to share my view around this, in a slightly more generic
> > way. My answer to the above, would be, yes, for any battery driven
> > platform, it should be worth it.
> > 
> > Unfortunately, I don't have any fresh numbers to share for eMMC/SD,
> > but just searching for some vendor specific information about their
> > eMMC/SD cards, should tell us I think. In fact, this problem isn't
> > even limited to eMMC/SD, but rather applies to most flash based
> > storage (UFS/NVMe etc) that are used on these types of platforms.
> > 
> > How much there is to gain, obviously depends on the internal behaviour
> > of the storage device. Of course, the number of cards being attached
> > is important too.
> > 
> > That said, enabling this feature (MMC_CAP_AGGRESSIVE_PM) needs to be
> > done by taking into account that being *too* aggressive (too
> > frequently) with turning off the power to the card, may cause a
> > potential wear-out/brake of the card if we end up preventing it from
> > doing internal house-keeping for too long.
> > 
> > The current default autosuspend timeout
> > (pm_runtime_set_autosuspend_delay()) is set to 3s in mmc_blk_probe().
> > That seems way too aggressive in my opinion, so perhaps increasing
> > that value to ~180s could allow us to enable this, even if 180s is
> > just a guesstimate from my side.
> > 
> > Also note that, during system wide suspend we always turn off the
> > power to the card - and we really don't know if that is too frequent
> > too. It depends on how the platform is used, compare a laptop with a
> > smartphone, the frequency greatly differs.
> > 
> > Kind regards
> > Uffe
> 
> 
> Hi ulf,
> 
> We already have AGGRESSIVE_PM enabled for all our internal targets and they
> are in production for quite long time (5-6 years) and haven't seen and

Upstream kernels support targets starting from APQ8060, so they are much
older than 5-6 years. For example, I'd like to point out several SDHCI
v4 targets (MSM8974 - MSM8998).

> performance degradations due to garbage collection. Also wear tears are not
> observed as per my current observations so far.
> 
> Like you rightly mentioned we may have battery powered devices where this
> caps will be useful and on the other hand we have always powered devices
> where this caps may not be needed, so can we make device tree changes and
> enable this PM property per board selectively?
> 
> Also I see there are four below vendor files who have already enabled this
> caps in their vendor file.
> 
> sdhci-pci-core.c sdhci-omap.c sdhci-acpi.c rtsx_pci_sdmmc.c
> 
> Let me know how can we proceed.
> 
> Regards,
> Sarthak
> 
> 
> 
> 
> 

-- 
With best wishes
Dmitry

