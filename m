Return-Path: <linux-kernel+bounces-763735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA42B21987
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 01:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0B43AFAE4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 23:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4492225762;
	Mon, 11 Aug 2025 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="F88HrC8q"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BE615990C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 23:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754956092; cv=none; b=XdFSpaNx+2Nfghn46ILgWrGs+CP8QQ45mQJ4msoUvwvg0fWdaRBY6Du7fd7dPUny7SsfspmVkA1HOLEbAFnChT/hOkREuZ62q8MR+9E/YrOgCDRRoRwdufGiIU8Rb3a/GOVHtVaX0QwAfLld1W/1gt7WkvJK+0kubLT4HLfk9ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754956092; c=relaxed/simple;
	bh=QHdGsbsGsMTF9ct+jFXXWmU25H4aBw6ecPoHa7EZZqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGfKvTN5eFFiiWZ22veI3i/MkePLYPFZ/6RJt/pvb6oCU5rlky9FfYj7oJhKVVKDFlZwNVjdZ2xp6urNQxWIR1hlsEFyzV9ueG/49wMjf+/uvEHQ/x8QEsJNGp0ij8+L/+1+Xs2IhgR8zaJLXJt1nQb7ZPOStu6x1otYgCIYYtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=F88HrC8q; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b271f3ae786so3989587a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754956090; x=1755560890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4XRSLXmEMw0woCxwm1Fun/oPeKwzB3yukJjNW3UI7g=;
        b=F88HrC8qUdQrxXC3tvFj9XjWPrV3p0qekcsK1I5otUb1UHxHK3AoN7Em0+ZGXxgbUz
         36mPhdmB/m0zJivW2oGuzfyuxs9+28QdHS5tL3gr7A3Wph+rArow2Vmlh1rwaxGhnWAN
         M60XkxpV8xjRHT9xh/g2jvYDHC/wvTEx2Y/d5rWLsAS+CHudi9L3ud3bLCD6TPsBO97W
         RP3LF3pxP57MRbbl/Lq4aE3FpkwF7C18g51OJ5wzr3gs71zNMsr/43ioYViVmIkkhx4c
         AKEiYUyaoB1GWf+IcbywFys3y8IZYZfdcHbj0dRSyMNXz0T2E8DrNcf6QeCwL5wU6Tfw
         NinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754956090; x=1755560890;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U4XRSLXmEMw0woCxwm1Fun/oPeKwzB3yukJjNW3UI7g=;
        b=e0DeINXC4EiKfjZ7PNLcqCwocdPVveCvccmJ4zZbAVmiFWP0BgTkt+F2S8YmY7Hve/
         oCWHED4S7fc3WMu0rRRnz5TvBl3AxKm00WqxbLeY7KOIfj9cufPe+XsytjH9dMBQL542
         RQoJmWKUcrcECA0To6/bP/ZLCvrQ42tli/lXKfsucLZD6hd6YhwsX1RiiMbOeGRjiU7L
         xhHJKjX0saCWJTY5VweI2TN2y5R44zkTRhjN+5qLk3SBRpKzSjZvVn7PgVzdXRviO6NG
         rRAlXO+o24a5HGCQP5JulSA2qBrA7LhyH8Cs7am7tDKjK+ZtoVDCyklYDLFNLqC0JjoU
         EEiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHP+Y88L2XpighcJ9COUdvjP1cgRdGOzo9c8YPtowaVLYW0BNmfICczbrMeAU47uXhxyuUHVkL7nkFOIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0U74SKK03i89C3EcbSXYJio/e4xjbezsT0Vy34eJ4Jd9wxZfY
	xMGKAT5B3yY5IlIIzTmxOg0fh3wKDXCxLO0uAKLVny55BRNMf427SMf4moiY2KLjL1E=
X-Gm-Gg: ASbGncslhzAq9TZcBqIaTB9wGtB3p20KM1c+R5EDBsBT+x29PbII1U7lppw8pc3c9i1
	Bvw278j8yWehBeBMCTCscNLm4o1w0zQfWM3kxES2oWZqmmtYhFFsjfUGJ+OJKiLxlwIhaO2lMsI
	eTcVHp5Ox68iaC+TJ+Qh0jBm4GHw2T9W8Cl/Sxl8B/9AYEUSbnZKOHH9U7YjzKGGI/08rphpaB+
	8zdP+lbiRxjC8JONYcb33kM1/wsfWkPzIt6xEAhZf5lgSV+/efmqgIY1zbCzSR9Rpxbr7RaRTcA
	gz9YWl4axZCWRshxYSvid8axb9zxYOb9z+c/TpPzh3YHHy6FZWsbMJPc+qvJaA/KriFdRRhoctY
	kjIRRV7IdQiGrLlgfJkKV2bo2Dci5Uf3sZOUvw/HBhBqvoHU03yjrWwM3RMjxH5RQxlo=
X-Google-Smtp-Source: AGHT+IG07aJWSFz0EKwHxV+0m672OZTjD+dXJRBt0J7U3ZDXaKrxKPz/mMfIbtp585GM0LtN28ugxQ==
X-Received: by 2002:a17:903:1ae6:b0:240:981d:a4f5 with SMTP id d9443c01a7336-242fc357fc0mr20275505ad.42.1754956090207;
        Mon, 11 Aug 2025 16:48:10 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2423783a84bsm252085905ad.51.2025.08.11.16.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 16:48:09 -0700 (PDT)
Date: Mon, 11 Aug 2025 16:48:07 -0700
From: Joe Damato <joe@dama.to>
To: Tianyu Xu <xtydtc@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, kuba@kernel.org, sdf@fomichev.me,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, tianyxu@cisco.com
Subject: Re: [PATCH] igb: Fix NULL pointer dereference in ethtool loopback
 test
Message-ID: <aJqBN0xtMzt_cA87@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>, Tianyu Xu <xtydtc@gmail.com>,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, kuba@kernel.org, sdf@fomichev.me,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, tianyxu@cisco.com
References: <20250811114153.25460-1-tianyxu@cisco.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811114153.25460-1-tianyxu@cisco.com>

On Mon, Aug 11, 2025 at 07:41:53PM +0800, Tianyu Xu wrote:
> The igb driver currently causes a NULL pointer dereference
> when executing the ethtool loopback test. This occurs because
> there is no associated q_vector for the test ring when it is
> set up, as interrupts are typically not added to the test rings.
> 
> Since commit 5ef44b3cb43b removed the napi_id assignment in
> __xdp_rxq_info_reg(), there is no longer a need to pass a napi_id.
> Therefore, simply use 0 as the final parameter.
> 
> Signed-off-by: Tianyu Xu <tianyxu@cisco.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index a9a7a94ae..453deb6d1 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4453,8 +4453,7 @@ int igb_setup_rx_resources(struct igb_ring *rx_ring)
>  	if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
>  		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
>  	res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev,
> -			       rx_ring->queue_index,
> -			       rx_ring->q_vector->napi.napi_id);
> +			       rx_ring->queue_index, 0);
>  	if (res < 0) {
>  		dev_err(dev, "Failed to register xdp_rxq index %u\n",
>  			rx_ring->queue_index);

This LGTM but will probably need to be re-sent with a Fixes tag.

See: https://www.kernel.org/doc/html/v6.16/process/maintainer-netdev.html#tl-dr

If you repost, feel free to add:

Reviewed-by: Joe Damato <joe@dama.to>

