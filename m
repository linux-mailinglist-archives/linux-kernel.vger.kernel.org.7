Return-Path: <linux-kernel+bounces-803799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA31B46571
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7113B97A3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BF02EFD98;
	Fri,  5 Sep 2025 21:23:46 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB11295DA6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757107425; cv=none; b=D4Sh8EJJsHT7nG1D2j3iepfy5TrWly03IlqMUmNvTxti5ddo7y2PYOpsdJV96dfckVADEtREnQrqwIbx0xk5tYikIrTxrXJGzozNo5+6iTXWOZ9GgnLNLtwctfuOeqEolS9tfluPn2P+WpAyNtV90TJLnc76TMU6ETWAKJPnTzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757107425; c=relaxed/simple;
	bh=o/PqQhK0PKkxH5IBGjaZ5xFiBra8PzKV7+1t1tFVm/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lnO5C6NZaKO5owBnBrkg9mOFZASYeRmoSPto4+FJpy/IIMPsPaHOSyK4q4xIO2uh9aV8kjzaQUhrQP8uJqfh0EEKjKEGfSV8wCwbpcnuadsfVKS7/pHvonK8npW4S0pSdAXKl41x3RZf91DLwIf5jXv5cFV5qHEfk1kZ6z2vJ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso2084104b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 14:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757107423; x=1757712223;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6wZ9HgdgMtQgRD7Hr86g025jE/p6E3Wse2CcjqMIiw=;
        b=lJ788zXz26I1Hs//OynyiOnGyBALRE7iQHc28sE4vFHCSNRa2NZ5rjEhd54OBH4Cb5
         i8Ywzq3tbezZfuohO+eoJ/uBPm0lnfQc4+vcbL6dvS0M1iXB1lZYFulFInTpKuw+B3a8
         BunzfchBsMyHyFdvnhtvKh2j+pyXDeB1wyjlRgNhWRB9tuLy47BhcEvVyHnqIisqND7V
         0w3fL5ZZYCVplltFaN/XaoodVv+g74w11dXOJYlijo48Z8MUIisJZ+4ykC+aIFjnbRWm
         9eHeCAYcTjwPUMaJRoZSJkVTngkL4xey+oPDjFC4fPKxzWPE5VdaT/FrVYbu2lAFPRiB
         HIUg==
X-Forwarded-Encrypted: i=1; AJvYcCWGD21wuBZWhF9ByhIIZcKxzQ5F22pEtWMUEyBix6oBr/ULiyKrXh6i/pmYDyHWNHfLVAABPX2zZXtAmaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHrIyRgvc/NPaWMypK17fxIOPSzXAGmO/TRutXMEkDmoD2MRdb
	QxeLM0ClhljPPPCOksKHNwRlClDtkXIRdLyS4LqKdpRkCGdokywTdg0YiS02CNctx48=
X-Gm-Gg: ASbGncvYdJapOL/8o8lbBjVhEvz+EcYylOBqgllokb0QL6VBYG7qdennTnNMmZcd7i+
	2d0nd9fBHrsLtOK/CxQu6xiUUEprQAUXnzWRAVV0f1s2Vrz6lz3WG7DhvPFnjN/vh1QcmLO7Vbc
	1ESE8Mf0ExO5AoJJ+70wQ6kGwd46bBdxKCP7nykr2Bnm5I19s92vZG2EAJ2nKc06LgAcAU49DND
	6kdygzsCRvwzdGOSB2hI7fh81I1ZrRkIR41o4DDSW/WARYlPbif71f1Kl+WhVkN74Ur5N9t7/Kj
	o8/DDHxtVib1OOopFhigzpP0kd4HOtFk4312q5IE6hVVUFkZt9VbVZEBRON3naNG0xksP3/mrSs
	aR3Hf1uIsf9ozkdOhDGhW
X-Google-Smtp-Source: AGHT+IECEsSQkwfBCZIu4aCVdg/6xbbfhAHy0KA5ITM5kpE6xl3JxGGtEoATFjZl9SBoRxWqA+Li6A==
X-Received: by 2002:a05:6a20:3d89:b0:246:f1:bec3 with SMTP id adf61e73a8af0-25344415094mr362891637.42.1757107423576;
        Fri, 05 Sep 2025 14:23:43 -0700 (PDT)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bf561sm23001252b3a.59.2025.09.05.14.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 14:23:43 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>, Brian Masney <bmasney@redhat.com>
Cc: Tero Kristo <kristo@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Maxime Ripard
 <mripard@kernel.org>, linux-omap@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] clk: ti: convert from clk round_rate() to
 determine_rate()
In-Reply-To: <20250814094527.29745592@akair>
References: <20250811-b4-clk-ti-round-rate-v1-0-cc0840594a49@redhat.com>
 <20250814094527.29745592@akair>
Date: Fri, 05 Sep 2025 14:23:42 -0700
Message-ID: <7hseh0a90h.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas Kemnade <andreas@kemnade.info> writes:

> Am Mon, 11 Aug 2025 08:48:05 -0400
> schrieb Brian Masney <bmasney@redhat.com>:
>
>> The round_rate() clk ops is deprecated in the clk framework in favor
>> of the determine_rate() clk ops. The first two patches in this series
>> drops the round_rate() function since a determine_rate() function is
>> already implemented. The remaining patches convert the drivers using
>> the Coccinelle semantic patch posted below. I did a few minor cosmetic
>> cleanups of the code in a few cases.
>> 
>> I want to call out the changes to the dpll driver since a fair number
>> of changes had to be done outside of Coccinelle. I unfortunately don't
>> have this particular hardware on hand, so I was not able to test it.
>> I broke the changes to this driver up into smaller chunks to make it
>> easier to review.
>> 
> Tested-by: Anddreas Kemnade <andreas@kemnade.info> # OMAP3 GTA04, OMAP4 Panda
>
> No new scary things seen on boot. Can someone check this on AM3, too?

I gave this a basic boot test on am335x-boneblack.  All is well.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin

