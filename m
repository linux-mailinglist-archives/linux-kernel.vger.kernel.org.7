Return-Path: <linux-kernel+bounces-813808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDF4B54AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7616F3AF6AB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64772FFDD6;
	Fri, 12 Sep 2025 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LveBUbH5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D80A257845
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676311; cv=none; b=eI/d31atcpILXsMPCZ7YgopCzScl5+7CfZ/wS0Q0vvTtPiRTfKyXFzsrlfJx7gq5w7WBBLM7yldA+Je5XDXQR3j5iwVR1pk/v6l8J0httRAv9ggyzJnZUQ46ygLFsgkK1Ce/enqwdSQDIYV0EAnsIOthEL1rtTv480yLsJqWElU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676311; c=relaxed/simple;
	bh=7+c1HJZGrsHI5KgOslaLRZvi3jiJ76oQSD51OaNEqug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzHmdmFvJCmxcH4Nncpmh6nKdpFvzo5eOeLtLxm6LRy8yyRYOMpNHMrkMHrNUXeinzf6MFyeXLN01miEQd7r9V/aCS+U8tagDBrOYOWnZUiuNQrnCUn32MLtzMAUOScG2lTr0IpKFfyBzJ/kG6v/GkckJrvtoIF2rjR4OAzBFN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LveBUbH5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fGBW017694
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=L/KO/8ARjOPSDYaWONlEfU/h
	96fvcT5jnTcbxDheBto=; b=LveBUbH5+IKoDERn3kFHQVSoFlOGA9aorkBY/HWO
	R5EL/IvDmc70MUV3aHLzEuhud1sqlDxJ4NZbl2FuERCj8gzqIQAu8JsMxTnqWGuz
	sYcg6uggPDMyMbhLlhwFZ3BDs6M78dW/WsBLET6Inb9puclecuiqjYoNYdYCSRK6
	yXNBQpM76/7ntmPWiu1sg7WeIF0nUG9YjOWXar/DXywryufl4eAS/6YXWaTWr2ec
	MuQT4gpOMmYWUok7/NiNRrx1ZAiDWRrs+KsdlsO/YcPW7xhY87psQphr9yANTN+o
	3DFfdeIlMbiLCe5MF/bpVAb757j/hbtQmT0DgOHKouPl9w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8uhp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:25:08 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-728f554de59so48296686d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757676308; x=1758281108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/KO/8ARjOPSDYaWONlEfU/h96fvcT5jnTcbxDheBto=;
        b=VuO9T6UrSDKihLYxaT3l+IKayu6+hlFTiuB7tfZu+6gQ0VR2QZxUq8Rpu9m9lTjWil
         ktfV5YDlTXTaMs3CQQ0FMwy1h3JL6mdR9wJWpykr0gIInzqiWTJj+I3KcijvgdCXcxtf
         z/D0kUkn7sMKWXPA7vSlpusCfXwTZPYYiW895MQylVAoFVPFFgaobLvepIMlfX8H4q7s
         ZHeV+m6mrsxnolUICA1gUYrD1uWB6X3R+678DSu4ouRhD9a4+C/5wt8IkJVEqg5jJhrt
         pSXC6opkPRTunrxsDFn4XLJw5mPk+exOemu5cIYI9npkzz6M3mrL1HMUbX922z40P2ki
         iEJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0nxseJOHFUoURv8G9/9gUgLsZ+R+TyaP/IxTeDAYEr5F60AaHZo04g0olGudVdW5/wHngX0Hjn0QzSoc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7WzhXPj1c5NDDLxnLUoIGl6GIjrRJhPq0NLqB1Qy5OSt7pFAy
	wJL+e1vC4RLQjuJ8buWPmM2E0RiSOJHPkLVPWt75U1OILvSKv+Nhsvtr3kLXh3C5WXA0f+ow3ba
	cAd1zZ9JSxDDbWV8H1hLgscIIAzfRqXU2jxkSPlZcD9wNyioCjCQX1254EKPtouVqotM=
X-Gm-Gg: ASbGnctPPPB+MJvUNWVTD2CQo7gVcicE6DqXwxv8MTn+REWXALr25PMRDnm1JeneVe2
	3Y33f32Q5zwHr6VJjNYHk+bEVfCb0MRlFCG2mZMaw1zVdCyVBrzH3BWY9Cpt778Fg2OddwBSfau
	5Om+WM+a+v4Vm6VjPnML11alh5vLRgNHm2+kyYyvCxLr8P5MBVoajKISNiUkfSC8OjoxwU8jZOV
	/TAa05ICfjcuaP/Ab6sIyGVXnO35g6hx7FNylBTRnS+RDgjur0leQnTX6RBIk44o0IERPqeDcrB
	HU68HqSB0h4iXiAFgyCnZByX9zr5/oEeckIgjmyLS/sAZA6E1mi89g1QPJazwIagoWSYJbmLd8+
	+EGRCzrjOluswv6djTkc4Afpilbw4YfD3Pdmt4BL7K+0WpO5YpG89
X-Received: by 2002:a05:6214:1c09:b0:727:e45a:562c with SMTP id 6a1803df08f44-767c5fc1237mr36407426d6.45.1757676307444;
        Fri, 12 Sep 2025 04:25:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBvOKZjxSrcCAvaaBqR3mwSYec8GgXHcFcEBSSwTJG6nn1Xn5NwUdFapU5ndqxPzynNLhv7A==
X-Received: by 2002:a05:6214:1c09:b0:727:e45a:562c with SMTP id 6a1803df08f44-767c5fc1237mr36406556d6.45.1757676306608;
        Fri, 12 Sep 2025 04:25:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e65754ab0sm1059810e87.132.2025.09.12.04.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 04:25:05 -0700 (PDT)
Date: Fri, 12 Sep 2025 14:25:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        kong.kongxinwei@hisilicon.com, liangjian010@huawei.com,
        chenjianmin@huawei.com, fengsheng5@huawei.com, libaihan@huawei.com,
        shenjian15@huawei.com, shaojijie@huawei.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 drm-dp 02/11] drm/hisilicon/hibmc: fix dp
 probabilistical detect errors after HPD irq
Message-ID: <3sywcmtd4uksow6exaav6smx4wwrlp7mur6mcrpw3qklvbr3kn@dqypx4fmnhrw>
References: <20250813094238.3722345-1-shiyongbang@huawei.com>
 <20250813094238.3722345-3-shiyongbang@huawei.com>
 <aayi7zjrmru2ancexrqmcutams6ohde3nrkhqacixwp45dsk4v@7ig6hqzahdxf>
 <1dd93bb7-4f67-4b9b-8b6a-d7c5c77cf807@huawei.com>
 <ce47v3y77uc4dunlwyvmfe6j7d7mza4zfrbvu5dz67t66jdlop@vqgv47saj37i>
 <8bbfd02f-138d-420c-b456-10d0c913f46e@huawei.com>
 <cdmtfluxqes3bv3t7suctbajp4jmpih6fhegkbf7mxvy4umzrd@rtpupear4el2>
 <13b3f4d9-c8b4-445f-8f9e-a57a1fa2bbb5@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13b3f4d9-c8b4-445f-8f9e-a57a1fa2bbb5@huawei.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX1IuCTjM96gM6
 BrGCyFWp+q7u0ggKFhywmGC5BHTZvMK9ba/LAXj5U8hpvO26WKsCA2q+lO1r7WbLPscuQ4SEA8q
 m5kxktrQZoBmaDnEBujoDMzBQhCJKvgfOCFWVGEK5cz+RsEKpe/GfiXoXDsaqd4xhtYxADR1URS
 acdxlJ2d5gUiL30srbREO7HlkI4uB3Wq+SjN686eqOPyUwSP6xwr7seAxDvJMmNLsgfLNbAhYv4
 /AR/WLZwsPq1Q3bJXZLqAXM3rwxlheH3TPB03qdLqIr99q74EqyqeVFUh7lyIKAKdK4WjA8V7ni
 bBlFJndFN/6WsU0lqd4F5LK2bF15EG2CQivSXvHKtBOK4e5bq8TWwhp+fJbM0dzpQUU6RCSpHoJ
 ysnJPFiY
X-Proofpoint-ORIG-GUID: EyDRmobP_JNbUd11BYJQgWC1GLFEGFHl
X-Proofpoint-GUID: EyDRmobP_JNbUd11BYJQgWC1GLFEGFHl
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c40314 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=i0EeH86SAAAA:8 a=74nAKEOhdCrmlouCdhMA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

On Fri, Sep 12, 2025 at 09:23:05AM +0800, Yongbang Shi wrote:
> 
> > On Thu, Sep 11, 2025 at 05:32:40PM +0800, Yongbang Shi wrote:
> > > > On Thu, Aug 14, 2025 at 08:19:41PM +0800, Yongbang Shi wrote:
> > > > > > On Wed, Aug 13, 2025 at 05:42:29PM +0800, Yongbang Shi wrote:
> > > > > > > From: Baihan Li <libaihan@huawei.com>
> > > > > > > 
> > > > > > > The debouncing when HPD pulled out still remains sometimes, 200ms still can
> > > > > > > not ensure helper_detect() is correct. So add a flag to hold the sink
> > > > > > > status, and changed detect_ctx() functions by using flag to check status.
> > > > > > THis doesn't explain what is wrong with
> > > > > > drm_connector_helper_detect_from_ddc(). In the end, this function
> > > > > > doesn't use the HPD pin.
> > > > > I'm sorry about the misunderstanding.
> > > > > The issue is that after plugging or unplugging the monitor, the driver takes no action sometimes
> > > > > even though an interrupt is triggered. The root cause is that drm_connector_helper_detect_from_ddc()
> > > > > still returns connected status when the monitor is unplugged.
> > > > > And I will fix the way in the end.
> > > > Can you perform a normal DP detection: read DPCD and check that there is
> > > > a DPRX attached and that it's either non-branch device or it has one or
> > > > more sinks?
> > > I'm very sorry that I didn't get the last sentence's asking before.
> > > It's a non-branch device. We just connect a DP monitor.
> > Somebody might connect a different configuration than the one that you
> > are using.
> 
> Okay, I can add the check drm_dp_is_branch() in the DP's detect_ctx() to
> intercept branch devices, is that good?

My suggestion is to implement DP detection in the way it's done by other
DP drivers.

-- 
With best wishes
Dmitry

