Return-Path: <linux-kernel+bounces-859688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 220D4BEE487
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 14:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34F02349DAC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 12:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B242E54D7;
	Sun, 19 Oct 2025 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g8ouADzE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7BA2E4247
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760875915; cv=none; b=cF+s81SxF6BCqJt4uVp0nA+1BLi0Q07ZIHRfPjrygrM5agcFJSvb06f4iiP1wxR3j2gBzBj9ms2NW0CIAmOpa1hjzvgshJHeqRFoiWkzbHxhLOBa98Hqi8xyxWlp4X7x9FuHMxm+ySb3z9GpmFAwswb0VRHm4aGQ8KI1hUjrTq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760875915; c=relaxed/simple;
	bh=jvznlM6D5OFeTEFwMN+wEgRK7LeLJiu3wj1O/umiVSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRYEmQLuzX5lOhXyBY/G4ZM6NKFkuHTb/9sWcdnLEVP+x/9jH5CjBVT3lgZC33ckTAPW+E7c2o/pFQx+1f7OdZsDtV8gOy/i6ZJyTCyKNhoVz7Td9MCV1x4ALAh2p1VbR76xtKA7rW3wowAbI4NckCfjdRAF0SlDo/PqRdXt9KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g8ouADzE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59J6pvsm005605
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 12:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FXakmNjNk9hILrNuLbMXrtpa
	gW3k4d1NuiaVjYCVt/0=; b=g8ouADzEe0zM/uNAVtVaconF+XQLNz+dEJWtiayy
	wZxGiZVX74GKQFgaPqUdiyjOsqx9Q67CLBNMvO3UZU3IxvLpIB9yUJ2you+o4zvr
	HTBnLtyiVb8GD3v9rTSx+QfOyb6UlW4i+KzQrY6CvsLLMPKNSni1LjiQmPcoYyH6
	GmhpYg7qy28ZubfupYrrFfUeX74bL/p+lX+RBANpLiQ+6N2xa2ZsvBOdKEn16Z9J
	3ujNlM5WqFj2bWuSfW2x2irKnhIDL9n/BzRr2jlIrqMBX3dnjL9U0F/xb97u9WaJ
	zgxW9W5fzW9mNnw/w/3eybvl1zxu6NmD+LXTBhBohKLgFA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2gdtc0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 12:11:53 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8787a94467cso125506366d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 05:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760875912; x=1761480712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXakmNjNk9hILrNuLbMXrtpagW3k4d1NuiaVjYCVt/0=;
        b=p6cbJIo/pbZgLxchDQ/82Wy2HBKaGxodshzGvijFAUkKYhzjoJtjcul7X4Y2Nq2pPB
         njRDVpn8YCYDYRhNfKIS1dZzrDy5T6H31f7iSfzXvKxORXc9+TAF6HpSbtqM08H/ApYm
         oowA0AUrRFL6z5MfVocX+JV8A1q0WkXajvJMIR+SxWaUJyuYILRyoe4W7lYazIBI498/
         lVoeXuxj+YdxUwP1z3lZ0jg0foLGjWew0Bp7vD+ecvdagY8+60kUDLxKAfw01PdNOvTu
         6gaREyJMd7S4uexIHgiuk8u+RIZHGclx92XMPetdZojIQg06bysRpMmEfKeS5fCQb7BZ
         CQaw==
X-Forwarded-Encrypted: i=1; AJvYcCWRmlOn94Lvp+Z//l8gBJws5yYlNa4tUh6c/Ij3PsA2GHOBuS2pRjWEiAXzp/O3jxpfcqsfxBrP7dVyGfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHpdvJVlgDLChFguuGf3z5PR9fvwQdws51Eppq+fY5BeSzwi7g
	8Rwf3+hs3kVBQSTiLPVhNctjpZA4vNe470V0f02ek3ZWUxNMKX3tPo3u/EhyRvsCevjfD8HCPMp
	b5byTNDZhRMEASuH7TA9byOORjYc2MaCqTjr30uQ1NLg5CLhyffiR2IGUTVHuRH/MsvY=
X-Gm-Gg: ASbGncv7hRNj5nJfhvRnIPKZji3mnyYe/b7NHFLwow+c5nWnjmJA3gqCDJcwkDgkuSu
	7kF3D8SC5TTenLl8XrYJnRKVPHCih0YdMq2HwVtWpPAQEX8oh/iSPcmVVKPx3WP0NpV2J2lf5w9
	i8b7jinyrdMpDdllPKBvXT4PCJMyhlJyuoog4F/V2sG5r8FeytIA9rB6WRMCZgSaEpZyqBMvMTv
	ZteXWBcZlBTLK22J6QFPXODtW2V7JoCVzIkfRc3EagWLM6RCaBuQPRIMP19/ptP43Q0pWXvYKGt
	3yFyLlXk6VuKCiysDtz+69bhPw1p95PeH3Yi549xHLGwXZpVeeNO+Ppdsz5QxHDbqQ64rxLFuFZ
	NEfFE1HJbtIHpRlXXHfmB+xKSnZlJTvX36JH9qzZGE0PhJWhq52SxoE+hQhVBIBSOUihmXp07Hh
	2qWyPCWx7vc/M=
X-Received: by 2002:a05:622a:5cc:b0:4e8:a51e:cdbc with SMTP id d75a77b69052e-4e8a51ed369mr89145121cf.43.1760875912134;
        Sun, 19 Oct 2025 05:11:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQGIvBCD9sJ/M1qvRjDaUZ1+T6tRELaWa2oMHhW/HyBqE/0fYTWTtclEdazefvpcZR2v9Ysg==
X-Received: by 2002:a05:622a:5cc:b0:4e8:a51e:cdbc with SMTP id d75a77b69052e-4e8a51ed369mr89144771cf.43.1760875911633;
        Sun, 19 Oct 2025 05:11:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a91b7111sm13663761fa.7.2025.10.19.05.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:11:49 -0700 (PDT)
Date: Sun, 19 Oct 2025 15:11:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: David Heidelberg <david@ixit.cz>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] drm/panel: Add Samsung S6E3FC2X01 DDIC with
 AMS641RW panel
Message-ID: <32iy3k5aq7aiz3juq5i2wnnidsmbde3kdixlkpxrvgv75573ow@ebo3pi6kbr6n>
References: <20251016-s6e3fc2x01-v3-0-ce0f3566b903@ixit.cz>
 <20251016-s6e3fc2x01-v3-4-ce0f3566b903@ixit.cz>
 <didkbltadu4ql6xcqtjrtf2iguody5bgy6mqlwtbyfgbambaii@mzofzymnfbju>
 <d13cdf83-22df-4a24-a711-2db4abe3a0a8@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d13cdf83-22df-4a24-a711-2db4abe3a0a8@ixit.cz>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX0EYEpTGuAg3H
 jV8Be7Jjd4DKpFqO1FY+Xruk4cqZuHG2WbaWG+5gRvPD2edrDG1+z8mWeIs1JIVTBGprTijp4mF
 Mrnou0t3IyTVa01rtq7nFnaJfMlR+jxpWs1c2ONeqxif1inG33aQVd5IwkqkX16EmCzSWXzCGzA
 XPO3ZNVE7CHGxiweC2UHObk9mqqLm+Xx8Fkbjt0fI8e//Qe7QLoW2Zytgr5V7Tdyd3t5sM5GNiM
 DReNkeCDer4eV9WKHI9BcV7q9en3VVPChdOxGms88ZH+5sNy1PAbmFRFJyUuFhzfupihaBvH1gh
 h2Et0gibfQk2JazQgdCs3RGWmO7TUOUi5y6Y76QTbOSjIYmUXAxsOMzbpwG/HoQ7J5SXfVXZPUJ
 7Rkx5+OsnOSODKECOCJlCCuvAd2miQ==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68f4d589 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=WFa1dZBpAAAA:8 a=bBqXziUQAAAA:8
 a=yoNOsk6A1An68yMDdNAA:9 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=MZguhEFr_PtxzKXayD1K:22 a=BjKv_IHbNJvPKzgot4uq:22
X-Proofpoint-GUID: ntAhzxsPxsXFkor-5MmCfoGQqDWn0urA
X-Proofpoint-ORIG-GUID: ntAhzxsPxsXFkor-5MmCfoGQqDWn0urA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

On Thu, Oct 16, 2025 at 10:46:56PM +0200, David Heidelberg wrote:
> On 16/10/2025 22:12, Dmitry Baryshkov wrote:
> > On Thu, Oct 16, 2025 at 06:16:59PM +0200, David Heidelberg via B4 Relay wrote:
> > > From: David Heidelberg <david@ixit.cz>
> > > 
> > > Add panel driver used in the OnePlus 6T.
> > > 
> > > No datasheet, based mostly on EDK2 init sequence and the downstream driver.
> > > 
> > > Note: This driver doesn't use previously mentioned "samsung,s6e3fc2x01"
> > > by OnePlus 6T device-tree.
> > > The reason is because DDIC itself without knowing the panel type used
> > > with it will not give the driver enough information about the panel used,
> > > as the panel cannot be autodetected.
> > > While would be more practical to support the original compatible,
> > > I would like to avoid it, to prevent confusing devs upstreaming DDICs.
> > > 
> > > Based on work of:
> > >    Casey Connolly <casey@connolly.tech>
> > >    Joel Selvaraj <foss@joelselvaraj.com>
> > >    Nia Espera <a5b6@riseup.net>
> > > 
> > > Signed-off-by: David Heidelberg <david@ixit.cz>
> > > ---
> > >   MAINTAINERS                                      |   1 +
> > >   drivers/gpu/drm/panel/Kconfig                    |  13 +
> > >   drivers/gpu/drm/panel/Makefile                   |   1 +
> > >   drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c | 399 +++++++++++++++++++++++
> > >   4 files changed, 414 insertions(+)
> > > 
> > > +static const struct of_device_id s6e3fc2x01_of_match[] = {
> > > +	/* samsung,s6e3fc2x01 will default to the AMS641RW mode (legacy) */
> > > +	{ .compatible = "samsung,s6e3fc2x01", .data = &ams641rw_mode },
> > 
> > Is there a need to probide this kind of legacy?
> 
> I don't know. I don't see the need to provide it, but I understood you may
> want to have it. If not, please tell me and I'll happily remove it from next
> version.

Since this never worked as expected and there were no DTs in upstream
that used this compat string, I think it can be dropped.

> 
> David
> 
> > 
> > > +	{ .compatible = "samsung,s6e3fc2x01-ams641rw", .data = &ams641rw_mode },
> > > +	{ /* sentinel */ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, s6e3fc2x01_of_match);
> > > +
> > 
> 
> -- 
> David Heidelberg
> 

-- 
With best wishes
Dmitry

