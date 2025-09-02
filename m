Return-Path: <linux-kernel+bounces-796971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D43B40A28
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 555227A4641
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E6032ED2E;
	Tue,  2 Sep 2025 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgPF+Dk6"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ABC2652A4;
	Tue,  2 Sep 2025 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756829388; cv=none; b=k2nH+kd/2sDZCTRo326x0T7pEjiHys+R5NSs59ExtTIHM957ci0rbjw1HWzQsKrXwEIwppWwLq99loJX540DDqK0CMTSPeNW/bsWbDK+RjmzJHAfAA++liR9ksLbfZg3gQ8g/ZlcGWZbWpqq1oPZBP6o6UDDJc2P1M2sfoV+xII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756829388; c=relaxed/simple;
	bh=syoayViFHo42fQnL1EzEylq68IIyUIb8xC90SmvePNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgzGhJ3C1FYawmFvMVCSh6EYfJMAwWnCHUQDokGSNxNvxMy1g0JvuqFcLXbLLA3TfWGylTdm7YHitSiuqg2FuBTkcpGvPUqortLrTTe7pzIgEpTCROz30zCjZ1iNrGETxFYsmBQuYhyb+D5KFAUv0CKLmQBrShNhXnUTwIPStOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgPF+Dk6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-248a61a27acso252975ad.1;
        Tue, 02 Sep 2025 09:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756829386; x=1757434186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05TUzW7tah/Dlcw/gEUwu44u6+noGwNwdDyA66QPm9w=;
        b=FgPF+Dk6glHoLW4vIWZu1BYEP0aGHJ20VW4lvySvO17W0kaee2kEYMoYQ0Qy4OkE9t
         aB8QXvoEzVaXRMhrl/St8uJ3XzSwVYy3Bd3ix8LI8P8E0UwaQy6u2F3WoGxYmmKrK+gb
         fOtGUzQdduSM/wnutzuIO1CpnH1kklQ95oXqNIWynGtn5CHppGXUfX0SBGwJubXQPf2p
         Yfu02ScPwm3nnNjPRIQL4HD67bwJGz+GgLEk+DAktRKLMujMVoYEo+pVuNzjgD6yXuTq
         wvLsoEMutiBVHyIisgsDkU50kHVKBl193dnUs6Oc/4AAWgk14Kq3mrWghNO9JJhlqkx3
         kRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756829386; x=1757434186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05TUzW7tah/Dlcw/gEUwu44u6+noGwNwdDyA66QPm9w=;
        b=X4dN1zgQf2sSmHDeOcF+ObO/16nFkDUNITdu1Dgozb+x4q5HsDU6Rhc6fQ+fqt7GB+
         dBTicZqj89OQJn5F/RIKiiR6A6DwTI6PbRsU0AGytvx8iFoMDGZAdTtD3Nwc25w05A4g
         P4/PmzA+edsnoTpCIi2C9W/SJ9Qowhn4JKlOYUpZEW/mvU/fDmYUSVbEeb4D7aVCHuUl
         eFO2CX1gWuBDSQynI81VyT2vrH4niJ7m9/vGoh2Pkd7TnjWYxsCPJMa4pLT9+8iEJ0Dd
         2Qp5hrdhysax8QM8vI9wRVGkzWQamnY1y0NtmLwWLD6Dk+NmNoGsIda9Su1Iv4sAG394
         949g==
X-Forwarded-Encrypted: i=1; AJvYcCU59m1IJpRN3opLSR0bBbav/GTiZ5ngl96PfDo3ydxL47xwKKVEIdACN0f4/kJUr6Al9Gv5x1PlU2o=@vger.kernel.org, AJvYcCWjgBNZTtUqxhfXqQ87OCJAPHIB8RYPN6tjKDEbrAxX1kja/uJyF2PFEhgl8x6vfCkcOMJ4p1GilvCU/ZeF@vger.kernel.org, AJvYcCWwe9T+SYUEtChFHyG0q1YjbdNepjf19WHsgnH4Jg8rCvtgeaNk0muCvqKN/DV3QmHcYh1wBJbgO/palBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV4XdLWeuxtKnS7RGB3QqLV2Q65C8jAEcuzlzqpcB6KQSZccPq
	Svcja3UICi+YfiUXoVSXsMCgQs60w1AWkPxkRQWjCryBAVbkQ5PgQLlE0RpogA==
X-Gm-Gg: ASbGncvy5bPPUEGQJl7Na7eVrbuT7dsfuYYb0+lbsHjz/sGfC4/O2XQnTloyWdddIwk
	qM7Mdz3eLAymplMsUfjsJzEQie5F+XVwJzLij4UNBIXgbWIhB2d7J4wC68ESsVEY6y7Sj/IJtdA
	oax32D/4EUfPIO1Pn3u57Mio++mX2GA/S2YQ5DMH3yOkIVpKtkI7zllTgJIjcPr4fmnyiwIsJfh
	5Wv4VL1JElUwBDQ+oW79OwSrTMR76Hk416bWmpznM6PFOYVJxDmqdNYMjDEOoukHB9Fg04JGR0X
	n619VdtfEV3OleNtoY7Hyz0llqEf1v+9mzwju14izOqopZp7xgxvgCa7z6wBD65Nuiyqveq5mqj
	4WyhjoPhELwNaTZ3YTBB41fE+Mm7Jsdgc8sc=
X-Google-Smtp-Source: AGHT+IHOtqWhi3a61BAAa2IW9pPnlO9A2DZ2gtvg7S0md20STwQ196nuIK9lsAOhd1DlgKe8tStYdw==
X-Received: by 2002:a17:903:32c6:b0:249:37b2:8629 with SMTP id d9443c01a7336-249448d70efmr142762655ad.9.1756829385899;
        Tue, 02 Sep 2025 09:09:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490370298dsm137765755ad.4.2025.09.02.09.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 09:09:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 2 Sep 2025 09:09:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tom Ingleby <tom@ewsting.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Eugene Shalygin <eugene.shalygin@gmail.com>,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add ROG STRIX Z690-E GAMING WIFI
Message-ID: <58dd3ee5-e68d-4931-8ad6-3102cf353288@roeck-us.net>
References: <20250902051603.35633-1-tom@ewsting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902051603.35633-1-tom@ewsting.com>

On Mon, Sep 01, 2025 at 10:15:58PM -0700, Tom Ingleby wrote:
> Add support for the ASUS ROG STRIX Z690-E GAMING WIFI
> 
> Signed-off-by: Tom Ingleby <tom@ewsting.com>

There have been other recent changes to the driver, resulting in conflicts
when I try to apply this patch. Please rebase on top of the hwmon-next
branch and resubmit.

Thanks,
Guenter

