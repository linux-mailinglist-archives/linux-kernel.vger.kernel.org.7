Return-Path: <linux-kernel+bounces-844340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D16BC1A02
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87AC19A0F11
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9566244685;
	Tue,  7 Oct 2025 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dz8Uq/Z4"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BFE157480
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759845798; cv=none; b=e0KAgqlC9849KRaipNJX+2/csAViAquUQgbDyJReinjFbdm0O9tXJbLu1cXVSsdSBLar7lIfmay3d8wQrMEarV2aEX2btKEm6pu8+9Y4M6Dq8tFOSD5bt5J2QPwvvgbCINIPfsw9F3xvwQbdGy3qwlKH45tW7tBYQYrNyqghKIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759845798; c=relaxed/simple;
	bh=QHDIZMz1ZEUlUwjyGTP5lM42aZbO1UP11CwVCrgZLNc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QIjmhxpGvSJXNVD9wUzjzGHOxj4T3kaGfwFBFfhC28leWHilmNPL0cQv7s1ZPCU77MI1FRiXum30lLVFWvtUNw++ze8O/1N3iPUwYQXStyn+5RsJOkVTGH0FalFJsK+QsQcXaCncSH4fKBnpfh98SajplYNdwVf/Dljt51xdZBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dz8Uq/Z4; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5F1DDC085F3;
	Tue,  7 Oct 2025 14:02:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 981D1606C8;
	Tue,  7 Oct 2025 14:03:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A6836102F214F;
	Tue,  7 Oct 2025 16:02:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759845790; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WSi/XXu9M7yK9fXAosnzu7bOzMYxwvxWn1n9XpuR2TI=;
	b=dz8Uq/Z4RT1Q24psyJ+UYiqxP6P7O7iYVkn0rWcGNH1An7qnWq8bUTZI81YQ9PUZgZbugT
	6n0zCKB1oy+oP6bBEoznuSj40VWNVdNBVNEoZtKGCPtrIlwrEzy8sSnCNQf4gBkhpSvolX
	jGzLYCJfH8nyXS3JXvPj68CsekeNbY80o1UkGASYQHa2w3ANAAoFG9fLAsub05y8RgG1Iy
	GndbDWYRZpjDW4TVeFiL7E6kpqigcruvuL2RyzdJCIlNwCk/nl+3W9JtPc0sCC0QfyXFLz
	fSi2qqZ0w+jq2YkCTYcfXLkzjZ/thlagQSjJPM0OD2mUVrDHGGw4MZb24TUAlA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Oct 2025 16:02:47 +0200
Message-Id: <DDC59CH6JUWR.GRJ77V41K2DC@bootlin.com>
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Hui Pu"
 <Hui.Pu@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] drm/encoder: add mutex to protect the bridge
 chain
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: aerc 0.20.1
References: <20251003-drm-bridge-alloc-encoder-chain-mutex-v2-0-78bf61580a06@bootlin.com> <20251003-drm-bridge-alloc-encoder-chain-mutex-v2-1-78bf61580a06@bootlin.com> <2ksmq6ytj3zabxuexzjuqovalik6memy33vrba2aihfld7b7so@lhqhmaargucp> <DDBZS1BBBKSN.ZHCLP3O5T1HI@bootlin.com>
In-Reply-To: <DDBZS1BBBKSN.ZHCLP3O5T1HI@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Dmitry,

On Tue Oct 7, 2025 at 11:45 AM CEST, Luca Ceresoli wrote:
> Hi Dmitry,
>
> On Sat Oct 4, 2025 at 11:47 AM CEST, Dmitry Baryshkov wrote:
>
>>> @@ -319,6 +323,41 @@ static inline struct drm_encoder *drm_encoder_find=
(struct drm_device *dev,
>>>  	return mo ? obj_to_encoder(mo) : NULL;
>>>  }
>>> =20
>>> +/**
>>> + * drm_encoder_chain_lock - lock the encoder bridge chain
>>> + * @encoder: encoder whose bridge chain must be locked
>>> + *
>>> + * Locks the mutex protecting the bridge chain from concurrent access.
>>> + * To be called by code modifying ot iterating over the bridge chain t=
o
>>> + * prevent the list from changing while iterating over it.
>>> + * Call drm_encoder_chain_unlock() when done to unlock the mutex.
>>> + *
>>> + * Returns:
>>> + * Pointer to @encoder. Useful to lock the chain and then operate on t=
he
>>> + * in the same statement, e.g.:
>>> + * list_first_entry_or_null(&drm_encoder_chain_lock(encoder)->bridge_c=
hain)
>>> + */
>>> +static inline struct drm_encoder *drm_encoder_chain_lock(struct drm_en=
coder *encoder)
>>
>> What is the use case for these wrappers? I'm asking especially since
>> you almost never use the return value of the _lock() one. I think with
>> scoped_guard you can get the same kind of code without needing extra API
>> or extra wrappers.
>
> For two reasons.
>
> One is to avoid drm_encoder users to need to access internal fields
> (encapsulation, in object-oriented jargon). But if I read correctly betwe=
en
> the lines of your question, it is not worth because drm_bridge and
> drm_encoder are already interdependent?
>
> The second is that the C language spec sets tight constraints to the
> drm_for_each_bridge_in_chain_scoped(). The macro must look like:
>
>   #define drm_for_each_bridge_in_chain_scoped(encoder, bridge) \
>           for (struct drm_bridge *bridge =3D <FOO>; clause-2; clause-3)
> 	       '----------- clause-1 ----------'
>
> clause-1 must:
>
>  * declare a 'struct drm_bridge *' variable (the loop cursor)
>  * initialize it via <FOO> which thus must be a rvalue of type
>    'struct drm_bridge *' (<FOO> must be a function or a macro, as a
>    variable with the correct value is not available)
>  * use the struct drm_encoder * as its sole input
>  * lock the encoder chain mutex
>  * get a reference to the bridge (as Maxime requested)
>  * ensure the bridge reference is put and the mutex is released on break
>    and return (clause-3 can't do that)
>
> Given the above, we still need a function that locks the encoder chain
> mutex and returns the encoder (bullets 3 and 4), like
> drm_encoder_chain_lock(). I'm OK with removing drm_encoder_chain_lock() a=
nd
> replace it with an internal macro or function in drm_bridge.h though.
>
> However I'm not sure how to use scoped_guard here because it doesn't retu=
rn
> a pointer that can then be passed further. Basically we are constrained t=
o
> have a chain of function or macro calls, each eating the result of the
> inner one, with the outer one returning a bridge pointer for the loop
> cursor variable. There might be some macro magic I'm missing, in such cas=
e
> don't hesitate to mention that.

I realized I was not fully clear, sorry about that. The inability to use
scoped_guard refers to the drm_for_each_bridge_in_chain_scoped()
implementation, being a macro defining a for loop. However scoped_guard can
be used in normal locking code such as the changes in patches 3, 6 and 7.

Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


