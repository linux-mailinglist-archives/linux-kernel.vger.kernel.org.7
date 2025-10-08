Return-Path: <linux-kernel+bounces-845312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98017BC455C
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3ECA4351539
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07432F5A2C;
	Wed,  8 Oct 2025 10:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iEF8aMoA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6262EC560;
	Wed,  8 Oct 2025 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759919716; cv=none; b=kG57F1Icpf/emf2lNf7mKtlkgIFaC8qFWtZVRPaFZADzqyvLEkHZmAJ8Bd6sNnllSPVlgbz5XCdw0+t08AnhMVDizGmWBoYQjZhTRhxeGf8oyDTEt6+MP2bM90q35lBQlGYDbyyPpIwd9As+kv3zspEUqFlc1Sg+D4oHTu1I9iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759919716; c=relaxed/simple;
	bh=eKipOXTHrNc1OdTzh4pva+hG4+Mk7E/fhYSndKp8ZVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7vVCdjgAjeSPpi56KVECKxzSVpXyBn236tXSlyAkWV7pYKcN7yLqHf0Ax8WCaVKTH7B0wIB0DiEXAGMdxJ5x6RrB3aAP+cC+qYHAi5iwndbgexAJWxUSJNpMYzGVtZgvUzne369C+i7uur0ubGsUrBZSKbtKrOEWzY2pdhsQY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iEF8aMoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371AFC4CEF4;
	Wed,  8 Oct 2025 10:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759919715;
	bh=eKipOXTHrNc1OdTzh4pva+hG4+Mk7E/fhYSndKp8ZVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iEF8aMoAGKSXq9PA6uDiSbiVL9GUW+JI/18n9rDm5UoPFo/wRKHKw35CIpzyMNZQU
	 Fuwfu0TOC7rq9+zvdP71OvM+64XU/Y0geh7yIGGaY0vhc3CFRN25lXybYxpCbviyYf
	 EYW8TpTTS0boSeo1AUOP+ZjFx2tgN8eLQf0pUnvI=
Date: Wed, 8 Oct 2025 12:35:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Akiyoshi Kurita <weibu@redadmin.org>
Cc: linux-staging@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vc04_services: mmal: fix typo in comment
Message-ID: <2025100805-early-shindig-fc85@gregkh>
References: <20250918115619.1616818-1-weibu@redadmin.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918115619.1616818-1-weibu@redadmin.org>

On Thu, Sep 18, 2025 at 08:56:19PM +0900, Akiyoshi Kurita wrote:
> Correct a misspelling in a comment ("recived" -> "received").
> 
> No functional change.
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> ---
>  drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h
> index 471413248a14..1889494425eb 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h
> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h
> @@ -13,7 +13,7 @@
>  
>  /*
>   * all the data structures which serialise the MMAL protocol. note
> - * these are directly mapped onto the recived message data.
> + * these are directly mapped onto the received message data.
>   *
>   * BEWARE: They seem to *assume* pointers are u32 and that there is no
>   * structure padding!
> -- 
> 2.47.3
> 

Already sent by someone else before you, sorry :(

