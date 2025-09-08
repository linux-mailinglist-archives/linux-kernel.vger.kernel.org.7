Return-Path: <linux-kernel+bounces-805537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 964C6B489DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A560162CAA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98C92F3636;
	Mon,  8 Sep 2025 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rt9J+HC+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD9F36B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326664; cv=none; b=c8lcE8W8BedsvjfjiHR1TZRY7P99QDyQmAe4cXAKqkGCZ8fAbX/ntWBabIZjhHRbfHsY0qbu2EUyb1wOXlTLyYnLGhkNi/c7aaT4TOjlIIVcIRLiO0ZLyOQz1fFlVpuWoh7jKoi6QJ7EDRDeSmfv2Rq/DPTxmyAN+ZvH/pY0XmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326664; c=relaxed/simple;
	bh=2TJTDeZJKGx+SpfW+lrahJ5aBe4+mxSzwIgucxh9hsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDo6Go99+AbOXNnTqE7L8oa0YRE0tdXq2d3sKcgFi98DNbewVLKDziJoktCWaKpWnRQsUQNigXdkUEgha40jigLastEWPQQud9hltt2X44I1rDDIyC8fJPC0ONHlEXNiHeaTrUtYcmPurbGfkXSdIxMmxO8CdYbgC/fOkHgHkJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rt9J+HC+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58890IsW020026
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 10:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vCjXnZfE2tyLur7FXPpdd2CNC2hDwBx1MMn09lIuguo=; b=Rt9J+HC+2/l2eMqf
	4IUK2oNS682Q6nrpSmvdnMNpGjsizL+7vBLI98Gxe/CNdyBUlqxy7XWLfAqtQOfS
	iDtk3qAYM5N7j+TIPUTdiogqCcNgIDGND/baDOXPbIWJ1BQ9dRhhJbMsyIlNyWey
	c/wyp/QqpAPk/tJckm8MEM5JKywpLkN3hpZCjyui+7EwRMs0Hf7HkwSqmiJEtGts
	dUNBWUWcd61VfxUHQ6A3hClkQbkptilRTDtrAyGD9GGpBsCR4DhiVycdx9r5f1Yr
	L7J6DyrbomJu7MPDRPUUnAd4ZKIgNAPSh5Bw3TqTc5Oo9azPv00YzrzPAba/cKDs
	hUGF9Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0m7kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 10:17:41 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7296c012f86so88117076d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 03:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757326660; x=1757931460;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vCjXnZfE2tyLur7FXPpdd2CNC2hDwBx1MMn09lIuguo=;
        b=d+4CuJql/JJ8GlQmZmCoIV/oFSidCJOf4A9O4vy/5fZc9jQhRj1gh6HktuVVSl4bm+
         bscsKq1bsPJCesXv19IBJpNEh6uaiJxfNyBXkfyphVOqz6WhSm4vuz2dLIW/zRp8sJ4k
         MQNI2p3HZxeFF6rf5T75CEvtJnmnbaVlW6mrHj+pgU+6xndC0F4ITyYjNxUcD/xrSOiq
         +Kqxf6zxEG3xpxHjt4z/8vWgjBrLzqM6o9TlNw/OjkiixkrAx2uehPn67YfyF8n30bAA
         YKDFGj5CtI06pSaGcus5QEJfCOcbVwr6L/e6sOBtlXmb+RTy+1TYXqMsOwTS39EGoKbB
         gJRw==
X-Forwarded-Encrypted: i=1; AJvYcCUCLpLPJH37UfE601NqlpRgxXZol0jZ6Fe64hlDMXMNMnNRaibmgh3ERD2yzRY+Iwv4dmMuQ+qOtGuf/sk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp5Mo0ihbsNwTiyfDebFk04oivZeQIfAfedJt+ryi6vkAkAi0r
	3+7gBoMi+f6QbjJgv/LEAOyyRrbCjGA4PN5dwfRGdM6U4MzjAoAbNE4W+P8VMuo+oauWFH+wGkN
	hxAzsSK3z9VrSLu2cDb8UJfikLx9c0d5ZIdWPlWAqbDidHmyRkRHfrcpkFfh+E195rf0=
X-Gm-Gg: ASbGncs/49fDBoUL9W/nHujDOSfl1ONqAQvNryQo+B43TLCtE9COj5OAQMFhgJ85Amk
	3dyf5bNTZGo607ZmKZVfotetLF4k9rqTnHTMYpBfBZyDI4ipsIIbYhOHyszr2CnQ3iLJYsdeT7k
	8E67SHHbc6CwgdTRbtK8Nl7xQv6ySA0ji4JciYs6HQ05n5ahOmA7dV8CK0ILJK+SDtfBBHPw1xa
	BMS4UKbST34XTd/T3ftRZyNkfXRmwRZGN3Qnywmowypykyz+AO47FJKUnhiPzMlWSkra0HRWqbr
	o65F/MYQip3ODATAGSpeD8lltscYLkoSohVKlYnQ9zz8cSP/qlB+fUTbxmPeLtf04VcBhhBMsYQ
	1OhpuGTZ+gsEccv2StUxHvcM2Xv34Flkd7Pp9BoEe+fwRX6wqdsMS
X-Received: by 2002:a05:6214:268e:b0:71c:261e:54ba with SMTP id 6a1803df08f44-73921b4fd8fmr78452506d6.27.1757326660253;
        Mon, 08 Sep 2025 03:17:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXC4iVA1vMcsCtHF5DkIPqNh5JMkSdSnysesnslOPC68kcKK7iwzOJZg6GK+/J/kIv3DHUYA==
X-Received: by 2002:a05:6214:268e:b0:71c:261e:54ba with SMTP id 6a1803df08f44-73921b4fd8fmr78452136d6.27.1757326659568;
        Mon, 08 Sep 2025 03:17:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f50b0901sm31248111fa.59.2025.09.08.03.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:17:38 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:17:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: =?utf-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, syyang <syyang@lontium.com>,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrzej.hajda@intel.com, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        xmzhu@lontium.com, llzhang@lontium.com, rlyu@lontium.com,
        xbpeng@lontium.com
Subject: Re: [PATCH v1 2/2] This patch adds a new DRM bridge driver for the
 Lontium LT9611C chip.
Message-ID: <x3g4qxksghteg4tcv6vmuaoie3c6lh3gkjsfwj2qn4lvim6o6t@hrjtunavnedj>
References: <20250903123825.1721443-1-syyang@lontium.com>
 <20250903123825.1721443-3-syyang@lontium.com>
 <24rahlm4kkob7knapdxxnjixye3khx3nv2425y4kkirat4lmam@gjey7zqsnzks>
 <CAFQXuNZUfAJe4QEDfi+-1N99xO0_z5_Omnsn_-SXr2QPtvdL_g@mail.gmail.com>
 <7cyypk5j7o5fglmibshg45iysffpdl75m6rqvv4b5zntfevhiz@zlt7ybuzkvrg>
 <CAFQXuNb+Eq6KPFvsnmGvn7KKjn4WRtMy1x4pn4ZvZoQ-_S_fYQ@mail.gmail.com>
 <d3e3b838-26fa-491e-8c4f-63a1693f2391@linaro.org>
 <CAFQXuNbZfnySYmizY2=PJGLkk38WHOYbVcbPTRZvgY7bFdK8yg@mail.gmail.com>
 <zv7twvfxlira5wmg4zwk6kgkldgdiesgqzjky4733lp2us2hmx@tohls6czl3wz>
 <CAFQXuNa7z=RHtbx6zrtGGDK4dpa++m_BPxTNj8iemLkxYPP_zA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFQXuNa7z=RHtbx6zrtGGDK4dpa++m_BPxTNj8iemLkxYPP_zA@mail.gmail.com>
X-Proofpoint-ORIG-GUID: UbzZrPzUWT_qrAmEUZ0iiZSxQW4_Su0l
X-Proofpoint-GUID: UbzZrPzUWT_qrAmEUZ0iiZSxQW4_Su0l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX4FY4/QnEuuSH
 kL/oeoJR7sXi2GQreuCIGVc2wAS67Zmfvzg++3hZHtw21rpKtnGBpUEFed2gajIrp1GtMAnZvTZ
 wdRDFYGTkxK28MphZI2wt0YyATA4HJShhCKwLA6qB7gb9b/jHT6o+kl0dmcl/xkLKKxJY1uOj+R
 8xox8OcNxUEddLP8ZL1ItLRYoO5CH74nchCUb1XBQOOSHjRvywHWMJOR9XGYs20YpKi8biVWY/z
 Q0PCMPJRte8fa2Ac1qGwmXIu5ykiVZ5Ymegakjk9q/puFlZMvThBXt1xTl3aMQqtpJU3KQ6SGcx
 8TPjV32j0cdJuP+XW0HmBg/zSt9520nAgR6T6MUC41NEQh8dwRTG9agC02cocUomqBtjVq1HeTm
 wuLQIDWe
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68bead45 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=Fy06R7qyhczz9_k_:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=vWrx5uKgKmi_-Q7riJMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

On Mon, Sep 08, 2025 at 09:14:51AM +0800, 杨孙运 wrote:
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2025年9月5日周五 22:24写道：
> >
> > On Fri, Sep 05, 2025 at 04:58:59PM +0800, 杨孙运 wrote:
> > > HI，
> > >
> > > As a vendors , we have begun to attempt to contribute to the Linux,
> > > and we are very willing to do so.
> > > there are still many rules that we don't understand and need to learn.
> >
> > Not top-posting and trimming your emails would be nice things to learn
> > too.
> >
> > > <neil.armstrong@linaro.org> 于2025年9月5日周五 16:10写道：
> > > > On 05/09/2025 04:55, 杨孙运 wrote:
> > > > > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2025年9月4日周四 22:39写道：
> > > > >> On Thu, Sep 04, 2025 at 06:48:13PM +0800, 杨孙运 wrote:
> > > > >>> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2025年9月4日周四 10:52写道：
> > > > >>>> On Wed, Sep 03, 2025 at 05:38:25AM -0700, syyang wrote:
> >
> > > > >>>>> +     }
> > > > >>>>> +
> > > > >>>>> +     if (lt9611c->bridge_added) {
> > > > >>>>> +             drm_bridge_remove(&lt9611c->bridge);
> > > > >>>>> +             lt9611c->bridge_added = false;
> > > > >>>>> +             dev_err(dev, "DRM bridge removed\n");
> > > > >>>>> +     }
> > > > >>>>> +
> > > > >>>>> +     if (lt9611c->regulators_enabled) {
> > > > >>>>> +             regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
> > > > >>>>> +             lt9611c->regulators_enabled = false;
> > > > >>>>> +             dev_err(dev, "regulators disabled\n");
> > > > >>>>> +     }
> > > > >>>>> +
> > > > >>>>> +     if (lt9611c->audio_pdev)
> > > > >>>>> +             lt9611c_audio_exit(lt9611c);
> > > > >>>>> +
> > > > >>>>> +     if (lt9611c->fw) {
> > > > >>>>
> > > > >>>> You definitely don't need firmware when the bridge is up and running.
> > > > >>>>
> > > > >>> The previous text has already described the working logic of the firmware.
> > > > >>
> > > > >> It's another topic: you are storing the firmware in memory while the
> > > > >> driver is bound. It's not necessary. You can release it after updating
> > > > >> it on the chip.
> > > > >>
> > > > > I understand what you mean.
> > > > > Based on the above conversation, your intention is that when the
> > > > > customer needs to upgrade the firmware, they should modify the
> > > > > comparison conditions of the version, then compile and burn the
> > > > > kernel, and then perform the firmware upgrade, just like the LT9611UXC
> > > > > driver. Instead of loading the firmware every time.
> > > > > My design intention is to avoid the need for recompiling the driver
> > > > > when upgrading. Instead, a file named "LT9611C.bin" can be directly
> > > > > sent to the "/lib/firmware" directory via scp. Then you can either
> > > > > perform a reboot for the upgrade or execute the command manually for
> > > > > the upgrade.
> > > > > Perhaps you are suggesting that we could follow the design approach of
> > > > > the LT9611UXC driver?
> > > >
> > > > Yes no need to rebuild, just use sysfs to trigger an update.
> > > >
> > > I think you haven't attempted to understand the intention behind my design.
> > >
> > > If during the debugging process, the customer discovers that a certain
> > > parameter in the chip's firmware is not suitable for the current
> > > situation, then he requests a perfect firmware from our company to be
> > > updated onto the chip.
> >
> > That's fine.
> >
> > >
> > > When there are hundreds or tens of thousands of devices that need to
> > > be updated, simply use sysfs to trigger the update. It is a very bad
> > > thing.
> >
> > Delivering updates to devices it off-topic here. You can use SWUpdate,
> > Mender or any other system to deliver updates and to trigger the
> > firmware reflash afterwards.
> >
> > > If you want to use version number comparison as the upgrade condition
> > > like in lt9611uxc.c, then the customer will need to modify the version
> > > number comparison condition and rebuild the driver. This method is not
> > > as simple as the one I have designed.
> >
> > Well, no. If there is a firmware update, it should be shared to
> > linux-firmware and then everybody can benefit from it.
> >
> > Think about one company using your chip in their SoM or compute module
> > and then another company integrating that module into their design?
> > Who will contact you? Or a company selling devkits with your chip.
> >
> > Having per-customer firmware is a nightmare for developers and for
> > integrators.
> >
> 
> We are a company that sells our own developed chips. After other
> platform design companies purchase our chips, they will design their
> platforms based on the hardware schematic of our chips. During this
> process, they must contact us. We will communicate about the design
> opinions of the platform, the configuration of parameters, and the use
> of custom firmware. We cannot provide a common firmware. This is
> determined by the characteristics of the chips.

We are getting off-topic here, but this model has issues as the platform
design company might be completely different from the company that ends
up (re)using the platform in their products.

Anyway, I'm looking forward to reviewing the next iteration of the
driver. It is really appreciated when chip vendors work on the drivers
for their chips.

-- 
With best wishes
Dmitry

