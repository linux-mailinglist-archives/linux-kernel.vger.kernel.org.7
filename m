Return-Path: <linux-kernel+bounces-772082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA70B28E8D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 16:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 862667B2BC7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BC02F39B5;
	Sat, 16 Aug 2025 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dominikbrodowski.net header.i=@dominikbrodowski.net header.b="bYMNAbur"
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B882F0C4A;
	Sat, 16 Aug 2025 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.71.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755355427; cv=none; b=RmkodBgu21DT6Oq2mzATEWs6JDu1C4+MMH+A4v+wIaYVIyAhafT34KJXkegClpsDYadpDPjknHTQfXG/lPOEB1UQEqPEjqW1S0wJxkwu0FGaWOVpv88Rik5GDl2tfTD1LTRPdHhCTAQcEHKeoDFLJFgusEBQVIn4rTUlZYrJoao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755355427; c=relaxed/simple;
	bh=pPS3+waBKJZuNb6253otbngG8ThZHROIxTa2swY+WYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrwEjbQoI5eYjUHfTNUWLtHafF0B733tP+JsMi6OWYhuIrrnfH3qZ/RaPkoKqPBezQoO4WAf7MWYJwbPCc65lXOG1s+HSTIKyZBYSxR3F4e7TZjk5cPx0J3W5O1S+H9SGU1lszrPE/YBk9VY/G0rjtjKtVKhvx01DS3qloMQVko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net; spf=pass smtp.mailfrom=dominikbrodowski.net; dkim=pass (2048-bit key) header.d=dominikbrodowski.net header.i=@dominikbrodowski.net header.b=bYMNAbur; arc=none smtp.client-ip=136.243.71.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dominikbrodowski.net;
	s=k19.isilmar-4; t=1755355416;
	bh=pPS3+waBKJZuNb6253otbngG8ThZHROIxTa2swY+WYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bYMNAburrhC/oT4b3swyvRvlXyf3Q7IKHqdyfxntxB9TRJC0zatFNicoHqZV4EqYT
	 rDxFQaPBLcf9fVGcbTkHBp2oiuxyXtXBN6JHn0zYS4N+U+GG5PYP8DmsG2iBXUSwFV
	 J+7Gqmacd5GeqtY8AZZ5hZ+1Gy3Ur8YoRpZ8HQltGHhTE27Vyr+BbbfG73LqNsq/Gt
	 Vemc6PnToVZYnCa/B2JS0+GsVLRSMbkYYoVdheA1e5BJf4NkavGS7nGpuGTW79QtUV
	 /n0iNyKMDq0mp7gdiWTnZntplEHyAWsjTGc2trb1bye2YEc/n+RXVnX8Es3gXVX6Fl
	 L9NboqNLHFohA==
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id 8AF3A20074E;
	Sat, 16 Aug 2025 14:43:36 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
	id 8D5D9A00A2; Sat, 16 Aug 2025 16:42:31 +0200 (CEST)
Date: Sat, 16 Aug 2025 16:42:31 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Lee Jones <lee@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Jilin Yuan <yuanjilin@cdjrlc.com>, Mao Zhu <zhumao001@208suo.com>
Subject: Re: [PATCH] pcmcia: ds: Emphasize "really" epizeuxis
Message-ID: <aKCY182EIzEZCV4P@shine.dominikbrodowski.net>
References: <20250811020436.13486-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811020436.13486-2-bagasdotme@gmail.com>

Applied to pcmcia-next.

Thanks,
	Dominik

Am Mon, Aug 11, 2025 at 09:04:37AM +0700 schrieb Bagas Sanjaya:
> pcmcia_dev_present() comment writes about small timeframe where
> the function returns NULL (racy condition), in epizeuxis device. In the
> past, it tripped contributors who misunderstood it for "really"
> duplicate ([1], [2]).
> 
> Add comma between "really" words to emphasize the epizeuxis.
> 
> Link: https://lore.kernel.org/all/YxT1As38WRZcyH0%2F@shine.dominikbrodowski.net/ [1]
> Link: https://lore.kernel.org/all/20220831083623.GA25639@isilmar-4.linta.de/ [2]
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  drivers/pcmcia/ds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
> index da6f66f357cc10..18f4eef28dbc5d 100644
> --- a/drivers/pcmcia/ds.c
> +++ b/drivers/pcmcia/ds.c
> @@ -1308,7 +1308,7 @@ static int pcmcia_bus_early_resume(struct pcmcia_socket *skt)
>   * physically present, even if the call to this function returns
>   * non-NULL. Furthermore, the device driver most likely is unbound
>   * almost immediately, so the timeframe where pcmcia_dev_present
> - * returns NULL is probably really really small.
> + * returns NULL is probably really, really small.
>   */
>  struct pcmcia_device *pcmcia_dev_present(struct pcmcia_device *_p_dev)
>  {
> 
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> -- 
> An old man doll... just what I always wanted! - Clara
> 
> 

