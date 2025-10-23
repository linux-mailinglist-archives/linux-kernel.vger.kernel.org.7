Return-Path: <linux-kernel+bounces-867386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5203C02779
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2AAE3A3885
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51914D515;
	Thu, 23 Oct 2025 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QcTgrd3M"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B91245006
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761237286; cv=none; b=G8Dz7EwP5ylmgxaQ2FCCdLypznFSOXYPvDGOWp0qkphAuU2BSgEsr5N4HwypPZho/mvVqmEVnP2igAgLSw5pKlwbobbfndw9Ke8BHoquuANSzoZ6sbg1FAKlTv4ks7bWz+oeyuvxqnxK4UiHkA3+Z8hyTUsmcME7WiKdqaQwm90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761237286; c=relaxed/simple;
	bh=NdJU3UtFyyI6EAB0mdJauQZVuKzjWi525UkH7p+1tDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E36hn7YXXkhcMOMrQxgHCGs8lUqINiVImoPqsaOV9diVduXXwui0RjwWytOUqTiLDwuXFpX4ys8tivepVrLuDwECPbufOvZLl2mQBe1DEjVFJsjvBOg2kdsBfy64vTP2nmC7wCI+1MBizn5pcZG40Ho+SSE7FziX+fPH5UqLJ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QcTgrd3M; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33d28dbced5so1407878a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761237284; x=1761842084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nX9LAccgZaMv+QMKej4XlkjO3db5yZqhpWW8M0KAbQ0=;
        b=QcTgrd3MF2as7trvAq9GUBgnCl6e8kPYjIu+PCkUvV5pYGVE6Q8XuoN1I6i+FyISS5
         A5TLn35y4eaKjFfRAPg1d6UqJUnkowBi8dInSm41qw8Hac0crHVd0XpXPXLHYSGuMX4y
         7qWq7DrnU9YZD+Jo69lLln1HaltB04YcxlzXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761237284; x=1761842084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nX9LAccgZaMv+QMKej4XlkjO3db5yZqhpWW8M0KAbQ0=;
        b=pfyBzxfmH0V/mLIiVYhae2JclKAjGDaK04f+ntDh5boD5sxWlpMb9mMoDgD7VZQvUN
         uwgp1yh5wTHsw1TCcOfVSApZUZ89qI+C+5589wRX4b0ojD3Gu6h6kUj5FudhsmqX00sP
         YTXz+K3YcLnDQq9x7pkowa8/w0rzckNrouYjbaQKXZ8ZHleaXS/0uY81nkrqrMZ9nmgM
         TbYemyMI+nKEQErEDD/85Up6Sq0eyX4Pl5wZmGhtqyY23Vlrj4V8dma3Rs3JDJgNqChY
         VO/8Cqp8enkA+RsagU2DE9Li/0HJKx2ni9A8WSpGjVBTgnmJggkpqwexvVnYmnCbjx5d
         /t5g==
X-Gm-Message-State: AOJu0YwYZALUXA1yMh6TuEEeX1PUeAUFipUrlUYjBXadzDYcFZzurjaA
	1e3sAEBKyzTb/KgdEqXdnUybVU4ergYA1NFRDWD4Fgud4UKBACKEzg8M8kBYSoeXNg==
X-Gm-Gg: ASbGncukzi+J9plkgq4Kgxl+kjUc7GFU5LjjKbIY8gz//qZjhQg1fLVZqSHrlfiK0lf
	s7oM4j9jphBSS/I0aADpsc7kgyVgRNHY3yfQA7EaZIjqOcT0fWjxhN/XW6LHy41c9WkJRe/rWlI
	vynXTc6R63FqYnByp/F5K/lO0A13wjw2t4GhyjPSVatyuff/JXvIihix/39BCMLsiCiMXUphWZj
	U5cU4rcYLc6cGwQ0La/QukgIeOJn5InGADhJIhV1lG2wZlg7EBakreiItAdcFEbEWuehxfFZ/br
	gOOIc27JJezDP3KsucRR1WU21k4uzeuabdVPqpmjs9gzh7MkBJHf+pllTmzakLt7s6JxXSZMLd1
	TR2JjjvYIrZI+wR/9huGgs+0VvjZETUEgVM1M3XySD8N86fhG8CQCdz8657EQOq7UMWr928/QRi
	rDOyt5QbAhGJWc79WynZMMEcLEsOEA4Hs1TbkS/g==
X-Google-Smtp-Source: AGHT+IEynXNDvnfI8YSlbXXclhPHM5qTj+zDVsUpWXh4APjJovTYiDiqoNYTvE67pyZbtDRPxrgDHA==
X-Received: by 2002:a17:90b:4c92:b0:336:b563:993b with SMTP id 98e67ed59e1d1-33bcf8f9153mr34119278a91.28.1761237284591;
        Thu, 23 Oct 2025 09:34:44 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:839c:d3ee:bea4:1b90])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33dfb683d79sm3983674a91.2.2025.10.23.09.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 09:34:43 -0700 (PDT)
Date: Thu, 23 Oct 2025 09:34:42 -0700
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Ensure power-up succeeded before restoring MMIO
 state
Message-ID: <aPpZIovpDU2KU_gg@google.com>
References: <20250821075812.1.I2dbf483156c328bc4a89085816b453e436c06eb5@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821075812.1.I2dbf483156c328bc4a89085816b453e436c06eb5@changeid>

On Thu, Aug 21, 2025 at 07:58:12AM -0700, Brian Norris wrote:
> From: Brian Norris <briannorris@google.com>
> 
> As the comments in pci_pm_thaw_noirq() suggest, pci_restore_state() may
> need to restore MSI-X state in MMIO space. This is only possible if we
> reach D0; if we failed to power up, this might produce a fatal error
> when touching memory space.
> 
> Check for errors (as the "verify" in "pci_pm_power_up_and_verify_state"
> implies), and skip restoring if it fails.
> 
> This mitigates errors seen during resume_noirq, for example, when the
> platform did not resume the link properly.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Brian Norris <briannorris@google.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Friendly ping on this one.

This bug causes quite a bit of problem for some Pixel devices, although
that's admittedly because of our own failure to resume properly in some
cases. (And we can recover later, if we don't crash here.)

I believe the patch is still a good addition for everyone, in case other
systems fall into similar error conditions.

Brian

