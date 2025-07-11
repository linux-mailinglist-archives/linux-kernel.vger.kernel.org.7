Return-Path: <linux-kernel+bounces-726847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7883AB011F0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 281787B09A9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC9D1A5BBA;
	Fri, 11 Jul 2025 04:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="sXc00bXc"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E623B3D6D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752206857; cv=none; b=tJljaEHWWES6mMjsnYCz56owUSDIevm8IyGbybh4t1uOnGSC3hFMWodGBodAaJfElKtPDpEGpOsY1mX8V+Ro9NBZ89TOw3OQh3hpXrQ6giIL+XG+1sdt4Mbpz1PSJCq1MEGBWH9r+wPtXwNnIzSq2PGuPWrSw2OPh55TVhGCR9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752206857; c=relaxed/simple;
	bh=j5AsxP9ygZ+4fLvkZ8fLF8g1ByH0EVRv6XFYqy13y9E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DqqDAuNd05ufoRdemLM/Cyq2j9Q3yKg7/z7y3e1QjBGQrI6H359sToTSvr0TDuboP/gsEIP6gTUTGwckviRrvsSE95REd9Ep/22BUPmhy7J/9vZ9wfNeNLHhjd3DCZx3u22ZqQnw2cUH3vZat2To1XDHbZ0o8wqyp/Loru7F4/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=sXc00bXc; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d9e2f85b51so174914185a.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752206853; x=1752811653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozI0Im86wAHsju6y0mF3RNQgE8ARNsXr6q3IFbk6UJ4=;
        b=sXc00bXcfY//854jxpkgbeajZbi/4pJxuXVtTx/S8LQqvfCJ0U0W4P2ZATrRyyj9Pr
         ZwQNnbzEJ2oLMAgTPrR4yOW0WlaGXqLhnelZ42mOP8PQIaxhxjPcgatGj+2Si6eKxcYr
         4HgC5SnuXYfMC6fx/le02PODrjm4HWI06CKe9ciemBaRuV92Ge8/OAmnNeqUPWUVV7v5
         vD/eZb84OYw9NkCObB2JAMtQRYOFIqwwnM3O5I7KUxMR/RfFJuFG87IVpOB4V5itG2IV
         Ikjjwod1duvI8dncTCPk7SVYRRpx43m5feJtseMPCFvhOFiR9pP40jL9Hz3K/avkcawh
         SyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752206853; x=1752811653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozI0Im86wAHsju6y0mF3RNQgE8ARNsXr6q3IFbk6UJ4=;
        b=lPRkMsxBHd3FuMCOTuQoZzSBRrtR2mHlJd+6SgGX3smIAIe8nsr9Wq3OGiFKJQa7kR
         coixr4ZsLQi+cb5kkJeffCVZ+TFwdpRzq8Js1/prbyQxwTftvdKpgD+2QANzuey6jkVt
         XcIOaOY2EWfB0Ht4gTHy+lJGiwzjyr7FiKvW4imT5n4CCxYxP8FT1AZ3RE/B674ZYBGb
         vwmrzjupfpTFehxZ+vz/140AjYM4EnqA/HIou/UL8YjCh8eni+ykpNFB5ieq7drNXBR1
         wwH7x+Q5d5PVjrraBYf6+HH0uXGuHtvFPwMgwukBYuMnZnUabmtubIVPHpAW2WunRiOb
         Dxww==
X-Forwarded-Encrypted: i=1; AJvYcCWFtzcES1QLcR5wiIFiNyUwGIo1StKD7gNjVWyoKHDzGVjJtGzb2ZFho4UyJYa54FVkLkaBLA+2kEdKa1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvjP+uBFJ5hqHxYxTElb05p43sveKY9I9q4uyhgjG3iHKM5k3G
	ndM8ofn5cYSfzPNMMVZIYQtLlcGE1m47IHrDPxXC8OLZQ6aOCZvExl9pSPd3VLTW0Lw=
X-Gm-Gg: ASbGncsh0wGvgGHVC78AYzOX/SY9DrbHhTcojRN/cbMewbW7qZhH8sI5CMT/jpZCS3S
	G3xvm3d0odtrTffTdEpYoG9bHBM8RamGlTR+hTcdrfYX4QX48kTul5RH1FZu4iKaCniaA5InX7d
	wC3fW6v5R/e5VvIqG26kOaNOC6IOlydyRNSjvzJG2crPnLwD0Oxbqrz2TUfl0fKBMyXoeX79QeL
	6D6CtueDi9ihb/2ky0WJnJciwtZtIGaXnMZrDb/l9ck+NzgNNFuNEjh9ynW+AbU4qwlhPZ9I+uw
	aRPffhR3djH3+AXtKdCUl6rSidJ/KlhTuWiohjYHd9AxLarMrutKPwypZ8LDhXCoYeW0Tn9aKic
	zgYkemRj5NoV2B5Bu9GJhNqmd4+AadvN2yVDlPv8OTpEsqnDu7Hh8vieOJCS7J32ZkXbQAX6qcr
	VHHXOLyp8Eng==
X-Google-Smtp-Source: AGHT+IFg+opR7QKrPek/aiw2KMWIeqj6WMrtKH54JNMGj4ISErFzTHBHopOhx9PIfMQ8GfRP14PjZg==
X-Received: by 2002:a05:6214:21e1:b0:6fd:ace:4cf8 with SMTP id 6a1803df08f44-704a39721a0mr25881386d6.30.1752206852620;
        Thu, 10 Jul 2025 21:07:32 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979e3146sm15991256d6.41.2025.07.10.21.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 21:07:32 -0700 (PDT)
Date: Thu, 10 Jul 2025 21:07:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Li Tian <litian@redhat.com>
Cc: netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v2] hv_netvsc: Add IFF_NO_ADDRCONF to VF priv_flags
 before
Message-ID: <20250710210729.36231c98@hermes.local>
In-Reply-To: <20250711034021.11668-1-litian@redhat.com>
References: <20250710024603.10162-1-litian@redhat.com>
	<20250711034021.11668-1-litian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 11:39:58 +0800
Li Tian <litian@redhat.com> wrote:

> Add an additional flag IFF_NO_ADDRCONF to prevent ipv6 addrconf.
> 
> Commit 8a321cf7becc6c065ae595b837b826a2a81036b9
> ("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")
> 
> This new flag change was not made to hv_netvsc resulting in the VF being
> assinged an IPv6.
> 
> Suggested-by: Cathy Avery <cavery@redhat.com>
> 
> Signed-off-by: Li Tian <litian@redhat.com>
> ---
>  drivers/net/hyperv/netvsc_drv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index c41a025c66f0..8be9bce66a4e 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -2317,8 +2317,11 @@ static int netvsc_prepare_bonding(struct net_device *vf_netdev)
>  	if (!ndev)
>  		return NOTIFY_DONE;
>  
> -	/* set slave flag before open to prevent IPv6 addrconf */
> +	/* Set slave flag and no addrconf flag before open
> +	 * to prevent IPv6 addrconf.
> +	 */
>  	vf_netdev->flags |= IFF_SLAVE;
> +	vf_netdev->priv_flags |= IFF_NO_ADDRCONF;
>  	return NOTIFY_DONE;
>  }
>  


Thanks this worked originally but got broken, please add:

Fixes: 8a321cf7becc ("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")
Cc: lucien.xin@gmail.com

Looks like team and failover have the same problem.

