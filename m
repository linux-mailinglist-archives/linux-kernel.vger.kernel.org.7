Return-Path: <linux-kernel+bounces-836180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC1EBA8F17
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A42AF4E15E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104F52FF156;
	Mon, 29 Sep 2025 11:01:15 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B83623D7C8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759143674; cv=none; b=d4qeCPVbFlVJNREjh3F4ugM9QVtNxdnjAQ2QOMVAM7PBwNec/fCDhEZBR6YCaUzecIdviVht1ixZY5Gfk9BEtGCIw+S7/+W5eaoPlD5MOM6buOOtkBhAU4AWAoeNvcil8YdH8epfvcAd6oPRnnKIg6CbNK2nS68uv01qvBlElmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759143674; c=relaxed/simple;
	bh=8zGoap3wmWOZg2RP/KLQXm1WGMeACOMILEEFXlggVBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGb6RetNKVFbYFd/5Nwg+6tTmaC9HL2NIXkZw21B5Py/PmAQpoJ3bBUccBQIzafBry6P/BEbZTg7ibv4cm7/eHQFTb6IaUwcIKTwQHKdLXZdKLbnYeE6LP623ge8n/FFyU3W8iBBjXG8twrIurCwjCtqobXmFhDr7XfMpldr8m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201611.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202509291901072427;
        Mon, 29 Sep 2025 19:01:07 +0800
Received: from localhost.localdomain.com (10.94.6.25) by
 jtjnmail201611.home.langchao.com (10.100.2.11) with Microsoft SMTP Server id
 15.1.2507.58; Mon, 29 Sep 2025 19:01:01 +0800
From: Chu Guangqing <chuguangqing@inspur.com>
To: <tzimmermann@suse.de>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<dmitry.baryshkov@oss.qualcomm.com>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Chu
 Guangqing <chuguangqing@inspur.com>
Subject: Re: Re: [PATCH v7 1/1] [DRIVER] gpu: drm: add support for Yhgc ZX1000 soc chipset
Date: Mon, 29 Sep 2025 19:00:57 +0800
Message-ID: <20250929110057.8583-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <piavbxkdtlmlfhfphyvhsr7nixbt2o2aomkfuotm5fnkq6dmoz@injbfc224w2c>
References: <piavbxkdtlmlfhfphyvhsr7nixbt2o2aomkfuotm5fnkq6dmoz@injbfc224w2c>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025929190107fb5c8f3b9b7e753efb803cb2087b1a22
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Hi Dmitry,

> On Mon, Sep 29, 2025 at 02:31:03PM +0800, Chu Guangqing wrote:
> > add support for Yhgc BMC soc chipset
> 
> So... Again, what is Yhgc? Please expand your commit message, MAINTAINERS
> and Kconfig entries. (this is a usual thing: if you get a review question, it
> usually means that you need to provide more information _in_ the patch
> rather than just reporting on the mailing list). I'd suggest adding full company
> name and maybe a website as a comment inside the driver code. Otherwise it
> would be very hard to assess in few years whether it's something that is still in
> use, whether it needs improvements, etc.
>
This is a spelling error, it should be YHGCH. which has been corrected and is 
now in uppercase. The chip introduction has been added to the commit message, 
and the company's website has been included in the MAINTAINERS file and the 
source code.

The v8 patch:
 https://lore.kernel.org/all/20250929104831.8548-1-chuguangqing@inspur.com/
 
> >
> > Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> > ---
> >  MAINTAINERS                            |   5 +
> >  drivers/gpu/drm/Kconfig                |   2 +
> >  drivers/gpu/drm/Makefile               |   1 +
> >  drivers/gpu/drm/yhgch/Kconfig          |  11 +
> >  drivers/gpu/drm/yhgch/Makefile         |   4 +
> >  drivers/gpu/drm/yhgch/yhgch_drm_de.c   | 398

Best Regards,
Chu Guangqing

