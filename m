Return-Path: <linux-kernel+bounces-756294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B90FB1B264
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1974C3BF790
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB5B23F424;
	Tue,  5 Aug 2025 11:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1tGrM+X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F1DEEC0;
	Tue,  5 Aug 2025 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754391768; cv=none; b=fCGOhZSiCYTZq9SCBxwEcPerFJeqBv9uBR9lJKhUbH9OeRo3IC3GZtFYTcLkXlC+Wf/cM0RnLk8DiaZRRZVLjOL/tNvYBA5MUtRUulyi9ZN53QbfD8UOUwuAdlWSpJiusnO3Xc/gWliaZg7igN7STIlZFf55bvP6SE1izvUc3FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754391768; c=relaxed/simple;
	bh=EjslFoKz385OQJla0S/06AbB1iqynByZR1aRppAa/8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBZ1vPc/rBtwZFBqQ5DiR/sM5CANJfmSSe0RgZs1ejjdJq26iiSAQ97Rc8a7u8d0JT2X9rmCbucVsPGmjX7nQ3/EnqsPI6CFuHCc6SZfKbqnv3+1Wy6J7h3afUaOZDRPR8lowaopxS6jCuwB4zejuHKD4pkfB0HA4t19CB+X2I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1tGrM+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6AA0C4CEF0;
	Tue,  5 Aug 2025 11:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754391768;
	bh=EjslFoKz385OQJla0S/06AbB1iqynByZR1aRppAa/8A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X1tGrM+XFLR4eTM8K6dfmXu35VxLHQC6249VyB02gOlL62JDHVBD65KfOi4soVpjx
	 lqmad8HYSYjhXG1vMsnTJTcVTWBX2Jru1muZp2gECh3EuxMaQl6X8RyDbBw1LtPhPb
	 /GfYKX96wkzVaDdL4KpVUuG4JXXyoJd/gpu8SXP4Wn7HV504kYOSo19Ild9i86gIZL
	 dHCutkgSV00mE5r9ii3CfvXGF7JqaFDw4Uw8Rjvui0uLmenvcAO7Puq92GtX7Hy+VJ
	 f8upNqoFncGKSqGJ9eV2UNxpLzeE3kFBruE3BW/BNhGSs1aY6jtw6Mh25buHCXd/6o
	 jZ4EGsFM6RzCA==
Message-ID: <23e31686-3bc2-4524-9735-fd50c1f9746e@kernel.org>
Date: Tue, 5 Aug 2025 13:02:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] staging: rtl8723bs: get rid of os_dep/mlme_linux.c
To: Michael Straube <straube.linux@gmail.com>, gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com, Larry.Finger@lwfinger.net,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250801083131.82915-1-straube.linux@gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20250801083131.82915-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Michael,

On 1-Aug-25 10:31 AM, Michael Straube wrote:
> This series moves/merges the functions/functionality of os_dep/mlme_linux.c
> into the corresponding parts of the driver in the core directory to reduce
> "os dependent" code.
> 
> The patches have been compile-tested only due to lack of hardware.
> 
> v1 -> v2: added back accidently removed tabs in patch 3/8
> 
> Michael Straube (8):
>   staging: rtl8723bs: remove wrapper rtw_os_indicate_scan_done
>   staging: rtl8723bs: move init_mlme_ext_timer to core/rtw_mlme_ext.c
>   staging: rtl8723bs: move rtw_init_mlme_timer to core/rtw_mlme.c
>   staging: rtl8723bs: remove wrapper init_addba_retry_timer
>   staging: rtl8723bs: merge rtw_os_indicate_connect into
>     rtw_indicate_connect
>   staging: rtl8723bs: merge rtw_os_indicate_disconnect into
>     rtw_indicate_disconnect
>   staging: rtl8723bs: move rtw_report_sec_ie to core/rtw_mlme.c
>   staging: rtl8723bs: move rtw_reset_securitypriv to core/rtw_mlme.c

Thank you for your continued work on improving the rtl8723bs driver.

I've given these patches a test-spin on a tablet with
a rtl8723bs wifi module (on top of your previous patches).

The patches work and they look good to me:

Tested-by: Hans de Goede <hansg@kernel.org>
Reviewed-by: Hans de Goede <hansg@kernel.org>

for the series.

Regards,

Hans


