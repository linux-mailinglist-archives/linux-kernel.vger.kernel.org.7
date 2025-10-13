Return-Path: <linux-kernel+bounces-850996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F03BD4E56
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE5F18A2634
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16823308F02;
	Mon, 13 Oct 2025 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYZQfS7j"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104EB2727F8
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371526; cv=none; b=FqdDHNJp2qPZBw7SrnfNz+7HrFrxxR9DRzMjGgroQ5uHLHh5kRuihrGwDluoj9OIW4IsGpRWydjclBnduiyQ0+z63iM7fz/qCIIxl1ONvsUBZGZ5hjK0j0JEnLFKa/dFIRcGG8oj/HmMM3X4B+BfbJevFztG/fsHiwMes24pKxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371526; c=relaxed/simple;
	bh=/WZ2iZes/FlXVVyMzwUFoWChBG8onTh/NJLcp9lLj+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiQDrw2fAUP9GuY3Yj23s2iwFfVILzKCgqETb/F2GWeRaAhydJzZKPeM1+5I6rB6TL0Xvpj/wW9TnkjphHX20nxnNt8aW73OgPDSxSoNGIAOrjONSCbiKx/x2y65v8q6ri6SPnw1RZwPI0eD3Yjq43mmajLnOjpq2cpv1n6RbXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYZQfS7j; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2681660d604so48742415ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760371524; x=1760976324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TrAN3NU0vqcbJuaRJ1d2MIegmQseMHGwlXximXGEwl8=;
        b=dYZQfS7jM+4lB4YmvO+ZD4PfwVEQ79LlVARNKjqv6hUYmhGG9vkcxWY64g/xXkf6qV
         fUo+LdfN+d6c881HSZwuOy0lXR/26pmuB/bcY1sQlpLkvhhVrKkb/5Yf6xEnAfr+2G2I
         tBiC9bSohYNfIzImJlV5ZQoLhLnGpJMtD3C0ikovujOydC1lKPLeAFOzBT0D0Yi3lXI0
         GZywYQx82h4B7NTNhvo41mrFepsufUv300aB9gM7M29Ek/RzXgAxIXXjx0AMb49mpyJs
         ykKJgTiOnY/xUhEnQyoOQDCkFXl5UgTDXQa9pemZiJaX2DW1NKbMxxHZ1Eyr9FzXN+w0
         OtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760371524; x=1760976324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrAN3NU0vqcbJuaRJ1d2MIegmQseMHGwlXximXGEwl8=;
        b=qvaJXM0zp1wuYoR6d+l3zQmuOSBohPpvPaFtYr9Pgqb262JfaTPGxZ/BtaOqVIpC2F
         88kjfJ12JZyXjxDueG+gppyKHPXM6NvghtItuTUId0jhyun66ahv079fJhVuN1LpmXwO
         61beu5mUKRibC/DwHx6Dw0abjHezctHJ7uDrCE1K3FNp7rDmu/fB27RqxBDeuUXlR6pQ
         djaZw6JzWRTjOEum+jaF7BQSSb1L0Y/jazSmHDL+G3GltIX1FHT5XUIO+AcRGdJl59eI
         3tieVrjW05bhR+KtoqI4ZKDe7w/UADKA9dSMsiqQpSPDNOIKt0LLeT5KjZsUs9kXvXZj
         TV8g==
X-Forwarded-Encrypted: i=1; AJvYcCUJCJPEiFeUsLQjRhJhFCBjwSSLby+yMMQegr7cJa4+TzmNLunOR/wtz3bdQOSjQFZ2DxubG94xLNFmuck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxTpCrBvo7wJmsNiC0BLSXEyWWC8soP2iTqoS2eg7J31mJDk1q
	jxrZcx5/59/2Mk3c3c3J6KNeW4KrQm2MVY6elFxF60pqrddWrvrmNt8hUB07SQ==
X-Gm-Gg: ASbGncuOYRM3vsD2YvyuvVbrzsXUM4QOH52ukfAhZmQ14GYe03JMXqGSvaBCQyzu6yo
	OZhNkrqvwY5+OmB4o5rISILjOj+wpzCacXsAeqoZuQGVRoMiBe//paL56EvMuxoBamj2eXhh/Hz
	Qw5IW2HrnaQtLvJPrDOxclTSlEVmDFGVKVX5FCEvI9D2NUKkCuduhbH+n9itDOobc3cECl2xMZA
	NxGZJVMx+pfdfrTqMeF6nWvBTpwdrVBW8ofGeDCWwEKpTGC7Or0xlEZw2ki2eFcI/u7R0B1fgFQ
	YSdjJckEuh6KD4mF47FwonQ7qL+mGYiqKfRlVbJNM8BAQEsByCsRU6B/aFUS2UN18ymqn/NMywi
	ObVHDTW/OsA7PJPRs+hogDv4fJte54fCr6j7pVP1h2vCUHAWVLjQhQHXus5bSuiOVqyp+VHx8I7
	5VYD+2/Dmw5l/JA5Da
X-Google-Smtp-Source: AGHT+IFvfAdODfTPcXlpP1SbDfro+d1+gc2qO3OfakrxvU4VDJJdZcivjZxkr4gBXLeHcfR3g8h09A==
X-Received: by 2002:a17:903:90d:b0:286:74e3:3889 with SMTP id d9443c01a7336-290272f93damr274113155ad.55.1760371524106;
        Mon, 13 Oct 2025 09:05:24 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:2811:1686:ffe6:64d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f3de4asm137517305ad.92.2025.10.13.09.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 09:05:23 -0700 (PDT)
Date: Mon, 13 Oct 2025 09:05:07 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hunter Moore <Hunter.Moore@garmin.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: Add marine keycodes for radar control.
Message-ID: <2rtgkpu7dzfxrnmepwxmxmemiqmmbx4fl6ow336f6spjdgqj7k@fxgfc26vzzkk>
References: <20251013152309.880-1-Hunter.Moore@garmin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013152309.880-1-Hunter.Moore@garmin.com>

Hi Hunter,

On Mon, Oct 13, 2025 at 10:23:09AM -0500, Hunter Moore wrote:
> From: Hunter Moore <hunter.moore@garmin.com>
> 
> We are looking into adding some additional keycodes to add support for
> radar control. In total we are adding 29 keycodes which seems to
> exceed the KEY_MAX limit set, so we have also bumped this value to
> 0x3ff to double the available keycodes.

No, we will not be adding these new keys since I do not see any users of
the previously defined ones anywhere, not in kernel sources and not in
the HID specification.

You seem to be creating a purpose-built devices where you control your
userspace, and I do not think the new keycodes will be of any use to
anyone but your specific application. You are also unlikely to be
running anything else besides the software that you are developing on
these devices, so I'd recommend simply reuse parts of the existing key
code space for your purposes (KEY_MACRO*, BTN_TRIGGER_HAPPY*, etc).

Thanks.

-- 
Dmitry

