Return-Path: <linux-kernel+bounces-767208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C9DB250BD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00BA2A23B7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF4C28C84C;
	Wed, 13 Aug 2025 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="ApKwlqYT"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA85281352
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104339; cv=none; b=fwwVm12XgZPf6EdoHM0ifg8UjAkOpuFGd+7Rfcdc5EnOY46mwkaNJzk27C/mBTKA38fXFp864nU+J1NTlXih2J+UKnd3gmLpawBq7+IMUUgQ9ZvrAbW8NVX0aukf1q7rZcU7GLc54VfgMd91I7XBvIXepefJFwuCgXtvxpA8bmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104339; c=relaxed/simple;
	bh=WltyD/Gu17z0VQIoy5UrL9din5O3T3+b4q0ZfweaWlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0cz90ZxscVaH+kaEajuRtqIKWz0bTxYSOKh06+C39s6wKbh31WLJKKZs0NkvdZrnFvV00HdB3mdYy6gzvTwqmZW7acxGvaH1IhS0TRSOQUNIoc7TQi0KnDgXJzoRNemID53gcCug2PNF18sq6ZoJZEI1apgAoJ6V9G5QwXUl38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=ApKwlqYT; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b1098f9e9eso1766191cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1755104337; x=1755709137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ixsrcuhdRVNDNuQRG1GynUI+Z0v3MMN1ZtGtSSllJ7g=;
        b=ApKwlqYTo62Nzv+8dil01LP7/QaXvneAjppO0ThGu17eQBVAWuz/mI0v8MrWzjvO2M
         YFlD81FQCgzVADvCHkI9Gp175K25HOi61Lr60zS3tFUnraEfLBle03B0vQCGImT8nN9H
         UT+zpVWWhbbtbh/BaFFaEVMTPfggmfyx+CQ4KElvcjZSM0TfcZ2G0JpqHKCzRpBr+2A+
         VSOGBaWsJQUp71h47zOCNnynJvfEO778mkNKUMw4+qNDJdzZGfNZhZVddd17u824vPtV
         w/Y5rUesDFsSRlIYicMoSU2BfoonJL1zn3ndEG0L4nOfvpWTVkKhMNETyqhfqnH6BYGg
         j09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755104337; x=1755709137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixsrcuhdRVNDNuQRG1GynUI+Z0v3MMN1ZtGtSSllJ7g=;
        b=XwItC9o+iZ3Kfi4BJL7aiCoyglyQBUFriTY/SuD4LINsNK+Vo5irbk4ZlmvKlftKA5
         rBmhvFTd3TGVFsZGJ+YtxQVc1WstuI0cCQarg+fajEgoP+VCWK5RLk/PEOw9xTE2poOd
         PO7bzeZa9XoKE4abjXLcjXvA4cUj+Q4y++ld5i2HwlByf/3QxCrqozRr3He4WTzwoTTQ
         pt8iR9svfTrlYgPkrelcjqWjTKtdL3pGGG/siGmwHtDmnJ1LFYgvsPN9jDSnbV0ZG2eo
         bFpR6xOz5WNeoPn8yf5fX1GIw1RbAs0kSK+hi19sbtkfWuH0IgskPUt0yMOU6S+P5Tj3
         3wSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+XTUDMCpVQwKNn9vFq0yLdIl7Le6/dgSLkzddZWarrvnrsM6FEIlGVeHyocFguINF4SD3GDuer9V4Tvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt8VeUpY2DquZkvcyB8vJqdKNdPqPh98Hwg/pbJJLE5XdNRBXV
	jAT3M9QY5NiuYKAKy1g8dTh8GfClpZljrANANgcRQf7atYJVwEVeI5nDbPy0MAKgWg==
X-Gm-Gg: ASbGncvtmBPSDyDRFhSAOHQWC1U0iFkGDxGwPqVTgFIqZdd0ByWdr6DBmTbsIxxiaqL
	TFT1D8wiMaXFHZRlgHQWqj7tUQxq5chg440Cp57yw83Q6nNwOC4NJfhvO+YmYQmf7uY8XDULoUs
	YOaRMqXTNd+gZehC0RBhRx3E7OswYRz3zrWbP2FMsrB8CaOhkHfgc8MGQ9uMCRU7mrKnlPrUuYR
	Jd6OmUQ+In+uJep/WG0zs3u5bEYMz+Xz9XfDpCHnnEWBcCn91E1WWwibkWzdmcfE4f6ZLVCFRwR
	+dpYK1mNB+G6mkgYI5HLWRt+NCkkH56ALC/phrl8SvwG0IQL2QgUdSzQfV41vY0JEleymD5P0Qf
	aCczcP9DaEdSELwnMW44b5HH0VAXlopvTdpNqcwBnNHyIKAB8J0f5759HHnzIEF9GTg==
X-Google-Smtp-Source: AGHT+IEX6taY4LlSwkNa+zM7dfmEU6izv8eUHX/5Yu4/4FOwk0gfPE982AWmeEaP1BJ/slfTY0ES4w==
X-Received: by 2002:ac8:590e:0:b0:4b0:89c2:68d9 with SMTP id d75a77b69052e-4b105f7a7b0mr16894621cf.36.1755104337064;
        Wed, 13 Aug 2025 09:58:57 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:349c:f507:d5eb:5d9e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b069ca56d6sm142258981cf.36.2025.08.13.09.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:58:56 -0700 (PDT)
Date: Wed, 13 Aug 2025 12:58:54 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Zenm Chen <zenmchen@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
	pkshih@realtek.com, rtl8821cerfe2@gmail.com, usbwifi2024@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: storage: Ignore driver CD mode for Realtek
 multi-mode Wi-Fi dongles
Message-ID: <ff043574-e479-4a56-86a4-feaa35877d1a@rowland.harvard.edu>
References: <20250813162415.2630-1-zenmchen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813162415.2630-1-zenmchen@gmail.com>

On Thu, Aug 14, 2025 at 12:24:15AM +0800, Zenm Chen wrote:
> Many Realtek USB Wi-Fi dongles released in recent years have two modes: 
> one is driver CD mode which has Windows driver onboard, another one is
> Wi-Fi mode. Add the US_FL_IGNORE_DEVICE quirk for these multi-mode devices.
> Otherwise, usb_modeswitch may fail to switch them to Wi-Fi mode.

There are several other entries like this already in the unusual_devs.h 
file.  But I wonder if we really still need them.  Shouldn't the 
usb_modeswitch program be smart enough by now to know how to handle 
these things?

In theory, someone might want to access the Windows driver on the 
emulated CD.  With this quirk, they wouldn't be able to.

Alan Stern

