Return-Path: <linux-kernel+bounces-765378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9443FB23105
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CA0685411
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054242FE569;
	Tue, 12 Aug 2025 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="uDK9qv6e"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245F02F8BE7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021480; cv=none; b=DeH8Ytz8+rzSAZK/QWezjhwmQbfV8MfHxJirs8UMr4lUetXbjBR2hKBNNY1YodmndTJSx/5JqerGtOkuLs02eEoC/6a704b+ZYhpGAPeBE1M5T0/RqpHlvzK9GNHIkXJ8VKlsTpNbjJ/7UB6K+J0Y3tV7KUd78I0tvXmh7Yd42E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021480; c=relaxed/simple;
	bh=hPrGuxrOLQ9ipBeDFWhoJK1vM+KGW1+i9S6rdpPe8xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcaDwwnfFir7WaKeMftzjXJMGhYcaWwBCHL/KO9iQJ3iziRR0kF00x5BDBbFHx1FfdKWlGw6JCaxFZIBpnhji4ny7o0lD1MVRb5MWskRyVsbeG5Sultox513qHT9m4/Bbl2JUmqgsYbJHxfzE1On/sNRcDoqAKJlQ6lszs2pSZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=uDK9qv6e; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76bd7676e60so4975894b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1755021478; x=1755626278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qc+A4jnBK4EPdKh66angrNfmE3qm0EXV6FaKJ1CugA4=;
        b=uDK9qv6eTp2PMd3L4a8hShsQcjDB5jf48FIhmNfWH2VcfmiteLxvDDlGaLdwujL5D9
         lHNURWLvSFtiaBpw/FL2Js9X7ifwtQQeSvS+DyF63YdqEH7EcBZmOIGjh1WXRsqfubqJ
         g/L1LzJ0Ub5shHfn8f1IlHGjlE+ja+bc++unIogu9YN9F+4Ig9vrIOX9pN+ofxd+f3Gw
         QIHvTWG25ZxIDouRkxvn+6YYlmhBVXT2XrQthUuT8JUhKS/oDbtCM3e0lxa2gKEoKq/7
         SOAwT9+yY57Jqg0t3NMnCMJJn60oqoppI4DjRVwiLT62c8lhBA1A6+2Ebh3n8jvZDRXE
         zm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021478; x=1755626278;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qc+A4jnBK4EPdKh66angrNfmE3qm0EXV6FaKJ1CugA4=;
        b=R/KVqazuvr43Z8AQORJeu21mIupmrpAnk97tYzgBVEDdwXF3BvG1DAnBHqktPCsk2d
         NkudBVpmE3K413uq5PTOfN45+b/JF8Q/MEpurCjnZ2TuUq6MRDIAOknUhL/IUqB5EXja
         hmQr9tVW2chJhSWID7GLY2VsPPRL8rZgBphtqvug+ruzWbcoQDs4aziZiR+J0s72oMjo
         4c0OisuvhnA3chQmZVo+4QugxrGN3Qb3TNh2xr0yzcR5xd02wDwRRZXhNnV9P85Ynjxl
         w61pLD40t3DHikyXCckdWEPJVahKvkfH17MlxqlnKiMkZGiOH4oo1pLyaIwLDC1H7Aw0
         1pwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNloQCmDc5Q1QQZSMkiPBJNf0+CplKEL9kofcaQ613gL+23uff4WPI8UBeI3369JnGZ4occ7pmy8HmouI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH7ML0lPvvyXQ6dQVFZpnuDD+7vauMriOhtWAQUS0WSuoj6n/F
	Blj2FYs52xWhNg2EqNpAuidpc4mzQEl6XUNm/IdUGmasr09yJYt6DCXJ/xg3s+v4F2E=
X-Gm-Gg: ASbGncv5k7lj51U389Suc4Dhqrhl3+OQbm4A5YCsDhW5RZ2abOPFYWZRUvN8hC/5ROF
	m+YtuKJ8qEL3bbovujt2F91cVITeGm1G25pUaS0od2/PUJZ0JX2bahuwvpVAn2PLRsY4rAseip6
	otHOlV4slXo2Ex3vxlb0/dnKNk1nioc5IHpKZ57P6BX74DJGV/0VcEe7LvNwnANXv3Nt1x91r7N
	NoMYFxQInSV8VNchfazqacFxSmu7IBKxAsxCL+q3/aoQeAN2BwAc986Uzmhd4WdUdELCUbq3uvR
	ocIDm6AhWr5w59QNLCP6OYqgcSh1SXfrj01Oh4POmBValLevL99L6lUpzYOxjQU16LLmIq3w+dV
	dqSJpdmJmA0MTYeIGxZG1fuZv42CYH1T7h7QJRqiDBYk+Y2kICSfHjujY4O6+UEh2c2++ryeyCB
	P9WALLMfA=
X-Google-Smtp-Source: AGHT+IHxi2HOW8bSGkAzQGQAd8ZqXnSd+5ht/WWbBZm7UBPBn7pRtc+d0H/ulq4tQ+TrYx/lPWqfGA==
X-Received: by 2002:a05:6a00:b55:b0:748:fe3a:49f2 with SMTP id d2e1a72fcca58-76e20f900d8mr126425b3a.21.1755021478408;
        Tue, 12 Aug 2025 10:57:58 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfcf523sm29950265b3a.90.2025.08.12.10.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:57:58 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:57:55 -0700
From: Joe Damato <joe@dama.to>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: trondmy@kernel.org, anna@kernel.org, chuck.lever@oracle.com,
	jlayton@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, neil@brown.name,
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
	horms@kernel.org, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sunrpc: fix "occurence"->"occurrence"
Message-ID: <aJuAo3lfY9lRB-Oo@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Xichao Zhao <zhao.xichao@vivo.com>, trondmy@kernel.org,
	anna@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, tom@talpey.com, horms@kernel.org,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20250812113359.178412-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812113359.178412-1-zhao.xichao@vivo.com>

On Tue, Aug 12, 2025 at 07:33:59PM +0800, Xichao Zhao wrote:
> Trivial fix to spelling mistake in comment text.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  net/sunrpc/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
> index 09434e1143c5..8b01b7ae2690 100644
> --- a/net/sunrpc/sysfs.c
> +++ b/net/sunrpc/sysfs.c
> @@ -389,7 +389,7 @@ static ssize_t rpc_sysfs_xprt_dstaddr_store(struct kobject *kobj,
>  	saddr = (struct sockaddr *)&xprt->addr;
>  	port = rpc_get_port(saddr);
>  
> -	/* buf_len is the len until the first occurence of either
> +	/* buf_len is the len until the first occurrence of either
>  	 * '\n' or '\0'
>  	 */
>  	buf_len = strcspn(buf, "\n");

In the future probably a good idea to add net-next to the subject line so it
is clear which tree you are targeting (e.g. [PATCH net-next]).

Reviewed-by: Joe Damato <joe@dama.to>

