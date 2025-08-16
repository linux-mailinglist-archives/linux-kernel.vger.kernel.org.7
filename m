Return-Path: <linux-kernel+bounces-772080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 452E8B28E89
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 16:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF701C23FA3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C676F2F1FFF;
	Sat, 16 Aug 2025 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dominikbrodowski.net header.i=@dominikbrodowski.net header.b="MhnNvdZI"
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A553A2ECEBD
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.71.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755355426; cv=none; b=m9u5pm6Q93eECK1zIT9LXjMxEwZNKf3p4BeAG9myoq7u2I1j5X/pXzC7l3+DhVP5ajOcNpJW8HAWy5Mrb3BwpI2e6XSrNLWOS4x0rCxT90ALDGxgU830HjfjEz3fQYFrbwhLLVpgX90wfQIpKdCWiw3hurlfO2lX30Ev+q1ajJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755355426; c=relaxed/simple;
	bh=TN99MRsPcz5YhN7Rwy76qkCZvjxd1IXZOLsBB/k6IoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeK/B+iF+S2OA17FelL+jzB6iBNVMH2nviXKqqRuLBsTqQcxas+Fd5y4m78xmAufVikRXPqeYfUHvSUt/76lLNk1vFC+eGz9Z4rvBLHYrU70K5wpDoSYl+vTfv3BuxRyPUw763bpUhuDP3EFLtXA8oLtkKUuIOkPIifrr04PBno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net; spf=pass smtp.mailfrom=dominikbrodowski.net; dkim=pass (2048-bit key) header.d=dominikbrodowski.net header.i=@dominikbrodowski.net header.b=MhnNvdZI; arc=none smtp.client-ip=136.243.71.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dominikbrodowski.net;
	s=k19.isilmar-4; t=1755355416;
	bh=TN99MRsPcz5YhN7Rwy76qkCZvjxd1IXZOLsBB/k6IoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MhnNvdZID+WEPnWCIVYCAzJuil5nFcqXueOzAacNa3zWoqGIW7M6pEM09Uggy0kEI
	 HONqNRGoSMJjBycia8DaUsftWLNUAyUTp9eQBNT7t3OlwpjstRCO3Alfx00zgvw5pd
	 lZKrbBAWMBULm9V72FHWBSpcTgIVM8gxmaNvpPjUikwhKfCpIuEQncSjoYwC5vbE+S
	 zZArIVnZtArchIUqUQPyLtD8tYYEs7A8V1LT0+SVLGPhpx+MCmt0VY8pqCJLJmwT1x
	 zRxC6NbFszKN//WnIZEMag0WhdZCiuzdZwimaKSLobjuHy1BWPrjKZPNSpL2QLaF9S
	 0ZpLfmBa5FQww==
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id 544AE200726;
	Sat, 16 Aug 2025 14:43:36 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
	id 04FEDA00AC; Sat, 16 Aug 2025 16:43:15 +0200 (CEST)
Date: Sat, 16 Aug 2025 16:43:14 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux@treblig.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: cs: Remove unused pcmcia_get_socket_by_nr
Message-ID: <aKCZAhWxo5fxzHUA@shine.dominikbrodowski.net>
References: <20250303010125.254587-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303010125.254587-1-linux@treblig.org>

Am Mon, Mar 03, 2025 at 01:01:25AM +0000 schrieb linux@treblig.org:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The last use of pcmcia_get_socket_by_nr() was removed in 2010 by
> commit 5716d415f8c5 ("pcmcia: remove obsolete ioctl")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Thanks for the catch! Applied to pcmcia-next.

Best,
	Dominik


> ---
>  drivers/pcmcia/cs.c          | 17 -----------------
>  drivers/pcmcia/cs_internal.h |  1 -
>  2 files changed, 18 deletions(-)
> 
> diff --git a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
> index c75f55e1250a..adbc486af2ea 100644
> --- a/drivers/pcmcia/cs.c
> +++ b/drivers/pcmcia/cs.c
> @@ -229,23 +229,6 @@ void pcmcia_unregister_socket(struct pcmcia_socket *socket)
>  EXPORT_SYMBOL(pcmcia_unregister_socket);
>  
>  
> -struct pcmcia_socket *pcmcia_get_socket_by_nr(unsigned int nr)
> -{
> -	struct pcmcia_socket *s;
> -
> -	down_read(&pcmcia_socket_list_rwsem);
> -	list_for_each_entry(s, &pcmcia_socket_list, socket_list)
> -		if (s->sock == nr) {
> -			up_read(&pcmcia_socket_list_rwsem);
> -			return s;
> -		}
> -	up_read(&pcmcia_socket_list_rwsem);
> -
> -	return NULL;
> -
> -}
> -EXPORT_SYMBOL(pcmcia_get_socket_by_nr);
> -
>  static int socket_reset(struct pcmcia_socket *skt)
>  {
>  	int status, i;
> diff --git a/drivers/pcmcia/cs_internal.h b/drivers/pcmcia/cs_internal.h
> index 02a83ca44e77..5ac810ffda31 100644
> --- a/drivers/pcmcia/cs_internal.h
> +++ b/drivers/pcmcia/cs_internal.h
> @@ -116,7 +116,6 @@ extern struct list_head pcmcia_socket_list;
>  extern const struct class pcmcia_socket_class;
>  
>  int pccard_register_pcmcia(struct pcmcia_socket *s, struct pcmcia_callback *c);
> -struct pcmcia_socket *pcmcia_get_socket_by_nr(unsigned int nr);
>  
>  void pcmcia_parse_uevents(struct pcmcia_socket *socket, unsigned int events);
>  #define PCMCIA_UEVENT_EJECT	0x0001
> -- 
> 2.48.1
> 
> 

