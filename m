Return-Path: <linux-kernel+bounces-831900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B01BB9DD76
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CD91B233CC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE212E7193;
	Thu, 25 Sep 2025 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXhrS+Np"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D75B2BB13
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758784861; cv=none; b=iDiQM+YEB+9VFgC+JaVcEHVNibHMPd4S18/Yvbc8ERWF8qPtYxFNgpW+K1Oy8PHUvaxXmzFIxYu/P8cp77aFAjjKrErjQ6wlBtAOUJfRp8KAj29l0z6g4BnrYp1ILOKDoP8ZHXy18YRfDw/8FIqeJT6QU07DoTMzb0DdLOE05Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758784861; c=relaxed/simple;
	bh=jvyoCWMpgS5D9iwfX/HzulNvpEIivhHRZX6iVNM2pSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SemV0LPSaAncsFAP6LjIxtq7tiBOskaB+ZtEOxwARso4U8Ojl7F30hoPHp/le8cMArzt2gOAAyqCn3Jm1EwMulEQJp/ymEwNxuTlZwyiE4FGN3zE6nCXMbYGYa8o8U+doz51YBkSNyGQMS14YOZAxlKg5TpodgmPtm8QI/CZfFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXhrS+Np; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso452820f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758784858; x=1759389658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5GK9C8KtH9+DmOnUEwg3Z7jsK5ZGy4qBPWOBOcMNRJw=;
        b=VXhrS+NpDcrGky9yv6X4TvGd8qCVzJe9VqoFhw3LgVo03Eph9qY5D7Hp06PJD2pwbS
         eLVbRHZMgIWxfcbKQ9TL1wHNt1fcRFqWNaXYKmIRvqQw5BBxFbFyFL7dWfZlAa3gfn/L
         cEEInTbeKovSLTpcMpEoHY468bKjdxbtpltsBazte8p+Qt0Wa6jaPHvzmo4U6t0J9iB0
         EolQhM8QCelGbCgX1curvg7glQEQhQgJl9ieehSSiWfnHZLa5Iv6TMTDhATMaYei7tam
         0LETtm8DyTXEv6cyN5PqblPjTkF9KAslKxXdwNjSHrSetq+6qIKEL0k6bvnV3ef11fPx
         ZWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758784858; x=1759389658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GK9C8KtH9+DmOnUEwg3Z7jsK5ZGy4qBPWOBOcMNRJw=;
        b=hLbBwpDBZLY/QmUAyW/czlM1s+kQvlf1H3pQvm+SDW66VzcnjHDsahV3MxMRs6dVVS
         GiMJB94BqUeuitTY28Z6Y8Fjs1WtkiL20SxvnB9fbpgqz6jIYlfDSC0/fYXeVT0H5FFa
         beYRKMZgRd8tUA0M3V+CcQ/ThFY11nqhv+D7BoJ+IuCqpw8fSLaHC1T8RjKYlyJPSU7S
         VF4QwCIrKo6lVLFxj3Hjo+9Cng6WNpIh3RXAPNLdt9PMkkFyMukL1r/2uDjBMAYk3FWn
         bQw0sBw5CRtwdkW95fORhMfvoIJdfSBUu2Uj2XQ/VIz06JK4irLfyj06QAkso3Jzhvuh
         Qc7g==
X-Forwarded-Encrypted: i=1; AJvYcCVlHwrXnzl+4dhHyQbi8409lMtzVXtEmrE+qutBD688x/z28oBsbCvGULEELeo1EewxxYIGKB88j92O3Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7UFDeDxr9VMsaF2jsdme9q0aPUokgKCuqlbVPMhWQRF1QupUZ
	DBIAgxNRLr+xYr8MV4qsUpnbkUaVhZEptsVMixb8qGDfbjKU71Q/ynQ7pJ0pjwmk8tqhAA==
X-Gm-Gg: ASbGncvikwS1rkSirw036F8ML0ngDaI/hdbYx//dniaX4GvDYMHwckXjHBk2gP0rxID
	mza8W5w55r2j/QPFdlqURXsgng9Qj+b705LlaMSmsPJVELlmsUjRLuHvB5sMcSLn0tc5Vxv/a9M
	mtC7QWojX6mELWcuK6jSCAczJ5CbhhcaNfsLpIGsb3s0ubonE36qUtt5zX+iyfcM5Bk5WiZalsP
	GWZwJwRiQKLZ2FoJtJLcxqS0QHmqPRPzqIsJJRaphx5/SEQotN6i0A5rEwdQciwnjxmE88d4xHD
	LAfYwj/Z0JOo2B6nWl9JaIqy9p1iLrwH9wKbPSK7OIabwaVZenlMfkTbY6SFj9zWljdMJmSuSgv
	IySaIzZajuTkaHF1oMJadBugqOVvOVxMyPkS/zqzHbpA=
X-Google-Smtp-Source: AGHT+IGZPO/i3EVx1oz0F6ZoZjaPP23o7cGrNgiXJrqYKEIkHenYM007xkUk74i7Lp80iQ9soiKOCA==
X-Received: by 2002:a05:6000:3102:b0:3ee:3dce:f672 with SMTP id ffacd0b85a97d-40e492fdc2emr1826364f8f.4.1758784857530;
        Thu, 25 Sep 2025 00:20:57 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e32c10823sm12335125e9.3.2025.09.25.00.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 00:20:57 -0700 (PDT)
Date: Thu, 25 Sep 2025 09:20:55 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: alexandre.belloni@bootlin.com
Cc: Jorge Marques <jorge.marques@analog.com>, Frank Li <Frank.Li@nxp.com>, 
	kernel test robot <lkp@intel.com>, linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: master: adi: fix number of bytes written to fifo
Message-ID: <5cwo5whsjmyruxmx4kl4opy6qylzzyoodeyqubgpxnlzcgd3ik@2n3gbz5dqtdk>
References: <20250924195600.122142-1-alexandre.belloni@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924195600.122142-1-alexandre.belloni@bootlin.com>

On Wed, Sep 24, 2025 at 09:56:00PM +0200, alexandre.belloni@bootlin.com wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> adi_i3c_master_wr_to_tx_fifo computes the maximum number of bytes that can be
> sent to the fifo but never makes use of it, actually limit the number of bytes
> sent.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202509190505.fKGvEJRa-lkp@intel.com/
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/i3c/master/adi-i3c-master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master/adi-i3c-master.c b/drivers/i3c/master/adi-i3c-master.c
> index 18597ba1f1c3..82ac0b3d057a 100644
> --- a/drivers/i3c/master/adi-i3c-master.c
> +++ b/drivers/i3c/master/adi-i3c-master.c
> @@ -135,7 +135,7 @@ static void adi_i3c_master_wr_to_tx_fifo(struct adi_i3c_master *master,
>  
>  	n = readl(master->regs + REG_SDO_FIFO_ROOM);
>  	m = min(n, nbytes);
> -	i3c_writel_fifo(master->regs + REG_SDO_FIFO, buf, nbytes);
> +	i3c_writel_fifo(master->regs + REG_SDO_FIFO, buf, m);
>  }
Reviewed-by: Jorge Marques <jorge.marques@analog.com>
>  
>  static void adi_i3c_master_rd_from_rx_fifo(struct adi_i3c_master *master,
> -- 
> 2.51.0
> 

