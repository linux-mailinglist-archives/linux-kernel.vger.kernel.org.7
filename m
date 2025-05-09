Return-Path: <linux-kernel+bounces-642173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D74AB1B56
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 19:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2832F3BCBAE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 17:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32266235BEE;
	Fri,  9 May 2025 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sfH0HX79"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11B420C030
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810562; cv=none; b=c1bPSSRJsonHLeTw3LslfkVMmZPEcxuhlD+XIlBFX96ck7idhXbZCr6GrWsE1gZGx96zwe6EnZoEJs5Bli6bvMvE2yKDZUP1vbP9rIW2hSwq5BCWbDW30/qzUpKk4G9igy7JJJ5pUBRUeJokcuA2gGNW83Z/8GWxi8YP/4UoDps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810562; c=relaxed/simple;
	bh=8/DLjgtB1UXxqodmz6qRqj1WIAPFgvTzfIhYvppbtXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHQVX8ORv7m6tKXwOuoFOkOIeWztLcIclPVuaNtqtVP/DCnjUG6bogphbchhYXb3ON5u4Hn72Stz5i528Q/o4rOLl5XlhdvrXC8AMfVoXIHv/1UzR27cpKr8i8978gahJZZH1rEiBR09G1Evp6nxdSjEM0JR36y95CZIzhRVTPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sfH0HX79; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so2632970b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 May 2025 10:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746810560; x=1747415360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5bcmHv8UeY0lDIEviX2vMPO5A6Q4ByVsdqO83gELMfU=;
        b=sfH0HX79Q3h0HXcpQzhJMH+ynJxkBfZerxdP70bvfZQWl0a97wwtlyYlgUvJXTuOFw
         i7WXuD7xgvUPS3H5njET7a8CcPhnRzil7XfX3s5fl8Uh4AKfom+6a/fosy1u9OI4It2h
         fsCLve+kHskvVaNbBp3IojJHevtBr4oDLBaS10ruqiT5A0ZumrGR7cwmnDuFS73XLhHV
         nDTtl/AKAfsMVDAkRQWw2pAw+ETlkqU3m/tFCm30wip/BQ5jUpZda7hEYnvjYRZsOwRL
         mou/ati+dmt+tg1DF3JqEXk9FDJDmkuDTVtZyk3P9EjNJ/fw8soCwB1XMK79H4ZHFAE0
         d/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746810560; x=1747415360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bcmHv8UeY0lDIEviX2vMPO5A6Q4ByVsdqO83gELMfU=;
        b=MPowb9Pzr4EthqRhWZRNcXkEaUzE6MJzMZFYF4WslXF1ROnlljCzLdCxLdtRbAGsqu
         L1F1re7aqKWM4/dBVH4u2qwB54AXk9KhvsnXKD6Istselb6YABrPer4MJ/EUl+Kl8F6d
         JtiIo+iSr5psINeP/7b7dOLDw5luFkPSFdzxxN5ozpvtB7Mx2coOlYE/7EuwV8UMz7N/
         69qbNX2L5sv8d08FqJeeIxqKjfRXjyxtns3zX1Aa85qwF4FIGR8NHBC5OH6bAtYu6PCm
         Hzkgxx6r8z4whxmcgm64pR/AZ4w4yn0nXYFDIUmw6CWijMBtZ57T6ro67gUzllr7IJAz
         HhjA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ2bz6d/09AmAygyNyGOvdbc6G+tusNUrMHk6tbBRG0pe0sZFWnNOwol5kXpJ0UyIq8bQOuDCcf2Tg9tI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCTZpUhIYpLf1kms76/wHCi8TggYBJM+LGm7parUuSEG+laQff
	zSZ0DW5UvpToycqyGMbjHZaFxqgtIJYzlJw3otswUKXhdvl+2s2r/NpSYMMxPoQ=
X-Gm-Gg: ASbGncuBnYj6A9GPJfDwX6y1Jn7YILuE+IzNpFm7ZEOhBONmsQfkRCwqOLPSlgf5MT6
	VWMGWHxxHQ2rTc1qnjPSwbJrJ5Jl/MxJcKAG/J8I6xxSyZNTBktbr0nSPeKhu8/ShSTOxBBm+S6
	E83C7ugHHXfvFT/TFqsU3TOOF35ARzmIhzXE7XTgWOKsK7auIqz4psFHfymsxsm1c13qcm+rlcA
	/Qs6Y2pGtUyYXjVynM7IdDol9Dus9h6dhGzU6/46hxalHDXBYyx7YfE8+jbiKk+UDsH9o7Z0rIV
	wFGdGXn0sDY4n/PYa0RbFFt1Wfi95Mg5BRTgEqLZpEK1PINukVVe6w==
X-Google-Smtp-Source: AGHT+IFRPnmnGbQ/2b09nBcZ6dbCbJlG5OB6PdW2GL91c+5hjt+11hwNV0GCAIrYhizbS30bdhbuzA==
X-Received: by 2002:a05:6a21:32a3:b0:1fd:f8dc:7c0e with SMTP id adf61e73a8af0-215abb03b45mr6245910637.12.1746810559780;
        Fri, 09 May 2025 10:09:19 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:1542:d6f4:7fe8:a35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7423770414dsm1997749b3a.23.2025.05.09.10.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 10:09:19 -0700 (PDT)
Date: Fri, 9 May 2025 11:09:17 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: andersson@kernel.org, afd@ti.com, hnagalla@ti.com, u-kumar1@ti.com,
	jm@ti.com, jan.kiszka@siemens.com, christophe.jaillet@wanadoo.fr,
	jkangas@redhat.com, eballetbo@redhat.com,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 00/35] Refactor TI K3 R5, DSP and M4 Remoteproc
 Drivers
Message-ID: <aB42vd1dmPn0FaJI@p14s>
References: <20250425104135.830255-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425104135.830255-1-b-padhi@ti.com>

On Fri, Apr 25, 2025 at 04:11:00PM +0530, Beleswar Padhi wrote:
> This series refactors a lot of functions & callbacks from
> ti_k3_dsp_remoteproc.c, ti_k3_r5_remoteproc.c and ti_k3_m4_remoteproc.c
> drivers. This is a consolidated and final series as part of the
> refactoring of K3 remoteproc drivers. Below is the breakdown:
> 1. PATCHES #1-#3 fixes important bugs in R5 and DSP drivers before refactoring
> them into a common driver.
> 2. PATCHES #4-#10 does the pre-cleanup and aligns R5, DSP, M4 data structures.
> 3. PATCHES #11-#35 does the actual refactoring R5, DSP and M4 drivers into
> ti_k3_common.c driver.
> 
> NOTE:
> This series supersedes below series:
> https://lore.kernel.org/all/20250219091042.263819-1-b-padhi@ti.com/
> https://lore.kernel.org/all/20250417182001.3903905-1-b-padhi@ti.com/
> https://lore.kernel.org/all/20250108063727.1416324-1-b-padhi@ti.com/
> 
> Testing Done:
> 1. Tested boot of R5Fs, C66x DSPs, C71x DSPs across Jacinto J7* devices in
> remoteproc mode and IPC-Only mode.
> 2. Tested boot of M4F core _only_ in _AM62xx SK_ board in Remoteproc mode and
> IPC-Only mode.
> 3. Tested Core stop and detach operations from sysfs for R5Fs, C66x DSPs, C71x DSPs
> 4. Tested device removal paths by executing 'modprobe -r ti_k3_dsp_remoteproc'
> and 'modprobe -r ti_k3_r5_remoteproc'.
> 5. Tested usecases where firmware not available at device probe time, but
> later in sysfs, able to load firmware into a remotecore and start it. [R5Fs]
> 6. Tested that each patch in this series generates no new warnings/errors.
> 7. Tested IPC on AM64x EVM Device. [Thanks to Judith].
> 
> v11: Changelog:
> 1. New patches: [v11 15/35] and [v11 18/35].
> Broken down rproc_reset() and rproc_release() refactoring patches into more
> atomic changes.
> 2. Carried T/B on all patches from Judith.
> 3. Carried A/B on [PATCH v11 13/35] by Andrew.
> 
> Link to v10:
> https://lore.kernel.org/all/20250417182001.3903905-1-b-padhi@ti.com/
> 
> v10: Changelog:
> 1. Re-ordered Bug Fixes to the start of the series, before starting pre-cleanup
> and finally the actual refactor. [Andrew]
> 2. Broken down commits into more atomic changes for ease of review. [Andrew].
> 3. Updated commit messages to have uniform flow throughout the series.
> 4. Carried R/B tags in applicable patches.
> 5. Further patch specific changelog is attached with patches.
> 
> Link to v9:
> https://lore.kernel.org/all/20250317120622.1746415-1-b-padhi@ti.com/
> 
> v9: Changelog:
> 1. Added R5 cleanup & refactoring along with existing DSP, M4 refactoring into this series. [Andrew]
> 2. Dropped Mailbox level IPC checks across R5, DSP, M4 drivers in IPC-only mode. [Andrew] 
> 
> Link to v8:
> https://lore.kernel.org/all/20250103101231.1508151-1-b-padhi@ti.com/
> 
> v8: Changelog:
> 1. Broken down refactoring into patches, each patch dealing with one function
> for ease in review. [Andrew]
> 
> Links to older versions:
> v7: https://lore.kernel.org/all/20240202175538.1705-1-hnagalla@ti.com/
> v6: https://lore.kernel.org/all/20230913111644.29889-1-hnagalla@ti.com/
> v5: https://lore.kernel.org/all/20230808044529.25925-1-hnagalla@ti.com/
> v4: https://lore.kernel.org/all/20230801141117.2559-1-hnagalla@ti.com/
> v3: https://lore.kernel.org/all/20230302171450.1598576-1-martyn.welch@collabora.com/
> v2: https://lore.kernel.org/all/20230301111323.1532479-4-martyn.welch@collabora.com/
> v1: https://lore.kernel.org/all/20220110040650.18186-1-hnagalla@ti.com/
> 
> Thanks,
> Beleswar
> 
> Beleswar Padhi (33):
>   remoteproc: k3-r5: Refactor sequential core power up/down operations
>   remoteproc: k3-r5: Re-order internal memory initialization functions
>   remoteproc: k3-r5: Re-order k3_r5_release_tsp() function
>   remoteproc: k3-r5: Refactor Data Structures to Align with DSP and M4
>   remoteproc: k3-r5: Use k3_r5_rproc_mem_data structure for memory info
>   remoteproc: k3-{m4/dsp}: Add a void ptr member in rproc internal
>     struct
>   remoteproc: k3-m4: Add pointer to rproc struct within k3_m4_rproc
>   remoteproc: k3-m4: Use k3_rproc_mem_data structure for memory info
>   remoteproc: k3: Refactor shared data structures
>   remoteproc: k3: Refactor mailbox rx_callback functions into common
>     driver
>   remoteproc: k3: Refactor .kick rproc ops into common driver
>   remoteproc: k3-dsp: Correct Reset logic for devices without lresets
>   remoteproc: k3-m4: Introduce central function to put rproc into reset
>   remoteproc: k3: Refactor rproc_reset() implementation into common
>     driver
>   remoteproc: k3-dsp: Correct Reset deassert logic for devices w/o
>     lresets
>   remoteproc: k3-m4: Introduce central function to release rproc from
>     reset
>   remoteproc: k3: Refactor rproc_release() implementation into common
>     driver
>   remoteproc: k3-m4: Ping the mbox while acquiring the channel
>   remoteproc: k3: Refactor rproc_request_mbox() implementations into
>     common driver
>   remoteproc: k3-dsp: Don't override rproc ops in IPC-only mode
>   remoteproc: k3-dsp: Assert local reset during .prepare callback
>   remoteproc: k3: Refactor .prepare rproc ops into common driver
>   remoteproc: k3: Refactor .unprepare rproc ops into common driver
>   remoteproc: k3: Refactor .start rproc ops into common driver
>   remoteproc: k3: Refactor .stop rproc ops into common driver
>   remoteproc: k3: Refactor .attach rproc ops into common driver
>   remoteproc: k3: Refactor .detach rproc ops into common driver
>   remoteproc: k3: Refactor .get_loaded_rsc_table ops into common driver
>   remoteproc: k3: Refactor .da_to_va rproc ops into common driver
>   remoteproc: k3: Refactor of_get_memories() functions into common
>     driver
>   remoteproc: k3: Refactor mem_release() functions into common driver
>   remoteproc: k3: Refactor reserved_mem_init() functions into common
>     driver
>   remoteproc: k3: Refactor release_tsp() functions into common driver
> 
> Siddharth Vadapalli (2):
>   remoteproc: k3-r5: Drop check performed in
>     k3_r5_rproc_{mbox_callback/kick}
>   remoteproc: k3-dsp: Drop check performed in
>     k3_dsp_rproc_{mbox_callback/kick}
> 
>  drivers/remoteproc/Makefile               |    4 +-
>  drivers/remoteproc/ti_k3_common.c         |  547 +++++++++++
>  drivers/remoteproc/ti_k3_common.h         |  113 +++
>  drivers/remoteproc/ti_k3_dsp_remoteproc.c |  616 +------------
>  drivers/remoteproc/ti_k3_m4_remoteproc.c  |  583 +-----------
>  drivers/remoteproc/ti_k3_r5_remoteproc.c  | 1012 +++++++--------------

I am done reviewing this set.  The work done herein is a textbook example on how
refactoring should be done and I commend you for it.

Mathieu

>  6 files changed, 1072 insertions(+), 1803 deletions(-)
>  create mode 100644 drivers/remoteproc/ti_k3_common.c
>  create mode 100644 drivers/remoteproc/ti_k3_common.h
> 
> -- 
> 2.34.1
> 

