Return-Path: <linux-kernel+bounces-728331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00377B026DC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4AEF1C28757
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 22:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A788A214A93;
	Fri, 11 Jul 2025 22:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4KYdcP8"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B20119995E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 22:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752272247; cv=none; b=AwOm5emvxNG8nVsA89QmwzetbJ6uqtn8wVO8bcLBy2bz5v8a8FJYrFZTveqQ8NiKpfEGveyBJhEYSTQ8IldsVxYIVQ8rqGRfi5rpW0MfFaGmbYEqy2edqU+L8PJMaPecNclO33RGdIJLHnBh9qJD7RmS2E3gfD74QThmJ89MJAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752272247; c=relaxed/simple;
	bh=f8r1uDskVX2XU8WLgXIg5I9dvA2+Qs7lFGJo7FLMuYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQfaOy0pb5T1p476k4mBxqsS/Zm9TU2O1VX3wOoJBl9Z4X8UADdyUUwr9ZZpWVoO1B3LsmYBpVmVCUltdAVU+V/+yViuxVi/c88OeOLj3iW76jcl/XrjENylm2c9UGE4WpS7G2dP9X215tY/1UZNXp2K+whOHbJHdI3nR1AHPhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4KYdcP8; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fd0a7d3949so36058606d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752272244; x=1752877044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QH4CLJHx8lz7tDS8sT5BrXfuy7SNXIyQ/0S6kOhEuU=;
        b=Y4KYdcP8bqyvXf/5KHkCEQw/teLly8hoSzed3JWdz4FFXiXjmLTWjkUzqvqZcHsVD1
         xz76XsUDUBrQHEGd5x2Ms8vvT4Xc4zwOUiRXqQhU8o5hfpSeDEwM2KG1PNZjTbmWmWWM
         GMbJnaFDWs5jSoYFnMP/y5hAkqD4CDp1wirmFzaFQQOcUvrA8S4GKbS/WPa5I5ii25J4
         JOYB5aKEiNm2EYu7EOgA2Xol17A2HBn9jyJ/UoAOJrbI1jCRuUg7+3ddTwXTtYLfEVSq
         ipArAWRYi3OAkYKx00T53v2mwyiFZCU45C/jCVwdNnln9JZIn0gJRxkaZoFXKf+k7C8Q
         J58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752272244; x=1752877044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QH4CLJHx8lz7tDS8sT5BrXfuy7SNXIyQ/0S6kOhEuU=;
        b=pPoVoqTg7vxCXRci/SnF4QAbJ5uy33B9WgdHDvSlOREbMjehQGbDUpqykFBnhgTlNo
         EEqBstCN49TFFAocYVnumu67ry5P9LOzX2X9tRsxdmV3KPVmkdDDEEVC+dBBrU9EZnQa
         H6eFgc3GGpk5Gf3915jNhv8w8vmJIpWsjSQe7mM84dsYPl7lE66M3AkHG43uCihv8ydC
         kLMi0GASpFi44FI6eulWeIwQR8/S+OPEUtdSPDz3fGxAud/h8e6meWIF5IZB1yXHc6Nl
         GL4DndUH1VTHU+yCsb3HSDJ4EpPlWmBmNYgqGlS4MuSq9/2TcGVhCCbfSVd0tLJU0TwD
         570g==
X-Forwarded-Encrypted: i=1; AJvYcCWUxdcz8MmQrDTHKVKUmswv/axWMabvjg6d6um9o3HRYTsfUtf+OOSxcZeTeIoufX4WlXPFh0vqoCSFLC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ct0T2Hhrf11N00LuYmKoWY/hE3Drloy8up6z/nL2v5oKmPIY
	CRgUhA1rDP01xTtRyB/2NYy+Q46l0TqfXQR+KlePSfoKHK6U3zbBnmys
X-Gm-Gg: ASbGncuZ3OqzNWwaYsy90Zc1LnlI52v68MmDrHbIqOB37hQC/LrzAzgja5UaSlpBd5a
	72XEjKC4/yshwSfgMILnUdBC1rU6UCEcr7jWqvs028OQS8wm9OnrCREb8rq5S2lzf0Yx0QPxpm+
	kpKIWcy8/SWHUceIh7mgNHQi/f85XZ6eQ4+RRj5MI5lfHnlJZccpKIYGXYjEKtZGX3iP2toN1Cc
	Wkkpi91ZIYFh60yt0dRMx8DWigmTnXiSxioVXbVB9hjphOvd12hqRKPSUH+Qwjx2YYATcDDcvPe
	T06m4sLqtryZBmV9CVRDZr69QZD9jBYUm+HV9h/1KCyFC7Mo9tx0TilWUA5GXWgjSTtDF2/p+9y
	VGpRpjwcjf2yo0jfQb73SgxJ0cXOhDm99dv+HU2N09CVPPvTtZ2t4PRAQabrkmBIB2EXJHA30Rl
	8uh2tNbMn2p20rAKTJFhXrzeY=
X-Google-Smtp-Source: AGHT+IGS3YuKWguiX02Ku1JRct4N9duKnnLTageeEMBStn6gM+QAzUO592LU2xY8HAEUr2rVukv9rg==
X-Received: by 2002:a05:6214:4a09:b0:702:daca:9049 with SMTP id 6a1803df08f44-704a32b03e3mr85626756d6.7.1752272243991;
        Fri, 11 Jul 2025 15:17:23 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcde8fa92dsm263728885a.91.2025.07.11.15.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 15:17:23 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 26E38F40067;
	Fri, 11 Jul 2025 18:17:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 11 Jul 2025 18:17:23 -0400
X-ME-Sender: <xms:c41xaEuS6j7-2NH5vpK8WBSwHSnbz4NNWxzKQ1phyxacJskI1TBleg>
    <xme:c41xaGo6sphl3AmwTb1EE--cNeRuTcAfPJ356YvYnFkxA9TUzQxgCLyeYyJY0U7ZT
    fbpJpRLgoxFxBZS0g>
X-ME-Received: <xmr:c41xaAoZzsrHvrYo14S1hAf3Ih60b9_7uifZFtSo5Ev3R0rRmYF8ec8NWkBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeggeeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehllhhonhhgsehrvgguhhgrthdrtghomhdprhgtphhtthhopehrrghngihirghokh
    griheivdejseduieefrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggv
    rggurdhorhhgpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpth
    htohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghnrdigihgroh
    hkrghiseiithgvrdgtohhmrdgtnhdprhgtphhtthhopegsohhquhhnsehfihigmhgvrdhn
    rghmvg
X-ME-Proxy: <xmx:c41xaNb1OsjaMiUcSuflw5irz2TSjORA-xJuWIEFvKocitdd4LZYig>
    <xmx:c41xaG_Q9KHN2cXuMM7upGlAmh9dDQHawNoFnrgeL_SjtoIMgqOpRw>
    <xmx:c41xaDlO8tdl8nbCG46JMdCf9V0DcjXewfCEhoFQ2gSVN-h3d9hgbg>
    <xmx:c41xaLw5izzp_yODrXL1mUqdx1xPNJ4_JoD2Yk47ry7ZGTnLpxx1nQ>
    <xmx:c41xaN6s9p-rHx8ZH4j8dbF8T8BBwrpDexb4ZDww8CT4bXsHTpkwwZp2>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 18:17:22 -0400 (EDT)
Date: Fri, 11 Jul 2025 15:17:21 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Waiman Long <llong@redhat.com>
Cc: ranxiaokai627@163.com, peterz@infradead.org, mingo@redhat.com,
	will@kernel.org, linux-kernel@vger.kernel.org,
	ran.xiaokai@zte.com.cn
Subject: Re: [PATCH] locking/mutex: remove redundant ifdef
Message-ID: <aHGNcZe-gwO53QFF@tardis-2.local>
References: <20250704015218.359754-1-ranxiaokai627@163.com>
 <6a687f94-770b-4fa8-83be-978007e902b6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a687f94-770b-4fa8-83be-978007e902b6@redhat.com>

On Fri, Jul 04, 2025 at 09:57:35AM -0400, Waiman Long wrote:
> 
> On 7/3/25 9:52 PM, ranxiaokai627@163.com wrote:
> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > 
> > hung_task_set/clear_blocker() is already guarded by
> > CONFIG_DETECT_HUNG_TASK_BLOCKER in hung_task.h, So remove
> > the redudant check of #ifdef.
> > 
> > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>

Queued for v6.17, thanks!

Regards,
Boqun

> > ---
> >   kernel/locking/mutex.c | 4 ----
> >   1 file changed, 4 deletions(-)
> > 
> > diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> > index a39ecccbd106..d4210dc97b6a 100644
> > --- a/kernel/locking/mutex.c
> > +++ b/kernel/locking/mutex.c
> > @@ -191,9 +191,7 @@ static void
> >   __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
> >   		   struct list_head *list)
> >   {
> > -#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> >   	hung_task_set_blocker(lock, BLOCKER_TYPE_MUTEX);
> > -#endif
> >   	debug_mutex_add_waiter(lock, waiter, current);
> >   	list_add_tail(&waiter->list, list);
> > @@ -209,9 +207,7 @@ __mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter)
> >   		__mutex_clear_flag(lock, MUTEX_FLAGS);
> >   	debug_mutex_remove_waiter(lock, waiter, current);
> > -#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> >   	hung_task_clear_blocker();
> > -#endif
> >   }
> >   /*
> Acked-by: Waiman Long <longman@redhat.com>
> 

