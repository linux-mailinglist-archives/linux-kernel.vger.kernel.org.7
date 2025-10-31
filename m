Return-Path: <linux-kernel+bounces-880608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756DEC26394
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A09467C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC24E2836AF;
	Fri, 31 Oct 2025 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YF4uSIPm"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9DC280CFC
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928083; cv=none; b=oT6ih/ZW8fkflNnKJB5mlUHD6uJ4id4Mb2ugEZqWWhvamZeN06EsuOJ0Qt2ffkaIqwqFddNfHJUF7iXlc2SaLu1nQc35C37kjUnOXbU1h9xIwpq50r4wcwBiNlwZ84Br652oS1H5/zzsAq4k+aphEY2HMFBbsf7zrlqt+xUIvRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928083; c=relaxed/simple;
	bh=kDssZKzypBLff+1ZVIfB58ENRKA3B3YlfDeq0xu5XOQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sv0yF8nLV7ZgTU6IEMqr96+d74LMl2EkOj9bLaXRU5Sf6F93d4J9AYqPjuQYMsktkEq7vPla6yeVRrhn9f7eLknkq8bHnvHmGubi626RZnTsXvu0qVzsVAio0KCn6rCa2Lll0FVSgTP496/N8qszp0tx9uUD7FtISm/YPxHLWv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YF4uSIPm; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso2279894f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761928079; x=1762532879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDssZKzypBLff+1ZVIfB58ENRKA3B3YlfDeq0xu5XOQ=;
        b=YF4uSIPmORgEQuR6NjPLFaZARAJ4qoW7zQLa6q9emUZ9Vo3PoXVD2S5AjYuvWrBRxn
         w0N70No6hi9ZSHAzNVhQpk+yjXkaAsYaRVfqTdiEXxV5Hs1HjttqkAoI5FS+I4jKeY6i
         wYxdBNlQZmSE59DIUPMjS5vJpmBsJZk8RWVUtewZ/ZLv9y80vwFSomxyXZQNvAFl2qe0
         JGNndhthQkt+pQRaA9ZMDIiOzNhwKXM3mzQaTm91pHpE+d09XFRPUmIQealJ+a6FPWRF
         LWMXaC4IDI95BcpRFX09Z9Vbu4wsGJwBikG/7PUN/UHat3pOrAchinnX6sGxNoGPbWzV
         CN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761928079; x=1762532879;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kDssZKzypBLff+1ZVIfB58ENRKA3B3YlfDeq0xu5XOQ=;
        b=cDpdb1uWbstEhxRuGHt4CzPMkDBVDqinWRLas2Kr5f9Pm9zeT0uMN5GnnMs3hn6kK8
         XR6qHD9Q9j7tB1gCvRRxknhuhJwZPLkeVXcMW5GqoaMaALF8HjA9fCAzc8VVf5jXipDY
         VO/NYZDh33S6uN6Htr9sisA+SDUhsLKI/5aSQQXhjVdhEop6Z8a72yT3bg8rK6M0mPIM
         Vp7UrykzxJ4Bo4NCQcDY/pa4krpwrP7Afjd0g0sBAMBdVm+jqIZ2DH5GoegZw0OCEhTm
         sS6xnaDxqANegwEPaNKJHnnDXze1pIdKxN6wQXvJbaomnOIj6qfu3CCc3qC5dRXoF78h
         8j9A==
X-Forwarded-Encrypted: i=1; AJvYcCVpgskibrefzs+1OhZs0Bm1moYW1rhU9jG5dy8c1vII6zH6QFXexT5RmtHwQmpOA0f+AOUPjAShw7SvK/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOmq/to+dM2Y79HQa4RLYBbQYjZKustnB+6FnH1OqigMz9gqhy
	wL10er6xadPnsKEWD3W7z+AOCS5yx9SS8BrIRYUdV9dwvh5z7PM3nTFnPdUknVBbqMA=
X-Gm-Gg: ASbGncu/PI7Al2ly22WTH2SkY+0FcJJOLHVViQRJzkygvjPUlr3VABDhMf50qOYDlqq
	8fRErfICA1bLnLcmP9oNnjHPrEYThuSthfz6PYxkGkmpQnxhca9IOvLYQR9aF8Lf11gPs0Hf+Ql
	NV7M2mqELoG4JUT6CrVTs5ERm40tWf4OcGewFKFDBAlKBaTJlee/+CwM2mhRJu4B2AWuN2EiX1x
	KZOTbAkBwWYHCNFdrRa19F7skQd6poZeVoLvn4U0PtMcgQF+vvBXFmv6AYKfX6c5avhksdoCfiP
	wQcF7ydS7vky8PUTL7H2ymHnFWDQn0KjhELCsrDAM07a0I8beTCrn2OYAGaFjgBor64+rooTN7Y
	82nVoKyjjbxIQTQkLbyJYfuzOrXZbaZxuysbRLdR1ILOgFHiS0AvcGgvFLpQbn4evEWGRd8dd7s
	5+d9GCxz19TQ==
X-Google-Smtp-Source: AGHT+IFrsbEnwLrCCUR6Iu0VY5Uzhd0sq8qEcvcS/A9/eiqg3la7OAXHkma7L0rV7CnkzwdcPd10ig==
X-Received: by 2002:a05:6000:178f:b0:429:bb21:94e1 with SMTP id ffacd0b85a97d-429bd6a0caemr3886114f8f.41.1761928079286;
        Fri, 31 Oct 2025 09:27:59 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:b8e9:e124:10fc:8444])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429c112413esm4367494f8f.12.2025.10.31.09.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 09:27:58 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>,  Neil
 Armstrong <neil.armstrong@linaro.org>,  Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,  Kevin Hilman
 <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  linux-amlogic@lists.infradead.org,
  linux-clk@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] clk: amlogic: optimize the PLL driver
In-Reply-To: <9751014d-926e-4d42-b8e1-5a4d3e734457@amlogic.com> (Chuan Liu's
	message of "Fri, 31 Oct 2025 23:09:13 +0800")
References: <20251031-optimize_pll_driver-v3-0-92f3b2f36a83@amlogic.com>
	<1jms57xx05.fsf@starbuckisacylon.baylibre.com>
	<9751014d-926e-4d42-b8e1-5a4d3e734457@amlogic.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Fri, 31 Oct 2025 17:27:58 +0100
Message-ID: <1j5xbvxchd.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri 31 Oct 2025 at 23:09, Chuan Liu <chuan.liu@amlogic.com> wrote:

> Hi Jerome,
>
> On 10/31/2025 5:04 PM, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>> On Fri 31 Oct 2025 at 16:10, Chuan Liu via B4 Relay
>> <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>>=20
>>> This patch series consists of four topics involving the amlogic PLL
>>> driver:
>>> - Fix out-of-range PLL frequency setting.
>>> - Improve the issue of PLL lock failures.
>>> - Add handling for PLL lock failure.
>>> - Optimize PLL enable timing.
>>>
>>> For easier review and management, these are submitted as a single
>>> patch series.
>>>
>>> The PLL timing optimization changes were merged into our internal
>>> repository quite some time ago and have been verified on a large
>>> number of SoCs:
>>> - Already supported upstream: G12A, G12B, SM1, S4, A1, C3.
>>> - Planned for upstream support: T7, A5, A4, S7, S7D, S6, etc.
>>>
>>> Based on the upstream code base, I have performed functional testing
>>> on G12A, A1, A5, A4, T7, S7, S7D, and S6, all of which passed.
>>>
>>> Additionally, stress testing using scripts was conducted on A5 and
>>> A1, with over 40,000 and 50,000 iterations respectively, and no
>>> abnormalities were observed. Below is a portion of the stress test
>>> log (CLOCK_ALLOW_WRITE_DEBUGFS has been manually enabled):
>> Okay, this little game has been going on long enough.
>> You've posted v2 24h hours ago
>> You've got feedback within hours
>> There was still a 1 question pending
>> The rest of community had no chance to review.
>>=20
>
> There might be a serious misunderstanding here.
>
> In recent years, we've mainly been maintaining our code in our
> internal repository, which has led to some differences between our
> internal codebase and the upstream version. The patches that account
> for these differences are already queued for submission, and several
> SoCs are also waiting in line to be submitted. As a result, quite a
> few patches have piled up, waiting to go upstream.
>
> Previously, I had been waiting for your clock driver restructuring
> patches to be ready (which have recently been merged), so for almost
> a year, we haven't made much progress on clock driver=E2=80=93related
> upstreaming.

Ohoh now you are just teasing me !

That work was made necessary because of all the copy/paste Amlogic was
submitting. Despite many requests, this was never addressed so I had
to step in.

If you want things to go faster, then *really* pay attention to the review
you are getting, do not ask question to ignore the answers and stop
making people repeat themselves over and over.


