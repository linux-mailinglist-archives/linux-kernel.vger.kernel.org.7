Return-Path: <linux-kernel+bounces-732450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EB0B066B2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 21:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DB7C7ACDB5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 19:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FCD2C033C;
	Tue, 15 Jul 2025 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="k4G5FLYV"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2E326C398
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 19:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606994; cv=none; b=LzCw/+Z1GStNusidMmKsa1vJvkSCtVSQmRjMAs1X+QCWZfqCCwfl1Apy9e8b47AL37ooPjmQNkax7ck/stUVN7TABIfCF2XtyOyso4Hp0J3AazyYWZLRDlCcAT4GYLswits0lYM8Pzm9j41b0ZWIvon7DXSHf0JWgr8n+9R5C1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606994; c=relaxed/simple;
	bh=jmEenBBnJcPJ6JLSnRvcrVhxo7jKKE5kjzYF95A58vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jg9HeZ0FUuI+e2aC3wh+hjDSp5Lqux4n7TzZIhVNCacsh3o5O7QY+bVzb125cPX6SjdZee/60t5abHUK/yA2gwmGIctaVtxUnTI8jh19tuYx546PsgyNtKh+ZEfOUgv2l3cAz2pEXEgctn7MMNVGyYr1QEl//Dll/mGd6HRmdEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=k4G5FLYV; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab644b8dc1so31818891cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752606992; x=1753211792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EyWMZNHH8t0HhJoB77UysafRoavoppKyzNMNzqOvChI=;
        b=k4G5FLYV7bs+tpC6ndMGLj+mSrqSyctAEH6RaNim3NJmvSrUn1EkTS+66geC66nhEo
         Qn84B9GfGOEWIxCOZnEi3wOd7lvDia3j5JlI6OWnPP1XN8Ui37F5AvjflaGrBXSRbM2J
         1pYiUQ7MEceodNTVBmh49Qq5/cOCpj0cwQzA9PIWSrRNzguRvVg4pOlgv2RM30vQWust
         xbNJnozB6gcZvjcimiGFgDLBc3I4ItzmlIIlxth7TSTr8yg2kczFtH3mxucAUJzEenBr
         k5Kjw7tlIPUTuolUm+PfsulCMxyeLgquZAQCnPfpgosDncccyVoaNPu++IQTzQtflme0
         dkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752606992; x=1753211792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyWMZNHH8t0HhJoB77UysafRoavoppKyzNMNzqOvChI=;
        b=c/Cgi63IYFMY/bxbnFfOXZoYO3SgVihfNb0g/bcDqD9BAZxxLElXzuyo94x1ZzC0sr
         OpKxjiU4gMKD8POzEKjb0BzF9me8au4bTLnaA1MYrVPC7jgDcV9CWLP0WsMZrdrujITh
         4z0brpH6bEnPAS1wbEozffDBD5e6G+ClUiokvzObMZhk+4FmiEDdJg4SB2Q8E1Vp3zK0
         7F7IGhlEIFs0UMC0lAEG59dL5tuusne//Hx90GxQOv0rc1KUIHaXbe992Mdfwp3J+pq+
         ygTvRirknW+2XmYOpE56wS/1Xo82Ea2otCSYw4FcXoAArLia8wO0AfD1WuFTAPNYk9Mk
         5maw==
X-Forwarded-Encrypted: i=1; AJvYcCWevt+aWRigKWtz9KsH7LAs6cDqwVdD8sIKWhPaDB1bxh6tb4Q1SZLhxtuvuZ7+rR4kE3QEPMuAHH+6Jy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVTN2wp6AhkKO2CvvaaASBKdjqKBtQN5hHQtrahmbsmAJEy7n0
	/r70tyjerYRbKMs5XTgQPAfAmYEEVPYvj7X8VU6FzWVwgL2zMGyHMNgv+ixMdrUdSIo=
X-Gm-Gg: ASbGncv2KnbLvfzvvXOvYaMdcII0LtLTvwHw43rtaQ0hzjiZZKnHWgjT/MM3jfc4oxb
	8n1Uj1wdL75B6QrUzredZVa1io69ysns1gGLnk2bC/o496saAghbZdd3AbMGcHeTlrsR5c+tT/K
	YPcxu9Ydn490DjzW2beI35K5pX1jVuShqbUG2CAadH/m38eDa3W1yOw2/FXLbj78gNogM5F8NJj
	jBN5+tly2YiNxu3jppK5Eskzkg0R0tt+MWDo4dGgUDCSKQvj8OMpPsvvo6bi5nsh0iyZcpmpjLV
	jBJkIIQXlF+J9Fee/Mzr0+JzgbHtYLLCYqE6MTROYC3gnVTcQGGiXfSTN9LKQJ8U83oStbaiuyi
	dEgDKWLFwCRn9F79Tms6dngK6gGD3X0SWNJT3BXYHGStFs4+Yk3c3dJyjM8FYYN0MX9YsiwxY6w
	==
X-Google-Smtp-Source: AGHT+IFNu6OS2CHvkVX/AFP0Ggu6QTgX/HryXXNt8GtSiABsUgLTgba9EtOOht2y1gHxuQnp05k70A==
X-Received: by 2002:ac8:5acc:0:b0:4a6:f9b0:2093 with SMTP id d75a77b69052e-4ab90cf6cfamr9216651cf.46.1752606991715;
        Tue, 15 Jul 2025 12:16:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edc593edsm64349751cf.21.2025.07.15.12.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 12:16:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ubl8f-00000008tB4-2UzY;
	Tue, 15 Jul 2025 16:16:29 -0300
Date: Tue, 15 Jul 2025 16:16:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>, shannon.nelson@amd.com,
	brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	andrew+netdev@lunn.ch, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Boyer <andrew.boyer@amd.com>
Subject: Re: [PATCH v3 10/14] RDMA/ionic: Register device ops for control path
Message-ID: <20250715191629.GA2116306@ziepe.ca>
References: <20250702131803.GB904431@ziepe.ca>
 <20250702180007.GK6278@unreal>
 <bb0ac425-2f01-b8c7-2fd7-4ecf9e9ef8b1@amd.com>
 <20250704170807.GO6278@unreal>
 <15b773a4-424b-4aa9-2aa4-457fbbee8ec7@amd.com>
 <20250707072137.GU6278@unreal>
 <1a7190d4-f3ef-744c-4e46-8cb255dee6cf@amd.com>
 <20250707164609.GA592765@unreal>
 <76a68f62-1f73-cc81-0f5b-48a6982a54c7@amd.com>
 <20250713062753.GA5882@unreal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713062753.GA5882@unreal>

On Sun, Jul 13, 2025 at 09:27:53AM +0300, Leon Romanovsky wrote:
> Let's do what all other drivers do, please. I prefer simplest solution
> and objects that can potentially be around after verbs objects were
> cleaned doesn't sound right.

I think it is OK, at least QP makes sense and matches some other
drivers.

+static void ionic_qp_event(struct ionic_ibdev *dev, u32 qpid, u8 code)
+{
+       struct ib_event ibev;
+       struct ionic_qp *qp;
+
+       rcu_read_lock();
+       qp = xa_load(&dev->qp_tbl, qpid);
+       if (qp)
+               kref_get(&qp->qp_kref);
+       rcu_read_unlock();
+

The above is an async event path, and the kref is effectively the open
coded rwlock pattern we use often.

The unlock triggers a completion:

+       kref_put(&qp->qp_kref, ionic_qp_complete);
+static inline void ionic_qp_complete(struct kref *kref)
+{
+       struct ionic_qp *qp = container_of(kref, struct ionic_qp, qp_kref);
+       
+       complete(&qp->qp_rel_comp);
+}

Which acts as the unlock. And then qp destruction:

+int ionic_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
+{
+       kref_put(&qp->qp_kref, ionic_qp_complete);
+       wait_for_completion(&qp->qp_rel_comp);

Which is the typical "write" side of the lock.

So this is all normal, the qp doesn't outlive destroy, destroy waits
for all the async event deliver to complete. It has to, we free the
underlying memory in the core code.

As long as the other case are like this it is fine

+       xa_erase_irq(&dev->qp_tbl, qp->qpid);
+       synchronize_rcu();

This should go away though, don't like to see synchronize_rcu(). The
idea is you kfree the QP with RCU. But the core code doesn't do that..

So in the short term you should take the lock instead of using rcu:

       xa_lock(&dev->qp_tbl);
       qp = xa_load(&dev->qp_tbl, qpid);
       if (qp)
               kref_get(&qp->qp_kref);

Jason

