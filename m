Return-Path: <linux-kernel+bounces-807990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F5EB4ABBB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E39168025
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1661C256C7E;
	Tue,  9 Sep 2025 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ocZKxBmq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7799F2D5C95
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417058; cv=none; b=lc6TC1RGDG7HfRJugRHJQpm+hvX+wjAlco18zhwdeYw1qRKO2OO2RocGvFiOXY7SqY11wXhJEj4dGXfITvCoQ6blprrwKambHkI9psfAwdx/v7Mu9zbAxRGx4TFpRTYQlfnYESDl9McTk3H/ASr90v5fKLKA/AtS6Y9AaAh7Fbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417058; c=relaxed/simple;
	bh=E+fiPsn0tG39c3qNxx8sOEVY4RKa86dHNXFiHTec0m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ha/men0hdR7mbuG1X6aSlrAHRg9p8MLit004ublnc1jhp355CAvKQE1VIm3aWBVVJGHPAXgtWYmBJbWVDbP06MhG1f2n/V43NJeNToWNO/3GE4Bcu+k6OmPNgzx9JR1MHcMgT5/NqaxKdEe2DSkQLYbabFaADMQwEknZGUtHCho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ocZKxBmq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LSh0032346
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 11:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KRjLROUBK5GNMNTT3bqbN9Gw
	tJh3/RE+/25tzLkEzd4=; b=ocZKxBmqiKmvw6Je/NWnjH48liN++RNyJ9wA43xV
	bnpm0pmhorsTk5HRgFSWPp1+laYU4FarMjvSIRJvEmctbN70tbPJWCRlwI6r8b3P
	8Apqi7+3w2HAjS7fNcuhnEBqTsdHzcKs/FajsJLrfGSaiLXt3A6WbaaYG24QoLEW
	vwyU1AMMW5XD5697kW5VuaXHM0f6JurzSd1tpxBETh9lw1TNcTwON1BSTlqlQ5jm
	rzFjoThNh4ueyIA84rzfeT1uUxHGyqmGcLJxQTgmC9MXTuWjrDXEDi6m2dnz88mn
	JY7ddj0YsDcQsIiXiBpmOeTLnEAVUR+3+GQ6LnEAvF8OCg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4kyw5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 11:24:15 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5f818eea9so73482841cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 04:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757417054; x=1758021854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRjLROUBK5GNMNTT3bqbN9GwtJh3/RE+/25tzLkEzd4=;
        b=ofd/ip5AzFLj7TM5Zwy19sx4gNFQIgVaDeirRY3dRG6qT7fa0GrB8q2mykZv7RlwKC
         xR+PMQlklxZWQrBFwuwHmGiCTtghmByNHnbSPrGKjiodI4KYB98eeyHrhVs1zdt6xljP
         yfegaubYxtcRjkQzf/fdjEKhP1SeW/4WZLhuMx7rs1bWvfeLH0JL4ZvXJ0iYZYK9fgh+
         ce92lK4eIV/tT7rouz78QbH3xQspgFz+hg/7a1U1r4W1Xyq7K5XDJCMG2DObge8rXygP
         TFd4cCr10HhWLRqNQE7gmIwWp2PBFq4laXscLsisXC6nkcK37D38jw9xpy42A7b4egNm
         g44g==
X-Forwarded-Encrypted: i=1; AJvYcCXLcsT7pqsr+mAu6i1nt0L6rFrqnIBQmcfl90LLMjtZfZ43+V6EFkuJAzgbrxEDWlRlV2X4ad77WEkLyj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKVXczym0S2mBAGUR+WsBj2NG3HAd6if8hxcljzvuVCGkSumGX
	3I2BllYrFYPLzGiB3MG0YZCup7ebfvSP/qaaqba4RUXBrT/k7KO51zoEeHsjS4fls2PSABKBYXV
	kc43xjWwYYrcfD6r1Vhlr7jkRWv9jI/HlRJ9c/S8N3XM1jWspQZrblob3afapJHN3T6g=
X-Gm-Gg: ASbGncsXq2GUp/OLghr4b8ECaPr2wn8+JAZJe6MC2+XOfoDYV2fDlR/HU5HKSKvP0pu
	yeHFqKQk7jbGRBHpI8RnOupog0BwY7FdtwM3cu4eUZ+wVX2wdZ46WytrQlOdr0J2R8CeA7sOnQW
	kUVqMr6epWXIheLfPpovl/ifkTvhywBt/OPvLvngh7sqO6XFPFRG6aafCZzQzKX5zDNB0NF1nNr
	qqlvXzbYKwUFvo6PIhHZ5yoxbLJaQmfLAwPgLW6ZleuqytrF1H3k7vFI6DvifyZCmhw6pu9VgUv
	BdcSHSaIVqhYvBIzB4XiwrYxP5s3SIdsUpHBXOe2PP5/9YlRFdLma5GBoAGZSNqQs8y8BRN2o+z
	aX5qGFrqZC+RljDir0udnRWovF9ZpPDrTd9sU60FrbtLZgFXq/0zh
X-Received: by 2002:a05:622a:4ccb:b0:4b2:8ac4:ef64 with SMTP id d75a77b69052e-4b617ab79a6mr53467561cf.71.1757417054177;
        Tue, 09 Sep 2025 04:24:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwyKidHOZHQUdMHjuNAtLDDa/IAQun/33WbLv7lhyDBwjJicuH8c4C2tkyAmG306W39xJ2pQ==
X-Received: by 2002:a05:622a:4ccb:b0:4b2:8ac4:ef64 with SMTP id d75a77b69052e-4b617ab79a6mr53467261cf.71.1757417053656;
        Tue, 09 Sep 2025 04:24:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680c424dafsm469142e87.28.2025.09.09.04.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 04:24:12 -0700 (PDT)
Date: Tue, 9 Sep 2025 14:24:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 4/5] phy: qcom: qmp-combo: get the USB3 & DisplayPort
 lanes mapping from DT
Message-ID: <77itzcvk23emlsoem2xcs7wswic7a2nj52i3m74kmkmo3xp65s@lsh7vmu2aqjb>
References: <20250908-topic-x1e80100-hdmi-v3-0-c53b0f2bc2fb@linaro.org>
 <20250908-topic-x1e80100-hdmi-v3-4-c53b0f2bc2fb@linaro.org>
 <dfhvmeo3pnjubgiwvakpzhzgl6uwlopyrkwuqyhfqw6jfh4mty@t4lhuh4jh6af>
 <b8156d1e-a4a5-46dd-8b78-4f2528a177c3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8156d1e-a4a5-46dd-8b78-4f2528a177c3@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfXyB4hMYrbQ74g
 hW2BYcnmItrWJq2VDzECSVQod3r3LE2AFlbINnCGso+ulnhy0UcksZIWzHc6A66TjmLwYKw0rVj
 XORb+vS3yr1BIFfQCV0nIRaqUTeiI7IJKdpi6ZV1KUEyenXkcGXc7Wo0C6vTDC+l12JA7Iy+m6S
 v34GsOoDwNdANncckuX0r7RtMIOrDYugDoCBVvP2Gcw4GkqXuGbQkPFzv3j1svlb0X9gliNYntk
 3XXp8wIreKI3ZBoE15RAtacbLaKcuwrYLotz6VvOaCGq3xgner2f5Vxnug1RSAr7puEJsogAHeO
 1vC8gn783mZaEO1dhT9zcuZWvMG0scnLSMEctD2kit4e2DkA09X9tiTrFutXeWI2geB+At4RwUJ
 OAW8dnwA
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68c00e5f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=bPd9SfhoXQ6rEPgJaLYA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 6wS3UPNkl7763OQDUasVNXZioUzrLQha
X-Proofpoint-ORIG-GUID: 6wS3UPNkl7763OQDUasVNXZioUzrLQha
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

On Tue, Sep 09, 2025 at 09:21:33AM +0200, Neil Armstrong wrote:
> On 08/09/2025 23:24, Dmitry Baryshkov wrote:
> > On Mon, Sep 08, 2025 at 03:04:21PM +0200, Neil Armstrong wrote:
> > > The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
> > > of a combo glue to route either lanes to the 4 shared physical lanes.
> > > 
> > > The routing of the lanes can be:
> > > - 2 DP + 2 USB3
> > > - 4 DP
> > > - 2 USB3
> > > 
> > > Get the lanes mapping from DT and stop registering the USB-C
> > > muxes in favor of a static mode and orientation detemined
> > > by the lanes mapping.
> > > 
> > > This allows supporting boards with direct connection of USB3 and
> > > DisplayPort lanes to the QMP Combo PHY lanes, not using the
> > > USB-C Altmode feature.
> > > 
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > >   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 132 ++++++++++++++++++++++++++++--
> > >   1 file changed, 124 insertions(+), 8 deletions(-)
> > 
> > Looking at the patch... Would it be possible to make it more generic? I
> > think some of the RockChips also have similar combo USB+DP PHY (and
> > similar issues). I believe, Mediatek might also have the same issue.
> 
> Since they don't use the data-lanes property, it's hard to make it generic and I would
> avoid migrating their DT to data-lanes just to solve HDMI on the Thinkpas T14s...

I'm waiting for Sebastian to respond regarding the RockChip USBPD PHY.
In the bindings he mentioned having separate USB and DP connectors, so
it might be relevant.

> 
> Let's solve this first, and code can be aggregated afterwards if the DT representation is correct.

Yep.

> 
> > 
> > > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > > index 7b5af30f1d028c592500e723ecd27b54ed554709..f3f91a69dc8b81e049cd06f7ab4f04baf57776cd 100644
> > > --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > > @@ -13,6 +13,7 @@
> > >   #include <linux/module.h>
> > >   #include <linux/of.h>
> > >   #include <linux/of_address.h>
> > > +#include <linux/of_graph.h>
> > >   #include <linux/phy/phy.h>
> > >   #include <linux/platform_device.h>
> > >   #include <linux/regulator/consumer.h>
> > > @@ -1744,6 +1745,21 @@ static const u8 qmp_dp_v6_pre_emphasis_hbr_rbr[4][4] = {
> > >   	{ 0x22, 0xff, 0xff, 0xff }
> > >   };
> > > +static const u32 usb3_data_lane_mapping[][2] = {
> > > +	[TYPEC_ORIENTATION_NORMAL] = { 1, 0 },
> > > +	[TYPEC_ORIENTATION_REVERSE] = { 2, 3 },
> > > +};
> > > +
> > > +static const u32 dp_2_data_lanes_mapping[][2] = {
> > > +	[TYPEC_ORIENTATION_NORMAL] = { 0, 1 },
> > > +	[TYPEC_ORIENTATION_REVERSE] = { 3, 2 },
> > > +};
> > > +
> > > +static const u32 dp_4_data_lanes_mapping[][4] = {
> > > +	[TYPEC_ORIENTATION_NORMAL] = { 0, 1, 2, 3 },
> > > +	[TYPEC_ORIENTATION_REVERSE] = { 3, 2, 1, 0 },
> > > +};
> > > +
> > >   struct qmp_combo;
> > >   struct qmp_combo_offsets {
> > > @@ -4167,9 +4183,114 @@ static int qmp_combo_probe(struct platform_device *pdev)
> > >   	if (ret)
> > >   		goto err_node_put;
> > > -	ret = qmp_combo_typec_register(qmp);
> > > -	if (ret)
> > > -		goto err_node_put;
> > > +	qmp->qmpphy_mode = QMPPHY_MODE_USB3DP;
> > > +
> > > +	if (of_find_property(dev->of_node, "mode-switch", NULL) ||
> > > +	    of_find_property(dev->of_node, "orientation-switch", NULL)) {
> > > +		ret = qmp_combo_typec_register(qmp);
> > > +		if (ret)
> > > +			goto err_node_put;
> > > +	} else {
> > 
> > At least this needs to be extracted to a function (or set of functions).
> 
> Yes I was not sure about how to split, and overall I'm not supeer happy about the design.
> 
> > 
> > > +		enum typec_orientation usb3_orientation = TYPEC_ORIENTATION_NONE;
> > > +		enum typec_orientation dp_orientation = TYPEC_ORIENTATION_NONE;
> > > +		struct device_node *usb3_ep, *dp_ep;
> > > +		u32 data_lanes[4];
> > > +		int count, i;
> > > +
> > > +		usb3_ep = of_graph_get_endpoint_by_regs(dev->of_node, 0, 0);
> > > +		dp_ep = of_graph_get_endpoint_by_regs(dev->of_node, 0, 1);
> > > +
> > > +		if (usb3_ep) {
> > > +			ret = of_property_count_u32_elems(usb3_ep, "data-lanes");
> > > +			if (ret == -EINVAL)
> > > +				/* Property isn't here, ignore property */
> > 
> > In all thsese error cases we are leaking a ref count on usb3_ep and
> > dp_ep.
> 
> It would be much simpler to solve in a separate function.

I'd suggest having one function which gets USB3 EP and parses it (and
then puts it), another function which gets DP EP and parses it (and
puts). This way you won't have to worry about reference leaks.

> 
> > 
> > > +				goto usb3_mapping_done;
> > > +			if (ret < 0)
> > > +				goto err_node_put;
> > > +
> > > +			count = ret;
> > > +			if (count != 2)
> > > +				/* Property size is invalid, ignore property */
> > > +				goto usb3_mapping_done;
> > > +
> > > +			ret = of_property_read_u32_array(usb3_ep, "data-lanes", data_lanes, count);
> > > +			if (ret)
> > > +				goto err_node_put;
> > > +
> > > +			for (i = TYPEC_ORIENTATION_NORMAL; i <= TYPEC_ORIENTATION_REVERSE; i++)
> > > +				if (!memcmp(data_lanes, usb3_data_lane_mapping[i], sizeof(u32) * 2))
> > > +					break;
> > > +
> > > +			if (i >= TYPEC_ORIENTATION_REVERSE)
> > > +				/* Property value is invalid, ignore property */
> > > +				goto usb3_mapping_done;
> > > +
> > > +			usb3_orientation = i;
> > > +		}
> > > +
> > > +usb3_mapping_done:
> > > +		of_node_put(usb3_ep);
> > > +
> > > +		if (dp_ep) {
> > > +			ret = of_property_count_u32_elems(dp_ep, "data-lanes");
> > > +			if (ret == -EINVAL)
> > > +				/* Property isn't here, ignore property */
> > > +				goto dp_mapping_done;
> > > +			if (ret < 0)
> > > +				goto err_node_put;
> > > +
> > > +			count = ret;
> > > +			if (count != 2 && count != 4)
> > > +				/* Property size is invalid, ignore property */
> > > +				goto dp_mapping_done;
> > > +
> > > +			ret = of_property_read_u32_array(dp_ep, "data-lanes", data_lanes, count);
> > > +
> > > +			if (ret)
> > > +				goto err_node_put;
> > > +
> > > +			for (i = TYPEC_ORIENTATION_NORMAL; i <= TYPEC_ORIENTATION_REVERSE; i++) {
> > > +				switch (count) {
> > > +				case 2:
> > > +					ret = memcmp(data_lanes, dp_2_data_lanes_mapping[i],
> > > +						      sizeof(u32) * count);
> > > +					break;
> > > +				case 4:
> > > +					ret = memcmp(data_lanes, dp_4_data_lanes_mapping[i],
> > > +						     sizeof(u32) * count);
> > > +					break;
> > > +				}
> > > +
> > > +				if (!ret)
> > > +					break;
> > > +			}
> > > +
> > > +			if (i >= TYPEC_ORIENTATION_REVERSE)
> > > +				/* Property value is invalid, ignore property */
> > > +				goto dp_mapping_done;
> > > +
> > > +			dp_orientation = i;
> > > +		}
> > > +
> > > +dp_mapping_done:
> > > +		of_node_put(dp_ep);
> > > +
> > > +		if (dp_orientation == TYPEC_ORIENTATION_NONE &&
> > > +		    usb3_orientation != TYPEC_ORIENTATION_NONE) {
> > > +			qmp->qmpphy_mode = QMPPHY_MODE_USB3_ONLY;
> > > +			qmp->orientation = usb3_orientation;
> > > +		} else if (usb3_orientation == TYPEC_ORIENTATION_NONE &&
> > > +			 dp_orientation != TYPEC_ORIENTATION_NONE) {
> > > +			qmp->qmpphy_mode = QMPPHY_MODE_DP_ONLY;
> > > +			qmp->orientation = dp_orientation;
> > > +		} else if (dp_orientation != TYPEC_ORIENTATION_NONE &&
> > > +			 dp_orientation == usb3_orientation) {
> > > +			qmp->qmpphy_mode = QMPPHY_MODE_USB3DP;
> > > +			qmp->orientation = dp_orientation;
> > > +		} else {
> > > +			dev_warn(dev, "unable to determine orientation & mode from data-lanes");
> > > +		}
> > > +	}
> > >   	ret = drm_aux_bridge_register(dev);
> > >   	if (ret)
> > > @@ -4189,11 +4310,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
> > >   	if (ret)
> > >   		goto err_node_put;
> > > -	/*
> > > -	 * The hw default is USB3_ONLY, but USB3+DP mode lets us more easily
> > > -	 * check both sub-blocks' init tables for blunders at probe time.
> > > -	 */
> > > -	qmp->qmpphy_mode = QMPPHY_MODE_USB3DP;
> > >   	qmp->usb_phy = devm_phy_create(dev, usb_np, &qmp_combo_usb_phy_ops);
> > >   	if (IS_ERR(qmp->usb_phy)) {
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> 

-- 
With best wishes
Dmitry

