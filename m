Return-Path: <linux-kernel+bounces-823253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAC0B85E70
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B19857BB9F5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626D6314D16;
	Thu, 18 Sep 2025 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPz0rlXW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486F02F8BF4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211697; cv=none; b=eWnRzitKrZLdzTf0keiP9LaMh5I/uOEPnMRMkpiP6txHAoEpaC3bwTNsEiLou+gUknjUu8XxYoE8yoT84r0Gu3l2U/P9Ll8KE37Ia2x2Mt1FE/yj6LP7tHr8jCv0glEAscm2865/sm5Gl1TwMFmtk/6JppOeSOMZcxbi98HuvxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211697; c=relaxed/simple;
	bh=JL/qBQ0n0kWZf+AaO8KDJFGjeMqMIUgMtsxBe3k+j+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMWZKmfvyxmiKzEh8ZzdxZTLZ35Kxd7Yr9vQR06XuhNkNLuG/RmT5LkNgrfvYudyZAMlbleJKmuNOCRwbmTSPZmzvbMTDPXvBdcpYHLEN9hHnH1vGZLw0qCeQ3zVFncOPmj/rbwOndFMDM53qxH7miv8X/3EMWEwxwLzJrnSdug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GPz0rlXW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758211695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q3W1jIekrmUS7hGw0PvTqPX4tAe8HmRxhRJM5xSdG6I=;
	b=GPz0rlXWlk1dj//3hCo0FvDp1STSztDzzJFpHem4HP9XKZyaYJHSVTxjg7s3ut3wjVTTK4
	vf/3joggMiFDcQZC3USL3APJPF/stHroNkmmQJAC2O4RUmZKKEXo/iWaNRyNqeDvQFHuqp
	7dreYp0l/FGDyLc464w/Pye3BQBKMwk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-1pmKKUsiOGegz0Jub9I7XA-1; Thu, 18 Sep 2025 12:08:13 -0400
X-MC-Unique: 1pmKKUsiOGegz0Jub9I7XA-1
X-Mimecast-MFC-AGG-ID: 1pmKKUsiOGegz0Jub9I7XA_1758211692
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee130237e1so342601f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758211692; x=1758816492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3W1jIekrmUS7hGw0PvTqPX4tAe8HmRxhRJM5xSdG6I=;
        b=gtUqRhxzVbby8RYUyM6RIpRbF+M5qQleVaDCaVfnK1omlS169fjiPyosU/uF8iVeJj
         i2cXiepI54LaJfTNB1ZU+MNmmGskQE2yOsuwadCdX2HuOF7SMTN++h6IuZNsMSRhBSPL
         JFNBs/L1DnL9vLbwEeXgOK1MrFws2FyjOxS6USH+VuJBdQiFGHdr3hL7jFg4Rk8wIzEw
         /bwdezpyf2VT1s9G6gtt7F+1JZO0lsq46ufULC9I8sP9TDcMupQwTz81mUCnLdGj8dbD
         Mi3DgrivyHh2iOCX9zKMaeDN/yC8W67IB7tZboQGxGVD0DHNUkyisuk2sWY9o9uEVecc
         Qaug==
X-Forwarded-Encrypted: i=1; AJvYcCUwU+SfHN2nGcnPUq4C5t/qA7WIFauFPRGLIbdAzA8AXyvFTBMGkVse+mqyHJyUKzA69NHb2bz6dOjGtK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuYMvqpPqi+P/AWl6MDMUo77I0ApBO4FV14Z/L1jI4nDX5F5S+
	TzZRDnuyVnaDAC0AGzQraMLUI7KBBxsOL61EnU5dxImqysroZsYKw9WmFJjAokg73LD3BeZToQX
	Wh83ZOaZneRnJRq7izl6sy5H48e3CT0ObXD5id9CQ+DRRam3oPD9worlUyupWqMy6gw==
X-Gm-Gg: ASbGnct9paPCXACxd1GQwoGNWulZDbe8sI4HrowHdqjOkM6vqkW8+pzyMrAfcE8wJ2u
	1zLr+89gKsS2ZR6Rn5aeEiGmVB3tt9496LAEfSWi6FwzC2OyEmdAdu33bRhbxinOiiA645bxWID
	SRPKmgyhqWsE0/JYb/0CsuXm9wHYyqPdAK9wcAr1B4FNxzTrnwI5yyZHYnVc2x3cCMDSKItuhYe
	n6o9D3KqjinT6eE2QJi2o2vZNVgg85OOyrImbGMZuOOdNOOwmM2ycvtaKXm5wDvlR1uGcevacYR
	o37mJvSlJQcPpqGZKjo0P5/LlTz4V7HHpyc=
X-Received: by 2002:a05:6000:200e:b0:3eb:f90a:f6cd with SMTP id ffacd0b85a97d-3ecdfa3ce7emr7085261f8f.60.1758211692371;
        Thu, 18 Sep 2025 09:08:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFONswKfp43OXLfg7nMNxh+zteAfi3TDzbvWnbk+eZ4aXLcjPUcMbF4AA2QkD6aFfodROyxZA==
X-Received: by 2002:a05:6000:200e:b0:3eb:f90a:f6cd with SMTP id ffacd0b85a97d-3ecdfa3ce7emr7085210f8f.60.1758211691864;
        Thu, 18 Sep 2025 09:08:11 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee106fd0edsm3919680f8f.53.2025.09.18.09.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:08:11 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:08:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited
 task
Message-ID: <20250918120658-mutt-send-email-mst@kernel.org>
References: <20250827194107.4142164-1-seanjc@google.com>
 <20250827201059.EmmdDFB_@linutronix.de>
 <20250918110828-mutt-send-email-mst@kernel.org>
 <20250918154826.oUc0cW0Y@linutronix.de>
 <aMwtd40q44q5uqwr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMwtd40q44q5uqwr@google.com>

On Thu, Sep 18, 2025 at 09:04:07AM -0700, Sean Christopherson wrote:
> On Thu, Sep 18, 2025, Sebastian Andrzej Siewior wrote:
> > On 2025-09-18 11:09:05 [-0400], Michael S. Tsirkin wrote:
> > > So how about switching to this approach then?
> > > Instead of piling up fixes like we seem to do now ...
> 
> I don't have a strong preference for 6.17, beyond landing a fix of some kind.
> I think there are three options for 6.17, in order of "least like to break
> something":
> 
>  1. Sebastian's get_task_struct() fix


I am just a bit apprehensive that we don't create a situation
where we leak the task struct somehow, given the limited
testing time. Can you help me get convinced that risk is 0?

>  2. This series, without the KILLED sanity check in __vhost_task_wake()
>  3. This series, with my fixup (with which syzbot was happy)
> 
> Longer term, I'd still like to land everything though.

No problem with that.

> > > Sean?
> > 
> > Since I am in To: here. You want me to resent my diff as a proper patch?
> 
> Ya, I think it makes sense to harden against UAF even if we fix the KVM bug more
> directly.


