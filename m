Return-Path: <linux-kernel+bounces-835609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89067BA7953
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 01:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47FC6172AD0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 23:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539CF261B86;
	Sun, 28 Sep 2025 23:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4AkhYR9"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFB0248166
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759102164; cv=none; b=P+4kxAk6+0WzNuQfe41nu/NWj7/JVxXK9UE2qggHjZkFI9COudjK0RA/4W+RRkSU4cbjN/CUW2zwSWrBHDhpJU0IUczZQXq9fRH7zuPhirdWO7H7bXmrNe0SVDk0KIH/l8ZMaoCvm8AM5zRPcHCaPG1EusVp4Jk7NutTYynqVN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759102164; c=relaxed/simple;
	bh=V/jzRpqEcOhYwBw3Dnxdh4YkMwhb3CbO4cM8jjUKGXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kbw1dChUh/1rshLXrDmpppnP4WxwWSWw9nJZzmOpUTAi6+4UVZ9DaUPt4Fapw43/NI2bp5B76S3F9dtlDRv5aNjaVDXV1+BZc0+GiibJDXaDUWoABdL7cQAbDSC+URMCb4k+rESHgaUgbKinrwOJwZ+wfHiq5hmQHI148vdZfs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4AkhYR9; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-73f20120601so40574747b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 16:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759102162; x=1759706962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iVT14YXhZO/vL323RFIMRVmhhyNgiqUs7sCBFMwP2Vc=;
        b=O4AkhYR9CT5jY/vm94Lqqq1W72e+5ENmIgOwLjtPBbT8tvt2l90VKut3ehoVs/l+E9
         D8fRyhNrUIWbqf3yBCTNWyzJZFIu0xkXS5/DioT7nLqmvv8lo5tbeYJjEjVPt5VUlFYv
         KR6mllloIcJ7fG2oUrLu0t/Rvl+6FmT889RXfPjENSZirkkyThFZkQfzjc95ReOIaOiX
         Arht39dnJDtE9CjEiLBlW45xmxaBHrBfHmmIMYk9NVa8uthi6KpvtH4MshkEmOC7Od0v
         Y3zw6ZUZwqN7GtzZkCHrIh8sXvtgleVDPSEPRVogRW6m6hjdmNF4Xm4JB5W31zI6sUkv
         ORsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759102162; x=1759706962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVT14YXhZO/vL323RFIMRVmhhyNgiqUs7sCBFMwP2Vc=;
        b=FGj3PYN7/OMnkkh2JawHhYiJcV2IGCYywaHYflhExfBQoAt+UVSZtiam2nMEzo6yKQ
         sG0/RHbeI6A1/KNwLrBLdZDlIFLU1zSBcZXMIG5BiTizXk9MV84wRhNw7Hyx5u+Flirg
         ZiitLkEJ5K+CGUAUYUIXCtswQTytw0FK48pvtJIn9mI028h5337o4/WGppL3anVHMUNX
         xy5dhd2a0FD1u5p1XAHYbk6x4KoD5w1Jef/as0B58VdDgmpLCa96z2+J4i06quLAT4aN
         qhUrX8zyeIbCY5oqnhBsSGe8oD27477Kxt+1tTY2XW0KKOImGgahEqFEnxRXVi3zRsFe
         XjjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDcCtIsuDh/Gqluq1AJTwPHcUBV6cqRN/8FT5I42UPpT1uS3vY3Ee/imJJb1JY9lOuz9mvkg3SMD2m93g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ5WgMXUjNrF027z8wEwkN2/p0Drx3rIuksiPCq3aeigcy6nda
	6fEQqV3yIv1yM3s7632B4nm1VZ4oTpjJbiV8kkSNZPlCSiangLrYdaHH
X-Gm-Gg: ASbGnctlwEpUGdQSQawXHy39r7oPoO+hASUYsaJTZs0y6OBsl+w6MX3giQTdi7O4UPL
	ZZyP3z5qVvDsMIA45G5Gqgtx69ztKOEFhfy6surXYR3mc2vqspAzk8Ewf2ATCrj9KX2TqmiRU8J
	2mwkkqaeRk1E2bwPG4j3wQeD7WhjBT9c0YCSFP7m0TSSsNYLOlcHOnhqlBdhHX2eIzh3H2r9bM5
	67nizUWD6/g9BQjl6PIAlokgV6s6T60LWf82DDZbHKCZ3rjQ3qEZT/eMRqMptf+3/brwe2EMswa
	Pkj0dUsoC5dQz5tVDoOn+K7irEEILXI+92MSksDJ8O6eBdLBePVcsPoZV8YsTKjpOIYSLOc3tY+
	7RYq6T9upckXZw/X6JxjJsMLfb7yupGflE5pacT8p
X-Google-Smtp-Source: AGHT+IHskYhayDwfzsV8lkE/Uops7xgSMHfw6Sw7Fk1JVYa5Q3Ma+PAZWIZOs7Aj8ggB//5BDs9q8w==
X-Received: by 2002:a05:690c:6f85:b0:727:1d96:46aa with SMTP id 00721157ae682-76405202175mr180066857b3.53.1759102162293;
        Sun, 28 Sep 2025 16:29:22 -0700 (PDT)
Received: from [192.168.201.155] ([76.200.76.117])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-636d5b1d960sm2016142d50.31.2025.09.28.16.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 16:29:21 -0700 (PDT)
Message-ID: <bb9d90ca-aa4d-4168-bdc5-543109c74493@gmail.com>
Date: Sun, 28 Sep 2025 19:29:15 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: udlfb: make CONFIG_FB_DEVICE optional
To: kernel test robot <lkp@intel.com>, Sukrut Heroorkar <hsukrut3@gmail.com>,
 Helge Deller <deller@gmx.de>, Bernie Thompson <bernie@plugable.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Arnd Bergmann <arnd@arndb.de>,
 Randy Dunlap <rdunlap@infradead.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Zsolt Kajtar <soci@c64.rulez.org>,
 Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 skhan@linuxfoundation.org
References: <20250924175743.6790-1-hsukrut3@gmail.com>
 <202509272320.3K8kdDCw-lkp@intel.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <202509272320.3K8kdDCw-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/27/25 12:12, kernel test robot wrote:
> Hi Sukrut,
> 
> kernel test robot noticed the following build errors:
> 

Did you compile and test this code before submitting this patch?



