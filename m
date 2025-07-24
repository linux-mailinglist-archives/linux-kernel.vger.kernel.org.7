Return-Path: <linux-kernel+bounces-743530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DECFEB0FFD6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899E59611B7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 05:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DB31FF1B4;
	Thu, 24 Jul 2025 05:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="MHyNHo4O"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC751FCFE7
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753334082; cv=none; b=VdqRBZZyRzlmDowfv1Q1havFhku7tfAfJ3hcetan5Pez9cB5SyXloN54JHA4S6xLyJ97FTjMRc/aQRFdmedN2AdmmQNu9p7dRQojoOXls8U2E0VmHJ45CxbaXW2u+xDJkxX+i76+sFdh6DFiPPzUj97vV7aBobK+Zph9fBJG7g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753334082; c=relaxed/simple;
	bh=Vo2SdnJZK3om5RaPVgTp8e/yJvD9F7K+eZvYm4uzem4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APvYe6UFVN5aduDVHVb8PCsuTD4ONQecGY0vYonZHWEGfuURr3GMsbzQf/3ns/QXFLordx0AboZWalipYxvDgF9aBoKqEBR8zUw5UNQqFcL20coWUgA+dmpEO2lfr2sKyky40WBmWzyA4uGVGqLOmtlvyJ6bE/vYs0xNEGtcVt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=MHyNHo4O; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b34ab678931so544142a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1753334080; x=1753938880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i7SimV5VJWEB25HagffS670JWUdLLyQFzQyMxpTCmMo=;
        b=MHyNHo4O85x5x9k9Dn69n2UtgdEPylU/uyqIrmKV51KhNKEiLgmQJAOYeSEUn13tG/
         SVZdOViKKtEd0ujxGEDNxlX0k7832Yw19MNK5L9mMpBd7rCw4VEijr4Y12xVoilkLJ3+
         I4EoIcmgaZKVA+nRfvKPOWIe2wBOJYpM4KZN6pswHoS4PBorMkGs3qioHdysTnn3neQ8
         mY+g9dr1jeCWiJ7lBoDooVVOFYPsJ4TU+8wsCr0j65pxAwA9+HCO0q7j74FH2B/DIVSL
         UAIG0rB8YnQfhqeHXA3C/v8/9nHMWwP7vtwMc5Y1cheoXVHNNuzJ+WWVEjmtc8SW1sJt
         nLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753334080; x=1753938880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7SimV5VJWEB25HagffS670JWUdLLyQFzQyMxpTCmMo=;
        b=rQ7GHFPGZswIsQ3kG4VxYLX2RiKcoftmp9DFZi6TDdJ8ac+7EwOuIS0qV4h7yLwAJo
         jzRb93HQFv0hDRmx8zOc7DB6IXj+I+oYRPbpY3JBCzx3q7IkwIon0j0d9Cz6xEyRtQ8G
         GqkqQrEt0FfsUBquqQvEYr2XygJvJtdhNXNVzLcORB7ZCD5EPaUhWkUMhPF5w/Ax7wxH
         0iPTKZpxamN3QE8dh1InD88N6nLx+d6KUlw5cPMnL6tWh5IWs+KHbeIGoHvAZf69uW5C
         1w6cz/jRlza5+wSgF1R/Mn3tnGinyMRo20kjx7waiJlIg5ZgrYqaIXEKEMcvk55QtdEk
         J8Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUF5GiLqWhpmg4TkPpre4WBwQpVSmUyQpJR7RUr05UrvzFNlvxxGGvSQUmnZo2XzVkayzU657R6NTXReC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuQ4VP80A0Xz35tdZugB8VEoypuKEReIb7z4ElaBEXQsRI7sQ7
	7gGQ9vX2ZhgsUbObirgz0g2osdRvt/i5LURu++PBA1FwBsZgiWpdpXu2dJCEwkO/TF6i
X-Gm-Gg: ASbGncs9d21W3DowIKiYqAh86WLq7BhgYiCKLJ205TJNMYFBmd1E4wof2056Emm2GmC
	pYqVUk49kbCxRgmKEhmMHf8x1gPs3Zn6P1gik1EM1TWbQYCZql24io0O6H4yAAfULUuT/fS4qi1
	8KtlhCh9ZTAtI2WL3Ms+YrWS88Q/M5THJ+AdRflYFD/QhnxQPZ9A+qMQG37fqbzjt+kY1jVP0hC
	1D56W3M0Wtc+7QlH5vl+MTNuT9guBKIJjrQpXd9q1bKFto0CE9qnxtCqwMl/krSdNKyLE1dUOM3
	FRXAF4GcvnBN6YQA4OKef+Xz2Q281ZNp9o3cB8HZQeR8pdyfms63yNYTsnuMI2alpAcQIaa/Jbc
	3V1zyGzxfYh722NvmGB49Lgfk
X-Google-Smtp-Source: AGHT+IENRsGq90aUM4ne2WTxB7vhhSJSRaiabdV70/A4kdHOS5MgcbNOqLONTS5Ybge8UgWLOEr1jQ==
X-Received: by 2002:a17:903:17c8:b0:234:c22:c612 with SMTP id d9443c01a7336-23f9821dfbemr89796085ad.43.1753334079646;
        Wed, 23 Jul 2025 22:14:39 -0700 (PDT)
Received: from sultan-box ([142.147.89.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e662b3304sm378571a91.17.2025.07.23.22.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 22:14:39 -0700 (PDT)
Date: Wed, 23 Jul 2025 22:14:35 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: Bin Du <Bin.Du@amd.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl,
	laurent.pinchart+renesas@ideasonboard.com,
	bryan.odonoghue@linaro.org, sakari.ailus@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	pratap.nirujogi@amd.com, benjamin.chan@amd.com, king.li@amd.com,
	gjorgji.rosikopulos@amd.com, Phil.Jawich@amd.com,
	Dominic.Antony@amd.com, Svetoslav.Stoilov@amd.com
Subject: Re: [PATCH v2 6/8] media: platform: amd: isp4 video node and buffers
 handling added
Message-ID: <aIHBO_2-hKWgb8Dq@sultan-box>
References: <20250618091959.68293-1-Bin.Du@amd.com>
 <20250618091959.68293-7-Bin.Du@amd.com>
 <aIEiJL83pOYO8lUJ@sultan-box>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIEiJL83pOYO8lUJ@sultan-box>

On Wed, Jul 23, 2025 at 10:55:48AM -0700, Sultan Alsawaf wrote:
> On Wed, Jun 18, 2025 at 05:19:57PM +0800, Bin Du wrote:
> > +
> > +	buf->bo = (void *)bo;
> > +	buf->gpu_addr = gpu_addr;
> > +
> > +	refcount_set(&buf->refcount, 1);
> 
> This discards the refcount inc triggered from amdgpu_bo_create_isp_user() when
> it calls get_dma_buf(), leading to a use-after-free. Move this refcount_set()
> up, preferably right after vmalloc_user() or right after `buf` is allocated so
> there's no risk of this issue occurring again in the future.

Following up to correct myself: please disregard this one comment from my
previous email since it's incorrect. Sorry for any confusion.

Sultan

