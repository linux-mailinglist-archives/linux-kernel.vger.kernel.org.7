Return-Path: <linux-kernel+bounces-757757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2FAB1C64A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B0618C3306
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D55A28C033;
	Wed,  6 Aug 2025 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="imzq8hEa"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFAE28B51F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 12:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484500; cv=none; b=KkYgCeEJqWTBE8Q7vuxMKvy8bGSWz+Z3uIYVMfz/8TT2I+sTrxmWA3GQYtjyGF8rBtVfjwywYYwZwvkRiT/TI2vKqe2FgsFvpPRRZpryvG/RNZ8hoYwwfx0IWnh/34TMd9AL8KguwGJ71tRoolKI54iHRTlXs/cJIzrCo+yzQfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484500; c=relaxed/simple;
	bh=HfI/zx9XDbVgQ0otqTbAOpA5i4S/wWlfQ7OSkosJO10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlG2u0nICOW5X611KVFXINtMs7ALaedKdz9iI5LlVYkxdGNsF07QvpiG5rdjzbW8LyOx/Lquc9duX1w2UZAqJd6wMxP7IJQ5RIB4XXpCqNGJSJlLqmR6xrRNwCqa4LPtB3RSH3K4CDM8GImK6wdvN++a2WPYGg0o+7deEP/6bnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=imzq8hEa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45994a72356so7590695e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 05:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754484496; x=1755089296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jFXnqIPRbV3BB6pjp/TTF7phDE5SLRKlO1oZx1A596Q=;
        b=imzq8hEaQBpaEeYBfp44rNq4dTIj4SrxeqxANKEtK3ajHy8UdWmInIe96u7qAnHC0C
         yRe+FekfmJ7V1aA5yt1Xu2+3TmL8deEKqe49J9hXWvsf++BWmndxW49sdLPjSjTY6s7s
         cWuZ0k38qMWS4VPjnBCFVq6KBfsewMfXFO9Q67lyDmMK0Dty1jbhGGNEo+hOvmCTw+10
         NiJdZlMvBb0pdTXXYJFl0/Dpno5MCzU764fyYH9nx1N+insNmrcV09rDDMuUrJS1IxH0
         icWPVTmY2ZBe/4UTa+ZcUc1ro+Uni28FoKE6JjvlVQQqTjbdlhxDbDV90DvjDcv9vJXm
         KIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754484496; x=1755089296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFXnqIPRbV3BB6pjp/TTF7phDE5SLRKlO1oZx1A596Q=;
        b=CKG3rGomSXPrKplOhvVW2II9rSxLt25BRGuKxDm1jVJDoSibheGbt4ECDBS8bL34Ip
         BVUBaWT4TZKgMlrFtVbnnLSF2dXDxQkouXb5UuccNfGSyXNnahdGpmC/IZLM/xGLAIAy
         eb4HEhhIMdyXf7jyCGY2VxsFmvz6iplHnHZPn36B0WqLbV6TcDw3+ElijJaS5Iue8FRT
         0sltFLlUvPisl45Fjs8P/CxNIDow+9BKLsEhHaxea7PsQnQMM3ukHxuCfY1Oh6YFdw0K
         6YvRvveaBND69nrhMjKsadg73wuZ6ILTpkg6VaGt5dd23mC8znuud48YD0n8qS7+CAl+
         Btww==
X-Forwarded-Encrypted: i=1; AJvYcCVtVD1bOwhN/fCxOebQdNiy6aQK+XxgF4hucwws+HDKHUVsZlLsEr3tcpLO0zeeKHots4GdSRGlcDxnVBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnv4DWnGi6mS2HcY2NgChfwoZmj52ynuxrlvmdFJ0bp3f3hzHv
	FgY+7uIVX/oYS4g3jWQ9jMOX5NUDqn1aUpDE2RKw8CsOY8yXtjuFQXr/55yFSkeqEpM=
X-Gm-Gg: ASbGnct8pmzHJMMZuUSExWe6q3q+ovAtzHSKGThN9pQp1EcS9E2/IKS9qTrr+nLufj0
	5RiXyvK7arKAi/0nS4Pq+FJdde27P69c0YRXI7GVoufr3iPXMRs7MaRkdpUs457EZb/kBrM3s8k
	gVU7MtOZjykahu/n2UcMZX7JCGeR2IKPLjumJJV24P68BKSxqfrOWJB3rsUxHP2SBNoM0O6Kl8h
	AEM6HBxoQ0Hje08qOzeKds37eQ4xi06yseOQ++b90rfX+HDXh9iln1CzvtrXABX8z08xvL1/tWT
	3LvH2ck35KvZwucIDzfmY5sfyObumUA10n3n6Pa1nVxy9R8KbLm0QkbKTOcMp1rf4stZNboDBKW
	c+b0DRo8bDUBUhRq2a1Ebtfh/ANfANlUyDCl7Qw==
X-Google-Smtp-Source: AGHT+IHNdtNiD0VN2ibLWx44aT6ddin7+JcHP84VGabSPvwF+bE3cWHRcZxCTSkZKPKy4kZcasPWeA==
X-Received: by 2002:a05:600c:3e08:b0:458:b608:509f with SMTP id 5b1f17b1804b1-459e711e039mr25952315e9.14.1754484496042;
        Wed, 06 Aug 2025 05:48:16 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4595cfea56fsm95238275e9.1.2025.08.06.05.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 05:48:15 -0700 (PDT)
Date: Wed, 6 Aug 2025 15:48:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Stefan Metzmacher <metze@samba.org>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] smb: client: Fix use after free in send_done()
Message-ID: <87646c67-78b8-41c5-9b72-361cb3b733d1@suswa.mountain>
References: <aJNASZzOWtg8aljM@stanley.mountain>
 <ad2e9d94-2d95-4351-b800-627f20672209@samba.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad2e9d94-2d95-4351-b800-627f20672209@samba.org>

On Wed, Aug 06, 2025 at 02:20:56PM +0200, Stefan Metzmacher wrote:
> Hi Dan,
> 
> > The mempool_free() function frees "request".  Don't free the request
> > until after smbd_disconnect_rdma_connection() to avoid a use after free
> > bug.
> > 
> > Fixes: 5e65668c75c0 ("smb: client: let send_done() cleanup before calling smbd_disconnect_rdma_connection()")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >   fs/smb/client/smbdirect.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
> > index 58321e483a1a..162f8d1c548a 100644
> > --- a/fs/smb/client/smbdirect.c
> > +++ b/fs/smb/client/smbdirect.c
> > @@ -286,8 +286,8 @@ static void send_done(struct ib_cq *cq, struct ib_wc *wc)
> >   	if (wc->status != IB_WC_SUCCESS || wc->opcode != IB_WC_SEND) {
> >   		log_rdma_send(ERR, "wc->status=%d wc->opcode=%d\n",
> >   			wc->status, wc->opcode);
> > -		mempool_free(request, request->info->request_mempool);
> >   		smbd_disconnect_rdma_connection(request->info);
> > +		mempool_free(request, request->info->request_mempool);
> 
> The correct fix is to use 'info' instead of 'request->info'
> other than that the order needs to stay that way.
> 
> I already asked Steve to squash such a change into the
> original commit (which is not yet upstream).
> 
> See:
> https://lore.kernel.org/linux-cifs/cover.1754308712.git.metze@samba.org/T/#m98a8607d7b83a11fd78547306836a872a2a27192
> 
> What was the test that triggered the problem?
> Or did you only noticed it by looking at the code?

This was a Smatch static checker warning.  You need to have the cross
function DB to detect it.

regards,
dan carpenter


