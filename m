Return-Path: <linux-kernel+bounces-845310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E31F8BC4547
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCD844E0F2F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7EF2F5A1C;
	Wed,  8 Oct 2025 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pKz3RM/X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE127244670;
	Wed,  8 Oct 2025 10:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759919671; cv=none; b=VesfB7MiL8+yf5AapE5qtkuCdAjFxWwCUoipessem5H58UAmaBG8EBFF2KCRf8QRpu/v81k2bUTvyaJ6O0ANPZLJ8VJ1gkRrZ4ZdugrPM5igr915dWHwZdWSvgNOKnqyRqw2mtOvfY0SHM/rEgo48bIMOKF0KBMpSlmLhaYHE5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759919671; c=relaxed/simple;
	bh=EDULCh+kq5lgtOP6xu4+4q+Gz7djMrt5F9HH1/LcYBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGSub+LzGKfRUgV6FbZHV/3b1OiErjoN4tV4+UR5hp6CKn0qpAjemG8Fod371qBc9VMdx9zCs+pakuxwh8JZTSrSS6O9tU54HC/FizJzScB6d5CLOxAnOZLiTzGVJ9knt/YR5mCz2IlAN51teRibCUThQ+2z9IgY0BTPNJ9JNjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pKz3RM/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B65C4CEF4;
	Wed,  8 Oct 2025 10:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759919670;
	bh=EDULCh+kq5lgtOP6xu4+4q+Gz7djMrt5F9HH1/LcYBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pKz3RM/XmuxC89BzVbKk2/UHU1iC+Zg+dGmm2C1IUzal0kTKvztkdtb9oa4h2O1FP
	 Vbc7h5KqOrLu4LHHqwbQ3PJdmUzAW51CbKebOSUp/q4luDJAc3xxNM4djPj9Ogi7i1
	 xlvJPq7PwSj/ZG3/TgPFa+FVa0qzXJ2b8uetaN1s=
Date: Wed, 8 Oct 2025 12:34:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Akiyoshi Kurita <weibu@redadmin.org>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	umang.jain@ideasonboard.com, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vc04_services: mmal-vchiq: fix typo in comment
Message-ID: <2025100822-bobble-basics-137c@gregkh>
References: <20250923043617.2482243-1-weibu@redadmin.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923043617.2482243-1-weibu@redadmin.org>

On Tue, Sep 23, 2025 at 01:36:17PM +0900, Akiyoshi Kurita wrote:
> servie → service
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> ---
>  drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> index 3fe482bd2793..c2b5a37915f2 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> @@ -326,7 +326,7 @@ static int bulk_receive(struct vchiq_mmal_instance *instance,
>  		 * committed a buffer_to_host operation to the mmal
>  		 * port without the buffer to back it up (underflow
>  		 * handling) and there is no obvious way to deal with
> -		 * this - how is the mmal servie going to react when
> +		 * this - how is the mmal service going to react when
>  		 * we fail to do the xfer and reschedule a buffer when
>  		 * it arrives? perhaps a starved flag to indicate a
>  		 * waiting bulk receive?
> -- 
> 2.47.3
> 
> 

Does not apply to the tree :(

