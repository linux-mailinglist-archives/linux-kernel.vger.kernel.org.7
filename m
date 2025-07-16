Return-Path: <linux-kernel+bounces-733543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA28B075FA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF6E16C41D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B602F531B;
	Wed, 16 Jul 2025 12:43:56 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A332F5318
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669835; cv=none; b=lGOXqI3pyQCflN4M9j9lSqOHHEb0ArQ5OG89A01Ylt+w8fVdBjWtgtDDRSyQb6RDxzKYWYFuKWUXKPns/tFxmwpoJOT3nQ1SwoULUnTK0sM1iWG7TfwsGM0Eg1XPQO1Nntbn9u91nINLXVbEzTkIZCZbaqfzgeRZ+ZqiVBTBA/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669835; c=relaxed/simple;
	bh=3V2vrjDDmdtVGky/E/b5pBppQDkqUTC44cZX8IEhM90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cG/icei222Wk8gJuBoOQaVnVDGUIHup2lGYQJuuQaJ7hH+2/QTIdvR5NUVgf8UE8E2UPKySiAM3AXOcef9FJcCD18ge6ZK24FAIWDnkH7ebxOp65pzsAPbJFB5SUYmkQNiqGLEaEMcMB4obMCKCGPQ2f2OjMKd1WSmBh47pajko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0dad3a179so1096371666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669832; x=1753274632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luvzlRgx0r28KvN0q8WXZ/8hKbFhIo8ahWW92QmT+Tk=;
        b=aLtfBfO62t+wQGsSj7GaKlkWVr49uKuZCAtusyRWVibEN02YPP+PXtl6koMJDS2ZiS
         C61T5KSjeax7kHI6VuICIadSbJ/aZEP4K3ffMbvo9wJFp/wALJfUdzofPwsbyKN0hZrJ
         5CqA1B3Zc39WOxwPK39fJ1qnKxjch27y9K1zAA/7/XG54/Yqc3Vwv/6bWigZsye0BxAx
         pbuq64CscdZY9t22rTgPHk1PcFAaTR4z8MAbiE3zLLYNFg3PAF8YajiVSx9t6K/tSvLU
         1nSdbGLjiPgrdFAbeF4ybQwT4OrCA2D4xXCcauFdMzESFCqkQUsgfABHxT4GRN7Lg7Rr
         9V/A==
X-Forwarded-Encrypted: i=1; AJvYcCUS3W3yqWMmySwwzYbSjWARtj4heEDvJiYjcCtweqyjnF0u7WC/nF4BztSqvrPieDWw/Ag3CkZtSlARbcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVgjU81YXYKrkxph667z5J+aL45tqkvnPo38F+B6CVIjV//3b+
	yYUmiwvQEOUH271jLTbnr/EPCX+UBOuvXpsIU2KXa/e6Jo8PToZaoJSO
X-Gm-Gg: ASbGnctYp6ajx8/87HzQ5Wr10Flr7KiISvzViroTcT0aVllLiLDQxlCWtceMKFzPdkC
	zqDDhkRQEwf8cfEnVV24DROuOVh1ZsvWXlc1a7jNMi9CNvnQbZI75GMbeHA7D8H1LOJ6wNXbDzT
	VVbJQNXLjMIGa2QT/KgERpM8LI4XQVm2RfVUS6fleLwIzixtjtGV/Ox4JA1rTe55/lBBunVOZ1s
	DNicaGOrhimluCesFYYw1Fs/onIazKBPh3IUbBa6xZKuiXRDPj9r3U/GWWvUSO3eEfPj+kW4BGL
	imFLPebPKQWoKIxy7bjsx5cP2dI/kSwQ5xlRMJWdubJ1h/rnbZOYAKJRT0kY08kHbrAGuIU+13r
	rywsqO3HCHhV87edH2PzTMvKw
X-Google-Smtp-Source: AGHT+IGSndK0JANwbPvfBAJmo/K75O4OeQOvOz59+72pn8Xy8XoJF0wtw9+awJW6p3QO48tnSFu0pg==
X-Received: by 2002:a17:907:7244:b0:ae3:8c9b:bd61 with SMTP id a640c23a62f3a-ae9c99568d0mr335348266b.12.1752669832226;
        Wed, 16 Jul 2025 05:43:52 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:7d::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e90c1dsm1185892866b.4.2025.07.16.05.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:43:51 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:43:49 -0700
From: Breno Leitao <leitao@debian.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Track currently locked rq
Message-ID: <f7u4e6bc6anj5nnphkxszmynk2yrrbs6hvpje4gzxwc56a73pq@jlf3dfza7nmm>
References: <20250422082907.110167-1-arighi@nvidia.com>
 <20250422082907.110167-2-arighi@nvidia.com>
 <xy47uzzirvauag3otkqhhhzwyhlpnnmeh3s77i2snmtoub3jhl@ywoeaxl3iq3x>
 <aHaN3FqRG6gXNwbv@gpd4>
 <qxulb3ckm256bltfep45iac3vifv342o24654ulh4zt6shvg5j@grp7crx56rk3>
 <aHedrl4G5DecVzpS@gpd4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHedrl4G5DecVzpS@gpd4>

On Wed, Jul 16, 2025 at 02:40:14PM +0200, Andrea Righi wrote:
> Hi Breno,
> 
> On Wed, Jul 16, 2025 at 03:47:38AM -0700, Breno Leitao wrote:
> > Hello Andrea,
> > 
> > On Tue, Jul 15, 2025 at 07:20:28PM +0200, Andrea Righi wrote:
> > > > On Tue, Apr 22, 2025 at 10:26:32AM +0200, Andrea Righi wrote:
> > 
> > > > 
> > > > > +		lockdep_assert_rq_held(rq);
> > > > > +	__this_cpu_write(locked_rq, rq);
> > > > 
> > > > This is hitting the following BUG() on some of my debug kernels:
> > > > 
> > > > 	BUG: using __this_cpu_write() in preemptible [00000000] code: scx_layered_6-9/68770
> > > > 
> > > > I have lockdep enabled, and I don't see the assert above. I am wondering
> > > > if rq is locked but preemption continues to be enabled (!?)
> > > 
> > > Interesting. And it makes sense, because we may have callbacks called from
> > > a preemptible context (especially when rq == NULL).
> > > 
> > > I think we can just put a preempt_disable() / preempt_enable() around
> > > __this_cpu_write(). If we jump to another CPU during the callback it's
> > > fine, since we would track the rq state on the other CPU with its own local
> > > variable. And if we were able to jump there, it means that preemption was
> > > disabled as well.
> > 
> > First of all thanks for the suggestion!
> > 
> > What about a patch like the following:
> 
> Looks good to me, feel free to add my:
> 
> Acked-by: Andrea Righi <arighi@nvidia.com>
 
Thanks. I will send it to the mailing list them.
--breno

