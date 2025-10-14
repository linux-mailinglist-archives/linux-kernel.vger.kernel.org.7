Return-Path: <linux-kernel+bounces-852185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B095EBD8631
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D6E14F849F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7C82E7BC0;
	Tue, 14 Oct 2025 09:18:20 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F3A271473
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433500; cv=none; b=fgEK6yTGPoZa/lb1BR/UDC/kKeY0rbsbntlyoDB2TPqkoMITKL6HVnD3Ts2pCPbCH4vFf4N5Rkgpxf2BqDTSzYDNrRI1ITO1MLVVx83JWK/K6OW07jExFpLtH7zEdzVxVfxtxvOlAKtU3EbrixXV7e3iCwLTyp/evyCiOVs5iPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433500; c=relaxed/simple;
	bh=pRySc9wGvib0712pdmZwsSCJaX7osrehM2VEKQgyLbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMQpBO6TErI4EGv23Oz+caDLzQ9VgylncjLbOOvEr1KDDXiiFR+aEdJYVs1br1SyaqRbj/bIWZKxxq91McOMo13JoxoqzIPP3rxFqOVgdIQOkFbkWhuNLvlZhM8UonWoFaAc+HK42N4HjnYOddaxFP5Pt8V7qwR8bt6wr+WYKpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so923257366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760433497; x=1761038297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0XLyxJWaoIPYyxxXV4bvKlSgBwkx+wM+aGiKaURStA=;
        b=os7qhPMUE1ADTmzoX0+j9SIFNJ5f5KbMrql99DmP8DllXSZAZIQhNXqkHAT4erMXhy
         ZrP0P/RAskfgjDypU3ei6lIA+xK9x4keE1rpbXFwRFVm4f8AkNyf4pHNz8uxOMgK2iSw
         RZfskFnostVxr3E7B9eT6PH2/Q6L22JEuIILj6GLMsup5FcwqnPE++GHSddRjqk8tFWg
         vksQaPeHVGYzOGGHDypowhlWuK5ct2n+XiMnSc929jOC2f9mAAizzsNdLU8dOBVPK3wA
         LlARV9yybcp4UtDUbNkh1OucPU4ap2eYh/tacI0169JA6y31a9S5uOCWcxM8c5/H5hGS
         gFFg==
X-Forwarded-Encrypted: i=1; AJvYcCUkTABHrXc1MWJH4PxdYq+TnZphdDLDI4ZkKKXyldIhIZcctWo7nSygVccVn4u1bLKgfpOwEtLwH4aFR1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2HRJ0aEWk5YppXEbXu+NdWB2znragQBWkMrvU2gIs6UXvl8Dc
	R9B1mbN5sQF1qVtqoaMLqUafTNwNpryEsTffKqt53WY6ReEjq+ELzOi2
X-Gm-Gg: ASbGnctj250yewl4V+2/pLtn4GN3R9PiROX+JKlq9H+K7i7GHKu7qVbVzjTkIPURMp1
	zIJT4tE7Act40It9MkdP1dn85lvRbdj16SQ5co+/isWjJCb972nkpQTRTug/h1NuW42ulVUP1d5
	Dhdhz1jZ4mAwX9DzDl0bZ38Ixfoqy8eUbILAQAeNZ6MCTI8WN0nmA5Ae4uQwRUcbrrn3r9CZDj1
	U6XjaM1i+vFSCWIkcXiknIQeLrYL8pgcMNmyAoRK6WiY74T65CYdW6hvhrTx/Njcspcik45l4wZ
	0AmlXW5+fiEUyxSW6ZPX8XrCchKUq8lv6vQTicxvSVgYgwrHSvitc6pSTTVzgPUR4xvSHVMa6wG
	T6DMVVldK91cEn7EhKyCZsfmfrlpY6mGYyxA=
X-Google-Smtp-Source: AGHT+IGKNEJ/R5tUjNTzQr8LYnYikZE7FzqSywVlP1BdDD46LFzgEzFplMLIppxM3bMlh8TiM4vnUA==
X-Received: by 2002:a17:907:868b:b0:b3e:babd:f257 with SMTP id a640c23a62f3a-b50aa49207amr2854806566b.10.1760433496877;
        Tue, 14 Oct 2025 02:18:16 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d900e432sm1081271566b.65.2025.10.14.02.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:18:16 -0700 (PDT)
Date: Tue, 14 Oct 2025 02:18:14 -0700
From: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net] netdevsim: set the carrier when the device goes up
Message-ID: <ha53dregkpznr6qeym7v65zcyl27u4oe6cwqtcyrxbmz2i7o5u@2gbcfwb42az6>
References: <20251013-netdevsim_fix-v1-1-357b265dd9d0@debian.org>
 <7e1d28c0-7276-448f-8d01-531b7e8bd195@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e1d28c0-7276-448f-8d01-531b7e8bd195@lunn.ch>

Hello Andrew,

On Mon, Oct 13, 2025 at 07:25:27PM +0200, Andrew Lunn wrote:
> On Mon, Oct 13, 2025 at 10:09:22AM -0700, Breno Leitao wrote:
> > Bringing a linked netdevsim device down and then up causes communication
> > failure because both interfaces lack carrier. Basically a ifdown/ifup on
> > the interface make the link broken.
> > 
> > When a device is brought up, if it has a peer and this peer device is
> > UP, set both carriers to on.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Fixes: 3762ec05a9fbda ("netdevsim: add NAPI support")
> 
> It was not obvious what adding NAPI has to do with carrier status.  I
> had to go look at 3762ec05a9fbda to see that that was when nsim_stop()
> started to change the carrier on stop. This patch makes nsim_open()
> somewhat symmetrical. If you need a respin, maybe expand the commit
> message to explain this.

Thanks for the review. I've sent a v2 with the updated message, given it
adds clarity to the change.

--breno

