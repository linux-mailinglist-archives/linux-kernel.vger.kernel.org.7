Return-Path: <linux-kernel+bounces-817945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1924B5895C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1126A1B25E67
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2991B1E7C03;
	Tue, 16 Sep 2025 00:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXLQHJY9"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638E51B4247
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982503; cv=none; b=ejE5dSW2iHjrdCR8SaO4d6U0qAh+tZNj0IXYhded2wbVY1WBBhbj8qVVJ4xMBk27iDyXkIqWCzF6pUWwiPePlKEXWCr99IIbHnHs5/DnkBAsqkJxITPOB6b2hSooAXIqZsew+oC2m/xBdVRgMXeKL8KiVGJo8hI6Zo4cTeWfVFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982503; c=relaxed/simple;
	bh=T4FR0ZIhBd2R0gRWCZdVUCIVwfUiBE8hHRGT34VaXww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRpqntWIKkaK7qmuGP2XcLbbSn8QN9JX3HwMwFAw0vrg4xQgAd12p1IhRgGiCybdrVBx64NJv+OqCHLtSOAb9dMgpSxfSgK9Qku4LYBPkxq3wwDdF65D3OMnaEt+Tay2eLTA+tLQ3+yUzjXV3eTMYRkI3/psrs6FT+ZQ3hb7sXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXLQHJY9; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70ba7aa131fso42187006d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757982499; x=1758587299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEQQug3AovcM6NC71MR7bT+yceXeTwMixGfHwtQI9ng=;
        b=RXLQHJY97W2tr3wOdD7aRe8469BMittWxIZyeQAxw4XNA0NdxUQjI5Ka7NWwdXLFI6
         axW5oAYocM/5cDFSPzdeIy1p8jiRI0owQFj/5R3GFH7uOeO8hlVhVoT3ZdlqiA2XWQYm
         Kz6hWG7+L38X2QEIZdAPU+sgOJLnwIN+duLJ8jfI+ROg8c5TxuK84eH34AT8Xsx8PNqG
         VfId5C/ob1113O0bOVX0MTESufJxuFcpriV7/+3OazcTX7XagQnULtaBXd5XHwxv4h0D
         BiO37HqdeVzY8WEDoVp3jLY0KDYEPYrVKFm4ZnNYU68B8lgTOk2vTIuHAkWucOqXWTAX
         QjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757982499; x=1758587299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEQQug3AovcM6NC71MR7bT+yceXeTwMixGfHwtQI9ng=;
        b=JZj3jceozB61Rctt/ggKrb1hAeJSwD2O0sZISbVrly1V7PO8xeSUbd+ZoeRt5Rnu7R
         0vQrXix3IPibuDukSyxKFMh6sApj7kdFAIPp+kRkA8BFatucHuyvEJz6vl9ewawYckCe
         gqy423NNW/dvfnKXtdswJor6VucE5sAHCtVzgQYU4FIBhr31v+oLlRh3l0zWuINZgFhk
         CCSXxopXEBG0EWzjRJ+T3h751a0POfoyLOJDrdmo+OcBA6r+0Mxkp1Hu9rGvX6j2Gs7S
         TND1vW1vhiRlokG2zl7GZqayintbTjTg4uLcQ5l4Sf5ZNRFqW3RVdarIqwRCylsnEe9s
         zQEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU16RETzoZRpPboF1RTjZW2BCcveDzoRbB79/gR2W08wiV+V4eU6uNG1ZkCvETU4a7d3y7hPuujLhw0Oe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJJY6l1zYynMEV9l0kPzDl8PilavM90Yhwaz3KsIqiRZIrCrBV
	HiL4KGc31Ep1bsm3TCGUc0iYib0N8viGWJjNJ64GdgY/jY8QR0UCEMEsKp1SEg==
X-Gm-Gg: ASbGncv7g/xpLhgoBahZCAFWQHNYU3K6FE3m+Puj3VjEnU7Db2FCKunDNxV/UqbkPFK
	Iu7xS57kNgVxtoM7C6lm9A21xHRnrtVpoiCgSn6KLGOkXSSf4Q6nz0VRpnKn+NhYmbOzok+fQkK
	ZIHA8++efTn70b4oX8MfiblArjY8WQGDyXYIoKG9pnW7vBwmLG59X2ZdDgMj95os8Qq0D1CNz8y
	G2+yyn/0mXFFpQ0BKo7EcVKwnzm1hlXA0s6AnDVFwRmkUboQyEVpR/l61aGPMtZvubdnSVAZk08
	bjtBwiAx6p7bwAeEpc3MBToUdRr9tILINRaiAmAU9R0GqSX8waxlfIVFExql8rgaS2cURjwfzgq
	eE7L/wOgX3OfL/HMPJKJi5paG8u+rHS1MzdctPjaFWNDAZ13zIQqZKmX62dsw2xzEy7SU8g0f7Q
	bUuOh3S4FqqJEzA1HosFQV98+w6O9QYLWU1nEKuY1g/W+2oCf4LgwD
X-Google-Smtp-Source: AGHT+IFGrUhDUZRFH7v5XG6LjyJa9V2kfPAslsRYf223c3WwW8aGdWipXFrqhGCYo0wOCCkc3MS2Zg==
X-Received: by 2002:ad4:5fcf:0:b0:78d:e0d:31cf with SMTP id 6a1803df08f44-78d0e0d345dmr22431416d6.50.1757982499152;
        Mon, 15 Sep 2025 17:28:19 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763bdd36aeasm87765626d6.42.2025.09.15.17.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 17:28:18 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 64034F40066;
	Mon, 15 Sep 2025 20:28:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 15 Sep 2025 20:28:18 -0400
X-ME-Sender: <xms:Iq_IaMC6QsefsGGfpWTKv0ug1RC9qmuKeAxOzvSATmBbDImg6nLfxQ>
    <xme:Iq_IaHJHgGtlEMgGIVbD6GPvUqpUEh3DUu6YShPyZmvHIHuJx0h16OtPGTVTdgZxl
    _Ec56Qo3NBw8jjfbA>
X-ME-Received: <xmr:Iq_IaHCqy7Vf_uIbFHuG_Mn3BoAo7xG5vmncRB8gF5TlFJ7GVDf8fpyntTls>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefledufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    uddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgt
    phhtthhopehmihhnghhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhphgrseiihi
    htohhrrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhg
    pdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegrgigsohgvsehkvghr
    nhgvlhdrughkpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:Iq_IaMtM43E5NGQdNYkGluApCF-KIora_OqZ8x15gPRR-gqWF2IxDw>
    <xmx:Iq_IaFR_G0ehqUp_pjgEJw_qI8Lj3T166ttY7lvkWjDOaUyeLN1r8w>
    <xmx:Iq_IaDLo2_zxZ1UgEhflEQAKY-qZHC0Wg3ukS0r2k0HgZ1T94hgdFA>
    <xmx:Iq_IaIsGBdnK7XZyG_iBjIDWFST3rE5AMGEaGLHceoUEu0o4Zvibbg>
    <xmx:Iq_IaK9Bs8PnmlHNSycOj2QxOki3kg_9xFCxkYOGHvsgKuaxXGfXp9K7>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 20:28:17 -0400 (EDT)
Date: Mon, 15 Sep 2025 20:28:17 -0400
From: Boqun Feng <boqun.feng@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Gary Guo <gary@garyguo.net>, Jens Axboe <axboe@kernel.dk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tip tree with the block tree
Message-ID: <aMivId3faSSzy5v8@tardis-2.local>
References: <aMiScHEWoOABPgt9@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMiScHEWoOABPgt9@sirena.org.uk>

On Mon, Sep 15, 2025 at 11:25:52PM +0100, Mark Brown wrote:
> Hi all,
> 

Hi Mark,

Thanks for reporting this. Your resolution looks good to me. Thanks!

Jens and Andreas, if you want to test this, please wait until the fix
[1] of tip/locking/core (top commit should be 17d9f8eaa87d "MAINTAINERS:
update atomic infrastructure entry to include Rust") to propagate to
tip/master (and then linux-next), otherwise you will get a compile error
because of missing a patch. Of course feel free to test with a manual
merge of tip/locking/core and block/for-next ;-)

[1]: https://lore.kernel.org/lkml/aMirlpnVNLqvwdCu@tardis-2.local/

Regards,
Boqun

> Today's linux-next merge of the tip tree got a conflict in:
> 
>   rust/kernel/block/mq/operations.rs
> 
> between commit:
> 
>   90d952fac8ac1 ("rust: block: add `GenDisk` private data support")
> 
> from the block tree and commit:
> 
>   b6dd7b75496c5 ("rust: block: convert `block::mq` to use `Refcount`")
> 
> from the tip tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --cc rust/kernel/block/mq/operations.rs
> index d098a8a3e4340,c0f95a9419c4e..0000000000000
> --- a/rust/kernel/block/mq/operations.rs
> +++ b/rust/kernel/block/mq/operations.rs
> @@@ -6,15 -6,15 +6,16 @@@
>   
>   use crate::{
>       bindings,
>  -    block::mq::request::RequestDataWrapper,
>  -    block::mq::Request,
>  +    block::mq::{request::RequestDataWrapper, Request},
>       error::{from_result, Result},
>       prelude::*,
> +     sync::Refcount,
>  -    types::ARef,
>  +    types::{ARef, ForeignOwnable},
>   };
> - use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic::Ordering};
> + use core::marker::PhantomData;
>   
>  +type ForeignBorrowed<'a, T> = <T as ForeignOwnable>::Borrowed<'a>;
>  +
>   /// Implement this trait to interface blk-mq as block devices.
>   ///
>   /// To implement a block device driver, implement this trait as described in the



