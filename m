Return-Path: <linux-kernel+bounces-788798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C38B38A66
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C30B7B95F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC4B2EF673;
	Wed, 27 Aug 2025 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S3qL1xiH"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56DA2E1EF8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 19:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323693; cv=none; b=B0xRIHzHm4TCAQp98xgHk/0yfsKho2nZEUnpmYQasfGgnwBbzb7btWPnzGasNNZpdK4eKUtw9DE+8r0W2f8hVrTSPr/WqgyNMxza4f2BV7rl+HIMSgRBwrPi4I3f5eaEawuOhbnvmqw/f/BKKiRBQ2EWt08Do409rowrHUOuUYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323693; c=relaxed/simple;
	bh=Sm3MI6RtHWl5SCtowMH1Z4lpx9sb43ATHH9WZPB4fI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmxn4oyMguK7B9oB2xIDXAsswGHGSXxhRpsEHcyC9hZtBYsIprI/Fd7SA3l8T33tBtY7d9QBFff2DTfPqe+ZkDbmmNll5LIWFhk85zUtc46dANZARQxAesyNvzz80bdgYUM2z8HZl2439+aySft8mOUaKkf/rpMeVLxNf7NKUV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S3qL1xiH; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4c1ed55930so263454a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756323691; x=1756928491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OcF76ThxDzseiSVRi9ITwryzKooFVtGhEDdOZb1GMK4=;
        b=S3qL1xiH1MwM7T7e9YYpOit4wxqDVQsy/my03mqZFkpBdLOzbKMwhQv2zq7aUhYWC3
         mDTbT8bHu1MhOBGdcdo86Sd++j6DPQClhRfkeR6Z8AzAIsQ55bqJP90/7Pd/HCSNeBau
         mFCp5S9ZwUnmN2JXo79NtWT6Qr2RZjrYtDzOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756323691; x=1756928491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcF76ThxDzseiSVRi9ITwryzKooFVtGhEDdOZb1GMK4=;
        b=ZHcZEn0vM+Qgqxs/jpAIqAFJmfeuUW8E6o353Y5Bp7UsEYohXzMN52Sy4/CocXOh/R
         di5aOHh991VlsR60XCe36kecHPRgYVLCXDlawnhkHM1CpLzcV8oEPsMGeh2SZPCekCkZ
         R8g8lUDFJpvu2o1sh8L+AqLd/BGq85ns+839tKZOx+1STD0vyQfTmbPglALHPYh4TDH3
         09VorRbQWcf77zgtraq2S9Z4d0XC++ZNjO58vtZFTtQuvooy2lxV556bswu3QfPuJPAx
         Tx8E8pVP9jp3aTVjEn4HVtQMcVTUthztlEi7dmekukFDuTAULnbw+5YwaudhH0ywiB8z
         Pcmg==
X-Forwarded-Encrypted: i=1; AJvYcCVweYNzAffgZXlbUuU4FxjYv1QfYdo5iqowCJK2g4E94rCPp+AjBU6lEu/Bq3hYPtn+3hW3KBwUvi2sl7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIA0azYrwGHkn2Hv3B8eIeMzbJ7wZq6tcgfzTtbFzHErQAPopS
	pyxdoprS4O8ZIoKuDD3N8EFp3skmc0G9VH38FfeMTDGE1T8irnFXvxhon3LoTT+spw==
X-Gm-Gg: ASbGnculhN/AWy45+AO0wzXlQdU+oYhxjsCEDYgDd18iD/UA5l48B+tCDtLPtUWrLjL
	YOLCv3YjysTsVKxcnkSPvuKUbRDlpDuhjMJjTPbSprq8/ZQQDvg5jG+IPBVdryzaHK+XQ+1B/CX
	Yk6Ev8PNv5fUD4LIEKvVItG9NnrS4NOZbYlUvCyBLcYnTAOc1N379iTaPoF9JEYLDzFQ3TE8Jsz
	0GCJqozk5HMIICEc0NI0g5o6tB1fo4u50vXW3pNTQIFIIDbtY/p8O949iHtO25/qEMJBaJX+RCl
	+gDA5fgcC1UVz+OGyj4ghzDWQkC7X561hfMyPQsoOW6S8K70Fj3KV3CJSKYZKtB6OH34KLZiYzO
	xENSwl97vSg2QcZ4Eu5/kSY7hdNTs32Hkio8EBdLVU9mR/+ghCQvaKLdsSxom
X-Google-Smtp-Source: AGHT+IFZiE4r45aDuqweIbhvj5Uvc3wABlr9GNax9UlaNDtrOMl0n6Aq3+PixqrRUWTKPTqBfnW1tA==
X-Received: by 2002:a17:902:d4d2:b0:248:9964:3796 with SMTP id d9443c01a7336-24899643b24mr48265415ad.43.1756323691105;
        Wed, 27 Aug 2025 12:41:31 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:36f6:f0a2:9401:263d])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2466889e11csm128094265ad.155.2025.08.27.12.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 12:41:30 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:41:28 -0700
From: Brian Norris <briannorris@chromium.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	David Gow <davidgow@google.com>, Sinan Nalkaya <sardok@gmail.com>
Subject: Re: [PATCH] um: Support SPARSE_IRQ
Message-ID: <aK9faES_JZYCgyip@google.com>
References: <20250825212031.111027-1-briannorris@chromium.org>
 <155ce30d5fad5a444f72b681eb096418384542b3.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155ce30d5fad5a444f72b681eb096418384542b3.camel@sipsolutions.net>

On Wed, Aug 27, 2025 at 09:38:17PM +0200, Johannes Berg wrote:
> On Mon, 2025-08-25 at 14:19 -0700, Brian Norris wrote:
> > 
> > +#ifdef CONFIG_SPARSE_IRQ
> > +int __init arch_probe_nr_irqs(void)
> > 
> 
> Is there much point in the ifdef if it's anyway always going to be
> enabled due to the 'select'?

Oh, good question. No, I don't see much point. I think I was waffling
about the MAY_HAVE_SPARSE_IRQ question, but if we go with 'select
SPARSE_IRQ' as proposed, I should probably drop the #ifdef.

Will send v2 if that's the only question/request.

Brian

