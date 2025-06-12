Return-Path: <linux-kernel+bounces-683941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE07AD73F2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 16:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29919188B3BD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 14:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED8123505F;
	Thu, 12 Jun 2025 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G2njMlsj"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DC419007D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738522; cv=none; b=tvUDdjms3XJWwW72GiF6b6TeWtc7sWy+Bcn52lhP+2P4vwaWEAx3vc/alUG4TVyYeYr2YaPs6S47HYcByXmKE0N2P9NDJ7Ii9SFEXE4d218fRPV57W+3ksNO1t9g8KIAC+lsXRnowXEk2QoB1rpINPqSAGdWqHgcl83hIlOXe04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738522; c=relaxed/simple;
	bh=EJUn+HxEphkXa3Tmo0WpUA6X64DPGMauzWeB2gIGvQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3RrZb+MN/CbAoh7F6JlUfm0rPu154n4frzTPXfCaG1QW2Pc+HFTuGbQkaNJMe5FagcQDP8FsiQt6CaWfG6OTIBETvX/kV4SVtESDY8izQk4UVDcwGO4ZA/cB33xjVjNEorzIJI2MgTA1lJUBAR5bjkphJvasp6nB03u1oEaH2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G2njMlsj; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a525eee2e3so888886f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 07:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749738518; x=1750343318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y7rIsWA2briWQ8Yb8DhTmywFqeEer3lbSfSQBbj2pps=;
        b=G2njMlsj+SEOIHr/5PYGj2oKnSU4DzwqxrpaaZCFD7xIhwRbgdQr/qY9Ek324Y+L0i
         8AbK8b48Hdus62jPwS9AiMSS9XN0C2YfzeOj6BMssc2vNfKorIz4m614vOuMhrncGIoY
         CwVGNO5eeQnqNHgv/m4mhgM9DfBVHjkIAMGn0rgr9aCZnRde/gqt2TUJeR3a9XcfGuW8
         7KKz+KktGOo1ozruMtgURfxTlTVgu1A5DGBbKDExbMw3qt9gaXaVjFWj0X4N8cmsiFOv
         Qa8W9UZ6g9IBNUlluzFqA4uQtr5kzZAneTFA8KyIzPo5pnnShLPp6DhDSbdZ/Q4wuI9U
         iysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749738518; x=1750343318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7rIsWA2briWQ8Yb8DhTmywFqeEer3lbSfSQBbj2pps=;
        b=hxrCNE6YP5llhg3ZYkl8d7MpRH/eQ4N6LoFlGYa516X/9hqsMxrkdUulflP03Fr7aJ
         VlXpX/6zot5Z+Efm9Zt3cJdamKZzt7DdNmzsBvcR5XRUkDOw9LrV5Y2Gw1t9YWeBCNRA
         dNxL45JjclmMujDq0IcOoEdbqTV2xNAVIYRqQ1IgEUOd/LcZNCstDD8/hMw5ddALMWz/
         f8nveVqV0Mwf0kqApbsqp8DrsdafYPsCLCmJcDzIpP/oF6qUl+sb4f+SUUQwNA19Krlt
         BsZXhqEbjEe+GSSS6BbNfSBf7YssPfFmXe73yopWxgvsrWWXmc634LXwfFGagR/v7a1m
         2sqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsCQI2smeA+H/Q4ae6//sYJspFv4pszkiRFWWyxcm0Px/A+sxteqJMmsoOUkGxECmLiDUI1Vnu0FUz3YA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFvTnzx97vhEtsAPZvOElOusej1nBn83QZSXpPo9lESMj6UIff
	la4Fz3jEJJrfyCQN8VLgzcrAvbnAytZRaxYHFrrEc7CVPDdK2jcOkDDOSYUU9YbX0rM=
X-Gm-Gg: ASbGncuVAwCmjQwPndro2nr0xKUqOzDXPJFSV7grJ2/4g9VlPZdNkFmYgdpn/uxcWJS
	Pv23O5iU34yq29zeJs8lpcewiEy28se7RIfAdPMkH45eRZ8bf1PVDlf/t5HmWByIrrUGgLEtFZu
	ni5quJbR0EGpflIOITOgwmnhknxYX/v5u9l025D2uuzzGiqpAoL+uCGKaHfuPttnTfpo8vYLeje
	DJyx+Mhy/f1XXn6JccM6YOharLKhFBzH8KJ3cLZBg4+FY1wtvDcKSdk848Cdt1CFZFO6YPwJ7J9
	OZtlgL6lXoFjt0VSt+HOD4rDc8qi54X3DtD7V24I5paWgAYAtN7OH9ctNXk2wksHWDs=
X-Google-Smtp-Source: AGHT+IGSIQRcM7fVzWirS8YoPF0tFI1UZjJkmBNxvk3+G8I7l0PWiFBYrTUOa1vhtpeoVhEQXQLGMA==
X-Received: by 2002:a05:6000:3106:b0:3a4:d975:7d6f with SMTP id ffacd0b85a97d-3a56076b241mr3276014f8f.39.1749738518473;
        Thu, 12 Jun 2025 07:28:38 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a561a3cdb4sm2152087f8f.54.2025.06.12.07.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 07:28:38 -0700 (PDT)
Message-ID: <5b21c4c9-0ef7-41e5-a3bb-5a48a0c73644@linaro.org>
Date: Thu, 12 Jun 2025 15:28:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] spi: spi-fsl-dspi: Use non-coherent memory for DMA
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Frank Li <Frank.li@nxp.com>,
 Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-2-2b831e714be2@linaro.org>
 <aEhMBsqlx9I4XqJS@lizhi-Precision-Tower-5810>
 <de7142ac-f1a3-412f-9f00-502222b20165@app.fastmail.com>
 <aEhVsrEk0qv+38r3@lizhi-Precision-Tower-5810>
 <20250611090107.t35zatn47vetnvse@skbuf>
 <c65c752a-5b60-4f30-8d51-9a903ddd55a6@linaro.org>
 <20250612111514.rfb3gpmlilznrfxs@skbuf>
 <ad7e9aa7-74a3-449d-8ed9-cb270fd5c718@linaro.org>
 <20250612142306.3c3dl46z326xvcud@skbuf>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250612142306.3c3dl46z326xvcud@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/06/2025 3:23 pm, Vladimir Oltean wrote:
> On Thu, Jun 12, 2025 at 03:14:32PM +0100, James Clark wrote:
>>> That's why I don't like the DMA mode in DSPI, it's still CPU-bound,
>>> because the DMA buffers are very small (you can only provide one TX FIFO
>>> worth of data per DMA transfer, rather than the whole buffer).
>>
>> Is that right? The FIFO size isn't used in any of the DMA codepaths, it
>> looks like the whole DMA buffer is filled before initiating the transfer.
>> And we increase the buffer to 4k in this patchset to fully use the existing
>> allocation.
> 
> Uhm, yeah, no?
> 
> dspi_dma_xfer():
> 
> 	while (dspi->len) {
> 		dspi->words_in_flight = dspi->len / dspi->oper_word_size;
> 		if (dspi->words_in_flight > dspi->devtype_data->fifo_size)
> 			dspi->words_in_flight = dspi->devtype_data->fifo_size;
> 		dspi_next_xfer_dma_submit();
> 	}

Right but that's before the change in this patchset to use the whole 
page that was allocated, hence the next bit:

 > And we increase the buffer to 4k in this patchset to fully use the
   existing allocation.

We were allocating for the size of the FIFO (multiplied by two to hold 
the control words), but dma_alloc_coherent() will be backed by a whole 
page anyway, even if you only ask for a few bytes.

After changing that to make use of the full allocation the FIFO length 
is no longer involved.


