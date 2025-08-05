Return-Path: <linux-kernel+bounces-757032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41987B1BCBC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 00:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECCCC7AA323
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 22:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050FD26A0B9;
	Tue,  5 Aug 2025 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="etTRpcOf"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F325135959
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754433658; cv=none; b=std9N2tAOPTefEQcofpzn00TyznrrgLF8LeL4VNWIGP1FpaUoNW3XV3b3psLa8zuXbWGm9lspIbbKy8gW5wnoccYA/usB/GwbXkMIN1D5whnwIKrXwo1J/jQXwuaCHoxi4QNTS7B06oSK6LCcJQO1inUIgnCbiHpOsj6yBgcnZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754433658; c=relaxed/simple;
	bh=zS1zWvhTT+IcSshTBcgi0LvYfFbo8Wss63zrFGwEmv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dgs8O9j/Uu5aGSEuNC6fKFfHVrfu0maJCU9MHlJIJInc7vRaP5vH4PHVtvp5W0ZO7Gbp4nn2ucUgfQRBgYaFLWY7dLOfrC3zuW69pJaydYxbooOoYuhqm4VnDOxxFjH/xeFrYe1YsAC/sURJVx/uVvj5+IX4e2GA8kGpDaNBvRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=etTRpcOf; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-615d0b11621so582838a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 15:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754433654; x=1755038454; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X3m+xXB2nDYY2FTeCIps+Dx8G8ytYsYqX18zczPNIoE=;
        b=etTRpcOf7pg5tQckPpSFEw6QjZ5vcwd+9l+m34Xtx2SpmlHVCRXQEhG1RgxsshqCxo
         VNWvbV3uesJr42K974/5EYvoK9Sbir5/8SV3wQ4ppUuKnGYyEvtjoIr2SZ/+JzSPyH2P
         V3/abqPAO8Xmz9f/QkY8uwovhVNjjwjnVqvTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754433654; x=1755038454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3m+xXB2nDYY2FTeCIps+Dx8G8ytYsYqX18zczPNIoE=;
        b=OBYj9yoD5AzbbP2id4C/TJPlADDtTmsSshkD/uFE/MMDTMkmMSJ0Zipf8kyrouiJJO
         aP2pVQhGGM9XVXo8flM5c0wrJdUurBLuN7Gp7Bsh4FuhzUTiexGKfKika9v3PgvgtvII
         7/fBhCsknXru2VsHSfTtz643An12S5pxRcVDN+yQ0AqAQhW0sADyoa+sIHfaHhEcQrzM
         LlkiDBtmyTozdCTZOPWYBmtSJDhIbdMIcsq2cSbjzuue/ca0woTMh3HeKdsXc4COC6uT
         X3T2mW8tSPaibLcdFf265028IXKbOUaaaSKf7r40f7gsYj2Zs+rAXYAgnhuV5Dfobad4
         3z5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRLhui/UGOtcuRgvFExkOJKnt1eGtzkDuTETxM6gMhzaZ+YCYj5w0JA6r4oCrXr4wyNzFTMw171d2jsZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCnW7PQQu69oH1mGYuwXmPzbkIr+lB6hbf7qt/8NFQEqBhICMX
	Qo4CVupbOcTAHofEg7MYS8wf0RHE1rsQ1iPtnYg5hIhdwx8xc8sKj0BA5iQLR5aCOP0YDnb9X5U
	dq0zZM246Og==
X-Gm-Gg: ASbGncse79ThPiqXxBglXCR9JQ6hpQHglLF9vzSLysjn4idt+nIzSdg/Qbkh6GfiLCb
	AUtnZdt1imsAYh6fyoOQdtg9qkcxnkfuEItB8RtSiYjHfbtSuHxlBhaavtLI/lxpa1aquX5+h4h
	BdL5xJEI+llTK7fhCyn2uib8FvWDsz1HBtR1psYs2s5yPOx1ak5Z42Y4QWqYs7XtsnuRPui31nw
	j97/oQLRO/QD+y6XsSQZAsy4i02tcVqIRVTFnOL5nqs8w07zccsCmAp0Kj1wkNPKKJ6GTLZMZan
	Q9cWdF4Ty5xwiaNnUpRf3O+zANmf5PE9hikk17WXYEzZJT8erhSig0O3a1IEMl4cj/PQ/frlszL
	od7DKhvcpq4v66DQrK+eILy5PPvOGy/Rti22afUYOv2/zoUIpGKPhTLbiaLDOqVNBtxwRTsRk
X-Google-Smtp-Source: AGHT+IGLQCxSzPbLqlEAPndsQvGfrqa0iYDnPth4pehk0RE8g2f//90R1JM7pgshExrDx2WPy3qejQ==
X-Received: by 2002:a17:907:72c2:b0:af5:5d76:3fbd with SMTP id a640c23a62f3a-af9907c7a5emr52104566b.11.1754433654188;
        Tue, 05 Aug 2025 15:40:54 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91b36e91dsm946968166b.69.2025.08.05.15.40.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 15:40:54 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61576e33ce9so666011a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 15:40:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWTXsXQAFQyB1q/VeHIsISWk1N2aW23pZHsCIJqD/yegjHq5pMBttRPOimEHacFNEhwAk59oN4GNlYdGk8=@vger.kernel.org
X-Received: by 2002:a50:d6da:0:b0:615:1ffe:7e13 with SMTP id
 4fb4d7f45d1cf-61796e84ddamr347112a12.16.1754433653535; Tue, 05 Aug 2025
 15:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801190310.58443-1-ammarfaizi2@gnuweeb.org>
 <20250804100050.GQ8494@horms.kernel.org> <20250805202848.GC61519@horms.kernel.org>
In-Reply-To: <20250805202848.GC61519@horms.kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Aug 2025 01:40:37 +0300
X-Gmail-Original-Message-ID: <CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com>
X-Gm-Features: Ac12FXzn6xC3GEWZwV8GpsWb-o1g1X9WA5sVZ0frXqURB1sH9fEGM06GbVjXWic
Message-ID: <CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: usbnet: Fix the wrong netif_carrier_on() call placement
To: Simon Horman <horms@kernel.org>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, Oliver Neukum <oneukum@suse.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linux Netdev Mailing List <netdev@vger.kernel.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Armando Budianto <sprite@gnuweeb.org>, gwml@vger.gnuweeb.org, 
	stable@vger.kernel.org, John Ernberg <john.ernberg@actia.se>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Aug 2025 at 23:28, Simon Horman <horms@kernel.org> wrote:
>
> I have looked over the patch and it appears to me that it addresses a
> straightforward logic error: a check was added to turn the carrier on only
> if it is already on. Which seems a bit nonsensical. And presumably the
> intention was to add the check for the opposite case.
>
> This patch addresses that problem.

So I agree that there was a logic error.

I'm not 100% sure about the "straightforward" part.

In particular, the whole *rest* of the code in that

        if (!netif_carrier_ok(dev->net)) {

no longer makes sense after we've turned the link on with that

                if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
                        netif_carrier_on(dev->net);

sequence.

Put another way - once we've turned the carrier on, now that whole

                /* kill URBs for reading packets to save bus bandwidth */
                unlink_urbs(dev, &dev->rxq);

                /*
                 * tx_timeout will unlink URBs for sending packets and
                 * tx queue is stopped by netcore after link becomes off
                 */

thing makes no sense.

So my gut feel is that the

                if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
                        netif_carrier_on(dev->net);

should actually be done outside that if-statement entirely, because it
literally ends up changing the thing that if-statement is testing.

And no, I didn't actually test that version, because I was hoping that
somebody who actually knows this code better would pipe up.

                Linus

