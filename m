Return-Path: <linux-kernel+bounces-759312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8E1B1DBEA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31C372245C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20D5253F03;
	Thu,  7 Aug 2025 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejy6su2w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DC9F510
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754585144; cv=none; b=AWDAXtt1kWfvVHvnR/+Sm+Qd3S9yWLk6mKUuYWUyyskdIGByPI8jdO8lkE9z5KTerAX9HJHFb7oBsnq/T9OFJO0FBCGVeB9VfU4Gfcb0cKTx7zXoH0B2lq1MqxBem1HAZ12WO9NV83bKiFv0ejrya9ujjeEloyXVMaPTarUbyf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754585144; c=relaxed/simple;
	bh=DnbinLqQ/SZv5MEYtpqvtmUWrOq+jq1hEaDbmqBlBqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOHoiayfL55NXuXx4eDXDXavhQljBe7aRKRxgSBKSgTeCWXllGXw8U0fCgAzmu8gOs5KPvRsbkY2PaWORfEKiNP83tcmbi1a8feGdaXZlwb2Q6TP80nKUQWHD8Gkq+HotJKBUuGi5jxV0ENDYpg8GIqBO1qD24ZSqSURSS+OaRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ejy6su2w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754585140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mJ5oeu3kAg6HS4OVA9rb//xbi40No26cZ49UiO4tWTM=;
	b=ejy6su2wN5ZJAfDkGH1leOaJEVgVzrb4zi82Z41vH2G4hzi55FGQMl3nxrntcIL6yT/bBd
	9MyjxCYjW2uPShkpKC/QxN4Cgs2iEP5KXuknvgo5DTyT8AdpxadIZjmN8K0bFxABQdLka6
	O06fJpBJOaWx9iHh8nmRQhb7CfoWiq4=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-qd9ttKvQOmiFZqiLLhGLwg-1; Thu, 07 Aug 2025 12:45:39 -0400
X-MC-Unique: qd9ttKvQOmiFZqiLLhGLwg-1
X-Mimecast-MFC-AGG-ID: qd9ttKvQOmiFZqiLLhGLwg_1754585139
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-711136ed77fso17213547b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 09:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754585139; x=1755189939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJ5oeu3kAg6HS4OVA9rb//xbi40No26cZ49UiO4tWTM=;
        b=AwAEZlKyCf5QbOiGs9bK7BauVHSKWFpgcbay1uyae1mbF+FVYuFOqGIFz9QHYIUjij
         QmlLyBH59q4vaz9zmu1Wx9SiqfG7FKzwn2tjy9kxVs+FqpG9jp7i/FagxbneUWVgSCQz
         SBjuCazCbcm20OIurkhT6ZbszN6zV9AB9iO9NxjC6RbKP42CbV5d+Xdu4N4UDXH//L84
         HZWbyarijyrD7y1+lQEiDUKu5vKeWjkGqdG7Xs0YeSKwltgc3cjAWv4HjE/JrMjsiRj7
         pYDjBu5KvCuMs6TYnefxJvhKlah8peKamWuwGsCvI1LoHJCsJ+jwXyqHbEORDLratAVz
         oCQw==
X-Forwarded-Encrypted: i=1; AJvYcCVEP3bniGNmaMsDYcf1kxpwOpaPV7askOFHmKJVF+6GwlWjusD9CUoU5Ovdbv1glxPyRFyEDx54r9Ki5HM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8QvPE/5A1fjFuNPBYwfBvllQtC9MSUPK854u4lxvynU/Cvwgm
	5EebFkmNUkOUEGXzgrAmnCrhysrgnpV42qU2Nl7GgYTQen6VpQXsQhaQ7AZPANe450oZcctzPWr
	uuLr9hlRDKHdG8LTE3tFlrsPliI4GRrkKNx3uL5vsW6pskHYK50Qr0x4TpDqPOg61LQ==
X-Gm-Gg: ASbGnctlrqbHdM+4eqLfIMQNut5XtkvZ/Aja0b+qBMIzAgv29JqZN00+fK47Bl02ZDL
	fcJo80piSljsrHfI+dyQStLD07px98GNAxojMxyvu/xkA2B6DkwaZEbSDFdhDB5tJTJ4QXYUR6A
	5qI9FpPqw7F855XREgElB3koZ3vcfhZqQNCb4oWZEgSvxtPz+rG/Pm9LtCLdSWVk2baQ7RKXl+D
	m3QLSALwu8c8KJEFGDy82SPb4ahZVKloybIuSORhYX7jjVpeDuK/4qK3ark+y2vMZGCtQT8ILq+
	xK8j2htv7lYOKkOY7e+Ifuo1BAoRDsnsubvp/TLIsC4quBNkYgiIOcoMUJ+Gg1MK+sDknzENeH4
	Q8Ap1izVaSxl8UuExs2AAAw==
X-Received: by 2002:a05:690c:2701:b0:70e:2d17:84b5 with SMTP id 00721157ae682-71bcc53c148mr93209337b3.0.1754585138994;
        Thu, 07 Aug 2025 09:45:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgbSqJY7+1sIhtBagdJKAXgNAdJDwXw5O7GuTQuwI9yzsV33fmqqWR2xnGe9+z9PsGvblgNg==
X-Received: by 2002:a05:690c:2701:b0:70e:2d17:84b5 with SMTP id 00721157ae682-71bcc53c148mr93208937b3.0.1754585138431;
        Thu, 07 Aug 2025 09:45:38 -0700 (PDT)
Received: from x1.local (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b83fd71afsm34285437b3.19.2025.08.07.09.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 09:45:36 -0700 (PDT)
Date: Thu, 7 Aug 2025 12:45:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Ujwal Kundur <ujwal.kundur@gmail.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, jackmanb@google.com,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
Message-ID: <aJTYJjj1pCWr-q62@x1.local>
References: <20250501163827.2598-1-ujwal.kundur@gmail.com>
 <20250702152057.4067-1-ujwal.kundur@gmail.com>
 <aGf_W_ZgIf63dmAz@x1.local>
 <CALkFLLJua-LeS+S5GpiXORA-3wNSR0DTzbh2bvU=Vg-Uzd2VFA@mail.gmail.com>
 <CALkFLLLoXfTNtigbcyD4RdJfY+b5Rh5-5Zta1QM9dBQxZd19cQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALkFLLLoXfTNtigbcyD4RdJfY+b5Rh5-5Zta1QM9dBQxZd19cQ@mail.gmail.com>

On Wed, Aug 06, 2025 at 08:33:06PM +0530, Ujwal Kundur wrote:
> Ping -- please let me know if there's anything else I must address.
> I've ensured v6 still applies on mm-new.

You can try formally reposting your patch, instead of replying to old
versions.  It might be overlooked as discussions.

Thanks,

-- 
Peter Xu


