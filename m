Return-Path: <linux-kernel+bounces-889967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE812C3EEEE
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EBFF134C30E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E483090D5;
	Fri,  7 Nov 2025 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN+jDjtG"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CEB2D9EF0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762503629; cv=none; b=FJF1oTNC7xIBWfnASDczP6KT6baJMCUqPJzkO/YrjW7YR7ACeuXwtvsU+K4R3GA5/pPPDbpLtyZ4i7vMIl1SJeeAmuUad/KFSNkOTwo3t4p64haG7kkxS+Tgv2UqkTcrUUltLt+xZgDEECLR5fR9z4bVGmbTOZYoltOiCc0n5BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762503629; c=relaxed/simple;
	bh=gI7Fuup8i1amPEK0YbxklMM9F668JXoIpmY3C3wbz1w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxVVxXmGpQ7GyFfZ9SJzoJvsrk3w5ROmYLY2vP/tjtqlAmWDeGAqVxQfBtfy8br6RtIs2enkh9fh/v8XcfGnaS8q+FUk/DKGO7lvsstQHs5i3+J65yL3YDwvRlDDFfURqABkqINgdEBTove5caq3lT4fdg/0MBnFueeLN2RNq2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KN+jDjtG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477632cc932so1777055e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762503625; x=1763108425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vk1MffHR0aoVhf3k27Pk0Lpr77G2pGMlsaZ4lNRFHLQ=;
        b=KN+jDjtGpuSjebdC9tHtkw4+Fs+1jV1c+sZAHsBRfBt++dKygtma4OmUoNDqTWw8Jr
         kmKLmzGAr7Ap94QTl8WFlpphN8zi/+UhYMWkw7TAWmTVIZQmjVbweZm5deb037Dnud1P
         IZ+uB3fWsowVUaVKClU+cxi2BuLjG6+7d+9u75bumiCeV9ck5502uZnODbfzx1FlfKhT
         BuZjArNZTOPUdI1u7e/YTMIM+vCqcPeXPqQrzLwL/Rqc57KnE5ADme1es0aMVViPbKQt
         Kv6KTpMgffAqu+KvwLukU+h7HU16jUj0jroqQ5IjnWv+lHyfsG10XIm9P7G2l8QqSvOq
         luHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762503625; x=1763108425;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vk1MffHR0aoVhf3k27Pk0Lpr77G2pGMlsaZ4lNRFHLQ=;
        b=IEDRYOtO3QhBHxCXTQda+PiZI4gNQ6cAR83gBwFBkGo9B3hFJSZynlGD1BmXiNRlO/
         IWAz/keGbQ1VshecttLkeMEouEq+58RjwHzNAOuBsVNoaYwhhvOmL1b7zolQqxQkkdMs
         XZjue4HcgUqxHgoODm/SiP9H0TIUXjXaBNp9yxJRizPrzG29z6zr10zngWbOkS3InwIS
         yPypPQZD22A0O074TDJYj6eGbJw3FMkH6bn+LwNdqsauj6u8t0xXuIlPeoqRhzU00kwW
         6Dqzhzx11mcUqEzjXHraIjdV+ZjOIWAK9s3szm+ChrXpS526U4zloTWidOckwVyguGwN
         P0dA==
X-Forwarded-Encrypted: i=1; AJvYcCUwJc/+Jyihpk2Dm4j1bSBkDcvohvjPzIAQReWx7O7qNleKEs17zNNCgjYK9uYqpWiMkJY71qlFa9QqeXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrMvVCaZKXlnSQ2l61h5ILXoJmPBK3siQR1uaVv3pCPCeUZ1M+
	76/59DjvAcuAWta2sUxBHJ3xIGg5cR9lY/cqI6F34/iNdkgyU2jKFlqD
X-Gm-Gg: ASbGncuu67fsedYUl7MGqMvre4PaBlxeoNyC9GJuT5HQcEJ9HwRHtjH5CMUX31GdZSu
	TxIZIaihTya0zMk42c/rSk/oAXOO8f0qaBBtlUw2zDg7RagrY1RZN2Rru3rh6jlC7I8zDNsr9VQ
	4aFgmsIrb2pNtk7aNwa8LlYyw2QJl9jfRUGx9SC5Lv3RriuADHjsx7Ry8Eb3sghVlZEFeo1+LPv
	M+/WRHhX7xVWwuEaLFV2HoIAkTrY8MSYnxxXi9CpDN/PzGk4KHcNdnlHo0Xg0DzQjocX66c18qr
	AkV4crmVWXmvFnTMZjuQjlzXBSjua4DSr2rDLlOMCx5xK7gkBN7iglVq2zhZIy/6YNRXDjaz1b/
	WlHRvyMVdKf9ucbZqohYWBNsfyUy8SNR8noFWzkUulasjv/P0tYmjrXPosNLcWQrRxGFa4XJOoQ
	zw9PNs4i1kwQ+M1RuXi5UtiJSwXZA3fRvywgZKkEw=
X-Google-Smtp-Source: AGHT+IEVLaEMFOvPeZc0Oi0rUOFMOQBnNHP+rsaefCysI5BwrUTSziTcZsuRefMyYxTThj9ZiHILoA==
X-Received: by 2002:a05:600c:4ba2:b0:477:4345:7c59 with SMTP id 5b1f17b1804b1-4776bcc9886mr12696425e9.40.1762503624631;
        Fri, 07 Nov 2025 00:20:24 -0800 (PST)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47767749916sm70627205e9.4.2025.11.07.00.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:20:24 -0800 (PST)
Message-ID: <690dabc8.7b0a0220.35db7d.1d97@mx.google.com>
X-Google-Original-Message-ID: <aQ2rxvM3JXcFbuaF@Ansuel-XPS.>
Date: Fri, 7 Nov 2025 09:20:22 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Felix Fietkau <nbd@nbd.name>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] dt-bindings: clock: airoha: Document support for
 AN7583 clock
References: <20251106195935.1767696-1-ansuelsmth@gmail.com>
 <20251106195935.1767696-5-ansuelsmth@gmail.com>
 <20251107-fancy-premium-lynx-dc9bbd@kuoka>
 <690da391.5d0a0220.33eed5.80b7@mx.google.com>
 <ab520621-b11d-4763-a7b7-fe7dfafdca6c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab520621-b11d-4763-a7b7-fe7dfafdca6c@kernel.org>

On Fri, Nov 07, 2025 at 09:12:48AM +0100, Krzysztof Kozlowski wrote:
> On 07/11/2025 08:45, Christian Marangi wrote:
> > On Fri, Nov 07, 2025 at 08:42:15AM +0100, Krzysztof Kozlowski wrote:
> >> On Thu, Nov 06, 2025 at 08:59:31PM +0100, Christian Marangi wrote:
> >>> Document support for Airoha AN7583 clock based on the EN7523
> >>> clock schema.
> >>>
> >>> Add additional binding for additional clock and reset lines.
> >>>
> >>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >>> ---
> >>>  .../bindings/clock/airoha,en7523-scu.yaml     |  5 +-
> >>>  include/dt-bindings/clock/en7523-clk.h        |  3 +
> >>>  .../dt-bindings/reset/airoha,an7583-reset.h   | 62 +++++++++++++++++++
> >>>  3 files changed, 69 insertions(+), 1 deletion(-)
> >>>  create mode 100644 include/dt-bindings/reset/airoha,an7583-reset.h
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
> >>> index fe2c5c1baf43..2d53b96356c5 100644
> >>> --- a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
> >>> +++ b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
> >>> @@ -30,6 +30,7 @@ properties:
> >>>    compatible:
> >>>      items:
> >>>        - enum:
> >>> +          - airoha,an7583-scu
> >>
> >> That's random order. Keep it sorted.
> >>
> >> Best regards,
> >> Krzysztof
> >>
> > 
> > Hi Krzysztof,
> > 
> > I was also not cetrain on the correct order.
> 
> Why? The rule was expressed on mailing list many, many times and only
> Sunxi or maybe one more SoC does it differently.
> 
> > 
> > We have En7523 and en7581 and then An7583.
> > 
> > So should I put it at last following the number order or the
> > alphabetical order?
> All such lists or enumerations are ordered alphanumerically.
>

Ok so I think the proposed order follows alphanumerically order.

           - airoha,An7583-scu
           - airoha,En7523-scu
           - airoha,En7581-scu

Maybe the A vs E was confusing?

The confusion was if I should have ordered for the number

so

- en7523
- en7581
- an7583

or the normaly way

- an7583
- en7523
- en7581

But since it's alphanumerically, it should be correct.

-- 
	Ansuel

