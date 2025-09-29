Return-Path: <linux-kernel+bounces-836816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71886BAA9F6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 23:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13473AC5F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 21:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339612561AA;
	Mon, 29 Sep 2025 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C5l+1tqN"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C782BAF9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 21:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759180368; cv=none; b=NXXOLgEc1R2h3+aVhX6fABq4aEhAnnhpzOlbNELfyFW10IQeEuOox+vAgCqvfp33BOq+rs7eKh4/m2IAqFsOLcyzIIyp7Cah1yxbeyvThgVOWTdz7b6oUlXX8WUWfYv4yS4JYa/huGgbtDE9IpMCdWIwiMl0KlZcB2K1kCZfO7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759180368; c=relaxed/simple;
	bh=ucZGbeD2jgRbnFjnBdfRBfd6INgysz5vu94Nfod+6qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHlUVNZ1GeqcjSTPx07HpK0K7Dbnow4HdEDNgr2sQFGEbhXN36v6GB1Zrmfgy0svDUExC8b/qTX6TNYtEPaaxIo2GOI58EwA/QAJOeINaOz2NfuZ9pzhmY7eNjiLgiNUJjVBFf2GpnHrDg/30eImtxc4fj8JhFe9Gnqa+B8P+GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C5l+1tqN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2731ff54949so24075ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759180366; x=1759785166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OIfyYpz2B+MAq1aJjSBfS5pMbU0uCMwOImE5fOq4OkU=;
        b=C5l+1tqNIJx5PWyMTGYIaXzImLwInUiYEhBTXNPbmPIxcKfLRuhN7C1HkCR07Hp7t4
         RCm2b8UeZTix6/4VO8tOzMnztQg2H1PD/H28Sk5MT3SpKnnnfqYXYTJVBuaz6YWyfO8j
         BBUJ3yBZNCW3zkdBipET/X8GM0aW117JWim2WfKEDR2hV1BmEKdAcYVE3ARO/QXELaXi
         6Qarwuo1hu2IhkgNl5Y+to1SWIrsv+J0lu2+/7APi5qGZWrtGCD99C871EKx13n546ki
         ISoaqG8pWxBcKMHc7ZLyxw6OC5K4craQaK3nh9Hqguu/FpRviEVWGAW9SaKpF8DE5n2w
         voZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759180366; x=1759785166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIfyYpz2B+MAq1aJjSBfS5pMbU0uCMwOImE5fOq4OkU=;
        b=tmYGUq1JjZY9tZS5eSCGtV8G0K7UHu35GGBKAQ4z2r8RbVO9pgTk5lWngUcmcpXH8K
         79pQW63K9FaOUGykDohkCb+KgDHaGR6xEi9DhmTa+L2/8Ee1mg+LbJ5TfHJVjCW2XMHN
         39HyHAZslfTeR8rocz44/VQ6Ybm8SPrrBHQ8lnbCD4lgudAufeFxW2uR42ZKB0bClDTE
         0fB325mN0bV6b3AR0h3wzsmb+zxpQEnbtcgqOnQKZbYQmUUS56WgfTEnwrsFWOsimCUc
         UMX19AC61BuSH9vYM0OUiIFKkbOGWOSOpuD58NT+J8Xn+osip298rIYFlf2aHpuBuMLz
         hHKg==
X-Forwarded-Encrypted: i=1; AJvYcCWVFYtmVfPNT9R/9NlpnHFLYlnUaIpDdjXbCzV3nSzitmcsdFXOMZHTTabqcgwINJv0DhlG4rW17R5VAfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOYp5wG7yaNiimnGvekwlgMSoDVyjuyC/cIYWfh+9lq6y8kfhb
	UHII6sBPaLOw0iT8wt8WAJwYexs8YbG5BWAkMBUcesyt/ry2y2OBH5WPta2RIYzMjA==
X-Gm-Gg: ASbGnctCU+xu/NAJEyRQCSGKuxzw6KJOiLL3Ac6d9S3wU1lph3pvWAesOAW3Q7sKbEs
	7OhBS9E1I9cx4kznEzI9sXXbaWIxcv/+LZ1bs88V/tAPXNQ+aafh1w7dX0/RXBVJJy+72E36ljI
	vnENYTw7l5dT83XMq3LLbwq6YxeRBB41XlfQwqoWKPKmxZpKKyhyMq36M/l7YR600SUnjIPHv/7
	+ARaCiTs2OPhq8J62c1btDnqFpz8CRsRvWKYSQH3FvMVn64FysN/jFkL2Hfiel12gXjkvM5CdeY
	NbaxZMQPCHnz5y3fz1OMsP7vA1nKInGvd9wz0PSZqjmoJrLTQwkf/6MKrT4zijXpbs9vvVso8rN
	3IT+6opMXgBXLRi2glMgqkyskH29f9y/iP1rJ7cSvAJ0HmZpP/4SrkbZ2xiKmIT3ljAdYhzyy/j
	DjxdpO
X-Google-Smtp-Source: AGHT+IFHVKzSY1iaogVEqA/cVnoS+cV8hLcXtNEd5U5wg+PyxVcPVXIy6Lt+6+KgVtbONxEXN/NMFA==
X-Received: by 2002:a17:902:ecc6:b0:269:63ea:6d3f with SMTP id d9443c01a7336-28e1483e39bmr1896985ad.8.1759180366094;
        Mon, 29 Sep 2025 14:12:46 -0700 (PDT)
Received: from google.com (235.215.125.34.bc.googleusercontent.com. [34.125.215.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cf9desm141448085ad.6.2025.09.29.14.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 14:12:45 -0700 (PDT)
Date: Mon, 29 Sep 2025 21:12:40 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, maze@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	erosca@de.adit-jv.com, Neill Kapron <nkapron@google.com>,
	John Stultz <jstultz@google.com>
Subject: Re: [PATCH] usb: gadget: f_ncm: Always set current gadget in
 ncm_bind()
Message-ID: <aNr2SMzxFesKg4aI@google.com>
References: <20231020153324.82794-1-hgajjar@de.adit-jv.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020153324.82794-1-hgajjar@de.adit-jv.com>

On Fri, Oct 20, 2023 at 05:33:24PM +0200, Hardik Gajjar wrote:
> Previously, gadget assignment to the net device occurred exclusively
> during the initial binding attempt.
> 
> Nevertheless, the gadget pointer could change during bind/unbind
> cycles due to various conditions, including the unloading/loading
> of the UDC device driver or the detachment/reconnection of an
> OTG-capable USB hub device.
> 
> This patch relocates the gether_set_gadget() function out from
> ncm_opts->bound condition check, ensuring that the correct gadget
> is assigned during each bind request.

Hi, sorry to dig out this old thread, but I'm seeing some issues in a
downstream kernel that seem relevant to this patch.

It seems to me that swapping the parent device like this might be a bit
more complex that it appears. When the register_netdev() is skipped for
the new parent gadgets it misses a crucial device_get(), and this leads
to an unbalanced reference count.

During tear-down (e.g. after device mode switch), the reference count on
the device unexpectedly reaches zero and the gadget is kfreed. Note this
doesn't happen with the gadget that was initially bound thanks to the
register_netdev() call.

Unfortunatelly, releasing the gadget device after ->unbind() leaves a
dangling pointer in netdev->parent. And certain operations such as a
netlink dump() will attempt to derreference the netdev->parent as cause
a use-after-free.

I checked this behavior by tracing several paths and using KASAN. And
looking at the upstream code, I believe the issue is also present and
was introduced by this patch.

Please let me know if anyone has some ideas on how to proceed, or if you
need me to run some specific tests or potential fixes. I would be happy
to help.

--
Carlos Llamas

