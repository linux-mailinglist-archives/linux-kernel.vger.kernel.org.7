Return-Path: <linux-kernel+bounces-721528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1775EAFCA6C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5FB07A3F97
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC31635;
	Tue,  8 Jul 2025 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBboDcMa"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2B621639B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751977755; cv=none; b=lCxLW776uk5k6A0oV9jjuy5rYyjqrS9Hc6GyBKqpEGIlMfpWhid9CfQ098iwR9SaJLQkIsflAk5+Cm3i7gzIVDH7TVUgXQLnx3f/tG1HOw4bx65QlmDhB+EgWMYkyCm3p9GdpXcEzgAkALLXL+vVteh4sw4pJHwkyTFkIMjlH4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751977755; c=relaxed/simple;
	bh=I/ro+RT9f7RUAHg6qtubIJfjozIyJLT7U+cakuoseDI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ct0R+eguR3EFUwiI+It9DcKPG+/vxFWKL0WVDft3B5+OuOiuJ1Nk23j5xUcBZmJCwHZRbW5OCVu2Uoga9ZZ//DqSuAPIx0pnavWXvx4HkzoQ/UcLjSVWwfTg7MOSeYniD12SI14HHJrwMkwcSHCWiFaX9togUWCGxHZhK3PVsa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBboDcMa; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-553bcf41440so4424330e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 05:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751977752; x=1752582552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jKrYTylI11tpnP0mGBFQ9r8Vbpw/JVR1OwgCplmGikw=;
        b=VBboDcMa9WwId9qCfHgCDMobQxu/0FulvBq/Uz8lbv0vLrBytMm1SeHjQYTMLtPwpI
         7X+N/nj5Ro5gMu1b1le6hI0Cqf3on0UrZfC0wui0jvVfZ3eamqH1Wq1CDZ1UsvjFzDSa
         6Dob113dX3yDDUlIW4XEWcz1fEnGjb8AtHc9Y7QFQdU6SEEO0t+6VZPqtllE7TR3751e
         noT2U261S6IXsU1j7VK1su4w/XqcxCK4+M+q2dZJ21VCqGIxkMJrl5t8HZX0SVx0nXRu
         Q4mxmhyRUf5p6wY/oXtF31LTqHUHrl0lCntsqFDMTNW4MV0UTGdNTS/JN/2f6cVn1DJC
         hoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751977752; x=1752582552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKrYTylI11tpnP0mGBFQ9r8Vbpw/JVR1OwgCplmGikw=;
        b=slqrGmdIyge/nRguIQ8TYkcBjQlh5d7IbWamBLAYYeKUb7O8XgTm6+3GIzuzrBKYx0
         qLvo+QPRAVFa+4Cvt/JmV+qgbOyRnjZuZtWKwn7HxKxAGIVLjOMk7Q9C+g3KXztZVJR1
         CiFdFlT7Kxvqa99znGOjxV+5sCa0JLcX10pGlC1HzvCaoVaMJPrzXOMAnySAhEJucPAE
         k3l+bxJ48UzbJjERSWe8oaUs6lJy8934pQ+BhIIQSvSncFzWWj09gg4bBmverJxJwLjP
         422HALBLuhWLiOupOxojB/SqdWeym1fKVbo+UmbW8LoHW4xYpCAg++2+SttGVdb3z8lg
         dKnw==
X-Forwarded-Encrypted: i=1; AJvYcCWI0VDfmpx/SmMYhIV+ByvpzWCVu6vK1H3aLo075MzGGdyL/cuBC4IfNgVx+UesoCeeG0p7gwG5aUoQ2AE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGDOedbmqZ7YrB/jMh24OdYFyIY4TNoSyZ4n8tdQ6Odr4dJiyc
	hI7Tf7b6l4yHwSWPjkqAJoAxwr26XOE11qXmELfc+3LHMCEsLt3ZFpAi
X-Gm-Gg: ASbGncvfDWrAhTShWhJys9Lt66qSUfiksMYmbH42iNksRySN8RA5bZy9XfoQRWzAp+l
	bu9VwChepVNe2eAoZTrxKqOrbQoHhd263xIpSvkk3NLVLSa3x+3a0Wp77WfEULzMzl/G9LoYIUe
	2PO7WCgzMkDDWHjIHaRp2PtcqT3gExFQViYrjDueyIfI7pDvIsp5MgAT/b85EmCQafAfDRlILQB
	nYMR5a8n7Wd3YOVuaw5FnYmD0quHS4fSCrxINzjZEW40PS6f52w/YH9vYZted6LqnfdGbCeHbx5
	+z/9bS0rKFxZOTEj64NR7la2pD7AsjCRyKo6VQ3ocQgBmFofvh+YVixB15f8VLymZAADoOB1k9M
	nQiE8BRkipFA=
X-Google-Smtp-Source: AGHT+IEU5jsNR54q8+iXNXGyc5nxjnUooNxl/UsyiBDeeI9PBzPIVZY9DBdq1dx6K3vis5Z8an2Skw==
X-Received: by 2002:a05:6512:1516:10b0:553:510d:f470 with SMTP id 2adb3069b0e04-557f83020cbmr886743e87.4.1751977752160;
        Tue, 08 Jul 2025 05:29:12 -0700 (PDT)
Received: from pc636 (host-95-203-1-180.mobileonline.telia.com. [95.203.1.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55638494fe8sm1674536e87.112.2025.07.08.05.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 05:29:11 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 8 Jul 2025 14:29:09 +0200
To: Michal Hocko <mhocko@suse.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>
Subject: Re: [RFC 3/7] mm/vmalloc: Avoid cond_resched() when blocking is not
 permitted
Message-ID: <aG0PFXpl9WFRAd_m@pc636>
References: <20250704152537.55724-1-urezki@gmail.com>
 <20250704152537.55724-4-urezki@gmail.com>
 <aGtzL-h0TvbML19g@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGtzL-h0TvbML19g@tiehlicka>

On Mon, Jul 07, 2025 at 09:11:43AM +0200, Michal Hocko wrote:
> On Fri 04-07-25 17:25:33, Uladzislau Rezki wrote:
> > The vm_area_alloc_pages() function uses cond_resched() to yield the
> > CPU during potentially long-running loops. However, yielding should
> > only be done if the given GFP flags allow blocking.
> > 
> > This patch avoids calling cond_resched() when the allocation context
> > is non-blocking(GFP_ATOMIC, GFP_NOWAIT).
> 
> Do we even need those cond_resched calls? Both of them are called
> shortly after memory allocator which already yields CPU when allowed.
>
I think it can be just dropped.

--
Uladzislau Rezki

