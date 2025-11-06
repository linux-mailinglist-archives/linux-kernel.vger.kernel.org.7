Return-Path: <linux-kernel+bounces-888927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F08C3C4B7
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9139050339A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068BA34A3CD;
	Thu,  6 Nov 2025 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLQ91vS/"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF77733509C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445355; cv=none; b=ojfX0OH0ru3VGShrxLFqnSle5QlEpUqWVqSa/VRfBwQYbaaGeLJQcukfo27d6u22XS1zf9wJPCC1HpdbAT0TT0GrqL6oFrYZ9n6c0ZIIJwOEfqq7k+bL2O+hDSGL849POW9AmiJQOrmyuejQWbCwyrke9rCZJ5J5HsG3lPyjl/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445355; c=relaxed/simple;
	bh=MLg3hiFxO0FS9fuavJ/JSEbJ+y7jTxCzr2x6pNOCnlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsppUjelHCfyqPzJgL/z31q9R6LLEkObn0BPbIBWgBmT4dqUXibAh2P/H77MCO7k95zSeOqz5VVADZhdWg9AvlpiLvgnq/vYRV+OLnmz/bZKASBTt7N3spp08QSFfPVXOYupNDkYOcaycjquMfgiWlodOZl9bgUrK+lRJs0sHzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLQ91vS/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63bea08a326so1149707a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762445352; x=1763050152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G/WVmVHenIdK3KCEFMeF1CP0bfdkN9fPLWoBNVC7n1U=;
        b=ZLQ91vS/bfZom87cO0VH4z4+nLi/6M8Gm72aETRZONIbkQTPtPBK4H7c/LTYfvdbVv
         qCv+2hiCKAvHQzg8fDvaGjhH7uyICIY+xvaNF9hksHBzNaloHjxdqSOAVX13JZjkDSiR
         flvZAVEja5fGsu/PxE5N1kNKez8/aEYhXjGvlzRMMwQip5cnSgowtoag3PVSJY+YGP13
         +DPhbAjWTY940eo8J/ex8XGCACueuk+3h9Q94fx5m+7oR6ZwXeg2sJAv6FSTXwgVGg93
         XAWhfwOuHtyLNHahfF9THms6ouDceqDnehVv1k3pedkBgVSgXMsoSzgYdNHJ6W+IKTEq
         8Fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445352; x=1763050152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/WVmVHenIdK3KCEFMeF1CP0bfdkN9fPLWoBNVC7n1U=;
        b=T7QfBwbxH7N3E2KejtVMcIaggr4LXE3jGdGeiWdveVdokytBJ0Tuk+NXYpXUKRtF1d
         Ebw0HEvJfv/0gSRktM0jlTE/s13lZFoud3L89/wWzWd80xMB0BIyWj3ezvXmnTqqfn1y
         fjOC5nuH7jo6iqYgafCNChp7kCibsDKqyw5J8YsKk/13h+EifSsw/fSJsF6zUd1iQ0on
         wzIILX0x0IUsocw4qwHGkmADCslmcK9wSdxrKV6hAv6/3Esu04a+kYLpQrsgVJzeKPfL
         Ol+eDo/1r/bufivGChIqGG4r2rXUU2o3uqJ7OgJtMcIuVyWurSh/4W7Ldm95QJY4BDdQ
         jOpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWnhEHPWgHtSgCkpWNdv7hekyvpGb3nZKcvyoI3/TAHjVI5f0bV3AjfcD8i+p3w45nc4+BPalsduGi9PI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuMydZe5azUOR22tTzDPjhfHu2W3hPZa3Fnwb92WFkpyrOgAxR
	Dx35CLhKKPlVSWcTynL3AKwlYqybJc4PZ1foISgXIs0J6BJzPTeaXy/VLlWsRz/IljpPTHu70tw
	F2gl4whcJsffkhylga//F7kOfVAjHRWk=
X-Gm-Gg: ASbGnctRTuoNDz1nR2cuSi1VeidxeLVBqWW/BsnJeO3Wpt3kpcdrKyx+N4teex6Irlu
	cDZUmGexLoCahgAMweAELLfWJET8L9AiBO4Jvy85G+XcXg71tVb1TSMuY5HZeXDZVsT1jDoZltI
	7HKoVMVQJQQjzb+TNuRwbjIOwfI/Xt8uCDl5UXwqjiHdbdof4Bwa9dD9zWEA/Ayq9RkDd1YunS0
	SmdEYfPqdM95abHFE1mQrYDjKvvD+EPWy+h0lELMrmcPIx7yHm4hmImqgvKgTWl9p2hN5UY9v64
	VShtRul7aLESbuq9f7ePWnQ/EPsvy20/pQVbyPd8iw0h3Mqiy79Dkx/7mUifhS6gFQ==
X-Google-Smtp-Source: AGHT+IEhSIJc5Z5I5NnrKkJBGLV9NZNcAoGr82x4X4tSXvlTQWMJrPj0B4VjrofC5qDWeUguEUAvAwWik8JyOF9e8g4=
X-Received: by 2002:a05:6402:280a:b0:63b:d7f0:d93a with SMTP id
 4fb4d7f45d1cf-6410588e1a2mr8115751a12.3.1762445351811; Thu, 06 Nov 2025
 08:09:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028174222.1739954-1-viswanathiyyappan@gmail.com>
 <20251028174222.1739954-2-viswanathiyyappan@gmail.com> <20251030192018.28dcd830@kernel.org>
 <CAPrAcgPD0ZPNPOivpX=69qC88-AAeW+Jy=oy-6+PP8jDxzNabA@mail.gmail.com> <20251104164625.5a18db43@kernel.org>
In-Reply-To: <20251104164625.5a18db43@kernel.org>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Thu, 6 Nov 2025 21:38:59 +0530
X-Gm-Features: AWmQ_bl5uAbPtelIBkdQOTDm-ZMeds5DYrYna8z74wPG5EKsLuiEbCWlKgzolEU
Message-ID: <CAPrAcgMXw5e6mi1tU=c7UaQdcKZhhC8j-y9woQk0bk8SeV4+8A@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH net-next v3 1/2] net: Add ndo_write_rx_config and
 helper structs and functions:
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, sdf@fomichev.me, kuniyu@google.com, ahmed.zaki@intel.com, 
	aleksander.lobakin@intel.com, jacob.e.keller@intel.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	david.hunter.linux@gmail.com, khalid@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Nov 2025 at 06:16, Jakub Kicinski <kuba@kernel.org> wrote:
> I wouldn't use atomic flags. IIRC ndo_set_rx_mode is called under
> netif_addr_lock_bh(), so we can reuse that lock, have update_config()
> assume ownership of the pending config and update it directly.
> And read_config() (which IIUC runs from a wq) can take that lock
> briefly, and swap which config is pending.

How does this look?

It's possible for the actual work of set_rx_mode to be in a work item
so we need to validate that dev->addr_list_lock is held in update_config()

// These variables will be part of dev->netif_rx_config_ctx in the final code
bool pending_cfg_ready = false;
struct netif_rx_config *ready, *pending;

void update_config()
{
    WARN_ONCE(!spin_is_locked(&dev->addr_list_lock),
    "netif_update_rx_config() called without netif_addr_lock_bh()\n");

    int rc = netif_prepare_rx_config(&pending);
    if (rc)
        return;

    pending_cfg_ready = true;
}

void read_config()
{
    // We could introduce a new lock for this but
    // reusing the addr lock works well enough
    netif_addr_lock_bh();

    // There's no point continuing if the pending config
    // is not ready
    if(!pending_cfg_ready) {
       netif_addr_unlock_bh();
       return;
    }

    swap(ready, pending);
    pending_cfg_ready = false;

    netif_addr_unlock_bh();

    do_io(ready);
}

On the topic of virtio_net:

set_rx_mode in virtio_net schedules and does the actual work in a work
item, so would
the correct justification here be moving I/O out of the rtnl lock?

If this looks good, I will start working on v4

