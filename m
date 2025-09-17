Return-Path: <linux-kernel+bounces-821697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AC4B8201E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523E63A8BCE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D27530E0C5;
	Wed, 17 Sep 2025 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="K4PKrvBx";
	dkim=pass (2048-bit key) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.b="Ywanj2ff"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB9129ACEE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145358; cv=none; b=mj7b0ZPkHHdadvhmcohNHTPWA1/juw3Q7NGQitv1/Cm5hM9w1QlHZGKb7MFoKm6dGNdPx4+tvlhHCBejAFoieyNolmwpiwaJtesBrPeYykVHCOE13vB7jp/3p3Kfj5C0JO+9WVLs8C35mHT1E+WFMDfgOL/aekq4SL/nLLk1VkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145358; c=relaxed/simple;
	bh=x3uPm0xYDopT12eXOctOMhNA/7AZX0eI/ADHUbau0qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOFUORKSDvR9wSC0RbQgEemaC249QbmIefol4qbogDgCjhd3rKw3UJGNXU09HxqcVxjg8+jhce1eWwHQrxRLKzrrTNCpXl6Of922X/XzsRO+FA0wAe7CO+JGSk5lA8+OWTKawlmWdyqIEUwkl0zf4U+kwAVjctV1nGKBSNyRNLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=opensource.wdc.com; spf=pass smtp.mailfrom=opensource.wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=K4PKrvBx; dkim=pass (2048-bit key) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.b=Ywanj2ff; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=opensource.wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758145356; x=1789681356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x3uPm0xYDopT12eXOctOMhNA/7AZX0eI/ADHUbau0qM=;
  b=K4PKrvBxufdpnsED2D8bCZU2cFawBGEpSrs4ZjoYoDBPWKV2AV8Wo3+R
   Wc4CfxwioFBzzbNmyFJXdK9HiaAy2mBiw7oMWJ4OKCGrZEVIX2JVDMFM0
   mXOIedaQFVwnaaqBGmrem2RQA2TGerF60KbpInv9nUqpptWd7XPxAxkjN
   lAnmXgwZxRvxF5axDa1qzg/Re80qWGsZ4WRGla7AoJhj17M4JsYTAzTEU
   WO+OZMIJlPdjnPRFsWPGtHEgWl8hT1msMNCRGcHoVpTpdWoHlBv0eMW3z
   VKDLnGPsxp3yUjU9+3Sq+Jb7G5Wq+1W3YZOwPYlJNTelSi/U3XOJtM+M8
   A==;
X-CSE-ConnectionGUID: Y3PjLcbcRdOIF54W8GwFbQ==
X-CSE-MsgGUID: 78sThphvQAedmIGM43VuTw==
X-IronPort-AV: E=Sophos;i="6.18,273,1751212800"; 
   d="scan'208";a="122921592"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2025 05:42:30 +0800
IronPort-SDR: 68cb2b46_4gcJJy9jfY5UBzWMvkDFvMcSRsjTo3IZSyfSwUezl6x0lx9
 ucGuW69MJJEmHMbGO7YqMkoTkYPHphBN4ODb3AQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2025 14:42:30 -0700
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2025 14:42:30 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4cRsgT5MpCz1SHvj
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:42:29 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=in-reply-to:content-disposition
	:content-type:mime-version:references:message-id:subject:to:from
	:date; s=dkim; t=1758145349; x=1760737350; bh=x3uPm0xYDopT12eXOc
	tOMhNA/7AZX0eI/ADHUbau0qM=; b=Ywanj2ffby068BMfzTQBw0cfLVzudeZtQX
	hJRpKTxAjQcvgorsucp+M7wgqcZbQqP145E97i+J3EjQtNxsOPcfQVvdmmkZuKOl
	vUSBndAcgYhROaM22rE+t8vHJM2BOyHLCWXpe3Zu8Ief1790BRw1OHudZvn+J9g4
	0O8sKyE7fk142QNkyNDEWqolOHACe1X5AvAsDQ6HMjyA2nqkJoojkDgi0OL82Ye6
	BcTToxW6zvYCxlvZ0qPAhxklhuzDLL90LzavCTanQ53wTpiy6DJemfoRr/JZKdhM
	HjIVQ0sJkowwyd1pBfxRhKKekbUg2yzBGPEmPc8zxQ0vIBffyPYQ==
X-Virus-Scanned: amavis at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Elo0vSAxxXdq for <linux-kernel@vger.kernel.org>;
 Wed, 17 Sep 2025 14:42:29 -0700 (PDT)
Received: from opensource.wdc.com (ros-3.wdc.com [10.23.145.79])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4cRsgS3S2Rz1SHkR;
	Wed, 17 Sep 2025 14:42:28 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:42:27 -0700
From: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
To: Hannes Reinecke <hare@suse.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	cassel@kernel.org, dlemoal@kernel.org, kamaljit.singh1@wdc.com
Subject: Re: [PATCH v2 1/2] nvme-core: add method to check for an I/O
 controller
Message-ID: <aMsrQzOukUXB0TZ7@opensource.wdc.com>
References: <20250905232550.1950307-1-kamaljit.singh@opensource.wdc.com>
 <20250905232550.1950307-2-kamaljit.singh@opensource.wdc.com>
 <d1db6858-75e7-4853-a5e8-d0f1f02fb389@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1db6858-75e7-4853-a5e8-d0f1f02fb389@suse.de>

On Mon, Sep 08, 2025 at 02:56:35PM +0200, Hannes Reinecke wrote:
> On 9/6/25 01:25, Kamaljit Singh wrote:
> > Add nvme_is_io_ctrl() to check if the controller is of type I/O
> > controller. Uses negative logic by excluding an administrative
> > controller and a discovery controller.
> > 
> > Signed-off-by: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
> > ---
> >   drivers/nvme/host/core.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
Please review and provide any feedback on these 2 patches.

Thanks,
Kamaljit Singh

