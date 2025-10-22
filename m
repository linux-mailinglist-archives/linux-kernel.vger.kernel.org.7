Return-Path: <linux-kernel+bounces-865563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E75EBFD650
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5483E188CC6F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BAB2C21E6;
	Wed, 22 Oct 2025 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0HlM6vy"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4BD2C11EF
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151864; cv=none; b=r7l/4exZUkcyU/hftyUgjQVnwBH2a3UwP+r4KdR/bnJ/Lf/OVp89N8HbtH1JihP19WhEeYWJhTICAAAX2O6NfkMkvPm4/tpn58MZURW6n8lbid8etHBJejIi3m3LwmM+UykRd295SiE8wfVD3FPFHPCqGcC7V45uZw2DkKMa124=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151864; c=relaxed/simple;
	bh=kaEfWt9wqqvS9mFtAO4AGXG/sT+UdEYY4lcsjrbyZL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z95Q5fklg5VNsHSt3uEWCq9Q7iSsaQYALHLEBmsF3W6p4Dd/v3k7YLbwUPAYlN8NqL5NQhUeB6r6oKr/N3GBE6pXc4NrXR9RHFj8CMDR4hSlwYpquOJJ+wF7+M/7IGQOCuLefP+dj5CpREslF9oygYs1i2ztZFSv4OMl1P+Li24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0HlM6vy; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47100eae3e5so25829625e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761151861; x=1761756661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJuLX7aWbTU6mURFbiEouk0cVstXAiHjIzxM4BL7c6c=;
        b=T0HlM6vyV+4O8BuhoRvEyI1R3uNZbhKvTve1TB4Bc0pOvynfd7uUpLcHgWco/ItqQi
         i7yoe4HjaCKT84aUuvs3yvlE+O5Dj+/80PnBawuQ0IEfx5UY1zJn+W1TV4e7rpOuvk19
         B6exusvKw0n5rhlluViecnxzzjNbsvl/GqSbqf+XxdxM1XQZehsb6n3GQlaICJ5B2RNq
         TixFJETq5xZJ1ZzsfeurpVOSMSL0obPVfGtRUekXrJ+Ip3RkozygIQPRmhc0zXyKUzA7
         kGOxaX1FRQpAsB698z+COIa/9hL/eNUcqPdwjmNdLImVinPe05owKdTnTX9tFH3U90oG
         5Rhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761151861; x=1761756661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJuLX7aWbTU6mURFbiEouk0cVstXAiHjIzxM4BL7c6c=;
        b=KHT02lk3lw4075aRu+IS9/kdNQTWMMAFrW/Qgou35JPHfX3eKDOtJTSQD4YjGOv5MI
         dxTk/zOObnDu0y5YR3/39knpnf2Jvi6qEQOADhFdbkOqFxhjJ90EuLgYnsaAs3CZGJsC
         dEou7OxuBPr6U79fwA/ckYdH0e9e98YXQVYFMhyJjcdWXh60IG0R+VyTVjuM94SThxMZ
         riBIBJ5qnEZAdr+P0FeENyXMiJMuDubEL1AlyYAmd3+7xXunzYQEBJ6sMTvBvMEivCqn
         8jjxGHs8Mw0/DOBtT8Rf80CIv4FBBg57AG6Eqh8JQKfigkpqAGDn6KQxFJKBKK2/X1T7
         FwHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHft4Ft//Obv7M2I2/dcvhM8uv/9ZBpRrjjJk+UNnS6WDKWLdUMxYAQIkjWE5/sSFJB/eypo5ynoA3ct4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi1ps6HItq4WpDcQx7PgAARnU4Z0YznW3ywg7pedVYhLggf6fR
	+E8RW9P0s9ZZVQFli4QTpOUZkaDB6f2DzjqctbTJl41+txa5OuN5CLpg3Sx3ow==
X-Gm-Gg: ASbGncuKCyPzO7Mw/LISA2MYB5fmFGwCwlx+BEPF3H9ZVenPcLiZF4IL9yfe1I47MGZ
	AmTBwrf7i114MjZjWEZBdhnqPQa7YUnf5sQfPfPevs0mheAU2YDt7qUiSfbNRZ8fRSR4JiZPHWe
	EDCTxkdtXnQfMsKSO3cQpnivaGT+6bRSJwzwol+aZtpVbJLVMGZa+wgcO1COy4Z1e2dLhlv9cI/
	gbkIoDiwRvOPsnIzfEp+Qnt/IZKenowtfaICg5BVcACUwzBiJbiJRxKWgje9osks7MzRc7NxUf5
	2oZ1dfbMo90uEpMota6kTRDYOXWD3CeCQ9vJp8/KCfyiWrrnm0glMc+k9nJWg6Jak7u/dnEcvus
	slNA27lR2Xy2ANRXsYcgyVwWRR/ItaDZcckA9P4RZ+0LBQiP46mYzwfHuXaUEgObn9QIQXINJtW
	nIU1o8X2EdPZ3RMMYpKiDbZm/gEXD9GRXwLdFup4txf9EJUFKvHzIi
X-Google-Smtp-Source: AGHT+IFT7+uFu/qxWlLQPopQzLXURbG5FXbq6hzN6rI9f1qJ5A6vjczxyKhbJgI28xxG6M+CCYJTpg==
X-Received: by 2002:a05:600c:548c:b0:46f:b42e:e39f with SMTP id 5b1f17b1804b1-4711791d96cmr151979785e9.40.1761151860871;
        Wed, 22 Oct 2025 09:51:00 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427c3ecsm51858965e9.2.2025.10.22.09.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 09:51:00 -0700 (PDT)
Date: Wed, 22 Oct 2025 17:50:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Huisong Li
 <lihuisong@huawei.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: therm: Replace deprecated strcpy with strscpy in
 alarms_store
Message-ID: <20251022175059.7653c2e0@pumpkin>
In-Reply-To: <db33871a-26ad-44f2-8e4b-046aa34f6477@kernel.org>
References: <20251017170047.114224-2-thorsten.blum@linux.dev>
	<db33871a-26ad-44f2-8e4b-046aa34f6477@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Oct 2025 09:01:08 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 17/10/2025 19:00, Thorsten Blum wrote:
> > strcpy() is deprecated because it can overflow when the destination
> > buffer is not large enough for the source string. Replace it with  
> 
> It cannot overflow. Look at the code - memory is allocated for the size.
> 
> > strscpy(), which avoids overflows and guarantees NUL-termination.  
> 
> Maybe NUL-termination is missing, could be.
> 
> Anyway please write commit msg describing this exact code, not a generic
> one for work replacing strcpy(). Your generic commit msg is just not
> applicable here.
> 
> And even there, just look at the code - why exactly cannot it be
> simplified into ksrtdup?

Or use a different function for numeric conversion that behaves like
the userspace strtoul() family and returns a pointer to the character
that fails the conversion - and then check it is a space.

Then there isn't any need to copy the string at all.

	David

> 
> 
> 
> Best regards,
> Krzysztof
> 


