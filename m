Return-Path: <linux-kernel+bounces-811071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCE8B523E7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200161C84632
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B36311C15;
	Wed, 10 Sep 2025 21:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+lVxidn"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9E3310628
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 21:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757541377; cv=none; b=OsdrPDVe8JvZfhJTolKVDzSE7NSvMSjr8+DbzQxgHdKuLZTkL5yAHwA3jOkbq13878HaWo1aVtSFF6yOM/voNVE0F5MwfAH/YBVsHC8dWB7MqIBIekDCBX/t+AuqV3EmgXdtUPPnrutfFSCoGKRBRPOAwUKynCQ6uWBolleEjwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757541377; c=relaxed/simple;
	bh=1K0L7vy0m6oAWABtFjIMxHjGZLkeAdVFiL8lxzfzoUc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=B4NoZ0TyNiqvK/X4TtAHKgJL/yr9CrufJ/FpMTRu3CeIa54moSE4LxO+2rTMc4y+AUklb1QpwSKSR+atdSwTH0iK7EmnAz2nRdaKEBBs5V32kS8I1k3Hq+ePGmImUgtdcGXsCPZseFDid7b1gwhB86wTAZho8/0orga5fFU5sTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+lVxidn; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-625e1ef08eeso83112a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757541373; x=1758146173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9d1QV8DriomeYuygow3J7NXcF+FjsYxyafVX+X7WJo=;
        b=b+lVxidnV+8U0kRBo9XFjy4fq9sWGM/85Iru9AQR6vmi353pV/OUyC4YhQcxqhAEXz
         1k3RY9B9dwNUkio/BpjrLqBl8MpPirM/BEJd/6B64vf6Qp//pJ66hPdIjRxTB59FA8qe
         mIr62K2Rp+NVV6LRYvBt/MxzBxA5GfhRpv+urZuLKlJpnAiliZqbiVZ4tp8kerbaw3gx
         fJhKoSg1xjq1ergfMYvhdyamD7cSNTtKvZE/TryF/ZkWIAYYIHBayW4w7uMskUohi104
         CHmNCBlP7cie8QN8jNa4wlssLoJB/bWxXfQ3tsfftqnXCcdIRmMDeqaCQrUGtaBkG6yq
         KG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757541373; x=1758146173;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g9d1QV8DriomeYuygow3J7NXcF+FjsYxyafVX+X7WJo=;
        b=AoQbJHr7dXHUjGKFsxUl36C90T0o2+R+gMlVCnn8WDK6Ruq4ffLIUHY3C3wQd1Voh8
         unWbx5crQtDrghraC2gT+PbUkcEgwRudwXB11pBZowHx6qCoteyc4pi1eymY/mk5tRDT
         t4Q4URDghYmGkJ0Je2hAZOT1Yc/eG9z0VG/qv56OcFcvlICjwRAEtZsTCbwlajssW+lx
         +2W1A5gdhVR1RZiXOnpl4lVg7TjRk3Wp2pQrnyFsDnnPeYWqr8H5e/ELIwTc1R/kaq5O
         7ieUgJrKlLlW1PbzSZxRmWW/gc6xe5dLwz2dzwDUOSJyu0cBIUDYUYYYntiXXyirNcLJ
         KjDA==
X-Forwarded-Encrypted: i=1; AJvYcCXUUUIy9+Qrv7I0N88/SyW7Zuz9I3lbL1v8rFKzh7IeGyj9E3h26z1SGdTdOwDELs0lasha8UNqLPQcLxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMOUCDyn2cEPuKToOH1/PuIv5VrVxtgf3KVp9ikqfCwrQHHQu9
	f1YzpeiVNS/+07zpshoxieq/Dj2uDtz+he1wnhcZ5wi5twGGCClw4B8Hmf6ngcfu9Uo=
X-Gm-Gg: ASbGncspp3pEzbIjeQuxentRV82wjTlW6tZLcHAzgvrxVGiBAUPJUrlxIXbu78pUNlr
	E3VwFcf3gYAaGI5mhMN98MJ///Kaaq1ItI5uAiIz9ct8SScztzqylAlammQCJa+Lu856vzjMJP4
	dYd0ZLvEk/xDtm71WM+6mskfBm4e/cm7QA8MTYCrXN8K1oNNwjyv+okN0bz1A9R5ALj+oHBap1x
	KlEAkCZMbQ5UbHqQ8m07yErqfGiZ+bYvKXZOpjC6kFKu8IHOW9jaWC+svadyuH/78tJVwhiLxVK
	1meL6DwYsa+N/ijuKlsHDjTeGbe7cH/jRDuRI7BRZPuyiSlGmJp3Wt2S6NSkk2XmNDgItgtGn3W
	Hv/JzukeNadtFl6xRUOFFk0JOVQSdfKfuD32Nz0X/KYVSlpgiUJXv7Nbx2tVjCTHdGKSkCwJan2
	/VDjK6B4s=
X-Google-Smtp-Source: AGHT+IGBsR+U1n4WFqO8g+vB4ERFu4ybrDNCTovC+1KY6W1/R7uSZEcXa89aKrlY6FwBWGiHJP9Ndw==
X-Received: by 2002:a05:6402:50d2:b0:629:c417:ee5c with SMTP id 4fb4d7f45d1cf-629c417f146mr10662130a12.32.1757541373118;
        Wed, 10 Sep 2025 14:56:13 -0700 (PDT)
Received: from [192.168.0.51] (217-62-96-139.cable.dynamic.v4.ziggo.nl. [217.62.96.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ebfe0ac03sm69476a12.16.2025.09.10.14.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 14:56:12 -0700 (PDT)
Message-ID: <1206e86e-488c-4c58-9e67-2313a678a5a0@gmail.com>
Date: Wed, 10 Sep 2025 23:56:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: richard@nod.at
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
 alexander.sverdlin@gmail.com, andreas@gaisler.com, ankur.a.arora@oracle.com,
 arnd@arndb.de, chester.a.unal@arinc9.com, christophe.leroy@csgroup.eu,
 dave@sr71.net, david@redhat.com, geert+renesas@glider.be, heiko@sntech.de,
 imx@lists.linux.dev, ira.weiny@intel.com, ksummit@lists.linux.dev,
 l.stach@pengutronix.de, linus.walleij@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, lorenzo.stoakes@oracle.com, nm@ti.com,
 rppt@kernel.org, sergio.paracuellos@gmail.com, surenb@google.com,
 vbabka@suse.cz, willy@infradead.org
References: <640041197.22387.1757536385810.JavaMail.zimbra@nod.at>
Subject: Re: [TECH TOPIC] Reaching consensus on CONFIG_HIGHMEM phaseout
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Herman?= <rene.herman@gmail.com>
In-Reply-To: <640041197.22387.1757536385810.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> In the past I saw that programs such as the Java Runtime (JRE) ran
> into address space limitations due to a 2G/2G split on embedded
> systems. Reverting to a 3G/1G split fixed the problems.
Believe you guys are talking specifically ARM so FWIW, but I remember 
for x86 that at least initially Wine and things such as VMware were 
affected by the more creative PAGE_OFFSET choices.

Both will have been as a matter of plain bugs and are supposedly long 
fixed (and I in fact believe I recall such fixing for VMware). Never had 
or as far as I recall heard of other issues back then.

Rene.

