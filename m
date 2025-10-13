Return-Path: <linux-kernel+bounces-850122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B98EBD1EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C67E1898D23
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A21B2EC0BF;
	Mon, 13 Oct 2025 08:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ai7bVnS5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3262EACF0
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342930; cv=none; b=XZHW+vklxzz99xxKF6nkTRGFS8MzBAhFL+ZsYT/xkVFIYMKwVkv0vDkh9XZr1YW15T/oTf7pCRkOI8/IjgFl4Garf68v+15T6xcYLMROoD02fBdJMds1PjeEGbPvRNAnB2xyLOwGxGaQGyiLg1AoYF+LW3xZzYbsOcm7y8AMLvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342930; c=relaxed/simple;
	bh=vVOvsg1+Ti0HxFSL4nhVXqF1CMG723QAbuq/zowP2JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXS5E7olzssmgbIqigFYgUjaeoSv1aZMvOp+meEmTtOPuc3zBNtSymvDK7InWE8dQyVaEMkCoME7ScL7cARVv8VqhYXClBZDfHlXhPeEuQmtrxitRUgO3RMyqUxhiCvQ+D9VtEbHXZuJwdHy1b/lsWBTM1+DaZBSL4HanlleTm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ai7bVnS5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760342927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7eWL4DN3XThSL1fpZ1rH690hipW9N7vRijRVW6Y3Oig=;
	b=Ai7bVnS5979auM0KTkYoW3Vr6MrmH9BbMgMlR434DhFz/JtLPl7jjA/UXBTw+PXnuI+m6f
	geeJILUEdSowUYRjXPd46otAW7NPLa6zXc3KfG9N5smGu4RxDDUMysK3A70KDBHyxiPrgq
	HcIRS4hO+w2WI9Mq8Cy6aKAatVTCpis=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-Ccd1edoUP4K-MZi25SL0wQ-1; Mon, 13 Oct 2025 04:08:45 -0400
X-MC-Unique: Ccd1edoUP4K-MZi25SL0wQ-1
X-Mimecast-MFC-AGG-ID: Ccd1edoUP4K-MZi25SL0wQ_1760342925
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ece14b9231so3454316f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760342925; x=1760947725;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eWL4DN3XThSL1fpZ1rH690hipW9N7vRijRVW6Y3Oig=;
        b=JACsdlrgP6nn1/x1FsYhCKGlnAATDJCpntD74Md/dNwb4PNg2HXOqB8j6+DOxk5X/M
         7JxiYwdii/0LUV97UasE1NvbZyqcwwEZitk7aKIwqVM4rUcXjs1NC2cBMzY71uDwvXBu
         kgJnf9FyWcnn2UGToCbXNAB0Sq9l5q2FxWdvy7Ryyq+rNx/FEza5TsF/RME7ThMYlV9h
         pTQTuJiP5zxSASwsP1yjsQU8UBf0Hsr4AeMmoRcyhvNUtKkmsiW+0uTb9mBmudOwIxcG
         daLwpK/UN6Kncu+AK4BVILCOeQrVganVRR1LQdOPbHIQAQ7/LxDvnIpmKc61nsjgTVnj
         D4Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXDokesMjjqZ7CHhJD9WYMJ4rBe9hmaz7XxNw3wWWqTY2LnbJsVjtiKXYdMHW/+D8dCFU+xVrRyncPGucc=@vger.kernel.org
X-Gm-Message-State: AOJu0YytVhePWPvil4DysH0/tkJZCNzDjj+DeBcrNyJRYOT3lDM1zvL4
	YmTQd6cmljKd4yfRJoPPrYQU+kqxGnpGfEhCW5Z+5UfRQ3I4ZBGdg0hIeSTig5ist5FOFO6Pja2
	PAUuNsQ9x/LYIH9dSeDsZoNFRCoMHjNw5pHGqjluWCNOipTuLhYL7R75EBU6sBQKpqA==
X-Gm-Gg: ASbGncuErwsKPlaDEDDQLrwqnmm8xtv1QOOljd/9+PSfWLU6/ihzXKGusFgSo8SP1bV
	8dfWcMoCkKb6bOK1Fou2K5ZAzOKqB3ljRd1NL9bvfEMOcaZIJ+jPUq/+C9cjDeiMvkQBLVKcyUz
	cAsGVgBMGfc5SlV21pYrF6mch1g2yab1tr6j73HYbhGMbxMoR+qYk9L+3Gy5xRTTIjbyYQYmkX7
	SiwhyOrTgBWI8CDl8FJpGYypkf0H3ESwvu0hVMlqinxRgk1Vlj7UJ1RCeUaAJda6k/1zF/4huCj
	m0LKq8ucznqcsM3otRf0MzYUIixcoA==
X-Received: by 2002:a5d:5f86:0:b0:426:d5de:e454 with SMTP id ffacd0b85a97d-426d5dee4d1mr4608121f8f.31.1760342924566;
        Mon, 13 Oct 2025 01:08:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtNpEAunbxp8ulrBXh0wStzwV4F/kXgVIxSO9DL5r5BrnXcg7l1GKUUVmPOZKzozmdGRj6yA==
X-Received: by 2002:a5d:5f86:0:b0:426:d5de:e454 with SMTP id ffacd0b85a97d-426d5dee4d1mr4608094f8f.31.1760342924147;
        Mon, 13 Oct 2025 01:08:44 -0700 (PDT)
Received: from redhat.com ([31.187.78.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57cce5sm17291452f8f.1.2025.10.13.01.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 01:08:43 -0700 (PDT)
Date: Mon, 13 Oct 2025 04:08:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	syzbot <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com>,
	eperezma@redhat.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [syzbot] [virt?] upstream test error: KMSAN: use-after-free in
 vring_map_one_sg
Message-ID: <20251013040810-mutt-send-email-mst@kernel.org>
References: <68e96ebf.050a0220.91a22.0177.GAE@google.com>
 <CACGkMEtnrayDWKFdJ1P22QyCrZuDK0C2LihhOtvhUyTOKSp_HQ@mail.gmail.com>
 <CACGkMEt0aJh1yAj+q1UNnXToLa_yGc9fT_HfeNptHsOQ7vXG+w@mail.gmail.com>
 <CACGkMEsh_j9wCAv-LwOVxLjvUzEuKuu+7ZGMGcdJr7ettdBYTQ@mail.gmail.com>
 <0f20cd6a-d9aa-4837-a120-1e2e7dbdc954@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f20cd6a-d9aa-4837-a120-1e2e7dbdc954@redhat.com>

On Mon, Oct 13, 2025 at 09:37:29AM +0200, Paolo Abeni wrote:
> On 10/13/25 9:20 AM, Jason Wang wrote:
> > On Mon, Oct 13, 2025 at 1:29 PM Jason Wang <jasowang@redhat.com> wrote:
> >> On Sat, Oct 11, 2025 at 3:40 PM Jason Wang <jasowang@redhat.com> wrote:
> >>>
> >>> #syz test
> >>>
> >>> On Sat, Oct 11, 2025 at 4:38 AM syzbot
> >>> <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com> wrote:
> >>
> >> Paolo, it looks like the GSO tunnel features will leave uninitialized
> >> vnet header field which trigger KMSAN warning.
> >>
> >> Please have a look at the patch (which has been tested by syzbot) or
> >> propose another one.
> > 
> > Forget the attachment.
> 
> I have a few questions. The report mentions both UaF and uninit; the
> patch addresses "just" the uninit access. It's not clear to me if and
> how the UaF is addressed, and why/if it's related to the uninit access.


I'd like to understand that, too.

> Do you know better?
> 
> It looks like the uninit root cause is on "the other side"? i.e. the
> device not initializing properly the header. Would unconditionally
> clearing the hash info implicitly disable such feature?
> 
> The syzbot dashboard mentions a (no more available) reproducer. Do you
> have it cached somewhere?
> 
> Thanks,
> 
> Paolo


