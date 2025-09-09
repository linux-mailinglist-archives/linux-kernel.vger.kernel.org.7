Return-Path: <linux-kernel+bounces-808558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD12B50184
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A2687AB3AD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0422926E179;
	Tue,  9 Sep 2025 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YhT1NqWn"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C072673BA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431898; cv=none; b=jzRq62TMDlaGth6hcic9n6USDjmyJXC6XhC+6vCaWIOvU6mqoJe4D/SC25vBqzmeuXhROSnk1qCMTylon4vIphbUg2Efy1TCzF1dP8EBfIpoq6h4ttAxTmUesVRUkBPwUNHg9rJoJkKupfYryEgcikKVxwkXWqSYEHSkqhSNs9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431898; c=relaxed/simple;
	bh=ZiFhYdl2bjOWEjo1NqUMAnXwgT2PaGixslQiYutgRy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn1pCEaYwfXDhx54RCsnLvKuJM5SEHYlsNIEmnorkL/e8NCs1MfOWJ4GzT4SbVIxGfrPTmQqw2XgtlFkkwnRHyIdtqew1bvzBo6FJb86pkZEX7wvG7pCUvtCcQ3iMy+6rjVr/ycJjO477fKbO9dhQC8XiaFr2t+werR2YLU9zvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YhT1NqWn; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b38d4de61aso76512241cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757431895; x=1758036695; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=498dEo+KF6gTc379XcLxpYOuwK2LCxMHvU+qZ/OXUfM=;
        b=YhT1NqWno+hgmBaBASpVCoyWjg2pvukMr8WzMjOQpwMofq8SZBnKETFAyBi8f6wDdA
         RqVQ43oqY0ylrBg7Fq/2m1eAplq069JCVIQYBPcXqSOvOwqstPdD4lEyKhxfISghJuov
         aAHdtVN8GL7m0xIZ+hGPT7VwHhdZJPW4/cXQXTOP8cGagfQ984mCxa5oXa5egzjUCiLA
         fCDZ1lAYhJPWIk8L8UXnPSzG1XkZ4/1J1o+Uxl+cYj6aoTgHBNfd8yNDm3j4ppbpo1Y+
         Qu2O8tuQAkHNXI0gFF2iE/6qkrkAP0SoqUdF5bx6M5AfNJcL9NAV1oeT3tHtkAE9awFm
         xWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757431895; x=1758036695;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=498dEo+KF6gTc379XcLxpYOuwK2LCxMHvU+qZ/OXUfM=;
        b=jgUsJ/cmV8jfnZSKCicmg43Wo1ANF9sZef+IKZyy2+Tn1q6YaBSGdljfenRIonwyyP
         BFmTsaIL2O58UM9BoFhVz80QbHFG9enL8fnaMDwskA4Irj5q+PP5mciVkQ1AGLIGShCJ
         U4RXam1PGJjy4V+NmCqd4DlOBpnD9IT7GXJ4KKI0AmIVkCzTj4PmxfXhVrSb2tFvEw4f
         IoJuKrZiGPZCHpUgom7bSUOargXU6+Pa3d1phHqJATlQg9nt7TnxA3MG+AJ1G53pqqEL
         tqyWMVGrn3qc2yImgZ0BvxL106NmHz3lw0Z/OUQmKKKnS42bFDexC4yUTJeA4UxGx2Cb
         gURA==
X-Forwarded-Encrypted: i=1; AJvYcCXJBI0chmxDd79bb8KV6bEIEfnnnUapSdt1YScCk731pYie8gONMsEmLxYQf2FL2dFdyFjdPpFpv8T6XQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1rPZikagQ2g0aPsJBTorB1MDagsD/vlpVhZ9Il8SUOi8+yD8q
	RgICHD+tuCy4UTF39IRKFw8At/W2vxMQcd97AqIJmO7L9N4Vrl4WMSBMqT2VM7xfgVCmiHaNNO9
	uAzMI
X-Gm-Gg: ASbGncuAO0pFF7ZvLczFo6iEnw2+C8II0f0REKv8xM7LxxWg6TyGIt1oHFVLlUP4+39
	/dH8SPcsHiuw2ezN4iuR6piYgWTyCO+aCNs0gG8dgpaLyNVjt+5nXUNXNqp6JTa7J0r+4GsYOti
	gl+YfAbFRLaBnCxiBeeICUrGZ8Wp9y3Wln6dQxZTanrkY8c/mJcDZioyeToZiLWWkO5nNiduh1Q
	u79MX/4+9s6i6OLC8qRfDYfoVQGGV7NXSKkRMteWfgU9ivwLRb6766P+43IVEgkIThud6iLgdAm
	0/tA2FtOowJVYBRrFtj6/FgyiLknflCMRwgCWk3Ie7UxXhVMRDyLo8t1xJlgXvgJ3HUedjlVfSx
	DM2kfF7Hu95FBgBQgMLoFD/3pC66EpTq7E/aRP0Uom+qk0wc5iCwYYKqt1wJ1Ny9MogDK
X-Google-Smtp-Source: AGHT+IH7K1XIyNvmlwRcafXwBvIsTn6HhCOCwW9mXvrQDKTlxF6E0GAU/aFQzWje+0RX4kjUPitS3g==
X-Received: by 2002:a05:622a:5796:b0:4b2:ecfd:be0d with SMTP id d75a77b69052e-4b5f84b6e2emr137778461cf.81.1757431895263;
        Tue, 09 Sep 2025 08:31:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b61ba8c52dsm10541271cf.20.2025.09.09.08.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:31:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uw0Jh-00000003i1N-3Pgp;
	Tue, 09 Sep 2025 12:31:33 -0300
Date: Tue, 9 Sep 2025 12:31:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Leon Romanovsky <leon@kernel.org>, Zhu Yanjun <yanjun.zhu@linux.dev>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] rdma_rxe: call comp_handler without holding
 cq->cq_lock
Message-ID: <20250909153133.GA882933@ziepe.ca>
References: <20250822081941.989520-1-philipp.reisner@linbit.com>
 <20250908142457.GA341237@unreal>
 <CADGDV=XNrmNo5gNZ1cX4eGUi+0xgAcQzra+pNHNGuQbc0DrpKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADGDV=XNrmNo5gNZ1cX4eGUi+0xgAcQzra+pNHNGuQbc0DrpKA@mail.gmail.com>

On Tue, Sep 09, 2025 at 04:48:19PM +0200, Philipp Reisner wrote:
> On Mon, Sep 8, 2025 at 4:25 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Fri, Aug 22, 2025 at 10:19:41AM +0200, Philipp Reisner wrote:
> > > Allow the comp_handler callback implementation to call ib_poll_cq().
> > > A call to ib_poll_cq() calls rxe_poll_cq() with the rdma_rxe driver.
> > > And rxe_poll_cq() locks cq->cq_lock. That leads to a spinlock deadlock.
> >
> > Can you please be more specific about the deadlock?
> > Please write call stack to describe it.
> >
> Instead of a call stack, I write it from top to bottom:
> 
> The line numbers in the .c files are valid for Linux-6.16:
> 
> 1  rxe_cq_post()                      [rxe_cq.c:85]
> 2   spin_lock_irqsave()               [rxe_cq.c:93]
> 3   cq->ibcq.comp_handler()           [rxe_cq.c:116]
> 4    some_comp_handler()
> 5     ib_poll_cq()
> 6      cq->device->ops.poll_cq()      [ib_verbs.h:4037]
> 7       rxe_poll_cq()                 [rxe_verbs.c:1165]
> 8        spin_lock_irqsave()          [rxe_verbs.c:1172]
> 
> In line 8 of this call graph, it deadlocks because the spinlock
> was already acquired in line 2 of the call graph.

Is this even legal in verbs? I'm not sure you can do pull cq from a
interrupt driven comp handler.. Is something already doing this intree?

Jason

