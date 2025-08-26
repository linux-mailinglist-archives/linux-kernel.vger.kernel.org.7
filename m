Return-Path: <linux-kernel+bounces-786976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2BEB36FA4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3498D4617F5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264B131A555;
	Tue, 26 Aug 2025 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JbswCT6s"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA1721CA1C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224508; cv=none; b=nMXdo3LPEhGq6rDM+WBxi3TBoE+p8E7vgoI+7zioaZVt58iQuhjZt9Nw5mH8E03yuld0RYlN+VUSdKS7TRma8Ff17AyRBfjyv6OqQWtLi2QDdlOCahyUD+cHoYR8lFSPSZ/NC7gfg56hCE+5fT1lzCCWGwYrWzKuJh2R0iW9Rrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224508; c=relaxed/simple;
	bh=Zj4aRAtzQtL6NmqzveqZ79Oi/lxZMVcjdwtX+OHrmh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXGVs/qXUdG7/Tc4oDY//7JsQUADwc8xpkuGf3g9sLS2oFMqF2W65OxskjOaXIOWFvM9FbrmjrBCjMk77WIZT3cdy3/ijbljrko2vH7UunPaFj0N/6YUM7IkYco62Rz0m6HUQMvQO5c6MWvpHjWAUBC4LG+U9jC9uCs8AH5mnhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JbswCT6s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QBRTpg015247
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5Y6MH/IfjA1JcEnoDtSw8pJM
	2X/EunOT5oKJPorXhUE=; b=JbswCT6sjJBwB/oXRot1KzTm7NFqJUos8kr5i1CQ
	MP1A0cQ0WBCm2vDiljFK0hOwi19o+0cJpUQVlWAONGs8nOm7/NEe7wEfUuvyhydc
	CmhkC/SkW6VCegD9VGihV7/3wCI+YqYEZI5A1/Fx3TizavTs3DR0NGFBGFUhhTxl
	SnU65YAmgvZinrJ1lwsb93+k8Klg1GXt/QBvWkL4nZ9pJmbQFJHCg5jMMZS1tKnE
	KWpQSqL6k5pfdetx2H7bjnQOy4oeSH6onMkGAxSU27uvyINNG6CJd8IgdNd1kXyE
	Z/lqRkYgZuw4nptDVgV7LXFFAaNJJzX1TbIWhbep88YBhA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6x89jy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:08:25 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109affec8so136298161cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756224504; x=1756829304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Y6MH/IfjA1JcEnoDtSw8pJM2X/EunOT5oKJPorXhUE=;
        b=ohtzPYO0pAaPFr6XBMQ8tv6JmfAd4Ge9mFM3OmhRZ+oN8H1vvfT7LXFMVtkw1nP2Vc
         /yf9zuI12tsbpp4ZB9+Ud5Nzb3aH2U/pafEnpX0791+DQOurURhUU4QhisuDm+IMbcTE
         9/NRaxSmN4oDljJHIbMIq2+xsgDWceKfDIppPsD2eA55EyBd1DtpILa3xmzkpekxpliR
         ULB+ztpjZ3aoYDbdshKy2nCISVHjX+EUAa10kYoQuyI9HIBdNY+S7K0+6YAplfo1mn0v
         Byl9+9HvMOU22NN/E/TababymBbV5jYCPPnh2rjO7GQkkUei/eiHE2B1cooCmEpGCIIM
         saog==
X-Forwarded-Encrypted: i=1; AJvYcCXps8eLt1SiSHHRFT8e1Eaj1mwBkwFiYok/igRrXuXB0+iDAIER2Tb8p+OITP38bf6xAs6DbWNA358Teos=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMo/mUuzIoxsSdWDB3qj+j0D3BGOegWa4dO4fZHFuDsp0U3Tez
	zUIJ7/us+2ABKUzih2Nw80Gx6+nzR8MweGxQ2hvj80bnbmIh3kuUVgoTX2nXdQbz4xKrNPcRdtx
	NuubUp9EP9OYvnIaxsnjMyIx2lTJKqqbJOxFrmp5Vkph4rYOXaSaMzCENH+bpdo0WJxg=
X-Gm-Gg: ASbGncvx78JXwKYQEkiMQmpLHC/qVRZuEdSMSHRyCGeoSmLK/ajctkp53liJ/eANsb7
	p9BEp7NGkucGtS0og0NmcDSP51gQa6BNb/cyR4LcwUt/p/DdfL0vlxOTOBzs4XPXEmYDcXJSHk/
	/lmeBuSC+KXIyMB5ZoPng6VKOIHYFLRjEKsksZGOMVnw4AT9aPpKqsAd8lIFY6DpAtSKHwoJR9e
	UJIIKsjMde1XrxuKTFiPxxav/BEZ/tXlID7o4FAWlzizSEtJAVDdRezoIOmFHCHn2aN2eY+vYJV
	wYDypbuwNFkX6Er8dJ/oUkyiAJRxot++wYAP1knBFaQZfesZh2CKYQcWw6o+qxRaN+xa5NOGtSk
	mysVJLXfmQsJj/K/KKozqg4Sp0GVHCvMbTOLxtjDgRL1hq7cBM3qj
X-Received: by 2002:a05:622a:188e:b0:4b0:677d:d8e1 with SMTP id d75a77b69052e-4b2aaa055c4mr159229971cf.17.1756224504041;
        Tue, 26 Aug 2025 09:08:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw4XVvhS8sJ4oPyO5LSxRLiQgorFOHBMUJBTT8et5S5EVGydVwVkXldGpoHbR11UxUC58e2w==
X-Received: by 2002:a05:622a:188e:b0:4b0:677d:d8e1 with SMTP id d75a77b69052e-4b2aaa055c4mr159227761cf.17.1756224501655;
        Tue, 26 Aug 2025 09:08:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f45a230ddsm1241131e87.59.2025.08.26.09.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 09:08:20 -0700 (PDT)
Date: Tue, 26 Aug 2025 19:08:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "mripard@kernel.org" <mripard@kernel.org>
Cc: "Kandpal, Suraj" <suraj.kandpal@intel.com>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "kernel-list@raspberrypi.com" <kernel-list@raspberrypi.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>,
        "Murthy, Arun R" <arun.r.murthy@intel.com>,
        "Shankar, Uma" <uma.shankar@intel.com>,
        "Nikula, Jani" <jani.nikula@intel.com>,
        "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "siqueira@igalia.com" <siqueira@igalia.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "simona@ffwll.ch" <simona@ffwll.ch>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        "robin.clark@oss.qualcomm.com" <robin.clark@oss.qualcomm.com>,
        "abhinav.kumar@linux.dev" <abhinav.kumar@linux.dev>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "jessica.zhang@oss.qualcomm.com" <jessica.zhang@oss.qualcomm.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "marijn.suijten@somainline.org" <marijn.suijten@somainline.org>,
        "mcanal@igalia.com" <mcanal@igalia.com>,
        "dave.stevenson@raspberrypi.com" <dave.stevenson@raspberrypi.com>,
        "tomi.valkeinen+renesas@ideasonboard.com" <tomi.valkeinen+renesas@ideasonboard.com>,
        "kieran.bingham+renesas@ideasonboard.com" <kieran.bingham+renesas@ideasonboard.com>,
        "louis.chauvet@bootlin.com" <louis.chauvet@bootlin.com>
Subject: Re: [RFC PATCH 1/8] drm: writeback: Refactor drm_writeback_connector
 structure
Message-ID: <76cmo6pqa534cdnckfgsnspczenzt7kiwkpgg4olxysjn2can7@g5dxteqi5jjs>
References: <20250811094429.GE21313@pendragon.ideasonboard.com>
 <awtqznhquyn7etojonmjn7karznefsb7fdudawcjsj5g2bok3u@2iqcdviuiz2s>
 <20250811111546.GA30760@pendragon.ideasonboard.com>
 <2ah3pau7p7brgw7huoxznvej3djct76vgfwtc72n6uub7sjojd@zzaebjdcpdwf>
 <DM3PPF208195D8D0E55A761A3C16B87BAEEE32AA@DM3PPF208195D8D.namprd11.prod.outlook.com>
 <aJ4LQvqli36TlETu@e110455-lin.cambridge.arm.com>
 <hc6f6wgsnauh72cowocpm55tikejhiha5z4mgufeq7v6gb2qml@kmgfd26bigos>
 <wr76vyag2osox2xf7ducnkiaanzk2k5ehd2ahnoyqdm5qiywlk@penf4v5bvg5z>
 <DM3PPF208195D8D87AECE8397914A67D9A1E33EA@DM3PPF208195D8D.namprd11.prod.outlook.com>
 <20250826-skinny-dancing-otter-de9be4@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826-skinny-dancing-otter-de9be4@houat>
X-Proofpoint-ORIG-GUID: bPj-G6cZqr_e54PykutI_z-IK6myem5J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0NCBTYWx0ZWRfX4ZPlEzumOrZt
 JyGDYDCYUYYgS/+wabAnnqOlZa+a2GysBQMjo/G2c760yEhUzF15hGylJzf5ZxF6Ap6ftq8azDE
 ebjdgkKVV3yBUcwSeRQz3nKnePI4eGDBHmzAwsYcps+fC/IBsCm0rhv2nhiRFiZh9gOZ8fFGCTy
 IiOCZnO2Zm7NlpeWwEawLurxf2k37yJnPrS3INIyD/MGOOltPUYvz6DTckSkQi6NgwAOM/yqKKY
 hRBy+Rcy2gdc1Y5fkvIN0cJVr2IyUmrA7WTMyDr6RoqbxAq8IIAL3iL8Xt3u4fIyHKW8SmF6fC4
 glCqrVCU6kKZc2adzphhpfcF9SyU1pVNrKyzxaAbNZFOoDXDumIEZ40TcGGY3Khc1ObwUsQLvaI
 Y4ZFjoOU
X-Proofpoint-GUID: bPj-G6cZqr_e54PykutI_z-IK6myem5J
X-Authority-Analysis: v=2.4 cv=Ep/SrTcA c=1 sm=1 tr=0 ts=68addbfa cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=cj-Nge-_NgV5cCdd3SwA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230044

On Tue, Aug 26, 2025 at 05:48:18PM +0200, mripard@kernel.org wrote:
> On Mon, Aug 25, 2025 at 06:26:48AM +0000, Kandpal, Suraj wrote:
> > > Subject: Re: [RFC PATCH 1/8] drm: writeback: Refactor
> > > drm_writeback_connector structure
> > > 
> > > Hi,
> > > 
> > > On Sat, Aug 16, 2025 at 01:20:53AM +0300, Dmitry Baryshkov wrote:
> > > > On Thu, Aug 14, 2025 at 05:13:54PM +0100, liviu.dudau@arm.com wrote:
> > > > > Hi,
> > > > >
> > > > > On Wed, Aug 13, 2025 at 10:04:22AM +0000, Kandpal, Suraj wrote:
> > > > > > > > > };
> > > > > > > >
> > > > > > > > I still don't like that. This really doesn't belong here. If
> > > > > > > > anything, the drm_connector for writeback belongs to drm_crtc.
> > > > > > >
> > > > > > > Why? We already have generic HDMI field inside drm_connector. I
> > > > > > > am really hoping to be able to land DP parts next to it. In
> > > > > > > theory we can have a DVI- specific entry there (e.g. with the
> > > subconnector type).
> > > > > > > The idea is not to limit how the drivers subclass those structures.
> > > > > > >
> > > > > > > I don't see a good case why WB should deviate from that design.
> > > > > > >
> > > > > > > > If the issue is that some drivers need a custom drm_connector
> > > > > > > > subclass, then I'd rather turn the connector field of
> > > > > > > > drm_writeback_connector into a pointer.
> > > > > > >
> > > > > > > Having a pointer requires additional ops in order to get
> > > > > > > drm_connector from WB code and vice versa. Having
> > > > > > > drm_connector_wb inside drm_connector saves us from those ops
> > > (which don't manifest for any other kind of structure).
> > > > > > > Nor will it take any more space since union will reuse space
> > > > > > > already taken up by HDMI part.
> > > > > > >
> > > > > > > >
> > > > > >
> > > > > > Seems like this thread has died. We need to get a conclusion on the
> > > design.
> > > > > > Laurent do you have any issue with the design given Dmitry's
> > > > > > explanation as to why this Design is good for drm_writeback_connector.
> > > > >
> > > > > I'm with Laurent here. The idea for drm_connector (and a lot of drm
> > > > > structures) are to be used as base "classes" for extended
> > > > > structures. I don't know why HDMI connector ended up inside
> > > > > drm_connector as not all connectors have HDMI functionality, but that's a
> > > cleanup for another day.
> > > >
> > > > Maybe Maxime can better comment on it, but I think it was made exactly
> > > > for the purpose of not limiting the driver's design. For example, a
> > > > lot of drivers subclass drm_connector via drm_bridge_connector. If
> > > > struct drm_connector_hdmi was a wrapper around struct drm_connector,
> > > > then it would have been impossible to use HDMI helpers for bridge
> > > > drivers, while current design freely allows any driver to utilize
> > > > corresponding library code.
> > > 
> > > That's exactly why we ended up like this. With that design, we wouldn't have
> > > been able to "inherit" two connector "classes": bridge_connector is one,
> > > intel_connector another one.
> > > 
> > > See here for the rationale:
> > > https://lore.kernel.org/dri-devel/ZOTDKHxn2bOg+Xmg@phenom.ffwll.local/
> > > 
> > > I don't think the "but we'll bloat drm_connector" makes sense either.
> > > There's already a *lot* of things that aren't useful to every connector (fwnode,
> > > display_info, edid in general, scaling, vrr, etc.)
> > > 
> > > And it's not like we allocate more than a handful of them during a system's life.
> > 
> > So Are we okay with the approach mentioned here with the changes that have been proposed here like
> > Having drm_writeback_connector in union with drm_hdmi_connector
> 
> I don't think we need a union here. It artificially creates the same
> issue: we can't have two types for a connector if we do so.

Well... What kind of connector would be both HDMI and WriteBack? I think
they are mutually exclusive already.

> > Also one more thing I would like to clarify here is how everyone would
> > like the patches patches where each patch changes both the drm core
> > and all related drivers (ensures buildability but then review is tough
> > for each driver). Or patches where we have initial drm core changes
> > and then each patch does the all changes in a driver in its own
> > respective patch.
> 
> The latter should be preferred, but if you can't maintain bisectability
> that way, then it's the most important and you should fall back to the
> former.

I'd say, we should be trying our best in providing bisectability. It
really a PITA if one can not use `git bisect run`.

-- 
With best wishes
Dmitry

