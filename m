Return-Path: <linux-kernel+bounces-799307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E96B429D0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D93A581787
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E27322C78;
	Wed,  3 Sep 2025 19:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8C3Urxn"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4FB30AAD0;
	Wed,  3 Sep 2025 19:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756927420; cv=none; b=ZsZJulL2LyxoRV4PJUTVrXaW65Qbu7wPKZYlakuSgVPQfI1jKqkDSQUEtx6FhJ/B2ND/8IRcEtuHo9ZK/N145lAYQvglj54U6zStv5rpawW5src6ui/Eoqdj45LriQAfqrHuLvhDk9ES7EGBQMyZOJxXCnTi5e1S4utcxT19q1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756927420; c=relaxed/simple;
	bh=4JDJTgQ3r53uYyj3HBe4zhubm/4WXNR7BVJpSU9g2CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBM5erbRkvhHgMw63YpD/vBWCXet/e1iETsd606hnjC8vwa3RCUG72XKRZnxAqJKRxiB+fw2PcqHfVAHoopbsJwmYwZn8wHOpHhHcdubDRqlmt2yj7hs8J5OuSaJksLxI28ZKUf/Ii/HG2RrL2IVtZH+mqFOAjwbO+ROH5FGkoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8C3Urxn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2445805aa2eso3170885ad.1;
        Wed, 03 Sep 2025 12:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756927418; x=1757532218; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Rz5uVzOA7H7auuSeE0duRCSB0VUtJjaNdjd61cz4Do=;
        b=m8C3UrxnXdT0XH8tex2ossXNvl1E6jsANEJAu/0jLkRb8d+mAOb8R5lbZqAkUrom6z
         GeKBrSQMjrg98rtcU9bvKpgjpIHtbZxqj00I4+Dl0mdAQUySAwsQKA+TxGrKnSQzDaaE
         1tvIWjtjvYH9S7Fju3Z/saCuPCy7stsHWxaFDDSiP7AE5zChD9zX1V5QEZrEG9EVLA6X
         N8GO3jTjkPfLk32zyv0jMsdVzvjsyAO/u6yRIGv3TsCaa+SE89v+f67uhgJ35WocjtWT
         dFUg/xi0duSGptIH+l287GTNxl6kKXId/Ne6qzuhz8Zq1ZAk1jOf/foBC2R29loUxw0q
         wEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756927418; x=1757532218;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Rz5uVzOA7H7auuSeE0duRCSB0VUtJjaNdjd61cz4Do=;
        b=ZbazGFQXFNmClRCPC392JgHdZ8EonT6JU/lpiBGWk++SO5joSg/pu+r+aMI3im54I5
         B2JgjXOZTSwgn2PGTHBNZr6BBErLLtV1g3jA9cqTh/7XqS+4SvFPeOG6MbmukLbEudBm
         kziZk2E2+W0bAyvWPgIjxBju2IySlEaYTo5vvLWZpK9YM8pZBbNl7K1G8yYXwnw2Ou2A
         EhM30TTvv/n537RGW+VHIW+bNj0OCEvB4nW2QCgngHSCQHiraIyK5xTn6PTxO1QNFOZB
         y+SuBRQhM3fYVlip/1TgOMJndpA1+Ogm7XpKzOybFQuCFHuQCCAvtCzdD1mfxvgEMOUQ
         bsaA==
X-Forwarded-Encrypted: i=1; AJvYcCUrJXFkF2msBm1aszD8NuS5/1SzePEXCaC9GK/56/ny8xgd8VeuYS+5gnPoaXKJ+Vo9a0LGPLIvadPWphVv@vger.kernel.org, AJvYcCV3LGLMnRG8Z2YvcIFBJZ/rKk5W3UW5T1kIeJR1yDuFU5BrSkVPhM1nthFHIRm4BSbp+Tv/Vg1LbBQ=@vger.kernel.org, AJvYcCX5I0tK8bkqb9cVfawlysJ2t5hTI1qqgQgod5YRLQ/wRGLsFcRYwShOXML/5sbXs5IsUv5/gmyVkuhPZ70=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOz6XmyfCVpW8DwuutSNyy5GrYMJ9kkApsAimGDiwzIN6hkuWC
	m3EFCSOBfiPFJ0jqm4syC9+XueQKx0NwSE0uYQZ7KaxX1lCZlmKkFDtq
X-Gm-Gg: ASbGncvzZPapt7p0f/QWD+LXmA7BR8n8JfMgrtIMT0N9hXm6kBynzHmIIriT4i657Zo
	f22HvbldEjTsutAQB5CqLKRWzfB8+LbI0RA2y567/7y0kIILehomdga+YfDQ/L2o+s/ivTNIqfp
	TPnrY9UfieNRQHvzfm+lnWLI+Y+gnXp6/3vuYFMy9Uoy9dZ0GLvljsMwf16WvQfcZJefkGYsVwn
	2Q30HExK9baKEg+g5TuSuZ045ZyvbKPuIk/UPJdum7N2zSpig+0nKq3pOw4IiCelOYNUlBETmRt
	/xJezJvKEvoVEsVnDHtRUBu/HFXGSFMQvyr6OB45I3SkfmYrXmBpZ6/NLFZzitAi7XL0kALU+a9
	IDv5Rqsf2FFhH2zD59THsLJM43gATMeW4CiE42pET3j8ddg==
X-Google-Smtp-Source: AGHT+IGUTqUq93P4mmxYqAbOauXZPiq6DOgxdCVvRL0pOfr0mjA2ttsMFgSWafh2QAEcvC1EsRvFUg==
X-Received: by 2002:a17:903:32cc:b0:24b:1692:e0bf with SMTP id d9443c01a7336-24b1692e695mr115434545ad.31.1756927417419;
        Wed, 03 Sep 2025 12:23:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490375b6d0sm169024895ad.62.2025.09.03.12.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 12:23:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 3 Sep 2025 12:23:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eugene Shalygin <eugene.shalygin@gmail.com>
Cc: Jan Philipp =?iso-8859-1?Q?Gro=DF?= <janphilippgross@mailbox.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add PRIME Z270-A
Message-ID: <848b6d49-e21f-4e75-9bd2-9e251a8d8e09@roeck-us.net>
References: <20250903191736.14451-1-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903191736.14451-1-eugene.shalygin@gmail.com>

On Wed, Sep 03, 2025 at 09:17:26PM +0200, Eugene Shalygin wrote:
> Add support for the PRIME Z270-A board.
> 
> Tested-by: Jan Philipp Groﬂ <janphilippgross@mailbox.org>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Guenter

