Return-Path: <linux-kernel+bounces-889102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3FAC3CB3C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C1E8351F5F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7B234D906;
	Thu,  6 Nov 2025 17:06:09 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C970734D916
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448768; cv=none; b=sp8PV21AtxUUQgrUJQtJXIy441DRk/MZdzUtEXBvTCkD23+SvbVxfL8FnjH6l3eZfCzZdLWfbkIAgXchQWBkcaU6AIBFVkEi6yli2+Gr4aczkx8E7VfwVuZKVTbeazpKRKC7vG5A6fxhVTAP8B+lrSGtGrN9q7F/EfXUJ/Rwl0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448768; c=relaxed/simple;
	bh=u9XVqLZpaWPD6eBVLxWNFs4+riQ5k6PAyZ3Iq48h8Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jp0RNU7d/jlJbCVKMyhsWYEpCBih3tOvZNga3tsdPXlztqLGkYJXkeLn56ur82cg8r7FmQkxLgSPhfNg3Uk24FBElgI/sBwaI7XnyoNPhdvs82CfN0i8Uh4JbJ+/ZDmBDcBiNeCC8KS5Imm6nPIQRnInp0II/zzidJrAC25gd1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b5a8184144dso180404066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 09:06:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448765; x=1763053565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+WGVXXWVhyjyZGYUX+1y1Q+1FkWB5jkOhwquLJi9MY=;
        b=ZM6sL9OH3/MDxD+TJycH6VSzt4l0sp+p3X0pvXaigCM6hKJzDzivtW5w6GcM694hKj
         8ymRL0afSfih2rHcWNBzZYtrnSf2k3Sx4KK7DBMutmVk0GRV9qzp2Dt/ldf3UtAXsKuY
         wqMBBcoFB7Gswry9z+LC6qKcjObx0358sPU0UHyClXhEvFDe63A9nkMwBqQohN2AHA9i
         B5nH8IaLfcB2As1YjAJjPGrRWDYYbRxVBk/EZ5gH3FbVYO1V7oUq5+nhheyNeSPYQQCY
         Jl/s8xgf2Mdj2megfZVktdFtKsLN4fc39X+dV9G82TX+ywth9dSre/rwfvo13ELWBCFP
         CbNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU9qKNxIQR73zyEejJ1QgpqBY8rda6r8CnnElIFQ2RkZlajMigZnBFfKIkVyNm6cMdFlMt1hmcSU8u470=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+9bVX5P2bT5sTQi+Bm4lO2Q7sK9TSubeFH2nbqTNcmze80jQ0
	Xgzb1lUCHdHIMH3DPMs66p9fAMMIhm1yuiNBPitKV1G0iXIy4IIVc+LU
X-Gm-Gg: ASbGncvkLnnVI3Hu+4VdCsmhRPf3DGsxqtWNR3w5+5quYbGZcCyGs0VEteWBK3gIXd3
	AStTo0nCWZkE9l7x6iSJvFJyvcZEihPpdBjU1NHrl7W2ljWhwtPFMWD3Q4oMTQ5Vv96sqc4pUiu
	QLanX3L2OoThYycNIZSpxYqn5Z4AdDkCvTxzLOp+ttb7nU67SesKjB4i8eoh4zgumqP2fUXkiRS
	UhHeQYV862pvQU2MCBpLvBZqXZwoZCnpdM9Dfb05s8JcX5V/5ZBS18ng+Hpz6Q5vOI1XXSFCTGD
	MovZldbEg9U8uGG1L3H1+e/ouRRRm7GEw8HNbIg968LB0fv5KnLp7Ymbr/XK58b8Y9ZXQR+OEyx
	Chr67c1xcycbDS70mlvcClO0p5Bf+AfweKQQzKt+wH2XZDFre/uoJLMaQ11g5K+jtAqDBl6+6jR
	dT
X-Google-Smtp-Source: AGHT+IHFnIfbtm1ZjvxdkHLl9Wb1IGZm1PL96ngnoeuGIDRz5E+nh+lXTjs6tMmUTl6jXosCKcP1gw==
X-Received: by 2002:a17:907:7ea6:b0:b4f:e357:78f8 with SMTP id a640c23a62f3a-b726553b6b5mr760452766b.52.1762448764934;
        Thu, 06 Nov 2025 09:06:04 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf7231dcsm6058266b.31.2025.11.06.09.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 09:06:04 -0800 (PST)
Date: Thu, 6 Nov 2025 09:06:01 -0800
From: Breno Leitao <leitao@debian.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Michael Chan <mchan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next] tg3: extract GRXRINGS from .get_rxnfc
Message-ID: <4abcq7mgx5soziyo55cdrubbr44xrscuqp7gmr2lys5eilxfcs@u4gy5bsoxvrt>
References: <20251105-grxrings_v1-v1-1-54c2caafa1fd@debian.org>
 <CACKFLim7ruspmqvjr6bNRq5Z_XXVk3vVaLZOons7kMCzsEG23A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACKFLim7ruspmqvjr6bNRq5Z_XXVk3vVaLZOons7kMCzsEG23A@mail.gmail.com>

On Wed, Nov 05, 2025 at 11:05:34AM -0800, Michael Chan wrote:
> The existing code to use num_online_cpus() is actually not correct.
> This is more correct:
> 
> return min(netif_get_num_default_rss_queues(), tp->rxq_max);
> 
> I think when netif_get_num_default_rss_queues() was used to replace
> num_online_cpus(), tg3_get_rxnfc() was not properly converted.

I can resend the current patch with this additional patch:

Author: Breno Leitao <leitao@debian.org>
Date:   Thu Nov 6 08:05:49 2025 -0800

    tg3: Fix num of RX queues being reported by ethtool
    
    Using num_online_cpus() to report number of queues is actually not
    correct, as reported by Michael[1].
    
    netif_get_num_default_rss_queues() was used to replace num_online_cpus()
    in the past, but tg3 ethtool callbacks didn't get converted. Doing it
    now.
    
    Link: https://lore.kernel.org/all/CACKFLim7ruspmqvjr6bNRq5Z_XXVk3vVaLZOons7kMCzsEG23A@mail.gmail.com/#t [1]
    
    Signed-off-by: Breno Leitao <leitao@debian.org>
    Suggested-by: Michael Chan <michael.chan@broadcom.com>

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index fa58c3ffceb06..5fdaee7ef9d7a 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -12729,7 +12729,7 @@ static u32 tg3_get_rx_ring_count(struct net_device *dev)
 	if (netif_running(tp->dev))
 		return tp->rxq_cnt;
 
-	return min(num_online_cpus(), TG3_RSS_MAX_NUM_QS);
+	return min((u32) netif_get_num_default_rss_queues(), tp->rxq_max);
 }
 
 static u32 tg3_get_rxfh_indir_size(struct net_device *dev)

