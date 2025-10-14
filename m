Return-Path: <linux-kernel+bounces-852015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37582BD7F11
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C8D18A5B0E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E02D221703;
	Tue, 14 Oct 2025 07:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmtW6Bvx"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8322989B7
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427226; cv=none; b=Zh76J+d1YHk5WdkYw9f+WEA40rL59Mz9BGFoi+urL3pHSkG2Qp3a2AVvwsjr2q+xjF4OiSwzDdregdtcruI2gQCHM5FZVfNKLGatlRrFBAy2gp0DmQa7bHLW0bTr57ClcIF3fzMPNF71NVZNYjMxTRDaE/uYeyZB2yGOYuFlpZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427226; c=relaxed/simple;
	bh=E9FSOYcm7i09XJeInxjrbVFWzFXzEPihfDfXGS9CtnA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=RTpQqtQENMzlIX6BRtdGYDECd3cuAe3/9Bw/4n1J10WBGCEh8gE+kCAo7s0p1EHgLp8nOB6ree3v8/glo29kwtadaV8UQJyVK78CXPoqh0rMXvkKTBYlAb5kN/OqT+7W0Tv8k3u9E/uAOmqxqv0UCtEZcHDtGxAM6tYcVqK+fEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmtW6Bvx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b463f986f80so142496966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760427223; x=1761032023; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IEg98LpWuzbKCtN9pX9/aXP/aM01CWdHEywDKCbeZI=;
        b=FmtW6Bvxr/EfXlZC9MGmVI57bwooQ0HMsCJ2jBEBMfXwj5lc858+8ZrBle0DMAQFW3
         lzYD2yt9uOyMCfUHteckG0ek7bKAxzlAGhlc+MW8015G1E2Q6ILqI1dG8OPOOL5Wf69q
         hULMGSsSaCJxahe5L+CXAdfbyUnp5W1VxrKvtxkdm68wP0GzqgiUJgAE5FgZPUYD+lng
         m4Jq2tordGRh6WnL32OSbFrM//RmQfnlKBWIyy4gIesID0sbF6a/Z5myIuEdrzYt/wdD
         jmlyGdhLB2ZUDCkfqvH0z+QC83/3VWnKjtIqpXL1jcS1iJCW9O9B/woVpBzHNXaes4d2
         wHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427223; x=1761032023;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7IEg98LpWuzbKCtN9pX9/aXP/aM01CWdHEywDKCbeZI=;
        b=SRSRVw2lQLMckAkeJnYIo0J9mrGNysJ6TUxUxAyJzDkUh+YoyZ547XdWWXk4d/mnFi
         MMeswn49xhAt0RC2oOj8owRyoNES1Txd8mBYbqGzpKox72CA87tC69u/ZzuCGJdr1Xiz
         F8mG2nr8qHSrstoV1CUniBCfVhFNerXW+yKVVAmBRnAcKctirhBfe+FpgqB6h6rvRgTp
         zz3Ql5Em7pwPF5bhferhCU7T93gIOmp29HlQJR14F3VqWfEr3dQM5sfFP/kOsHvfzLa+
         QK1d2Cyw2LsWrSr+5RVbppZKXn11VTo1ZEUb76xsuKWVH2HLsWoNZB1YG1syU6WY7kax
         m4dg==
X-Gm-Message-State: AOJu0Yw6qHKk/L3k83Oy/od74XsydXJxG+uOIPya7TqSOF2bTptSYGyJ
	qm3IAC+02gMplsUed7nt6gGFsdsMjYsuBOu1glIH9P/UtneQTs3FvnrAjZldXnSB
X-Gm-Gg: ASbGnctSN8gPfvOUuk2ZLkdpBYBEXpnf3oZ7jKJUy2gdYibejKSOXPvqKBtdSdYoujB
	/8YjTPRW3rK6b/QnGY0ncpFY5lBrvf2jyRHfZ9T6j3QiV5FRyW/8Ss9v86cnRlertJk+PYLdLzi
	OWH0L+7sSVPvVIwV4dr2CaVyBDZV9eCMyd9jdqLHGytKgYAToaL0+AqkvkxD3zm+D+FKcdwlhqE
	o0ilIOV8CJTPzYbbCE9HiuJDbmAXiPXeswzUs8IQYSFq0jD4u/nly8jSn3KGI8JTLw1eqrcPEid
	+kWrTi+dI/hEPZ1dPwMdNfkYroycwDuP7KEE2Wq7uGZN/VMh7jwEs4Hn+GturmtmJi4KhUqq46y
	OTIfaJ5/mIvRsJCqPIH837WX85z9AFwue29vJx+jiAjQLxH75BQchyBsVO8YRbu0tokgXLyNXSr
	c=
X-Google-Smtp-Source: AGHT+IEeVHwAx0FPVDhlI8GXtseViCYJAPnq2mlIoZD9ebgPh39iXaRoB2Ty4ZTXHVVflb/KGAktig==
X-Received: by 2002:a17:907:d86:b0:b49:5103:c0b4 with SMTP id a640c23a62f3a-b50ac5d07f2mr2700342666b.56.1760427222709;
        Tue, 14 Oct 2025 00:33:42 -0700 (PDT)
Received: from [10.0.72.158] ([213.52.63.204])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d9113a67sm1113181966b.70.2025.10.14.00.33.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 00:33:42 -0700 (PDT)
Message-ID: <46facf7f-de3e-4cb2-b452-df7ffe9b474b@gmail.com>
Date: Tue, 14 Oct 2025 09:33:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Johan Korsnes <johan.korsnes@gmail.com>
Subject: USB charging: How to determine maximum allowed current draw
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I'm writing logic to determine the maximum current draw my USB device
(gadget) may safely draw from a USB host port. I haven't found any
appropriate place for this logic, so as for now, it lives in the driver
for my Type-C controller.

This means I have easy access to the negotiated USB Type-C current at
either 3.0A or 1.5A. If the Type-C controller reports Default current
I would like to proceed with the BC1.2 negotiation next. This is also
quite straight-forward, as the driver handling BC1.2 updates the usbphy
that I have a reference to. Hence, the usbphy notifier callback will
inform me about the outcome of the BC1.2 negotiation.

Now, the problem is if the outcome of that negotiation is SDP. In that
case, I need to know whether the gadget is enumerated/configured or not.
If the gadget is non-enumerated, I'm only allowed to draw 100mA (USB2),
while if it's enumerated, we're allowed to draw 500mA. I don't see how
I can obtain this state from my Type-C driver.

I noticed that the UDC driver, together with the composite driver, do
inform the usbphy about the correct SDP current, based on enumeration
and suspend state. But, things are a bit racy, as the phy driver itself
uses 500mA as default/initialization value for SDP:

#define DEFAULT_SDP_CUR_MAX	500

Is there something I've missed? Reading Neil Brown's LWN articles on USB
charging, there is reference to on-going work on a dedicated driver for
handling USB charging. Or, is it the extcon framework I should be using?

Kind regards,
Johan

