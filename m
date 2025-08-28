Return-Path: <linux-kernel+bounces-789596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1446AB397D8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D39E1C21571
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211012C2368;
	Thu, 28 Aug 2025 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOp7+ne1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D6625B663
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756372251; cv=none; b=PEf/gwQp7IjEKsHdzDUroIur1mNzZJpA2OjDkmR+sxTMG3AgV9cciPoEX68bOSJJfbFYszPmwga2gV79O6iuGzN24pUoOcrOu9epN+rHC6oODsgVH+PVhJlT4mlf6oa6pidjmAotxzK0XKMIyS33ciTie0v2sCKwkwB7B/0OfZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756372251; c=relaxed/simple;
	bh=w6SANh9M41Cz/FJdilTI2rNWrEJavLzRaQZtNc9gy9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXSTZof8KvsNoZb9X67LFF7S2eMSBtNa6qJfNivBjUs/2nf0KcHwsLtm1rPFU01IlbjFqSgBgux0sCQJv7AQ5d8Hqtxc+eXLdR+AIo47+ekwcKTzsrBHNSSuPmvK3KLtCEEpCw4hSz4k2CdImciBSn6Xgi7aT5IS0UGe0HMYVuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HOp7+ne1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756372248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nKlwPKezbuO9xwAGZFmpWVmFnAyIOSinJ2mEOrJ9HXU=;
	b=HOp7+ne1UuIug9gUp5+AqQKsKNuNSs56RQV8FdlPUKgG9JfT9Hj37dMWDe+Nwszs913UZu
	48v8XxjzHZzsh2RcKivOqIzvbE5XzGAbAUDJ/7gt1agJO+RcprV8tK+pJGCMGYVgBVAG9W
	dZ2H3SygqSeO0T6QA/SSyUjSNicF6EI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-R5S1vPIwNNWRoCVBcBoOVQ-1; Thu, 28 Aug 2025 05:10:46 -0400
X-MC-Unique: R5S1vPIwNNWRoCVBcBoOVQ-1
X-Mimecast-MFC-AGG-ID: R5S1vPIwNNWRoCVBcBoOVQ_1756372246
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-71fece075d7so8655097b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756372246; x=1756977046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKlwPKezbuO9xwAGZFmpWVmFnAyIOSinJ2mEOrJ9HXU=;
        b=e9QgWj1fS7c6WA2FEhcoOU2pQj0GEC2NCqsoP07dEjMuOeoBavjcy/Uho7/g3B5eNq
         shpAkthkvd1jwKDtmKuYiKRPGXxl70k7R83UN6V0SrZxO9HCjW0jOFFYn6C8K+n4oI7p
         DoQbvCTOfgMrf3dUK6GkR+orKiFJuH2y8JdCZvwloISoTiuZLSPmBtGLh5Qo+elCwP1a
         zVLJgbNCjwdJWgK9Ig71cHzsjBYCqmFmKF9ZZeE1n6lcs1MktkghMr/m7B/ebkKRAscO
         J+NNjiHXbUYhdxVWygCplaPbSfVrQHytzucGAXcL3CwA5hdkcw+NFvZIMVfuxT99DyWG
         zRmw==
X-Forwarded-Encrypted: i=1; AJvYcCXWFVykQpQDn3tXeSvdSXYgKw7mc4gu0akBFnzCyV4CAaYyW1jMAs0vGL/f5Pnsq0UhjMgBUVwwUsr3gxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1cbIdSUOPzJ6LCJm0NIhe93xSC1osVT7YBjeXyXNL3LSk+8Ug
	tpjk+LkSVosVpwHo3su4gclEs71M8UZ4Pxk2FHmxCIjbtimkI8oH3gLKogNC+TgA3Fjk6pAlSTZ
	2/x2nA0Pr1IdHGrRoifD73dP7Q//EPT3NJGNDR8XvHvAf/UcI+MobaSNG54QyAl+FXQ==
X-Gm-Gg: ASbGnctDL3iob+F8nYrgn/lMUOpxdY0/yoBUvQYlKfCMmYSQzx2a6oWtbE5KWkfmzUt
	UVn0UleAqmmiBiOAN4GGXzqmCdOdKieJHoUY/ymGXHuX2GF4GbwKlL6SS2d/eC8QtZaQ+77tQAp
	LctjDKUzUbxBP1QVVBeb0M2LclSfop4PAj1pdXhgpvC05AkIIQMqYhfhl7hq3fiH8cFihAxqfVs
	+KURVU4MSfD9EjYQk9cirZOjnGqYl5bKr1XuWjbr4m77TCynTZapTqALjiVKeUxkkr7Wj4jBmWe
	pYniwbYOFK5O/X0dh6hqUYbDliooTvmosYu1+vlQHs1IlDxNYFypjTnUBd+aIhYKblCNRBAm7eP
	MmawPvm0is8VgVyc=
X-Received: by 2002:a05:690c:ec8:b0:71e:7ee9:839a with SMTP id 00721157ae682-71fdc2f17e3mr254131117b3.2.1756372246204;
        Thu, 28 Aug 2025 02:10:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6sWncGKqn1v4/1RP9QN/2CTRKrNYh1qBsv09tOJjEFxNBC/SRSbycXZhflbiMWoycIj9R3Q==
X-Received: by 2002:a05:690c:ec8:b0:71e:7ee9:839a with SMTP id 00721157ae682-71fdc2f17e3mr254130717b3.2.1756372245672;
        Thu, 28 Aug 2025 02:10:45 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it. [79.45.205.118])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-721583892efsm5988377b3.2.2025.08.28.02.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 02:10:45 -0700 (PDT)
Date: Thu, 28 Aug 2025 11:10:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: "open list:VM SOCKETS (AF_VSOCK)" <virtualization@lists.linux.dev>, 
	"open list:VM SOCKETS (AF_VSOCK)" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] vsock/test: Remove redundant semicolons
Message-ID: <rz5brbahjthbpdl7k4g47zugrofw3wj4fijl5aejwteumtsjiu@3nl2sfyvbp24>
References: <20250828083938.400872-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250828083938.400872-1-liaoyuanhong@vivo.com>

On Thu, Aug 28, 2025 at 04:39:38PM +0800, Liao Yuanhong wrote:
>Remove unnecessary semicolons.
>
>Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
>---
>Changes in v2:
>	- Remove fixes tag.
>---
> tools/testing/vsock/util.c | 1 -
> 1 file changed, 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 7b861a8e997a..d843643ced6b 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -756,7 +756,6 @@ void setsockopt_ull_check(int fd, int level, int optname,
> fail:
> 	fprintf(stderr, "%s  val %llu\n", errmsg, val);
> 	exit(EXIT_FAILURE);
>-;
> }
>
> /* Set "int" socket option and check that it's indeed set */
>-- 
>2.34.1
>


