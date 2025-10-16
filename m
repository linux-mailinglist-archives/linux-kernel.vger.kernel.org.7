Return-Path: <linux-kernel+bounces-856851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB22BE53EE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36CE7407DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CF62DC35F;
	Thu, 16 Oct 2025 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKbtxVxh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C9D233D9C
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760643242; cv=none; b=dw4FNP/R4aOYeeOHvCZOq6i01JlHy9B2LjUuEHUg+1+7TpEtvg0oNNDbW4nobbyN1lj+SjwcZX634hjp6r72RAS3KkG76aE/ye4/lkyv7KR0adOWBaclvyS+VjaCqE8u/J1hG/komNJYihTiVbUAL40oRNNm0UgLucpsyaSVbEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760643242; c=relaxed/simple;
	bh=nJ6ctnrEA8Q56fp0ViPbOcho6E4CmzCEIQKhpkkDCLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJSorEAs97R6TFryoGn3onAYHwGos+aTahqXbBp964hSNU9pPFu4plKiBoXtc1DjQ4UQzMM1RTatxpPgOxidqhrif8bmnSMxST/oL/7yOZQFET6acHxN8YEuxLoPt+7vgvso3bmHKEawz+mCK8rhMFu0o5sxVGJI6ZSL3thgg6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKbtxVxh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760643239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uiHgWfmK+UdxQ6h4Om3AjYBL36s51e3Yfvg/vhnMSJc=;
	b=aKbtxVxh3xp05tvYUAwWRY9P82wjFRHNJ61EJQt5dVOKznNiA4eePIoxhBtZCfKmioJQSO
	lltNMECiKVfFcBFKPFLXSqvct7PFEzNHYV9BGfqHj4IVNwYR8JugHJLHokV2+4no6mX/Ij
	UjEruIS4ICa/Gtk01NNasl72Rx85UyA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-pXxTt-LvONihoAXK_2GYrQ-1; Thu, 16 Oct 2025 15:33:58 -0400
X-MC-Unique: pXxTt-LvONihoAXK_2GYrQ-1
X-Mimecast-MFC-AGG-ID: pXxTt-LvONihoAXK_2GYrQ_1760643238
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-78154e23a78so14564217b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760643238; x=1761248038;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiHgWfmK+UdxQ6h4Om3AjYBL36s51e3Yfvg/vhnMSJc=;
        b=lu4DmHr3j0iRtq9Yh1eRDreq5+nzzLB1butiBMdFRo4H+Br+S6XzuQP9FJ1Z0M3xsW
         MzE9fpJQoBX365H99TSwZa33hV2Bu3IpGfk0YANEutNYdmIp3QQDdu/YWUtmzPpZfTNB
         CHocX4TthMx60yzm3ORbV2N5LY38bwI499xh3L5Z4vI6R2DOl+XxnibO/fOU1wy7yqep
         O3wl3jJd49+FCFqtyRlWAepl0NrKwUp80Q9dzV/cB4jES/erQ5iSAzfzpei//lzrWXCr
         RLv+2HHu+Mpo/lT62i2LTzuoy4KEYXSCknW9WrA+XEjZSUHWLRhVNL0ogDoPrc/g8Rap
         a/1g==
X-Forwarded-Encrypted: i=1; AJvYcCXNjgmKY5/7mntPqJeeTLW1rRPIRYZpEAJngjn/4tO1An1SdvqOGpRBuMR26gb8l6JRSoMXc8IQXL7IKHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlvyqOfsTa/IP99KBB0w+VzbCqPN55Jx2O3GhC7kJhDlzshve4
	uaHstBIMVSNtSXhLQb5KaAAqaBHoz/BOr1N1gQM5n75gsYJN+Bkw9se9kVbKFVcGHRd4gAx3Bjc
	LOXaJGRl001RV6zWPZCfHBB1dMeHbjKR2mrN4uZqErqazaDEKKU1EkytyK0YpCaWtyQ==
X-Gm-Gg: ASbGnctZtbIhd6Gd9sCrLhmfYtkJDwDZxy/Oc7Dq86uWAtnHNzsAZLlnmSlAnfaNlka
	ITQjZPiaLjOLoHFGUftklyYpCWXkvfOVfEbvZz2nVAHQTemq57fYz/9SIYOSrjTHHBKjckN7XpO
	kgKcaLfC1MAhfdb0Wt3SHV7aa5avU5xKO/l/m6tHwT76cbgn1TqBlMNbOGKtNAUN3h2N/Cgk8p+
	3yZ2Kiv8kfP1LpSUY6naCJYaBvisoVlO0hl0n7gc9IF2OvavlDUwHFQKSBnpeE9Lu4+jQkl0YMQ
	R2jUA/TgbgRmY6FiiHlrtGmARJmaVrhJVEcl3JFXF2G1tENLJXUqIp/XsCr5XKpV7IaWKFp7XIQ
	7RzhM+U2bbjscMneudFbsz2996rOjOA==
X-Received: by 2002:a05:690e:2510:10b0:62f:c634:4b3f with SMTP id 956f58d0204a3-63e1616c2e1mr1013795d50.7.1760643237985;
        Thu, 16 Oct 2025 12:33:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMio9VLzQuuBpiuwQhgCpujKJGVl5WrcNOxS8afEZSVyzHjxnIZGruiRbFQ1+FjVygkA/akQ==
X-Received: by 2002:a05:690e:2510:10b0:62f:c634:4b3f with SMTP id 956f58d0204a3-63e1616c2e1mr1013781d50.7.1760643237561;
        Thu, 16 Oct 2025 12:33:57 -0700 (PDT)
Received: from redhat.com ([2600:382:852c:bf2e:3d5e:51e0:852d:1b05])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63e1983c9f3sm83895d50.7.2025.10.16.12.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 12:33:57 -0700 (PDT)
Date: Thu, 16 Oct 2025 15:33:54 -0400
From: Brian Masney <bmasney@redhat.com>
To: "Zhou, Yun" <yun.zhou@windriver.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, dianders@chromium.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] clk: fix slab-use-after-free when
 clk_core_populate_parent_map failed
Message-ID: <aPFIohBAaSnv8YUB@redhat.com>
References: <20251002061215.1055185-1-yun.zhou@windriver.com>
 <9c8a8df4-f69c-4407-911f-0402bd06f4c5@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c8a8df4-f69c-4407-911f-0402bd06f4c5@windriver.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Yun,

On Thu, Oct 16, 2025 at 09:25:20AM +0800, Zhou, Yun wrote:
> Hi Brian,
> 
> Can you help me check if there are any issues with this new patch?

The new patch looks good to me. Ultimately though it's up to Stephen.

Brian


