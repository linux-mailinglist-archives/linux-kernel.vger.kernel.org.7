Return-Path: <linux-kernel+bounces-847002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9F3BC99D2
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B3919E109D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B762EB84F;
	Thu,  9 Oct 2025 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MntwWWGX"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DD542065
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021344; cv=none; b=HHuNwTH3PmluT3+XRDRJRgB/GgXfsL2frYQxjYabMTsGi9SnlGHeFCpHP3+s4eEcy1iO9KNmIwQzGdOHTRyTJtaVDIeyqz2Uj4Yvd9hPrZBVuGNBAs2hkqO5ZpEl9iHnSOl0RGWOCVYQDy7wTmnpxonKiaKkqpntBXzuexh0+9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021344; c=relaxed/simple;
	bh=1XYLuOFbNFgiZvjhYKmjcRhWYH+0tPHq30+pyiPCvPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYKtgm/MlmbOin4p8qScjNjGKPlmW5vqEjuyunoiiwf2ryPhYTqUme+fvA01NDnEHnki/1O6vUagO+7dH53OserWzAfmgnQcdFDfwp4BlGKYmlOOUiUn2NU3AwsvmSqT1MIaRCK3hQk71oSPh4AXwJSb+mBCGceRACHE7IepDpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MntwWWGX; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso1181320f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760021341; x=1760626141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u3VbnVQItkD+tFNuLwAYfAssjXKroSj3yDUqMHNh5A0=;
        b=MntwWWGX1REHHZn7h/G+PnaF9ijD8WBJNv+Mb5VEITfjkJJLoGWE6iW56T68GOocAv
         adJposbyQI/GZOmZ7+UAiEuOqRBz2JJ/the2a7sdWwyRxeE6ahbhh0IgkRg/UVQ/CMF3
         lz0yr9e/rBknCIS5uq+nZ2IFTNJf5en4T5N5pqXYD3Wnn8gxmirS3bnTWRrKH4SyfDgE
         Tl/Nl2+g5e9lpksAFlz5gwulQdlgL8pSkv6VebVtLA9zrUdm5nljVdWJ44BlDay2tR2S
         FZawlxWGLfCHJVWPOPTUSyNMiW1z+zSU2h4mtKpo1df1Xenm5TcPUl9rnLbWb4P8tQrv
         BRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760021341; x=1760626141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3VbnVQItkD+tFNuLwAYfAssjXKroSj3yDUqMHNh5A0=;
        b=nBXGI+gR+QPlEGdviDhObc+AvId3j9Tg1Cbe1mIiBdqFd6T2G8YordMBauZpK+xAKW
         ap4CSNxyYe0WgEte3P0Ris0yN3jR6BiHJUcgFcnpbv4dhpYtQraEF+6wmxXE60PNktpn
         /T0vIV9E2b1w1IlQeron/wIfTTQHvRPT3nR9a6JKJFjIeoLzmqcTA54FtOpz9SWK/1oS
         o9eeI7KN9sbp8gwZEzBifdE4z+Pex2lwOrzO8bZQcTEDyNhMlsEXUOH0BCp0scBWKY1q
         GqFOb8mGL2ablITM91zgx1Zsa1mR4keMCduVtLhvoUXb5SEpVLA2LhIl27EQTxhsJk9Q
         43jA==
X-Forwarded-Encrypted: i=1; AJvYcCXt6zSF1FsIbs1g1qd5b+VGh5TH2JzAW6eQ5X/VGMtle1+GAQhg5fiKnFlIcGEaQZj1iljunGQvHOLsPqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiwd8kXJrvIt3+cuvueKxjOiZVpuVH0HwjGszzwB65Vpm0KwOn
	EEMBCGXflOEINp1c17LvM9oTJB94YwhmpEQxXR+N8OpeCmqaQE9H4ns7UW+lMbp/EQA=
X-Gm-Gg: ASbGncvMCXGxw+E4BcX0Mr6SgrRO/9C88q/19zDCqbXPzYe97C9Cn/TADiFW9/ECoDO
	Fw8cAvCMBujlJVYuN1AS+x1d7A4mtGidxvl1QTb7CSauxhc0UkrXXr5gA5RAS45b+8Qp87n1YFL
	t0ICzJu5WRlERp5kSYBz9/LDFWIZ6bAMYsGWq7WhC43r4Ros5JfC2Ds4eaaPLjRvRqrcCoKQgPK
	Qjvbp/TNH5b60TvyqJj31lmZlUtAL56kYcN2Lcw9wcldmgb8cVZCapQ9E/TY/2dxMzB1Qqae23l
	d6gYhYo/g+MtDplrU+haKmjr6WV90G1nNbSA/q96fqviG8XCff15CtnWj6fUT0n+8QWwY3+MYpY
	Wxv1eJrD9ajO+xfr4X3btaq4qoj7n/GYCegeG7pxyNUZC+oqZIg==
X-Google-Smtp-Source: AGHT+IH8jHNbOYW/v14vdGW4bYpGR39m3BaXqycMwxtKHRkIJeWjN9eQ43l0nvOX5TQ8cDXKACSXmg==
X-Received: by 2002:a05:6000:2912:b0:3df:22a3:d240 with SMTP id ffacd0b85a97d-425829a5a07mr8047402f8f.4.1760021340783;
        Thu, 09 Oct 2025 07:49:00 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab500706sm39603055e9.3.2025.10.09.07.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:49:00 -0700 (PDT)
Date: Thu, 9 Oct 2025 16:48:58 +0200
From: Petr Mladek <pmladek@suse.com>
To: Joel Granados <joel.granados@kernel.org>
Cc: Daniel Xu <dlxu@meta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: move nmi_watchdog sysctl into .rodata
Message-ID: <aOfLWoveGuFEcvwm@pathway.suse.cz>
References: <20250929-jag-nmiwd_const-v1-1-92200d503b1f@kernel.org>
 <aOPa8RClyXaeyV6L@pathway.suse.cz>
 <lgunjvc6dqr7bofukwckd3435odkntc4trboiiwzg3pc55ebdg@hllo5da2yfkv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lgunjvc6dqr7bofukwckd3435odkntc4trboiiwzg3pc55ebdg@hllo5da2yfkv>

On Thu 2025-10-09 16:20:48, Joel Granados wrote:
> On Mon, Oct 06, 2025 at 05:06:25PM +0200, Petr Mladek wrote:
> > On Mon 2025-09-29 17:55:07, Joel Granados wrote:
> > > Move nmi_watchdog into the watchdog_sysctls array to prevent it from
> > > unnecessary modification. This move effectively moves it inside the
> > > .rodata section.
> > > 
> > > Initially moved out into its own non-const array in commit 9ec272c586b0
> > > ("watchdog/hardlockup: keep kernel.nmi_watchdog sysctl as 0444 if probe
> > > fails"), which made it writable only when watchdog_hardlockup_available
> > > was true. Moving it back to watchdog_sysctl keeps this behavior as
> > > writing to nmi_watchdog still fails when watchdog_hardlockup_available
> > > is false.
> > > 
> > > Signed-off-by: Joel Granados <joel.granados@kernel.org>
> > 
> > The patch looks good to me. Updating the access rights was nice to
> > have. But it does not look not worth complicating the constification.
> > And proc_nmi_watchdog() works correctly even when the access rights
> > are always 0644.
> > 
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > 
> > Best Regards,
> > Petr
> Thx for the review.
> 
> I'll push this through the sysctl-next branch unless you want to handle
> it somewhere else.

Feel free to push it via the sysctl-next branch.

Best Regards,
Petr

