Return-Path: <linux-kernel+bounces-806421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE15B4968C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797D43B30CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF89A30E0DC;
	Mon,  8 Sep 2025 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYdKwNNO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDED63101B2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351369; cv=none; b=GBUpQEIxcW4ZOS4tEEgKqALKVJf4RuGY5rVL7y2nAefxVbtLnTUav7J/1sl5lkpD0cQill6jWC7KBa7WG3SDxseGdGBkXd45t4ljOn99kBaJrH4kuKQSK0N+uboeAnIWWlkc1x6A5uyj78IkAO5K1c4/4QkmXxpeHF+LxB5bx84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351369; c=relaxed/simple;
	bh=nEnJefsPnqX5TFlOhSjy/aCZuFSg/cMMij5f+DaISJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7GB5dT7fmHmtrCD21zJhuyMz5dJdWlBoymKne7j/6SCjfA9dOdZ4/YyVZYTCHBV+0h6qPuXWOtlbMRKQtuMiWhGbhx/qEnzYpSU+u3PyVUE0uLhnVJsVRAu6c1bcg54jAIa9rwuo3PXHTsCOthTNgLEOGGjoxz1UycIfUo4bvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XYdKwNNO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757351366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BjGSfoNLufNCcnOWJhIHlOPvlvWzDfGM2mQB9ETv4Jw=;
	b=XYdKwNNOTZmhph5kKeA7YcYjO5wM6KjONPcmh6XUiwwWJNEUU0oe0YGt7caAE4gGadt/Bq
	8D3iW6cLcfaIgARu+GXQ3ogK5ylZssfqC0sphFRiB8LNnczBUYaQhmqTsb022M8qv4NNNl
	mg6JctMbOq5Lmbl1uQEWMuPY+idQbOc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-gLB0TlkNMImmhLz9z9smoA-1; Mon, 08 Sep 2025 13:09:24 -0400
X-MC-Unique: gLB0TlkNMImmhLz9z9smoA-1
X-Mimecast-MFC-AGG-ID: gLB0TlkNMImmhLz9z9smoA_1757351364
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-72108a28f05so188452946d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 10:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757351364; x=1757956164;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjGSfoNLufNCcnOWJhIHlOPvlvWzDfGM2mQB9ETv4Jw=;
        b=BuXEo1uok2vggCM1OV0X/dp5lWx5gaCHU9ThJdmuRqV49dWsy1rsrWi/wrvx0AqWIF
         qhqmd6dL7iLVZ48kq6dcFn326t9wgGZ5cUz6NoHCoWXoFgy+4s7xEO0M7KW02DXSwcK8
         QprrbcqY6/5t7LGLZ04gn+2IZmK5jxtiUqqP4HQHxNtv5qpMRcRQsAW01CIqGJZSXQZD
         29e86vgUl4H+WhuSm8HBG9a0jPeppAy73AebVS5VspCDTw2audTea/4Gv9lS9NTcp7ar
         Vo7W7c5tTCFYdvNy48pNdHqgqlpwH33Z3ZapGDZCco6t9mqc47cjBEJLDDZjTGUPXbvz
         WzvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhKFShCecPAEL68RH0C9ALasJqK3W5bivbqCZ0dZuCKiBonp0hNX0gwp33V1/zfD1Li/e4w6C/1jZv67w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMjXq3w0XdTIwmStCxbbjUccXiV6jYpPLWZVnlo/o/xjh/cDJ1
	se8ZdyqIQVqc4CvDE5Va/fQ9jlb0uw0zetSkqRREMyQ5niuFUuqdhrPzItKnyxplqOtljcnLC+q
	n375uwnWDMnZej7d9XZizzfLSIioWcSPK65wjfNVFSFjIQNVdnxU84P4wWKmBil7T1g==
X-Gm-Gg: ASbGncsAhZzx0jx7iQEom4wGODDWpJH5vhh3XV1xlLKbSjud25IqiTG13oR4C1S01AK
	7c3mELow/6EqhaP54ipnqZxL23tR+6dsuGFvszvFBPLCXH8qom1k1E2Hiu6QfJObHc7AuHLUIuh
	ULdP/N34DbEomjScK7nFGb1amwq6z95Qi+FOxdd1nWO827/aq5uPwUPrSez7HCY8ipWqAknOIAz
	Gw8VpVIYh3mg7Odzm8h+/KyJpwaZbI+6+lSOotnsHkDF2X4zZ45hA/E7X7sM9R8qKPVAnx19l9M
	70Fd7Q7Gy5rufsjFINVt2ontgSpAe9Ax4DrLh51AOXWRXJf/Mj48IMbhHRM=
X-Received: by 2002:a05:6214:460b:b0:742:1ea2:b5fa with SMTP id 6a1803df08f44-7421ea2bfc1mr87069466d6.27.1757351363901;
        Mon, 08 Sep 2025 10:09:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IED5LQ1C1kD2cQaTdi6CchCpZ13f6Gj4BgYLX1Z0AMPVgl9HbDNtaLifWHhEKfT7Yq0Zl0NpQ==
X-Received: by 2002:a05:6214:460b:b0:742:1ea2:b5fa with SMTP id 6a1803df08f44-7421ea2bfc1mr87069046d6.27.1757351363366;
        Mon, 08 Sep 2025 10:09:23 -0700 (PDT)
Received: from x1 ([2600:382:8507:870e:b6f8:ee72:4f09:a16a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-721cf6d6cffsm119097426d6.54.2025.09.08.10.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 10:09:22 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:09:20 -0400
From: Brian Masney <bmasney@redhat.com>
To: Tero Kristo <kristo@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] clk: ti: convert from clk round_rate() to
 determine_rate()
Message-ID: <aL8NwHe00OeVuAuW@x1>
References: <20250811-b4-clk-ti-round-rate-v1-0-cc0840594a49@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811-b4-clk-ti-round-rate-v1-0-cc0840594a49@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Mon, Aug 11, 2025 at 08:48:05AM -0400, Brian Masney wrote:
> The round_rate() clk ops is deprecated in the clk framework in favor
> of the determine_rate() clk ops. The first two patches in this series
> drops the round_rate() function since a determine_rate() function is
> already implemented. The remaining patches convert the drivers using
> the Coccinelle semantic patch posted below. I did a few minor cosmetic
> cleanups of the code in a few cases.
> 
> I want to call out the changes to the dpll driver since a fair number
> of changes had to be done outside of Coccinelle. I unfortunately don't
> have this particular hardware on hand, so I was not able to test it.
> I broke the changes to this driver up into smaller chunks to make it
> easier to review.

I included this patch series in this PULL request to Stephen:
https://lore.kernel.org/linux-clk/aL8MXYrR5uoBa4cB@x1/T/#u

Brian


