Return-Path: <linux-kernel+bounces-823254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436F7B85EB2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39B8E7B2544
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AABA30BF71;
	Thu, 18 Sep 2025 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgXD12Dp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D30306D36
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211958; cv=none; b=p7CCjRrqJhWS9qKwUHEK0m3NZ5vK7n2OmuWP2fz2+s+lTTogpBnazCIimUqk04tkriAZC1bo5M4OM+azGYSss33J3lsnvfWezrEu1j5YJmp3rjsqEsAOok8orLdkZT7vzYd/kHCXBBvswgPQlj3SGVewVGEv2leYD/pWabsZ1c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211958; c=relaxed/simple;
	bh=3ChuK9dLT+j/JKhhXXw790DwdOdULGToKTA4biGxyaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etjsgsMR7BlUfdCt6yBIQziIAIq/GXTu6/3IMAOpRFagz11Xfh7CE4OZ3B//dfRMG6GwN3HAsYlw9X/nFiYZ/fka8CWB0xpFdDrbpaDwfXy2W8J2IKnkOb2zSqoY6osWey0OBQfvYF1nMk2zdbNQNWVSCpPiuMOeZDBHqmynwgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VgXD12Dp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758211956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GWkKglNyHyj28Yf+KWWRVKsP6YQNNJY7QhKMXW45eIw=;
	b=VgXD12DpGN+1XVTwwomy+lWTBgTg+uKNUOU0IptEAtjPoLX5f0Hct7d9Q3Ol2MZy4m3VzE
	jb6zGvd3KVZ3Nw/ea+Hxr4BEwBuUC8UuQKE+AUGTRuPC+c1Wah3eDMlZXDYgCShVk7TnwP
	dPrbEsftsVZMGm7YtGPlz/cRzMhc1qA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-NA2I5qrDMGCnyCFCO7WkYQ-1; Thu, 18 Sep 2025 12:12:34 -0400
X-MC-Unique: NA2I5qrDMGCnyCFCO7WkYQ-1
X-Mimecast-MFC-AGG-ID: NA2I5qrDMGCnyCFCO7WkYQ_1758211953
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3e997eb7232so514953f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758211953; x=1758816753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWkKglNyHyj28Yf+KWWRVKsP6YQNNJY7QhKMXW45eIw=;
        b=Ole8zhSWIcE4d7+JjVa31tvzraKrzADGUa5cUEKD49NGu92s/4nwF9yL5VWn2ONZ21
         O4y7vHE+B2Ckz+IXyI0jzwdUrRKubRYwnXpAlrN+ijj78HrmrkDL2rbwWfilVkCjfmPe
         6KFlRAutX+QlSQTJgc84sq1wIqJHRgsUGOE3qIsfSherUKC08boqXGy3yZ0IK2kVSf1p
         E1AMLW5d746iOjUfakCcoKlavRy/BeO/u+fjgibNkYiY+cdEWcK8nByV11e59j3czgZ9
         XrBM496p07nerbXDUQn9S+syBXbHdJdROtzWUioFIkzzDURWBbscTu8twSn8CrsrTN3f
         7b/g==
X-Forwarded-Encrypted: i=1; AJvYcCXbV1u0aabXnecrrwTnfHJhyjOJDAQyJhOo37P0PaT1hBv2EaZ7efjOoO1q0lBgg470Su03sDDbhl9yaqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyow5H2z5UtHCvvUe9wwaFnDCguih74wJEF9RJmI24bpY1qUbx2
	vt9ufE1Ez24HelP8kyYM8ZPDmC6crp2s32pvJcAdzQUW0q7ggStnBdDAWF4PUZdxZU4b2fWUcSa
	fSLSZacAkKCD1CLr4FYvaVUxLH653O5dpRIxXmWLZ8shjwnB3wAbtz7Vg8lotaJP6aw==
X-Gm-Gg: ASbGncvCtuGeyxdNs7oz4SJcCOH1l3Kac+hFAHOf1xNexg5utfPvFYAJ9zkp6+GXMPG
	vJkq44G9kEBYyENe9Lgc3WQ6TASqHF26whGD0GT/UR/ToZUq6re8esufE+OERO7d49xCyVMi1nB
	dYu3BNU6xiVzVeC/yKXrENpyUX0yoGs43RS6/lOPUQWmMz0gBPImp6gOxzTdLXsPJdUBxMTChkf
	n948vlj53IJWMzrD6VEkUBZ1i3rP28oNHAo7S0lMckKdUXoxMZEYoU7pp3nzkscenKUK05I6lRs
	IY8QE9u6FXUzWHyBQk2f7pnWJhxwgfiiunc=
X-Received: by 2002:a05:6000:2411:b0:3eb:d906:e553 with SMTP id ffacd0b85a97d-3ecdfa59c2cmr6499613f8f.55.1758211953357;
        Thu, 18 Sep 2025 09:12:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQNjD7OmqbUX0lKdSCUxk8S1FFLIR2TIUSd05xm5nCE+NLCdpN93A3STkA7r0Jij+RWM8oVA==
X-Received: by 2002:a05:6000:2411:b0:3eb:d906:e553 with SMTP id ffacd0b85a97d-3ecdfa59c2cmr6499570f8f.55.1758211952931;
        Thu, 18 Sep 2025 09:12:32 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407d33sm4389523f8f.18.2025.09.18.09.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:12:32 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:12:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, alok.a.tiwari@oracle.com,
	ashwini@wisig.com, hi@alyssa.is, maxbr@linux.ibm.com,
	zhangjiao2@cmss.chinamobile.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL v2] virtio,vhost: last minute fixes
Message-ID: <20250918121009-mutt-send-email-mst@kernel.org>
References: <20250918110946-mutt-send-email-mst@kernel.org>
 <869d0cd1576c2ea95a87d40e6ce49b97d62237c9.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <869d0cd1576c2ea95a87d40e6ce49b97d62237c9.camel@gmail.com>

On Thu, Sep 18, 2025 at 05:45:05PM +0200, Filip Hejsek wrote:
> On Thu, 2025-09-18 at 11:09 -0400, Michael S. Tsirkin wrote:
> > Most notably this reverts a virtio console
> > change since we made it without considering compatibility
> > sufficiently.
> 
> It seems that we are not in agreement about whether it should be
> reverted or not. I think it should depend on whether the virtio spec
> maintainers are willing to change it to agree with the Linux
> implementation. I was under the impression that they aren't.

Ugh. OK I guess I'll drop this one too then.
That leaves nothing relevant for this pull request.


> I will quote some conversation from the patch thread.
> 
> Maximilian Immanuel Brandtner wrote:
> > On a related note, during the initial discussion of this changing the
> > virtio spec was proposed as well (as can be read from the commit mgs),
> > however at the time on the viritio mailing list people were resistent
> > to the idea of changing the virtio spec to conform to the kernel
> > implementation.
> > I don't really care if this discrepancy is fixed one way or the other,
> > but it should most definitely be fixed.
> 
> I wrote:
> > I'm of the same opinion, but if it is fixed on the kernel side, then
> > (assuming no device implementation with the wrong order exists) I think
> > maybe the fix should be backported to all widely used kernels. It seems
> > that the patch hasn't been backported to the longterm kernels [1],
> > which I think Debian kernels are based on.
> > 
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/drivers/char/virtio_console.c?h=v6.12.47
> 
> Maximilian Immanuel Brandtner wrote:
> > Then I guess the patch-set should be backported
> 
> After that, I sent a backport request to stable@. Maybe I should have
> waited some more time before doing that.
> 
> Anyway, I don't care which way this dilemma will be resolved, but the
> discussion is currently scattered among too many places and it's hard
> to determine what the consensus is.
> 
> Best regards,
> Filip Hejsek


