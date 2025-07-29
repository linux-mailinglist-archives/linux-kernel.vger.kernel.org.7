Return-Path: <linux-kernel+bounces-749179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF74B14B0D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F691892301
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD4D264F8A;
	Tue, 29 Jul 2025 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SV3aZX+B"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6AC22DA0B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780762; cv=none; b=WheWBSd5zcw1uDFna0ip8ZxjPsLeroLoG3E2RNJKZGIDBcT4pB+1kQ8d4IsJ193EmDGZCYYkwghHaDO6GVcekRxuRNOtPm/GVM8Gwv9X9kJmMOm2tu/Hx4/oN4ec82SnevM/mG7ga2JXx5gGYUTTJoilCY+NRuruY1Rt/xbuvYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780762; c=relaxed/simple;
	bh=rQvsWu+Pb8C/47+QetGvb0sbFiXZpTaN+Gpht+bmprk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpWu5xP360quqkVAwmvwfOojTFeo1MaVIZ5HPDwkST7vXOxDeHFGIABRq0vMVzUJuVj4g6bSxmqbxN4eBSEZ4fI+SA6EdaIG67yUe1b0Aj8QroBM4lurYaBgYdtZdjgZfLrWngO/QQXVXGpgONJRTzve/Hz2fkLQIEmTvWUeXPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SV3aZX+B; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae360b6249fso956108466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753780756; x=1754385556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FrFwM1VTnba/UhHasFMl0CnHRVF7mL2ndb/lv3touvg=;
        b=SV3aZX+B0Bi/9pHgGlFcgmiBexuhw5Yqt+cn/8PRCkND3JCoUGFxm/7KR5J5MPIgLM
         iXc60vQhH+8uyTKNp1/r1Os3EczxWV0Hp0PNMRwkC1/8/Kty6CSwUpvyeNQ+C19Hvk1g
         1t2l4OyBQUWpiB9o/pFy88/3L3EqrSWLDGwDn0HmmmzOaTx0ZDQLspftGGvDaWjEcu6L
         BiL3KP2F9sfqxwO9uegPzvA4juAnLF6C29d1E3OljagHTzdD5pcL7OcFDp9wLG8llWS7
         NASI6JwpfQVQLZu36T7CzvuUF+h/LlFmB/vC50NFD4LPjMcHZiuE5nT7fX6erbn/6uNZ
         XqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753780756; x=1754385556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrFwM1VTnba/UhHasFMl0CnHRVF7mL2ndb/lv3touvg=;
        b=Fiv//L67pPJOncrIvkUJnTwqYWYikwMynRar5hhbtv9awfXSwJvOFjCeSlGXKX1+8o
         ehfvebPmQxFWPU+SBRwmf/0CbeD56VhX8vi5AKjlOG40KwbJG5RA7xPcmRHQNa7FLlAS
         19hc9FihBiHBDabjP8+POSriTiwhwgAGb3p49Sy2l240vZStUvZCGDWK2IP0tSO9A82X
         HjzIaQli6ype03sst7Te3YprBxU6l7QmpU4JiU8H4EA6R5lO6R+6URrByhbJeTZS4GAS
         V0uAzZdRd+mRigMP6stQieTWSwJG+tWJ0vyXei8o1kl+YP4OfFPxIFlus7irmsA7MFvA
         dkHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/ds6yTSVOlh5oD86tHGhoezzCLHw4nNGdu+rw4pb1B/1XXOcWIHMSvcLSRSQ98rJXwG1LVtNBliHAvdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmM4Ft20xFEBdTLPeNPH3IyrSvKI0QRcIbabwNhPfcT0yIFlH+
	4/qkwCzG6uFl02Qkz9kEUkmrG9w72iYcW6HlerUDg49dgVrlr/7NBin5q1jVhrDjZAo=
X-Gm-Gg: ASbGncucVEsenHK/NjnoKktTF8bI6LFO31vCmdH2t4qIMYDZ6/6u57cJnTAtxQb3U/S
	Gj/ovNERR48SHV3721OeCdtUPx/cbODIsWwe8iUUBdMVP9/VHiqmDXIFaDjpyrEx+U4jqk+jyqV
	4LchvfqYB9Nb7e7z+CWZtUoIrhuIiv/8aY2X+cNImnUz/JcTpXF09mSsAzgRx5eXdTRAaX+yzaQ
	QqcwgGtRUggg8cuIaZUE3aE/Ct+L7ry6uTaoVe0LqnpkRlsxfLuZti+8bXepLoWquKYvZEdqhm1
	xa/4QKRS9E6PqmAwUq029SKjlwn1hZ+J7cDjcuZJuA6MwvZpRyOQipYYD0SVnVYsZjjtz41nfDu
	3ixj2sO/HM0jDmnxNUE12z2p216UXqb2iVl8=
X-Google-Smtp-Source: AGHT+IG5if8x6TzCm9A2O62HvaAVkznS6JFPkv75AtILJqhhNjqt74fPiYQzDCocAuv9abxq43Ts5A==
X-Received: by 2002:a17:907:3f16:b0:ae0:da2d:44b9 with SMTP id a640c23a62f3a-af61c4b19c1mr1854043966b.7.1753780755612;
        Tue, 29 Jul 2025 02:19:15 -0700 (PDT)
Received: from localhost (109-81-20-172.rct.o2.cz. [109.81.20.172])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-af635af9967sm545754666b.131.2025.07.29.02.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 02:19:15 -0700 (PDT)
Date: Tue, 29 Jul 2025 11:19:14 +0200
From: Michal Hocko <mhocko@suse.com>
To: Hannes Reinecke <hare@suse.de>
Cc: David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [RFC] Disable auto_movable_ratio for selfhosted memmap
Message-ID: <aIiSEpQhWqPsvaST@tiehlicka>
References: <aIcxs2nk3RNWWbD6@localhost.localdomain>
 <aIc5XxgkbAwF6wqE@tiehlicka>
 <2f24e725-cddb-41c5-ba87-783930efb2aa@redhat.com>
 <aIc9DQ1PwsbiOQwc@tiehlicka>
 <79919ace-9cd2-4600-9615-6dc26ba19e19@redhat.com>
 <f859e5c3-7c96-4d97-a447-75070813450c@suse.de>
 <aId16W4EaqjANtKR@tiehlicka>
 <3e88642f-3914-42b0-b864-4ad374b659b5@redhat.com>
 <ac7add36-808d-4883-a09e-ef1bf6fd6834@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac7add36-808d-4883-a09e-ef1bf6fd6834@suse.de>

On Tue 29-07-25 09:24:37, Hannes Reinecke wrote:
> On 7/28/25 15:08, David Hildenbrand wrote:
> > On 28.07.25 15:06, Michal Hocko wrote:
> > > On Mon 28-07-25 11:37:46, Hannes Reinecke wrote:
> > > > On 7/28/25 11:10, David Hildenbrand wrote:
> > > > And to make matters worse, we have two competing user-space programs:
> > > > - udev
> > > > - daxctl
> > > > neither of which is (or can be made) aware of each other.
> > > > This leads to races and/or inconsistencies.
> > > 
> > > Would it help if generic udev memory hotplug rule exclude anything that
> > > is dax backed? Is there a way to check for that? Sorry if this is a
> > > stupid question.
> > Parsing /proc/iomem, it's indicated as "System RAM (kmem)".
> > 
> I would rather do it the other way round, and make daxctl aware of
> udev. In the end, even 'daxctl' uses the sysfs interface to online
> memory, which really is the territory of udev and can easily be
> done via udev rules (for static configuration).

udev doesn't really have any context what user space wants to do with
the memory and therefore how to online it. Therefore we have (arguably)
ugly hacks like auto onlining and movable_ration etc. daxctl can take
information from the admin directly and therfore it can do what is
needed without further hacks.

> Note, we do a similar thing on s/390; the configuration tool there
> just spits out udev rules.

Those were easy times when you just need to online memory without any
more requirements where it should land.
-- 
Michal Hocko
SUSE Labs

