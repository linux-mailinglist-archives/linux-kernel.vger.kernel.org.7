Return-Path: <linux-kernel+bounces-844998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25333BC33F1
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 05:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E873BFE91
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 03:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8862BD5B4;
	Wed,  8 Oct 2025 03:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXBlsuUy"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6012BD035
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 03:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759895075; cv=none; b=N3s7U6A8x6fmQ5Dt1TUuwm9gzAKtZuBMh167EJG5c0T+prTsfBtQZxX1/Zs2v1/jepFfBah63XQm2789yK58I/cshOLs9F+jVIro3JtHXKOT0J7hpn64ccoxF30F5rMZQwZU+axAjdb325q2ThCNjMYd3+2Dvz2Z4y8b95fOUe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759895075; c=relaxed/simple;
	bh=QwxYTjM/Hs56IWPzeA4KrNyLGwDxDEJRONFXjgNhoyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAMxWPsSLodtgYC6BnBQQqaXTSzBCeXTFh+gC8K0vEIOxZUWrMEbI9Jt/WCYA7vjUNeaWk1oVS7+K4SWtJryjXJGJQLktqZ+RfbFfQY/12LyAv2oDC1pAXWgS8/1emI3CnXoxY2H/j8hlIlVdqVK91S8ZEMo/j7/UXFB1Enalg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXBlsuUy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-269af38418aso83781795ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 20:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759895073; x=1760499873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I759iT4j8SDZVd7J4MI01EBF6i0nlohVy9HPt2MhIoM=;
        b=IXBlsuUyCBxDax6nD4LSJcvQ9J3gg6WnPWYy3yk9W9r5U5wXlIvzmA1FmJ5d423xKR
         GqEpzMThfoqUxvMylyoCCP5RyPGT8jgzizO19+OsT7Vt/bppIsQQXjoJcKN1NpkjZRi2
         OO2bCD+4iB31NuxZfisOIYDka0aCw0G5AMhmiYJUY67YWruvFsZApq9xSPvbnsboMADN
         azF9YISFD5c8fJeh9FUFWjg2unUQuMUSZWi1To3EO9hHugA7s1T69CFSi2s7w9Fgi+vJ
         +h8q7Wg79FPJblFYyvp+yXNPUdMZ+Zix7b5PV2D1IbVhSt7MGuavQKjEHoP9CFuo6zJk
         cYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759895073; x=1760499873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I759iT4j8SDZVd7J4MI01EBF6i0nlohVy9HPt2MhIoM=;
        b=e+yBflkI9WrIsS/ruO9g5kz9GUy4KYm3km9GixYWwWatEstmyc0IqMqiEyX6VvL1ln
         dScIc6T1tsWWp0dml+D2fy9ib44eN79VEyCuPXShJfskCafGktubGPLrxjBB3CCyZVIQ
         gjBq/l8MVmEWv1uqLl+GczDBeQLRdMIT2A6jyf2hrlsGqeM42GSasEdWlZkc+2vPgO5R
         1eTc624tB+3gtmyB+ehwgs60IRipS4u/mxjaYyYxlJMGTy3sb4k9lVGmckthweextV6l
         jZ+rVy9oGh3nEDR2GWNfFZbx2JeNRH9eZm6qNuXxvZ/u17+VMdhvJ09pLBuwCmQhEiKR
         whBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUP/ToxftRD2hz1jbiBr8PEUtYgYQtG00gagqHq+cQMRWTVTH7+wex965seZyOeJQi9hvXa+cAizNG2Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1iekGclNOzjr5AmKJSsphzSzJG7Fc78NwadXQTHkNfMSyh0d/
	sCvJAxAun+b+ABs+2URzIy6L6K4bXBhcUtRliK2mPDVAfNmdWD1WqYry
X-Gm-Gg: ASbGncuT4uI3NCie5kL80zY73H3nYfMWnvXF390pm4mndiYlSo0F/Pu/23Qgh1aUfHa
	SCqHMMySqnBxxT6JYpVXognN+N/8iK+fw8WGMFcqI1iYMNiDeuO1G9fd1PY21xYnahWhVMczUeQ
	sW9aSPcIJPhEd06dh8NdlBrc95LHTwvAxSVRKBGbAe1QFysAO9Fw6ZQiBhl/obWp78fIptoAu13
	m2hFuNTBvYddT+Z59n1me10NYL5DzoVcftYUokM1lDQ+KJctocnfLTMe6yxknrV0yP6BdAE4L8S
	V7cc7ivNTOOTxzYyKHoivVb5KS/Ee+wRWB8gSdiG2NQWUWBC5k9KtO0/rTmufmgcy9qEHzvWAd1
	2iF9HXVpAqwocBe1hrCPIghbnXpWswsuamG78Qd6Bk4e8RsrDz14FT2ZH6eTJCB7QFqjeorax
X-Google-Smtp-Source: AGHT+IFupCckjpcLo39oZCGHlaErTF4u7UG/c6eq09cdH5+LiWmXwTrf7Bt/BU9N70lcGOmKNtu34g==
X-Received: by 2002:a17:902:ef4d:b0:27e:c18a:dbb1 with SMTP id d9443c01a7336-29027373cb1mr26274475ad.16.1759895072595;
        Tue, 07 Oct 2025 20:44:32 -0700 (PDT)
Received: from 2a2a0ba7cec8 ([119.127.198.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1108c5sm182331855ad.16.2025.10.07.20.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 20:44:32 -0700 (PDT)
Date: Wed, 8 Oct 2025 03:44:24 +0000
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Waiman Long <llong@redhat.com>, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci/aer_inject: switching inject_lock to raw_spinlock_t
Message-ID: <aOXeGFJLuMsPqAjw@2a2a0ba7cec8>
References: <20251007060218.57222-1-jckeep.cuiguangbo@gmail.com>
 <4ab58884-aad3-4c99-a5f9-b23e775a1514@redhat.com>
 <CAH6oFv+KYGZNzb7gySoyQAB3tn2CrH+H_-vi4E=4NS6pvTBHvw@mail.gmail.com>
 <20251007161229.7IT0x9Me@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007161229.7IT0x9Me@linutronix.de>

On Tue, Oct 07, 2025 at 06:12:29PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-10-08 00:10:45 [+0800], guangbo cui wrote:
> > As mentioned above, the list is usually short in typical use cases,
> > since error injection is mainly used for debugging or development
> > purposes. Perhaps we can also get some advice from the PCI folks.
> 
> Is this something that is used in "production" or more debugging/
> development?

It's mainly for debugging/development. Debugging AER code is difficult
cause it's hard to trigger real hardware errors.

Best regards,
Guangbo

