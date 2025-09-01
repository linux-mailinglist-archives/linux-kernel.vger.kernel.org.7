Return-Path: <linux-kernel+bounces-794363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0906B3E09B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E651A80B98
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9962580DE;
	Mon,  1 Sep 2025 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DsyzgiWT"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE61211290
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756723869; cv=none; b=tcM4A52kwrebgPGOgHNiW3pBK0ivGn5oxjlkWdZBhVjGELQsxLTrTYMK8s++OdgRm3PEakVPv9yx+grP5N+jUt/Ahg7KR/tqjFj8Zv2wFCNhW3TOtzICzER02a9otfFKwoNb22PUrc1ld0L3Ui6+QwL05fXU7cfM5FNWmlf9Vlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756723869; c=relaxed/simple;
	bh=c3AWq2+aRE6uJyjTcxkkvR1nFxFlag6Rj997piwPcZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkqgq3EVjheUdqFsnY0G3fcAuneYE0B3RnDMOA2Z5TFN8G57ZilXPjfCVgr96LOB6b1Xi1kIx/OKoHHCVUalTw3OpBxE2OQ39rPqnjy4mrQ2mrn25QHA1yMyl8umOF3JNNpRlUrwc6U246xJgTmlqasBqNQ7OuflrX61iEM6K18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DsyzgiWT; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3d3f46e231fso861945f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 03:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756723865; x=1757328665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wOpFznUBHcwhp4Aa+t8/Mwg69Xfy6GS/mz3K6gMcmbM=;
        b=DsyzgiWTJVhWnQfZJ0I4lx9sPGvOeZCSFKfbPT22j95VUHfnK846UkDka4TtsZ/yWw
         bI2SrELLQJE4dDMFBNSr3rK6C2KlqL7TWijqeGeCs9hGE18rcww75ndGvUUWdu2oiYOY
         SNRbfLTK3CXKnPu/UA/lGBN1pDG4DJbV2Y+ZbAC5KYQXvq+hL+Us5kpbcMFaR062DFeB
         +/uQJhWJlUykH6UKrrU8SGZvq/Y8iQNNISP72a5mC7R/kGSjsqbqC2kmLbGA4oCM4w0J
         +CN0MXXUPdmvV4/fO0tdJdJ7sfc/myqgNQ0biq643nZXmTkYfzJoJzwplo85ZG6MHccz
         k18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756723865; x=1757328665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOpFznUBHcwhp4Aa+t8/Mwg69Xfy6GS/mz3K6gMcmbM=;
        b=cp9j7bNq1T9Pdl5J/wr5pPnecR/zofhV8KF0bMRxs7xXM2fNgSTdbeYKS5IlJyvhtJ
         YtTuOS1oJ8RogEcKXs8aIGWt87XL8JdtJZYNnJbY+cqlRS4ABSghLay7KESTJPn6cWlf
         4HSYI+/GMnUcvjDSbzbVkZa6RumRIShZYBWmbcJkvkCbO/1bSHEPys0PYTvsbIaE5e/E
         C6BsQ3DATIkZPt+rDiC7no9nwF4KzFKwB3zZ3VzWXjA7vYX6jBPirw1JM1HrHwp7+KtO
         hNpg3NiYucdmrA46LMw0JyHXv8lINMc/9EIJy6wTWE+VW/7/RjWSoogTuKSutvl3oMBy
         kqYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVApLnihixkbFr8LfFISLR8DRGHToPe3vnyCiJt8PcPHkWB4ecV1m/anSBaFoBUk1IcQ4ZG4pqw5ULGB94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn2wI81ia9SBiObFBKrMN4iS1aG/6FDTskdBOB0Hp6aTdhWvNQ
	orx7UTGLTuY4q0QSWnR0mWFBTGRcBhk7uV36Vd8gda8D0kVt5pM3zZuGyDbeA0UyD/k=
X-Gm-Gg: ASbGncv1/EZ0Yh50EkccW9y+64vSGI10juruRHSwSUMs25V9FYgxLEbhXWrsysEv9Wl
	NgrCroOU/vQIk9pNU/doT4b4YyC7hTNlxPTKtThYN0f/5d/lxuG/cftz1ibc/jyUUdkmjbQHl1o
	K2llIyzHVsbUV4cvYWiaZFxdCk3v+m7q06I3lR2SgyfQWj4+ptTnAEYPjeqAE9/GkvX9Wfqatq0
	dza4NCLSYSFBsblpvKIRmQV16obrA5sXT1h0US73NzcrwFoTRRjGwwXVYzJXwhJ1Zf+UbGxsGST
	GR7I7WB9I5JNS1xrRTyl7enpI0HuK5hHJZ1VlK9OOjTyOglXtrGNrdDBM3uQR8+/WzHGiTd/OzV
	5kYmygBllg4BIxxzWic8fFVfnD1c=
X-Google-Smtp-Source: AGHT+IHHuD3FBRfv5Nxn4YsvqK/oKdbA0bdrkOdxRnh4/fqC0X90je6gaBStTovt5jXxCQ/QupdLWQ==
X-Received: by 2002:a05:6000:4022:b0:3d8:1f1b:9c9f with SMTP id ffacd0b85a97d-3d81f1b9fcemr1107840f8f.55.1756723864751;
        Mon, 01 Sep 2025 03:51:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b7e7ef7cfsm151725455e9.6.2025.09.01.03.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 03:51:04 -0700 (PDT)
Date: Mon, 1 Sep 2025 13:51:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: gregkh@linuxfoundation.org, aleksander.lobakin@intel.com,
	sergio.paracuellos@gmail.com, pabeni@redhat.com,
	abhishektamboli9@gmail.com, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: octeon: use fixed-width integer types
Message-ID: <aLV6lF2gutK24RtV@stanley.mountain>
References: <20250829200107.132443-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829200107.132443-1-osama.abdelkader@gmail.com>

On Fri, Aug 29, 2025 at 10:01:07PM +0200, Osama Abdelkader wrote:
> The kernel coding style prefers fixed-width integer types defined in
> <linux/types.h> (u8, u16, u32, u64, etc.) over the C99 stdint.h types
> (e.g. uint64_t).
> 
> Replace uint64_t with u64, uint32_t with u32, uint16_t with u16
> uint8_t with u8 in octeon-stubs.h.
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  drivers/staging/octeon/octeon-stubs.h | 1745 +++++++++++++------------
>  1 file changed, 873 insertions(+), 872 deletions(-)
> 
> diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
> index 44cced319c11..ff6509b28cdd 100644
> --- a/drivers/staging/octeon/octeon-stubs.h
> +++ b/drivers/staging/octeon/octeon-stubs.h
> @@ -43,144 +43,144 @@
>  #define CVMX_POW_WQ_INT_PC		0
>  
>  union cvmx_pip_wqe_word2 {
> -	uint64_t u64;
> +	u64 u64;

This was already done upstream so the patch doesn't apply.

The point of the octeon-stubs.h file is it allows us to compile test
a bunch of code which is specific to Octeon.  The real code lives
in arch/mips/include/asm/octeon/cvmx-wqe.h.  These files have diverged
quite a bit, unfortunately.  But I guess everything still builds...
I don't know if it's really useful to cleanup this fake code while
leaving the real code as-is.


> @@ -1380,12 +1380,13 @@ static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interfac
>  	return r;
>  }
>  
> -static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
> +static inline void cvmx_pko_send_packet_prepare(u64 port, u64 queue,
>  						cvmx_pko_lock_t use_locking)
>  { }
>  
> -static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
> -		uint64_t queue, union cvmx_pko_command_word0 pko_command,
> +static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(u64 port,
> +							    u64 queue,
> +								union cvmx_pko_command_word0 cmd,
>  		union cvmx_buf_ptr packet, cvmx_pko_lock_t use_locking)

This is messed up now.  Just leave the indenting as it was and fix it in
another change if you want to.

regards,
dan carpenter


