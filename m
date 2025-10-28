Return-Path: <linux-kernel+bounces-873183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4B5C13505
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8CA9507F01
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337EF238D54;
	Tue, 28 Oct 2025 07:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFLhdjLi"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD441B425C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761636730; cv=none; b=pEki2laoNaAGlGZcjGBUvEnqgYTXZFOtJqepNNpr7M58preHykbOPJapSozWVGueM7gJG77QqfRxnZzi/hKwbRoybIi60jfnJn4uCL5AqibzW5Rq3g9EDA+myWpmUW6niKindCW+jW9bqFTg8KbckYXfknWBRmBIU+fmbj8g8cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761636730; c=relaxed/simple;
	bh=5BQ/aCITCOxxpQZMc8iMrEbP3kxbbmeZ8y2tOTCPGV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q60v7euCYl6INtHtkUgqpE2m4eEZpnfM3XfSz0lbhLBpkt5Mxwe83vtz4H5tf5gVf1Wq/4FSIVwrPa7rnuYxF1LMBdHtEz/NmfV6G8C0R0Umzoi2EmH5M3hKelBP0R+Vt+dam4eQoRCJw7f6u2MofGESmregU4LEjt/6u67ux/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFLhdjLi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4710683a644so46655615e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761636727; x=1762241527; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rec9/cQDeU0bv1R0dhkpzftWDI1wklVhjatSRo1mvhc=;
        b=AFLhdjLi6dd0gsihRiZu+1M9h9qMxeVAo2d4xGMJgFEulbc9GuWRCKUp3l8s1ev8FY
         eYwThMxH4BWsZ+aL1ZI6SwnVpuRfdhtX7MIKiUIgTrYHDNXZmazoMBU9vw7MBvx8zHp4
         wJzq/9vB/n2Y24GcAFSRvmklc9D4R0/6+fno3vLnslFK7gCAbDEjfYHmIGWnZKrieBRz
         vUIY6s0dJt6yEXFw5l7kI97AT4aW0ZslMNn2FiAlV4xWhhF8lBCeTBTU9e0oLp4gasYM
         TePsQm3zE47BQyYnt3I+hGs+qAAXaiPN8zduSallywg2b1Y0BpHS8HxZflFPMZrKrpj7
         INlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761636727; x=1762241527;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rec9/cQDeU0bv1R0dhkpzftWDI1wklVhjatSRo1mvhc=;
        b=wNWtQ5UHgSohALdthI1jUrWRU56QlCF3lucdXZ8P401QdUNE2M/2vvFb8Xmpf31tiF
         W5vS44NntBDTaTQ8PUix6qOAacEAfzDU31XXNKCAJL0Ccf2VqWlPnkBj4zW9MLTkgO5U
         XWancAGB9oyrBxrR3ACw8vzZPwxNKVAU8TTz7IaQQnnTIsy+dApaKTcfH48xVaSSgMtw
         vkH7ItUTTYSffvr5YRf2QxZvKp0Egp50md7l5sYhmLxAKCatSx8LSgnEDu/k3MhScWrn
         JLzIM1qJZVeP1s1/ssOTVeIG/pkdu8kOtOW7YfKTO3AScvyFsRu9Cf6tYg1nuQzx1WVo
         EzMw==
X-Forwarded-Encrypted: i=1; AJvYcCWvL30m9Fh9BF14EIee6Hx0GlNKaz1aSyyQZO9GINZuptl+bnhUpz3+vZgshkYsn5BfyhD/PiL4Ye1aEBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhk3v238iXXtqiHP7Gyy4Ggp38kgSHj5GvARoZLu6SfAyQzQER
	FTMwZleDgwW/anRYr2RScMzElMzOyPumySU/wD90W/fXLwGCyqWMcJJw
X-Gm-Gg: ASbGncsRao1XACZhwZWtc7Al//RTPb5QS9YoIHlLO5SICEuCg3tsW1YmCTQPl6/yEKI
	5LvHfpusC2ZNlpMPhj96n63h1uTBs4h07Vnprgl0LBbvKvDGWF5Fm2FO9JAabYU6PVMxjiL+NuY
	G/zzbCEI2f6FWCiZ8Zyj/yAHV5EHwLRvHo8TwM3B58ZUN+dKGalLNt9+IE/n/Nnzd4SAWlH0s0W
	7sNch96/DmQmpnscIDW4wu6Rb4fmKKt4FiFiJkNwhsQwGmIBOK43WXnm1Uwfs3X41XM7t93mwbQ
	W21XG38kXlupeREkcSKoKXgT0Zl7JVi18LxDWMjUMYd/VKefs77t4rqU/AcR4XMF1JNu84xhIpE
	pnxm+7tO9ikdBPzVTFRboYklc5U3KtLvhxbksnRVKsKiMIawgHz8274ZVajKicquPz3q3TK4qug
	==
X-Google-Smtp-Source: AGHT+IG6/c3drKV+IIodLHpHQ4Y5FD1JlAXAJn9PKk468TlNJ3au9RHLKL3a3nf0xh+QjRg2jA6R7A==
X-Received: by 2002:a05:600c:46d3:b0:45f:29eb:2148 with SMTP id 5b1f17b1804b1-4771a46941fmr9387545e9.7.1761636726410;
        Tue, 28 Oct 2025 00:32:06 -0700 (PDT)
Received: from fedora ([94.73.38.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd48a07dsm179254745e9.17.2025.10.28.00.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 00:32:06 -0700 (PDT)
Date: Tue, 28 Oct 2025 08:32:04 +0100
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Melissa Wen <melissa.srw@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	victoria@system76.com, sebastian.wick@redhat.com,
	thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 00/22] VKMS: Introduce multiple configFS attributes
Message-ID: <aQBxdDzFkR9CYpSN@fedora>
References: <20251018-vkms-all-config-v1-0-a7760755d92d@bootlin.com>
 <aP-OLNFQA0M16xuy@fedora>
 <0dac7c85-0b44-4a6c-b1e1-5833649e6413@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0dac7c85-0b44-4a6c-b1e1-5833649e6413@bootlin.com>

On Mon, Oct 27, 2025 at 04:53:03PM +0100, Louis Chauvet wrote:
> 
> 
> Le 27/10/2025 à 16:22, José Expósito a écrit :
> > Hey Louis,
> > 
> > On Sat, Oct 18, 2025 at 04:01:00AM +0200, Louis Chauvet wrote:
> > > VKMS have a wide range of options. The aim of this series is to introduce
> > > many configfs attribute so VKMS can be used to test a wide range of
> > > configurations.
> > > 
> > > This series depends on [1] that should be applied soon.
> > > 
> > > PATCH 1-13 are for configuring planes
> > > - name
> > > - rotation
> > > - color encoding
> > > - color range
> > > - plane formats
> > > - zpos
> > > PATCH 14-19 are for configuring the connector
> > > - type
> > > - supported colorspace
> > > - edid
> > > PATCH 20-22 are to enable dynamic connectors
> > > 
> > > [1]:https://lore.kernel.org/all/20251016175618.10051-1-jose.exposito89@gmail.com
> > > 
> > > PS: Each pair of config/configfs patch are independant. I could
> > > technically create ≈10 different series, but there will be a lot of
> > > (trivial) conflicts between them. I will be happy to reordoer, split and
> > > partially apply this series to help the review process.
> > 
> > I just finished reviewing the series.
> 
> Thanks a lot, I started to apply your suggestions (I agree to most of them).
> 
> > Amazing work, thanks a lot for adding all of these new properties!!
> > 
> > I'd like to see KUnit and IGT coverage to test coner cases and, since this
> > is uAPI, to have a mechanishm to catch regressions without lots of manual
> > testing.
> 
> I started to add some Kunits for vkms_config.c, for the format parsing too.
> 
> > Let's talk so we can start working on them on v2, I'll be able to help in
> > that front if needed.
> 
> I finish to apply your suggestions and I will send the v2 soon, so we can
> discuss on the same ground. I think we can add a little bit of vkms_config.c
> testing, but for vkms_configfs I need to see if we can mock configfs
> interations from kunit tests.

For vkms_configfs I find more convinient IGT than mocking in KUnit.
It saves maintaining a bunch of mocking code and it is a good way to
test end-to-end VKMS.

Jose

> Have a nice week,
> Louis Chauvet
> 
> > Best wishes,
> > Jose
> > > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > ---
> > > Louis Chauvet (22):
> > >        drm/vkms: Introduce config for plane name
> > >        drm/vkms: Introduce configfs for plane name
> > >        drm/vkms: Introduce config for plane rotation
> > >        drm/vkms: Introduce configfs for plane rotation
> > >        drm/vkms: Introduce config for plane color encoding
> > >        drm/vkms: Introduce configfs for plane color encoding
> > >        drm/vkms: Introduce config for plane color range
> > >        drm/vkms: Introduce configfs for plane color range
> > >        drm/vkms: Introduce config for plane format
> > >        drm/vkms: Introduce configfs for plane format
> > >        drm/vkms: Properly render plane using their zpos
> > >        drm/vkms: Introduce config for plane zpos property
> > >        drm/vkms: Introduce configfs for plane zpos property
> > >        drm/vkms: Introduce config for connector type
> > >        drm/vkms: Introduce configfs for connector type
> > >        drm/vkms: Introduce config for connector supported colorspace
> > >        drm/vkms: Introduce configfs for connector supported colorspace
> > >        drm/vkms: Introduce config for connector EDID
> > >        drm/vkms: Introduce configfs for connector EDID
> > >        drm/vkms: Store the enabled/disabled status for connector
> > >        drm/vkms: Allow to hot-add connectors
> > >        drm/vkms: Allows the creation of connector at runtime
> > > 
> > >   Documentation/gpu/vkms.rst                    |  42 +-
> > >   drivers/gpu/drm/vkms/tests/vkms_config_test.c |  18 +
> > >   drivers/gpu/drm/vkms/vkms_config.c            | 183 ++++++
> > >   drivers/gpu/drm/vkms/vkms_config.h            | 524 +++++++++++++++
> > >   drivers/gpu/drm/vkms/vkms_configfs.c          | 893 +++++++++++++++++++++++++-
> > >   drivers/gpu/drm/vkms/vkms_connector.c         | 137 +++-
> > >   drivers/gpu/drm/vkms/vkms_connector.h         |  36 +-
> > >   drivers/gpu/drm/vkms/vkms_crtc.c              |  11 +-
> > >   drivers/gpu/drm/vkms/vkms_drv.h               |   6 +-
> > >   drivers/gpu/drm/vkms/vkms_output.c            |  19 +-
> > >   drivers/gpu/drm/vkms/vkms_plane.c             |  73 +--
> > >   11 files changed, 1865 insertions(+), 77 deletions(-)
> > > ---
> > > base-commit: b291e4f1a4951204ce858cd01801291d34962a33
> > > change-id: 20251017-vkms-all-config-bd0c2a01846f
> > > prerequisite-message-id: 20251016175618.10051-1-jose.exposito89@gmail.com
> > > prerequisite-patch-id: 74083a8806b1f26d9b4cd2a5107c756b971c4d11
> > > prerequisite-patch-id: f982390487699921b625b413e8460d67ca7a74c9
> > > prerequisite-patch-id: 0afca639e43c8fbfea2af1bc395e489efc8e1f10
> > > prerequisite-patch-id: 6285108b2fd90d30d15d4cb4fdddfef953fad51b
> > > prerequisite-patch-id: 2eacf5ad4f25f54a60958aa7a2df633d5642ce2f
> > > prerequisite-patch-id: 81e98ac3aeb3b6128098ab7bab56d3446a3a2705
> > > prerequisite-patch-id: 973f94c4edb4a5822c84a57d4479ca40e9cf25de
> > > prerequisite-patch-id: 0efbaf1b0e962a1c40bf5a744b5089d8be696f62
> > > prerequisite-patch-id: afa0cff94085e6ab216ffd9b99cd3dc882a0a687
> > > prerequisite-patch-id: 3561347f2b586392985a8e3af9ed1c5c7d3eefd5
> > > prerequisite-patch-id: 94030044ae8d404f7cdaed9137bddd59cfb22e79
> > > prerequisite-patch-id: a54b483797d5ffb7ce13b56a8943025181cd0d7a
> > > prerequisite-patch-id: f148fe7f445cb42437e7e2ba8b59e7e0fd40da8b
> > > prerequisite-patch-id: 1ef2045872843670c452816c5d6187b713c9258c
> > > prerequisite-patch-id: 3b9963ea3ae3455ae15ee36b67042c06a2ef6006
> > > prerequisite-patch-id: 519ee42dfabb4de734e41e59bd07d7a723d810bb
> > > 
> > > Best regards,
> > > -- 
> > > Louis Chauvet <louis.chauvet@bootlin.com>
> > > 
> 
> -- 
> --
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

