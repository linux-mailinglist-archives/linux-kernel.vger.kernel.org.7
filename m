Return-Path: <linux-kernel+bounces-785255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2557FB34833
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 212367B2134
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA61301006;
	Mon, 25 Aug 2025 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCsP9ffx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462DB2FD7C6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141547; cv=none; b=N1eqq50O45rIPmW13TubnttTUDnwiA9YH8+UE4EjfWLjXln/xK6Sp2uH92knw1TonTTekjOav12wAfP362RwKGpTpRq4wlXuxPP9PPpfUzWV1mFNI+wCFGVn/KSD5NZRvaQM+Zv786MF0c0HiYFSUH3XENvXXWQYEukyzvi0HFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141547; c=relaxed/simple;
	bh=a9DEbmQDFs1ppjiAWwlvOY2MAO6FzDy9K1E/Pyjmmhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJgiIGFeqy1jwVZPupFeuj+A5wp9H7esbESwIrmUy1E/9EKqsZwrLN+h3WEHdk4WW+YKWOteK8NCBu7u9PdAI0FjBqN8oyS7MYqWeDuuAEKLXp6nEd/Eis0PGWaR1gpbZdu+z9J4vFvHHruP2T6tWcgSxqiWoASHjU5dyUDid6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hCsP9ffx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756141544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bvfYaRBOsqgg9T3AWRsCKLpVkMgeI8wkL7WYk9/VCmQ=;
	b=hCsP9ffxSCRrMRkhsuAlPcVcFAQJJJt0LI9zgqa9we20+DvY6d8VUJeQOZxa6LX+HRxydr
	0bkKRFg61g68xZGopBJP97mcnPJRCsecVVl2PtvNezfNqXQ7cnsQ7Tqpwelt+VuAX88MtC
	45nDwUFzsGkscHEbAFeaXGSMASG8Llw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-w3kIC4mxPTKM6fx3JMh1Vw-1; Mon, 25 Aug 2025 13:05:42 -0400
X-MC-Unique: w3kIC4mxPTKM6fx3JMh1Vw-1
X-Mimecast-MFC-AGG-ID: w3kIC4mxPTKM6fx3JMh1Vw_1756141542
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70db3dedae5so51098986d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756141542; x=1756746342;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvfYaRBOsqgg9T3AWRsCKLpVkMgeI8wkL7WYk9/VCmQ=;
        b=xGez0q3hUrjpGlNUPeHq/CxhdoSoDcd9UguVdsqw66kqRN18hAuz+Vnh6gbiBAVqf9
         7/0SOLl/1zRemJvheNuVAbm/o1M/R2eU35dpjrLWVptQxgkyyyJxJrEtFjG2xtdxNq+m
         hzj3tp8Wq9Y7+U8RBMnw6v0/CY9d9j1HwqqJmSPcnHC0jc19Xw2Ws557bc+oG3mtVICE
         VYKbNgGSGQDZQSkBgAURkkE9A2sw7Pvza3m4PP0OyiuYE6bsijAI+fm8mHHpz4g0ZQ4K
         4gtGACdTSqnk/k7egO101ndwkZQlneoi/cWGi6uhRdAikMk+vpisVr2JCxRTjGV/GOPU
         WLXA==
X-Forwarded-Encrypted: i=1; AJvYcCUVp9jEPHoou6Ul8R8P1NG9S0Kk/G09QqG6bWBYP1nUDEolTETvAoqKBbxXjCKH2mmsQLhkFuoXt9LSYDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ITWjXg/hPZe5tRQqMsoiSoT/YR3RJ6pfh0vqTdAk0693eYg+
	3FTe77DRej1SwtD0efpsSTDhv5AsbpYaMeTZyS1yK+QqS7CBWjIFZGTHvB58jMRMDtbIKBFnYvW
	kjp+rm0zSbswSSVAayNrkShB80TUUVk0x3jlwC4kHIK3vbfwWOff3ttwcO6IV0Q3Caw==
X-Gm-Gg: ASbGncsVTnn3nqPiKjKo5/uEKE05BH8fUDygoh0+8zjkkgxnAyHC0GmuOU/u+ZOFzdg
	tvL0eDNlBvpsc6MgMOTQ9qLuH3FDMRaPsFX+u0rzffrbWltAfEXxWNvyIIU/kkGI83LN+wb502V
	SwJcBf/JAN9fkfDnGd53qQ7+lde5Utgaxa4FFqiWBOS8GfzGKMaQSr6CXJBpxqeFVyJSAVGJEWL
	NeVC/VzxsF3q1z0olznsij5c2NpdViY30OgJ7l2GZED/HAlLUdagBSCIO2h6AyUKO9srS2KjMAy
	Ss0nBexhy9MP0HSwv5jDvZzleat9Qs4dgx4WBEGC17pUrYe89YiYpOJQ3OMyMRZB52/hCbvmYme
	0VBGk3h2zjTRG+0cknLg=
X-Received: by 2002:ad4:5ec5:0:b0:70d:ad2e:cedb with SMTP id 6a1803df08f44-70dad2ed081mr83964576d6.43.1756141541417;
        Mon, 25 Aug 2025 10:05:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnj7pgLgYj0gnzZFl+kk2EVSGRa08xMAzv363arIwLdssNid6xlYMbYTH85va++EtXnTmBAA==
X-Received: by 2002:ad4:5ec5:0:b0:70d:ad2e:cedb with SMTP id 6a1803df08f44-70dad2ed081mr83963686d6.43.1756141540665;
        Mon, 25 Aug 2025 10:05:40 -0700 (PDT)
Received: from x1 (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da714727csm48194826d6.13.2025.08.25.10.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:05:39 -0700 (PDT)
Date: Mon, 25 Aug 2025 13:05:37 -0400
From: Brian Masney <bmasney@redhat.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, geert+renesas@glider.be,
	linux@armlinux.org.uk, linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 0/2] clk: renesas: rzg2l: Disable unused clocks after
 resume
Message-ID: <aKyX4YJswZLuqA6Y@x1>
References: <20250821080333.27049-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821080333.27049-1-claudiu.beznea.uj@bp.renesas.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Claudiu,

On Thu, Aug 21, 2025 at 11:03:30AM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> This series disables clocks that remain unused after resume.
> This is necessary when the resume process is done with the help of the
> bootloader, as the bootloader enables various clocks when returning from
> resume.
> 
> On the RZ/G3S SoC (where this series was tested), the bootloader enables
> the SDHI clocks (for all SDHI modules, of which 2 are used by Linux and
> 1 is unused) and the clocks for a serial IP (unused by Linux).
> 
> Testing was done on the RZ/G3S SMARC Carrier II board.

Do you think that other boards would also benefit from this change? If
so, what do you think about putting the call to register_pm_notifier()
inside an __init block in clk.c so that this same change doesn't have to
be implemented across various clk drivers?

Alternatively, if this is board specific, could this be fixed in the
boot loader so that the clock that's not used by Linus is properly shut
down on resume?

I'm not the subsystem maintainer, so I'm not asking you to make any of
these changes.

Brian


