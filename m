Return-Path: <linux-kernel+bounces-853338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27363BDB537
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C9034E86DF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E392306D49;
	Tue, 14 Oct 2025 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="bQzVuM4d"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE6A3009CA
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760475193; cv=none; b=iMhbgfvvTGuVvaHjTHSbcok/STsX3hJxtIMLN+dBukZ7RPiPXyXZv/Yx0xi4tL2xToFE4wDPR3Qck4PWn2ZcBGk8wPTNMTSe9LlB199XmZz1G9rgXvSP2tsHQjedwfXS/S9JSdLbh+8njFP3ZFkHJhhb/0iNqvuPgkUSWdGRMYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760475193; c=relaxed/simple;
	bh=MaULL3hJx6iYeigIBADiMv7AmNxmbq1AyBxOvhvMOKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AS2jOvkZY13CNgKq6wnUloKb1SQPpu6e4H/csTW3GqU70QsWkaVtB8i9HhleMZpVxBFYghWiV3iKuu8uvcWpG2Pp7hI/V/rEugELLEkpM0goHcPvB+tYiIQso2Y80JlfYu19ej2mIfhVKrPXuCi1g9kJVsUUjXJOHoy53y+6moU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=bQzVuM4d; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8608f72582eso405630685a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1760475191; x=1761079991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fl5sADz/8q9KzwLSAkG7lxcp1UM2F2pHojAxQcAaYMY=;
        b=bQzVuM4dA4jFsYfjNfddh0ictICS7XNfxRHt8/OMGR/agj4AIhbGfFELKmpaI5B+Ox
         NPW9wS59tb5dmGpWz6yS6YbYJ0daUtgVdK9xK83Pj3KdHBF+cNgInajzWat/UH7GoSKB
         t9wgI40japkFeoF/tgPr2SUyBMZP2uxNFkBGEUvwtzoriZ1GREIShN1SDibJgg/Jha8x
         GCngv3Gcb3LTUSKh4Ppesg/SuRtlv9Q8kUdV8dEZXq3cQ/x4YQbbAdGtgo65S+5KGIWV
         7Mgd5NPD4aWroQm0YnV0xEb+wKpf3T+CYZIUjNUtHLmYur93FdDZuADpT8ZftmQy13O9
         L5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760475191; x=1761079991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fl5sADz/8q9KzwLSAkG7lxcp1UM2F2pHojAxQcAaYMY=;
        b=V/CI+QGJMNQSnoQ3K97mBOJVR3zY+TfYRf3oBzFehYADX1dSorxN1uKfjv9TphtmTu
         NNg2LteDQmDxNQl9mfJ9ZkHRgidL8ngir2/lh2e0vBs/n4XdkJfGnjImzsyG8bFD2wMc
         qTdmdFEmjAU1SBt988PJRCCYUQSVOA0DCdq1gXfQo64E3QI7cc06MWit3yUVagVQSv/D
         8Oe/PHO5DbmtGsVOAh+Sc8E4atIKzIblbNIhxT37R05LHhQ0m4WwP45ha4Sk6GBORxgV
         X65dOzoxINazxup5IexBOMpxrMGpuZIxXSM9WGgbsscC7F9VnGSSvA02dFtiIou6erkx
         hxvw==
X-Forwarded-Encrypted: i=1; AJvYcCXvJ0/8eh8VPl/6G9+JSH7WmPtK7TwiE7tvBfJX4gldc7S+Ac54MtI7j3gs0S7Btg50vG8eueCMxZLRphk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA7QrKYO5rHaBsSUnLMmOF5OZKE0BwNPUoRQfgqoRZiGGv2oJn
	WoHr3YDOcAJXfddwJPNQbtAzbbp4WNniVijKHbcjH2vrI4xTIH1H3thRk16v/q0x9Q==
X-Gm-Gg: ASbGncvGJu9LLLiAX75LDCzabmAG9O0YZT9Y7DbBA7vzyiyYgm24JmOMXIDBFIsyANQ
	HUbwlTQcuTYA/i7ECNCBS2c+SxA4miswIcK4mwH6wjswNxmTd4ZebDA992cABzrVjn0MJdgbhPB
	MevJr+vm9ilPNj1BBymqwRQNGV3b/HoD5ec6xs2qGX40cY/Ew/UX4X6Yoxu103uFclaLisZnmPJ
	pGQ6o7PGigV0h20dd8Sv2dtU4W6OtWZK3CMTsrH3lOMhgTnGzxy/2WS7RfaYeZv2zQ8fWh2FlyM
	R1wvB4Kn+06g0FRHw/yWWVoEkQysLRhQWFVS6y/xV9T7FFkV2CXorzzUsYfwCHyW3XOPWJFC4bm
	bcrq4mkMw9kWFKYCzgGlpd42WuuMUhEYu6mhl9BfefGAcNKTf
X-Google-Smtp-Source: AGHT+IG2Qj7ViQUv/Wby3iwc/u8L47gyNsRnas1sZipgOqVoYu8K33lTGKKw/+idkqno3+TmHSUASQ==
X-Received: by 2002:a05:620a:40c8:b0:829:d46:78f5 with SMTP id af79cd13be357-883550968a1mr3564794385a.37.1760475185795;
        Tue, 14 Oct 2025 13:53:05 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::9c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a1ca4185sm1257331385a.31.2025.10.14.13.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 13:53:05 -0700 (PDT)
Date: Tue, 14 Oct 2025 16:53:01 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Kuen-Han Tsai <khtsai@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] usb: core: Improve device lifecycle debuggability
Message-ID: <8a7f7183-38f5-4fa0-8585-88a01648617f@rowland.harvard.edu>
References: <20251015-usbcore-tracing-v2-0-5a14b5b9d4e0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-usbcore-tracing-v2-0-5a14b5b9d4e0@google.com>

On Wed, Oct 15, 2025 at 03:50:50AM +0800, Kuen-Han Tsai wrote:
> This series enhances USB core debuggability. The first patch refactors
> device state updates into a new update_usb_device_state() helper 
> function, centralizing logic and preparing for tracing.
> 
> The second patch adds tracepoints for USB device allocation and state 
> changes, providing better visibility into the device lifecycle.
> 
> Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
> ---

For both patches:

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>


> Changes in v2:
> - hub.c: Changed the inline function to a standard one.
> - Makefile: Moved trace.o to the preceding line.
> - trace.h: Changed the speed and state into strings.
> - Link to v1: https://lore.kernel.org/r/20251013-usbcore-tracing-v1-0-b885a3121b09@google.com
> 
> ---
> Kuen-Han Tsai (2):
>       usb: core: Centralize device state update logic
>       usb: core: Add tracepoints for device allocation and state changes
> 
>  drivers/usb/core/Makefile |  5 +++-
>  drivers/usb/core/hub.c    | 30 +++++++++++++----------
>  drivers/usb/core/trace.c  |  6 +++++
>  drivers/usb/core/trace.h  | 61 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/core/usb.c    |  2 ++
>  5 files changed, 91 insertions(+), 13 deletions(-)
> ---
> base-commit: 5472d60c129f75282d94ae5ad072ee6dfb7c7246
> change-id: 20251012-usbcore-tracing-76f00c9b2b3e
> 
> Best regards,
> -- 
> Kuen-Han Tsai <khtsai@google.com>
> 

