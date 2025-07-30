Return-Path: <linux-kernel+bounces-751009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1E1B16409
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D0718C2F1C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127A22DC357;
	Wed, 30 Jul 2025 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mi/7/0nM"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3732D8368
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753891411; cv=none; b=L9Q2b8QAFxgOGbJ+BiX1TouLM4+YM/vOzszyUZ8A0bZKJXKB3szbqz9aT6KEyIUU5ySX0pYMGAhlZu3rlyc9f76bJ4dKHGz3gy/hpbWHwjJ5e+/hqGSOjBYobQUuEKxbrwNsdXuLD8EBscoFuoPG30txRljHQkqj9PvyvFlIgAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753891411; c=relaxed/simple;
	bh=JD/vxYw0vyKQComxP4E1Z53ndDUYTzU3hErVNH+AgZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoKmHh9g0UlWege8q9+fOPZkSmf8HfZBWJQFGHLsYJsdJg0hQNTBDddbzf6uK4TQPKyU2Rzi8UGBngnFPWMhM1KyAwvWpwnfNR24DXdiwup2XBAGkS2HkyqFdyReEfCN0WfMFLpPQrs/by4gUGYh3Af/UPl9sLTmB+KC37Fwn48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mi/7/0nM; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-7074bad053aso28367306d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753891409; x=1754496209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JD/vxYw0vyKQComxP4E1Z53ndDUYTzU3hErVNH+AgZo=;
        b=mi/7/0nMsNks/vscU7x4ar2dhvN3RihseppRPvnuMM14wAZyj/t4o2QEALtV8PgVFE
         bgKNfzCzg/oX7o2s52iiloUvDs5lNTSZAekum8ehKoqJhL9q+9lzbVDJ5II0Cw4qN8nA
         tQoO0xwyEeLCPfV9TjVJya1GfcL5rkRpt9F+YW0k9DnzMzIvCrTTzy0oIlkR/eLsAgQv
         A4Ng0v0K87NjfU7vD2BVAZUFSq/8270T0hWOaUYaWQa8l2GfLy8mK7EhRpBVLsl9o24x
         LvCAO+HTTULu6u2tA1y5VRZJ8IBT3Y1Y4FjYPhWywWUNIzwAxT2OrCL8NGjeI2vtsrz8
         LLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753891409; x=1754496209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JD/vxYw0vyKQComxP4E1Z53ndDUYTzU3hErVNH+AgZo=;
        b=WOhpRZvh+hF4CXGsDh44BSHu/6OKHU5bONCu2BNF5SxUdUO+w35jaITMxvDA/0hzjB
         sGkVIzucIt8TujdHId4mHNrohNLjdLkwMw6Z+1sbXvsfiGaM3lywCdc5mmk7qpEm9bkn
         5JNi7tw7LPyI4xRbyiGlZU9lLBsyJpJ7ep4W2zoqWzotvpcJhnNkIl9yjrYQmrJ7vpbE
         Mtlpexzgt0XwhS4UMQggwP3aihxSma07ZI92YyNKLgiDHBkGuBP+LScAK0Jlsgwld2lz
         x/5Zx55ExROi7+s7dtMF9/Ojhv3NuqBCywOUZ1A4uzKNRsURvfPliIxuNICgmgnfGTjl
         HRJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmWcbTPiA02BRN0q/wFJUpoyxMbuH+dxF3iv7etfaMNifX+PC/kXjFdcsAhQgk+Q2pw3HlSKxypEEStDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM3hArcqejG70oXhuE2GuMTWO6P5SHYmZAN5XsBwORbPS88/Fr
	gRethhsslt4XIYjwcXMaTPH5ZTEXQTOfcnZPWG/FX18Ccz5HDbS38u8Bqgku/Puhr8c=
X-Gm-Gg: ASbGncv5L87ITw4jVme3gmnooqlQQ1fCCBylHmEzh9aFW8JxIp8rGUJi+Qx8F3aiz2r
	qVISp6lcRXhzjMlgsi9mNGKRTbyZX3Z57m5ZE2Y/X5OoYp9KsVu+4wvpPNQdgJyQfUPbmT4D3ia
	dQX4pHlRHSpphGGEV4Axtu0mea5ei+7FMTNAfmpHx0cQFRQOrIKoGQRRo6xzLaRwPAhKuJCJE3p
	fWfyql0NNw+Eitz3bCrotUztsMdN6evHBi044urxAon3zn3DR9vCcTrltF3g+Ge8flS/VEa8Jhm
	RjZ6/dCI3Ft5V9HnL6hYywWV3iQM2r0dL0aEfdbwjm7IG4bRBPnlOrEPhkm/UFlU46Rad0p/Svi
	MBxVTav+PjeV8xAg8YyFpbReQudwuDcbs5eeLMYJL3TntRvhyT8BGuHBWy+UlD1vXo9tY
X-Google-Smtp-Source: AGHT+IELABFxJjSRVnbcoDgQoyF3DZZtzde7lxM9LhmXgjrOqotsrSt3Aw3+tn7CmcIoh22Vu+LWXA==
X-Received: by 2002:a05:6214:5296:b0:707:4825:ff41 with SMTP id 6a1803df08f44-707672d91b7mr47058816d6.42.1753891407540;
        Wed, 30 Jul 2025 09:03:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70742e70964sm47845006d6.23.2025.07.30.09.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 09:03:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uh9H4-00000000SCB-0SyY;
	Wed, 30 Jul 2025 13:03:26 -0300
Date: Wed, 30 Jul 2025 13:03:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 00/38] ARM CCA Device Assignment support
Message-ID: <20250730160326.GN26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135216.48084-1-aneesh.kumar@kernel.org>

On Mon, Jul 28, 2025 at 07:21:37PM +0530, Aneesh Kumar K.V (Arm) wrote:
> This patch series implements support for Device Assignment in the ARM CCA
> architecture. The code changes are based on Alp12 specification published here
> [1].

Robin and I were talking about CCA and DMA here:

https://lore.kernel.org/r/6c5fb9f0-c608-4e19-8c60-5d8cef3efbdf@arm.com

What do you think about pulling some of this out and trying to
independently push a series getting the DMA API layers ready for
device assignment?

I think there will be some discussion on these points, it would be
good to get started.

Jason

