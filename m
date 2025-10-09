Return-Path: <linux-kernel+bounces-846949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEC4BC97F7
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54A07351E64
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A609B2EA496;
	Thu,  9 Oct 2025 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YR8u+Gs/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502E12EA47E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020013; cv=none; b=NxZ5Ojf3VAWQfHrwHOYMVeOVy8v/s5LgtA9gRiQhp/K4EvCGooZRm3oYzgV1S+8yVnBqT3HUNC5rNEwP4JNhUa7QuzAPFEwgVq3s0MUIvscBL/yQGZDKU09te1hee23pbGMSNZwyX89ZM8jRtk2F2xB9m8nPbpmId5HENM8iTao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020013; c=relaxed/simple;
	bh=8hvdupc+LZK/iN+CW4zbSmj8G9FzomotMvequinYfSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGOeULd+Fu3jf63Cvo7P9J+T6HI+g8uglkqOv/e6PGPLnMuxdev+3pVf67UZTFWX96Qzefji2gaSSSIcGOnMBLRsMXngFwT25fu3cZnOL9jskKJxex3FHFEKWTSxnLQC7GmbCKlDqZJqGdgXPw/MN4LpgB8QKxWO0+ULi+8rXMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YR8u+Gs/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996ELtS019211
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 14:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=G2KvXnwbuscjouOeX9M2xhbN
	j+kin2y5TQrFozgduvU=; b=YR8u+Gs/wtwLU58ZURivOsxW92bTU+ngTcRJDdn6
	ZT/eU6WoX5YaoxxHNjuTJDjBKUj+rqCxM6EdVLaLxxr4cCP984JzbUP0kiKJrEw9
	9uzHclNOl6GuTNUt+7C/bFvMJH37oEAe1qbuDg7eLOuaKnv6h+kJyhgLmER9g8ja
	5hJNLuV2OSVu8yVHQsxnV0W61H2fLrtR8lD+pFyfJZQQ48r419N7pX+Lm81VY3IV
	wKC2GhXO6ORGFm5eoMYHQg31fOyiNwcpObEW8SfbzIJbV/gH2FcGVlTvMVjnm4Nz
	HxI8mDhBhy+Z2hFnDceypl06uTyHHBRsZ/qZYmdtp2aTuQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4nu4wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:26:51 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-78e45d71f05so24941016d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760020010; x=1760624810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2KvXnwbuscjouOeX9M2xhbNj+kin2y5TQrFozgduvU=;
        b=DVCwm2HC3TEgLFOcjDU0wiEeY4VwQmouavHAbcDUAj9mtAn3as+x9zpK/9mWoJ2cu9
         tNT14uhEntxS6Qw15XT9ba+4hBVWifNMLWL9JejWlfU540gxyqgeH59ZXAFmSiqD4YyZ
         UvgvStRArtINWu5Q7Nx5MSOXKn+18vg3xm+I2kvKZrcQFLZiQz2ZvZbM4yYy8HOGUo85
         6LomLBlMfN4W6LeJ0JEczYbh0WrM8QNuVI1JmAfHi616ZpyB+YbXtA6aOTtMYQaBzSJi
         6GPSkAKeVBnLjXxcxuNyanToba6i7Ou8hMCQqltLoIfcrOtKL6+u/HpjAVHkmjF9gZTe
         y4zw==
X-Forwarded-Encrypted: i=1; AJvYcCW/ptod/c5noNzHtS2dwdaE0fU8l1opklUvcZUufDueP1MKk7/1ImKGtailDXldedcPyImPnjsxqHS6TKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+uQMlpsiPXP9tBDr4Qb79r6TS7KKJxYHnSvC2iEXfRlvF5o4t
	F61XFteKM3QKfqhQTjrmSxnmsKiqki/PRYGazq3T+CJ7xYGmz/d3Wr/qU/VvXU57M3uOvhZTnhq
	Fir1shfuElvme5GQvORl4BV7Xxn1MhxkcQ7o5bpiA4ix3XAdazrplIB5mg1diOxWxb04=
X-Gm-Gg: ASbGncuxSAekLWoYcmG2ZlfC42hN8p8DaOvLLnsA5wuJzEMWRBZYL5CiEghdxtYGrMo
	Y8IaBon4PbOBn1pyJbeQ1/7Op6PsFeXacc3WhDimGBB2iYkdUQ0gOijPmbeosaapaVDtjKcNYhp
	bFh9R3+BRj5uk7SMVZvJUWCXQd5U3vZdxhFk4+LSxrl7m5wsLGB4VX+8aog48/cVTKDaY3Dho5b
	QNtCx5JvJj/In2Jx4/7XaL5pZdC4ki24qyT2uOe7Q69mEfHMSKvTO/wpwXERHJa9DjoDt/lai8J
	I/yt1BuaxMZJUrhn/WIYVNc7ZH7Yz1f16FgWWcBz/alJoRmYfps0NQawmEXfJBdGFR20yLjJf+M
	u2/sgCBrz04/IhYSamkfxfeUxunyey4SMggL8abtIEUeJKU+ovLDWBOSz7g==
X-Received: by 2002:a05:6214:2aac:b0:783:2157:5a34 with SMTP id 6a1803df08f44-87b2f02ba73mr98393866d6.65.1760020007674;
        Thu, 09 Oct 2025 07:26:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdTWGuZxMQcCYadLFdJmdthwUCJVxPbcp/MQRks6lOTZwcbWtf0yNa8g4UdjMUG53579SmMg==
X-Received: by 2002:a05:6214:2aac:b0:783:2157:5a34 with SMTP id 6a1803df08f44-87b2f02ba73mr98390956d6.65.1760020003398;
        Thu, 09 Oct 2025 07:26:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f3b63f1bsm28387511fa.31.2025.10.09.07.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:26:42 -0700 (PDT)
Date: Thu, 9 Oct 2025 17:26:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: David Heidelberg <david@ixit.cz>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
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
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings: panel: Add Samsung S6E3FC2X01 DDIC
 with panel
Message-ID: <3mbngf2r3rvbn5fr4vxbk64ouvm3voo5o2r63vg3clyswnceoh@64r6ujb5qr65>
References: <20251008-s6e3fc2x01-v2-0-21eca1d5c289@ixit.cz>
 <20251008-s6e3fc2x01-v2-1-21eca1d5c289@ixit.cz>
 <7askbazrkbny5jlw6cpxcpjyw5nyiozmksoyj5b5momcc7w5hn@r3x6kddatf3u>
 <74893f76-1b7d-4cfb-ba7a-9fd64427762b@oss.qualcomm.com>
 <bmsxmwfdwx7wlmngaqpvz7c2nudcoukspkxgq6zqh2mdlolfxg@fsdbafotp5q2>
 <75011ead-8bd8-4939-ae7b-1c127eba8aa8@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75011ead-8bd8-4939-ae7b-1c127eba8aa8@ixit.cz>
X-Proofpoint-ORIG-GUID: GtisBzKAECVC9kzIT5mfA25hacw7XAAv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX4p2VwTk7jb7U
 BbI0HVV8sofhxZw6B8/lTgLlXeu7biEROeN+J9vjfUyTROcKd86I73h3Y0/txUEWNzVk5TlKMn9
 /ho0hrsW/Uqvu0QTJwCYbenTgQ20KbtT3AQtQM2O+P7sEwkSO1NmsZ+F3FY5DokHZPXOoPwKQ94
 hqjbq9TbB+sc0F/tVA2ip8n2CQBB2Etuv0NVVKM+QfrjOk+psInb1JfKhV2REZdOUTDDedjhuwU
 cH6MPrAQNA3YRPrbKKWdETexTLOou+cfCYOeGVCbXW5HoWw4iNBs6rmtaVKW54KFyg4yYPkH97d
 7Os5LoWkwXQ3eeGlwg16iEeMsTCs0WTsZLJ1atjGDg7UIG1qAlbj1WtirYunRnRJYT+7AU6ESRn
 MKgBDKol8lam0/bKhwBLHikHSsQi4w==
X-Proofpoint-GUID: GtisBzKAECVC9kzIT5mfA25hacw7XAAv
X-Authority-Analysis: v=2.4 cv=b6a/I9Gx c=1 sm=1 tr=0 ts=68e7c62b cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=df2SJZlNlAcoaDSKSIcA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Thu, Oct 09, 2025 at 03:32:22PM +0200, David Heidelberg wrote:
> 
> 
> On 09/10/2025 15:21, Dmitry Baryshkov wrote:
> > On Thu, Oct 09, 2025 at 10:51:31AM +0200, Konrad Dybcio wrote:
> > > On 10/8/25 8:57 PM, Dmitry Baryshkov wrote:
> > > > On Wed, Oct 08, 2025 at 04:05:28PM +0200, David Heidelberg via B4 Relay wrote:
> > > > > From: David Heidelberg <david@ixit.cz>
> > > > > 
> > > > > Basic description for S6E3FC2X01 DDIC with attached panel AMS641RW.
> > > > > 
> > > > > Samsung AMS641RW is 6.41 inch, 1080x2340 pixels, 19.5:9 ratio panel
> > > > > 
> > > > > Signed-off-by: David Heidelberg <david@ixit.cz>
> > > > > ---
> > > > >   .../bindings/display/panel/samsung,s6e3fc2x01.yaml | 78 ++++++++++++++++++++++
> > > > >   MAINTAINERS                                        |  5 ++
> > > > >   2 files changed, 83 insertions(+)
> > > > > 
> > > > 
> > > > Please also describe, why it's not enough to use defined compatible,
> > > > samsung,s6e3fc2x01. Why do we need a separate schema and can't use the
> > > > panel-simple-dsi.yaml
> > > 
> > > panel-simple works for 'dumb' (perhaps a harsh word for 'made with
> > > just the in-spec DCS commands in mind') panels, but Samsungs are
> > > widely known to require a ton of vendor magic
> > 
> > The question is about the _schema_. I think it's fine to have a driver
> > for a panel covered by panel-simple-dsi.yaml.
> 
> see display/panel/samsung,amoled-mipi-dsi.yaml
> the OLED display don't fit well, but I wouldn't mind consolidating at some
> point, but since we know very little (no datasheets), it's hard to do for
> now. Maybe in the future when there will be more panels schemas, we can find
> a way to consolidate into one big?

I'm looking for a simple answer ATM: it doesn't fit
panel-simple-dsi.yaml because it needs foo bar baz, which is not a part
of that schema.

> 
> > 
> > > 
> > > Perhaps the original change was made with an "oh it just works
> > > surely there's no drawbacks possible" attitude, as the panel
> > > was left initialized by the bootloader

-- 
With best wishes
Dmitry

