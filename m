Return-Path: <linux-kernel+bounces-797563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13600B411EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C5B1B61555
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2219A1DE3A5;
	Wed,  3 Sep 2025 01:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="C6xHLWKE"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E9419D087
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 01:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756862925; cv=none; b=ncF97lSoKx3W54DSyNwsqQet4XOR/Ke5pav4XXDgkXG7sjEuaKx3RJ+jCOya3O0sJCp9wYeISMyIDtdc4rIba7oVWEj+JpKnZjKPR/+7RQ+3ruwqZqtZR2sfqz41/N5aBw1lxkPLTplNrGkZIRQTHvbeosBuFkk6YrweW0Kqt3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756862925; c=relaxed/simple;
	bh=jWktqMN2tTvElLfqJ9PQzb588RRjyLQJKS+SP+KgUPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+lCGlMlZjanQoEjyG6TeUvBZ/RzEsouhmf8YDn3NPGgz4P/2xhhgnrqBE+cb8jO4um1heLuB8HVRcCZ44H1TGD/K+R5khhzxUotxZ51PhObxzcvPrUHlM8sOM+MkCQ+ONsBiaN67c7LsXw+oNpsxIvi0nuaqmmvdK3ALPYduaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=C6xHLWKE; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3ea8b3a6426so54674885ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 18:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756862923; x=1757467723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7EibFznyAK36EWEv74X4db1iHSzaIlAEYhBCBRHhqnw=;
        b=C6xHLWKEDUFMEhB2vtNdoK2yuixQGCUToVDDzFnxRzBLfX61nzY8mKZtnm3Ro9zeRF
         2jtgfOU40eRXPBzBcoylrT1XhO3H3rHXEZJ1NwK2wqyMORFv7uGEL27UCaDhJU5cAfPr
         DZ7BeBX3bAzHKQCCtvXC4cWxd6KC3d+VYnugnF57FU+fVRaoMr9UwsLfgRSSIcvRwAtC
         u3bAMb7Sw7NYe7Mwy3AkRJXdifvHk00RcB21CQgLFn2xWbrqoniIedsH7HnaF032CkT8
         x7mPUF5u4ZQayErqzIyr56IPQ9B/HjzpRfWgV8ZP12NGPDR3y9SF6mSPf4yJlljWXsaB
         y6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756862923; x=1757467723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7EibFznyAK36EWEv74X4db1iHSzaIlAEYhBCBRHhqnw=;
        b=mDEXoP1lWwBnej6Gb/Fn8Ruaks3jDxW3uIBuOVU5PwgxO2k8NTLurzaeaSKcaUOmAe
         mqpltN78vYHAOhCGfzOBwKIKBRv+677vkIr4RNTK1GWlB19SPX/v0Tli6UTV/MB7zvl5
         rec2JtoawR+zdncA9JFkPEgNerj8oqlg1CIzagvDtUF+nYfaGOlJUQn0TtI0/seLrs9W
         jq9IIPnJeVYfe9zYi0cvvf7dICIW9rB3xzFZNmr0sa9vl1NnFufwCjnNeghXg0yJ3l3C
         HIQMIDwSBkmlNgbbAb/ZPVzBVqIk56fRzg4Jwo9Lv8xOT0mh8BexJkA6RV9EOnG3qS45
         4Q3w==
X-Gm-Message-State: AOJu0YyoxZKAkVghizKIj3rO/BuTN20GtDM5bXbSVrdtw2QLH5gbQq7v
	bMf/yPeXwRv4U6YMVvrrSdWBR7BZ01OuX4NR6yNgPxYZIT9ZpbpHpde+EJUh9wMJ+90=
X-Gm-Gg: ASbGncvBlJSnOPIgy4/P/gQNHN/MOD2b1T/WVlzc7gbWkGjiB4wq40/WD6U/RghoEEp
	ZFsuBYW/imeY00Yy3rkgwR0EcDrMswwUFaj30M+aMUSR1upv2aq/QMEl1VYEyWj9NFh4EKWNPPA
	J2TLeoBWGbFJj2LklN+UW7TuW+SsNLg/GWE6hzYflo96+PPK+U1jIXDtI0C2kXrq/l86hmSxRA0
	b8IA+wR7sPKkq5xLKXtGhPFOKhox1/ZhuTzrgB4XqyghOWOLX6PXAXg/CZirs4/djFXJCeRtuUo
	tLZzuANCfs7UL5qUf7oyyFanOybTd8Lfiwa7U6KY6B6giiwcO95hD0zAchZ6ZOuoIK5ioRvhEM5
	qDXQvMso1X4se7ymBjY9UQs8uwQdvk5EzfJeoetHKJOZ9Em8hrpraoWxq
X-Google-Smtp-Source: AGHT+IEpLqZE10ud7S91HvWmiCVH4yRvxb42ONzfjyyPF56r3l8jYnVMY+TKr1ak289QB7LZarY0aQ==
X-Received: by 2002:a05:6e02:216b:b0:3f1:7907:5fb9 with SMTP id e9e14a558f8ab-3f3ffda5d39mr268520025ab.6.1756862923251;
        Tue, 02 Sep 2025 18:28:43 -0700 (PDT)
Received: from [10.11.35.62] (syn-047-044-098-030.biz.spectrum.com. [47.44.98.30])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f3b1de7sm3593483173.77.2025.09.02.18.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 18:28:42 -0700 (PDT)
Message-ID: <97fbbd68-cdd1-49fa-82d3-e3714ca70eeb@kernel.dk>
Date: Tue, 2 Sep 2025 19:28:41 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] io_uring: avoid uring_lock for
 IORING_SETUP_SINGLE_ISSUER
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-kernel@vger.kernel.org
References: <20250902220803.1932692-1-csander@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250902220803.1932692-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/25 4:07 PM, Caleb Sander Mateos wrote:
> As far as I can tell, setting IORING_SETUP_SINGLE_ISSUER when creating
> an io_uring doesn't actually enable any additional optimizations (aside
> from being a requirement for IORING_SETUP_DEFER_TASKRUN).

Indeed. It was supposed to enable future optimizations, but they
didn't quite materialize.

> This series leverages IORING_SETUP_SINGLE_ISSUER's guarantee that only
> one task submits SQEs to skip taking the uring_lock mutex in the
> submission and task work paths.

Interesting, would indeed be great to kill the lock/unlock for each
submit and local work run. I'll take a closer look at this tomorrow.

-- 
Jens Axboe

