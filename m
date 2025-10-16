Return-Path: <linux-kernel+bounces-857001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC485BE59D9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374681A66305
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB722E8DF5;
	Thu, 16 Oct 2025 21:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="reobcTYy"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8492E8B73
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651607; cv=none; b=nlLF8fYkocGNx2tZcJXXUnREozswJWRmsSvgraBfBbcrB+R7yXr9VL1RqxkdYwnzDPVEXTFp+znRpOGMENldNPRwPqpFFeIeaufoIwQ8v8AACNqBfRTPStlMalxWWdz//i0EFyjVv7HEQQDC8JFyWbzcN+hwPOG/lCqKIGgR5b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651607; c=relaxed/simple;
	bh=1YgxJ/4RLuaRvWUjGGZ2dNvhLcQPJpPPz0ZEw45IfPo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=fHmtxhNTwkFfo5O4xvaAkdOy6sx2I43BnLKPwkzC+K4VTXnTASQEBzsFg2mecyfcngwrQQtRammcMYSuNCGt+RBGtX6I5M3C16rKbcyX0I4JkXS6/mHTTdTP6Z/3PBtjWCWhA4TinD5ElbGYpGfNFyyLDgDBu44MGKJgGEdILWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=reobcTYy; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e42fa08e4so10666535e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1760651604; x=1761256404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1YgxJ/4RLuaRvWUjGGZ2dNvhLcQPJpPPz0ZEw45IfPo=;
        b=reobcTYyKL3Y6aW0NtLf5O8YLHnXt64nhzbLgnGi+V8H7Xy3GNHrs4IxVpmI3uGtCA
         IaX3Y0fijKoWxC0gj0hAAOrElOIYzEKSyF58Y/MDHmSa2XEtwfxrCOa5Y/do6GE7wyKJ
         QkuA0bDTqvEWtN5jrY024bvMDFYcOKrfUe3JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760651604; x=1761256404;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YgxJ/4RLuaRvWUjGGZ2dNvhLcQPJpPPz0ZEw45IfPo=;
        b=THNdG0ae+58QXFcr9JwZjXP04eyYKsyH9ed4e+KgP+8GjSpR4EwbLdbVwHQHkBrjgd
         QdH35pCf8UnAg34uJHeyHJlcpIfpViGuiKhJd97lfyXJgr6qsnKOMnEpPpCsbG7yPgwq
         RSE0Iaxs+wqCezJ90esV94tbr/YlTldzA3IQWMNW3COWbcilbPVY93KeiOiTmZbR8Ao4
         9lePeryqMi4KakQ9/4ejOMk3ByEZvcpnwNU6jNVSsrnNHfaQFMBoztYyJgMKQ2UOG0gj
         wWbpGgHgKhvDdTVzl7x6QNgfDwqCWp+UD4/E+wDHPH23GdX2U2PSL0eufF2aj12F3/85
         gORA==
X-Forwarded-Encrypted: i=1; AJvYcCV842Su64eWhPRJi/D4PDc9Kz4oVtWHsg5RfPp/KeMw9SlzJsMBUuL+h0Uu3xQLDLtw1vkEOHbzFUzbhXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJLgw5TE00r5Fh2QYpW6VOr6WNQmrW54kfsu8mvmeCGvAygspu
	XHVDl7Pk2svoV6L6nTqHnDDaZnTnGPv6+Wfg0vzHzULiL7z3f9fBeVQHk9GJ3KrFVZg=
X-Gm-Gg: ASbGncu6KL/cPp98Gjp8T9vh++hf7GGDx1VoyP5dQ/3bcecG873w5g4H5uSMCkCERdp
	2cU9cbP74HmqZrNvfdBnV/7ySsgrHwtVrf0p4OejagCsQI0oVhODxMMulJ8UWYAyTdvy0vkCdFw
	SjLtAeQs6sw/zu2R6vmrHH8ZyBNphihndio5zeLtHvsLWkxkty5q0q6SiHXnT0q4OCIo4OuXi21
	kP+5IC5aps05BnwLufdxvWNdttK1vSFM6Yg2p9XhDYwmTsb4ontM93Y0MJR0JsxzRa+2aqMYsia
	21+ITvgc8HgB2EuMUWDazfCskxnl07UNiXt+Mow2CLU8W04O8/D45f/sKA1T+haIJryPJGEJZYU
	B6FNMA7gPuiCGSH/t4J/Q2mLG/pE0eenf+lVk02ZVNu1RqCLGDNu4kn/dmX+ireVc/P09tyx0PW
	p9JIwgXHohzvzm9HaJXne0guqKeKwn0ylxxqq6ow==
X-Google-Smtp-Source: AGHT+IGm2dRPq6DFvbxIS/F9QGIIpJHwmg54eEmLAjbdoN+VtjYoGMRz90eb1nFzrki2I7b38Wz+nw==
X-Received: by 2002:a05:600c:8b66:b0:46e:428a:b4c7 with SMTP id 5b1f17b1804b1-471179120ccmr10476885e9.23.1760651604144;
        Thu, 16 Oct 2025 14:53:24 -0700 (PDT)
Received: from [192.168.1.183] (host-92-22-57-86.as13285.net. [92.22.57.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710f29da7fsm29002655e9.9.2025.10.16.14.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 14:53:23 -0700 (PDT)
Message-ID: <e2924e3a-33a8-4fa7-8e08-bd0c3fc8e668@citrix.com>
Date: Thu, 16 Oct 2025 22:53:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: peterz@infradead.org
Cc: David.Kaplan@amd.com, boris.ostrovsky@oracle.com, bp@alien8.de,
 dave.hansen@linux.intel.com, graf@amazon.com, hpa@zytor.com,
 jpoimboe@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
 pawan.kumar.gupta@linux.intel.com, tglx@linutronix.de, x86@kernel.org,
 Andrew Cooper <amc96@srcf.net>
References: <20251016185811.GH3289052@noisy.programming.kicks-ass.net>
Subject: Re: [RFC PATCH 40/56] x86/alternative: Use sync_core_nmi_safe()
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20251016185811.GH3289052@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>> Ok. Btw, how long has Intel supported SERIALIZE?
> I'm not sure.. its fairly new, so

Serialise was introduced in GLC/GMT, so AlderLake and Sapphire Rapids. 
It's not even 4 years old.

~Andrew

