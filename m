Return-Path: <linux-kernel+bounces-831153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E419B9BB56
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61AE4C1AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E2E2609DC;
	Wed, 24 Sep 2025 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dy9r53sX"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A821F5846
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758742235; cv=none; b=VAUIwOXOgpsEyV4m7K0C5iSRQS/2HsKFqAjp5aCz37G6Nurxn2gBUxWcex/pqnxgyBSfU4Cd0KLbHaqcZI0tQIaM8Rp7Mo3NldHU3J+mWfXaIcL2shWCsrJUb/bXwq0XvSs6IjkJanqR64TEFkiBVwDSNbDfEExiK6osLnc0Za0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758742235; c=relaxed/simple;
	bh=/e4i971/r7Fw/eEhFZtksigrKbXlOazlZrmnop2pcDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhiaWoaGmWmkS28hfcRKiyrcTl/SRkQRRdT4gBG7qr5eY3jr3QRY59+1c0mM3pneTHE81Aq/0hbaRwh8d+COcnzB2KrED4h5v16MEUW91K35/PUUyfHjhcHOQE/3wzWkuLBYSZeHnw73aHmHpKxCRda+yiNPlUD6iGxP7PyTseQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dy9r53sX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27d69771e3eso1398715ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758742233; x=1759347033; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WUNFCslYIEFTynDU+6nP8kR8zycndcSpw/ZB7QnT4fg=;
        b=Dy9r53sXzjFA4OGosg08HJwOXziqxlItDQtBwhIUQBYF3ya2z2YaKYYqDROzkYHnR5
         jgobOyaaXamafXOK8TmIoAtxEJhEwiovtAeHJSG8i1wE289enI9+XkNSN3o6qpZicvsD
         wsbiIFclzdeGe5lTdRXD3jeIgdMg2XAsV+l5rVX/Jhpyw5K4ez7k4YP6aNH1bdzyXv+Q
         JZ6Ge3JY9uk1A7iMrQXnrRo/2ZIZUxe2xVtMBjODEsamHv1+eOWf6m+Qjx2Vzx5HnbcT
         0Ywl2ryUMZdnL1wdqY1+Cri6419o9v0cqL5u2ke7J2k/AlLuPd8hVRnYeUn63HtEFJdD
         7eYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758742233; x=1759347033;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUNFCslYIEFTynDU+6nP8kR8zycndcSpw/ZB7QnT4fg=;
        b=Zta1PF/Kst26wEYI7yZ46fQaA8VejrKOgCoA+noRE7wf6sOVE4f6C+wSYQF76zuTV1
         Tj5Vk1rWnYt5+De7gvk+5oGPJRAZVQd9AZ3SAliqRicK9Ed6I1HeqmBDEuRCxxAnaS2L
         7OhiNQlNnVNqatlzdfVUD6JihHQXF9zEViDkpC4T5aHRbaC3TZ8JLnnfKEV2DChjiEMl
         tbgG2UlJjQMBFYguTkF1N+omxg/bZldTm+zEskXVIFEgDgH8XbMxXXADI6McgSxy4Izv
         DerdIpYSoer7rCZCFUTGbGgCUYDQD5tSL0+6pVGZBKmi/3hXp6ihBW/IdeljyWjDzlUl
         wMKA==
X-Forwarded-Encrypted: i=1; AJvYcCW4c89WMHU8Dbx78pZlliO+ZHAUFBQ5jOICNR6uvuGdwB+G/SrNP6fWTlAQO+dA9zBY9WBSZK9fx61otbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvDUA33GXoNMrYXJ9oDlIj007HjqkuaXquB2EYLce3Hw+jlmhU
	YifTqhTryILpbleU4slWB7hpQDBlfdH9ghEmDw9mg15RPVsHtQsmLyk4
X-Gm-Gg: ASbGncua5iMGe3zze6Ffhv/Q8AYZisGsoOpFVt7xT+ybNfadvwsC2kYmQCmjfbTYvO2
	KYxtueDp9+U860vPwAcgUfDKhfDFbCovwvGYfh2WlbEW+Pa2OHSbJpoeRrl3yYKVKlB12fgdhQM
	EWd0gs60Vi4W3A3LimeFDrHVowrTkcOoQf9H1e7o6vUmQaININ2wDm+l2jZNg2VV+TDUBPywfS/
	0qrvY+m9ozKGL0faFmM1ggN0lJS0n8XmUtm/kpt5lEuKcY8iGcFzDomrCAGPzTBWpxSOxrZkeoy
	P41GWi+3PeYuIiQZAyMz207uPTZLXPtshc67UKsfPQZOPA7qM8Ef4kuBRkIe8mg0GT95FyzFz0G
	R/3G+aa8kXSOM7eTiUDEhOAJNfI6IqtlwFnc=
X-Google-Smtp-Source: AGHT+IGXgHIPGwjBqDVM78HsNs0PblmkiXDMpBXIECEl2ksSHuLIfRokrz6fPJ65rOVTJopiGyU7Nw==
X-Received: by 2002:a17:902:c403:b0:23f:fa79:15d0 with SMTP id d9443c01a7336-27ed4a986e0mr7756055ad.46.1758742233251;
        Wed, 24 Sep 2025 12:30:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed68821d3sm181785ad.83.2025.09.24.12.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 12:30:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 24 Sep 2025 12:30:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sung-Chi Li <lschyi@google.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Jonathan Corbet <corbet@lwn.net>, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, Sung-Chi Li <lschyi@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH v6 1/3] platform/chrome: update pwm fan control host
 commands
Message-ID: <60ecaa03-8cf1-493d-84fb-16c0ae71357d@roeck-us.net>
References: <20250911-cros_ec_fan-v6-0-a1446cc098af@google.com>
 <20250911-cros_ec_fan-v6-1-a1446cc098af@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250911-cros_ec_fan-v6-1-a1446cc098af@google.com>

On Thu, Sep 11, 2025 at 06:56:34AM +0000, Sung-Chi Li wrote:
> From: Sung-Chi Li <lschyi@chromium.org>
> 
> Update cros_ec_commands.h to include definitions for getting PWM fan
> duty, getting and setting the fan control mode.
> 
> Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>
> Reviewed-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Applied.
Guenter

