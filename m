Return-Path: <linux-kernel+bounces-736783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2A6B0A1CA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6C516A05F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2E72D8363;
	Fri, 18 Jul 2025 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="oQFIxZFQ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E022D6415
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752837373; cv=none; b=DYcqSecMYTl/j+poXumoIK2eOyrGwsbPUSEovGLq6OCY3vLBqI1aD3P4pyVJBuoQftWxlJWjtEO79MgXpL8m5VJJ3qw7Vpm3vsUZRM9lG62PoyrzGtVi50cbO2aiq6sGd3QfgNCkOKl0mTQcgjPhnaYNusoQkKP32Hg1jQJbJ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752837373; c=relaxed/simple;
	bh=KAC7tKnqNw6ghQsIQoBhWab53HCnxnYmc4lm5r7+vxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmV02tjQ14QymndvmvMN1LTb+XCn395rrEebSbK+66Qp5EAWsxiAceapGOGg3KV1E7d6RFUr8lfBpw6Ww/Ds1VPeNSauu5b38+Sf/oZaLMCm+VKH0OCxEB2HSrHxbWY3yh69/YV6nXUeJ8JcyJyHBrx7N3v/6qtfuPm+sZbSuIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=oQFIxZFQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235e1d710d8so21820535ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 04:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1752837371; x=1753442171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qpf3i0yhcut+LszaoQo/We6g+NwrXQm4EMP35kSjpEQ=;
        b=oQFIxZFQ5eqyVK8ufESlli3UCffJBTznu6+THRnqlYpKYQB24YGeiNk9EF4SZO90f+
         hCK/WNap5QkcL7cV8RbJ7VYk7yQ0LQ3aNBaU+M/wTGcQ9CmEIFbUAJLZCJePfrMZM72e
         /XGb/pgJE+nKkEh9s9MFZK+RJRdZGa4a/OHrAaVsiC9leXpnTzXxlM6AxOnak03tbCtb
         XYLeCnqddhbpmWy5VI8RcstwffQc+ackZvhWoIiVOKlrc3w5+DJyNIHBKs6LQWp9VUgX
         dJIBEXV0g2QXDkSYbB/xk3907s5Dy3VbXlCW4CSaJocaRIn3oC2iNqkmRZOEQasroOjJ
         XhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752837371; x=1753442171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qpf3i0yhcut+LszaoQo/We6g+NwrXQm4EMP35kSjpEQ=;
        b=QFWtucOIIsD9CoKNNgbfXP9+2Qoi1wBx95mAo3LDRhEFayDal7Q8m8BKBIWgYcHGH9
         uuTHiwzRfEs8jpUx0zT1iZEXXEGvKchSApQgA3SqP5MEjv5cUFl9kPlW0iOvijt20PZa
         ZtHPjApjDF8jfCyFM9oAbpmN04JdcH5joJg5SR1xj9prEbi2ECykgBrC72OYU2y5Drze
         lAlse/zwOU4gPtYhp61uTdnmtUNHUcj00fB0ELotXm0k7X8b4OorOj9jAQJWHcszGugT
         uTEnmdsHNs4+7WAHbq8ClOE5ILQCprBK6GWrKOX0lHShYIhTq6pHo+L99XBmV8Ckq7Rr
         lyRw==
X-Forwarded-Encrypted: i=1; AJvYcCXGgrQHJDnS9bQucd5hSffawD+tBdVVwu2juezLvZzses36Axcj7GANeh2l0LlFkpJor2PHv9UHdREvVVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfP20Cho3UHXSHxnf41oniRwqYy2Fb20CZ//iUHXOauAsRW+XP
	DyncCg2ctaSpGeBzQ4eNzpag+C4yWedPghF3HLMLcS+N5O8aA04jY6k2MJwO4ngkth0=
X-Gm-Gg: ASbGnctmUIpvJpTNB4/fiiwt/fslWIs8ZZskTzZERazH+r5fA8XGHytVOTvMdp9vgTm
	9A9DLOsnsQLXunt7ovUWuNFk+Qq1O0Cl75g+PWdMkOqitftYTZVuQx1kWIVcYyIfS58weSXlXu+
	yVNoy6lwtxBguWPZlFXWWW9oMfFk0BGGYmXs9jEhHfbo8QBKl40P3DRyKU4A5tXX5z5Y49G2d5d
	jYJB0BQEgr9HsbteXymjsYqEzGMiJv/xJNNn4n1bNOlN7IAmabTzEq6/IPdgsjknJ8pCKHSNlm2
	Q7WH1oTZZlfPhUz8Ag+2eFwREmqvwdy1+VHg6MON26AscCm8p6cZy7waJ+Wd1ntoBATdMuvsdyB
	IySqxy/LHaq5/12iJ7aBO7q1g8+9qoxbQDzJwPNMFFp6b8MDKLsNYmqtknBvMWKSny8xp8yoIjw
	==
X-Google-Smtp-Source: AGHT+IH+YNkMNydCV8+ckYpqEo/rurDfmxt/BmZG9DSn518D6//2LQGAwxPczvGdppJLXJX8W68Ctw==
X-Received: by 2002:a17:903:350d:b0:234:c549:da14 with SMTP id d9443c01a7336-23e303389aamr104128795ad.29.1752837371571;
        Fri, 18 Jul 2025 04:16:11 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-64-170.pa.nsw.optusnet.com.au. [49.181.64.170])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2ff9e964sm1016534a12.59.2025.07.18.04.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 04:16:11 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1ucj4S-0000000CZ8f-1Fgb;
	Fri, 18 Jul 2025 21:16:08 +1000
Date: Fri, 18 Jul 2025 21:16:08 +1000
From: Dave Chinner <david@fromorbit.com>
To: Marcelo Moreira <marcelomoreira1905@gmail.com>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] xfs: Replace strncpy with strscpy
Message-ID: <aHos-A3d0T6qcL0o@dread.disaster.area>
References: <20250716182220.203631-1-marcelomoreira1905@gmail.com>
 <aHg7JOY5UrOck9ck@dread.disaster.area>
 <CAPZ3m_gL-K1d2r1YSZhFXmy4v3xHs5uigGOmC2TdsAAoZx+Tyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPZ3m_gL-K1d2r1YSZhFXmy4v3xHs5uigGOmC2TdsAAoZx+Tyg@mail.gmail.com>

On Thu, Jul 17, 2025 at 02:34:25PM -0300, Marcelo Moreira wrote:
> Given that the original `strncpy()` is safe and correctly implemented
> for this context, and understanding that `memcpy()` would be the
> correct replacement if a change were deemed necessary for
> non-NUL-terminated raw data, I have a question:
> 
> Do you still think a replacement is necessary here, or would you
> prefer to keep the existing `strncpy()` given its correct and safe
> usage in this context? If a replacement is preferred, I will resubmit
> a V2 using `memcpy()` instead.

IMO: if it isn't broken, don't try to fix it. Hence I -personally-
wouldn't change it.

However, modernisation and cleaning up of the code base to be
consistent is a useful endeavour. So from this perspective replacing
strncpy with memcpy() would be something I'd consider an acceptible
change.

Largely it is up to the maintainer to decide.....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

