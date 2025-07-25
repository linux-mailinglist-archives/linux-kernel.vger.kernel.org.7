Return-Path: <linux-kernel+bounces-746362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC998B125C6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1040B561E99
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1918C25B1CB;
	Fri, 25 Jul 2025 20:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H3lVmFoR"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75FB8F5B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753476349; cv=none; b=uRdkLe4mt9gL9u3uDU6pSbi6Btw7FbofbaYJLUwygdJXhHTT9LS+5aO6QR7Mi4MgK9keJhtpOwEVhf2xLamNX2rrB1kZ8QQTpTisQakqDhs+q15S9ZS8f0r9a2dMx/YapuEJm7BMxBY5hKbbKFbuqgV8Xmzp5gcrTqlPE7kU5GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753476349; c=relaxed/simple;
	bh=ML3wJzicutJ7pzzOS8eBw3LcVt5abqgOJBY1Oc5SJuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XE+bfwg0/JqGxkHTWDuwCoDhru835DUIQaGWEDtxO6lBx3+yGE/bVU7JyTVdMu0+frm1WLvqfIm2PNpb963V39gVQtc6iTDKg9gLitdhJyGNNVsmgQOxwwd0p1wwX9ibybI7CA8aFO/OLmHIta64WZxDCbwN9PPznak/hPZ7KvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H3lVmFoR; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55a25635385so2916933e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753476346; x=1754081146; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dkFV7hywCaEtlGf8Q7mOLQIOdrHzvmI6g+XiRXRO/yU=;
        b=H3lVmFoRNQwYPfeO9iBYuLeITvT5MfGwDaTZSBL4vFsmPXyN4MmzuptVIqFGk/RsET
         V/nHPKAft0ZeRN2EubE69vkH4mDwygKZHC1snpsD1wZ1XTeMAtllKdA5qBuZ4bjo3zox
         lEtQEPDLGrheUbzzUcji3f0r6dzdxRBscfxo/xi8BI9/54iqIzuX0awLnvnyWcJgJmzq
         xsseyVYJ2PVzIcU8ai65heX8iQGEgZDdr3ojx+ImVw1cdeWSwNCKWyogwVGmiog42dQE
         z4gKNr5JPLRcAIwzscs5B+PMlvkYMDQ9+aytomfLp5js/YrucUtkBlpW8qt/W5ULTj39
         fNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753476346; x=1754081146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkFV7hywCaEtlGf8Q7mOLQIOdrHzvmI6g+XiRXRO/yU=;
        b=jyFaAw2VPIowkjr/jXyKeDerAqLcyxmgWglaaSxb3IB1KnlygNDL4Wc9Zjtv0d5jJw
         uLVUbFPQ+6Jr2IayqqE33fBn5vsrFXNRU3xHB88w75F4+Z04vV1GHUMpXeMC2ajfjlz5
         S8a5bV1YuyaPIBWN34X7dwtENQ071y+SXkxIuGP56R+3C4DjLDsxra5iNaAuCEI+q1bh
         Xa/TvekSIBrQZp5r0zLUBb0VEt5/IxOew3zaIhHlfxLcz9BkjTwNB6Q4u92JQ+dS5GmA
         /ax0ztgdj46QmwPC/gRGmOTpgbmSy1UJIKPSm5VjcatTuq1M/5QvIuAyFqKQcmzgUuFZ
         5Sqw==
X-Forwarded-Encrypted: i=1; AJvYcCXG0wNNZt5PpvAwUec0EdsBgnU4cYovGBkeKMJf6IKYQlJCYj/n8zAd7kRdrZRB2wRVskThQqsLcIGe+HE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIq2E8EhAJUBHbk5BHtswqh4Ws2PTZYge0ljO96v/otYkSyHoQ
	yUAB2En7ECllbgRtxitktg3xdAJBLWfd6zNqUI9wLetbsC9NP0W8g+guvtltgB8woaqQWr2S0iY
	P5bS/e8tvgrA84jOnUUs15Y36KW6Df/jpvQ5dy843
X-Gm-Gg: ASbGncuLCWBT9Q83XivfpVA32ruxne0otg67AFyHeBIIWzdUOfTfNJdOXP42YMCjbFW
	MKQXXZKX9c/dJL8Sl532PlWCx9/Z5ixdL2m1Ur9T9y8EeUR1S5hYm3NU6Yfp8XjRPCTOiPr7EE2
	bgUYLSQ4xZ3bh7jq1WoHQUsfUqXfOPZBdnvzAG2/t4sXxXpw++JdwmVJBJlxcL6oIRzhwAGhMfI
	rF9XQAkCZXNSfveug==
X-Google-Smtp-Source: AGHT+IHH48TMpDfzEN/GY0NLk20jn5GyvCErTtW6GyBV2cgMPoLiDuPLD9Pt+FDD3Nt+B3TDEvgLB3LL4Rp8lrPZ7CM=
X-Received: by 2002:a05:6512:ac8:b0:553:cf7d:7283 with SMTP id
 2adb3069b0e04-55b5f4808cfmr1002884e87.33.1753476345590; Fri, 25 Jul 2025
 13:45:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALU+5Va_zeqS5YK7v3HNvDKkg8srqc87P5ZaQUK5tGFUMyNrkg@mail.gmail.com>
 <42f4753a-f7db-49a3-ba40-8743a78684b4@rowland.harvard.edu>
In-Reply-To: <42f4753a-f7db-49a3-ba40-8743a78684b4@rowland.harvard.edu>
From: Olivier Tuchon <tcn@google.com>
Date: Fri, 25 Jul 2025 22:45:29 +0200
X-Gm-Features: Ac12FXxD8K4ZtrkE9PBWaB_iYkwnoMBGmcB3aMxN41S6-C5rqYsj2xJeiUdU8XU
Message-ID: <CALU+5VYnZfp2CqXqn7X14J5pGsXyHDOcC5mOCZx4nKA6tjzO2Q@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: Add gadgetmon traffic monitor
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > The UDC core is modified to add an optional monitoring interface defined
> > by struct usb_gadget_mon_operations in <linux/usb/gadget.h>.
>
> This does not appear in the patch.  Was it left out by mistake?

My bad, sorry for this silly mistake.
Files will be included in the next patch.

> Do you expect that other gadget monitoring modules will be written?
> If they are, assignment to the global pointer should be handled by a
> routine in the gadget core, not in the monitoring module as done here.

I have no plan to write another one but designing the API to support it
is a very interesting approach. I implemented it in the next patch.

> There should be a similar optimization for IN givebacks.  The data to
> be transferred to the host was already recorded by the submission
> hook, so you can save space by not copying it a second time during the
> giveback.

After a couple of tests, I found that the payload at the Submit ('S') stage
is often meaningless (zero-filled) for both IN and OUT transfers or the
payload size is already set to zero.
I simplified the logic to drop the payload for ALL Submit events.
Fixed in the next patch.

> Would it be better to keep the event but drop the tail end of the data?
Thanks, excellent suggestion. I implemented it in the next patch.

Thank you for your review, Alan.

